-- Schema for Domain: test | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:14:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`test` COMMENT 'Wafer probing, die sort, final test, and reliability testing operations. Manages ATPG programs, ATE configurations, test coverage, bin mapping, test yield, parametric test data, and correlation studies between wafer-level and package-level test. Distinct from quality domain which focuses on QMS and compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`program` (
    `program_id` BIGINT COMMENT 'System-generated unique identifier for each test program record.',
    `ate_configuration_id` BIGINT COMMENT 'Foreign key linking to test.ate_configuration. Business justification: Test programs are executed on specific ATE configurations; many programs can share one configuration, so add FK from test_program to ate_configuration.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Test programs are developed and qualified at the product family level and reused across all ICs in that family. Family-level test program management, reuse tracking, and NPI planning require this link',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test Program Management requires linking each test program to the IC catalog entry it validates for release tracking.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Test programs are qualified against specific process recipe versions. Recipe changes trigger test program re-validation. Test engineering change management and re-qualification workflows require knowi',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.design_revision. Business justification: Test programs must be re-qualified when design revisions change (ECO, re-spin). Traceability from test_program to design_revision supports test program change management, re-qualification workflows, a',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Required for Test Program Definition: each test program is created for a specific technology node to ensure correct test parameters and compliance reporting.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: A test program is validated and released against a specific equipment qualification. The tool qualification record documents that the ATE platform is qualified to execute this program for the target d',
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
    `program_name` STRING COMMENT 'Human‑readable name of the test program.',
    `owner` STRING COMMENT 'Name of the engineer or team responsible for the program.',
    `parametric_test_data_reference` STRING COMMENT 'Link to the parametric test data set used for limit verification.',
    `program_status` STRING COMMENT 'Overall lifecycle state of the test program.. Valid values are `active|inactive|deprecated|retired`',
    `release_date` DATE COMMENT 'Calendar date when the program version was officially released for production use.',
    `test_coverage_metric` STRING COMMENT 'Metric used to express coverage (e.g., fault, code, timing).. Valid values are `fault_coverage|code_coverage|timing_coverage`',
    `test_environment` STRING COMMENT 'Physical environment where the program is executed.. Valid values are `lab|production|prototype`',
    `test_flow_description` STRING COMMENT 'Detailed description of the test flow sequence executed by the program.',
    `test_flow_version` STRING COMMENT 'Version identifier of the underlying test flow definition.',
    `test_limit_units` STRING COMMENT 'Units for numeric test limits (e.g., mV, mA, ns).',
    `test_limit_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary test limit associated with the program.',
    `test_type` STRING COMMENT 'Category of testing performed by the program (e.g., wafer probe, die sort, final test, burn‑in, system level test).. Valid values are `wafer_probe|die_sort|final_test|burn_in|slit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the program record.',
    `validation_status` STRING COMMENT 'Current validation state of the program version.. Valid values are `draft|validated|released|rejected`',
    `version_description` STRING COMMENT 'Free‑form description of changes introduced in this version.',
    `version_number` STRING COMMENT 'Semantic version identifier for the program (e.g., 1.0.3).',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record for ATPG-generated and manually authored test programs used on ATE platforms, with full version lifecycle management. Captures program name, target device family, test type (wafer probe, die sort, final test, burn-in, SLT), ATE platform compatibility, ATPG tool used, coverage targets, and program lifecycle status. Includes version-level tracking: version number, change description, changed test flows or limits, validation status, release date, approved-by engineer, associated PCN/ECO reference, and change impact assessment. SSOT for all test program definitions and their complete evolution history across test operations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` (
    `ate_configuration_id` BIGINT COMMENT 'Unique system-generated identifier for the ATE configuration record.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: An ATE configuration is physically instantiated on a specific tester (fab_tool). Equipment maintenance scheduling, OEE tracking, and calibration compliance all require knowing which physical tester an',
    `bin_mapping_version` STRING COMMENT 'Version identifier for the binning map used in this configuration.',
    `calibration_due_date` DATE COMMENT 'Date by which the configuration must be re‑calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration state of the configuration.. Valid values are `calibrated|due|overdue`',
    `change_reason` STRING COMMENT 'Free‑text reason describing why the configuration was changed.',
    `compliance_ear_status` STRING COMMENT 'Indicates whether the configuration complies with Export Administration Regulations.. Valid values are `compliant|non_compliant|exempt`',
    `compliance_itar_status` STRING COMMENT 'Indicates whether the configuration complies with International Traffic in Arms Regulations.. Valid values are `compliant|non_compliant|exempt`',
    `configuration_code` STRING COMMENT 'Business identifier code used to reference the configuration in work orders and test plans.',
    `configuration_name` STRING COMMENT 'The configuration name of the ate configuration record in the test domain.',
    `configuration_status` STRING COMMENT 'The configuration status of the ate configuration record in the test domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created.',
    `dut_parallelism` STRING COMMENT 'The dut parallelism of the ate configuration record in the test domain.',
    `effective_end_date` DATE COMMENT 'Date when the configuration is retired (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the configuration becomes valid for use.',
    `hardware_revision` STRING COMMENT 'Revision identifier for the ATE hardware bundle (e.g., Rev A, Rev B).',
    `instrument_resource_allocation` STRING COMMENT 'List of instrument resources (e.g., power supplies, signal generators) allocated to this configuration.',
    `last_calibration_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent calibration activity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the ate configuration record in the test domain.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the configuration.. Valid values are `active|inactive|retired|decommissioned`',
    `load_board_qualification_status` STRING COMMENT 'Current qualification status of the load board for production use.. Valid values are `qualified|pending|rejected`',
    `load_board_revision` STRING COMMENT 'Revision identifier of the load board / Device Interface Board used.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance window description (e.g., weekly Saturday 02:00‑04:00).',
    `max_parallel_site_count` STRING COMMENT 'Maximum number of test sites that can be exercised simultaneously.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the ate configuration record in the test domain.',
    `ate_configuration_name` STRING COMMENT 'Human‑readable name identifying this ATE configuration.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the configuration.',
    `parametric_test_supported` BOOLEAN COMMENT 'Indicates whether parametric testing is enabled for this configuration.',
    `pin_electronics_card_map` STRING COMMENT 'Mapping description of pin‑to‑electronics card assignments for the configuration.',
    `platform_type` STRING COMMENT 'Type of test platform the configuration supports (wafer probe, final test, or reliability).. Valid values are `wafer_probe|final_test|reliability`',
    `site_count` STRING COMMENT 'The site count of the ate configuration record in the test domain.',
    `supported_device_families` STRING COMMENT 'Comma‑separated list of device families (e.g., ASIC, SoC, FPGA) that this configuration can test.',
    `test_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of functional test coverage provided by this configuration.',
    `test_head_count` STRING COMMENT 'The test head count of the ate configuration record in the test domain.',
    `test_yield_target_percentage` DECIMAL(18,2) COMMENT 'Target yield percentage that the configuration aims to achieve during test runs.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the configuration record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration record.',
    `version` STRING COMMENT 'Semantic version identifier for the configuration (e.g., 1.2.0).',
    `warranty_expiration_date` DATE COMMENT 'Date when the hardware warranty for this configuration expires.',
    `created_by` STRING COMMENT 'User identifier of the person who created the configuration record.',
    CONSTRAINT pk_ate_configuration PRIMARY KEY(`ate_configuration_id`)
) COMMENT 'Master configuration record for Automatic Test Equipment (ATE) platform setups used across wafer probe and final test operations. Captures tester model and platform type (e.g., Advantest V93000, Teradyne UltraFlex), hardware configuration revision, pin electronics card map, load board/DIB (Device Interface Board) revision and qualification status, instrument resource allocation, calibration status and due date, supported device families, maximum parallel site count, and configuration effective dates. SSOT for ATE setup definitions that test runs reference for full equipment traceability. Links to equipment domain for physical asset and maintenance tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`probe_card` (
    `probe_card_id` BIGINT COMMENT 'Unique identifier for the probe card.',
    `ate_configuration_id` BIGINT COMMENT 'Unique identifier for the ate configuration record within the probe card test entity.',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to equipment.calibration_record. Business justification: Probe cards require periodic calibration (contact resistance, planarity verification). Linking to the active calibration record is mandatory for AEC-Q qualification traceability and fab quality audits',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the prober equipment to which the probe card is currently assigned.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Probe cards are designed and qualified for specific IC catalog entries based on die pad layout, pitch, and pin count. Probe card qualification reports and procurement decisions require direct traceabi',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Probe cards are designed and qualified for specific IC designs — die pad layout, pitch, and needle placement are derived from the design projects physical specifications. Probe card qualification tra',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Probe card needle placement and pitch are directly derived from the die pad layout defined in physical_layout (pad coordinates, die dimensions, metal layer stack). This engineering dependency is funda',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Probe cards are qualified per technology node; linking ensures traceability of card usage to node specifications for yield and reliability analysis.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Probe cards are qualified and assigned to specific prober tool chambers. Chamber-level probe card qualification tracking and yield-per-chamber analysis are standard semiconductor operations. A probe c',
    `card_name` STRING COMMENT 'Human‑readable name of the probe card used for identification in test engineering.',
    `card_status` STRING COMMENT 'The card status of the probe card record in the test domain.',
    `compliance_status` STRING COMMENT 'Regulatory compliance classification applicable to the probe card.. Valid values are `itar|ear|rohs|none|restricted|export_control`',
    `contact_resistance_ohm` DECIMAL(18,2) COMMENT 'Measured electrical resistance of needle contacts in ohms.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Acquisition cost of the probe card in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the probe card record was first created in the system.',
    `probe_card_description` STRING COMMENT 'Free‑form text describing special features, notes, or remarks about the probe card.',
    `die_site_layout` STRING COMMENT 'Description of the die site arrangement on the wafer for this probe card.',
    `last_cleaning_date` DATE COMMENT 'The last cleaning date associated with the probe card test record.',
    `last_maintenance_date` DATE COMMENT 'Date when the probe card last underwent scheduled maintenance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the probe card record in the test domain.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent test run that utilized the probe card.',
    `maintenance_cycle_months` STRING COMMENT 'Planned interval in months between preventive maintenance activities.',
    `manufacturer` STRING COMMENT 'Company that manufactured the probe card.',
    `max_touchdowns` BIGINT COMMENT 'The max touchdowns of the probe card record in the test domain.',
    `needle_count` STRING COMMENT 'Total number of probing needles/pins on the card.',
    `needle_replacements` STRING COMMENT 'Cumulative number of needle replacement events performed on the card.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next preventive maintenance.',
    `notes` STRING COMMENT 'Any additional remarks or observations about the probe card.',
    `pin_count` STRING COMMENT 'The pin count of the probe card record in the test domain.',
    `pitch_um` DECIMAL(18,2) COMMENT 'Center‑to‑center spacing of needles in micrometers.',
    `planarity_um` DECIMAL(18,2) COMMENT 'The planarity um of the probe card record in the test domain.',
    `probe_card_status` STRING COMMENT 'Current lifecycle state of the probe card within test operations.. Valid values are `in_service|retired|maintenance|decommissioned|qualified|failed`',
    `probe_card_type` STRING COMMENT 'Design classification of the probe card (e.g., cantilever, vertical, MEMS, advanced).. Valid values are `cantilever|vertical|mems|advanced|custom|other`',
    `qualification_date` DATE COMMENT 'Date when the probe card was qualified for production use.',
    `qualification_status` STRING COMMENT 'Current status of the probe card qualification process.. Valid values are `qualified|pending|failed|rejected|under_review`',
    `safety_classification` STRING COMMENT 'Safety classification level for handling the probe card.. Valid values are `class_a|class_b|class_c|class_d|class_e|class_f`',
    `serial` STRING COMMENT 'The serial of the probe card record in the test domain.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number that uniquely identifies the physical probe card.',
    `supplier` STRING COMMENT 'Supplier from which the probe card was procured.',
    `touchdown_count` BIGINT COMMENT 'Number of successful needle contacts recorded per test cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the probe card record.',
    `usage_hours` DECIMAL(18,2) COMMENT 'Total operational hours the probe card has been used in testing.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty for the probe card expires.',
    CONSTRAINT pk_probe_card PRIMARY KEY(`probe_card_id`)
) COMMENT 'Master record for probe cards used in wafer probing operations, owned by test engineering for qualification, assignment, and performance tracking. Captures probe card type (cantilever, vertical, MEMS, advanced), needle/pin count, pitch, technology node compatibility, die site layout, touchdown count, maintenance cycle, current condition status, and assigned prober tool. Tracks probe card lifecycle from incoming qualification through active use to retirement, including needle replacement history and contact resistance trending. Links to equipment domain for physical asset management while test domain owns operational qualification and assignment decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` (
    `bin_definition_id` BIGINT COMMENT 'Unique surrogate key for each bin definition record.',
    `ic_catalog_id` BIGINT COMMENT 'add column ic_catalog_id (BIGINT) with FK to product.ic_catalog.ic_catalog_id - bin definitions are product specific',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Bin definitions belong to a test program; many bins per program, so add FK from bin_definition to test_program.',
    `bin_category` STRING COMMENT 'Classification of the bin outcome according to JEDEC taxonomy.. Valid values are `pass|functional_fail|parametric_fail|contact_fail|leakage_fail`',
    `bin_code` STRING COMMENT 'Alphanumeric code used in test programs to reference the bin.',
    `bin_definition_status` STRING COMMENT 'Current lifecycle status of the bin definition.. Valid values are `active|inactive|deprecated`',
    `bin_name` STRING COMMENT 'Human‑readable name describing the purpose of the bin.',
    `bin_number` STRING COMMENT 'Numeric identifier assigned to the test bin within a test program.',
    `bin_sort_order` STRING COMMENT 'Display order for bins in reports and UI.',
    `color_code` STRING COMMENT 'Coded value representing the color code of the bin definition test record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bin definition record was first created.',
    `bin_definition_description` STRING COMMENT 'Detailed free‑text description of the bin purpose and usage.',
    `device_family` STRING COMMENT 'Product family or platform to which the bin definition applies.',
    `disposition_rule` STRING COMMENT 'Action to be taken for devices falling into this bin.. Valid values are `ship|scrap|rework|hold`',
    `effective_from` DATE COMMENT 'Date when the bin definition becomes active.',
    `effective_until` DATE COMMENT 'Date when the bin definition is retired (null if indefinite).',
    `failure_mode` STRING COMMENT 'Root cause or failure mechanism associated with the bin.',
    `failure_mode_description` STRING COMMENT 'The failure mode description of the bin definition record in the test domain.',
    `hard_bin_flag` BOOLEAN COMMENT 'The hard bin flag of the bin definition record in the test domain.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this bin is the default for its category.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the bin definition record in the test domain.',
    `parameter_set` STRING COMMENT 'Set of parametric test parameters associated with the bin.',
    `pass_fail_flag` BOOLEAN COMMENT 'The pass fail flag of the bin definition record in the test domain.',
    `test_level` STRING COMMENT 'Stage of testing where the bin is applied.. Valid values are `wafer|final|reliability`',
    `updated_by` STRING COMMENT 'User identifier who last modified the bin definition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bin definition.',
    `yield_impact_category` STRING COMMENT 'The yield impact category of the bin definition record in the test domain.',
    `yield_impact_classification` STRING COMMENT 'Indicates how the bin affects overall wafer or lot yield.. Valid values are `high|medium|low|none`',
    `created_by` STRING COMMENT 'User identifier who created the bin definition record.',
    CONSTRAINT pk_bin_definition PRIMARY KEY(`bin_definition_id`)
) COMMENT 'Reference master defining all test bin codes used in wafer sort and final test. Captures bin number, bin name, bin category (pass, functional fail, parametric fail, contact fail, leakage fail), disposition rule (ship, scrap, rework, hold), yield impact classification, and associated failure mode. Provides standardized bin taxonomy across all test programs and device families per JEDEC and internal standards.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` (
    `wafer_probe_run_id` BIGINT COMMENT 'Unique identifier for each wafer probing execution event.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Billing & Reporting: wafer probe runs are billed to the customer account that owns the wafer lot, required for financial and compliance reports.',
    `assembly_order_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_order. Business justification: Wafer probe run results (KGD yield, pass die count) directly gate die release to assembly orders. Operations teams plan assembly orders against probe run outcomes; this link enables die supply traceab',
    `ate_configuration_id` BIGINT COMMENT 'FK to test.ate_configuration.ate_configuration_id — Each probe run executes on a specific ATE configuration. Required for traceability and equipment correlation analysis.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Wafer probe runs during production are traceable to the customer design win driving that production lot. Enables wafer-level yield tracking per design win, supports customer yield reports, and is requ',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the wafer prober equipment used.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Probe yield is correlated to the specific process recipe version used during fabrication for recipe qualification and yield excursion analysis. When a recipe change causes a yield shift, engineers mus',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Wafer Probe Run records must be associated with the IC catalog entry to trace probe results to the specific product version.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Yield engineers correlate wafer probe yield to the process recipe version used during fabrication to detect recipe-induced yield shifts. Recipe change impact assessments and process control reports de',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Probe runs are scheduled after a specific process step; the Probe Run Scheduling dashboard needs the step reference to track yield impact.',
    `probe_card_id` BIGINT COMMENT 'FK to test.probe_card.probe_card_id — Probe card assignment is critical for wafer probe operations — probe card condition directly impacts yield and contact quality.',
    `program_id` BIGINT COMMENT 'FK to test.test_program.test_program_id — Every wafer probe execution must reference the specific test program (and version) being run. This is the fundamental operational link between test execution and test definition.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Each wafer probe run executes on a specific prober tool chamber. Chamber-level yield analysis, OEE correlation, and excursion investigation all require knowing which chamber processed each lot. This i',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Wafer probe runs must execute on equipment qualified for the specific device family. Traceability from each probe run to the active tool qualification record is required for IATF 16949 and AEC-Q compl',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Yield excursion analysis requires correlating wafer probe run results to maintenance events on the prober. When a maintenance event precedes a yield shift, this link enables root cause analysis. Stand',
    `ate_configuration` STRING COMMENT 'Configuration identifier for the Automatic Test Equipment used in the run.. Valid values are `CFG-w{3,}`',
    `bin_map_version` STRING COMMENT 'Version identifier of the binning map used to classify die test results.',
    `contact_yield_percent` DECIMAL(18,2) COMMENT 'Percentage of dies that made electrical contact during probing.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the wafer probe run record in the test domain.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer probing run completed or was terminated.',
    `fail_die_count` STRING COMMENT 'Number of dies that failed one or more test criteria.',
    `good_die_count` STRING COMMENT 'The good die count of the wafer probe run record in the test domain.',
    `gross_die_count` STRING COMMENT 'Total die count before any filtering (e.g., before known‑good die certification).',
    `insertion_number` STRING COMMENT 'The insertion number of the wafer probe run record in the test domain.',
    `parametric_test_data_available` BOOLEAN COMMENT 'Indicates whether parametric test measurements were captured for this run.',
    `pass_die_count` STRING COMMENT 'Number of dies that passed all test criteria.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this run record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this run record.',
    `remarks` STRING COMMENT 'Free‑form notes or comments entered by the operator or quality engineer.',
    `run_number` STRING COMMENT 'Business identifier assigned to the probe run, typically following the pattern RUN-######.. Valid values are `RUN-d{6}`',
    `run_status` STRING COMMENT 'The run status of the wafer probe run record in the test domain.',
    `run_timestamp` TIMESTAMP COMMENT 'The run timestamp of the wafer probe run record in the test domain.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer probing run started.',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Proportion of functional tests executed relative to the total test plan.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'The test temperature c of the wafer probe run record in the test domain.',
    `total_die_count` STRING COMMENT 'Total number of dies present on the wafer.',
    `total_die_tested` STRING COMMENT 'The total die tested of the wafer probe run record in the test domain.',
    `wafer_probe_run_status` STRING COMMENT 'Current lifecycle status of the probe run.. Valid values are `scheduled|running|completed|failed|canceled`',
    `wafer_sequence_number` STRING COMMENT 'Sequential number of the wafer within the lot.',
    `yield_percent` DECIMAL(18,2) COMMENT 'The yield percent of the wafer probe run record in the test domain.',
    CONSTRAINT pk_wafer_probe_run PRIMARY KEY(`wafer_probe_run_id`)
) COMMENT 'Transactional record capturing each wafer probing execution event. Records wafer lot ID, wafer sequence number, probe card used, ATE configuration, test program version, prober tool, start and end timestamps, total die count, pass die count, fail die count, contact yield, gross die count, and operator ID. Core operational event for wafer-level electrical test and die sort operations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` (
    `unit_test_result_id` BIGINT COMMENT 'Primary key for unit_test_result',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Each tested die that passes becomes a unit in an assembly lot. Traceability from unit test result to assembly lot is mandatory for IATF 16949 compliance, customer quality reports, and KGD-to-packaged-',
    `final_test_run_id` BIGINT COMMENT 'FK to test.final_test_run.final_test_run_id — Package-level test results must link back to the final test run event. Required for lot disposition and DPPM tracking.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Unit test results must be traceable to the inventory wafer lot for quality tracking and stock accounting.',
    `bin_definition_id` BIGINT COMMENT 'FK to test.bin_definition.bin_definition_id — Every unit test result is assigned a bin code from the bin_definition master. This is the core yield classification link.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Unit test results are produced by a test program; add FK to capture the originating program.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Die test results are tied to the manufacturing step that produced the die; required for the Step‑Level SPC analysis report.',
    `unit_assigned_bin_definition_id` BIGINT COMMENT 'Unique identifier for the assigned bin definition record within the unit test result test entity.',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer containing the unit.',
    `wafer_probe_run_id` BIGINT COMMENT 'FK to test.wafer_probe_run.wafer_probe_run_id — Die-level test results from wafer probing must link back to the probe run event. Required for wafer map generation and lot traceability.',
    `assembly_position` STRING COMMENT 'Position identifier for multi-die or chiplet assemblies.',
    `bin_number` BIGINT COMMENT 'The bin number of the unit test result record in the test domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result record was created in the system.',
    `device_serial_number` STRING COMMENT 'Serial number of the packaged device, if applicable.',
    `die_x` STRING COMMENT 'The die x of the unit test result record in the test domain.',
    `die_x_coordinate` STRING COMMENT 'The die x coordinate of the unit test result record in the test domain.',
    `die_y` STRING COMMENT 'The die y of the unit test result record in the test domain.',
    `die_y_coordinate` STRING COMMENT 'The die y coordinate of the unit test result record in the test domain.',
    `hard_bin` STRING COMMENT 'The hard bin of the unit test result record in the test domain.',
    `hard_bin_code` STRING COMMENT 'Hard bin classification assigned to the unit based on test outcome.',
    `kgd_status` STRING COMMENT 'Qualification status of the unit as a Known Good Die.. Valid values are `kgd|non_kgd|pending`',
    `measurement_summary` STRING COMMENT 'Concise summary of parametric measurement values for the unit.',
    `measurement_units` STRING COMMENT 'Units of the parametric measurements reported. [ENUM-REF-CANDIDATE: C|V|Ohm|nA|pF|%|dB — 7 candidates stripped; promote to reference product]',
    `parametric_flags` STRING COMMENT 'Flags indicating which parametric tests were executed or passed.',
    `pass_fail` STRING COMMENT 'Overall pass or fail result for the unit.. Valid values are `pass|fail`',
    `pass_fail_flag` BOOLEAN COMMENT 'The pass fail flag of the unit test result record in the test domain.',
    `pass_fail_status` STRING COMMENT 'The pass fail status of the unit test result record in the test domain.',
    `retest_count` STRING COMMENT 'Number of times the unit has been retested.',
    `retest_indicator` BOOLEAN COMMENT 'Indicates whether the unit was retested after an initial failure.',
    `soft_bin` STRING COMMENT 'The soft bin of the unit test result record in the test domain.',
    `soft_bin_code` STRING COMMENT 'Soft bin classification for detailed failure analysis.',
    `test_condition` STRING COMMENT 'Descriptive condition of the test environment.. Valid values are `room_temp|high_temp|low_temp|stress`',
    `test_result_comment` STRING COMMENT 'Free-text comments or notes associated with the test result.',
    `test_result_version` STRING COMMENT 'Version identifier of the test result format or schema.',
    `test_stage` STRING COMMENT 'Discriminator indicating the test insertion stage where the result was captured.. Valid values are `wafer_probe|die_sort|final_test|system_level_test`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the unit was tested, in degrees Celsius.',
    `test_time_ms` DECIMAL(18,2) COMMENT 'The test time ms of the unit test result record in the test domain.',
    `test_time_seconds` DECIMAL(18,2) COMMENT 'Total duration of the test execution for the unit, in seconds.',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the test was performed.',
    `test_voltage_v` DECIMAL(18,2) COMMENT 'Voltage level applied during testing, in volts.',
    `test_yield_flag` BOOLEAN COMMENT 'Indicates if the unit is counted towards lot yield calculations.',
    `unit_identifier` STRING COMMENT 'Identifier of the tested unit, expressed as wafer X/Y coordinates for wafer-level or serial number for package-level.',
    `unit_serial_number` STRING COMMENT 'The unit serial number of the unit test result record in the test domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test result record.',
    CONSTRAINT pk_unit_test_result PRIMARY KEY(`unit_test_result_id`)
) COMMENT 'Transactional record capturing individual unit-level test results from all test insertions including wafer probing, die sort, final test, and system-level test (SLT). Records unit identifier (X/Y die coordinates for wafer-level or device serial/unit position for package-level), test insertion stage discriminator, assigned hard-bin and soft-bin codes per bin_definition, pass/fail status, total test time, parametric measurement summary flags, retest indicator and retest count, KGD (Known Good Die) qualification status, multi-die/chiplet assembly position, and test temperature/voltage condition. Serves as the single source of truth for all unit-level test outcomes across the entire test flow, enabling wafer map generation, unit-level yield analysis, full lot traceability, and die-to-package correlation. Aligns with STDF PTR/FTR/MPR record concepts.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` (
    `final_test_run_id` BIGINT COMMENT 'Unique internal identifier for the package-level test execution event.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Final test runs are performed on packaged units from a specific assembly lot. This link is essential for assembly-lot-level yield analysis, OSAT accountability reporting, and defect correlation — a te',
    `assembly_order_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_order. Business justification: Final test runs execute against units from a specific assembly order. Linking enables order-level yield reporting, cost accounting per assembly order, and customer delivery commitment tracking — stand',
    `ate_configuration_id` BIGINT COMMENT 'FK to test.ate_configuration.ate_configuration_id — Final test runs execute on specific ATE configurations. Required for equipment utilization and correlation analysis.',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to equipment.calibration_record. Business justification: AEC-Q100 and IATF 16949 require traceability from production test results to the calibration record active at time of test. Final test runs must reference the calibration record of the ATE used, enabl',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Final test runs executed during production ramp are directly tied to the customer design win that initiated production. Enables yield-per-design-win reporting, production ramp tracking, and customer-f',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the specific ATE equipment unit used.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Final test run outcomes are reported per IC product to support qualification, release, and compliance documentation.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Final test run outcomes are recorded against the inventory wafer lot to update inventory status and yield metrics.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Final test results are reported per package type; linking to package_type enables yield analysis and compliance reporting per JEDEC package family.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Final test runs are generated by a specific test program; add FK to capture this relationship.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Final test runs execute on a specific handler/tester chamber. Chamber-level yield, throughput, and defect analysis are standard final test operations. Correlating test results to specific chambers ena',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Final test runs must be executed on equipment with a valid tool qualification for the device type. AEC-Q100/Q101 compliance requires traceability from each production test run to the qualification rec',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Correlating final test yield excursions to maintenance events on the tester is a named yield engineering process. Post-maintenance qualification runs are tracked against the triggering maintenance eve',
    `ate_name` STRING COMMENT 'Name or model of the ATE system executing the test.',
    `bin_distribution` STRING COMMENT 'Compact representation of test bin counts (e.g., JSON or delimited string).',
    `boot_success_count` STRING COMMENT 'Number of devices that successfully booted during SLT.',
    `comments` STRING COMMENT 'Free‑form notes captured by the operator or system.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the final test run record in the test domain.',
    `defect_code` STRING COMMENT 'Standardized code describing the primary failure mode when the run fails.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the test execution completed.',
    `fail_count` STRING COMMENT 'Number of devices that failed one or more test criteria.',
    `final_test_run_status` STRING COMMENT 'Current lifecycle status of the test run.. Valid values are `pending|running|completed|failed`',
    `handler_model` STRING COMMENT 'The handler model of the final test run record in the test domain.',
    `handler_name` STRING COMMENT 'Identifier of the handler module that loads devices into the ATE.',
    `lot_number` STRING COMMENT 'The lot number of the final test run record in the test domain.',
    `parametric_test_fail` STRING COMMENT 'Count of parametric test points that failed.',
    `parametric_test_pass` STRING COMMENT 'Count of parametric test points that passed.',
    `pass_count` STRING COMMENT 'Number of devices that passed all test criteria.',
    `power_consumption_mw` DECIMAL(18,2) COMMENT 'Measured average power consumption during system‑level test, in milliwatts.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this test run record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this test run record.',
    `run_status` STRING COMMENT 'The run status of the final test run record in the test domain.',
    `run_timestamp` TIMESTAMP COMMENT 'The run timestamp of the final test run record in the test domain.',
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
    `units_passed` STRING COMMENT 'The units passed of the final test run record in the test domain.',
    `units_tested` STRING COMMENT 'The units tested of the final test run record in the test domain.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Yield of the test run expressed as a percentage of passed devices.',
    CONSTRAINT pk_final_test_run PRIMARY KEY(`final_test_run_id`)
) COMMENT 'Transactional record for package-level test execution events on ATE including final test and system-level test (SLT). Captures device lot ID, package type, test type discriminator (final_test, SLT), test configuration (socket, ATE, handler, SLT board), test program version, test temperature, test time, pass/fail counts, bin distribution, power consumption (SLT), boot success (SLT), and test site count. Covers all post-packaging test operations distinct from wafer-level probing.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` (
    `parametric_measurement_id` BIGINT COMMENT 'Unique surrogate key for each parametric measurement record.',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Parametric measurements taken during final test must be traceable to the assembly lot for reliability screening, SPC, and outgoing quality control. Required for PPAP submissions and customer quality r',
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Parametric measurements reference a bin definition; replace ad‑hoc bin fields with FK to bin_definition.',
    `calibration_record_id` BIGINT COMMENT 'Identifier of the calibration record applied to the equipment for this measurement.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE, probe card, etc.) that generated the measurement.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Parametric measurements are directly tied to the process recipe used — SPC charts track parametric trends by recipe version for process control and recipe qualification. Engineers need to query all pa',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Parametric measurements are taken on wafers from specific lots; lot-level SPC, process control charts, and yield excursion investigations require direct lot-level aggregation of parametric data withou',
    `final_test_run_id` BIGINT COMMENT 'Unique identifier for the final test run record within the parametric measurement test entity.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Parametric measurements need the IC catalog reference to correlate measured values with product specifications.',
    `limit_id` BIGINT COMMENT 'Unique identifier for the limit record within the parametric measurement test entity.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Process-electrical correlation (PEC) analysis — a core yield engineering activity — requires linking parametric measurements to the specific lot process run. This enables detection of process paramete',
    `wafer_id` BIGINT COMMENT 'Identifier of the individual die on which the measurement was performed.',
    `unit_test_result_id` BIGINT COMMENT 'FK to test.unit_test_result.unit_test_result_id — Parametric measurements are captured per unit under test. Must link to the parent unit result for traceability.',
    `program_id` BIGINT COMMENT 'Identifier of the test program or ATPG pattern set used for the measurement.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Parametric measurements are captured after a defined process step; required for the Process Step Parameter Trending report.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Parametric measurements are taken on final silicon; regulatory and reliability reports link each measurement to the tapeout that produced the device.',
    `to_unit_test_result_id` BIGINT COMMENT 'Identifier linking to the overall test result set for the die.',
    `wafer_probe_run_id` BIGINT COMMENT 'Unique identifier for the wafer probe run record within the parametric measurement test entity.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the parametric measurement record in the test domain.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement event was captured by the test system.',
    `lower_limit` DECIMAL(18,2) COMMENT 'The lower limit of the parametric measurement record in the test domain.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower acceptable bound for the parameter as defined by the product spec.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value recorded for the test parameter.',
    `measurement_average_value` DECIMAL(18,2) COMMENT 'Average of repeated measurements for the parameter.',
    `measurement_comment` STRING COMMENT 'Free‑form comment entered by the operator or analyst.',
    `measurement_condition_frequency_mhz` DECIMAL(18,2) COMMENT 'Frequency condition during the measurement, expressed in megahertz.',
    `measurement_condition_temperature_c` DECIMAL(18,2) COMMENT 'Temperature condition during the measurement, expressed in degrees Celsius.',
    `measurement_condition_voltage_mv` DECIMAL(18,2) COMMENT 'Voltage condition applied during the measurement, expressed in millivolts.',
    `measurement_evaluated_against_limit` BIGINT COMMENT 'FK to test.test_limit.test_limit_id — Each parametric measurement is evaluated against specification limits defined in test_limit. This link enables pass/fail determination and SPC analysis.',
    `measurement_flagged` BOOLEAN COMMENT 'Indicates if the measurement was flagged for outlier review.',
    `measurement_for_unit_result` BIGINT COMMENT 'FK to test.die_test_result.die_test_result_id — Parametric measurements are captured for specific die/device test results. This is the detail-level link from measurement to the unit being tested.',
    `measurement_location` STRING COMMENT 'Physical location on the die where the measurement was taken.. Valid values are `center|edge`',
    `measurement_mode` STRING COMMENT 'Mode of the test, indicating whether the measurement is parametric or functional.. Valid values are `parametric|functional`',
    `measurement_quality_flag` STRING COMMENT 'Quality assessment of the measurement data.. Valid values are `good|questionable|bad`',
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
    `measurement_unit` STRING COMMENT 'The measurement unit of the parametric measurement record in the test domain.',
    `parameter_name` STRING COMMENT 'The parameter name of the parametric measurement record in the test domain.',
    `parametric_against_limit` BIGINT COMMENT 'FK to test.test_limit.test_limit_id — Each parametric measurement is evaluated against a test limit specification. Required for pass/fail determination and SPC.',
    `parametric_checked_against_limit` BIGINT COMMENT 'FK to test.test_limit.test_limit_id — Each parametric measurement is evaluated against a test limit. This FK enables limit-vs-actual analysis and SPC trending.',
    `pass_fail_flag` BOOLEAN COMMENT 'The pass fail flag of the parametric measurement record in the test domain.',
    `pass_fail_status` STRING COMMENT 'Result of the measurement against spec limits.. Valid values are `pass|fail`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement record was first persisted in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the measurement record.',
    `test_parameter_name` STRING COMMENT 'Name of the specific parametric test parameter (e.g., Vth, Idsat).',
    `unit_of_measure` STRING COMMENT 'Engineering unit associated with the measured value. [ENUM-REF-CANDIDATE: V|mV|A|mA|Ohm|C|K|Hz — 8 candidates stripped; promote to reference product]',
    `upper_limit` DECIMAL(18,2) COMMENT 'The upper limit of the parametric measurement record in the test domain.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper acceptable bound for the parameter as defined by the product spec.',
    CONSTRAINT pk_parametric_measurement PRIMARY KEY(`parametric_measurement_id`)
) COMMENT 'Transactional record storing individual parametric test measurements captured during wafer probe and final test. Records test parameter name, measured value, lower specification limit (LSL), upper specification limit (USL), pass/fail status, measurement unit, test condition (voltage, temperature, frequency), and associated die or device result. Enables SPC analysis, parametric yield optimization, and process-test correlation studies.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`limit` (
    `limit_id` BIGINT COMMENT 'System-generated unique identifier for the test limit record.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test limits are defined per IC catalog entry to ensure each product revision meets its specification envelope.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Test limits are package-type-specific — thermal resistance, electrical, and reliability limits differ by package (e.g., BGA vs QFN). Package-specific parametric guardbands are a real semiconductor eng',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Test limits are defined per process node; the Test Limit Specification requires the PDK identifier to ensure correct corner definitions.',
    `product_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_spec. Business justification: Test limits are derived from and must be traceable to product specifications. Spec-to-limit traceability is required for design validation sign-off, customer datasheet generation, and change control —',
    `program_id` BIGINT COMMENT 'Identifier of the ATPG or ATE program that consumes this limit.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.design_revision. Business justification: Test limits are reviewed and updated when design revisions occur — ECO changes affecting parametric specs require limit re-evaluation. Traceability from limit to design_revision supports change manage',
    `approval_status` STRING COMMENT 'Current approval state of the limit record.. Valid values are `pending|approved|rejected|revoked`',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the limit.',
    `audit_trail` STRING COMMENT 'Chronological log of actions performed on the limit record.',
    `bin_mapping_code` STRING COMMENT 'Code linking the limit to a specific binning scheme.',
    `limit_category` STRING COMMENT 'High‑level category of the limit.. Valid values are `voltage|current|resistance|capacitance|frequency|temperature`',
    `change_reason` STRING COMMENT 'Narrative explanation for why the limit was changed.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the limit.. Valid values are `SEMI|JEDEC|IEC|ISO`',
    `created_by_department` STRING COMMENT 'Organizational department responsible for creating the limit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the limit record was first created.',
    `data_source` STRING COMMENT 'Origin of the measurement data used for the limit.. Valid values are `ATE|ATPG|simulation|lab`',
    `device_type` STRING COMMENT 'Classification of the semiconductor device (e.g., ASIC, SoC, FPGA) to which the limit applies.',
    `effective_date` DATE COMMENT 'Date on which the limit becomes active for production testing.',
    `expiration_date` DATE COMMENT 'Date after which the limit is no longer valid (null for open‑ended).',
    `guardband_value` DECIMAL(18,2) COMMENT 'The guardband value of the limit record in the test domain.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the limit is currently active in the test flow.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the limit record in the test domain.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the limit.',
    `limit_type` STRING COMMENT 'The type of the limit record in the test domain.',
    `lower_limit` DECIMAL(18,2) COMMENT 'The lower limit of the limit record in the test domain.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable measured value for the parameter.',
    `measurement_type` STRING COMMENT 'Category of measurement the limit belongs to.. Valid values are `parametric|functional|timing`',
    `measurement_unit` STRING COMMENT 'The measurement unit of the limit record in the test domain.',
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
    `upper_limit` DECIMAL(18,2) COMMENT 'The upper limit of the limit record in the test domain.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable measured value for the parameter.',
    `version` STRING COMMENT 'Version identifier for the limit record, incremented on each change.',
    `version_history` STRING COMMENT 'JSON or delimited text capturing historical versions of the limit.',
    CONSTRAINT pk_limit PRIMARY KEY(`limit_id`)
) COMMENT 'Master record defining parametric test limits for each test parameter by device type, product revision, and test condition. Captures parameter name, LSL, USL, target value, measurement unit, test condition set, limit revision history, effective date, and approval status. SSOT for all test specification limits used across ATPG programs and ATE test flows. Supports limit change management and PCN-driven limit updates.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_probe_card_id` FOREIGN KEY (`probe_card_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`probe_card`(`probe_card_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_unit_assigned_bin_definition_id` FOREIGN KEY (`unit_assigned_bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_limit_id` FOREIGN KEY (`limit_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`limit`(`limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_to_unit_test_result_id` FOREIGN KEY (`to_unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`test` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`test` SET TAGS ('dbx_domain' = 'test');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Test Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Test Program Owner');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `parametric_test_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Data Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_coverage_metric` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Metric');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_coverage_metric` SET TAGS ('dbx_value_regex' = 'fault_coverage|code_coverage|timing_coverage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'lab|production|prototype');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Units');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ALTER COLUMN `test_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Value');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `dut_parallelism` SET TAGS ('dbx_business_glossary_term' = 'Dut Parallelism');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `hardware_revision` SET TAGS ('dbx_business_glossary_term' = 'Hardware Revision');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `instrument_resource_allocation` SET TAGS ('dbx_business_glossary_term' = 'Instrument Resource Allocation');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `last_calibration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|decommissioned');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `load_board_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Load Board Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `load_board_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `load_board_revision` SET TAGS ('dbx_business_glossary_term' = 'Load Board Revision');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `max_parallel_site_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Parallel Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `ate_configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `parametric_test_supported` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Supported');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `pin_electronics_card_map` SET TAGS ('dbx_business_glossary_term' = 'Pin Electronics Card Map');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'wafer_probe|final_test|reliability');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `site_count` SET TAGS ('dbx_business_glossary_term' = 'Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `supported_device_families` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Families');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `test_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `test_head_count` SET TAGS ('dbx_business_glossary_term' = 'Test Head Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `test_yield_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Test Yield Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Prober Tool Identifier (APTI)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `card_name` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Name (PCN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `card_status` SET TAGS ('dbx_business_glossary_term' = 'Card Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'itar|ear|rohs|none|restricted|export_control');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `contact_resistance_ohm` SET TAGS ('dbx_business_glossary_term' = 'Contact Resistance (Ohm) (CR)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost (USD) (COST)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_description` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Description (PCD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `die_site_layout` SET TAGS ('dbx_business_glossary_term' = 'Die Site Layout Description (DSL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `last_cleaning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaning Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LMD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp (LUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `maintenance_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Months) (MC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name (MN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `max_touchdowns` SET TAGS ('dbx_business_glossary_term' = 'Max Touchdowns');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `needle_count` SET TAGS ('dbx_business_glossary_term' = 'Needle Count (NC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `needle_replacements` SET TAGS ('dbx_business_glossary_term' = 'Needle Replacement Count (NRC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date (NMDD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Pin Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Needle Pitch (µm) (NP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `planarity_um` SET TAGS ('dbx_business_glossary_term' = 'Planarity Um');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_status` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Lifecycle Status (PCS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|decommissioned|qualified|failed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_type` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Type (PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_type` SET TAGS ('dbx_value_regex' = 'cantilever|vertical|mems|advanced|custom|other');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date (QD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|failed|rejected|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification (SC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c|class_d|class_e|class_f');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `serial` SET TAGS ('dbx_business_glossary_term' = 'Serial');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Serial Number (PCS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `supplier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name (SN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `touchdown_count` SET TAGS ('dbx_business_glossary_term' = 'Touchdown Count per Test (TC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `usage_hours` SET TAGS ('dbx_business_glossary_term' = 'Usage Hours (UH)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WED)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_category` SET TAGS ('dbx_business_glossary_term' = 'Bin Category (BIN_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_category` SET TAGS ('dbx_value_regex' = 'pass|functional_fail|parametric_fail|contact_fail|leakage_fail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Code (BIN_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Bin Status (BIN_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_name` SET TAGS ('dbx_business_glossary_term' = 'Bin Name (BIN_NM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bin Number (BIN_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_sort_order` SET TAGS ('dbx_business_glossary_term' = 'Bin Sort Order (BIN_ORDER)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Bin Description (BIN_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `device_family` SET TAGS ('dbx_business_glossary_term' = 'Device Family (DEV_FAM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `disposition_rule` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rule (DISP_RULE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `disposition_rule` SET TAGS ('dbx_value_regex' = 'ship|scrap|rework|hold');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode (FAIL_MODE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `failure_mode_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `hard_bin_flag` SET TAGS ('dbx_business_glossary_term' = 'Hard Bin Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Bin (IS_DEF)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `parameter_set` SET TAGS ('dbx_business_glossary_term' = 'Parameter Set (PARAM_SET)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `test_level` SET TAGS ('dbx_business_glossary_term' = 'Test Level (TEST_LVL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `test_level` SET TAGS ('dbx_value_regex' = 'wafer|final|reliability');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UPD_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `yield_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Category');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `yield_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Classification (YLD_IMPACT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `yield_impact_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CRE_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Prober Tool ID (PROBER_TOOL_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration` SET TAGS ('dbx_business_glossary_term' = 'ATE Configuration (ATE_CFG)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration` SET TAGS ('dbx_value_regex' = 'CFG-w{3,}');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `bin_map_version` SET TAGS ('dbx_business_glossary_term' = 'Bin Map Version (BIN_MAP_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `contact_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Contact Yield Percent (YIELD_CONTACT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp (END_TIME)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `fail_die_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Die Count (FAIL_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `gross_die_count` SET TAGS ('dbx_business_glossary_term' = 'Gross Die Count (GROSS_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `insertion_number` SET TAGS ('dbx_business_glossary_term' = 'Insertion Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `parametric_test_data_available` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Data Available (PARAM_DATA)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `pass_die_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Die Count (PASS_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (REMARKS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number (RUN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `run_number` SET TAGS ('dbx_value_regex' = 'RUN-d{6}');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp (START_TIME)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percent (COVERAGE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count (TOTAL_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `total_die_tested` SET TAGS ('dbx_business_glossary_term' = 'Total Die Tested');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|failed|canceled');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Sequence Number (WAFER_SEQ_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Bin Definition Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `unit_assigned_bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `unit_assigned_bin_definition_id` SET TAGS ('dbx_business_role' = 'assigned_bin');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `assembly_position` SET TAGS ('dbx_business_glossary_term' = 'Assembly Position');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bin Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_x` SET TAGS ('dbx_business_glossary_term' = 'Die X');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Die X Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_x_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_x_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_x_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_y` SET TAGS ('dbx_business_glossary_term' = 'Die Y');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Die Y Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_y_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_y_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `die_y_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `hard_bin` SET TAGS ('dbx_business_glossary_term' = 'Hard Bin');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `hard_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Hard Bin Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'kgd|non_kgd|pending');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `measurement_summary` SET TAGS ('dbx_business_glossary_term' = 'Measurement Summary');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `measurement_units` SET TAGS ('dbx_business_glossary_term' = 'Measurement Units');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `parametric_flags` SET TAGS ('dbx_business_glossary_term' = 'Parametric Flags');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `retest_count` SET TAGS ('dbx_business_glossary_term' = 'Retest Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `retest_indicator` SET TAGS ('dbx_business_glossary_term' = 'Retest Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `soft_bin` SET TAGS ('dbx_business_glossary_term' = 'Soft Bin');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `soft_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Soft Bin Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_condition` SET TAGS ('dbx_business_glossary_term' = 'Test Condition');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_condition` SET TAGS ('dbx_value_regex' = 'room_temp|high_temp|low_temp|stress');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_result_comment` SET TAGS ('dbx_business_glossary_term' = 'Test Result Comment');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_result_version` SET TAGS ('dbx_business_glossary_term' = 'Test Result Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_stage` SET TAGS ('dbx_business_glossary_term' = 'Test Stage (Wafer Probe, Die Sort, Final Test, System-Level Test)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_stage` SET TAGS ('dbx_value_regex' = 'wafer_probe|die_sort|final_test|system_level_test');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Test Time Ms');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Time (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage (V)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_yield_flag` SET TAGS ('dbx_business_glossary_term' = 'Yield Contribution Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `unit_identifier` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (Die Coordinates or Serial Number)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `unit_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ate_name` SET TAGS ('dbx_business_glossary_term' = 'Automatic Test Equipment Name (ATEN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `bin_distribution` SET TAGS ('dbx_business_glossary_term' = 'Bin Distribution (BD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `boot_success_count` SET TAGS ('dbx_business_glossary_term' = 'Boot Success Count (BSC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Test Run Comments (TRC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code (DC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp (TET)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `fail_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Count (FC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_status` SET TAGS ('dbx_business_glossary_term' = 'Test Run Status (TRS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `handler_model` SET TAGS ('dbx_business_glossary_term' = 'Handler Model');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `handler_name` SET TAGS ('dbx_business_glossary_term' = 'Test Handler Name (THN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `parametric_test_fail` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Fail Count (PTFC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `parametric_test_pass` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Pass Count (PTPC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `pass_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Count (PC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (mW) (PC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `units_passed` SET TAGS ('dbx_business_glossary_term' = 'Units Passed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `units_tested` SET TAGS ('dbx_business_glossary_term' = 'Units Tested');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parametric_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Parametric Measurement ID (PMID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Identifier (CAL_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier (EQP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Die Identifier (DIE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier (TP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `to_unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier (RES_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (ET)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value (MV)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_average_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Average Value (AVG)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_comment` SET TAGS ('dbx_business_glossary_term' = 'Measurement Comment (CMNT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency (F_MHZ)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Measurement Temperature (T_C)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_voltage_mv` SET TAGS ('dbx_business_glossary_term' = 'Measurement Voltage (V_MV)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_evaluated_against_limit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Evaluated Against Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_flagged` SET TAGS ('dbx_business_glossary_term' = 'Measurement Flagged (FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_for_unit_result` SET TAGS ('dbx_business_glossary_term' = 'Measurement For Unit Result');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_location` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location (MLOC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_location` SET TAGS ('dbx_value_regex' = 'center|edge');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode (MODE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'parametric|functional');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Measurement Quality Flag (QFLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parametric_against_limit` SET TAGS ('dbx_business_glossary_term' = 'Parametric Against Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parametric_checked_against_limit` SET TAGS ('dbx_business_glossary_term' = 'Parametric Checked Against Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status (PFS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `test_parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Name (TPN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `bin_mapping_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Code');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `guardband_value` SET TAGS ('dbx_business_glossary_term' = 'Guardband Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'parametric|functional|timing');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Name');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Limit Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `version_history` SET TAGS ('dbx_business_glossary_term' = 'Version History');
