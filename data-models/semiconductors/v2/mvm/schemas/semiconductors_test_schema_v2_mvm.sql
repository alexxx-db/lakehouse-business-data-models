-- Schema for Domain: test | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-07-10 14:04:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`test` COMMENT 'Wafer probing, die sort, final test, and reliability testing operations. Manages ATPG programs, ATE configurations, test coverage, bin mapping, test yield, parametric test data, and correlation studies between wafer-level and package-level test. Distinct from quality domain which focuses on QMS and compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`program` (
    `program_id` BIGINT COMMENT 'System-generated unique identifier for each test program record.',
    `ate_configuration_id` BIGINT COMMENT 'Foreign key linking to test.ate_configuration. Business justification: Test programs are executed on specific ATE configurations; many programs can share one configuration, so add FK from test_program to ate_configuration.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Required for R&D Program Test Alignment Report linking each test program to its originating research program for budget and compliance tracking.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test Program Management requires linking each test program to the IC catalog entry it validates for release tracking.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Test programs must be qualified against the PDK used in design to ensure test coverage of process-specific parameters. Enables test program reuse validation across process nodes and foundry-specific t',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Test programs are developed and certified against specific process recipe versions. When a recipe changes, test programs require re-qualification. Process-test correlation reports and re-qualification',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-level test qualification: test programs are qualified per specific SKU (speed grade, voltage variant, temperature range) for AEC-Q100 and production release. Enables traceability from test program',
    `actual_coverage_percent` DECIMAL(18,2) COMMENT 'Measured fault‑coverage achieved after program execution.',
    `approval_date` DATE COMMENT 'Date on which the program was approved.',
    `ate_platform` STRING COMMENT 'Automatic Test Equipment platform compatible with the program.. Valid values are `ATE_9000|ATE_9500|ATE_10000|Custom`',
    `atpg_tool` STRING COMMENT 'ATPG software used to generate the test vectors (e.g., Synopsys TestMAX, Mentor Tessent).',
    `bin_mapping_reference` STRING COMMENT 'Identifier of the bin‑mapping table associated with this program.',
    `program_category` STRING COMMENT 'High‑level classification of the test program purpose.. Valid values are `functional|structural|parametric|mixed`',
    `change_description` STRING COMMENT 'Detailed narrative of modifications to test flows, limits, or parameters.',
    `program_code` STRING COMMENT 'Business‑assigned code that uniquely identifies the test program across systems.',
    `correlation_study_reference` STRING COMMENT 'Identifier of the wafer‑to‑package correlation study associated with the program.',
    `coverage_target_percent` DECIMAL(18,2) COMMENT 'Desired fault‑coverage percentage the program aims to achieve.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `deprecation_date` DATE COMMENT 'Date on which the program version was marked as deprecated.',
    `impact_assessment` STRING COMMENT 'Narrative assessment of the programs impact on yield, cost, and schedule.',
    `is_deprecated` BOOLEAN COMMENT 'Flag indicating whether the program version is deprecated.',
    `owner` STRING COMMENT 'Name of the engineer or team responsible for the program.',
    `parametric_test_data_reference` STRING COMMENT 'Link to the parametric test data set used for limit verification.',
    `release_date` DATE COMMENT 'Calendar date when the program version was officially released for production use.',
    `target_device` STRING COMMENT 'Specific device part number or SKU the program validates.',
    `target_device_family` STRING COMMENT 'Family or series of devices the program is intended for (e.g., FinFET‑45nm, GAA‑7nm).',
    `test_coverage_metric` STRING COMMENT 'Metric used to express coverage (e.g., fault, code, timing).. Valid values are `fault_coverage|code_coverage|timing_coverage`',
    `test_environment` STRING COMMENT 'Physical environment where the program is executed.. Valid values are `lab|production|prototype`',
    `test_flow_description` STRING COMMENT 'Detailed description of the test flow sequence executed by the program.',
    `test_flow_version` STRING COMMENT 'Version identifier of the underlying test flow definition.',
    `test_limit_units` STRING COMMENT 'Units for numeric test limits (e.g., mV, mA, ns).',
    `test_limit_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary test limit associated with the program.',
    `test_program_name` STRING COMMENT 'Human‑readable name of the test program.',
    `test_program_status` STRING COMMENT 'Overall lifecycle state of the test program.. Valid values are `active|inactive|deprecated|retired`',
    `test_type` STRING COMMENT 'Category of testing performed by the program (e.g., wafer probe, die sort, final test, burn‑in, system level test).. Valid values are `wafer_probe|die_sort|final_test|burn_in|slit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the program record.',
    `validation_status` STRING COMMENT 'Current validation state of the program version.. Valid values are `draft|validated|released|rejected`',
    `version_description` STRING COMMENT 'Free‑form description of changes introduced in this version.',
    `version_number` STRING COMMENT 'Semantic version identifier for the program (e.g., 1.0.3).',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record for ATPG-generated and manually authored test programs used on ATE platforms, with full version lifecycle management. Captures program name, target device family, test type (wafer probe, die sort, final test, burn-in, SLT), ATE platform compatibility, ATPG tool used, coverage targets, and program lifecycle status. Includes version-level tracking: version number, change description, changed test flows or limits, validation status, release date, approved-by engineer, associated PCN/ECO reference, and change impact assessment. SSOT for all test program definitions and their complete evolution history across test operations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` (
    `ate_configuration_id` BIGINT COMMENT 'Unique system-generated identifier for the ATE configuration record.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: ATE testers are physical fab tools tracked in the equipment domain. Linking ate_configuration to its physical tester (fab_tool) enables maintenance scheduling, OEE reporting, and calibration complianc',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: ATE configurations are qualified per product family (pin electronics, load board, instrument resources are family-specific). Replaces denormalized supported_device_families text column with a proper F',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: ATE configurations must be qualified for specific PDKs and process nodes to ensure measurement accuracy and parametric test validity. Enables equipment capability planning, test platform qualification',
    `bin_mapping_version` STRING COMMENT 'Version identifier for the binning map used in this configuration.',
    `calibration_due_date` DATE COMMENT 'Date by which the configuration must be re‑calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration state of the configuration.. Valid values are `calibrated|due|overdue`',
    `change_reason` STRING COMMENT 'Free‑text reason describing why the configuration was changed.',
    `compliance_ear_status` STRING COMMENT 'Indicates whether the configuration complies with Export Administration Regulations.. Valid values are `compliant|non_compliant|exempt`',
    `compliance_itar_status` STRING COMMENT 'Indicates whether the configuration complies with International Traffic in Arms Regulations.. Valid values are `compliant|non_compliant|exempt`',
    `configuration_code` STRING COMMENT 'Business identifier code used to reference the configuration in work orders and test plans.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the configuration is retired (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the configuration becomes valid for use.',
    `hardware_revision` STRING COMMENT 'Revision identifier for the ATE hardware bundle (e.g., Rev A, Rev B).',
    `instrument_resource_allocation` STRING COMMENT 'List of instrument resources (e.g., power supplies, signal generators) allocated to this configuration.',
    `last_calibration_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent calibration activity.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the configuration.. Valid values are `active|inactive|retired|decommissioned`',
    `load_board_qualification_status` STRING COMMENT 'Current qualification status of the load board for production use.. Valid values are `qualified|pending|rejected`',
    `load_board_revision` STRING COMMENT 'Revision identifier of the load board / Device Interface Board used.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance window description (e.g., weekly Saturday 02:00‑04:00).',
    `max_parallel_site_count` STRING COMMENT 'Maximum number of test sites that can be exercised simultaneously.',
    `ate_configuration_name` STRING COMMENT 'Human‑readable name identifying this ATE configuration.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the configuration.',
    `parametric_test_supported` BOOLEAN COMMENT 'Indicates whether parametric testing is enabled for this configuration.',
    `pin_electronics_card_map` STRING COMMENT 'Mapping description of pin‑to‑electronics card assignments for the configuration.',
    `platform_type` STRING COMMENT 'Type of test platform the configuration supports (wafer probe, final test, or reliability).. Valid values are `wafer_probe|final_test|reliability`',
    `test_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of functional test coverage provided by this configuration.',
    `test_yield_target_percentage` DECIMAL(18,2) COMMENT 'Target yield percentage that the configuration aims to achieve during test runs.',
    `tester_model` STRING COMMENT 'Model of the Automatic Test Equipment platform (e.g., Advantest V93000).. Valid values are `Advantest V93000|Teradyne UltraFlex|National Instruments PXI`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the configuration record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration record.',
    `version` STRING COMMENT 'Semantic version identifier for the configuration (e.g., 1.2.0).',
    `warranty_expiration_date` DATE COMMENT 'Date when the hardware warranty for this configuration expires.',
    `created_by` STRING COMMENT 'User identifier of the person who created the configuration record.',
    CONSTRAINT pk_ate_configuration PRIMARY KEY(`ate_configuration_id`)
) COMMENT 'Master configuration record for Automatic Test Equipment (ATE) platform setups used across wafer probe and final test operations. Captures tester model and platform type (e.g., Advantest V93000, Teradyne UltraFlex), hardware configuration revision, pin electronics card map, load board/DIB (Device Interface Board) revision and qualification status, instrument resource allocation, calibration status and due date, supported device families, maximum parallel site count, and configuration effective dates. SSOT for ATE setup definitions that test runs reference for full equipment traceability. Links to equipment domain for physical asset and maintenance tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`probe_card` (
    `probe_card_id` BIGINT COMMENT 'Unique identifier for the probe card.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Probe cards are qualified per technology node; linking ensures traceability of card usage to node specifications for yield and reliability analysis.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the prober equipment to which the probe card is currently assigned.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Probe cards are designed and qualified for specific product families (die layout, pitch, pin count are family-level attributes). This link supports probe card qualification tracking, maintenance sched',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Probe cards are designed for specific PDK pad layouts, pitch requirements, and metal stack configurations. This link enables probe card qualification tracking, reuse planning across designs, and capit',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Probe cards are procured from specialized suppliers (e.g., FormFactor, Technoprobe). Linking to supply.supplier enables supplier qualification tracking, warranty claims, quality scorecards, and ITAR/E',
    `card_name` STRING COMMENT 'Human‑readable name of the probe card used for identification in test engineering.',
    `compliance_status` STRING COMMENT 'Regulatory compliance classification applicable to the probe card.. Valid values are `itar|ear|rohs|none|restricted|export_control`',
    `contact_resistance_ohm` DECIMAL(18,2) COMMENT 'Measured electrical resistance of needle contacts in ohms.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Acquisition cost of the probe card in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the probe card record was first created in the system.',
    `probe_card_description` STRING COMMENT 'Free‑form text describing special features, notes, or remarks about the probe card.',
    `die_site_layout` STRING COMMENT 'Description of the die site arrangement on the wafer for this probe card.',
    `last_maintenance_date` DATE COMMENT 'Date when the probe card last underwent scheduled maintenance.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent test run that utilized the probe card.',
    `maintenance_cycle_months` STRING COMMENT 'Planned interval in months between preventive maintenance activities.',
    `manufacturer` STRING COMMENT 'Company that manufactured the probe card.',
    `needle_count` STRING COMMENT 'Total number of probing needles/pins on the card.',
    `needle_replacements` STRING COMMENT 'Cumulative number of needle replacement events performed on the card.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next preventive maintenance.',
    `notes` STRING COMMENT 'Any additional remarks or observations about the probe card.',
    `pitch_um` DECIMAL(18,2) COMMENT 'Center‑to‑center spacing of needles in micrometers.',
    `probe_card_status` STRING COMMENT 'Current lifecycle state of the probe card within test operations.. Valid values are `in_service|retired|maintenance|decommissioned|qualified|failed`',
    `probe_card_type` STRING COMMENT 'Design classification of the probe card (e.g., cantilever, vertical, MEMS, advanced).. Valid values are `cantilever|vertical|mems|advanced|custom|other`',
    `qualification_date` DATE COMMENT 'Date when the probe card was qualified for production use.',
    `qualification_status` STRING COMMENT 'Current status of the probe card qualification process.. Valid values are `qualified|pending|failed|rejected|under_review`',
    `safety_classification` STRING COMMENT 'Safety classification level for handling the probe card.. Valid values are `class_a|class_b|class_c|class_d|class_e|class_f`',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number that uniquely identifies the physical probe card.',
    `touchdown_count` STRING COMMENT 'Number of successful needle contacts recorded per test cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the probe card record.',
    `usage_hours` DECIMAL(18,2) COMMENT 'Total operational hours the probe card has been used in testing.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty for the probe card expires.',
    CONSTRAINT pk_probe_card PRIMARY KEY(`probe_card_id`)
) COMMENT 'Master record for probe cards used in wafer probing operations, owned by test engineering for qualification, assignment, and performance tracking. Captures probe card type (cantilever, vertical, MEMS, advanced), needle/pin count, pitch, technology node compatibility, die site layout, touchdown count, maintenance cycle, current condition status, and assigned prober tool. Tracks probe card lifecycle from incoming qualification through active use to retirement, including needle replacement history and contact resistance trending. Links to equipment domain for physical asset management while test domain owns operational qualification and assignment decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` (
    `bin_definition_id` BIGINT COMMENT 'Unique surrogate key for each bin definition record.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Bin definitions (pass/fail criteria) are process-node-specific — a bin for a 5nm flow differs from a 28nm flow. Linking bin_definition to process_flow enables process-node-specific bin governance, ens',
    `ic_catalog_id` BIGINT COMMENT 'add column ic_catalog_id (BIGINT) with FK to product.ic_catalog.ic_catalog_id - bin definitions are product-specific for sort/test classification',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Bin definitions belong to a test program; many bins per program, so add FK from bin_definition to test_program.',
    `bin_category` STRING COMMENT 'Classification of the bin outcome according to JEDEC taxonomy.. Valid values are `pass|functional_fail|parametric_fail|contact_fail|leakage_fail`',
    `bin_code` STRING COMMENT 'Alphanumeric code used in test programs to reference the bin.',
    `bin_definition_status` STRING COMMENT 'Current lifecycle status of the bin definition.. Valid values are `active|inactive|deprecated`',
    `bin_name` STRING COMMENT 'Human‑readable name describing the purpose of the bin.',
    `bin_number` BIGINT COMMENT 'Numeric identifier assigned to the test bin within a test program.',
    `bin_sort_order` STRING COMMENT 'Display order for bins in reports and UI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bin definition record was first created.',
    `bin_definition_description` STRING COMMENT 'Detailed free‑text description of the bin purpose and usage.',
    `device_family` STRING COMMENT 'Product family or platform to which the bin definition applies.',
    `disposition_rule` STRING COMMENT 'Action to be taken for devices falling into this bin.. Valid values are `ship|scrap|rework|hold`',
    `effective_from` DATE COMMENT 'Date when the bin definition becomes active.',
    `effective_until` DATE COMMENT 'Date when the bin definition is retired (null if indefinite).',
    `failure_mode` STRING COMMENT 'Root cause or failure mechanism associated with the bin.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this bin is the default for its category.',
    `parameter_set` STRING COMMENT 'Set of parametric test parameters associated with the bin.',
    `test_level` STRING COMMENT 'Stage of testing where the bin is applied.. Valid values are `wafer|final|reliability`',
    `updated_by` STRING COMMENT 'User identifier who last modified the bin definition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bin definition.',
    `yield_impact_classification` STRING COMMENT 'Indicates how the bin affects overall wafer or lot yield.. Valid values are `high|medium|low|none`',
    `created_by` STRING COMMENT 'User identifier who created the bin definition record.',
    CONSTRAINT pk_bin_definition PRIMARY KEY(`bin_definition_id`)
) COMMENT 'Reference master defining all test bin codes used in wafer sort and final test. Captures bin number, bin name, bin category (pass, functional fail, parametric fail, contact fail, leakage fail), disposition rule (ship, scrap, rework, hold), yield impact classification, and associated failure mode. Provides standardized bin taxonomy across all test programs and device families per JEDEC and internal standards.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` (
    `wafer_probe_run_id` BIGINT COMMENT 'Unique identifier for each wafer probing execution event.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Billing & Reporting: wafer probe runs are billed to the customer account that owns the wafer lot, required for financial and compliance reports.',
    `ate_configuration_id` BIGINT COMMENT 'FK to test.ate_configuration.ate_configuration_id — Each probe run executes on a specific ATE configuration. Required for traceability and equipment correlation analysis.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Wafer probe yield results are tracked per customer design win to monitor production ramp health and early yield performance. Semiconductor yield engineers and account managers use this link to report ',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Wafer probe runs directly produce the KGD die that populate a die_bank. die_bank.wafer_probe_yield_pct is a denormalization signal. Yield analysis, KGD inventory planning, and quality traceability req',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the wafer prober equipment used.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Wafer Probe Run records must be associated with the IC catalog entry to trace probe results to the specific product version.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Probe Yield Report requires linking each wafer probe run to the inventory wafer lot to update lot-level yield and inventory status.',
    `osat_work_order_id` BIGINT COMMENT 'Foreign key linking to supply.osat_work_order. Business justification: Wafer probe runs executed at OSAT facilities are authorized by an osat_work_order. Linking them enables OSAT yield reporting, work order closure, and cost-per-unit tracking — a fundamental operational',
    `probe_card_id` BIGINT COMMENT 'Identifier of the probe card installed on the prober for this run.',
    `wafer_id` BIGINT COMMENT 'Foreign key linking to fabrication.wafer. Business justification: Wafer probe runs are executed on individual wafers. Wafer-level traceability from fab through probe test is a core semiconductor operational requirement for die-level yield analysis, defect mapping co',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Wafer probe runs on qualification lots must be formally linked to the process qualification record. Qualification engineers aggregate probe yield data as acceptance evidence. This link enables the qua',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Probe runs are scheduled after a specific process step; the Probe Run Scheduling dashboard needs the step reference to track yield impact.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Wafer probe runs test silicon from specific tapeouts and mask sets. This link enables yield learning correlation to tapeout revisions, mask defect tracking, and design iteration effectiveness analysis',
    `ate_configuration` STRING COMMENT 'Configuration identifier for the Automatic Test Equipment used in the run.. Valid values are `CFG-w{3,}`',
    `bin_map_version` STRING COMMENT 'Version identifier of the binning map used to classify die test results.',
    `contact_yield_percent` DECIMAL(18,2) COMMENT 'Percentage of dies that made electrical contact during probing.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer probing run completed or was terminated.',
    `fail_die_count` STRING COMMENT 'Number of dies that failed one or more test criteria.',
    `gross_die_count` STRING COMMENT 'Total die count before any filtering (e.g., before known‑good die certification).',
    `parametric_test_data_available` BOOLEAN COMMENT 'Indicates whether parametric test measurements were captured for this run.',
    `pass_die_count` STRING COMMENT 'Number of dies that passed all test criteria.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this run record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this run record.',
    `remarks` STRING COMMENT 'Free‑form notes or comments entered by the operator or quality engineer.',
    `run_number` STRING COMMENT 'Business identifier assigned to the probe run, typically following the pattern RUN-######.. Valid values are `RUN-d{6}`',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer probing run started.',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Proportion of functional tests executed relative to the total test plan.',
    `total_die_count` STRING COMMENT 'Total number of dies present on the wafer.',
    `wafer_probe_run_status` STRING COMMENT 'Current lifecycle status of the probe run.. Valid values are `scheduled|running|completed|failed|canceled`',
    `wafer_sequence_number` STRING COMMENT 'Sequential number of the wafer within the lot.',
    CONSTRAINT pk_wafer_probe_run PRIMARY KEY(`wafer_probe_run_id`)
) COMMENT 'Transactional record capturing each wafer probing execution event. Records wafer lot ID, wafer sequence number, probe card used, ATE configuration, test program version, prober tool, start and end timestamps, total die count, pass die count, fail die count, contact yield, gross die count, and operator ID. Core operational event for wafer-level electrical test and die sort operations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` (
    `unit_test_result_id` BIGINT COMMENT 'Primary key for unit_test_result',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Unit test results at die level determine KGD classification and bin assignment for die stored in die_bank. Customer quality audits and KGD traceability reports require linking individual unit test res',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE) used.',
    `final_test_run_id` BIGINT COMMENT 'FK to test.final_test_run.final_test_run_id — Package-level test results must link back to the final test run event. Required for lot disposition and DPPM tracking.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Unit test results are the direct quality gate for finished good creation. Certificate of Conformance, AEC-Q traceability, and customer quality reports require linking each unit test result to the fini',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Unit test results must be traceable to the inventory wafer lot for quality tracking and stock accounting.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Unit test results must trace back to the lot process run that produced the unit for process-to-unit-test yield correlation and failure analysis. This is a fundamental traceability requirement for semi',
    `netlist_id` BIGINT COMMENT 'Foreign key linking to design.netlist. Business justification: Die test results are correlated to the netlist version used for synthesis; debugging reports require the netlist_id reference.',
    `bin_definition_id` BIGINT COMMENT 'FK to test.bin_definition.bin_definition_id — Every unit test result is assigned a bin code from the bin_definition master. This is the core yield classification link.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Unit test results are produced by a test program; add FK to capture the originating program.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Each unit test result assigns a unit to a specific SKU post-binning. This FK enables unit-level traceability to the orderable SKU, required for customer returns (RMA), field failure analysis, and lot ',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Die test results are tied to the manufacturing step that produced the die; required for the Step‑Level SPC analysis report.',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer containing the unit.',
    `wafer_probe_run_id` BIGINT COMMENT 'FK to test.wafer_probe_run.wafer_probe_run_id — Die-level test results from wafer probing must link back to the probe run event. Required for wafer map generation and lot traceability.',
    `assembly_position` STRING COMMENT 'Position identifier for multi-die or chiplet assemblies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result record was created in the system.',
    `device_serial_number` STRING COMMENT 'Serial number of the packaged device, if applicable.',
    `hard_bin_code` STRING COMMENT 'Hard bin classification assigned to the unit based on test outcome.',
    `kgd_status` STRING COMMENT 'Qualification status of the unit as a Known Good Die.. Valid values are `kgd|non_kgd|pending`',
    `measurement_summary` STRING COMMENT 'Concise summary of parametric measurement values for the unit.',
    `measurement_units` STRING COMMENT 'Units of the parametric measurements reported. [ENUM-REF-CANDIDATE: C|V|Ohm|nA|pF|%|dB — 7 candidates stripped; promote to reference product]',
    `parametric_flags` STRING COMMENT 'Flags indicating which parametric tests were executed or passed.',
    `pass_fail` STRING COMMENT 'Overall pass or fail result for the unit.. Valid values are `pass|fail`',
    `retest_count` STRING COMMENT 'Number of times the unit has been retested.',
    `retest_indicator` BOOLEAN COMMENT 'Indicates whether the unit was retested after an initial failure.',
    `soft_bin_code` STRING COMMENT 'Soft bin classification for detailed failure analysis.',
    `test_condition` STRING COMMENT 'Descriptive condition of the test environment.. Valid values are `room_temp|high_temp|low_temp|stress`',
    `test_result_comment` STRING COMMENT 'Free-text comments or notes associated with the test result.',
    `test_result_version` STRING COMMENT 'Version identifier of the test result format or schema.',
    `test_stage` STRING COMMENT 'Discriminator indicating the test insertion stage where the result was captured.. Valid values are `wafer_probe|die_sort|final_test|system_level_test`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the unit was tested, in degrees Celsius.',
    `test_time_seconds` DECIMAL(18,2) COMMENT 'Total duration of the test execution for the unit, in seconds.',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the test was performed.',
    `test_voltage_v` DECIMAL(18,2) COMMENT 'Voltage level applied during testing, in volts.',
    `test_yield_flag` BOOLEAN COMMENT 'Indicates if the unit is counted towards lot yield calculations.',
    `unit_identifier` STRING COMMENT 'Identifier of the tested unit, expressed as wafer X/Y coordinates for wafer-level or serial number for package-level.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test result record.',
    CONSTRAINT pk_unit_test_result PRIMARY KEY(`unit_test_result_id`)
) COMMENT 'Transactional record capturing individual unit-level test results from all test insertions including wafer probing, die sort, final test, and system-level test (SLT). Records unit identifier (X/Y die coordinates for wafer-level or device serial/unit position for package-level), test insertion stage discriminator, assigned hard-bin and soft-bin codes per bin_definition, pass/fail status, total test time, parametric measurement summary flags, retest indicator and retest count, KGD (Known Good Die) qualification status, multi-die/chiplet assembly position, and test temperature/voltage condition. Serves as the single source of truth for all unit-level test outcomes across the entire test flow, enabling wafer map generation, unit-level yield analysis, full lot traceability, and die-to-package correlation. Aligns with STDF PTR/FTR/MPR record concepts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` (
    `final_test_run_id` BIGINT COMMENT 'Unique internal identifier for the package-level test execution event.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Delivery Acceptance: final test results are associated with the customer account to confirm product acceptance and trigger invoicing.',
    `ate_configuration_id` BIGINT COMMENT 'FK to test.ate_configuration.ate_configuration_id — Final test runs execute on specific ATE configurations. Required for equipment utilization and correlation analysis.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Final test runs produce yield and qualification data that must be reported against the originating customer design win for production ramp tracking and revenue realization. Semiconductor sales-ops and',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: In KGD flows, final test runs qualify die that are stored in die_bank inventory. Linking final_test_run to die_bank enables traceability of which test run produced KGD-qualified die, required for cust',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the specific ATE equipment unit used.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Final Test Run must reference the device architecture defined in research to ensure test data is tied to the correct architecture for yield analysis.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Final test runs produce the pass/fail disposition that gates finished good inventory creation and release. Quality engineers and inventory planners need this link for yield reporting, CoC generation, ',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Final test runs validate a completed process flow; the Final Test Yield Summary links each run to its originating flow.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Final test run outcomes are reported per IC product to support qualification, release, and compliance documentation.',
    `osat_work_order_id` BIGINT COMMENT 'Foreign key linking to supply.osat_work_order. Business justification: Final test runs are performed at OSAT facilities under a specific work order governing test scope, quantity, and cost. This link is required for OSAT work order closure, yield reporting against commit',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Final test runs are generated by a specific test program; add FK to capture this relationship.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Final test runs on qualification lots serve as acceptance evidence for process qualification sign-off. Qualification engineers reference final test yield and parametric data as gate criteria. This lin',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Final test runs produce units graded to specific SKUs. Linking final_test_run to sku enables yield-by-SKU reporting, production planning, and customer order fulfillment analysis — a standard operation',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Final test is executed on taped‑out silicon; the Final Test Yield report must reference the tapeout_id for traceability.',
    `ate_name` STRING COMMENT 'Name or model of the ATE system executing the test.',
    `bin_distribution` STRING COMMENT 'Compact representation of test bin counts (e.g., JSON or delimited string).',
    `boot_success_count` STRING COMMENT 'Number of devices that successfully booted during SLT.',
    `comments` STRING COMMENT 'Free‑form notes captured by the operator or system.',
    `defect_code` STRING COMMENT 'Standardized code describing the primary failure mode when the run fails.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the test execution completed.',
    `fail_count` STRING COMMENT 'Number of devices that failed one or more test criteria.',
    `final_test_run_status` STRING COMMENT 'Current lifecycle status of the test run.. Valid values are `pending|running|completed|failed`',
    `handler_name` STRING COMMENT 'Identifier of the handler module that loads devices into the ATE.',
    `parametric_test_fail` STRING COMMENT 'Count of parametric test points that failed.',
    `parametric_test_pass` STRING COMMENT 'Count of parametric test points that passed.',
    `pass_count` STRING COMMENT 'Number of devices that passed all test criteria.',
    `power_consumption_mw` DECIMAL(18,2) COMMENT 'Measured average power consumption during system‑level test, in milliwatts.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this test run record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this test run record.',
    `slt_board_code` STRING COMMENT 'Identifier of the board used for system‑level testing, if applicable.',
    `socket_code` STRING COMMENT 'Identifier of the socket used to hold the device during testing.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the test execution started.',
    `test_location` STRING COMMENT 'Code of the laboratory or floor where the test was performed.',
    `test_program_version` STRING COMMENT 'Version identifier of the ATE test program used for this run.',
    `test_result` STRING COMMENT 'Aggregated result of the test run.. Valid values are `pass|fail`',
    `test_run_code` STRING COMMENT 'Business identifier assigned to the test run, used for tracking across systems.',
    `test_shift` STRING COMMENT 'Work shift during which the test run was executed.. Valid values are `A|B|C|D`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the test was performed, expressed in degrees Celsius.',
    `test_time_seconds` DECIMAL(18,2) COMMENT 'Total duration of the test execution for the device.',
    `test_type` STRING COMMENT 'Discriminator indicating whether the run is a final test or system‑level test (SLT).. Valid values are `final_test|slt`',
    `total_sites` STRING COMMENT 'Number of parallel test sites active on the ATE for this run.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Yield of the test run expressed as a percentage of passed devices.',
    CONSTRAINT pk_final_test_run PRIMARY KEY(`final_test_run_id`)
) COMMENT 'Transactional record for package-level test execution events on ATE including final test and system-level test (SLT). Captures device lot ID, package type, test type discriminator (final_test, SLT), test configuration (socket, ATE, handler, SLT board), test program version, test temperature, test time, pass/fail counts, bin distribution, power consumption (SLT), boot success (SLT), and test site count. Covers all post-packaging test operations distinct from wafer-level probing.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` (
    `parametric_measurement_id` BIGINT COMMENT 'Unique surrogate key for each parametric measurement record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Quality Compliance: parametric measurements are reported back to the owning customer account for quality assurance and regulatory compliance.',
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Parametric measurements reference a bin definition; replace ad‑hoc bin fields with FK to bin_definition.',
    `calibration_record_id` BIGINT COMMENT 'Identifier of the calibration record applied to the equipment for this measurement.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE, probe card, etc.) that generated the measurement.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: The domain description explicitly states parametric measurements are captured during both wafer probe AND package-level test. When a parametric measurement is taken during final test (package-level), ',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Parametric measurements need the IC catalog reference to correlate measured values with product specifications.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Parametric measurements are associated with the inventory wafer lot for SPC and statistical analysis.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Parametric measurements must correlate to the specific lot process run to enable process-parametric correlation analysis (e.g., how deposition temperature variation affects threshold voltage Vt). This',
    `unit_test_result_id` BIGINT COMMENT 'Identifier linking to the overall test result set for the die.',
    `limit_id` BIGINT COMMENT 'FK to test.test_limit.test_limit_id — Each parametric measurement is evaluated against specification limits defined in test_limit. This link enables pass/fail determination and SPC analysis.',
    `parametric_unit_test_result_id` BIGINT COMMENT 'FK to test.die_test_result.die_test_result_id — Parametric measurements are captured for specific die/device test results. This is the detail-level link from measurement to the unit being tested.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Parametric measurements must be interpreted against PDK specifications, process corners, and design rules. This link enables statistical process control, design rule validation, and foundry process ca',
    `primary_limit_id` BIGINT COMMENT 'FK to test.test_limit.test_limit_id — Each parametric measurement is evaluated against a test limit specification. Required for pass/fail determination and SPC.',
    `wafer_id` BIGINT COMMENT 'Identifier of the individual die on which the measurement was performed.',
    `primary_parametric_unit_test_result_id` BIGINT COMMENT 'FK to test.unit_test_result.unit_test_result_id — Parametric measurements are captured per unit under test. Must link to the parent unit result for traceability.',
    `program_id` BIGINT COMMENT 'Identifier of the test program or ATPG pattern set used for the measurement.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Parametric measurements are captured after a defined process step; required for the Process Step Parameter Trending report.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Parametric measurements are taken on final silicon; regulatory and reliability reports link each measurement to the tapeout that produced the device.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Parametric measurements are captured during wafer probe execution events. The wafer_probe_run is the parent execution context for parametric measurements taken at wafer level. Adding wafer_probe_run_i',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement event was captured by the test system.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower acceptable bound for the parameter as defined by the product spec.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value recorded for the test parameter.',
    `measurement_average_value` DECIMAL(18,2) COMMENT 'Average of repeated measurements for the parameter.',
    `measurement_comment` STRING COMMENT 'Free‑form comment entered by the operator or analyst.',
    `measurement_condition_frequency_mhz` DECIMAL(18,2) COMMENT 'Frequency condition during the measurement, expressed in megahertz.',
    `measurement_condition_temperature_c` DECIMAL(18,2) COMMENT 'Temperature condition during the measurement, expressed in degrees Celsius.',
    `measurement_condition_voltage_mv` DECIMAL(18,2) COMMENT 'Voltage condition applied during the measurement, expressed in millivolts.',
    `measurement_flagged` BOOLEAN COMMENT 'Indicates if the measurement was flagged for outlier review.',
    `measurement_location` STRING COMMENT 'Physical location on the die where the measurement was taken.. Valid values are `center|edge`',
    `measurement_mode` STRING COMMENT 'Mode of the test, indicating whether the measurement is parametric or functional.. Valid values are `parametric|functional`',
    `measurement_quality_flag` BOOLEAN COMMENT 'Quality assessment of the measurement data.',
    `measurement_repeat_count` STRING COMMENT 'Number of times the parameter was measured in this test cycle.',
    `measurement_review_status` STRING COMMENT 'Current review status of the measurement.. Valid values are `pending|reviewed|closed`',
    `measurement_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement review was completed.',
    `measurement_sequence` STRING COMMENT 'Ordinal position of this measurement within the test program.',
    `measurement_source` STRING COMMENT 'Source of the measurement data, e.g., probe card or automatic test equipment.. Valid values are `probe_card|ATE`',
    `measurement_status` STRING COMMENT 'Lifecycle status of the measurement record.. Valid values are `recorded|validated|rejected`',
    `measurement_std_dev` DECIMAL(18,2) COMMENT 'Statistical standard deviation of repeated measurements.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact time the physical measurement occurred (may differ from ingestion time).',
    `measurement_tool_version` STRING COMMENT 'Software/firmware version of the test tool that generated the measurement.',
    `measurement_type` STRING COMMENT 'Indicates whether the measurement is analog or digital.. Valid values are `analog|digital`',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty of the measured value.',
    `pass_fail_status` STRING COMMENT 'Result of the measurement against spec limits.. Valid values are `pass|fail`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement record was first persisted in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the measurement record.',
    `test_parameter_name` STRING COMMENT 'Name of the specific parametric test parameter (e.g., Vth, Idsat).',
    `unit_of_measure` STRING COMMENT 'Engineering unit associated with the measured value. [ENUM-REF-CANDIDATE: V|mV|A|mA|Ohm|C|K|Hz — 8 candidates stripped; promote to reference product]',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper acceptable bound for the parameter as defined by the product spec.',
    CONSTRAINT pk_parametric_measurement PRIMARY KEY(`parametric_measurement_id`)
) COMMENT 'Transactional record storing individual parametric test measurements captured during wafer probe and final test. Records test parameter name, measured value, lower specification limit (LSL), upper specification limit (USL), pass/fail status, measurement unit, test condition (voltage, temperature, frequency), and associated die or device result. Enables SPC analysis, parametric yield optimization, and process-test correlation studies.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`limit` (
    `limit_id` BIGINT COMMENT 'System-generated unique identifier for the test limit record.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Test limits are process-node-specific — leakage current limits for a 5nm flow differ from a 28nm flow. Linking limit to process_flow enables process-node-specific limit governance, ensures correct lim',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test limits are defined per IC catalog entry to ensure each product revision meets its specification envelope.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Test limits are defined per process node; the Test Limit Specification requires the PDK identifier to ensure correct corner definitions.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: Parametric test limits are defined per fabrication process flow and technology node — leakage, threshold voltage, and speed limits differ by process node. This link enables process-flow-specific limit',
    `program_id` BIGINT COMMENT 'Identifier of the ATPG or ATE program that consumes this limit.',
    `approval_status` STRING COMMENT 'Current approval state of the limit record.. Valid values are `pending|approved|rejected|revoked`',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the limit.',
    `audit_trail` STRING COMMENT 'Chronological log of actions performed on the limit record.',
    `limit_category` STRING COMMENT 'High‑level category of the limit.. Valid values are `voltage|current|resistance|capacitance|frequency|temperature`',
    `change_reason` STRING COMMENT 'Narrative explanation for why the limit was changed.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the limit.. Valid values are `SEMI|JEDEC|IEC|ISO`',
    `created_by_department` STRING COMMENT 'Organizational department responsible for creating the limit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the limit record was first created.',
    `data_source` STRING COMMENT 'Origin of the measurement data used for the limit.. Valid values are `ATE|ATPG|simulation|lab`',
    `device_type` STRING COMMENT 'Classification of the semiconductor device (e.g., ASIC, SoC, FPGA) to which the limit applies.',
    `effective_date` DATE COMMENT 'Date on which the limit becomes active for production testing.',
    `expiration_date` DATE COMMENT 'Date after which the limit is no longer valid (null for open‑ended).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the limit is currently active in the test flow.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the limit.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable measured value for the parameter.',
    `measurement_type` STRING COMMENT 'Category of measurement the limit belongs to.. Valid values are `parametric|functional|timing`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the limit.',
    `parameter_name` STRING COMMENT 'Human‑readable name of the parametric test parameter (e.g., Vdd, Idd).',
    `product_revision` STRING COMMENT 'Internal revision identifier of the product (e.g., A1, B2) linked to the limit.',
    `regulatory_flag` BOOLEAN COMMENT 'True if the limit is mandated by a regulatory requirement.',
    `review_cycle` STRING COMMENT 'Scheduled frequency for limit review.. Valid values are `annual|semiannual|quarterly`',
    `risk_level` STRING COMMENT 'Risk classification associated with the limit deviation.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of samples used to calculate the limit.',
    `source` STRING COMMENT 'Origin of the limit definition.. Valid values are `design|customer|regulatory|internal`',
    `statistical_method` STRING COMMENT 'Statistical approach used to derive the limit.. Valid values are `mean|median|percentile|sigma`',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal target value that the process aims to achieve.',
    `test_condition_set` STRING COMMENT 'Named set of test conditions (temperature, voltage, frequency) under which the limit is valid.',
    `test_flow_name` STRING COMMENT 'Name of the test flow or sequence where the limit is applied.',
    `tolerance_percent` DECIMAL(18,2) COMMENT 'Allowed percentage deviation from the target value.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the limit values. [ENUM-REF-CANDIDATE: V|mV|A|mA|Ohm|kOhm|nF|pF|C|% — 10 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the limit record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable measured value for the parameter.',
    `version` STRING COMMENT 'Version identifier for the limit record, incremented on each change.',
    `version_history` STRING COMMENT 'JSON or delimited text capturing historical versions of the limit.',
    CONSTRAINT pk_limit PRIMARY KEY(`limit_id`)
) COMMENT 'Master record defining parametric test limits for each test parameter by device type, product revision, and test condition. Captures parameter name, LSL, USL, target value, measurement unit, test condition set, limit revision history, effective date, and approval status. SSOT for all test specification limits used across ATPG programs and ATE test flows. Supports limit change management and PCN-driven limit updates.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_probe_card_id` FOREIGN KEY (`probe_card_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`probe_card`(`probe_card_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_limit_id` FOREIGN KEY (`limit_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`limit`(`limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_parametric_unit_test_result_id` FOREIGN KEY (`parametric_unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_primary_limit_id` FOREIGN KEY (`primary_limit_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`limit`(`limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_primary_parametric_unit_test_result_id` FOREIGN KEY (`primary_parametric_unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`test` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`test` SET TAGS ('dbx_domain' = 'test');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `actual_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `ate_platform` SET TAGS ('dbx_business_glossary_term' = 'ATE Platform');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `ate_platform` SET TAGS ('dbx_value_regex' = 'ATE_9000|ATE_9500|ATE_10000|Custom');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `atpg_tool` SET TAGS ('dbx_business_glossary_term' = 'ATPG Tool');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `bin_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'functional|structural|parametric|mixed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Test Program Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `correlation_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `coverage_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Test Program Owner');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `parametric_test_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Data Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `target_device` SET TAGS ('dbx_business_glossary_term' = 'Target Device');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `target_device_family` SET TAGS ('dbx_business_glossary_term' = 'Target Device Family');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_coverage_metric` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Metric');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_coverage_metric` SET TAGS ('dbx_value_regex' = 'fault_coverage|code_coverage|timing_coverage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'lab|production|prototype');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Units');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_program_name` SET TAGS ('dbx_business_glossary_term' = 'Test Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_program_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'wafer_probe|die_sort|final_test|burn_in|slit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'draft|validated|released|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Version Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'ATE Configuration Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `bin_mapping_version` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|due|overdue');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `compliance_ear_status` SET TAGS ('dbx_business_glossary_term' = 'EAR Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `compliance_ear_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `compliance_itar_status` SET TAGS ('dbx_business_glossary_term' = 'ITAR Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `compliance_itar_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `hardware_revision` SET TAGS ('dbx_business_glossary_term' = 'Hardware Revision');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `instrument_resource_allocation` SET TAGS ('dbx_business_glossary_term' = 'Instrument Resource Allocation');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `last_calibration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|decommissioned');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `load_board_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Load Board Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `load_board_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `load_board_revision` SET TAGS ('dbx_business_glossary_term' = 'Load Board Revision');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `max_parallel_site_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Parallel Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `ate_configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `ate_configuration_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `parametric_test_supported` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Supported');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `pin_electronics_card_map` SET TAGS ('dbx_business_glossary_term' = 'Pin Electronics Card Map');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'wafer_probe|final_test|reliability');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `test_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `test_yield_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Test Yield Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `tester_model` SET TAGS ('dbx_business_glossary_term' = 'Tester Model');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `tester_model` SET TAGS ('dbx_value_regex' = 'Advantest V93000|Teradyne UltraFlex|National Instruments PXI');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Prober Tool Identifier (APTI)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `card_name` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Name (PCN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `card_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'itar|ear|rohs|none|restricted|export_control');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `contact_resistance_ohm` SET TAGS ('dbx_business_glossary_term' = 'Contact Resistance (Ohm) (CR)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `contact_resistance_ohm` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost (USD) (COST)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_description` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Description (PCD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `die_site_layout` SET TAGS ('dbx_business_glossary_term' = 'Die Site Layout Description (DSL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LMD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp (LUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `maintenance_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Months) (MC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name (MN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `needle_count` SET TAGS ('dbx_business_glossary_term' = 'Needle Count (NC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `needle_replacements` SET TAGS ('dbx_business_glossary_term' = 'Needle Replacement Count (NRC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date (NMDD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Needle Pitch (µm) (NP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_status` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Lifecycle Status (PCS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|decommissioned|qualified|failed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_type` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Type (PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_type` SET TAGS ('dbx_value_regex' = 'cantilever|vertical|mems|advanced|custom|other');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date (QD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|failed|rejected|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification (SC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c|class_d|class_e|class_f');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Serial Number (PCS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `touchdown_count` SET TAGS ('dbx_business_glossary_term' = 'Touchdown Count per Test (TC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `usage_hours` SET TAGS ('dbx_business_glossary_term' = 'Usage Hours (UH)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WED)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_category` SET TAGS ('dbx_business_glossary_term' = 'Bin Category (BIN_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_category` SET TAGS ('dbx_value_regex' = 'pass|functional_fail|parametric_fail|contact_fail|leakage_fail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Code (BIN_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Bin Status (BIN_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_name` SET TAGS ('dbx_business_glossary_term' = 'Bin Name (BIN_NM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bin Number (BIN_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_sort_order` SET TAGS ('dbx_business_glossary_term' = 'Bin Sort Order (BIN_ORDER)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Bin Description (BIN_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `device_family` SET TAGS ('dbx_business_glossary_term' = 'Device Family (DEV_FAM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `disposition_rule` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rule (DISP_RULE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `disposition_rule` SET TAGS ('dbx_value_regex' = 'ship|scrap|rework|hold');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode (FAIL_MODE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Bin (IS_DEF)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `parameter_set` SET TAGS ('dbx_business_glossary_term' = 'Parameter Set (PARAM_SET)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `test_level` SET TAGS ('dbx_business_glossary_term' = 'Test Level (TEST_LVL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `test_level` SET TAGS ('dbx_value_regex' = 'wafer|final|reliability');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UPD_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `yield_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Classification (YLD_IMPACT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `yield_impact_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CRE_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Prober Tool ID (PROBER_TOOL_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `osat_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Work Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card ID (PROBE_CARD_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Probed Wafer Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration` SET TAGS ('dbx_business_glossary_term' = 'ATE Configuration (ATE_CFG)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration` SET TAGS ('dbx_value_regex' = 'CFG-w{3,}');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `bin_map_version` SET TAGS ('dbx_business_glossary_term' = 'Bin Map Version (BIN_MAP_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `contact_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Contact Yield Percent (YIELD_CONTACT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `contact_yield_percent` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp (END_TIME)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `fail_die_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Die Count (FAIL_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `gross_die_count` SET TAGS ('dbx_business_glossary_term' = 'Gross Die Count (GROSS_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `parametric_test_data_available` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Data Available (PARAM_DATA)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `pass_die_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Die Count (PASS_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (REMARKS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number (RUN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `run_number` SET TAGS ('dbx_value_regex' = 'RUN-d{6}');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp (START_TIME)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percent (COVERAGE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count (TOTAL_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|failed|canceled');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Sequence Number (WAFER_SEQ_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Bin Definition Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `assembly_position` SET TAGS ('dbx_business_glossary_term' = 'Assembly Position');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `hard_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Hard Bin Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'kgd|non_kgd|pending');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `measurement_summary` SET TAGS ('dbx_business_glossary_term' = 'Measurement Summary');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `measurement_units` SET TAGS ('dbx_business_glossary_term' = 'Measurement Units');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `parametric_flags` SET TAGS ('dbx_business_glossary_term' = 'Parametric Flags');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `retest_count` SET TAGS ('dbx_business_glossary_term' = 'Retest Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `retest_indicator` SET TAGS ('dbx_business_glossary_term' = 'Retest Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `soft_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Soft Bin Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_condition` SET TAGS ('dbx_business_glossary_term' = 'Test Condition');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_condition` SET TAGS ('dbx_value_regex' = 'room_temp|high_temp|low_temp|stress');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_result_comment` SET TAGS ('dbx_business_glossary_term' = 'Test Result Comment');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_result_version` SET TAGS ('dbx_business_glossary_term' = 'Test Result Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_stage` SET TAGS ('dbx_business_glossary_term' = 'Test Stage (Wafer Probe, Die Sort, Final Test, System-Level Test)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_stage` SET TAGS ('dbx_value_regex' = 'wafer_probe|die_sort|final_test|system_level_test');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Time (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage (V)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_yield_flag` SET TAGS ('dbx_business_glossary_term' = 'Yield Contribution Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `unit_identifier` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (Die Coordinates or Serial Number)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `osat_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Work Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ate_name` SET TAGS ('dbx_business_glossary_term' = 'Automatic Test Equipment Name (ATEN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ate_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `bin_distribution` SET TAGS ('dbx_business_glossary_term' = 'Bin Distribution (BD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `boot_success_count` SET TAGS ('dbx_business_glossary_term' = 'Boot Success Count (BSC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Test Run Comments (TRC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code (DC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp (TET)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `fail_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Count (FC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_status` SET TAGS ('dbx_business_glossary_term' = 'Test Run Status (TRS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `handler_name` SET TAGS ('dbx_business_glossary_term' = 'Test Handler Name (THN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `handler_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `parametric_test_fail` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Fail Count (PTFC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `parametric_test_pass` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Pass Count (PTPC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `pass_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Count (PC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (mW) (PC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `slt_board_code` SET TAGS ('dbx_business_glossary_term' = 'System‑Level Test Board Identifier (SLTBI)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `socket_code` SET TAGS ('dbx_business_glossary_term' = 'Socket Identifier (SID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp (TST)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location Code (TLC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version (TPV)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Test Result (OTR)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_run_code` SET TAGS ('dbx_business_glossary_term' = 'Test Run Code (TRC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_shift` SET TAGS ('dbx_business_glossary_term' = 'Test Shift (TS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_shift` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C) (TT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Time (seconds) (TET)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'final_test|slt');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `total_sites` SET TAGS ('dbx_business_glossary_term' = 'Total Test Sites (TTS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parametric_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Parametric Measurement ID (PMID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Identifier (CAL_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier (EQP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier (RES_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Evaluated Against Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parametric_unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement For Unit Result');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `primary_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Parametric Against Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Die Identifier (DIE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `primary_parametric_unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier (TP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (ET)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value (MV)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_average_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Average Value (AVG)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_comment` SET TAGS ('dbx_business_glossary_term' = 'Measurement Comment (CMNT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency (F_MHZ)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Measurement Temperature (T_C)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_voltage_mv` SET TAGS ('dbx_business_glossary_term' = 'Measurement Voltage (V_MV)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_flagged` SET TAGS ('dbx_business_glossary_term' = 'Measurement Flagged (FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_location` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location (MLOC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_location` SET TAGS ('dbx_value_regex' = 'center|edge');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode (MODE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'parametric|functional');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Measurement Quality Flag (QFLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_repeat_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Repeat Count (RPT_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_review_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Review Status (REV_STAT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|closed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Review Timestamp (REV_TIME)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_sequence` SET TAGS ('dbx_business_glossary_term' = 'Measurement Sequence (SEQ)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source (SRC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'probe_card|ATE');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status (MSTAT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'recorded|validated|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_std_dev` SET TAGS ('dbx_business_glossary_term' = 'Measurement Standard Deviation (STDDEV)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp (MTIME)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool Version (VER)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type (MTYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'analog|digital');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty (UNC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status (PFS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `test_parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Name (TPN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `test_parameter_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `limit_category` SET TAGS ('dbx_business_glossary_term' = 'Limit Category');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `limit_category` SET TAGS ('dbx_value_regex' = 'voltage|current|resistance|capacitance|frequency|temperature');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'SEMI|JEDEC|IEC|ISO');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `created_by_department` SET TAGS ('dbx_business_glossary_term' = 'Created By Department');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'ATE|ATPG|simulation|lab');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'parametric|functional|timing');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `parameter_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `product_revision` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Limit Source');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'design|customer|regulatory|internal');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Method');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `statistical_method` SET TAGS ('dbx_value_regex' = 'mean|median|percentile|sigma');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `test_condition_set` SET TAGS ('dbx_business_glossary_term' = 'Test Condition Set');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `test_flow_name` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `test_flow_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Limit Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `version_history` SET TAGS ('dbx_business_glossary_term' = 'Version History');
