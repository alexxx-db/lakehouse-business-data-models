-- Schema for Domain: test | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`test` COMMENT 'Wafer probing, die sort, final test, and reliability testing operations. Manages ATPG programs, ATE configurations, test coverage, bin mapping, test yield, parametric test data, and correlation studies between wafer-level and package-level test. Distinct from quality domain which focuses on QMS and compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`test_program` (
    `test_program_id` BIGINT COMMENT 'System-generated unique identifier for each test program record.',
    `ate_configuration_id` BIGINT COMMENT 'Foreign key linking to test.ate_configuration. Business justification: Test programs are executed on specific ATE configurations; many programs can share one configuration, so add FK from test_program to ate_configuration.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgeting process: each test program is funded by a specific cost center; required for cost allocation reports.',
    `employee_id` BIGINT COMMENT 'Name of the engineer or manager who approved the program release.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Required for Test Program Definition: each test program is created for a specific technology node to ensure correct test parameters and compliance reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test Program Management requires linking each test program to the IC catalog entry it validates for release tracking.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Required for Test Program Planning: links each test program to the specific material (chip) defined in the Material Master, enabling traceability of test coverage to product specifications.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Test Engineering defines a test program per manufacturing flow; linking enables the Test Flow Specification report that maps each program to its process flow.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability tracking: test program results are evaluated against profit center performance for ROI analysis.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: Required for R&D Program Test Alignment Report linking each test program to its originating research program for budget and compliance tracking.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Needed for Test Program Management to associate test results with the specific research project that defines the chip design, enabling milestone reporting.',
    `actual_coverage_percent` DECIMAL(18,2) COMMENT 'Measured fault‑coverage achieved after program execution.',
    `approval_date` DATE COMMENT 'Date on which the program was approved.',
    `ate_platform` STRING COMMENT 'Automatic Test Equipment platform compatible with the program.. Valid values are `ATE_9000|ATE_9500|ATE_10000|Custom`',
    `atpg_tool` STRING COMMENT 'ATPG software used to generate the test vectors (e.g., Synopsys TestMAX, Mentor Tessent).',
    `bin_mapping_reference` STRING COMMENT 'Identifier of the bin‑mapping table associated with this program.',
    `change_description` STRING COMMENT 'Detailed narrative of modifications to test flows, limits, or parameters.',
    `correlation_study_reference` STRING COMMENT 'Identifier of the wafer‑to‑package correlation study associated with the program.',
    `coverage_target_percent` DECIMAL(18,2) COMMENT 'Desired fault‑coverage percentage the program aims to achieve.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `deprecation_date` DATE COMMENT 'Date on which the program version was marked as deprecated.',
    `impact_assessment` STRING COMMENT 'Narrative assessment of the programs impact on yield, cost, and schedule.',
    `is_deprecated` BOOLEAN COMMENT 'Flag indicating whether the program version is deprecated.',
    `test_program_name` STRING COMMENT 'Human‑readable name of the test program.',
    `owner` STRING COMMENT 'Name of the engineer or team responsible for the program.',
    `parametric_test_data_reference` STRING COMMENT 'Link to the parametric test data set used for limit verification.',
    `program_category` STRING COMMENT 'High‑level classification of the test program purpose.. Valid values are `functional|structural|parametric|mixed`',
    `program_code` STRING COMMENT 'Business‑assigned code that uniquely identifies the test program across systems.',
    `related_pcn_eco` STRING COMMENT 'Reference to the Product Change Notification or Engineering Change Order linked to this program version.',
    `release_date` DATE COMMENT 'Calendar date when the program version was officially released for production use.',
    `test_program_status` STRING COMMENT 'Overall lifecycle state of the test program.. Valid values are `active|inactive|deprecated|retired`',
    `target_device` STRING COMMENT 'Specific device part number or SKU the program validates.',
    `target_device_family` STRING COMMENT 'Family or series of devices the program is intended for (e.g., FinFET‑45nm, GAA‑7nm).',
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
    CONSTRAINT pk_test_program PRIMARY KEY(`test_program_id`)
) COMMENT 'Master record for ATPG-generated and manually authored test programs used on ATE platforms, with full version lifecycle management. Captures program name, target device family, test type (wafer probe, die sort, final test, burn-in, SLT), ATE platform compatibility, ATPG tool used, coverage targets, and program lifecycle status. Includes version-level tracking: version number, change description, changed test flows or limits, validation status, release date, approved-by engineer, associated PCN/ECO reference, and change impact assessment. SSOT for all test program definitions and their complete evolution history across test operations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` (
    `ate_configuration_id` BIGINT COMMENT 'Unique system-generated identifier for the ATE configuration record.',
    `site_id` BIGINT COMMENT 'FK to shared.site.site_id',
    `ate_platform` STRING COMMENT 'The ate platform of the ate configuration record in the test domain.',
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
    `ate_configuration_id` BIGINT COMMENT 'Unique identifier for the ate configuration record within the probe card test entity.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the prober equipment to which the probe card is currently assigned.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Probe cards are qualified per technology node; linking ensures traceability of card usage to node specifications for yield and reliability analysis.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier record within the probe card test entity.',
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
    `probe_card_serial_number` STRING COMMENT 'The probe card serial number of the probe card record in the test domain.',
    `qualification_date` DATE COMMENT 'Date when the probe card was qualified for production use.',
    `qualification_status` STRING COMMENT 'Current status of the probe card qualification process.. Valid values are `qualified|pending|failed|rejected|under_review`',
    `safety_classification` STRING COMMENT 'Safety classification level for handling the probe card.. Valid values are `class_a|class_b|class_c|class_d|class_e|class_f`',
    `serial` STRING COMMENT 'The serial of the probe card record in the test domain.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number that uniquely identifies the physical probe card.',
    `probe_card_status` STRING COMMENT 'Current lifecycle state of the probe card within test operations.. Valid values are `in_service|retired|maintenance|decommissioned|qualified|failed`',
    `supplier` STRING COMMENT 'Supplier from which the probe card was procured.',
    `touchdown_count` BIGINT COMMENT 'Number of successful needle contacts recorded per test cycle.',
    `probe_card_type` STRING COMMENT 'Design classification of the probe card (e.g., cantilever, vertical, MEMS, advanced).. Valid values are `cantilever|vertical|mems|advanced|custom|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the probe card record.',
    `usage_hours` DECIMAL(18,2) COMMENT 'Total operational hours the probe card has been used in testing.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty for the probe card expires.',
    CONSTRAINT pk_probe_card PRIMARY KEY(`probe_card_id`)
) COMMENT 'Master record for probe cards used in wafer probing operations, owned by test engineering for qualification, assignment, and performance tracking. Captures probe card type (cantilever, vertical, MEMS, advanced), needle/pin count, pitch, technology node compatibility, die site layout, touchdown count, maintenance cycle, current condition status, and assigned prober tool. Tracks probe card lifecycle from incoming qualification through active use to retirement, including needle replacement history and contact resistance trending. Links to equipment domain for physical asset management while test domain owns operational qualification and assignment decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` (
    `bin_definition_id` BIGINT COMMENT 'Unique surrogate key for each bin definition record.',
    `ic_catalog_id` BIGINT COMMENT 'add column ic_catalog_id (BIGINT) with FK to product.ic_catalog.ic_catalog_id - bin definitions are product specific',
    `test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Bin definitions belong to a test program; many bins per program, so add FK from bin_definition to test_program.',
    `bin_category` STRING COMMENT 'Classification of the bin outcome according to JEDEC taxonomy.. Valid values are `pass|functional_fail|parametric_fail|contact_fail|leakage_fail`',
    `bin_code` STRING COMMENT 'Alphanumeric code used in test programs to reference the bin.',
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
    `bin_definition_status` STRING COMMENT 'Current lifecycle status of the bin definition.. Valid values are `active|inactive|deprecated`',
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
    `ate_configuration_id` BIGINT COMMENT 'FK to test.ate_configuration.ate_configuration_id — Each probe run executes on a specific ATE configuration. Required for traceability and equipment correlation analysis.',
    `correlation_study_id` BIGINT COMMENT 'Identifier of the correlation study linking wafer‑level and package‑level test data.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the wafer prober equipment used.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Wafer Probe Run records must be associated with the IC catalog entry to trace probe results to the specific product version.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Wafer probe runs are performed on wafers from a given design project; yield analysis links probe data to the originating IC design project.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Internal order captures labor and equipment cost for each wafer probe run; used in cost‑of‑goods‑sold calculations.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Probe Yield Report requires linking each wafer probe run to the inventory wafer lot to update lot-level yield and inventory status.',
    `primary_wafer_probe_card_id` BIGINT COMMENT 'Identifier of the probe card installed on the prober for this run.',
    `primary_wafer_test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Wafer probe runs are executed under a specific test program; replace version string with FK to test_program.',
    `probe_card_id` BIGINT COMMENT 'FK to test.probe_card.probe_card_id — Probe card assignment is critical for wafer probe operations — probe card condition directly impacts yield and contact quality.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Probe runs are scheduled after a specific process step; the Probe Run Scheduling dashboard needs the step reference to track yield impact.',
    `test_program_id` BIGINT COMMENT 'FK to test.test_program.test_program_id — Every wafer probe execution must reference the specific test program (and version) being run. This is the fundamental operational link between test execution and test definition.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who operated the probe equipment for this run.',
    `wafer_id` BIGINT COMMENT 'Unique identifier for the wafer record within the wafer probe run test entity.',
    `wafer_operator_employee_id` BIGINT COMMENT 'Unique identifier for the wafer operator employee record within the wafer probe run test entity.',
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
    `wafer_probe_run_status` STRING COMMENT 'Current lifecycle status of the probe run.. Valid values are `scheduled|running|completed|failed|canceled`',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Proportion of functional tests executed relative to the total test plan.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'The test temperature c of the wafer probe run record in the test domain.',
    `total_die_count` STRING COMMENT 'Total number of dies present on the wafer.',
    `total_die_tested` STRING COMMENT 'The total die tested of the wafer probe run record in the test domain.',
    `wafer_lot_number` STRING COMMENT 'The wafer lot number of the wafer probe run record in the test domain.',
    `wafer_sequence_number` STRING COMMENT 'Sequential number of the wafer within the lot.',
    `yield_percent` DECIMAL(18,2) COMMENT 'The yield percent of the wafer probe run record in the test domain.',
    CONSTRAINT pk_wafer_probe_run PRIMARY KEY(`wafer_probe_run_id`)
) COMMENT 'Transactional record capturing each wafer probing execution event. Records wafer lot ID, wafer sequence number, probe card used, ATE configuration, test program version, prober tool, start and end timestamps, total die count, pass die count, fail die count, contact yield, gross die count, and operator ID. Core operational event for wafer-level electrical test and die sort operations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` (
    `unit_test_result_id` BIGINT COMMENT 'Primary key for unit_test_result',
    `bin_definition_id` BIGINT COMMENT 'Unique identifier for the assigned bin definition record within the unit test result test entity.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Each die test result is linked to the devices ECCN classification for export‑control compliance reporting and analytics.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who oversaw the test.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE) used.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot associated with the unit.',
    `final_test_run_id` BIGINT COMMENT 'FK to test.final_test_run.final_test_run_id — Package-level test results must link back to the final test run event. Required for lot disposition and DPPM tracking.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Unit test results must be traceable to the inventory wafer lot for quality tracking and stock accounting.',
    `netlist_id` BIGINT COMMENT 'Foreign key linking to design.netlist. Business justification: Die test results are correlated to the netlist version used for synthesis; debugging reports require the netlist_id reference.',
    `primary_bin_definition_id` BIGINT COMMENT 'FK to test.bin_definition.bin_definition_id — Every unit test result is assigned a bin code from the bin_definition master. This is the core yield classification link.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Die test results are tied to the manufacturing step that produced the die; required for the Step‑Level SPC analysis report.',
    `test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Unit test results are produced by a test program; add FK to capture the originating program.',
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
    `ate_configuration_id` BIGINT COMMENT 'FK to test.ate_configuration.ate_configuration_id — Final test runs execute on specific ATE configurations. Required for equipment utilization and correlation analysis.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Final test of devices slated for export must be tied to the governing export license to satisfy USML/EAR control reporting.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the specific ATE equipment unit used.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot associated with the devices under test.',
    `employee_id` BIGINT COMMENT 'Name or employee identifier of the operator who initiated the test run.',
    `final_operator_employee_id` BIGINT COMMENT 'Unique identifier for the final operator employee record within the final test run test entity.',
    `test_program_id` BIGINT COMMENT 'FK to test.test_program.test_program_id — Every final test execution references a specific test program version. Same fundamental link as wafer_probe_run to test_program.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Final test run outcomes are reported per IC product to support qualification, release, and compliance documentation.',
    `insertion_id` BIGINT COMMENT 'Unique identifier for the insertion record within the final test run test entity.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Final test execution costs are booked to an internal order for expense tracking and profitability reporting.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Final test run outcomes are recorded against the inventory wafer lot to update inventory status and yield metrics.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Final test results are reported per package type; linking to package_type enables yield analysis and compliance reporting per JEDEC package family.',
    `primary_final_test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Final test runs are generated by a specific test program; add FK to capture this relationship.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Final test runs validate a completed process flow; the Final Test Yield Summary links each run to its originating flow.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Final test is executed on taped‑out silicon; the Final Test Yield report must reference the tapeout_id for traceability.',
    `ate_name` STRING COMMENT 'Name or model of the ATE system executing the test.',
    `bin_distribution` STRING COMMENT 'Compact representation of test bin counts (e.g., JSON or delimited string).',
    `boot_success_count` STRING COMMENT 'Number of devices that successfully booted during SLT.',
    `comments` STRING COMMENT 'Free‑form notes captured by the operator or system.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the final test run record in the test domain.',
    `defect_code` STRING COMMENT 'Standardized code describing the primary failure mode when the run fails.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the test execution completed.',
    `fail_count` STRING COMMENT 'Number of devices that failed one or more test criteria.',
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
    `final_test_run_status` STRING COMMENT 'Current lifecycle status of the test run.. Valid values are `pending|running|completed|failed`',
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
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Parametric measurements reference a bin definition; replace ad‑hoc bin fields with FK to bin_definition.',
    `calibration_record_id` BIGINT COMMENT 'Identifier of the calibration record applied to the equipment for this measurement.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE, probe card, etc.) that generated the measurement.',
    `final_test_run_id` BIGINT COMMENT 'Unique identifier for the final test run record within the parametric measurement test entity.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Parametric measurements need the IC catalog reference to correlate measured values with product specifications.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Parametric measurements are associated with the inventory wafer lot for SPC and statistical analysis.',
    `limit_id` BIGINT COMMENT 'Unique identifier for the limit record within the parametric measurement test entity.',
    `wafer_id` BIGINT COMMENT 'Identifier of the individual die on which the measurement was performed.',
    `parametric_unit_test_result_id` BIGINT COMMENT 'FK to test.unit_test_result.unit_test_result_id — Parametric measurements are captured per unit under test. Must link to the parent unit result for traceability.',
    `parametric_wafer_id` BIGINT COMMENT 'Identifier of the wafer containing the die measured.',
    `employee_id` BIGINT COMMENT 'Identifier of the human operator overseeing the test run.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Parametric measurements are captured after a defined process step; required for the Process Step Parameter Trending report.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Parametric measurements are taken on final silicon; regulatory and reliability reports link each measurement to the tapeout that produced the device.',
    `test_program_id` BIGINT COMMENT 'Identifier of the test program or ATPG pattern set used for the measurement.',
    `test_step_id` BIGINT COMMENT 'Identifier of the specific test step within the program.',
    `unit_test_result_id` BIGINT COMMENT 'Identifier linking to the overall test result set for the die.',
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
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the record.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test limits are defined per IC catalog entry to ensure each product revision meets its specification envelope.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Test limits are defined per process node; the Test Limit Specification requires the PDK identifier to ensure correct corner definitions.',
    `test_case_id` BIGINT COMMENT 'Unique identifier for the test case record within the limit test entity.',
    `test_program_id` BIGINT COMMENT 'Identifier of the ATPG or ATE program that consumes this limit.',
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
    `lower_limit` DECIMAL(18,2) COMMENT 'The lower limit of the limit record in the test domain.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable measured value for the parameter.',
    `measurement_type` STRING COMMENT 'Category of measurement the limit belongs to.. Valid values are `parametric|functional|timing`',
    `measurement_unit` STRING COMMENT 'The measurement unit of the limit record in the test domain.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the limit.',
    `parameter_name` STRING COMMENT 'Human‑readable name of the parametric test parameter (e.g., Vdd, Idd).',
    `product_revision` STRING COMMENT 'Internal revision identifier of the product (e.g., A1, B2) linked to the limit.',
    `regulatory_flag` BOOLEAN COMMENT 'True if the limit is mandated by a regulatory requirement.',
    `related_pcn_number` STRING COMMENT 'Product Change Notification identifier that triggered the limit change.',
    `review_cycle` STRING COMMENT 'Scheduled frequency for limit review.. Valid values are `annual|semiannual|quarterly`',
    `risk_level` STRING COMMENT 'Risk classification associated with the limit deviation.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of samples used to calculate the limit.',
    `source` STRING COMMENT 'Origin of the limit definition.. Valid values are `design|customer|regulatory|internal`',
    `statistical_method` STRING COMMENT 'Statistical approach used to derive the limit.. Valid values are `mean|median|percentile|sigma`',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal target value that the process aims to achieve.',
    `test_condition_set` STRING COMMENT 'Named set of test conditions (temperature, voltage, frequency) under which the limit is valid.',
    `test_flow_name` STRING COMMENT 'Name of the test flow or sequence where the limit is applied.',
    `test_step_id` BIGINT COMMENT 'Unique identifier for the test step record within the limit test entity.',
    `tolerance_percent` DECIMAL(18,2) COMMENT 'Allowed percentage deviation from the target value.',
    `limit_type` STRING COMMENT 'The type of the limit record in the test domain.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the limit values. [ENUM-REF-CANDIDATE: V|mV|A|mA|Ohm|kOhm|nF|pF|C|% — 10 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the limit record.',
    `upper_limit` DECIMAL(18,2) COMMENT 'The upper limit of the limit record in the test domain.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable measured value for the parameter.',
    `version` STRING COMMENT 'Version identifier for the limit record, incremented on each change.',
    `version_history` STRING COMMENT 'JSON or delimited text capturing historical versions of the limit.',
    CONSTRAINT pk_limit PRIMARY KEY(`limit_id`)
) COMMENT 'Master record defining parametric test limits for each test parameter by device type, product revision, and test condition. Captures parameter name, LSL, USL, target value, measurement unit, test condition set, limit revision history, effective date, and approval status. SSOT for all test specification limits used across ATPG programs and ATE test flows. Supports limit change management and PCN-driven limit updates.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`coverage` (
    `coverage_id` BIGINT COMMENT 'Unique surrogate key for each test coverage record.',
    `ic_catalog_id` BIGINT COMMENT 'Surrogate key linking to the device type master data.',
    `coverage_ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test coverage reports are generated per IC product to assess validation completeness before tape‑out.',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer or analyst who performed the last review.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Test coverage metrics are reported per design project; the Design Coverage Dashboard aggregates coverage by ic_design_project_id.',
    `test_program_id` BIGINT COMMENT 'Surrogate key linking to the master test program entity.',
    `analysis_date` DATE COMMENT 'The analysis date associated with the coverage test record.',
    `atpg_tool` STRING COMMENT 'The atpg tool of the coverage record in the test domain.',
    `coverage_category` STRING COMMENT 'High‑level category of coverage measured (functional, parametric, structural, timing).. Valid values are `functional|parametric|structural|timing`',
    `comments` STRING COMMENT 'Free‑form notes or observations about the coverage run.',
    `correlation_score` DECIMAL(18,2) COMMENT 'Score indicating correlation between wafer‑level and package‑level test results.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coverage record was first created in the system.',
    `coverage_date` DATE COMMENT 'Calendar date on which the coverage metrics were measured.',
    `defect_density` DECIMAL(18,2) COMMENT 'Number of defects per unit area observed during testing.',
    `detected_fault_count` BIGINT COMMENT 'The detected fault count of the coverage record in the test domain.',
    `detected_faults` BIGINT COMMENT 'The detected faults of the coverage record in the test domain.',
    `device_type` STRING COMMENT 'Logical classification of the device (e.g., ASIC, SoC, FPGA) for which coverage is measured.',
    `dft_structure_coverage_percent` DECIMAL(18,2) COMMENT 'Coverage of DFT structures such as scan chains, BIST, and boundary‑scan.',
    `fault_count` BIGINT COMMENT 'The fault count of the coverage record in the test domain.',
    `fault_coverage_percent` DECIMAL(18,2) COMMENT 'Overall percentage of detectable faults covered by the test program.',
    `iddq_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of IDDQ (quiescent current) tests covered.',
    `is_approved` BOOLEAN COMMENT 'Indicates whether the coverage record has been formally approved.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the coverage level is critical for tapeout readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the coverage record in the test domain.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent formal review of the coverage data.',
    `measurement_method` STRING COMMENT 'The measurement method of the coverage record in the test domain.',
    `method` STRING COMMENT 'Method used to obtain coverage metrics.. Valid values are `simulation|silicon|mixed`',
    `path_delay_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of timing paths meeting delay specifications.',
    `percent` DECIMAL(18,2) COMMENT 'The percent of the coverage record in the test domain.',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the coverage record.. Valid values are `draft|active|retired`',
    `stuck_at_fault_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of stuck‑at faults covered.',
    `tapeout_ready` BOOLEAN COMMENT 'True if the coverage meets the tapeout release criteria.',
    `target_percent` DECIMAL(18,2) COMMENT 'The target percent of the coverage record in the test domain.',
    `test_program_version` STRING COMMENT 'Version identifier of the test program associated with this coverage record.',
    `tool` STRING COMMENT 'Name of the software tool used to generate coverage metrics.',
    `tool_version` STRING COMMENT 'Version identifier of the coverage analysis tool.',
    `total_faults` BIGINT COMMENT 'Total number of fault models considered for coverage analysis.',
    `transition_fault_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of transition‑faults covered.',
    `coverage_type` STRING COMMENT 'The type of the coverage record in the test domain.',
    `units` STRING COMMENT 'Units for coverage metrics, typically percent.',
    `untestable_fault_count` STRING COMMENT 'Number of faults that cannot be tested with the current program.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the coverage record.',
    `version_number` STRING COMMENT 'Sequential version number for the coverage record.',
    `yield_estimate_percent` DECIMAL(18,2) COMMENT 'Projected silicon yield based on current coverage levels.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_coverage PRIMARY KEY(`coverage_id`)
) COMMENT 'Master record tracking test coverage metrics for each test program version by device type. Captures fault coverage percentage, stuck-at fault coverage, transition fault coverage, path delay coverage, IDDQ coverage, DFT structure coverage (scan chains, BIST, boundary scan), and untestable fault count. Links test program to design DFT intent and supports tapeout readiness reviews.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` (
    `reliability_test_run_id` BIGINT COMMENT 'System-generated unique identifier for each reliability test run record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Warranty & Reliability Reporting: reliability test outcomes are linked to the customer account for warranty claims and reliability guarantees.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE, probe station) used for the run.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot from which the tested devices were drawn.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Reliability test runs must be linked to the IC catalog entry to track long‑term performance and warranty metrics per product.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Reliability test runs are executed on a specific inventory wafer lot; linking enables lot-level reliability tracking.',
    `test_program_id` BIGINT COMMENT 'FK to test.test_program.test_program_id — Reliability test executions (including burn-in) reference test programs for pre/post stress testing.',
    `employee_id` BIGINT COMMENT 'Identifier of the personnel who initiated or supervised the test run.',
    `reliability_operator_employee_id` BIGINT COMMENT 'Unique identifier for the reliability operator employee record within the reliability test run test entity.',
    `reliability_test_program_id` BIGINT COMMENT 'Unique identifier for the reliability test program record within the reliability test run test entity.',
    `acceleration_factor` DOUBLE COMMENT 'Factor used to extrapolate stress results to normal operating conditions.',
    `bias_condition` STRING COMMENT 'Electrical bias applied to the device (e.g., Vdd=1.2V, ground), described in free text.',
    `burn_in_board_code` STRING COMMENT 'Identifier of the burn‑in board or fixture used for the test.',
    `compliance_standard` STRING COMMENT 'Applicable industry standard or specification (e.g., JEDEC JESD47) governing the test.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test run record was first created in the system.',
    `data_capture_rate_hz` DOUBLE COMMENT 'Sampling frequency of test data acquisition.',
    `duration_hours` STRING COMMENT 'Total time the device is subjected to the stress conditions, expressed in hours.',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp of the reliability test run record in the test domain.',
    `failure_count` STRING COMMENT 'Number of devices that failed during the test run.',
    `humidity_control_method` STRING COMMENT 'Method used to maintain humidity (e.g., saturated salt solution, humidifier).',
    `infant_mortality_rate` DOUBLE COMMENT 'Percentage of early‑life failures observed during the test.',
    `measurement_method` STRING COMMENT 'Technique used to capture test data (e.g., ATE, probe).',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the operator.',
    `post_stress_yield_percent` DOUBLE COMMENT 'Yield percentage measured after stress exposure.',
    `pre_stress_yield_percent` DOUBLE COMMENT 'Yield percentage measured before applying stress.',
    `qualification_status` STRING COMMENT 'Result of the qualification assessment per JEDEC standards.. Valid values are `qualified|conditionally_qualified|rejected|pending`',
    `run_status` STRING COMMENT 'The run status of the reliability test run record in the test domain.',
    `sample_size` STRING COMMENT 'Number of individual devices (dies) included in the test run.',
    `screen_effectiveness_percent` DOUBLE COMMENT 'Effectiveness of the stress screen in removing latent defects, expressed as a percentage.',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the reliability test run record in the test domain.',
    `stress_humidity_percent` DOUBLE COMMENT 'Relative humidity level maintained during the stress test, expressed as a percentage.',
    `stress_mode` STRING COMMENT 'Pattern of stress application during the run.. Valid values are `constant|cyclic|step`',
    `stress_temperature_c` DECIMAL(18,2) COMMENT 'Maximum temperature applied during the stress phase, expressed in degrees Celsius.',
    `stress_type` STRING COMMENT 'The stress type of the reliability test run record in the test domain.',
    `stress_voltage_v` DECIMAL(18,2) COMMENT 'Voltage level applied to the device under test during stress, expressed in volts.',
    `temperature_c` STRING COMMENT 'The temperature c of the reliability test run record in the test domain.',
    `temperature_ramp_rate_c_per_min` DOUBLE COMMENT 'Rate at which temperature was increased during ramp‑up.',
    `test_batch_code` STRING COMMENT 'Identifier grouping multiple test runs executed as a batch.',
    `test_data_file_path` STRING COMMENT 'File system path or URI to the raw test data file.',
    `test_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the stress phase completed.',
    `test_failure_mode` STRING COMMENT 'Category of failure observed during the test.. Valid values are `parametric|functional|both`',
    `test_failure_rate_percent` DOUBLE COMMENT 'Percentage of devices that failed out of the sample.',
    `test_location` STRING COMMENT 'Physical location or fab where the test was performed.',
    `test_program_version` STRING COMMENT 'Version of the test program or script executed.',
    `test_result_file_hash` STRING COMMENT 'Hash (e.g., SHA‑256) of the test result file for integrity verification.',
    `test_result_summary` STRING COMMENT 'High‑level textual summary of the test outcome (e.g., PASS, FAIL, PARTIAL).',
    `test_run_number` STRING COMMENT 'Human‑readable business identifier assigned to the test run (e.g., TRT‑20230915‑001).',
    `test_standard` STRING COMMENT 'The test standard of the reliability test run record in the test domain.',
    `test_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the stress phase began.',
    `test_status` STRING COMMENT 'Current operational state of the test run.. Valid values are `scheduled|running|completed|failed|cancelled`',
    `test_type` STRING COMMENT 'Specifies the category of reliability stress applied during the run.. Valid values are `htol|hast|esd|latch_up|electromigration|burn_in`',
    `test_yield_improvement_percent` DOUBLE COMMENT 'Improvement in yield attributable to the stress screening.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test run record.',
    `voltage_ramp_rate_v_per_sec` DOUBLE COMMENT 'Rate at which voltage was increased during ramp‑up.',
    CONSTRAINT pk_reliability_test_run PRIMARY KEY(`reliability_test_run_id`)
) COMMENT 'Transactional record for reliability, qualification, and burn-in stress screening test executions. Covers HTOL, HAST, ESD, latch-up, electromigration, and burn-in stress screens. Captures test type, stress conditions (temperature, voltage, humidity, bias), duration, sample size, device lot, burn-in board ID, failure count, acceleration factor, pre/post-stress test results, infant mortality rate, screen effectiveness, and qualification status per JEDEC standards. Consolidates all reliability and stress screening operations into a single transactional record.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` (
    `correlation_study_id` BIGINT COMMENT 'System-generated unique identifier for the correlation study record.',
    `ate_configuration_id` BIGINT COMMENT 'Unique identifier for the correlation reference ate configuration record within the correlation study test entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record within the correlation study test entity.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Correlation studies compare test data to design simulations; they must reference the originating IC design project for accurate analysis.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Required for Correlation Study Traceability: associates each study with the Material Master record of the device under test, supporting regulatory reporting and root‑cause analysis.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Correlation studies are conducted within a research project; linking provides traceability for analysis reports and IP filing decisions.',
    `target_ate_configuration_id` BIGINT COMMENT 'Unique identifier for the target ate configuration record within the correlation study test entity.',
    `test_program_id` BIGINT COMMENT 'FK to test.test_program.test_program_id — Correlation studies compare results between wafer probe and final test programs. Must reference both program versions being correlated.',
    `approval_date` DATE COMMENT 'Date on which the study was formally approved for use.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level (e.g., 95.00) associated with the study results.',
    `correlation_coefficient` DECIMAL(18,2) COMMENT 'Numeric coefficient (e.g., Pearson r) representing strength of correlation for each parameter.',
    `correlation_methodology` STRING COMMENT 'Statistical or analytical method used to derive the correlation.. Valid values are `linear|nonlinear|multivariate|machine_learning`',
    `cpk_impact` DECIMAL(18,2) COMMENT 'Impact on process capability index (Cpk) resulting from the correlation adjustment.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the correlation study record in the test domain.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the study record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date after which the study must be revalidated or retired.',
    `guard_band_recommendation` STRING COMMENT 'Suggested guard‑band values for test limits based on study findings.',
    `insertion_pair` STRING COMMENT 'Description of the two test insertions being correlated (e.g., wafer‑probe vs final‑test).',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the study contains confidential information that requires restricted handling.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the study record.',
    `notes` STRING COMMENT 'Free‑form comments, observations, or special considerations captured by the study owner.',
    `offset_value` DECIMAL(18,2) COMMENT 'The offset value of the correlation study record in the test domain.',
    `parameter_count` STRING COMMENT 'Number of distinct test parameters included in the correlation analysis.',
    `parameter_name` STRING COMMENT 'The parameter name of the correlation study record in the test domain.',
    `sample_size` STRING COMMENT 'Number of devices or test points used in the study.',
    `correlation_study_status` STRING COMMENT 'Current lifecycle status of the study.. Valid values are `draft|active|completed|archived`',
    `study_code` STRING COMMENT 'External business code or identifier assigned to the study (e.g., SOP‑CS‑2024‑001).',
    `study_date` DATE COMMENT 'The study date associated with the correlation study test record.',
    `study_name` STRING COMMENT 'Human‑readable name of the study used for reporting and search.',
    `study_status` STRING COMMENT 'The study status of the correlation study record in the test domain.',
    `study_type` STRING COMMENT 'Classification of the study methodology: parametric, functional, or combined.. Valid values are `parametric|functional|combined`',
    `systematic_offset` DECIMAL(18,2) COMMENT 'Measured systematic offset between the two test insertions.',
    `test_platform` STRING COMMENT 'Name or identifier of the ATE platform used (e.g., Advantest V93000).',
    `test_site` STRING COMMENT 'Physical location or fab where the test was performed.',
    `version` STRING COMMENT 'Incremental version number of the study record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the study record.',
    CONSTRAINT pk_correlation_study PRIMARY KEY(`correlation_study_id`)
) COMMENT 'Master record for test correlation studies comparing results across different test insertions, ATE platforms, or test sites. Primarily supports wafer-probe-to-final-test correlation for KGD qualification and test cost reduction, but also covers tester-to-tester correlation, site-to-site correlation, and multi-insertion guard-band optimization. Captures study name, device type, correlation methodology (parametric, functional, combined), insertion pair under study, correlation coefficient by parameter, systematic offset values, Cpk impact analysis, guard-band recommendations, sample size and confidence level, study status, approval date, and expiration/revalidation schedule. Enables test program optimization, probe-only shipping decisions, and OSAT transfer qualification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`insertion` (
    `insertion_id` BIGINT COMMENT 'System-generated unique identifier for the test insertion definition.',
    `process_flow_id` BIGINT COMMENT 'add column process_flow_id (BIGINT) with FK to process.process_flow.process_flow_id - test insertions occur at specific points in process flows',
    `test_program_id` BIGINT COMMENT 'FK to test.test_program',
    `ate_platform_type` STRING COMMENT 'Type of Automatic Test Equipment platform required.. Valid values are `standard|custom|legacy`',
    `bin_mapping_reference` STRING COMMENT 'Identifier of the binning scheme applied to test results at this insertion.',
    `insertion_code` STRING COMMENT 'Unique alphanumeric code used to reference the insertion within the test flow.',
    `conditional_flag` BOOLEAN COMMENT 'Indicates the insertion is executed only when specific pre‑conditions are met.',
    `correlation_study_flag` BOOLEAN COMMENT 'Indicates whether data from this insertion is used in wafer‑to‑package correlation studies.',
    `cost_per_unit_usd` DECIMAL(18,2) COMMENT 'Estimated cost incurred for each unit processed at this insertion.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the insertion record was first created.',
    `effective_from` DATE COMMENT 'Date when the insertion definition becomes active in the test flow.',
    `effective_until` DATE COMMENT 'Date when the insertion definition is retired; null if still active.',
    `expected_yield_percent` DECIMAL(18,2) COMMENT 'The expected yield percent of the insertion record in the test domain.',
    `handler_requirement` STRING COMMENT 'Specifies the handler or prober needed for the insertion.. Valid values are `wafer_prober|die_handler|none`',
    `is_active` BOOLEAN COMMENT 'The is active of the insertion record in the test domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the insertion record in the test domain.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the insertion must be executed for every device.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Highest temperature allowed during the insertion test.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Lowest temperature allowed during the insertion test.',
    `insertion_name` STRING COMMENT 'Human‑readable name of the test insertion step (e.g., wafer probe, die sort).',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the insertion.',
    `optional_flag` BOOLEAN COMMENT 'Indicates whether the insertion can be skipped without affecting product qualification.',
    `sequence` STRING COMMENT 'The sequence of the insertion record in the test domain.',
    `sequence_order` STRING COMMENT 'Ordinal position of the insertion in the overall test flow.',
    `skip_rule_description` STRING COMMENT 'Human‑readable rule that defines when this insertion may be skipped.',
    `insertion_status` STRING COMMENT 'Current lifecycle status of the insertion definition.. Valid values are `active|inactive|deprecated|planned`',
    `temperature_c` DECIMAL(18,2) COMMENT 'The temperature c of the insertion record in the test domain.',
    `temperature_condition` STRING COMMENT 'The temperature condition of the insertion record in the test domain.',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of functional or parametric coverage provided by this insertion.',
    `test_parameter_set` STRING COMMENT 'Name of the parameter set applied during the test program execution.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'The test temperature c of the insertion record in the test domain.',
    `test_time_budget_seconds` STRING COMMENT 'Maximum allowed test time for this insertion, in seconds.',
    `insertion_type` STRING COMMENT 'Category of the insertion step within the manufacturing test flow.. Valid values are `probe|sort|burn_in|final|slt|qa`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the insertion record.',
    `yield_gate_criteria_percent` DECIMAL(18,2) COMMENT 'Minimum pass‑rate percentage required to allow progression to the next step.',
    CONSTRAINT pk_insertion PRIMARY KEY(`insertion_id`)
) COMMENT 'Reference master defining the complete test insertion architecture for each device type within the manufacturing flow. Captures insertion name (wafer probe, die sort, pre-burn-in, burn-in, post-burn-in, final test, SLT, outgoing QA), sequence order in the flow, mandatory vs. optional vs. conditional flag, assigned test program reference, required ATE platform type, handler/prober requirement, yield gate criteria (minimum pass rate to proceed), test time budget allocation, cost per unit at this insertion, and insertion-level skip rules. SSOT for the test flow architecture governing which tests are performed at which manufacturing stage, in what sequence, and under what conditions. Critical for test cost modeling and flow optimization.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` (
    `adaptive_test_flow_id` BIGINT COMMENT 'System-generated unique identifier for each adaptive test flow configuration.',
    `correlation_study_id` BIGINT COMMENT 'Foreign key linking to test.correlation_study. Business justification: Adaptive test flow references a correlation study; replace string reference with FK to correlation_study for referential integrity.',
    `fallback_adaptive_test_flow_id` BIGINT COMMENT 'Self-referencing FK on adaptive_test_flow (fallback_adaptive_test_flow_id)',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Adaptive test flows are generated per process flow to optimize test time; the Adaptive Flow Configuration tool needs this FK.',
    `test_program_id` BIGINT COMMENT 'FK to test.test_program.test_program_id — Adaptive test flows modify the execution of a base test program. Must reference which program the adaptive rules apply to.',
    `action_type` STRING COMMENT 'The action type of the adaptive test flow record in the test domain.',
    `adaptive_flow_at_insertion` BIGINT COMMENT 'FK to test.test_insertion.test_insertion_id — Adaptive test rules are applied at specific test insertion points in the manufacturing flow.',
    `adaptive_rule_set` STRING COMMENT 'JSON or XML representation of the adaptive rules (skip rules, limit adjustments, ordering logic).',
    `audit_trail` STRING COMMENT 'JSON log of significant changes to the flow configuration for compliance auditing.',
    `compliance_standard` STRING COMMENT 'Applicable industry or regulatory standard governing the test flow.. Valid values are `SEMI|JEDEC|ISO9001|ISO14001`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the flow record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level for the flow record as defined by corporate data policy.. Valid values are `restricted|confidential|internal|public`',
    `decision_rule` STRING COMMENT 'The decision rule of the adaptive test flow record in the test domain.',
    `adaptive_test_flow_description` STRING COMMENT 'Detailed description of the flow logic, purpose, and scope.',
    `effective_date` DATE COMMENT 'The effective date associated with the adaptive test flow test record.',
    `effective_from` DATE COMMENT 'Date on which the flow becomes active for use.',
    `effective_until` DATE COMMENT 'Date on which the flow is retired or superseded (null if open‑ended).',
    `effectiveness_metric` STRING COMMENT 'Primary metric used to evaluate the adaptive flows success.. Valid values are `yield_improvement|time_savings|defect_reduction`',
    `flow_code` STRING COMMENT 'Short alphanumeric code used to reference the flow in systems and reports.',
    `flow_name` STRING COMMENT 'Human‑readable name describing the adaptive test flow.',
    `flow_status` STRING COMMENT 'The flow status of the adaptive test flow record in the test domain.',
    `flow_type` STRING COMMENT 'Indicates whether the flow is fully adaptive, static, or a hybrid of both.. Valid values are `adaptive|static|hybrid`',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the flow has been deprecated and should no longer be used.',
    `last_evaluation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent performance evaluation of the flow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the adaptive test flow record in the test domain.',
    `limit_adjustment_strategy` STRING COMMENT 'Strategy used to tighten or loosen test limits based on inline data.',
    `ml_model_name` STRING COMMENT 'Name of the predictive model referenced for test optimization.',
    `ml_model_reference` STRING COMMENT 'The ml model reference of the adaptive test flow record in the test domain.',
    `ml_model_version` STRING COMMENT 'Version identifier of the referenced ML model.',
    `multi_site_optimization_params` STRING COMMENT 'Parameters governing test flow distribution across multiple test sites.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `predictive_model_reference` STRING COMMENT 'Reference identifier linking to the predictive analytics model used.',
    `quality_escape_risk_threshold` DECIMAL(18,2) COMMENT 'Maximum acceptable risk of defective dies escaping test, expressed as a percentage.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score representing overall risk associated with the flow configuration.',
    `rule_evaluation_logic` STRING COMMENT 'Description of how adaptive rules are evaluated (e.g., priority order, conflict resolution).',
    `skip_rule_description` STRING COMMENT 'Human‑readable description of conditions under which tests may be skipped.',
    `adaptive_test_flow_status` STRING COMMENT 'Current lifecycle status of the flow configuration.. Valid values are `active|inactive|deprecated|pending`',
    `test_order_optimization` STRING COMMENT 'Parameters that define the optimal sequencing of test items.',
    `test_time_reduction_target_percent` DECIMAL(18,2) COMMENT 'Target percentage reduction in overall test time compared to baseline.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value of the adaptive test flow record in the test domain.',
    `trigger_condition` STRING COMMENT 'The trigger condition of the adaptive test flow record in the test domain.',
    `trigger_conditions` STRING COMMENT 'Logical conditions that activate the adaptive flow (e.g., prior bin result, parametric thresholds).',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the flow record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the flow record.',
    `version` STRING COMMENT 'Version identifier for change management and release tracking.',
    `created_by` STRING COMMENT 'User identifier of the person who created the flow record.',
    CONSTRAINT pk_adaptive_test_flow PRIMARY KEY(`adaptive_test_flow_id`)
) COMMENT 'Master record defining adaptive and intelligent test flow configurations that dynamically adjust test content based on prior test results, inline parametric data, or predictive models. Captures adaptive rule sets (skip rules, test ordering optimization, limit tightening/loosening), triggering conditions, ML model references for predictive test, multi-site optimization parameters, test time reduction targets, quality escape risk thresholds, and effectiveness metrics. Supports modern test methodologies including good-die-bad-die classification, adaptive limit setting, and AI-driven test optimization programs. SSOT for all dynamic test flow logic that modifies standard test program execution based on real-time or historical data.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` (
    `program_assignment_id` BIGINT COMMENT 'Primary key',
    `ate_configuration_id` BIGINT COMMENT 'FK to ATE configuration',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `inventory_wafer_lot_id` BIGINT COMMENT 'FK to inventory wafer lot',
    `employee_id` BIGINT COMMENT 'Unique identifier for the program approved by employee record within the program assignment test entity.',
    `program_assigned_by_employee_id` BIGINT COMMENT 'FK to assigning employee',
    `program_employee_id` BIGINT COMMENT 'FK to employee',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the program assignment test entity.',
    `test_program_id` BIGINT COMMENT 'FK to test program',
    `active_flag` BOOLEAN COMMENT 'The active flag of the program assignment record in the test domain.',
    `actual_test_time_sec` STRING COMMENT 'The actual test time sec of the program assignment record in the test domain.',
    `assigned_by` STRING COMMENT 'The assigned by of the program assignment record in the test domain.',
    `assignment_date` DATE COMMENT 'The assignment date associated with the program assignment test record.',
    `assignment_notes` STRING COMMENT 'The assignment notes of the program assignment record in the test domain.',
    `assignment_priority` STRING COMMENT 'The assignment priority of the program assignment record in the test domain.',
    `assignment_status` STRING COMMENT 'The assignment status of the program assignment record in the test domain.',
    `assignment_type` STRING COMMENT 'The assignment type of the program assignment record in the test domain.',
    `coverage_target_pct` DECIMAL(18,2) COMMENT 'The coverage target pct of the program assignment record in the test domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the program assignment record in the test domain.',
    `effective_date` DATE COMMENT 'The effective date associated with the program assignment test record.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the program assignment test record.',
    `effective_from` DATE COMMENT 'The effective from of the program assignment record in the test domain.',
    `effective_revision` STRING COMMENT 'The effective revision of the program assignment record in the test domain.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the program assignment test record.',
    `effective_until` DATE COMMENT 'The effective until of the program assignment record in the test domain.',
    `end_date` DATE COMMENT 'The end date associated with the program assignment test record.',
    `estimated_test_time_sec` STRING COMMENT 'The estimated test time sec of the program assignment record in the test domain.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the program assignment test record.',
    `insertion_point` STRING COMMENT 'The insertion point of the program assignment record in the test domain.',
    `insertion_sequence` STRING COMMENT 'Insertion sequence number',
    `insertion_stage` STRING COMMENT 'The insertion stage of the program assignment record in the test domain.',
    `insertion_type` STRING COMMENT 'The insertion type of the program assignment record in the test domain.',
    `is_active` BOOLEAN COMMENT 'Whether assignment is active',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the program assignment record in the test domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the program assignment record in the test domain.',
    `notes` STRING COMMENT 'The notes of the program assignment record in the test domain.',
    `override_reason` STRING COMMENT 'The override reason of the program assignment record in the test domain.',
    `priority` STRING COMMENT 'The priority of the program assignment record in the test domain.',
    `priority_level` STRING COMMENT 'The priority level of the program assignment record in the test domain.',
    `program_version` STRING COMMENT 'The program version of the program assignment record in the test domain.',
    `qualification_status` STRING COMMENT 'The qualification status of the program assignment record in the test domain.',
    `program_assignment_status` STRING COMMENT 'Program assignment status',
    `test_insertion_type` STRING COMMENT 'The test insertion type of the program assignment record in the test domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the program assignment record in the test domain.',
    `yield_target_pct` DECIMAL(18,2) COMMENT 'The yield target pct of the program assignment record in the test domain.',
    CONSTRAINT pk_program_assignment PRIMARY KEY(`program_assignment_id`)
) COMMENT 'This association product represents the assignment of a test program to a wafer lot. It captures when the program was scheduled for the lot and the current status of that assignment. Each record links one test_program to one inventory_wafer_lot.. Existence Justification: In semiconductor fabs, each wafer lot can be tested with multiple test programs over its lifecycle, and each test program is applied to many wafer lots. The scheduling of these programs is managed as a distinct assignment record that captures the assignment date and status. Humans create, update, and delete these assignment records as part of the test planning process.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`test_case` (
    `test_case_id` BIGINT COMMENT 'Primary key for test_case',
    `ic_catalog_id` BIGINT COMMENT 'add column ic_catalog_id (BIGINT) with FK to product.ic_catalog.ic_catalog_id - test cases validate specific products',
    `parent_test_case_id` BIGINT COMMENT 'Self-referencing FK on test_case (parent_test_case_id)',
    `test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Test cases belong to a test program; adding test_program_id FK eliminates silo and enables navigation.',
    `bin_mapping_version` STRING COMMENT 'Version identifier for the binning scheme associated with this test case.',
    `test_case_category` STRING COMMENT 'Level at which the test is applied, such as wafer‑level, die‑level, package‑level, or system‑level.',
    `test_case_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the test case within the test management system.',
    `coverage_percent` DECIMAL(18,2) COMMENT 'Proportion of functional or parametric specifications covered by this test case.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the test case record was first created in the system.',
    `default_duration_seconds` STRING COMMENT 'Standard execution time expected for the test case, in seconds.',
    `test_case_description` STRING COMMENT 'Free‑form description of the test purpose, methodology, and any special considerations.',
    `effective_from` DATE COMMENT 'Date when the test case becomes valid for use in production.',
    `effective_until` DATE COMMENT 'Date after which the test case is no longer valid; null if open‑ended.',
    `execution_order` STRING COMMENT 'The execution order of the test case record in the test domain.',
    `expected_result` STRING COMMENT 'The expected result of the test case record in the test domain.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the test case is executed automatically by ATE without manual intervention.',
    `is_critical` BOOLEAN COMMENT 'The is critical of the test case record in the test domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the test case record in the test domain.',
    `test_case_name` STRING COMMENT 'Human‑readable name of the test case used in reports and dashboards.',
    `owner` STRING COMMENT 'Name of the engineering group or individual responsible for maintaining the test case.',
    `priority` STRING COMMENT 'Business priority indicating the importance of the test case for production release.',
    `required_equipment` STRING COMMENT 'List of ATE or probe stations required to execute the test case.',
    `specification_url` STRING COMMENT 'Link to the detailed test specification document stored in the PLM system.',
    `test_case_status` STRING COMMENT 'Current lifecycle state of the test case definition.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Desired yield percentage that the test case aims to achieve.',
    `test_category` STRING COMMENT 'The test category of the test case record in the test domain.',
    `test_case_type` STRING COMMENT 'Category of test performed, indicating the nature of the measurement or stimulus.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the test case record.',
    CONSTRAINT pk_test_case PRIMARY KEY(`test_case_id`)
) COMMENT 'Master reference table for test_case. Referenced by test_case_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`test`.`test_step` (
    `test_step_id` BIGINT COMMENT 'Primary key for test_step',
    `limit_id` BIGINT COMMENT 'Unique identifier for the limit record within the test step test entity.',
    `prerequisite_test_step_id` BIGINT COMMENT 'Self-referencing FK on test_step (prerequisite_test_step_id)',
    `test_case_id` BIGINT COMMENT 'Unique identifier for the test case record within the test step test entity.',
    `test_program_id` BIGINT COMMENT 'Identifier of the test program that includes this step.',
    `bin_mapping_required` BOOLEAN COMMENT 'True if the steps result must be mapped to a yield bin.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the test step record was first created in the system.',
    `default_duration_seconds` STRING COMMENT 'Typical execution time for the step when run under standard conditions.',
    `effective_from` DATE COMMENT 'Date from which the test step definition is valid for use.',
    `effective_until` DATE COMMENT 'Date after which the test step definition is retired (null if indefinite).',
    `equipment_required` STRING COMMENT 'Identifier of the ATE or fixture needed to execute the step.',
    `expected_value` DECIMAL(18,2) COMMENT 'The expected value of the test step record in the test domain.',
    `force_unit` STRING COMMENT 'The force unit of the test step record in the test domain.',
    `force_value` DECIMAL(18,2) COMMENT 'The force value of the test step record in the test domain.',
    `is_critical` BOOLEAN COMMENT 'True if failure of this step causes the entire test to be aborted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the test step record in the test domain.',
    `measure_unit` STRING COMMENT 'The measure unit of the test step record in the test domain.',
    `measurement_type` STRING COMMENT 'The measurement type of the test step record in the test domain.',
    `measurement_unit` STRING COMMENT 'Unit of the primary measurement captured by the step.',
    `pass_fail_criteria` STRING COMMENT 'Rule or threshold that determines whether the step passes or fails.',
    `step_action` STRING COMMENT 'The step action of the test step record in the test domain.',
    `step_category` STRING COMMENT 'Phase of the overall test flow where the step occurs.',
    `step_code` STRING COMMENT 'Compact alphanumeric code that uniquely identifies the step within a test program.',
    `step_description` STRING COMMENT 'Detailed description of the purpose, methodology, and expected outcome of the step.',
    `step_name` STRING COMMENT 'Human‑readable name of the test step as used in test programs and reports.',
    `step_number` STRING COMMENT 'The step number of the test step record in the test domain.',
    `step_order` STRING COMMENT 'Zero‑based sequence number indicating the steps position in the test program.',
    `step_sequence` STRING COMMENT 'The step sequence of the test step record in the test domain.',
    `step_status` STRING COMMENT 'The step status of the test step record in the test domain.',
    `step_type` STRING COMMENT 'Category of the test step based on its functional purpose.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the test step record.',
    CONSTRAINT pk_test_step PRIMARY KEY(`test_step_id`)
) COMMENT 'Master reference table for test_step. Referenced by test_step_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ADD CONSTRAINT `fk_test_test_program_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_correlation_study_id` FOREIGN KEY (`correlation_study_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`correlation_study`(`correlation_study_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_primary_wafer_probe_card_id` FOREIGN KEY (`primary_wafer_probe_card_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`probe_card`(`probe_card_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_primary_wafer_test_program_id` FOREIGN KEY (`primary_wafer_test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_probe_card_id` FOREIGN KEY (`probe_card_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`probe_card`(`probe_card_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_primary_bin_definition_id` FOREIGN KEY (`primary_bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_primary_final_test_program_id` FOREIGN KEY (`primary_final_test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_limit_id` FOREIGN KEY (`limit_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`limit`(`limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_parametric_unit_test_result_id` FOREIGN KEY (`parametric_unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_test_step_id` FOREIGN KEY (`test_step_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_step`(`test_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_test_case_id` FOREIGN KEY (`test_case_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_case`(`test_case_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_reliability_test_program_id` FOREIGN KEY (`reliability_test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ADD CONSTRAINT `fk_test_correlation_study_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ADD CONSTRAINT `fk_test_correlation_study_target_ate_configuration_id` FOREIGN KEY (`target_ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ADD CONSTRAINT `fk_test_correlation_study_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ADD CONSTRAINT `fk_test_insertion_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ADD CONSTRAINT `fk_test_adaptive_test_flow_correlation_study_id` FOREIGN KEY (`correlation_study_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`correlation_study`(`correlation_study_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ADD CONSTRAINT `fk_test_adaptive_test_flow_fallback_adaptive_test_flow_id` FOREIGN KEY (`fallback_adaptive_test_flow_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`adaptive_test_flow`(`adaptive_test_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ADD CONSTRAINT `fk_test_adaptive_test_flow_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ADD CONSTRAINT `fk_test_program_assignment_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ADD CONSTRAINT `fk_test_program_assignment_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ADD CONSTRAINT `fk_test_test_case_parent_test_case_id` FOREIGN KEY (`parent_test_case_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_case`(`test_case_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ADD CONSTRAINT `fk_test_test_case_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ADD CONSTRAINT `fk_test_test_step_limit_id` FOREIGN KEY (`limit_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`limit`(`limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ADD CONSTRAINT `fk_test_test_step_prerequisite_test_step_id` FOREIGN KEY (`prerequisite_test_step_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_step`(`test_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ADD CONSTRAINT `fk_test_test_step_test_case_id` FOREIGN KEY (`test_case_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_case`(`test_case_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ADD CONSTRAINT `fk_test_test_step_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`test_program`(`test_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`test` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`test` SET TAGS ('dbx_domain' = 'test');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `actual_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `ate_platform` SET TAGS ('dbx_business_glossary_term' = 'ATE Platform');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `ate_platform` SET TAGS ('dbx_value_regex' = 'ATE_9000|ATE_9500|ATE_10000|Custom');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `atpg_tool` SET TAGS ('dbx_business_glossary_term' = 'ATPG Tool');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `bin_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `correlation_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `coverage_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_program_name` SET TAGS ('dbx_business_glossary_term' = 'Test Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Test Program Owner');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `parametric_test_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Data Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'functional|structural|parametric|mixed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Test Program Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `related_pcn_eco` SET TAGS ('dbx_business_glossary_term' = 'Related PCN/ECO');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `target_device` SET TAGS ('dbx_business_glossary_term' = 'Target Device');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `target_device_family` SET TAGS ('dbx_business_glossary_term' = 'Target Device Family');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_coverage_metric` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Metric');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_coverage_metric` SET TAGS ('dbx_value_regex' = 'fault_coverage|code_coverage|timing_coverage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'lab|production|prototype');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Units');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'wafer_probe|die_sort|final_test|burn_in|slit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'draft|validated|released|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Version Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` SET TAGS ('dbx_subdomain' = 'equipment_configuration');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'ATE Configuration Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ALTER COLUMN `ate_platform` SET TAGS ('dbx_business_glossary_term' = 'Ate Platform');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Prober Tool Identifier (APTI)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date (QD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|failed|rejected|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification (SC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c|class_d|class_e|class_f');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `serial` SET TAGS ('dbx_business_glossary_term' = 'Serial');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Serial Number (PCS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_status` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Lifecycle Status (PCS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|decommissioned|qualified|failed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `supplier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name (SN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `touchdown_count` SET TAGS ('dbx_business_glossary_term' = 'Touchdown Count per Test (TC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_type` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Type (PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `probe_card_type` SET TAGS ('dbx_value_regex' = 'cantilever|vertical|mems|advanced|custom|other');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `usage_hours` SET TAGS ('dbx_business_glossary_term' = 'Usage Hours (UH)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WED)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_category` SET TAGS ('dbx_business_glossary_term' = 'Bin Category (BIN_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_category` SET TAGS ('dbx_value_regex' = 'pass|functional_fail|parametric_fail|contact_fail|leakage_fail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Code (BIN_CD)');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Bin Status (BIN_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `bin_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `test_level` SET TAGS ('dbx_business_glossary_term' = 'Test Level (TEST_LVL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `test_level` SET TAGS ('dbx_value_regex' = 'wafer|final|reliability');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UPD_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `yield_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Category');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `yield_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Classification (YLD_IMPACT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `yield_impact_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CRE_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `correlation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study ID (CORR_STUDY_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Prober Tool ID (PROBER_TOOL_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `primary_wafer_probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card ID (PROBE_CARD_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `primary_wafer_test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID (OPERATOR_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|failed|canceled');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percent (COVERAGE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count (TOTAL_DIE)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `total_die_tested` SET TAGS ('dbx_business_glossary_term' = 'Total Die Tested');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Sequence Number (WAFER_SEQ_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_role' = 'assigned_bin');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `primary_bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Bin Definition Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (LID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Operator (TO)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `primary_final_test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `ate_name` SET TAGS ('dbx_business_glossary_term' = 'Automatic Test Equipment Name (ATEN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `bin_distribution` SET TAGS ('dbx_business_glossary_term' = 'Bin Distribution (BD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `boot_success_count` SET TAGS ('dbx_business_glossary_term' = 'Boot Success Count (BSC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Test Run Comments (TRC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code (DC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp (TET)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `fail_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Count (FC)');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_status` SET TAGS ('dbx_business_glossary_term' = 'Test Run Status (TRS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ALTER COLUMN `final_test_run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parametric_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Parametric Measurement ID (PMID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Identifier (CAL_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier (EQP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Die Identifier (DIE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parametric_unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `parametric_wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (WAFER_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (OP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier (TP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `test_step_id` SET TAGS ('dbx_business_glossary_term' = 'Test Step Identifier (STEP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier (RES_ID)');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'parametric|functional|timing');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `product_revision` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `related_pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Related PCN Number');
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
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `test_step_id` SET TAGS ('dbx_business_glossary_term' = 'Test Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Limit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Limit Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`limit` ALTER COLUMN `version_history` SET TAGS ('dbx_business_glossary_term' = 'Version History');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Record Identifier (TC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Identifier (DT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `coverage_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By (RB)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier (TP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `atpg_tool` SET TAGS ('dbx_business_glossary_term' = 'Atpg Tool');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `coverage_category` SET TAGS ('dbx_business_glossary_term' = 'Coverage Category (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `coverage_category` SET TAGS ('dbx_value_regex' = 'functional|parametric|structural|timing');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Coverage Comments (CCOM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `correlation_score` SET TAGS ('dbx_business_glossary_term' = 'Coverage Correlation Score (CCS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `coverage_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Measurement Date (CMD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (DD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `detected_fault_count` SET TAGS ('dbx_business_glossary_term' = 'Detected Fault Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `detected_faults` SET TAGS ('dbx_business_glossary_term' = 'Detected Faults');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type (DT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `dft_structure_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'DFT Structure Coverage Percentage (DFTSCP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `fault_count` SET TAGS ('dbx_business_glossary_term' = 'Fault Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `fault_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Fault Coverage Percentage (FCP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `iddq_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'IDDQ Coverage Percentage (IDDQCP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `is_approved` SET TAGS ('dbx_business_glossary_term' = 'Approval Flag (AF)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Coverage Flag (CCF)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LRT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Coverage Determination Method (CDM)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'simulation|silicon|mixed');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `path_delay_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Path Delay Coverage Percentage (PDCP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `percent` SET TAGS ('dbx_business_glossary_term' = 'Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Record Status (CRS)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `stuck_at_fault_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Stuck‑at Fault Coverage Percentage (SAFCP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `tapeout_ready` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Readiness Flag (TRF)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `target_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version (TPV)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `tool` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Tool (CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `tool_version` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tool Version (CTV)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `total_faults` SET TAGS ('dbx_business_glossary_term' = 'Total Fault Count (TFC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `transition_fault_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Transition Fault Coverage Percentage (TFCP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `units` SET TAGS ('dbx_business_glossary_term' = 'Coverage Units (CU)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `untestable_fault_count` SET TAGS ('dbx_business_glossary_term' = 'Untestable Fault Count (UFC)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (RUB)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Coverage Record Version Number (CRVN)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `yield_estimate_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Estimate Percentage (YEP)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`coverage` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (RCB)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `reliability_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Run Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Device Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `reliability_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `reliability_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `reliability_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `reliability_test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `acceleration_factor` SET TAGS ('dbx_business_glossary_term' = 'Acceleration Factor');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `bias_condition` SET TAGS ('dbx_business_glossary_term' = 'Bias Condition');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `burn_in_board_code` SET TAGS ('dbx_business_glossary_term' = 'Burn‑In Board Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `data_capture_rate_hz` SET TAGS ('dbx_business_glossary_term' = 'Data Capture Rate (Hz)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Stress Duration (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Failure Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `humidity_control_method` SET TAGS ('dbx_business_glossary_term' = 'Humidity Control Method');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `infant_mortality_rate` SET TAGS ('dbx_business_glossary_term' = 'Infant Mortality Rate (%)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Run Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `post_stress_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Post‑Stress Yield (%)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `pre_stress_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Stress Yield (%)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditionally_qualified|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `screen_effectiveness_percent` SET TAGS ('dbx_business_glossary_term' = 'Screen Effectiveness (%)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `stress_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Stress Relative Humidity (%)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `stress_mode` SET TAGS ('dbx_business_glossary_term' = 'Stress Mode');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `stress_mode` SET TAGS ('dbx_value_regex' = 'constant|cyclic|step');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `stress_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Stress Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `stress_type` SET TAGS ('dbx_business_glossary_term' = 'Stress Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `stress_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Stress Voltage (V)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `temperature_ramp_rate_c_per_min` SET TAGS ('dbx_business_glossary_term' = 'Temperature Ramp Rate (°C/min)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_data_file_path` SET TAGS ('dbx_business_glossary_term' = 'Test Data File Path');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Test Failure Mode');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_failure_mode` SET TAGS ('dbx_value_regex' = 'parametric|functional|both');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_failure_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Failure Rate (%)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_result_file_hash` SET TAGS ('dbx_business_glossary_term' = 'Test Result File Hash');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Result Summary');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_run_number` SET TAGS ('dbx_business_glossary_term' = 'Test Run Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Standard');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|failed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Type (HTOL, HAST, ESD, Latch‑Up, Electromigration, Burn‑In)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'htol|hast|esd|latch_up|electromigration|burn_in');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `test_yield_improvement_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Improvement (%)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`reliability_test_run` ALTER COLUMN `voltage_ramp_rate_v_per_sec` SET TAGS ('dbx_business_glossary_term' = 'Voltage Ramp Rate (V/s)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `correlation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `target_ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Study Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `correlation_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Correlation Coefficient');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `correlation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Correlation Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `correlation_methodology` SET TAGS ('dbx_value_regex' = 'linear|nonlinear|multivariate|machine_learning');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `cpk_impact` SET TAGS ('dbx_business_glossary_term' = 'Cpk Impact');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Study Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Study Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `guard_band_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Guard‑Band Recommendation');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `insertion_pair` SET TAGS ('dbx_business_glossary_term' = 'Insertion Pair Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Study Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `offset_value` SET TAGS ('dbx_business_glossary_term' = 'Offset Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `parameter_count` SET TAGS ('dbx_business_glossary_term' = 'Parameter Count');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `correlation_study_status` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `correlation_study_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|archived');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `study_date` SET TAGS ('dbx_business_glossary_term' = 'Study Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'parametric|functional|combined');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `systematic_offset` SET TAGS ('dbx_business_glossary_term' = 'Systematic Offset Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `test_platform` SET TAGS ('dbx_business_glossary_term' = 'Test Platform');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `test_site` SET TAGS ('dbx_business_glossary_term' = 'Test Site');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Study Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`correlation_study` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `test_program_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `ate_platform_type` SET TAGS ('dbx_business_glossary_term' = 'ATE Platform Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `ate_platform_type` SET TAGS ('dbx_value_regex' = 'standard|custom|legacy');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `bin_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `insertion_code` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `conditional_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditional Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `correlation_study_flag` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `cost_per_unit_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `expected_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `handler_requirement` SET TAGS ('dbx_business_glossary_term' = 'Handler Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `handler_requirement` SET TAGS ('dbx_value_regex' = 'wafer_prober|die_handler|none');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `insertion_name` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `optional_flag` SET TAGS ('dbx_business_glossary_term' = 'Optional Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `skip_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Skip Rule Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `insertion_status` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `insertion_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|planned');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `temperature_condition` SET TAGS ('dbx_business_glossary_term' = 'Temperature Condition');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `test_parameter_set` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Set');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `test_time_budget_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Time Budget (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `insertion_type` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `insertion_type` SET TAGS ('dbx_value_regex' = 'probe|sort|burn_in|final|slt|qa');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`insertion` ALTER COLUMN `yield_gate_criteria_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Gate Criteria (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `adaptive_test_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Test Flow Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `correlation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `fallback_adaptive_test_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fallback Adaptive Test Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `fallback_adaptive_test_flow_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `adaptive_flow_at_insertion` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Flow At Insertion');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `adaptive_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Rule Set Definition');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'SEMI|JEDEC|ISO9001|ISO14001');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `decision_rule` SET TAGS ('dbx_business_glossary_term' = 'Decision Rule');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `adaptive_test_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Test Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `effectiveness_metric` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Metric');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `effectiveness_metric` SET TAGS ('dbx_value_regex' = 'yield_improvement|time_savings|defect_reduction');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Test Flow Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Test Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_business_glossary_term' = 'Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Test Flow Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_value_regex' = 'adaptive|static|hybrid');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated Flag');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `last_evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `limit_adjustment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Limit Adjustment Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `ml_model_name` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning Model Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `ml_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Ml Model Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `ml_model_version` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning Model Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `multi_site_optimization_params` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Site Optimization Parameters');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `predictive_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Predictive Model Reference');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `quality_escape_risk_threshold` SET TAGS ('dbx_business_glossary_term' = 'Quality Escape Risk Threshold (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `rule_evaluation_logic` SET TAGS ('dbx_business_glossary_term' = 'Rule Evaluation Logic');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `skip_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Skip Rule Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `adaptive_test_flow_status` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Test Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `adaptive_test_flow_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `test_order_optimization` SET TAGS ('dbx_business_glossary_term' = 'Test Order Optimization');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `test_time_reduction_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Time Reduction Target (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Trigger Condition');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `trigger_conditions` SET TAGS ('dbx_business_glossary_term' = 'Trigger Conditions');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Test Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`adaptive_test_flow` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` SET TAGS ('dbx_association_edges' = 'test.test_program,inventory.inventory_wafer_lot');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_assigned_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_assigned_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_assigned_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `effective_revision` SET TAGS ('dbx_business_glossary_term' = 'Effective Revision');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `insertion_sequence` SET TAGS ('dbx_business_glossary_term' = 'Insertion Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `insertion_stage` SET TAGS ('dbx_business_glossary_term' = 'Insertion Stage');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `insertion_type` SET TAGS ('dbx_business_glossary_term' = 'Insertion Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Program Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `program_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `test_insertion_type` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `parent_test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Test Case Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `parent_test_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `bin_mapping_version` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Version');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_case_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_case_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Coverage Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `default_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Default Duration Seconds');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_case_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `execution_order` SET TAGS ('dbx_business_glossary_term' = 'Execution Order');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `expected_result` SET TAGS ('dbx_business_glossary_term' = 'Expected Result');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_case_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Owner');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `required_equipment` SET TAGS ('dbx_business_glossary_term' = 'Required Equipment');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `specification_url` SET TAGS ('dbx_business_glossary_term' = 'Specification Url');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_case_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `test_case_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `test_step_id` SET TAGS ('dbx_business_glossary_term' = 'Test Step Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `prerequisite_test_step_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Test Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `prerequisite_test_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `bin_mapping_required` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Required');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `default_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Default Duration Seconds');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `force_unit` SET TAGS ('dbx_business_glossary_term' = 'Force Unit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `force_value` SET TAGS ('dbx_business_glossary_term' = 'Force Value');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `measure_unit` SET TAGS ('dbx_business_glossary_term' = 'Measure Unit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `pass_fail_criteria` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_action` SET TAGS ('dbx_business_glossary_term' = 'Step Action');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_category` SET TAGS ('dbx_business_glossary_term' = 'Step Category');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_code` SET TAGS ('dbx_business_glossary_term' = 'Step Code');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_description` SET TAGS ('dbx_business_glossary_term' = 'Step Description');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Step Name');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Number');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_order` SET TAGS ('dbx_business_glossary_term' = 'Step Order');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `step_type` SET TAGS ('dbx_business_glossary_term' = 'Step Type');
ALTER TABLE `vibe_semiconductors_v1`.`test`.`test_step` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
