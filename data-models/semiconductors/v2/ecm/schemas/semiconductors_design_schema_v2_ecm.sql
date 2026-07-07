-- Schema for Domain: design | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`design` COMMENT 'IC design and architecture lifecycle from RTL specification through GDS/GDSII tapeout. Manages IP cores, PDK libraries, EDA tool flows, DFM and DFT rule sets, logic synthesis, physical design, timing closure data, and MPW shuttle assignments. Integrates with Cadence Virtuoso, Synopsys Design Compiler, and PrimeTime for design data provenance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` (
    `ic_design_project_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'FK to customer account',
    `cost_center_id` BIGINT COMMENT 'FK to finance cost center',
    `employee_id` BIGINT COMMENT 'FK to workforce employee',
    `export_license_id` BIGINT COMMENT 'FK to compliance export license',
    `supplier_id` BIGINT COMMENT 'FK to supply supplier',
    `ic_catalog_id` BIGINT COMMENT 'FK to product ic catalog',
    `internal_order_id` BIGINT COMMENT 'FK to finance internal order',
    `org_unit_id` BIGINT COMMENT 'FK to workforce org unit',
    `pdk_id` BIGINT COMMENT 'FK to design pdk',
    `process_flow_id` BIGINT COMMENT 'FK to process flow',
    `process_technology_node_id` BIGINT COMMENT 'FK to process technology node',
    `profit_center_id` BIGINT COMMENT 'FK to finance profit center',
    `research_program_id` BIGINT COMMENT 'FK to research program',
    `wbs_element_id` BIGINT COMMENT 'FK to finance wbs element',
    `block_count` STRING COMMENT 'Number of design blocks',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `design_phase` STRING COMMENT 'Current design phase',
    `design_type` STRING COMMENT 'Type of IC design',
    `dfm_rule_set_version` STRING COMMENT 'The dfm rule set version of the ic design project record in the design domain.',
    `dft_enabled` BOOLEAN COMMENT 'DFT enabled flag',
    `eda_tool_suite` STRING COMMENT 'EDA tool suite name',
    `eda_tool_version` STRING COMMENT 'The eda tool version of the ic design project record in the design domain.',
    `export_control_classification` STRING COMMENT 'The export control classification of the ic design project record in the design domain.',
    `gate_count_target_k` DECIMAL(18,2) COMMENT 'Target gate count in thousands',
    `gds_file_path` STRING COMMENT 'File system or storage gds file path for the ic design project design record.',
    `iatf_automotive_grade` BOOLEAN COMMENT 'IATF automotive grade flag',
    `ip_core_count` STRING COMMENT 'Number of IP cores',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `lithography_type` STRING COMMENT 'The lithography type of the ic design project record in the design domain.',
    `metal_layer_count` STRING COMMENT 'Number of metal layers',
    `nre_actual_spend_usd` DECIMAL(18,2) COMMENT 'Actual NRE spend in USD',
    `nre_budget_usd` DECIMAL(18,2) COMMENT 'NRE budget in USD',
    `packaging_type` STRING COMMENT 'The packaging type of the ic design project record in the design domain.',
    `pdk_version` STRING COMMENT 'The pdk version of the ic design project record in the design domain.',
    `plm_item_reference` STRING COMMENT 'The plm item reference of the ic design project record in the design domain.',
    `process_node_nm` STRING COMMENT 'Process node in nm',
    `project_code` STRING COMMENT 'Coded value representing the project code of the ic design project design record.',
    `project_description` STRING COMMENT 'The project description of the ic design project record in the design domain.',
    `project_name` STRING COMMENT 'The project name of the ic design project record in the design domain.',
    `project_start_date` DATE COMMENT 'The project start date associated with the ic design project design record.',
    `project_status` STRING COMMENT 'The project status of the ic design project record in the design domain.',
    `reach_svhc_assessed` BOOLEAN COMMENT 'REACH SVHC assessed flag',
    `revision` STRING COMMENT 'Revision identifier',
    `rohs_compliant` BOOLEAN COMMENT 'RoHS compliant flag',
    `rtl_freeze_date` DATE COMMENT 'The rtl freeze date associated with the ic design project design record.',
    `sap_wbs_element` STRING COMMENT 'The sap wbs element of the ic design project record in the design domain.',
    `tapeout_actual_date` DATE COMMENT 'Actual tapeout date',
    `tapeout_target_date` DATE COMMENT 'Target tapeout date',
    `target_clock_freq_mhz` DECIMAL(18,2) COMMENT 'Target clock frequency in MHz',
    `target_die_area_mm2` DECIMAL(18,2) COMMENT 'Target die area in mm2',
    `target_power_budget_mw` DECIMAL(18,2) COMMENT 'Target power budget in mW',
    `tsv_required` BOOLEAN COMMENT 'TSV required flag',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the ic design project record in the design domain.',
    CONSTRAINT pk_ic_design_project PRIMARY KEY(`ic_design_project_id`)
) COMMENT 'Master record for an IC design project lifecycle from RTL specification through GDS/GDSII tapeout. Captures project identity, target process node, design type (ASIC, SoC, FPGA), PPA targets (power budget, clock frequency, die area), tapeout milestone dates, NRE budget, design team assignments, EDA tool suite version, hierarchical block decomposition, and PLM integration references. SSOT for all design project metadata including block-level partitioning. Managed in Siemens Teamcenter PLM and Oracle Agile PLM.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` (
    `design_ip_core_id` BIGINT COMMENT 'Primary key',
    `eccn_classification_id` BIGINT COMMENT 'FK to compliance ECCN classification',
    `ip_core_development_id` BIGINT COMMENT 'FK to research IP core development',
    `pdk_id` BIGINT COMMENT 'FK to design PDK',
    `supplier_id` BIGINT COMMENT 'FK to supply supplier',
    `area_um2` DECIMAL(18,2) COMMENT 'Area in um2',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `datasheet_url` STRING COMMENT 'The datasheet url of the design ip core record in the design domain.',
    `dfm_compliant` BOOLEAN COMMENT 'DFM compliant flag',
    `dft_compliant` BOOLEAN COMMENT 'DFT compliant flag',
    `eda_tool_compatibility` STRING COMMENT 'The eda tool compatibility of the design ip core record in the design domain.',
    `export_control_classification` STRING COMMENT 'The export control classification of the design ip core record in the design domain.',
    `foundry_compatibility` STRING COMMENT 'The foundry compatibility of the design ip core record in the design domain.',
    `function_category` STRING COMMENT 'The function category of the design ip core record in the design domain.',
    `functional_description` STRING COMMENT 'The functional description of the design ip core record in the design domain.',
    `gate_count` BIGINT COMMENT 'The gate count of the design ip core record in the design domain.',
    `gds_available` BOOLEAN COMMENT 'GDS available flag',
    `interface_standard` STRING COMMENT 'The interface standard of the design ip core record in the design domain.',
    `ip_core_code` STRING COMMENT 'Coded value representing the ip core code of the design ip core design record.',
    `ip_type` STRING COMMENT 'The ip type of the design ip core record in the design domain.',
    `lef_available` BOOLEAN COMMENT 'LEF available flag',
    `license_expiry_date` DATE COMMENT 'The license expiry date associated with the design ip core design record.',
    `license_fee_usd` DECIMAL(18,2) COMMENT 'License fee in USD',
    `license_type` STRING COMMENT 'The license type of the design ip core record in the design domain.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status of the design ip core record in the design domain.',
    `max_frequency_mhz` DECIMAL(18,2) COMMENT 'Max frequency in MHz',
    `mpw_eligible` BOOLEAN COMMENT 'MPW eligible flag',
    `design_ip_core_name` STRING COMMENT 'IP core name',
    `nda_required` BOOLEAN COMMENT 'NDA required flag',
    `power_uw` DECIMAL(18,2) COMMENT 'Power in uW',
    `qualification_status` STRING COMMENT 'The qualification status of the design ip core record in the design domain.',
    `release_date` DATE COMMENT 'The release date associated with the design ip core design record.',
    `rohs_compliant` BOOLEAN COMMENT 'RoHS compliant flag',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'Royalty rate percentage',
    `rtl_language` STRING COMMENT 'The rtl language of the design ip core record in the design domain.',
    `scan_coverage_pct` DECIMAL(18,2) COMMENT 'Scan coverage percentage',
    `silicon_proven` BOOLEAN COMMENT 'Silicon proven flag',
    `silicon_proven_date` DATE COMMENT 'The silicon proven date associated with the design ip core design record.',
    `source_type` STRING COMMENT 'The source type of the design ip core record in the design domain.',
    `support_tier` STRING COMMENT 'The support tier of the design ip core record in the design domain.',
    `timing_model_available` BOOLEAN COMMENT 'Timing model available flag',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the design ip core record in the design domain.',
    `vendor_name` STRING COMMENT 'The vendor name of the design ip core record in the design domain.',
    `vendor_part_number` STRING COMMENT 'The vendor part number of the design ip core record in the design domain.',
    `version` STRING COMMENT 'Version or revision identifier of the design ip core design record.',
    CONSTRAINT pk_design_ip_core PRIMARY KEY(`design_ip_core_id`)
) COMMENT 'Master catalog of reusable Intellectual Property (IP) cores available for integration into IC designs. Tracks IP type (hard macro, soft IP, firm IP), function category (CPU, GPU, NPU, SerDes, PHY, memory controller, analog, RF), process node compatibility matrix, PPA characterization data, licensing terms and royalty structure, version history, silicon-proven status, EDA tool compatibility, and compliance with industry interface standards (AMBA, PCIe, USB). Sourced from internal IP library and third-party vendors (ARM, Synopsys DesignWare, Cadence Tensilica). SSOT for IP core definitions used across design projects.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`pdk` (
    `pdk_id` BIGINT COMMENT 'Primary key',
    `process_node_id` BIGINT COMMENT 'FK to product process node',
    `agile_plm_part_number` STRING COMMENT 'The agile plm part number of the pdk record in the design domain.',
    `checksum_sha256` STRING COMMENT 'SHA256 checksum',
    `pdk_code` STRING COMMENT 'Coded value representing the code of the pdk design record.',
    `deprecation_date` DATE COMMENT 'The deprecation date associated with the pdk design record.',
    `pdk_description` STRING COMMENT 'PDK description',
    `dft_rule_deck_version` STRING COMMENT 'The dft rule deck version of the pdk record in the design domain.',
    `drc_rule_deck_version` STRING COMMENT 'The drc rule deck version of the pdk record in the design domain.',
    `eda_tool_compatibility` STRING COMMENT 'The eda tool compatibility of the pdk record in the design domain.',
    `export_control_classification` STRING COMMENT 'The export control classification of the pdk record in the design domain.',
    `file_path` STRING COMMENT 'File system or storage file path for the pdk design record.',
    `foundry_name` STRING COMMENT 'The foundry name of the pdk record in the design domain.',
    `gds_format` STRING COMMENT 'The gds format of the pdk record in the design domain.',
    `io_library_name` STRING COMMENT 'The io library name of the pdk record in the design domain.',
    `ip_library_version` STRING COMMENT 'The ip library version of the pdk record in the design domain.',
    `layer_stack_definition` STRING COMMENT 'The layer stack definition of the pdk record in the design domain.',
    `license_type` STRING COMMENT 'The license type of the pdk record in the design domain.',
    `lithography_type` STRING COMMENT 'The lithography type of the pdk record in the design domain.',
    `lvs_rule_deck_version` STRING COMMENT 'The lvs rule deck version of the pdk record in the design domain.',
    `max_supply_voltage_v` DECIMAL(18,2) COMMENT 'Max supply voltage',
    `memory_compiler_supported` BOOLEAN COMMENT 'The memory compiler supported of the pdk record in the design domain.',
    `metal_layer_count` STRING COMMENT 'The metal layer count of the pdk record in the design domain.',
    `min_supply_voltage_v` DECIMAL(18,2) COMMENT 'Min supply voltage',
    `mpw_shuttle_supported` BOOLEAN COMMENT 'The mpw shuttle supported of the pdk record in the design domain.',
    `pdk_name` STRING COMMENT 'The name of the pdk record in the design domain.',
    `nda_required` BOOLEAN COMMENT 'The nda required of the pdk record in the design domain.',
    `nominal_supply_voltage_v` DECIMAL(18,2) COMMENT 'Nominal supply voltage',
    `opc_rule_deck_version` STRING COMMENT 'The opc rule deck version of the pdk record in the design domain.',
    `operating_temp_max_c` DECIMAL(18,2) COMMENT 'Max operating temperature',
    `operating_temp_min_c` DECIMAL(18,2) COMMENT 'Min operating temperature',
    `pdk_status` STRING COMMENT 'PDK status',
    `process_corner_set` STRING COMMENT 'The process corner set of the pdk record in the design domain.',
    `process_family` STRING COMMENT 'The process family of the pdk record in the design domain.',
    `qualification_date` DATE COMMENT 'The qualification date associated with the pdk design record.',
    `release_date` DATE COMMENT 'The release date associated with the pdk design record.',
    `release_notes_url` STRING COMMENT 'The release notes url of the pdk record in the design domain.',
    `spice_model_set` STRING COMMENT 'The spice model set of the pdk record in the design domain.',
    `spice_model_version` STRING COMMENT 'The spice model version of the pdk record in the design domain.',
    `std_cell_library_name` STRING COMMENT 'Standard cell library name',
    `std_cell_library_version` STRING COMMENT 'Standard cell library version',
    `teamcenter_item_reference` STRING COMMENT 'The teamcenter item reference of the pdk record in the design domain.',
    `transistor_architecture` STRING COMMENT 'The transistor architecture of the pdk record in the design domain.',
    `version` STRING COMMENT 'Version or revision identifier of the pdk design record.',
    CONSTRAINT pk_pdk PRIMARY KEY(`pdk_id`)
) COMMENT 'Process Design Kit (PDK) master record defining the foundry-specific design rules, device models, standard cell libraries, and technology files required for IC design at a given process node. Captures PDK version, foundry name, process node (e.g., 3nm, 5nm, 7nm), SPICE model sets, DRC/LVS rule decks, layer stack definitions, and EDA tool compatibility matrix. SSOT for PDK versioning used in Cadence Virtuoso and Synopsys Design Compiler flows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` (
    `rtl_specification_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to workforce employee',
    `license_agreement_id` BIGINT COMMENT 'FK to product license agreement',
    `mpw_shuttle_id` BIGINT COMMENT 'FK to design MPW shuttle',
    `ic_design_project_id` BIGINT COMMENT 'FK to design IC design project',
    `product_spec_id` BIGINT COMMENT 'FK to product spec',
    `to_ic_design_project_id` BIGINT COMMENT 'FK to design IC design project',
    `ams_behavioral_model_ref` STRING COMMENT 'AMS behavioral model reference',
    `cdc_annotation_status` STRING COMMENT 'The cdc annotation status of the rtl specification record in the design domain.',
    `clock_domain_count` STRING COMMENT 'The clock domain count of the rtl specification record in the design domain.',
    `commit_hash` STRING COMMENT 'The commit hash of the rtl specification record in the design domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the rtl specification record in the design domain.',
    `design_block_name` STRING COMMENT 'The design block name of the rtl specification record in the design domain.',
    `design_block_type` STRING COMMENT 'The design block type of the rtl specification record in the design domain.',
    `design_intent_description` STRING COMMENT 'The design intent description of the rtl specification record in the design domain.',
    `dfm_rule_set_version` STRING COMMENT 'The dfm rule set version of the rtl specification record in the design domain.',
    `dft_strategy` STRING COMMENT 'The dft strategy of the rtl specification record in the design domain.',
    `ear_eccn_code` STRING COMMENT 'Coded value representing the ear eccn code of the rtl specification design record.',
    `fpga_device_family` STRING COMMENT 'The fpga device family of the rtl specification record in the design domain.',
    `functional_coverage_target_pct` DECIMAL(18,2) COMMENT 'The functional coverage target pct of the rtl specification record in the design domain.',
    `hdl_language` STRING COMMENT 'The hdl language of the rtl specification record in the design domain.',
    `interface_protocols` STRING COMMENT 'The interface protocols of the rtl specification record in the design domain.',
    `ip_reuse_source` STRING COMMENT 'The ip reuse source of the rtl specification record in the design domain.',
    `is_analog_mixed_signal` BOOLEAN COMMENT 'Analog mixed signal flag',
    `is_fpga_target` BOOLEAN COMMENT 'FPGA target flag',
    `itar_controlled` BOOLEAN COMMENT 'ITAR controlled flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the rtl specification record in the design domain.',
    `lint_compliance_status` STRING COMMENT 'The lint compliance status of the rtl specification record in the design domain.',
    `logic_gate_count_estimate` BIGINT COMMENT 'The logic gate count estimate of the rtl specification record in the design domain.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'NRE cost in USD',
    `obsolescence_date` DATE COMMENT 'The obsolescence date associated with the rtl specification design record.',
    `pdk_version` STRING COMMENT 'The pdk version of the rtl specification record in the design domain.',
    `power_domain_count` STRING COMMENT 'The power domain count of the rtl specification record in the design domain.',
    `power_intent_format` STRING COMMENT 'The power intent format of the rtl specification record in the design domain.',
    `repository_path` STRING COMMENT 'File system or storage repository path for the rtl specification design record.',
    `reset_strategy` STRING COMMENT 'The reset strategy of the rtl specification record in the design domain.',
    `revision_control_system` STRING COMMENT 'The revision control system of the rtl specification record in the design domain.',
    `specification_approved_date` DATE COMMENT 'The specification approved date associated with the rtl specification design record.',
    `specification_number` STRING COMMENT 'The specification number of the rtl specification record in the design domain.',
    `specification_released_date` DATE COMMENT 'The specification released date associated with the rtl specification design record.',
    `specification_status` STRING COMMENT 'The specification status of the rtl specification record in the design domain.',
    `tapeout_target_date` DATE COMMENT 'The tapeout target date associated with the rtl specification design record.',
    `target_clock_frequency_mhz` DECIMAL(18,2) COMMENT 'Target clock frequency in MHz',
    `target_process_node` STRING COMMENT 'The target process node of the rtl specification record in the design domain.',
    `teamcenter_item_reference` STRING COMMENT 'The teamcenter item reference of the rtl specification record in the design domain.',
    `version_label` STRING COMMENT 'The version label of the rtl specification record in the design domain.',
    CONSTRAINT pk_rtl_specification PRIMARY KEY(`rtl_specification_id`)
) COMMENT 'Register Transfer Level (RTL) design specification and source record capturing the functional hardware description of a design block, IP subsystem, or full chip. Tracks RTL module hierarchy, HDL language (VHDL, Verilog, SystemVerilog, Chisel), design intent documentation, clock domain definitions and CDC boundary annotations, reset strategy, interface protocols (AXI, AHB, APB, Wishbone), power domain definitions (UPF/CPF), functional coverage model targets, lint rule compliance status, and linkage to the parent IC design project. For analog/mixed-signal blocks, captures behavioral model references (Verilog-AMS, VHDL-AMS) and links to transistor-level schematic source in Cadence Virtuoso where applicable. For FPGA targets, captures synthesis constraints, pin assignments, and target device family. Managed as a versioned artifact in revision control (Git, Perforce) with provenance tracking through Siemens Teamcenter PLM.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`netlist` (
    `netlist_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to workforce employee',
    `design_ip_core_id` BIGINT COMMENT 'FK to design IP core',
    `eda_tool_id` BIGINT COMMENT 'FK to design EDA tool',
    `ic_design_project_id` BIGINT COMMENT 'FK to design IC design project',
    `pdk_id` BIGINT COMMENT 'FK to design PDK',
    `rtl_specification_id` BIGINT COMMENT 'FK to design RTL specification',
    `to_ic_design_project_id` BIGINT COMMENT 'FK to design IC design project',
    `to_pdk_id` BIGINT COMMENT 'FK to design PDK',
    `to_rtl_specification_id` BIGINT COMMENT 'FK to design RTL specification',
    `approval_timestamp` TIMESTAMP COMMENT 'The approval timestamp of the netlist record in the design domain.',
    `area_estimate_um2` DECIMAL(18,2) COMMENT 'Area estimate in um2',
    `cell_instance_count` BIGINT COMMENT 'The cell instance count of the netlist record in the design domain.',
    `cell_library_name` STRING COMMENT 'The cell library name of the netlist record in the design domain.',
    `cell_library_version` STRING COMMENT 'The cell library version of the netlist record in the design domain.',
    `checksum_sha256` STRING COMMENT 'SHA256 checksum',
    `combinational_cell_count` BIGINT COMMENT 'The combinational cell count of the netlist record in the design domain.',
    `constraints_file_ref` STRING COMMENT 'Constraints file reference',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the netlist record in the design domain.',
    `critical_path_delay_ps` DECIMAL(18,2) COMMENT 'Critical path delay in ps',
    `design_block_name` STRING COMMENT 'The design block name of the netlist record in the design domain.',
    `design_iteration` STRING COMMENT 'The design iteration of the netlist record in the design domain.',
    `dfm_rule_check_status` STRING COMMENT 'The dfm rule check status of the netlist record in the design domain.',
    `dft_scan_coverage_pct` DECIMAL(18,2) COMMENT 'The dft scan coverage pct of the netlist record in the design domain.',
    `dynamic_power_mw` DECIMAL(18,2) COMMENT 'Dynamic power in mW',
    `file_path` STRING COMMENT 'File system or storage file path for the netlist design record.',
    `format` STRING COMMENT 'Netlist format',
    `gate_count` BIGINT COMMENT 'The gate count of the netlist record in the design domain.',
    `leakage_power_uw` DECIMAL(18,2) COMMENT 'Leakage power in uW',
    `netlist_name` STRING COMMENT 'Netlist name',
    `netlist_type` STRING COMMENT 'Netlist type',
    `process_node_nm` STRING COMMENT 'Process node in nm',
    `sequential_cell_count` BIGINT COMMENT 'The sequential cell count of the netlist record in the design domain.',
    `synthesis_run_timestamp` TIMESTAMP COMMENT 'The synthesis run timestamp of the netlist record in the design domain.',
    `synthesis_runtime_minutes` DECIMAL(18,2) COMMENT 'Synthesis runtime in minutes',
    `synthesis_status` STRING COMMENT 'The synthesis status of the netlist record in the design domain.',
    `tapeout_target_date` DATE COMMENT 'The tapeout target date associated with the netlist design record.',
    `target_clock_freq_mhz` DECIMAL(18,2) COMMENT 'Target clock frequency in MHz',
    `timing_closure_achieved` BOOLEAN COMMENT 'Timing closure achieved flag',
    `timing_slack_hold_ps` DECIMAL(18,2) COMMENT 'Timing slack hold in ps',
    `timing_slack_setup_ps` DECIMAL(18,2) COMMENT 'Timing slack setup in ps',
    `timing_violation_count` STRING COMMENT 'The timing violation count of the netlist record in the design domain.',
    `total_power_estimate_mw` DECIMAL(18,2) COMMENT 'Total power estimate in mW',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the netlist record in the design domain.',
    `version` STRING COMMENT 'Version or revision identifier of the netlist design record.',
    CONSTRAINT pk_netlist PRIMARY KEY(`netlist_id`)
) COMMENT 'Synthesized netlist artifact produced by logic synthesis tools (Synopsys Design Compiler) from RTL. Captures netlist type (pre-synthesis, post-synthesis, post-layout), gate count, cell library version, synthesis constraints file reference, timing slack summary, power estimate, and linkage to the RTL specification and PDK version used. Tracks netlist versions across design iterations for design provenance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` (
    `timing_analysis_run_id` BIGINT COMMENT 'Unique surrogate identifier for each Static Timing Analysis (STA) run record in the Databricks Silver Layer. Primary key for the timing_analysis_run data product.',
    `ic_design_project_id` BIGINT COMMENT 'FK to design.ic_design_project.ic_design_project_id — Timing runs belong to a project for aggregated timing closure tracking across design iterations.',
    `netlist_id` BIGINT COMMENT 'FK to design.netlist.netlist_id — STA runs analyze timing on a specific netlist version. This linkage is required for timing closure tracking.',
    `physical_layout_id` BIGINT COMMENT 'FK to design.physical_layout.physical_layout_id — Post-route STA runs reference a specific physical layout version for parasitic-annotated timing. Critical for post-layout timing closure.',
    `primary_timing_ic_design_project_id` BIGINT COMMENT 'Reference to the IC design or SoC/ASIC design entity for which this STA run was executed. Links the timing analysis result to the parent design record managed in Cadence Virtuoso/Innovus or Siemens Teamcenter PLM.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Timing analysis run submission is logged by the engineer who initiates it; required for run audit report.',
    `analysis_mode` STRING COMMENT 'Timing analysis mode applied in this STA run. Setup checks for maximum path delay violations; hold checks for minimum path delay violations; OCV (On-Chip Variation), AOCV (Advanced OCV), and POCV (Parametric OCV) modes apply statistical derating for silicon variation modeling. Determines which slack metrics are applicable.. Valid values are `setup|hold|setup_hold|ocv|aocv|pocv`',
    `clock_domain_count` STRING COMMENT 'Number of distinct clock domains analyzed in this STA run. Multi-clock domain designs require careful CDC (Clock Domain Crossing) analysis. Relevant for SoC and ASIC designs with multiple functional blocks operating at different frequencies.',
    `clock_frequency_target_mhz` DECIMAL(18,2) COMMENT 'Target clock frequency in megahertz (MHz) specified for this STA run, representing the designs PPA (Power Performance Area) performance goal. Used to evaluate whether timing closure is achieved at the required operating frequency.',
    `clock_period_target_ps` DECIMAL(18,2) COMMENT 'Target clock period in picoseconds (ps) corresponding to the clock frequency target. Directly used by Synopsys PrimeTime as the timing constraint for setup/hold analysis. Derived from clock_frequency_target_mhz but stored independently as the authoritative STA constraint value.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this STA run record was first created in the Databricks Silver Layer data product. Represents the audit trail creation timestamp for data lineage and compliance purposes.',
    `critical_path_count` STRING COMMENT 'Number of critical timing paths (paths with negative or near-zero slack) identified in this STA run. Used by design engineers to prioritize optimization efforts in Synopsys Design Compiler or Cadence Innovus for timing closure.',
    `derating_factor_hold` DECIMAL(18,2) COMMENT 'On-Chip Variation (OCV) derating factor applied to hold timing paths in this STA run. Represents the percentage by which cell delays are derated for hold analysis. Typically different from setup derating to model the asymmetric nature of process variation effects on min/max paths.',
    `derating_factor_setup` DECIMAL(18,2) COMMENT 'On-Chip Variation (OCV) derating factor applied to setup timing paths in this STA run. Represents the percentage by which cell delays are derated to model process variation (e.g., 0.95 = 5% derating). Used in OCV/AOCV/POCV analysis modes for silicon-accurate sign-off.',
    `design_stage` STRING COMMENT 'Physical design stage at which this STA run was performed, reflecting the state of the netlist and parasitics. Values: pre_synthesis (RTL-level), post_synthesis (gate-level), pre_cts (before Clock Tree Synthesis), post_cts (after CTS), post_route (after detailed routing), signoff (final tapeout signoff). Drives interpretation of WNS/TNS results.. Valid values are `pre_synthesis|post_synthesis|pre_cts|post_cts|post_route|signoff`',
    `design_version` STRING COMMENT 'Version or revision label of the IC design netlist or GDS/GDSII database at the time this STA run was executed (e.g., v2.3.1, tapeout_rc2). Enables timing closure tracking across design iterations and correlates with PLM change records.',
    `hold_violation_count` STRING COMMENT 'Total number of hold timing violations (negative hold slack endpoints) reported by Synopsys PrimeTime in this STA run. A value of zero indicates full hold timing closure. Critical for designs with multi-cycle paths, clock domain crossings, and post-CTS analysis.',
    `is_multi_corner_run` BOOLEAN COMMENT 'Indicates whether this STA run covers multiple PVT corners simultaneously (True) or a single corner (False). Multi-corner runs are used for comprehensive sign-off coverage across all operating conditions required by the PDK and target application specifications.',
    `is_signoff_run` BOOLEAN COMMENT 'Indicates whether this STA run is designated as an official tapeout signoff run (True) or an intermediate/exploratory analysis run (False). Signoff runs are subject to formal design review, PLM change control, and foundry submission requirements.',
    `liberty_library_version` STRING COMMENT 'Version of the Liberty (.lib) timing library files used in this STA run. Liberty libraries contain cell timing models, power models, and operating condition data from the PDK. Library version directly affects timing analysis accuracy and sign-off validity.',
    `max_capacitance_violation_count` STRING COMMENT 'Number of maximum capacitance violations reported in this STA run. Capacitance violations indicate nets with excessive load that degrade timing and signal integrity. Must be resolved through buffer insertion or net splitting before tapeout.',
    `max_transition_violation_count` STRING COMMENT 'Number of maximum transition time violations reported in this STA run. Transition violations indicate signal edges that are too slow, potentially causing functional failures or increased power consumption. Must be resolved before tapeout signoff per PDK design rules.',
    `pdk_version` STRING COMMENT 'Version of the Process Design Kit (PDK) used for this STA run. The PDK defines the foundrys process parameters, design rules, and standard cell libraries. PDK version is critical for tapeout sign-off traceability and foundry submission compliance.',
    `primetime_version` STRING COMMENT 'Version of Synopsys PrimeTime used to execute this STA run (e.g., PrimeTime 2023.12-SP3). Critical for result reproducibility, audit trails, and identifying version-specific timing model differences that may affect sign-off validity.',
    `process_node_nm` STRING COMMENT 'Semiconductor process technology node in nanometers at which the design is implemented (e.g., 5nm, 7nm, 28nm). Determines PDK library characteristics, timing model accuracy, and applicable EUV/DUV lithography constraints relevant to STA sign-off.',
    `pvt_corner` STRING COMMENT 'Operating corner (Process-Voltage-Temperature) under which this STA run was performed (e.g., ss_0p72v_125c for slow-slow worst-case, ff_1p08v_m40c for fast-fast best-case). Defined by the PDK (Process Design Kit) and critical for sign-off coverage across all operating conditions.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the STA run results were formally reviewed and approved by the responsible design engineer or timing closure lead. Null if the run has not yet been reviewed. Required for tapeout sign-off audit trail.',
    `reviewed_by` STRING COMMENT 'Username or employee identifier of the senior design engineer or timing closure lead who reviewed and approved the results of this STA run. Required for signoff runs as part of the formal design review process before tapeout submission.',
    `run_completion_timestamp` TIMESTAMP COMMENT 'Date and time when this Static Timing Analysis run completed execution in Synopsys PrimeTime. Used to calculate run duration and assess EDA compute resource utilization. Null if the run is still in progress or was aborted.',
    `run_duration_seconds` STRING COMMENT 'Wall-clock duration of this STA run in seconds, from job submission to completion. Used for EDA compute resource planning, license utilization tracking, and identifying unusually long runs that may indicate tool or design issues.',
    `run_identifier` STRING COMMENT 'Externally-known alphanumeric run identifier assigned by the EDA tool flow or MES integration (e.g., PT-RUN-20240315-0042). Used for cross-referencing with Synopsys PrimeTime job logs, Cadence Innovus signoff reports, and Siemens Teamcenter PLM design records.',
    `run_iteration` STRING COMMENT 'Sequential iteration number of this STA run within the current design stage and PVT corner. Enables tracking of timing closure convergence across multiple optimization-analysis cycles (e.g., iteration 1 through N until timing closure is achieved).',
    `run_name` STRING COMMENT 'Human-readable name or label assigned to this Static Timing Analysis run, typically encoding the design name, corner, and iteration (e.g., soc_top_ss_0p72v_125c_postroute_iter3). Used for identification in Synopsys PrimeTime run logs and design review meetings.',
    `run_notes` STRING COMMENT 'Free-text notes or comments entered by the design engineer describing the purpose, context, or key findings of this STA run (e.g., Post-ECO run after fixing 3 critical paths in clock tree, Baseline run for tapeout corner coverage). Supports design review and knowledge transfer.',
    `run_status` STRING COMMENT 'Execution lifecycle status of this STA run job in the EDA tool flow. submitted indicates the job is queued, running indicates active execution, completed indicates successful completion, failed indicates tool error or license failure, aborted indicates user-cancelled run. Distinct from timing_closure_status which reflects the timing result.. Valid values are `submitted|running|completed|failed|aborted`',
    `run_timestamp` TIMESTAMP COMMENT 'Date and time when this Static Timing Analysis run was initiated in Synopsys PrimeTime. Represents the principal business event timestamp for this record. Used for tracking timing closure progress over time and correlating with design iteration milestones.',
    `sdc_constraints_version` STRING COMMENT 'Version or identifier of the Synopsys Design Constraints (SDC) file used in this STA run. SDC files define clock definitions, input/output delays, and timing exceptions. Versioning ensures traceability of constraint changes across design iterations.',
    `setup_violation_count` STRING COMMENT 'Total number of setup timing violations (negative setup slack endpoints) reported by Synopsys PrimeTime in this STA run. A value of zero indicates full setup timing closure. Tracked across iterations to measure convergence progress toward tapeout readiness.',
    `spef_version` STRING COMMENT 'Version or identifier of the SPEF (Standard Parasitic Exchange Format) file used for parasitic extraction in this STA run. SPEF files contain RC parasitics from the routed layout and directly impact timing accuracy. Null for pre-route analysis stages.',
    `supply_voltage_v` DECIMAL(18,2) COMMENT 'Nominal supply voltage in volts (V) applied for this STA runs PVT corner. Defined by the PDK operating conditions and UPF (Unified Power Format) power intent. Directly impacts cell delay models and timing analysis results.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Operating temperature in degrees Celsius (°C) for this STA runs PVT corner. Temperature affects transistor characteristics and cell delays. Typical corners range from -40°C (automotive cold) to 125°C (worst-case hot). Defined by the PDK and target application requirements.',
    `timing_closure_status` STRING COMMENT 'Overall timing closure pass/fail status for this STA run. pass indicates all setup and hold violations are resolved and the design meets timing at the specified PVT corner and clock frequency. waived indicates known violations accepted with engineering sign-off. pending_review indicates results awaiting design team review. Primary KPI for tapeout readiness.. Valid values are `pass|fail|waived|in_progress|pending_review`',
    `total_hold_negative_slack_ps` DECIMAL(18,2) COMMENT 'Total Hold Negative Slack (THNS) in picoseconds — the sum of all negative hold slack values across all violating hold endpoints in this STA run. Complements TNS (setup) to provide a complete picture of hold timing closure status.',
    `total_negative_slack_ps` DECIMAL(18,2) COMMENT 'Total Negative Slack (TNS) in picoseconds — the sum of all negative slack values across all violating timing endpoints in this STA run. Indicates the overall magnitude of timing violations in the design. Used alongside WNS to assess timing closure convergence across design iterations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this STA run record was last modified in the Databricks Silver Layer data product. Tracks updates such as status changes, waiver additions, or review approvals for audit trail and data lineage compliance.',
    `waiver_count` STRING COMMENT 'Number of timing violations formally waived with engineering sign-off in this STA run. Waivers are granted for violations on non-critical paths, test-mode-only paths, or paths with functional justification. Tracked for tapeout risk assessment and compliance with design review processes.',
    `worst_hold_slack_ps` DECIMAL(18,2) COMMENT 'Worst Hold Slack (WHS) in picoseconds for hold timing analysis in this STA run. Represents the most critical hold violation — the largest shortfall in minimum path delay. Negative values indicate hold violations that must be fixed before tapeout. Applicable when analysis_mode includes hold or setup_hold.',
    `worst_negative_slack_ps` DECIMAL(18,2) COMMENT 'Worst Negative Slack (WNS) in picoseconds reported by Synopsys PrimeTime for this STA run. Represents the most critical timing violation — the largest shortfall between required and actual signal arrival time. A value of 0 or positive indicates no setup/hold violation on the worst path. Key metric for timing closure tracking.',
    CONSTRAINT pk_timing_analysis_run PRIMARY KEY(`timing_analysis_run_id`)
) COMMENT 'Static Timing Analysis (STA) run record produced by Synopsys PrimeTime capturing timing closure status for a design at a specific design stage. Tracks worst negative slack (WNS), total negative slack (TNS), setup/hold violations count, operating corner (PVT), clock frequency targets, analysis mode (pre-CTS, post-CTS, post-route), and pass/fail status. Enables timing closure tracking across design iterations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` (
    `physical_layout_id` BIGINT COMMENT 'Unique surrogate identifier for each physical design layout record in the Databricks Silver Layer. Serves as the primary key for the physical_layout data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Layout engineering effort costs are allocated to a cost center for accurate product cost accounting.',
    `employee_id` BIGINT COMMENT 'Reference to the physical design engineer responsible for this layout iteration. Enables accountability tracking, design review assignment, and workforce analytics in Workday HCM.',
    `ic_design_project_id` BIGINT COMMENT 'FK to design.ic_design_project.ic_design_project_id — Physical layouts belong to a specific IC design project. Required for design artifact management.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW (Multi-Project Wafer) shuttle run assignment for this layout, if applicable. MPW shuttles allow multiple designs to share a single wafer run to reduce NRE (Non-Recurring Engineering) costs for prototype fabrication.',
    `netlist_id` BIGINT COMMENT 'FK to design.netlist.netlist_id — Physical layout (place and route) takes a netlist as input. This is the core PnR flow linkage required for design provenance.',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) version used for this physical layout. The PDK defines the technology node rules, design rule checks (DRC), and layer stack for the target fabrication process.',
    `primary_physical_ic_design_project_id` BIGINT COMMENT 'Reference to the parent IC design record for which this physical layout iteration was produced. Links the layout to its originating design project.',
    `antenna_violation_count` STRING COMMENT 'Number of antenna rule violations detected in the layout. Antenna violations occur when metal segments accumulate charge during plasma etching that can damage gate oxide. Must be resolved or mitigated with antenna diodes before tapeout.',
    `cell_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the core area occupied by placed standard cells, expressed as a decimal percentage (e.g., 72.500 = 72.5%). High utilization (>85%) may indicate routing congestion risk; low utilization (<50%) may indicate oversized floorplan.',
    `core_area_mm2` DECIMAL(18,2) COMMENT 'Area of the core logic region in square millimeters (mm²), excluding I/O ring, power ring, and seal ring. Used to assess logic density and available routing resources.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this physical layout record was first created in the data platform. Used for audit trail and data lineage tracking in the Databricks Silver Layer.',
    `cts_insertion_delay_ps` DECIMAL(18,2) COMMENT 'Clock insertion delay in picoseconds (ps) from the clock source to the farthest clock sink in the clock tree. Impacts setup timing margin and must be accounted for in static timing analysis (STA).',
    `cts_skew_ps` DECIMAL(18,2) COMMENT 'Clock skew in picoseconds (ps) achieved by the Clock Tree Synthesis (CTS) engine at this layout iteration. Measures the maximum difference in clock arrival times across all sink flip-flops. Lower skew improves timing closure margin.',
    `dfm_score` DECIMAL(18,2) COMMENT 'Quantitative DFM (Design for Manufacturability) score assigned to this layout iteration by the DFM analysis tool (e.g., Mentor Calibre YieldAnalyzer). Higher scores indicate better manufacturability and expected yield; used to guide layout optimization before tapeout.',
    `dft_coverage_pct` DECIMAL(18,2) COMMENT 'Fault coverage percentage achieved by the DFT (Design for Testability) implementation at this layout stage, as reported by ATPG (Automatic Test Pattern Generation) tools. Typically required to exceed 95% for production test qualification.',
    `die_area_mm2` DECIMAL(18,2) COMMENT 'Total die area in square millimeters (mm²) computed from the floorplan boundary. A primary PPA (Power, Performance, Area) metric used for cost estimation, yield modeling, and competitive benchmarking.',
    `die_height_um` DECIMAL(18,2) COMMENT 'Height of the die boundary in micrometers (µm) as defined in the physical layout floorplan. Together with die width, determines die area for yield and cost analysis.',
    `die_width_um` DECIMAL(18,2) COMMENT 'Width of the die boundary in micrometers (µm) as defined in the physical layout floorplan. Used for package selection, wafer yield estimation, and cost modeling.',
    `drc_critical_violation_count` STRING COMMENT 'Number of DRC violations classified as critical (yield-impacting or functionality-blocking) as opposed to waivable violations. Critical DRC violations must be resolved before tapeout; waivable violations may be accepted with foundry approval.',
    `drc_violation_count` STRING COMMENT 'Total number of Design Rule Check (DRC) violations detected in this layout iteration by the signoff DRC tool (e.g., Mentor Calibre, Synopsys IC Validator). A value of zero is required for tapeout approval.',
    `eda_tool` STRING COMMENT 'EDA tool used to produce this physical layout iteration. Identifies the physical implementation platform (Cadence Innovus, Synopsys IC Compiler 2, Siemens Aprisa, or Cadence Virtuoso for custom layouts) for provenance and reproducibility.. Valid values are `cadence_innovus|synopsys_icc2|siemens_aprisa|cadence_virtuoso`',
    `eda_tool_version` STRING COMMENT 'Version string of the EDA tool used to generate this layout (e.g., Innovus 21.1, ICC2 2022.03). Critical for design reproducibility and debugging layout-specific tool behavior.',
    `em_compliant` BOOLEAN COMMENT 'Indicates whether all metal interconnects in the layout comply with electromigration (EM) current density limits specified by the foundry PDK. TRUE = EM compliant; FALSE = EM violations present requiring wire widening or rerouting.',
    `gds_file_checksum` STRING COMMENT 'SHA-256 cryptographic checksum of the GDSII/OASIS layout file for integrity verification. Used to confirm that the submitted tapeout file has not been corrupted or tampered with during transfer to the foundry.. Valid values are `^[a-fA-F0-9]{64}$`',
    `gds_file_format` STRING COMMENT 'Format of the layout database file referenced in gds_file_path. GDSII is the traditional foundry submission format; OASIS (Open Artwork System Interchange Standard) is the modern compressed alternative; LEF/DEF is used for abstract/physical exchange.. Valid values are `gdsii|oasis|lef_def`',
    `gds_file_path` STRING COMMENT 'File system or object storage path to the GDSII (Graphic Data System II) or OASIS layout database file for this physical layout iteration. The GDSII file is the primary deliverable submitted to the foundry for mask generation at tapeout.',
    `implementation_stage` STRING COMMENT 'Current stage in the physical implementation flow for this layout iteration. Stages progress from initial floorplan through placement, clock tree synthesis (CTS), routing, signoff, and final tapeout submission. [ENUM-REF-CANDIDATE: floorplan|placement|cts|routing|signoff|tapeout — promote to reference product if additional stages are needed]. Valid values are `floorplan|placement|cts|routing|signoff|tapeout`',
    `ir_drop_max_mv` DECIMAL(18,2) COMMENT 'Maximum static IR drop in millivolts (mV) observed in the power grid analysis at this layout iteration. Excessive IR drop degrades circuit performance and reliability; must remain within foundry-specified limits for tapeout approval.',
    `iteration_timestamp` TIMESTAMP COMMENT 'Timestamp when this physical layout iteration checkpoint was captured and committed to the design database. Represents the principal business event time for this layout record, enabling chronological tracking of design progress.',
    `layout_name` STRING COMMENT 'Human-readable name identifying this physical layout iteration, typically including the design name and iteration label (e.g., SoC_v3_floorplan_iter2). Used in Cadence Innovus and Synopsys ICC2 project naming conventions.',
    `layout_status` STRING COMMENT 'Lifecycle status of this physical layout record. Tracks whether the layout is actively being worked on, under design review, approved for next stage, rejected requiring rework, or archived as a historical iteration.. Valid values are `in_progress|review|approved|rejected|archived`',
    `layout_version` STRING COMMENT 'Version identifier for this physical layout iteration following semantic versioning (e.g., 1.0.0, 2.3.1). Tracks incremental changes through the physical implementation flow from floorplan to tapeout.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `leakage_power_uw` DECIMAL(18,2) COMMENT 'Static leakage power in microwatts (µW) estimated for this layout at the target operating conditions. Critical for battery-powered and low-power IoT/mobile applications; tracked separately from dynamic power for PPA optimization.',
    `lvs_clean` BOOLEAN COMMENT 'Indicates whether the physical layout passes Layout Versus Schematic (LVS) verification with zero errors, confirming that the layout netlist matches the schematic netlist. TRUE = LVS clean (required for tapeout); FALSE = LVS errors present.',
    `metal_fill_density_pct` DECIMAL(18,2) COMMENT 'Average metal fill density percentage across all metal layers after dummy metal fill insertion. Foundry CMP (Chemical Mechanical Planarization) processes require metal density to remain within specified min/max bounds to ensure planar surfaces.',
    `metal_layer_count` STRING COMMENT 'Number of metal routing layers used in this physical layout, as defined by the PDK technology node stack (e.g., 12 for advanced FinFET nodes). Determines routing resource availability and BEOL (Back End of Line) complexity.',
    `notes` STRING COMMENT 'Free-text notes capturing design decisions, known issues, waiver justifications, or iteration-specific observations recorded by the physical design engineer. Supports design review documentation and knowledge transfer.',
    `power_consumption_mw` DECIMAL(18,2) COMMENT 'Estimated total power consumption in milliwatts (mW) from power analysis at this layout iteration, including dynamic switching power and static leakage power. A key PPA (Power, Performance, Area) metric for product specification compliance.',
    `routing_congestion_layer` STRING COMMENT 'Metal layer identifier (e.g., M4, M7) where the maximum routing congestion was observed. Used to guide targeted floorplan or placement adjustments to relieve congestion on the most constrained layer.',
    `routing_congestion_max_pct` DECIMAL(18,2) COMMENT 'Maximum routing congestion percentage observed across all metal layers in the layout, expressed as overflow percentage. Values above 5% typically indicate routing closure risk requiring floorplan or placement adjustment.',
    `tapeout_date` DATE COMMENT 'Date on which the final GDSII/OASIS layout was submitted to the foundry for mask generation (tapeout). A critical milestone in the IC design lifecycle tracked against the product TTM (Time to Market) schedule.',
    `tns_ps` DECIMAL(18,2) COMMENT 'Total Negative Slack (TNS) in picoseconds (ps), representing the sum of all negative slack values across all timing paths. Indicates the overall magnitude of timing violations in the design; must reach zero for tapeout signoff.',
    `total_cell_count` STRING COMMENT 'Total number of standard cells placed in the core area at this layout iteration. Includes combinational logic, sequential elements, buffers, and inverters. Used to assess design complexity and placement density.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this physical layout record was last modified in the data platform. Supports incremental data processing, change detection, and audit compliance in the Databricks Silver Layer.',
    `wns_ps` DECIMAL(18,2) COMMENT 'Worst Negative Slack (WNS) in picoseconds (ps) from static timing analysis at this layout iteration. Negative values indicate timing violations; zero or positive values indicate timing closure. A key metric for tapeout readiness.',
    CONSTRAINT pk_physical_layout PRIMARY KEY(`physical_layout_id`)
) COMMENT 'Physical design layout record representing the floorplan, placement, clock tree, and routing state of an IC design at a specific stage in the physical implementation flow. Captures die dimensions and core area, cell utilization percentage, routing congestion metrics by metal layer, DRC violation count and categories, LVS clean status, metal layer stack usage and fill density, power grid IR-drop analysis results, clock tree synthesis (CTS) metrics (skew, insertion delay), electromigration compliance status, antenna rule violations, and GDS/GDSII or OASIS file reference. Tracks physical design iterations from initial floorplan through final tapeout-ready layout in Cadence Innovus, Synopsys ICC2, or Siemens Aprisa. SSOT for physical design state at each iteration checkpoint.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`tapeout` (
    `tapeout_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the tapeout event record. Primary key for the tapeout data product in the design domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tapeout manufacturing costs are charged to a cost center for COGS reporting and cost control.',
    `customer_design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Enables tracking of each tapeout against its originating design win for NRE cost recovery and warranty reporting.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Each tapeout shipment must be covered by an export license; linking enables audit of license usage per tapeout.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Tapeout submission must specify the foundry supplier to coordinate mask set delivery and wafer fab.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA) associated with this tapeout event. Links the tapeout to the product master record.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Tapeout projects are tracked via internal orders to capture capital spend and cost commitments.',
    `mask_set_id` BIGINT COMMENT 'Unique identifier assigned to the photolithography mask set generated from this tapeout. Used to track mask fabrication orders, reticle inventory, and wafer fabrication lots linked to this design submission.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the Multi-Project Wafer (MPW) shuttle assignment if this tapeout is part of a shared wafer run. Null if this is a dedicated wafer tapeout.',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) version used for this tapeout. The PDK defines the foundry-specific design rules, device models, and layer stack used during physical design.',
    `physical_layout_id` BIGINT COMMENT 'FK to design.physical_layout.physical_layout_id — Tapeout submits a final physical layout (GDS) to the foundry. Must reference which layout version was taped out.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the parent IC design record from which this tapeout was generated. Links tapeout provenance back to the design lifecycle in the design domain.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tapeout revenue and margin are attributed to a profit center for product line profitability analysis.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Tapeout Completion Report requires associating each tapeout with its originating research project for closure and ROI analysis.',
    `to_ic_design_project_id` BIGINT COMMENT 'FK to design.ic_design_project.ic_design_project_id — A tapeout event is the culmination of an IC design project. This is the critical milestone linkage.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: WBS linkage ties tapeout tasks to financial work packages for schedule‑cost integration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tapeout record was first created in the system. Used for audit trail and data lineage tracking.',
    `design_name` STRING COMMENT 'Human-readable name of the IC design being taped out (e.g., product code name or internal design designation). Used for identification in design review meetings and foundry communications.',
    `design_revision` STRING COMMENT 'Revision identifier of the design at the time of tapeout (e.g., A0, B1, C2). Distinguishes successive tapeout iterations of the same design, critical for mask set versioning and silicon bring-up tracking.. Valid values are `^[A-Z][0-9]{1,2}$`',
    `design_type` STRING COMMENT 'Classification of the IC design type being taped out. Distinguishes ASIC, SoC, FPGA, analog, mixed-signal, RF, memory, and photonic designs, which have different EDA flows, PDK requirements, and sign-off criteria. [ENUM-REF-CANDIDATE: ASIC|SoC|FPGA|analog|mixed_signal|RF|memory|photonic — promote to reference product]',
    `dfm_score` DECIMAL(18,2) COMMENT 'Quantitative Design for Manufacturability (DFM) score assigned to the layout at tapeout, reflecting predicted yield sensitivity to process variation. Higher scores indicate better manufacturability. Sourced from DFM analysis tools integrated with the EDA flow.',
    `dft_coverage_pct` DECIMAL(18,2) COMMENT 'Percentage of logic nodes covered by Design for Testability (DFT) structures (scan chains, BIST) as measured by Automatic Test Pattern Generation (ATPG) at tapeout sign-off. Directly impacts post-silicon test quality and DPPM targets.',
    `die_size_mm2` DECIMAL(18,2) COMMENT 'Physical area of the die in square millimeters as defined in the final GDS layout at tapeout. A key Power-Performance-Area (PPA) metric used for cost modeling, yield estimation, and wafer utilization planning.',
    `drc_clean` BOOLEAN COMMENT 'Indicates whether the final GDS layout passed all Design Rule Check (DRC) violations with zero errors at the time of tapeout submission. A TRUE value is a mandatory tapeout sign-off criterion per foundry requirements.',
    `erc_clean` BOOLEAN COMMENT 'Indicates whether the design passed Electrical Rule Check (ERC) with no violations at tapeout. ERC validates electrical connectivity integrity including floating nodes, antenna violations, and electromigration rules.',
    `expected_yield_pct` DECIMAL(18,2) COMMENT 'Predicted die yield percentage (good dies per wafer as a percentage of total dies per wafer) at the time of tapeout, based on DFM analysis and process node historical yield data. Used for production planning and cost-per-die estimation.',
    `export_control_classification` STRING COMMENT 'Export control classification of the tapeout design under US Export Administration Regulations (EAR) or International Traffic in Arms Regulations (ITAR). Determines licensing requirements for foundry submission to foreign entities. [ENUM-REF-CANDIDATE: EAR99|ECCN_3E001|ECCN_3A001|ITAR_controlled|not_classified — promote to reference product]. Valid values are `EAR99|ECCN_3E001|ECCN_3A001|ITAR_controlled|not_classified`',
    `foundry_name` STRING COMMENT 'Name of the semiconductor fabrication facility (FAB) or foundry to which the tapeout was submitted (e.g., TSMC, Samsung Foundry, GlobalFoundries, Intel Foundry Services). Used for supply chain and vendor management reporting.',
    `foundry_submission_ref` STRING COMMENT 'Foundry-assigned reference number or confirmation code for the tapeout submission. Used to track the submission status with the external foundry partner and cross-reference with foundry manufacturing orders.',
    `gds_file_path` STRING COMMENT 'Storage path or URI of the final GDS/GDSII layout file in the design data repository. Enables traceability from the tapeout record to the physical design artifact. Classified confidential as it contains proprietary IP location data.',
    `gds_file_version` STRING COMMENT 'Version identifier of the final GDS/GDSII layout file submitted for tapeout. Provides design data provenance linking the physical layout file to the tapeout event. Sourced from Cadence Virtuoso or equivalent EDA tool.',
    `ip_sign_off_complete` BOOLEAN COMMENT 'Indicates whether all third-party and internal Intellectual Property (IP) cores integrated in the design have received sign-off approval for inclusion in the tapeout. Ensures IP licensing compliance and integration verification are complete.',
    `lithography_type` STRING COMMENT 'Photolithography exposure technology used for the critical layers in this tapeout. Distinguishes Extreme Ultraviolet (EUV), Deep Ultraviolet (DUV), and legacy lithography types, which impact mask cost, yield, and process complexity.. Valid values are `EUV|DUV|i-line|g-line|multi-patterning`',
    `lvs_clean` BOOLEAN COMMENT 'Indicates whether the final GDS layout passed Layout Versus Schematic (LVS) verification with zero discrepancies. Confirms that the physical layout matches the intended circuit schematic, a mandatory tapeout sign-off criterion.',
    `mask_cost_usd` DECIMAL(18,2) COMMENT 'Cost of the photolithography mask set fabrication for this tapeout in US dollars. A major component of NRE cost, tracked separately for cost accounting and foundry invoice reconciliation in SAP S/4HANA.',
    `mask_count` STRING COMMENT 'Total number of photolithography masks in the mask set for this tapeout. Directly drives NRE mask cost and is a key input to tapeout cost modeling. Includes FEOL, MOL, and BEOL layers.',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers in the Back End of Line (BEOL) stack for this tapeout. Determines routing density, RC parasitics, and mask count, directly impacting NRE cost and manufacturing complexity.',
    `notes` STRING COMMENT 'Free-text field for capturing tapeout-specific notes, known issues, approved waivers, or special foundry instructions that do not fit structured fields. Used by design and process engineering teams for context during silicon bring-up.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'Total Non-Recurring Engineering (NRE) cost committed for this tapeout in US dollars, including mask set fabrication, EDA tool licenses, and foundry engineering charges. A critical financial commitment recorded at tapeout sign-off. Classified confidential as it contains proprietary cost data.',
    `opc_ret_status` STRING COMMENT 'Processing status of Optical Proximity Correction (OPC) and Resolution Enhancement Technology (RET) applied to the GDS data prior to mask tape-out. OPC/RET is mandatory for sub-28nm nodes to compensate for photolithographic distortion effects.. Valid values are `not_started|in_progress|completed|waived`',
    `packaging_type` STRING COMMENT 'Intended die packaging technology for the taped-out design (e.g., WLCSP, CoWoS, InFO, flip-chip BGA, QFN). Informs OSAT engagement, assembly NRE planning, and downstream packaging domain linkage. [ENUM-REF-CANDIDATE: WLCSP|CoWoS|InFO|flip_chip_BGA|QFN|BGA|LGA|SiP — promote to reference product]',
    `process_node` STRING COMMENT 'Semiconductor manufacturing process node used for this tapeout, expressed as a technology node designation (e.g., 5nm, 7nm, 28nm, 65nm). Defines the lithography generation and transistor geometry for the fabricated IC.',
    `process_technology` STRING COMMENT 'Transistor architecture and process technology type used for this tapeout. Distinguishes between planar CMOS, FinFET, Gate-All-Around (GAA), and specialty process technologies relevant to device performance and yield modeling. [ENUM-REF-CANDIDATE: CMOS|FinFET|GAA|BiCMOS|SiGe|GaN|SiC|SOI — 8 candidates stripped; promote to reference product]',
    `signoff_checklist_complete` BOOLEAN COMMENT 'Indicates whether all items on the design sign-off checklist have been completed and approved prior to tapeout submission. The checklist covers DRC, LVS, ERC, timing closure, power analysis, DFT, and IP sign-off milestones.',
    `tapeout_date` DATE COMMENT 'The principal real-world business event date on which the final GDS/GDSII design data was submitted to the foundry or mask house for manufacturing. This is the definitive tapeout milestone date used in project tracking and TTM reporting.',
    `tapeout_number` STRING COMMENT 'Externally-known business identifier for the tapeout event, used in communications with the foundry, mask house, and internal design teams. Follows the format TO-<DESIGN_CODE>-<YEAR>.. Valid values are `^TO-[A-Z0-9]{4,20}-[0-9]{4}$`',
    `tapeout_status` STRING COMMENT 'Current lifecycle state of the tapeout event. Tracks progression from internal preparation through foundry acceptance or rejection. [ENUM-REF-CANDIDATE: draft|pending_signoff|submitted|accepted|rejected|cancelled — promote to reference product if additional states are needed]. Valid values are `draft|pending_signoff|submitted|accepted|rejected|cancelled`',
    `tapeout_type` STRING COMMENT 'Classification of the tapeout run type. Distinguishes full custom dedicated wafer tapeouts, Multi-Project Wafer (MPW) shuttle runs, engineering sample tapeouts, and production tapeouts. Drives cost allocation and foundry scheduling.. Valid values are `full_custom|mpw|engineering_sample|production`',
    `target_market_segment` STRING COMMENT 'Primary market segment for which the taped-out IC is designed. Used for business reporting, revenue forecasting, and strategic portfolio analysis. [ENUM-REF-CANDIDATE: mobile|automotive|datacenter|IoT|industrial|consumer|aerospace_defense|networking — promote to reference product]',
    `target_tapeout_date` DATE COMMENT 'Originally planned tapeout date as committed in the project schedule. Used to measure schedule adherence and Time to Market (TTM) variance against the actual tapeout date.',
    `timing_closure_status` STRING COMMENT 'Status of static timing analysis (STA) sign-off at tapeout. Indicates whether all timing paths met setup and hold constraints (clean), had approved waivers (waived), or had unresolved violations (failed). Sourced from Synopsys PrimeTime or Cadence Tempus.. Valid values are `clean|waived|failed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the tapeout record was last modified. Used for change tracking, audit compliance, and incremental data pipeline processing.',
    `wafer_count_ordered` STRING COMMENT 'Number of wafers ordered from the foundry for this tapeout run. Used for production planning, yield forecasting, and supply chain management. Applicable for dedicated tapeouts; for MPW runs, this reflects the allocated wafer share.',
    CONSTRAINT pk_tapeout PRIMARY KEY(`tapeout_id`)
) COMMENT 'Tapeout event record capturing the final design submission milestone for manufacturing. Records tapeout date, GDS/GDSII file version, mask set identifier, foundry submission reference, PDK version used, final DRC/LVS clean status, OPC/RET processing status, design sign-off checklist completion, NRE cost committed, and MPW shuttle assignment if applicable. SSOT for tapeout provenance linking design to fabrication domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` (
    `mpw_shuttle_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the MPW shuttle record. Primary key for this entity.',
    `supplier_id` BIGINT COMMENT 'FK to supply.supplier',
    `ic_design_project_id` BIGINT COMMENT 'FK to design.ic_design_project.ic_design_project_id — MPW shuttles serve multiple design projects. Need to track which projects participate in each shuttle for cost allocation and scheduling.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: Shuttle scheduling is planned within R&D programs; linking supports program‑level resource allocation tracking.',
    `actual_die_release_date` DATE COMMENT 'Actual date on which fabricated dies were released by the foundry. Compared against scheduled_die_release_date to assess foundry delivery performance and downstream packaging schedule impact.',
    `actual_tapeout_date` DATE COMMENT 'Actual date on which the final GDS/GDSII data package was submitted to the foundry for mask generation. Compared against scheduled_tapeout_date to measure tapeout schedule adherence and TTM performance.',
    `actual_wafer_start_date` DATE COMMENT 'Actual date on which the foundry commenced wafer processing for this MPW shuttle lot. Used to measure foundry schedule adherence and to calculate actual cycle time.',
    `allocated_project_count` STRING COMMENT 'Number of distinct IC design projects participating in and allocated die area within this MPW shuttle run. Tracks shuttle utilization and cost-sharing distribution.',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this MPW shuttle run qualifies for US CHIPS and Science Act incentives or subsidies based on domestic fabrication requirements, technology node, and participating project criteria.',
    `cost_per_mm2_usd` DECIMAL(18,2) COMMENT 'Unit cost in US Dollars per square millimeter of die area on this shuttle. Used to calculate each participating projects cost share based on their allocated die area. Derived from foundry pricing and total reticle area.',
    `cost_sharing_model` STRING COMMENT 'Method used to allocate the total shuttle cost among participating design projects. Proportional area charges each project based on die area consumed; fixed slot assigns equal shares; tiered applies volume-based rates; negotiated uses custom terms.. Valid values are `proportional_area|fixed_slot|tiered|negotiated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MPW shuttle record was first created in the system, capturing the initial planning entry. Used for audit trail and data lineage tracking in the Databricks Silver layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts recorded in this shuttle record (e.g., USD, EUR, TWD). Ensures consistent financial reporting and multi-currency reconciliation in SAP S/4HANA FI.. Valid values are `^[A-Z]{3}$`',
    `dfm_rule_set_version` STRING COMMENT 'Version identifier of the Design for Manufacturability (DFM) rule set that all participating designs must comply with for this shuttle. Ensures layout patterns meet foundry yield enhancement guidelines.',
    `dft_requirement_flag` BOOLEAN COMMENT 'Indicates whether participating designs in this shuttle are required to implement Design for Testability (DFT) structures (e.g., scan chains, BIST) as a condition of shuttle participation. True if DFT is mandatory.',
    `export_control_classification` STRING COMMENT 'Export control classification applicable to this shuttle run based on the process technology and participating design IP. Determines licensing requirements under EAR (Export Administration Regulations) and ITAR. Critical for foundry site selection and participant eligibility.. Valid values are `EAR99|ECCN_3E001|ECCN_3E002|ECCN_3E003|ITAR_controlled`',
    `foundry_account_manager` STRING COMMENT 'Name of the foundry-side account manager or technical program manager responsible for this MPW shuttle engagement. Used for escalation and commercial relationship management.',
    `gds_submission_format` STRING COMMENT 'File format required for final design data submission to the foundry for this shuttle. GDSII is the legacy industry standard; OASIS is the modern compressed alternative; LEF/DEF is used for certain digital flows.. Valid values are `GDSII|OASIS|LEF_DEF`',
    `ip_nda_required` BOOLEAN COMMENT 'Indicates whether participating design projects are required to execute a Non-Disclosure Agreement (NDA) to protect IP confidentiality within the shared MPW shuttle environment. Relevant for multi-company shuttle participation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this MPW shuttle record. Supports change tracking, audit compliance, and incremental data pipeline processing in the Databricks lakehouse.',
    `lithography_technology` STRING COMMENT 'Photolithography technology used for patterning in this shuttle run. Extreme Ultraviolet (EUV) is used for leading-edge nodes; Deep Ultraviolet (DUV) for mature nodes. Impacts mask cost, cycle time, and OPC complexity.. Valid values are `EUV|DUV|i-line|g-line|multi-patterning`',
    `mask_set_cost_usd` DECIMAL(18,2) COMMENT 'Cost in US Dollars for the full photomask set required for this shuttle run. Mask costs are a major NRE component, especially for EUV processes, and are shared across participating projects proportionally.',
    `nre_cost_center_code` STRING COMMENT 'SAP S/4HANA CO cost center code to which the NRE and shuttle fabrication costs are initially booked before being allocated to participating design projects. Supports financial controlling and budget tracking.',
    `process_design_kit_version` STRING COMMENT 'Version identifier of the Process Design Kit (PDK) provided by the foundry and used for all participating designs in this shuttle. Ensures all designs comply with the same design rules, device models, and layout constraints.',
    `process_node` STRING COMMENT 'Semiconductor process technology node used for fabrication, expressed as a technology generation label (e.g., 5nm, 7nm, 16nm FinFET, 28nm HPC+). Determines design rules, PDK version, and lithography requirements (EUV vs DUV).',
    `purchase_order_number` STRING COMMENT 'SAP S/4HANA MM purchase order number issued to the foundry for this MPW shuttle run. Links the shuttle record to procurement and accounts payable processes for financial reconciliation.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the materials and processes used in this shuttle run comply with the EU RoHS Directive restricting hazardous substances in electronic equipment. Required for products sold in EU markets.',
    `scheduled_die_release_date` DATE COMMENT 'Planned date for the foundry to complete fabrication and release diced wafers or Known Good Dies (KGD) to the customer or OSAT partner for packaging and assembly.',
    `scheduled_tapeout_date` DATE COMMENT 'Planned date by which all participating design projects must submit final GDS/GDSII data for the shuttle. Tapeout is the final design submission milestone triggering mask fabrication and wafer processing.',
    `scheduled_wafer_start_date` DATE COMMENT 'Planned date for the foundry to begin wafer processing (lot start) for this MPW shuttle. Marks the transition from design domain to fabrication domain in the IC development lifecycle.',
    `shuttle_code` STRING COMMENT 'Externally-known alphanumeric code assigned by the foundry or shuttle service provider to uniquely identify this MPW run. Used for cross-referencing with foundry purchase orders, lot tracking systems, and Camstar MES wafer lot records.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `shuttle_description` STRING COMMENT 'Free-text description of the MPW shuttle run, including its primary purpose, target applications, special process options (e.g., embedded non-volatile memory, RF options, high-voltage), and any notable constraints or conditions.',
    `shuttle_name` STRING COMMENT 'Human-readable name or label assigned to the MPW shuttle run, typically including foundry code, process node, and run sequence (e.g., TSMC-N5-MPW-2024Q3-01). Used as the primary business identifier across design and fabrication teams.',
    `shuttle_status` STRING COMMENT 'Current lifecycle state of the MPW shuttle run. Tracks progression from initial planning through tapeout submission, wafer start, active fabrication, and final completion or cancellation. [ENUM-REF-CANDIDATE: planning|open|tapeout_submitted|wafer_started|fabrication|completed|cancelled — promote to reference product]',
    `shuttle_type` STRING COMMENT 'Classification of the shuttle run by its purpose and risk profile. Standard MPW is a fully shared cost run; engineering run is for process validation; risk production is a pre-production volume run; prototype is a single-project low-volume run.. Valid values are `standard_mpw|engineering_run|risk_production|prototype`',
    `special_process_options` STRING COMMENT 'Comma-separated list of optional process modules or specialty layers enabled for this shuttle run (e.g., eNVM, RF, HV, MIM capacitor, thick metal). Participating designs must declare which options they require.',
    `submission_deadline_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone) by which all participating projects must submit their final GDS/GDSII data and sign-off documentation to the shuttle coordinator. Hard deadline; late submissions result in exclusion from the shuttle.',
    `total_reticle_area_mm2` DECIMAL(18,2) COMMENT 'Total usable reticle (mask field) area in square millimeters available for allocation across all participating design projects in this shuttle. Constrains the sum of all individual project die area allocations.',
    `total_shuttle_cost_usd` DECIMAL(18,2) COMMENT 'Total Non-Recurring Engineering (NRE) and fabrication cost in US Dollars for the entire MPW shuttle run, including mask set costs, wafer processing fees, and foundry service charges. Basis for cost-sharing allocation across participating projects.',
    `total_wafer_count` STRING COMMENT 'Total number of wafers allocated to this MPW shuttle run across all participating design projects. Determines total silicon area available for die allocation and directly impacts per-project die yield.',
    `wafer_diameter_mm` STRING COMMENT 'Diameter of the silicon wafer substrate in millimeters used in this shuttle run (e.g., 200mm, 300mm, 450mm). Determines total die area per wafer and influences cost-per-die calculations.',
    CONSTRAINT pk_mpw_shuttle PRIMARY KEY(`mpw_shuttle_id`)
) COMMENT 'Multi-Project Wafer (MPW) shuttle record managing shared wafer runs where multiple IC designs are fabricated together to reduce NRE costs. Captures shuttle name, foundry, process node, scheduled tapeout date, wafer start date, participating design projects, allocated die area per project, shuttle coordinator, cost-sharing terms, and shuttle status. Bridges design domain to fabrication domain for low-volume prototype runs.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` (
    `eda_tool_id` BIGINT COMMENT 'Unique surrogate identifier for each EDA tool record in the master catalog. Primary key for the eda_tool data product. Entity role: MASTER_RESOURCE — catalogues a tool asset owned/licensed by the business.',
    `license_agreement_id` BIGINT COMMENT 'add column license_agreement_id (BIGINT) with FK to product.license_agreement.license_agreement_id - EDA tools require license tracking',
    `supplier_id` BIGINT COMMENT 'add column supplier_id (BIGINT) with FK to supply.supplier.supplier_id - EDA tools are procured from vendors and need supplier linkage',
    `annual_license_cost_usd` DECIMAL(18,2) COMMENT 'Annual cost of the EDA tool license in US Dollars as contracted with the vendor. For perpetual licenses, represents the annual maintenance and support fee. Used for R&D cost allocation, NRE budgeting, and design cost-per-project analysis in SAP S/4HANA CO.',
    `approved_user_groups` STRING COMMENT 'Comma-separated list of authorized engineering groups or organizational units permitted to use this EDA tool (e.g., IC_Design,Physical_Design,DFT_Engineering). Used for access control enforcement, license allocation governance, and ITAR/EAR user screening compliance.',
    `compute_platform_type` STRING COMMENT 'Deployment model for this EDA tool: on_premise = installed on internal compute farm; cloud = deployed on cloud EDA platform (e.g., AWS, Azure, Cadence Cloud); hybrid = split between on-premise and cloud burst. Drives infrastructure cost allocation and data sovereignty compliance.. Valid values are `on_premise|cloud|hybrid`',
    `concurrent_users_peak` STRING COMMENT 'Maximum number of concurrent users or license checkouts observed for this tool during peak design activity periods (e.g., pre-tapeout crunch). Used to assess license adequacy, identify bottlenecks, and justify license pool expansion requests.',
    `design_flow_stage` STRING COMMENT 'Primary IC design flow stage at which this EDA tool is deployed. Maps to the standard front-to-back design flow: rtl_design (RTL coding and simulation), logic_synthesis (RTL-to-netlist via Design Compiler), physical_design (place-and-route via Innovus), signoff (STA/DRC/LVS/PEX), verification (formal/functional), packaging (assembly design), other. [ENUM-REF-CANDIDATE: rtl_design|logic_synthesis|physical_design|signoff|verification|packaging|other — 7 candidates stripped; promote to reference product]',
    `dfm_rule_set_version` STRING COMMENT 'Version identifier of the DFM rule set bundled with or validated against this EDA tool version (e.g., TSMC_N5_DFM_v2.1). Ensures that physical design outputs meet foundry DFM requirements for yield optimization. Critical for tapeout sign-off packages.',
    `dft_support_flag` BOOLEAN COMMENT 'Indicates whether this EDA tool includes or supports DFT capabilities such as ATPG, scan insertion, BIST, or boundary scan (IEEE 1149.1 JTAG). True = DFT-capable; False = no DFT support. Used to determine tool eligibility for DFT-required design projects.',
    `euv_process_support_flag` BOOLEAN COMMENT 'Indicates whether this EDA tool version is validated for use with EUV lithography process nodes (typically sub-7nm). True = EUV-qualified. Relevant for OPC, mask synthesis, and DRC tools where EUV-specific rule decks are required.',
    `export_control_classification` STRING COMMENT 'Export control classification code applicable to this EDA tool under US Export Administration Regulations (EAR) or ITAR (e.g., ECCN 3D002, EAR99, ITAR Category XV). Required for compliance with BIS/EAR and ITAR regulations governing the export and re-export of EDA software to foreign nationals and entities.',
    `flow_integration_point` STRING COMMENT 'Description of how this tool integrates into the enterprise EDA design flow, including upstream and downstream tool handoffs (e.g., Receives synthesized netlist from Synopsys DC; outputs DEF/LEF to Cadence Innovus; interfaces with PrimeTime for timing constraints). Used for flow documentation and tool dependency management.',
    `formal_verification_flag` BOOLEAN COMMENT 'Indicates whether this EDA tool supports formal verification methodologies (equivalence checking, model checking, property verification). True = formal verification capable. Used to classify tools for safety-critical design flows (automotive ISO 26262, IEC 61508).',
    `installation_path` STRING COMMENT 'File system path or network mount point where this EDA tool version is installed on the compute infrastructure (e.g., /tools/synopsys/dc/2023.09). Used by design flow scripts, Makefiles, and environment setup modules to locate the correct tool binary.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether this EDA tool is subject to ITAR controls, restricting its use, transfer, or disclosure to foreign persons without a license. True = ITAR-controlled; False = not ITAR-controlled. Mandatory for compliance with US State Department ITAR regulations.',
    `last_used_date` DATE COMMENT 'Most recent date on which a license checkout was recorded for this EDA tool version. Used to identify dormant or underutilized tools for license reclamation, cost optimization, and EOL planning decisions.',
    `license_count` STRING COMMENT 'Total number of license seats or tokens procured for this EDA tool version. For floating licenses, represents the maximum concurrent user count. For node-locked, represents the number of authorized hosts. Used for license compliance audits and capacity planning.',
    `license_expiry_date` DATE COMMENT 'Date on which the current EDA tool license agreement expires. Null for perpetual licenses. Used to trigger renewal workflows in SAP S/4HANA MM and to prevent design flow disruptions due to license lapses. Critical for SOX-compliant software asset management.',
    `license_server_host` STRING COMMENT 'Hostname or IP address of the FlexLM/RLM license server managing floating license pools for this tool. Null for node-locked or cloud-based licenses. Required for license server failover planning and network access control configuration.',
    `license_start_date` DATE COMMENT 'Date on which the current EDA tool license agreement becomes effective. Defines the start of the licensed usage period for subscription and term-based licenses. Used alongside license_expiry_date to determine the active license window for compliance reporting.',
    `license_type` STRING COMMENT 'Licensing model under which the EDA tool is procured and deployed. node_locked = tied to a specific compute host; floating = shared pool via FlexLM/RLM license server; subscription = time-limited SaaS or annual term; cloud = consumption-based cloud deployment; perpetual = one-time purchase with optional maintenance. Governs compliance obligations and cost allocation.. Valid values are `node_locked|floating|subscription|cloud|perpetual`',
    `license_utilization_pct` DECIMAL(18,2) COMMENT 'Average license utilization rate expressed as a percentage of total licensed seats consumed over the most recent reporting period (e.g., 78.50 = 78.5%). Calculated as (average concurrent checkouts / total license count) × 100. Used for license optimization, rightsizing, and vendor negotiation.',
    `maintenance_renewal_date` DATE COMMENT 'Date by which the annual maintenance and support contract for this EDA tool must be renewed to maintain access to patches, updates, and vendor support. Triggers procurement renewal workflow in SAP S/4HANA MM. Distinct from license_expiry_date for perpetual licenses.',
    `pdk_compatibility_version` STRING COMMENT 'Specific PDK version string with which this EDA tool version has been validated for correct DRC, LVS, and parasitic extraction results (e.g., TSMC_N5_PDK_v1.3, Samsung_SF3_PDK_v2.0). Ensures design rule compliance and sign-off accuracy for tapeout submissions.',
    `qualification_date` DATE COMMENT 'Date on which the EDA tool version was formally qualified and approved for production use in the enterprise design flow. Recorded in Oracle Agile PLM as part of the design tool change management record. Required for design audit trails and tapeout sign-off packages.',
    `qualification_status` STRING COMMENT 'Formal qualification status of the EDA tool version against the enterprise design methodology and PDK. qualified = passed all DRM/DFM/DFT checks and approved for production tapeouts; in_qualification = undergoing validation; not_qualified = failed or not yet tested; waived = approved with documented exceptions. Required for ISO 9001 and IATF 16949 design control compliance.. Valid values are `qualified|in_qualification|not_qualified|waived`',
    `qualified_by` STRING COMMENT 'Name or employee ID of the CAD/EDA engineer or team responsible for qualifying this tool version. Provides accountability for the qualification sign-off and is referenced in design methodology documentation and audit packages.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EDA tool record was first created in the master catalog. Provides audit trail for tool onboarding and is used for data lineage tracking in the Databricks Silver Layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this EDA tool record in the master catalog. Used for change tracking, data freshness monitoring, and incremental ETL processing in the Databricks Silver Layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `release_notes_url` STRING COMMENT 'URL or internal document management path to the vendor release notes for this specific tool version. Provides engineers with access to known issues, bug fixes, and new feature documentation. Stored in Siemens Teamcenter PLM document management.',
    `supported_os_platforms` STRING COMMENT 'Comma-separated list of operating system platforms on which this EDA tool version is certified to run (e.g., RHEL7,RHEL8,CentOS7,SLES15). Required for IT infrastructure planning, compute farm provisioning, and tool qualification sign-off.',
    `supported_process_nodes` STRING COMMENT 'Comma-separated list of semiconductor process technology nodes (in nanometers) for which this EDA tool version is qualified and PDK-validated (e.g., 3nm,5nm,7nm,12nm,28nm). Determines tool eligibility for specific tapeout projects. Validated against PDK release notes from foundry partners.',
    `tool_category` STRING COMMENT 'Functional classification of the EDA tool within the IC design flow. Drives tool selection, flow integration, and license budgeting. Valid categories: synthesis (logic synthesis), simulation (functional/timing simulation), formal_verification, place_and_route (physical implementation), sta (Static Timing Analysis), drc_lvs (Design Rule Check / Layout vs. Schematic), parasitic_extraction, power_analysis, signal_integrity, other. [ENUM-REF-CANDIDATE: synthesis|simulation|formal_verification|place_and_route|sta|drc_lvs|parasitic_extraction|power_analysis|signal_integrity|other — promote to reference product]',
    `tool_code` STRING COMMENT 'Externally-known, human-readable unique business identifier for the EDA tool (e.g., SYNOPSYS-DC-2023, CADENCE-INNOVUS-22). Used as the canonical reference code across PLM, procurement, and license management systems. Maps to the tool catalog number in Oracle Agile PLM.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `tool_description` STRING COMMENT 'Free-text description of the EDA tools functional capabilities, primary use cases, and design flow role. Provides context for engineers selecting tools for new projects and for onboarding documentation. Sourced from vendor product documentation and internal CAD team notes.',
    `tool_name` STRING COMMENT 'Full commercial name of the EDA tool as published by the vendor (e.g., Synopsys Design Compiler, Cadence Innovus Implementation System, Siemens Calibre DRC). Primary human-readable label used in design flow documentation and license agreements.',
    `tool_status` STRING COMMENT 'Current lifecycle state of the EDA tool in the enterprise design environment. active = qualified and in production use; deprecated = superseded but still permitted for legacy projects; evaluation = under qualification testing; retired = no longer licensed or supported; pending_qualification = awaiting PDK and flow validation sign-off.. Valid values are `active|deprecated|evaluation|retired|pending_qualification`',
    `tool_version` STRING COMMENT 'Specific release version string of the EDA tool as provided by the vendor (e.g., 2023.09, v22.1, 21.1.0.1). Critical for design reproducibility, PDK compatibility validation, and regression testing. Tracked in Siemens Teamcenter PLM for design provenance.. Valid values are `^[A-Za-z0-9.-_]{1,40}$`',
    `vendor_contract_number` STRING COMMENT 'Vendor-assigned or internally-assigned contract reference number for the EDA tool license agreement. Links this tool record to the corresponding procurement contract in SAP S/4HANA MM for spend tracking, renewal management, and audit compliance.',
    `vendor_name` STRING COMMENT 'Name of the EDA software vendor supplying the tool (e.g., Cadence Design Systems, Synopsys, Siemens EDA, Ansys, Mentor Graphics). Used for vendor management, procurement, and license compliance tracking.',
    `vendor_support_tier` STRING COMMENT 'Level of vendor technical support contracted for this EDA tool (e.g., standard = business-hours support; premium = 24/7 with dedicated TAM; elite = on-site engineering support; end_of_support = vendor no longer provides patches or fixes). Impacts risk assessment for production tapeout use.. Valid values are `standard|premium|elite|end_of_support`',
    CONSTRAINT pk_eda_tool PRIMARY KEY(`eda_tool_id`)
) COMMENT 'EDA (Electronic Design Automation) tool master record cataloging all licensed design automation tools used across the IC design flow. Captures tool name, vendor (Cadence, Synopsys, Siemens EDA, Ansys), tool category (synthesis, simulation, formal verification, place-and-route, STA, DRC/LVS, parasitic extraction, power analysis, signal integrity), version, license type (node-locked, floating, subscription), license count, supported process nodes, flow integration points, and license utilization metrics. SSOT for EDA tool inventory, version management, and license compliance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`rule_set` (
    `rule_set_id` BIGINT COMMENT 'Unique surrogate identifier for the design rule set record in the semiconductor design domain. Primary key for the design_rule_set data product.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the engineering authority who formally approved this rule set version for production use. Distinct from the owner; the approver provides independent technical sign-off per the deviation approval workflow.',
    `eda_tool_id` BIGINT COMMENT 'Foreign key linking to design.eda_tool. Business justification: A rule set targets a particular EDA tool; the FK provides a concrete link and removes duplicated compatibility descriptors.',
    `owner_employee_id` BIGINT COMMENT 'Employee identifier of the designated rule set owner accountable for its accuracy, versioning, and approval workflow. References the workforce record in Workday HCM. The owner is the primary point of contact for rule interpretation and waiver decisions.',
    `parent_rule_set_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent rule set from which this rule set was derived or branched. Supports hierarchical rule set structures where project-specific rule sets inherit from a foundry-standard base deck.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Design rule sets are tied to a specific PDK; the FK replaces string version fields and enables direct rule‑set to PDK navigation.',
    `primary_superseded_by_rule_set_id` BIGINT COMMENT 'Reference to the design_rule_set_id of the newer rule set version that replaces this one when status is Superseded. Enables forward navigation of the rule set version chain for design migration planning.',
    `applicable_design_phase` STRING COMMENT 'IC design lifecycle phase during which this rule set is enforced. RTL = register-transfer level; Synthesis = logic synthesis; Floorplan = physical planning; Place-and-Route = physical implementation; Signoff = pre-tapeout verification; Tapeout = final GDS/GDSII submission check.. Valid values are `RTL|Synthesis|Floorplan|Place-and-Route|Signoff|Tapeout`',
    `approval_date` DATE COMMENT 'Date on which this rule set version received formal engineering approval and was cleared for production use. Distinct from effective_from_date; approval may precede the effective date to allow design teams preparation time.',
    `approved_waiver_count` STRING COMMENT 'Number of currently active, formally approved waivers against rules in this rule set. Provides a quick quality signal; high waiver counts may indicate rule set misalignment with design intent or process capability.',
    `authored_by_team` STRING COMMENT 'Name of the internal engineering team or external foundry group responsible for authoring and maintaining this rule set. Examples: DFM-Engineering, DFT-Architecture, Foundry-PDK-Team, Process-Integration. Used for ownership tracking and escalation routing.',
    `rule_set_category` STRING COMMENT 'Categorizes the origin and scope of the rule set relative to the base PDK rule deck. Supplemental rules extend the foundry PDK; Project-Specific rules apply only to a named design project; Foundry-Standard rules are delivered directly by the foundry; Internal-Engineering rules are authored by the IC design team; Customer-Mandated rules are imposed by an end customer.. Valid values are `Supplemental|Project-Specific|Foundry-Standard|Internal-Engineering|Customer-Mandated`',
    `change_control_number` STRING COMMENT 'Formal change control number assigned by Oracle Agile PLM or Siemens Teamcenter when this rule set version was created or modified through the engineering change management process. Provides full audit traceability to the change record.. Valid values are `^CCN-[0-9]{6,10}$`',
    `rule_set_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this rule set across design teams, EDA tools, and foundry interfaces. Used as the business key in Cadence Virtuoso, Synopsys IC Validator, and Siemens Calibre configurations. Example: DRS-DFM-N5-2024-R3.. Valid values are `^[A-Z0-9_-]{3,40}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design rule set record was first created in the data platform. Provides the audit trail creation anchor for the Silver layer lakehouse record.',
    `rule_set_description` STRING COMMENT 'Free-text narrative description of the rule sets purpose, scope, and key engineering rationale. Provides context for design engineers selecting rule sets and for auditors reviewing tapeout compliance packages.',
    `deviation_approval_workflow` STRING COMMENT 'Defines the change control workflow required to approve deviations or modifications to this rule set. None = no formal workflow; Single-Approver = one designated approver; Dual-Approver = two independent approvers required; Change-Control-Board = full CCB review required per Oracle Agile PLM change management process.. Valid values are `None|Single-Approver|Dual-Approver|Change-Control-Board`',
    `effective_from_date` DATE COMMENT 'Date from which this rule set version is binding and enforceable in design flows. Designs initiated on or after this date must comply with this version. Supports temporal rule set management across concurrent design projects.',
    `effective_until_date` DATE COMMENT 'Date after which this rule set version is no longer valid for new design starts. Null indicates the rule set is open-ended with no planned expiry. Enables orderly transition to superseding rule set versions.',
    `export_control_classification` STRING COMMENT 'Export control classification of this rule set under US EAR (Export Administration Regulations) or ITAR (International Traffic in Arms Regulations). Governs whether the rule set can be shared with foreign nationals, subsidiaries, or foundry partners. Classified confidential due to regulatory sensitivity.. Valid values are `EAR99|ECCN-3E001|ECCN-3E002|ITAR-Controlled|Not-Classified`',
    `feol_beol_scope` STRING COMMENT 'Indicates which portion of the wafer fabrication stack the rules in this set govern. FEOL = transistor-level rules (gate, diffusion, well); BEOL = interconnect and metal layer rules; MOL = middle-of-line contact and via rules; Full-Stack = rules spanning all layers; Not-Applicable = for non-physical rule sets such as DFT scan rules.. Valid values are `FEOL|BEOL|MOL|Full-Stack|Not-Applicable`',
    `foundry_source` STRING COMMENT 'Name of the semiconductor foundry or internal engineering team that authored or supplied this rule set. Examples: TSMC, Samsung Foundry, GlobalFoundries, Internal-DFM-Team. Establishes provenance and accountability for rule content.',
    `ip_classification` STRING COMMENT 'Intellectual property ownership classification of the rule set content. Proprietary = owned by the company; Foundry-Confidential = supplied under NDA by the foundry; Third-Party-Licensed = licensed from an EDA vendor or IP provider; Open-Standard = based on publicly available standards. Governs distribution and usage rights.. Valid values are `Proprietary|Foundry-Confidential|Third-Party-Licensed|Open-Standard`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this design rule set record in the data platform. Used for incremental data pipeline processing, change detection, and audit compliance.',
    `lithography_type` STRING COMMENT 'Lithography exposure technology assumed by the rules in this set. EUV = Extreme Ultraviolet; DUV = Deep Ultraviolet (193nm immersion); Multi-Patterning = SADP/SAQP patterning rules; Nanoimprint = NIL-specific rules; Not-Applicable = for non-lithography rule sets. Drives OPC and MEEF-related rule thresholds.. Valid values are `EUV|DUV|Multi-Patterning|Nanoimprint|Not-Applicable`',
    `mpw_compatible` BOOLEAN COMMENT 'Indicates whether this rule set is certified for use in Multi-Project Wafer (MPW) shuttle runs, where multiple customer designs share a single wafer. MPW-compatible rule sets must satisfy additional density and boundary isolation requirements.',
    `rule_set_name` STRING COMMENT 'Human-readable descriptive name of the design rule set, used in PLM and EDA tool dashboards. Example: N5 DFM Supplemental Rules Rev3 or TSMC 7nm Antenna Rule Deck.',
    `nre_impact` BOOLEAN COMMENT 'Indicates whether violations of this rule set have Non-Recurring Engineering (NRE) cost implications, such as requiring mask re-spins or additional foundry qualification runs. Used in project risk and cost management reporting.',
    `opc_required` BOOLEAN COMMENT 'Indicates whether Optical Proximity Correction (OPC) must be applied to layouts before this rule sets DRC checks are considered valid. True = OPC is a prerequisite for rule compliance; False = rules apply to pre-OPC geometry.',
    `release_notes` STRING COMMENT 'Summary of changes, additions, and deletions introduced in this version of the rule set relative to the previous version. Enables design teams to assess migration impact when upgrading to a new rule set version.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the design rules in this set enforce compliance with the EU RoHS Directive (Restriction of Hazardous Substances), ensuring that designs using this rule set will not specify materials or processes that violate RoHS substance restrictions.',
    `rule_count` STRING COMMENT 'Total number of individual design rules contained within this rule set. Used for completeness validation, rule coverage reporting, and comparison across rule set versions to detect additions or deletions.',
    `rule_deck_checksum` STRING COMMENT 'SHA-256 cryptographic hash of the rule deck file, used to verify integrity and detect unauthorized modifications. Enables audit trail compliance and ensures the exact rule deck used at tapeout is reproducible.. Valid values are `^[a-fA-F0-9]{64}$`',
    `rule_deck_file_path` STRING COMMENT 'Canonical file system or object storage path to the rule deck source file(s) for this rule set. Stored in the design data repository (e.g., Cadence Design Intent or Teamcenter vault). Classified confidential as it reveals internal IP and design infrastructure topology.',
    `rule_set_status` STRING COMMENT 'Current lifecycle state of the rule set governing its usability in active design flows. Draft = under authoring; Under-Review = pending engineering sign-off; Approved = cleared for use; Active = currently enforced in production flows; Deprecated = no longer recommended; Superseded = replaced by a newer version.. Valid values are `Draft|Under-Review|Approved|Active|Deprecated|Superseded`',
    `rule_set_type` STRING COMMENT 'Classification of the rule set by its engineering function. DRC = Design Rule Check (geometric), LVS = Layout vs. Schematic, ERC = Electrical Rule Check, DFM = Design for Manufacturability recommended rules, DFT = Design for Testability scan insertion rules, Antenna = metal antenna effect rules, Density = metal/poly fill density rules, Custom = project-specific overrides. [ENUM-REF-CANDIDATE: DRC|LVS|ERC|DFM|DFT|Antenna|Density|Custom — 8 candidates stripped; promote to reference product]',
    `severity_classification` STRING COMMENT 'Default severity level assigned to violations of rules within this rule set. Error = must be resolved before tapeout; Warning = requires engineering review; Advisory = informational, no blocking action; Waivable = can be formally waived with approval. Individual rules may override this default.. Valid values are `Error|Warning|Advisory|Waivable`',
    `technology_family` STRING COMMENT 'Semiconductor device technology family for which this rule set is applicable. Examples: FinFET, GAA (Gate All Around), Planar CMOS, BiCMOS, SiGe, GaN. Determines the physical and electrical rule paradigms encoded in the rule set.',
    `version` STRING COMMENT 'Semantic version string of the rule set, enabling precise traceability of rule evolution across tapeout cycles. Follows major.minor.patch[-qualifier] convention. Example: 2.1.0-RC1. Aligns with PDK versioning cadence from the foundry.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?(-[A-Za-z0-9]+)?$`',
    `waiver_policy` STRING COMMENT 'Defines the approval authority required to grant a waiver for violations of rules in this set. No-Waiver = violations are never waivable; Engineering-Approval = design engineering lead sign-off required; Management-Approval = director or VP sign-off required; Foundry-Approval = foundry must co-sign the waiver.. Valid values are `No-Waiver|Engineering-Approval|Management-Approval|Foundry-Approval`',
    CONSTRAINT pk_rule_set PRIMARY KEY(`rule_set_id`)
) COMMENT 'Design rule set master record defining collections of DFM (Design for Manufacturability), DFT (Design for Testability), and custom design rules beyond the base PDK rule deck. Captures rule set type (supplemental DRC, project-specific LVS, ERC, DFM recommended rules, DFT scan insertion rules, antenna rules, density rules), rule version, foundry source or internal engineering team, applicable PDK version baseline, rule count, severity classification, waiver policy and approved waiver log, tool compatibility (Calibre, IC Validator, Pegasus), and deviation approval workflow. Enables project-specific rule customization, rule evolution tracking, and consistent enforcement across design teams beyond the foundry-standard PDK rules.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` (
    `simulation_run_id` BIGINT COMMENT 'Unique system-generated identifier for each simulation or verification run record. Primary key for the simulation_run data product.',
    `eda_tool_id` BIGINT COMMENT 'Foreign key linking to design.eda_tool. Business justification: Simulation runs are executed with a particular EDA tool; linking to eda_tool centralizes tool metadata and removes redundant name/version columns.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Simulation compute resource consumption is charged to an internal order for cost recovery and budgeting.',
    `netlist_id` BIGINT COMMENT 'FK to design.netlist.netlist_id — Simulation runs execute against a specific netlist or schematic version. Required for verification traceability.',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) version used during this simulation or verification run. The PDK defines the foundry process rules, device models, and design rule decks applied.',
    `ic_design_project_id` BIGINT COMMENT 'FK to design.ic_design_project.ic_design_project_id — All verification runs belong to a project. Required for verification closure tracking and sign-off dashboards.',
    `project_id` BIGINT COMMENT 'Reference to the IC design project or product program under which this simulation run was executed. Enables project-level verification closure tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Simulation run sign‑off requires the verifying engineers ID; used in verification sign‑off report.',
    `assertion_coverage_pct` DECIMAL(18,2) COMMENT 'Percentage of SystemVerilog Assertions (SVA) or PSL assertions that were triggered and evaluated during this simulation run. Measures the effectiveness of assertion-based verification.',
    `code_coverage_pct` DECIMAL(18,2) COMMENT 'Percentage of RTL or gate-level code coverage achieved by this simulation run, aggregating line, branch, condition, expression, and FSM coverage metrics. Indicates structural completeness of verification.',
    `compute_cluster` STRING COMMENT 'Name or identifier of the compute farm, LSF cluster, or cloud compute environment on which this simulation run was executed. Supports infrastructure cost allocation and capacity utilization analysis.',
    `cpu_hours_consumed` DECIMAL(18,2) COMMENT 'Total CPU compute hours consumed by this simulation run across all parallel processes. Used for compute cost allocation, capacity planning, and NRE (Non-Recurring Engineering) cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this simulation run record was first created in the data platform. Provides the audit trail creation timestamp for data governance and lineage tracking.',
    `design_stage` STRING COMMENT 'Stage in the IC design flow at which this simulation or verification run was performed. Indicates whether the run was executed on pre-synthesis RTL, post-synthesis netlist, or post-layout (GDSII) data, supporting design closure tracking.. Valid values are `pre_synthesis|post_synthesis|post_layout|post_mask|tapeout`',
    `design_version` STRING COMMENT 'Version label of the design artifact (RTL, gate-level netlist, or physical layout GDSII) that was the subject of this simulation or verification run (e.g., v2.4.1, GDS_tapeout_r7).',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the simulation or verification run completed, failed, or was aborted. Used together with start_timestamp to compute run duration for capacity planning and SLA tracking.',
    `functional_coverage_pct` DECIMAL(18,2) COMMENT 'Percentage of functional coverage points (covergroups, coverpoints, cross-coverage) exercised by this simulation run. Measures how thoroughly the design specification has been verified. Applicable to functional simulation runs.',
    `pass_fail_status` STRING COMMENT 'Overall verification outcome of the simulation run indicating whether the design passed all checks, failed one or more checks, had violations waived by engineering sign-off, or produced an inconclusive result. Critical for tapeout sign-off compliance.. Valid values are `pass|fail|waived|inconclusive`',
    `peak_memory_gb` DECIMAL(18,2) COMMENT 'Maximum RAM memory consumed in gigabytes during this simulation run. Critical for compute infrastructure sizing, job scheduling, and identifying memory-intensive verification tasks.',
    `process_corner` STRING COMMENT 'Process corner of the PVT (Process, Voltage, Temperature) operating condition under which this simulation run was executed. Defines the transistor performance variation (e.g., TT=typical-typical, FF=fast-fast, SS=slow-slow, FS=fast-slow, SF=slow-fast). [ENUM-REF-CANDIDATE: tt|ff|ss|fs|sf|typical|fast|slow — 8 candidates stripped; promote to reference product]',
    `regression_suite_name` STRING COMMENT 'Name of the regression test suite or verification plan to which this simulation run belongs. Enables grouping of runs for regression tracking, coverage closure, and sign-off milestone reporting.',
    `rule_deck_name` STRING COMMENT 'Name of the design rule deck, constraint file, or property specification used for this run (e.g., DRC rule deck, LVS rule file, CDC constraint file, formal property set). Identifies the specific rule set version applied for compliance checking.',
    `rule_deck_version` STRING COMMENT 'Version identifier of the rule deck or constraint file applied in this run. Tracks which revision of foundry DRC/LVS rules or EDA property specifications was used, supporting audit and regression analysis.',
    `run_duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed wall-clock time in minutes from run start to completion or termination. Supports compute resource planning, bottleneck identification, and EDA tool performance benchmarking.',
    `run_identifier` STRING COMMENT 'Externally-known alphanumeric run identifier or job ID as assigned by the EDA tool scheduler or MES (e.g., Cadence job ID, LSF job number, or Synopsys run tag). Used for cross-system traceability.',
    `run_name` STRING COMMENT 'Human-readable name or label assigned to this simulation or verification run, typically including design block, run type, and iteration identifier (e.g., TOP_DRC_PostLayout_v3.2).',
    `run_notes` STRING COMMENT 'Free-text engineering notes, observations, or disposition comments associated with this simulation run. Captures context such as known issues, waiver justifications, or follow-up actions required.',
    `run_status` STRING COMMENT 'Current lifecycle state of the simulation or verification run, tracking execution progress from job submission through completion or failure.. Valid values are `queued|running|completed|failed|aborted|timed_out`',
    `run_subtype` STRING COMMENT 'Further classification of the simulation run within its run_type, specifying the abstraction level or scope (e.g., RTL functional simulation, gate-level simulation, post-layout SPICE, mixed-signal AMS co-simulation). [ENUM-REF-CANDIDATE: rtl|gate_level|post_layout|spice|mixed_signal|full_chip|block_level|subsystem — 8 candidates stripped; promote to reference product]',
    `run_type` STRING COMMENT 'Classification of the verification or checking run by methodology. Indicates the primary verification technique applied. [ENUM-REF-CANDIDATE: functional_simulation|drc|lvs|erc|formal_equivalence|model_checking|property_checking|cdc_analysis|rdc_analysis|spice_simulation|ams_cosimulation|ir_drop|em_analysis|signal_integrity|electromigration|timing_analysis|atpg — promote to reference product]',
    `signoff_approved` BOOLEAN COMMENT 'Indicates whether this simulation run has been formally approved as part of the design verification sign-off process for tapeout clearance. True when an authorized engineer has reviewed and accepted the run results.',
    `signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the formal verification sign-off approval was granted for this simulation run. Establishes the audit timestamp for tapeout compliance documentation.',
    `simulation_to_ruleset` BIGINT COMMENT 'FK to design.design_rule_set.design_rule_set_id — DRC/LVS/ERC simulation runs execute against a specific design rule set version. Required for audit trail of which rules were applied.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the simulation or verification run was initiated on the compute infrastructure. Used for run duration calculation, scheduling analysis, and compute resource utilization reporting.',
    `supply_voltage_v` DECIMAL(18,2) COMMENT 'Nominal supply voltage in volts applied during this simulation run as part of the PVT (Process, Voltage, Temperature) operating corner specification (e.g., 0.9000, 1.0500, 1.8000).',
    `tapeout_milestone` STRING COMMENT 'Design milestone context in which this simulation run was executed, indicating whether it was part of pre-tapeout verification, tapeout freeze sign-off, post-tapeout validation, or an MPW (Multi-Project Wafer) shuttle submission.. Valid values are `pre_tapeout|tapeout_freeze|post_tapeout|mpw_shuttle|not_applicable`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Operating temperature in degrees Celsius applied during this simulation run as part of the PVT (Process, Voltage, Temperature) corner specification (e.g., -40.00, 25.00, 125.00).',
    `testbench_name` STRING COMMENT 'Name of the simulation testbench or stimulus file used for functional simulation runs (RTL, gate-level, SPICE, AMS co-simulation). Identifies the verification environment applied to exercise the design under test.',
    `toggle_coverage_pct` DECIMAL(18,2) COMMENT 'Percentage of signal toggle coverage achieved in this simulation run, measuring how many design signals transitioned both 0-to-1 and 1-to-0 during simulation. Supports DFT (Design for Testability) analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this simulation run record was last modified in the data platform. Supports change tracking, data freshness monitoring, and audit compliance.',
    `violation_count_error` STRING COMMENT 'Number of violations classified at error severity level in this run. Error-level violations typically block tapeout sign-off and require mandatory resolution before design release.',
    `violation_count_total` STRING COMMENT 'Total number of violations, errors, or failures detected across all severity levels in this simulation or verification run. Primary quantitative outcome metric for DRC, LVS, ERC, formal, and functional runs.',
    `violation_count_waived` STRING COMMENT 'Number of violations formally waived by engineering sign-off in this run. Waived violations are acknowledged exceptions documented for tapeout compliance audit trail.',
    `violation_count_warning` STRING COMMENT 'Number of violations classified at warning severity level in this run. Warning-level violations require engineering review and documented disposition but may be waived with justification.',
    CONSTRAINT pk_simulation_run PRIMARY KEY(`simulation_run_id`)
) COMMENT 'Verification and checking execution record capturing all pre-silicon verification run results including functional simulation (RTL, gate-level, SPICE, mixed-signal AMS co-simulation), design rule checking (DRC, LVS, ERC), formal verification (equivalence checking, model checking, property checking, CDC analysis, RDC analysis), power integrity analysis (IR-drop, EM), signal integrity analysis, and reliability checking (electromigration, self-heating). Tracks run type, EDA tool and version used, rule deck or stimulus/testbench reference, functional/code/toggle/assertion coverage achieved, violation count and severity breakdown, overall pass/fail status, compute resources consumed (CPU hours, memory peak), run duration, operating corner conditions (PVT - process, voltage, temperature), design stage (pre-synthesis, post-synthesis, post-layout), regression suite membership, and linkage to the specific netlist, RTL, or physical layout version verified. Provides the complete audit trail for design verification closure and tapeout sign-off compliance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` (
    `ip_core_usage_id` BIGINT COMMENT 'Unique surrogate identifier for each IP core integration instance record within a design project. Primary key for the ip_core_usage entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: IP core licensing fees are allocated to a cost center for expense tracking in project budgets.',
    `design_ip_core_id` BIGINT COMMENT 'Reference to the specific IP core being integrated. Identifies the IP block (e.g., PCIe controller, DDR PHY, USB subsystem) from the IP catalog.',
    `employee_id` BIGINT COMMENT 'Reference to the design engineer responsible for integrating this IP core into the design project. Used for accountability tracking, workload management, and design review assignment.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Integration and validation costs of IP cores are captured via internal orders for capital budgeting.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the governing license agreement under which this IP core is used in this design project. Enables license compliance auditing and royalty obligation tracking.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW (Multi-Project Wafer) shuttle run in which this IP core integration was included, if applicable. Used for prototype and early silicon validation cost tracking.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the IC design project (SoC, ASIC, or FPGA design) into which this IP core version is being integrated. Links the usage record to the parent design context.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Royalty revenue from IP core usage is credited to a profit center for profitability reporting.',
    `source_design_project_ic_design_project_id` BIGINT COMMENT 'Reference to the original design project from which this IP core integration was reused, when ip_reuse_flag is True. Enables IP reuse lineage tracking and qualification inheritance assessment.',
    `tapeout_id` BIGINT COMMENT 'Reference to the tapeout event (final GDSII submission for manufacturing) in which this IP core integration was included. Links IP usage to the specific fabrication submission for traceability.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Detailed cost allocation of IP core usage is tracked against WBS elements for project accounting.',
    `area_consumed_um2` DECIMAL(18,2) COMMENT 'Physical silicon area consumed by this IP core integration in square micrometers (µm²). Used for die area budget tracking, PPA (Power, Performance, Area) analysis, and cost estimation.',
    `clock_frequency_mhz` DECIMAL(18,2) COMMENT 'Target operating clock frequency in megahertz (MHz) for this IP core integration in the design context. Used for timing closure planning and STA (Static Timing Analysis) constraint setup.',
    `configuration_parameters` STRING COMMENT 'Serialized key-value string of configuration parameters applied to this IP core instance (e.g., data_width=64, num_channels=8, fifo_depth=512). Captures the specific parameterization used in this design context for reproducibility and IP reuse analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP core usage record was first created in the system. Used for audit trail, data lineage, and record provenance tracking in the Databricks Silver Layer.',
    `design_hierarchy_path` STRING COMMENT 'Full hierarchical path of the IP core instance within the design netlist (e.g., top/subsystem_a/pcie_ctrl_0). Enables precise identification of the IP instance location in the design hierarchy for debug, ECO, and physical implementation.',
    `export_control_classification` STRING COMMENT 'Export control classification of this IP core under US EAR (Export Administration Regulations) or ITAR (International Traffic in Arms Regulations). Determines permissible countries and end-users for design sharing and IP transfer. Critical for regulatory compliance.. Valid values are `EAR99|ECCN_3E001|ECCN_3E002|ECCN_3E003|ITAR|unrestricted`',
    `functional_coverage_pct` DECIMAL(18,2) COMMENT 'Functional verification coverage percentage achieved for this IP core integration, as reported by the verification environment. Used for sign-off readiness assessment and quality gate enforcement.',
    `instance_count` STRING COMMENT 'Number of times this IP core is instantiated within the design project (e.g., 4 instances of a SERDES PHY). Drives royalty calculation for royalty-bearing IP and area budget planning.',
    `integration_start_date` DATE COMMENT 'Calendar date on which integration of this IP core into the design project was initiated. Used for project timeline tracking, TTM (Time to Market) analysis, and design schedule management.',
    `integration_status` STRING COMMENT 'Current lifecycle state of the IP core integration within the design project. Tracks progression from initial selection through silicon validation: planned (selected but not yet integrated), in_progress (integration underway), verified (simulation/emulation verified), silicon_proven (validated on fabricated silicon).. Valid values are `planned|in_progress|verified|silicon_proven`',
    `interface_protocol` STRING COMMENT 'Primary bus or interface protocol used to connect this IP core to the SoC interconnect fabric (e.g., AXI4, AHB, APB, CHI, TileLink, OCP). Critical for integration verification and bus protocol compliance checking. [ENUM-REF-CANDIDATE: AXI4|AHB|APB|CHI|TileLink|OCP|AXI4-Lite|AXI4-Stream|Wishbone|AMBA — promote to reference product]',
    `ip_core_version` STRING COMMENT 'Specific version identifier of the IP core being integrated (e.g., 2.1.0, 3.0.0-rc1). Tracks which release of the IP block is used in this design context to support IP lifecycle and change management.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?([a-zA-Z0-9_-]*)?$`',
    `ip_reuse_flag` BOOLEAN COMMENT 'Indicates whether this IP core integration is a reuse of a previously silicon-proven instance from another design project (True = reused IP, False = first-time integration). Enables IP reuse analytics and NRE cost avoidance tracking.',
    `ip_usage_to_core` BIGINT COMMENT 'FK to design.ip_core.ip_core_id — Each usage record references which IP core from the catalog is being integrated. Essential for IP reuse analytics and license compliance.',
    `is_dfm_compliant` BOOLEAN COMMENT 'Indicates whether this IP core integration has passed DFM (Design for Manufacturability) rule checks for the target process node (True = DFM compliant). Critical for yield optimization and tapeout readiness sign-off.',
    `is_dft_enabled` BOOLEAN COMMENT 'Indicates whether DFT (Design for Testability) structures such as scan chains, BIST, or JTAG boundary scan are enabled for this IP core integration (True = DFT enabled). Impacts ATPG test pattern generation and ATE test coverage.',
    `is_silicon_proven` BOOLEAN COMMENT 'Indicates whether this IP core version has been validated on fabricated silicon within this specific design project context (True = silicon-proven, False = not yet silicon-proven). Key qualifier for IP reuse qualification and KGD (Known Good Die) assessments.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP core usage record was most recently modified. Used for change tracking, incremental data pipeline processing, and audit compliance.',
    `license_type` STRING COMMENT 'Licensing model under which the IP core is used in this design: royalty_bearing (per-unit royalty owed on production), perpetual (one-time NRE fee, unlimited use), subscription (time-limited access), internal (internally developed IP, no external license), open_source (open-source licensed IP). Critical for license compliance auditing and cost accounting.. Valid values are `royalty_bearing|perpetual|subscription|internal|open_source`',
    `notes` STRING COMMENT 'Free-text field for capturing integration-specific observations, known issues, workarounds, or deviations from standard integration procedures. Supports design review documentation and knowledge transfer.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'Non-Recurring Engineering cost in US dollars associated with licensing or customizing this IP core for the design project. Includes one-time integration fees, customization charges, and support costs. Used for design project cost accounting.',
    `pdk_node` STRING COMMENT 'Semiconductor process technology node for which this IP core version is qualified (e.g., 5nm, 7nm, 28nm). Ensures IP-PDK compatibility and is critical for physical design sign-off and DFM compliance.',
    `power_contribution_mw` DECIMAL(18,2) COMMENT 'Estimated power consumption contributed by this IP core integration in milliwatts (mW), covering dynamic and static power. Used for top-level power budget analysis and PPA optimization.',
    `royalty_rate_per_unit` DECIMAL(18,2) COMMENT 'Per-unit royalty rate in US dollars payable to the IP licensor for each chip shipped containing this IP core. Applicable only for royalty_bearing license types. Used for royalty obligation forecasting and financial accruals.',
    `sign_off_date` DATE COMMENT 'Calendar date on which the formal design sign-off for this IP core integration was granted or last updated. Used for tapeout readiness tracking and audit trail.',
    `sign_off_status` STRING COMMENT 'Design sign-off status for this IP core integration, reflecting the outcome of formal design review and approval gates (pending, approved, rejected, waived). Required for tapeout readiness and quality gate compliance.. Valid values are `pending|approved|rejected|waived`',
    `silicon_validation_date` DATE COMMENT 'Calendar date on which silicon validation of this IP core integration was completed, confirming silicon-proven status. Null if silicon validation has not yet occurred.',
    `supply_voltage_v` DECIMAL(18,2) COMMENT 'Operating supply voltage in volts (V) for this IP core integration. Used for power domain planning, multi-voltage design verification, and UPF (Unified Power Format) constraint generation.',
    `timing_budget_ns` DECIMAL(18,2) COMMENT 'Timing budget allocated to this IP core integration in nanoseconds (ns), representing its contribution to the top-level timing closure budget. Derived from Synopsys PrimeTime timing analysis and used for STA sign-off.',
    `usage_to_core` BIGINT COMMENT 'FK to design.ip_core.ip_core_id — IP core usage records which IP core is being integrated. This is the fundamental FK for the association record.',
    `verification_completion_date` DATE COMMENT 'Calendar date on which functional verification of this IP core integration was completed and signed off. Marks the transition from in_progress to verified integration status.',
    `verification_methodology` STRING COMMENT 'Verification methodology applied to validate this IP core integration (e.g., UVM, OVM, formal verification, emulation, FPGA prototype). Determines verification coverage and sign-off criteria. [ENUM-REF-CANDIDATE: UVM|OVM|VMM|formal|emulation|FPGA_prototype|mixed — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_ip_core_usage PRIMARY KEY(`ip_core_usage_id`)
) COMMENT 'Integration instance record capturing the deployment of a specific IP core version into an IC design project, with full lifecycle from selection through silicon validation. Tracks IP core version used, integration status (planned, in-progress, verified, silicon-proven), configuration parameters applied, interface connections and bus protocol mappings, timing constraints contributed to the top-level budget, physical area consumed, power contribution, licensing compliance status (royalty-bearing, perpetual, subscription), and silicon-proven flag for this design context. Enables IP reuse analytics, license compliance auditing across design projects, and IP qualification tracking. SSOT for the many-to-many relationship between IP cores and design projects.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` (
    `design_milestone_id` BIGINT COMMENT 'Unique surrogate identifier for each design milestone or gate review record in the IC design lifecycle. Primary key for the design_milestone data product.',
    `employee_id` BIGINT COMMENT 'Reference to the individual (design manager, chief architect, or program director) who holds formal authority to approve or reject this gate milestone. Serves as the PARTY_REFERENCE for this transaction, enabling accountability and tapeout authorization audit trail.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW (Multi-Project Wafer) shuttle run assignment associated with this tapeout milestone. Applicable when the design is submitted as part of a shared wafer shuttle rather than a dedicated production run. Links milestone to the specific shuttle schedule.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the parent IC design project to which this milestone belongs. Links the milestone to the overall design program, enabling schedule tracking and gate governance at the project level.',
    `research_milestone_id` BIGINT COMMENT 'SSOT reference to authoritative owner research.research_milestone for concept milestone',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Milestones are part of the projects WBS, enabling financial gating and milestone‑based funding releases.',
    `actual_date` DATE COMMENT 'Calendar date on which the design milestone was actually achieved and formally signed off. Null if the milestone has not yet been completed. Compared against planned_date to compute schedule variance for TTM reporting.',
    `approval_disposition` STRING COMMENT 'Formal outcome decision rendered at the gate review for this milestone. approved = unconditional sign-off; conditionally_approved = sign-off with mandatory action items; rejected = milestone failed, rework required; deferred = review postponed to a later date; waived = milestone formally bypassed with documented justification. Distinct from milestone_status which tracks workflow state.. Valid values are `approved|conditionally_approved|rejected|deferred|waived`',
    `blocker_count` STRING COMMENT 'Number of critical blocking issues preventing milestone achievement or sign-off at the time of review. Blockers are issues that must be fully resolved before the milestone can be approved, distinct from action items which may be post-approval.',
    `blocker_description` STRING COMMENT 'Narrative description of critical blocking issues preventing milestone sign-off. Details the nature of each blocker (e.g., unresolved DRC violations, failing timing paths, missing PDK sign-off) and the responsible owner for resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design milestone record was first created in the system of record. Used for audit trail, data lineage, and compliance reporting per SOX and ISO 9001 requirements.',
    `dfm_sign_off` BOOLEAN COMMENT 'Boolean flag indicating whether DFM (Design for Manufacturability) analysis has been completed and signed off at this milestone. True = DFM rules verified and approved by the process engineering team; False = DFM sign-off pending or not applicable for this milestone type.',
    `dft_sign_off` BOOLEAN COMMENT 'Boolean flag indicating whether DFT (Design for Testability) implementation and ATPG (Automatic Test Pattern Generation) coverage requirements have been met and signed off at this milestone. True = DFT sign-off complete; False = DFT sign-off pending.',
    `die_area_mm2` DECIMAL(18,2) COMMENT 'Physical die area in square millimeters (mm²) as estimated or finalized at this design milestone. Part of the PPA (Power, Performance, Area) triad. Tracked across milestones from initial floorplan through tapeout to monitor area budget compliance.',
    `drc_violation_count` STRING COMMENT 'Number of unresolved Design Rule Check (DRC) violations present in the design at the time of this milestone review. A value of zero is required for DRC/LVS clean and tapeout readiness milestones. Non-zero values must be accompanied by waivers.',
    `eda_tool_version` STRING COMMENT 'Version of the primary EDA (Electronic Design Automation) tool used to achieve or verify this milestone (e.g., Cadence Innovus 21.1, Synopsys PrimeTime 2022.03). Supports design data provenance and reproducibility of sign-off results.',
    `export_control_classification` STRING COMMENT 'Export control classification of the IC design at this milestone under US EAR (Export Administration Regulations) and ITAR (International Traffic in Arms Regulations). Determines applicable export license requirements for design data sharing and tapeout submission to foreign foundries. Classified as confidential business data.. Valid values are `EAR99|ECCN_3E001|ECCN_3E002|ECCN_3E003|ITAR_controlled|not_classified`',
    `findings_summary` STRING COMMENT 'Narrative summary of key findings, observations, and issues identified during the gate review. Captures design quality concerns, DRC/LVS violations, timing closure gaps, DFM/DFT issues, and other technical findings that inform the approval disposition.',
    `gate_criteria_met` BOOLEAN COMMENT 'Boolean flag indicating whether all formally defined entry and exit criteria for this gate milestone were satisfied at the time of review. True = all criteria met; False = one or more criteria failed or outstanding. Drives approval disposition and tapeout authorization decisions.',
    `gate_review_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the formal gate review meeting or sign-off event occurred. Serves as the principal business event timestamp for this transaction record, enabling audit trail and tapeout authorization traceability.',
    `gds_version` STRING COMMENT 'Version identifier of the GDS (Graphic Data System) or GDSII layout file submitted or reviewed at this milestone. Provides design data provenance for tapeout authorization and enables traceability between the milestone record and the physical layout database.. Valid values are `^[A-Za-z0-9._-]{1,50}$`',
    `ip_clearance_confirmed` BOOLEAN COMMENT 'Boolean flag indicating whether all third-party IP (Intellectual Property) cores used in the design have been cleared for use at this milestone, including license verification and export control review under ITAR and EAR regulations.',
    `lvs_violation_count` STRING COMMENT 'Number of unresolved Layout Versus Schematic (LVS) violations present in the design at the time of this milestone review. LVS violations indicate discrepancies between the physical layout and the circuit schematic. Must be zero for tapeout authorization.',
    `milestone_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this milestone within the design project (e.g., MS-RTL-001, MS-TAPEOUT-003). Used as the business-facing reference in PLM and project management systems. Serves as the BUSINESS_IDENTIFIER for this transaction.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `milestone_name` STRING COMMENT 'Human-readable name of the design milestone or gate review event (e.g., RTL Freeze, Design Freeze, Netlist Freeze, Floorplan Complete, Timing Closure, DRC/LVS Clean, Tapeout Readiness). Provides the identity label for the milestone record.',
    `milestone_status` STRING COMMENT 'Current workflow state of the design milestone gate review. planned = milestone scheduled but review not yet initiated; in_review = gate review meeting in progress or findings under evaluation; approved = all gate criteria met and sign-off granted; conditionally_approved = sign-off granted subject to outstanding action items or waivers; rejected = gate criteria not met, design must remediate before re-review; waived = milestone bypassed under formal waiver authority.. Valid values are `planned|in_review|approved|conditionally_approved|rejected|waived`',
    `milestone_type` STRING COMMENT 'Classification of the milestone representing the specific lifecycle checkpoint in the IC design flow. Values: rtl_freeze (Register Transfer Level code locked), design_freeze (all design changes halted), netlist_freeze (synthesized netlist locked), floorplan_complete (physical floorplan approved), timing_closure (all timing constraints met per PrimeTime signoff), drc_lvs_clean (Design Rule Check and Layout Versus Schematic violations resolved), tapeout_readiness (GDS/GDSII submission authorized). [ENUM-REF-CANDIDATE: rtl_freeze|design_freeze|netlist_freeze|floorplan_complete|timing_closure|drc_lvs_clean|tapeout_readiness — promote to reference product]',
    `nre_phase` STRING COMMENT 'NRE (Non-Recurring Engineering) lifecycle phase to which this milestone belongs. Categorizes the milestone within the broader IC development investment phases from concept through post-silicon validation. [ENUM-REF-CANDIDATE: concept|architecture|rtl_design|physical_design|verification|tapeout|post_silicon — promote to reference product]',
    `open_action_item_count` STRING COMMENT 'Number of unresolved action items identified during the gate review that must be closed before or after milestone sign-off. A non-zero value with conditionally_approved disposition indicates outstanding obligations tracked in PLM.',
    `open_waiver_count` STRING COMMENT 'Number of active design rule, timing, or quality waivers outstanding at the time of this milestone review. Waivers represent formally accepted deviations from standard gate criteria, each requiring documented justification and risk acceptance.',
    `pdk_version` STRING COMMENT 'Version identifier of the Process Design Kit (PDK) used for this design milestone. The PDK defines the design rules, device models, and standard cell libraries for the target process node. Ensures traceability of design decisions to the correct foundry-certified PDK release.. Valid values are `^[A-Za-z0-9._-]{1,50}$`',
    `planned_date` DATE COMMENT 'Originally scheduled calendar date for achieving this design milestone as defined in the project plan. Used for schedule adherence tracking and TTM (Time to Market) analysis.',
    `power_budget_mw` DECIMAL(18,2) COMMENT 'Total power consumption budget in milliwatts (mW) for the IC design as defined at this milestone checkpoint. Part of the PPA (Power, Performance, Area) triad tracked across design milestones. Compared against actual power estimates from EDA tools.',
    `process_node` STRING COMMENT 'Semiconductor fabrication process technology node at which the IC design is being implemented (e.g., 3nm, 5nm, 7nm, 12nm, 28nm). Contextualizes the milestone within the applicable PDK (Process Design Kit) and design rule set.',
    `review_iteration` STRING COMMENT 'Iteration count for this milestone gate review, incremented each time the milestone is re-reviewed following a rejection or conditional approval. A value greater than 1 indicates the design required rework cycles, which is a quality and schedule risk indicator.',
    `review_meeting_date` DATE COMMENT 'Calendar date on which the formal gate review meeting was convened with all required participants. May differ from gate_review_timestamp if the sign-off decision was rendered after the meeting concluded.',
    `review_participant_list` STRING COMMENT 'Comma-separated list of names or employee IDs of individuals who participated in the gate review meeting. Includes design engineers, DFM/DFT leads, physical design leads, and program management. Supports audit trail and quorum validation.',
    `revised_target_date` DATE COMMENT 'Updated target date for milestone completion following a formal schedule re-baseline or change control event. Captures the most recent approved schedule revision, distinct from the original planned_date.',
    `schedule_variance_days` STRING COMMENT 'Number of calendar days by which the actual milestone date deviates from the planned date (actual_date minus planned_date). Positive values indicate delay; negative values indicate early completion. Used for TTM (Time to Market) schedule adherence analytics.',
    `sequence` STRING COMMENT 'Ordinal sequence number defining the order of this milestone within the IC design project lifecycle. Enables chronological ordering of milestones for schedule visualization, critical path analysis, and gate governance reporting.',
    `tapeout_authorized` BOOLEAN COMMENT 'Boolean flag indicating whether this milestone record constitutes or contributes to formal tapeout authorization for GDS/GDSII submission to the fabrication facility (FAB). True = tapeout authorized; False = tapeout not yet authorized. Critical for the tapeout readiness audit trail.',
    `timing_slack_worst_ps` DECIMAL(18,2) COMMENT 'Worst-case setup timing slack in picoseconds (ps) across all timing paths in the design as reported by Synopsys PrimeTime at the time of this milestone. Negative values indicate timing violations. Zero or positive values indicate timing closure. Critical metric for timing_closure milestone sign-off.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this design milestone record. Supports change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver layer.',
    `waiver_justification` STRING COMMENT 'Documented rationale for any waivers granted at this milestone, explaining why the deviation from standard gate criteria is acceptable and what risk mitigation measures are in place. Required for compliance with ISO 9001 and IATF 16949 non-conformance management.',
    CONSTRAINT pk_design_milestone PRIMARY KEY(`design_milestone_id`)
) COMMENT 'Design milestone and gate review record tracking key lifecycle checkpoints and formal sign-off events in an IC design project. Captures milestone type (RTL freeze, design freeze, netlist freeze, floorplan complete, timing closure, DRC/LVS clean, tapeout readiness), planned and actual dates, sign-off authority, gate criteria met/failed, review participants, findings and action items, approval disposition (approved, conditionally approved, rejected), outstanding waivers with justifications, and blockers. SSOT for design schedule adherence, quality governance, and tapeout authorization audit trail.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` (
    `verification_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the design verification plan record within the Databricks Silver Layer lakehouse. Primary key for this entity.',
    `design_revision_id` BIGINT COMMENT 'Reference to the specific RTL or netlist design revision under verification. Ensures the verification plan is tied to a precise design snapshot, supporting traceability from verification results back to the design state at time of sign-off.',
    `employee_id` BIGINT COMMENT 'Reference to the primary verification engineer responsible for authoring, maintaining, and executing this verification plan. Sourced from Workday HCM workforce records.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the parent IC design project for which this verification plan is authored. Links the plan to the RTL-to-GDSII design project record managed in Cadence Virtuoso/Innovus or Siemens Teamcenter PLM.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW shuttle assignment for this design, if applicable. MPW shuttles allow multiple designs to share a single wafer run to reduce NRE costs. Links the verification plan to the foundry shuttle schedule.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Verification Plan aligns with a specific research project; linking enables project‑level verification status reporting.',
    `assertion_coverage_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of SystemVerilog Assertions (SVA) or PSL assertions that must be exercised and pass during simulation. Assertion coverage is a key metric for protocol compliance and corner-case verification completeness.',
    `bug_tracking_project_key` STRING COMMENT 'Project key or identifier in the bug tracking system corresponding to this verification plan (e.g., SOC-X5-VER). Used to hyperlink verification failures to the defect management workflow.',
    `bug_tracking_system` STRING COMMENT 'Name of the defect/bug tracking system integrated with this verification plan for logging simulation failures and RTL bugs (e.g., Jira, Bugzilla, Synopsys Serenity). Enables traceability from verification failures to RTL fixes.',
    `code_coverage_target_pct` DECIMAL(18,2) COMMENT 'Target code coverage closure percentage (line, branch, condition, expression, FSM) required for sign-off. Complements functional coverage to ensure structural completeness of the RTL simulation. Tracked against EDA tool-reported actuals.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design verification plan record was first created in the system. Supports audit trail, data lineage, and compliance reporting requirements.',
    `design_type` STRING COMMENT 'Classification of the IC design type under verification. Determines the applicable verification strategies, IP reuse policies, and regulatory requirements. [ENUM-REF-CANDIDATE: ASIC|SoC|FPGA|IP_core|ASSP|MCU|GPU|DSP — promote to reference product]',
    `dft_strategy` STRING COMMENT 'Primary DFT strategy defined in the verification plan for post-silicon test coverage. Scan chain inserts flip-flop chains for structural test; BIST (Built-In Self-Test) embeds test logic on-chip; ATPG (Automatic Test Pattern Generation) generates test vectors; boundary scan (JTAG per IEEE 1149.1) tests board-level interconnects. [ENUM-REF-CANDIDATE: scan_chain|BIST|ATPG|boundary_scan|JTAG|combined|none — promote to reference product]',
    `emulation_platform` STRING COMMENT 'Hardware emulation platform used for pre-silicon software bring-up and system-level verification (e.g., Cadence Palladium Z2, Synopsys ZeBu, Mentor Veloce). Null if emulation is not in scope for this plan.',
    `fault_coverage_target_pct` DECIMAL(18,2) COMMENT 'Target stuck-at and transition fault coverage percentage for ATPG-generated test patterns. Typically 99%+ for automotive/safety-critical designs per IATF 16949 and ISO 26262. Drives DFT insertion effort and scan chain architecture decisions.',
    `fault_injection_campaign_planned` BOOLEAN COMMENT 'Indicates whether a structured fault injection campaign is planned as part of this verification plan to validate safety mechanisms per ISO 26262. True for ASIL-B and above designs. Drives resource allocation for fault simulation infrastructure.',
    `fmeda_document_reference` STRING COMMENT 'Reference identifier of the linked FMEDA document in the PLM system. The FMEDA quantifies diagnostic coverage and safe failure fraction for ISO 26262 hardware metrics compliance. Null for non-safety designs.',
    `formal_verification_tool` STRING COMMENT 'EDA tool used for formal property checking and equivalence checking (e.g., Synopsys VC Formal, Cadence JasperGold, OneSpin 360). Null if formal verification is not part of the plan methodology.',
    `fpga_prototype_platform` STRING COMMENT 'FPGA prototyping board or platform used for early software validation and system integration testing (e.g., Xilinx VCU128, Intel Stratix 10 GX, Aldec HES-US-440). Null if FPGA prototyping is not in scope.',
    `functional_coverage_target_pct` DECIMAL(18,2) COMMENT 'Target functional coverage closure percentage required for verification sign-off (e.g., 99.50 for 99.5%). Defined in the verification plan and tracked against actual coverage results from simulation regression runs. A key tapeout readiness gate metric.',
    `ip_reuse_count` STRING COMMENT 'Number of third-party or internal IP cores integrated into this design that require verification waivers or pre-verified IP sign-off. Impacts the scope of the verification plan and the testbench architecture for IP interface compliance.',
    `iso26262_asil_decomposition` STRING COMMENT 'Description of the ASIL decomposition strategy applied to this design per ISO 26262 Part 9. Documents how a higher ASIL requirement is decomposed into two independent lower-ASIL sub-elements (e.g., ASIL D decomposed to ASIL B + ASIL B). Mandatory for automotive safety-critical IC designs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this design verification plan record. Used for change tracking, PLM synchronization, and incremental data pipeline processing in the Databricks Silver Layer.',
    `pdk_version` STRING COMMENT 'Version of the foundry-provided PDK used in this design and verification environment. The PDK defines the design rules, device models, and standard cell libraries. Verification must be validated against the correct PDK version to ensure DFM compliance.',
    `plan_end_date` DATE COMMENT 'Planned completion date for all verification activities and sign-off, aligned with the tapeout schedule. A key TTM (Time to Market) planning date. Slippage triggers NRE (Non-Recurring Engineering) cost impact analysis.',
    `plan_name` STRING COMMENT 'Descriptive human-readable name for the verification plan, typically including the IC design project name and verification phase (e.g., SoC-X5 Full-Chip Functional Verification Plan v2.1). Used in dashboards, reports, and PLM document management.',
    `plan_number` STRING COMMENT 'Externally-known, human-readable identifier for the verification plan, typically assigned by the PLM system (e.g., Oracle Agile PLM or Siemens Teamcenter). Format: DVP-<PROJECT_CODE>-<YEAR>-<SEQ>. Used in cross-functional communications, tapeout checklists, and audit trails.. Valid values are `^DVP-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$`',
    `plan_start_date` DATE COMMENT 'Planned start date for verification activities as defined in the project schedule. Used for milestone tracking, resource planning, and TTM (Time to Market) analysis.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the verification plan document. Drives workflow approvals and tapeout gate readiness. [ENUM-REF-CANDIDATE: draft|in_review|approved|active|on_hold|closed|cancelled — promote to reference product]',
    `plan_version` STRING COMMENT 'Version identifier of the verification plan document following semantic versioning (e.g., 1.0, 2.3, 3.1.2). Incremented upon each approved revision cycle in the PLM system. Critical for traceability to tapeout sign-off.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `regression_run_frequency` STRING COMMENT 'Planned frequency at which the regression suite is executed. Continuous integration runs on every RTL commit; nightly runs are scheduled overnight; milestone-triggered runs occur at defined project gates; on-demand runs are manually initiated.. Valid values are `continuous|nightly|weekly|milestone_triggered|on_demand`',
    `regression_suite_name` STRING COMMENT 'Name of the primary regression test suite defined in this verification plan (e.g., SoC_Full_Regression_v3, CPU_Smoke_Suite). The regression suite defines the set of simulation tests run nightly or at milestone gates to track coverage progress.',
    `safety_criticality_level` STRING COMMENT 'Functional safety classification of the IC design per ISO 26262 (automotive ASIL) or IEC 61508 (industrial SIL). Drives the rigor of fault injection campaigns, FMEDA linkage, and safety mechanism coverage targets within the verification plan. Non-safety designs are tagged non_safety. [ENUM-REF-CANDIDATE: ASIL_A|ASIL_B|ASIL_C|ASIL_D|SIL_1|SIL_2|SIL_3|non_safety — promote to reference product]',
    `safety_mechanism_coverage_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of identified safety mechanisms that must be verified through simulation, formal analysis, or fault injection campaigns. Required for ISO 26262 hardware verification sign-off. Null for non-safety designs.',
    `scan_chain_count` STRING COMMENT 'Number of scan chains defined in the DFT architecture for this design. Determines ATPG test time, test data volume, and ATE (Automatic Test Equipment) channel requirements. A key DFT planning parameter.',
    `signoff_approved` BOOLEAN COMMENT 'Indicates whether all verification sign-off criteria have been met and formal approval has been granted to proceed to tapeout. True only after all coverage targets, regression pass rates, and safety requirements are satisfied.',
    `signoff_criteria_description` STRING COMMENT 'Textual description of the complete set of criteria that must be satisfied before verification sign-off is granted and tapeout is authorized. Includes coverage closure thresholds, zero-open-critical-bug requirement, regression pass rate, and formal proof completion.',
    `signoff_date` DATE COMMENT 'Actual date on which verification sign-off was formally approved. Null until sign-off is granted. Used for tapeout readiness confirmation and post-silicon correlation analysis.',
    `simulation_tool` STRING COMMENT 'Primary EDA simulation tool assigned for RTL and gate-level simulation (e.g., Synopsys VCS, Cadence Xcelium, Mentor Questa). Determines the simulation environment configuration, license requirements, and regression infrastructure.',
    `tapeout_target_date` DATE COMMENT 'Target date for GDSII tapeout submission to the foundry. The verification plan must achieve all sign-off criteria before this date. Drives the verification schedule and milestone gate definitions.',
    `target_process_node` STRING COMMENT 'Semiconductor fabrication process node for which this design is targeted (e.g., 5nm, 7nm, 28nm, 180nm). Influences PDK selection, timing constraints, and DFM rule applicability within the verification plan.',
    `testbench_architecture` STRING COMMENT 'Structural architecture of the simulation testbench. UVM_layered follows the standard UVM agent/scoreboard/coverage hierarchy; directed uses manually written test vectors; constrained_random uses SystemVerilog randomization; cocotb uses Python-based co-simulation; SystemC uses transaction-level modeling. [ENUM-REF-CANDIDATE: UVM_layered|directed|constrained_random|hybrid|cocotb|SystemC — promote to reference product]. Valid values are `UVM_layered|directed|constrained_random|hybrid|cocotb|SystemC`',
    `toggle_coverage_target_pct` DECIMAL(18,2) COMMENT 'Target toggle coverage percentage for all RTL signals, ensuring each net transitions both 0→1 and 1→0 during simulation. Used as a DFT readiness indicator and a structural verification completeness metric.',
    `verification_methodology` STRING COMMENT 'Primary pre-silicon verification methodology employed for this plan. UVM (Universal Verification Methodology) is the industry-standard constrained-random simulation approach; formal uses mathematical property checking; emulation uses hardware accelerators; FPGA_prototyping uses field-programmable gate arrays for early software bring-up. [ENUM-REF-CANDIDATE: UVM|formal|emulation|FPGA_prototyping|hybrid|mixed_signal — promote to reference product]. Valid values are `UVM|formal|emulation|FPGA_prototyping|hybrid|mixed_signal`',
    CONSTRAINT pk_verification_plan PRIMARY KEY(`verification_plan_id`)
) COMMENT 'Design verification plan master record defining the pre-silicon verification strategy for an IC design project. Captures verification methodology (UVM, formal, emulation, FPGA prototyping), coverage goals (functional, code, toggle, assertion), testbench architecture, simulation environment configuration, DFT strategy (ATPG, BIST, scan chain, boundary scan), verification milestones and schedule, tool assignments, regression suite definitions, bug tracking integration, and sign-off criteria. For automotive and safety-critical designs, captures ISO 26262 functional safety verification requirements including ASIL decomposition, safety mechanism coverage targets, fault injection campaign plans, and FMEDA linkage. Ensures systematic verification coverage and regulatory compliance before tapeout.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` (
    `package_compatibility_id` BIGINT COMMENT 'Primary key for package compatibility record',
    `ic_design_project_id` BIGINT COMMENT 'FK to the IC design project',
    `package_type_id` BIGINT COMMENT 'FK to the package type',
    `employee_id` BIGINT COMMENT 'Unique identifier for the validated by employee record within the package compatibility design entity.',
    `assessed_date` DATE COMMENT 'Date of assessment',
    `ball_count` STRING COMMENT 'Number of solder balls on the package',
    `body_size_mm` DECIMAL(18,2) COMMENT 'Package body size in millimeters',
    `compatibility_grade` STRING COMMENT 'Grade assigned to compatibility',
    `compatibility_notes` STRING COMMENT 'Detailed compatibility notes',
    `compatibility_status` STRING COMMENT 'Overall compatibility status',
    `constraints` STRING COMMENT 'Constraints or limitations identified',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `die_size_max_x_mm` DECIMAL(18,2) COMMENT 'The die size max x mm of the package compatibility record in the design domain.',
    `die_size_max_y_mm` DECIMAL(18,2) COMMENT 'The die size max y mm of the package compatibility record in the design domain.',
    `effective_date` DATE COMMENT 'Effective date of the compatibility record',
    `evaluation_date` DATE COMMENT 'Date of evaluation',
    `flip_chip_compatible_flag` BOOLEAN COMMENT 'The flip chip compatible flag of the package compatibility record in the design domain.',
    `io_count` STRING COMMENT 'Number of IOs',
    `is_recommended` BOOLEAN COMMENT 'Whether this combination is recommended',
    `max_die_area_mm2` DECIMAL(18,2) COMMENT 'Maximum die area in square millimeters',
    `max_die_size_mm` DECIMAL(18,2) COMMENT 'Maximum die size in millimeters',
    `max_io_count` STRING COMMENT 'Maximum IO count supported',
    `max_junction_temp_c` DECIMAL(18,2) COMMENT 'Maximum junction temperature in Celsius',
    `max_power_dissipation_w` DECIMAL(18,2) COMMENT 'Maximum power dissipation in watts',
    `max_temp_c` DECIMAL(18,2) COMMENT 'The max temp c of the package compatibility record in the design domain.',
    `mechanical_fit_notes` STRING COMMENT 'Notes on mechanical fit assessment',
    `min_ball_pitch_um` DECIMAL(18,2) COMMENT 'Minimum ball pitch in micrometers',
    `min_temp_c` DECIMAL(18,2) COMMENT 'The min temp c of the package compatibility record in the design domain.',
    `moisture_sensitivity_level` STRING COMMENT 'Moisture sensitivity level per IPC/JEDEC',
    `notes` STRING COMMENT 'General notes',
    `package_type_code` STRING COMMENT 'Code identifying the package type',
    `pin_count` BIGINT COMMENT 'The pin count of the package compatibility record in the design domain.',
    `pin_count_compatibility` STRING COMMENT 'The pin count compatibility of the package compatibility record in the design domain.',
    `pin_pitch_mm` DECIMAL(18,2) COMMENT 'Pin pitch in millimeters',
    `pitch_mm` DECIMAL(18,2) COMMENT 'Pin/ball pitch in millimeters',
    `power_dissipation_limit` DECIMAL(18,2) COMMENT 'The power dissipation limit of the package compatibility record in the design domain.',
    `qualification_reference` STRING COMMENT 'Reference to qualification documentation',
    `qualification_status` STRING COMMENT 'Qualification status of the compatibility assessment',
    `qualified_date` DATE COMMENT 'The qualified date associated with the package compatibility design record.',
    `required_die_pitch_um` DECIMAL(18,2) COMMENT 'Required die pitch in micrometers',
    `rohs_compliant` BOOLEAN COMMENT 'Whether the package is RoHS compliant',
    `substrate_layer_count` STRING COMMENT 'Number of substrate layers',
    `substrate_material_match` DECIMAL(18,2) COMMENT 'The substrate material match of the package compatibility record in the design domain.',
    `thermal_budget_c` DECIMAL(18,2) COMMENT 'Thermal budget in degrees Celsius',
    `thermal_rating` DECIMAL(18,2) COMMENT 'Thermal rating value',
    `thermal_rating_c` DECIMAL(18,2) COMMENT 'Thermal rating in degrees Celsius',
    `thermal_resistance` DECIMAL(18,2) COMMENT 'The thermal resistance of the package compatibility record in the design domain.',
    `thermal_resistance_jc` DECIMAL(18,2) COMMENT 'Junction-to-case thermal resistance',
    `thermal_resistance_max` DECIMAL(18,2) COMMENT 'The thermal resistance max of the package compatibility record in the design domain.',
    `thermal_resistance_rating` DECIMAL(18,2) COMMENT 'Overall thermal resistance rating',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `validated_by` STRING COMMENT 'Person who validated the compatibility',
    `validated_date` DATE COMMENT 'Date when compatibility was validated',
    `validation_date` DATE COMMENT 'The validation date associated with the package compatibility design record.',
    `validation_method` STRING COMMENT 'Method used for validation',
    `wire_bond_pad_pitch_um` DECIMAL(18,2) COMMENT 'The wire bond pad pitch um of the package compatibility record in the design domain.',
    CONSTRAINT pk_package_compatibility PRIMARY KEY(`package_compatibility_id`)
) COMMENT 'Represents the compatibility relationship between an IC design project and a package type. Each record links one ic_design_project to one package_type and stores attributes that are specific to that pairing, such as required die pitch, thermal budget, and qualification status.. Existence Justification: Engineering maintains a Design‑Package Compatibility matrix that records which package types are qualified for each IC design project. Each matrix entry captures required die pitch, thermal budget, and qualification status, and both a design project can be linked to multiple package types and a package type can serve many design projects.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`design_revision` (
    `design_revision_id` BIGINT COMMENT 'Primary key for design_revision',
    `change_request_id` BIGINT COMMENT 'Reference to the change request that triggered this revision.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the parent design entity that this revision belongs to.',
    `prior_design_revision_id` BIGINT COMMENT 'Self-referencing FK on design_revision (prior_design_revision_id)',
    `area_um2` DECIMAL(18,2) COMMENT 'Physical silicon area of the design in square micrometers.',
    `change_reason` STRING COMMENT 'Business or technical justification for the revision.',
    `change_summary` STRING COMMENT 'Brief textual summary of the changes introduced in this revision.',
    `checksum` STRING COMMENT 'SHA‑256 checksum of the primary design file to ensure integrity.',
    `confidentiality_level` STRING COMMENT 'Data sensitivity classification for the revision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revision record was first created in the system.',
    `design_complexity_metric` STRING COMMENT 'Qualitative assessment of design complexity.',
    `design_file_path` STRING COMMENT 'File system or repository path where the design files for this revision are stored.',
    `design_owner_team` STRING COMMENT 'Team responsible for the design revision.',
    `design_revision_status` STRING COMMENT 'Current lifecycle state of the design revision.',
    `design_stage` STRING COMMENT 'Current development stage of the design for this revision.',
    `design_type` STRING COMMENT 'Technology category of the design.',
    `designer` STRING COMMENT 'Name of the primary engineer or team that authored the revision.',
    `file_format` STRING COMMENT 'Standard file format of the stored design data.',
    `gate_count` BIGINT COMMENT 'Total number of logic gates in the design for this revision.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the revision addresses a critical issue.',
    `place_and_route_tool` STRING COMMENT 'Name of the place‑and‑route tool used (e.g., Cadence Innovus).',
    `power_mw` DECIMAL(18,2) COMMENT 'Estimated power consumption of the design in milliwatts.',
    `power_report_available` BOOLEAN COMMENT 'Indicates whether a post‑layout power analysis report exists for this revision.',
    `release_date` DATE COMMENT 'Calendar date when the revision was officially released to downstream teams.',
    `release_notes` STRING COMMENT 'Detailed notes accompanying the release of this revision.',
    `review_status` STRING COMMENT 'Outcome of the design review process.',
    `reviewer` STRING COMMENT 'Name of the engineer or manager who performed the formal review.',
    `revision_label` STRING COMMENT 'Human‑readable label or name for the design revision (e.g., "Rev_A1").',
    `revision_number` STRING COMMENT 'External version number assigned to the revision (e.g., "1.0.3").',
    `revision_type` STRING COMMENT 'Category of the revision indicating its impact scope.',
    `synthesis_tool` STRING COMMENT 'Name of the logic synthesis tool used (e.g., Synopsys Design Compiler).',
    `timing_report_available` BOOLEAN COMMENT 'Indicates whether a timing analysis report exists for this revision.',
    `timing_slack_ns` DECIMAL(18,2) COMMENT 'Worst negative timing slack for the design in nanoseconds.',
    `tool_version` STRING COMMENT 'Version of the EDA tool suite used to generate this revision.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revision record.',
    `valid_until` DATE COMMENT 'Date after which the revision is considered obsolete or superseded.',
    `version_control_branch` STRING COMMENT 'Source‑control branch name where the revision is tracked.',
    `version_control_commit` STRING COMMENT 'Commit hash or identifier linking to the exact source code snapshot.',
    CONSTRAINT pk_design_revision PRIMARY KEY(`design_revision_id`)
) COMMENT 'Master reference table for design_revision. Referenced by design_revision_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`change_request` (
    `change_request_id` BIGINT COMMENT 'Primary key for change_request',
    `employee_id` BIGINT COMMENT 'Unique identifier for the approver employee record within the change request design entity.',
    `ic_design_project_id` BIGINT COMMENT 'Identifier of the design (e.g., RTL, netlist) impacted by the change.',
    `change_approved_by_employee_id` BIGINT COMMENT 'Unique identifier for the change approved by employee record within the change request design entity.',
    `change_employee_id` BIGINT COMMENT 'Identifier of the person who approved or rejected the change.',
    `change_ic_design_project_id` BIGINT COMMENT 'Unique identifier for the change ic design project record within the change request design entity.',
    `change_requested_by_employee_id` BIGINT COMMENT 'Unique identifier for the change requested by employee record within the change request design entity.',
    `change_requestor_employee_id` BIGINT COMMENT 'Unique identifier for the change requestor employee record within the change request design entity.',
    `requester_employee_id` BIGINT COMMENT 'Unique identifier for the requester employee record within the change request design entity.',
    `requester_id` BIGINT COMMENT 'Identifier of the person or team that originated the change request.',
    `superseded_change_request_id` BIGINT COMMENT 'Self-referencing FK on change_request (superseded_change_request_id)',
    `actual_effort_hours` STRING COMMENT 'Actual effort spent implementing the change, expressed in hours.',
    `actual_implementation_date` DATE COMMENT 'Date when the change was actually applied to the design.',
    `approval_status` STRING COMMENT 'Current approval state of the change request.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the change request was approved or rejected.',
    `change_category` STRING COMMENT 'High‑level classification of the change purpose.',
    `change_description` STRING COMMENT 'The change description of the change request record in the design domain.',
    `change_reason` STRING COMMENT 'Business or technical reason prompting the change request.',
    `change_request_number` STRING COMMENT 'The number of the change request record in the design domain.',
    `change_request_status` STRING COMMENT 'Current lifecycle state of the change request.',
    `change_title` STRING COMMENT 'The change title of the change request record in the design domain.',
    `change_type` STRING COMMENT 'Category describing the nature of the change (e.g., design, process, tool, documentation).',
    `communication_plan` STRING COMMENT 'Plan for communicating the change to stakeholders.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the change complies with applicable design and regulatory standards.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual financial cost incurred by the change.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost associated with the change.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change request record was first created in the system.',
    `deployment_window` STRING COMMENT 'Scheduled time window for deploying the change into production.',
    `change_request_description` STRING COMMENT 'Detailed description of the change, including rationale and scope.',
    `estimated_effort_hours` STRING COMMENT 'Projected effort required to implement the change, expressed in hours.',
    `impact_analysis` STRING COMMENT 'Summary of impact assessment performed for the change.',
    `impacted_modules` STRING COMMENT 'Comma‑separated list of design modules or blocks affected by the change.',
    `origin` STRING COMMENT 'Indicates whether the request originated from internal teams or external customers.',
    `planned_implementation_date` DATE COMMENT 'Target date for implementing the change in the design flow.',
    `post_implementation_review` STRING COMMENT 'Findings and lessons learned after the change has been implemented.',
    `priority` STRING COMMENT 'Business priority assigned to the change request.',
    `related_ticket_number` BIGINT COMMENT 'Identifier of a related change request or issue ticket.',
    `request_number` STRING COMMENT 'Human‑readable business identifier for the change request, often used in tracking and communication.',
    `request_status` STRING COMMENT 'The request status of the change request record in the design domain.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the change request was initially submitted.',
    `requested_date` DATE COMMENT 'The requested date associated with the change request design record.',
    `risk_level` STRING COMMENT 'Assessed risk associated with the change request.',
    `rollback_plan` STRING COMMENT 'Description of the plan to revert the change if needed.',
    `severity` STRING COMMENT 'Impact severity of the change on the design or production flow.',
    `source` STRING COMMENT 'Specific source system or tool that generated the change request (e.g., EDA tool, ticketing system).',
    `target_release` STRING COMMENT 'Design or product release version that the change targets.',
    `testing_status` STRING COMMENT 'Current status of testing activities related to the change.',
    `title` STRING COMMENT 'Brief, human‑readable title summarizing the change request.',
    `updated_by` STRING COMMENT 'User name or identifier of the person who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the change request record.',
    `created_by` STRING COMMENT 'User name or identifier of the person who created the record.',
    CONSTRAINT pk_change_request PRIMARY KEY(`change_request_id`)
) COMMENT 'Master reference table for change_request. Referenced by change_request_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_to_ic_design_project_id` FOREIGN KEY (`to_ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_eda_tool_id` FOREIGN KEY (`eda_tool_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`eda_tool`(`eda_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_rtl_specification_id` FOREIGN KEY (`rtl_specification_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`rtl_specification`(`rtl_specification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_to_ic_design_project_id` FOREIGN KEY (`to_ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_to_pdk_id` FOREIGN KEY (`to_pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_to_rtl_specification_id` FOREIGN KEY (`to_rtl_specification_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`rtl_specification`(`rtl_specification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ADD CONSTRAINT `fk_design_timing_analysis_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ADD CONSTRAINT `fk_design_timing_analysis_run_netlist_id` FOREIGN KEY (`netlist_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`netlist`(`netlist_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ADD CONSTRAINT `fk_design_timing_analysis_run_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ADD CONSTRAINT `fk_design_timing_analysis_run_primary_timing_ic_design_project_id` FOREIGN KEY (`primary_timing_ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_netlist_id` FOREIGN KEY (`netlist_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`netlist`(`netlist_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_primary_physical_ic_design_project_id` FOREIGN KEY (`primary_physical_ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_to_ic_design_project_id` FOREIGN KEY (`to_ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ADD CONSTRAINT `fk_design_rule_set_eda_tool_id` FOREIGN KEY (`eda_tool_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`eda_tool`(`eda_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ADD CONSTRAINT `fk_design_rule_set_parent_rule_set_id` FOREIGN KEY (`parent_rule_set_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`rule_set`(`rule_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ADD CONSTRAINT `fk_design_rule_set_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ADD CONSTRAINT `fk_design_rule_set_primary_superseded_by_rule_set_id` FOREIGN KEY (`primary_superseded_by_rule_set_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`rule_set`(`rule_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_eda_tool_id` FOREIGN KEY (`eda_tool_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`eda_tool`(`eda_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_netlist_id` FOREIGN KEY (`netlist_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`netlist`(`netlist_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_source_design_project_ic_design_project_id` FOREIGN KEY (`source_design_project_ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ADD CONSTRAINT `fk_design_ip_core_usage_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ADD CONSTRAINT `fk_design_design_milestone_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ADD CONSTRAINT `fk_design_design_milestone_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_design_revision_id` FOREIGN KEY (`design_revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_revision`(`design_revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ADD CONSTRAINT `fk_design_package_compatibility_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ADD CONSTRAINT `fk_design_design_revision_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`change_request`(`change_request_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ADD CONSTRAINT `fk_design_design_revision_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ADD CONSTRAINT `fk_design_design_revision_prior_design_revision_id` FOREIGN KEY (`prior_design_revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`design_revision`(`design_revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_change_ic_design_project_id` FOREIGN KEY (`change_ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ADD CONSTRAINT `fk_design_change_request_superseded_change_request_id` FOREIGN KEY (`superseded_change_request_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`change_request`(`change_request_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`design` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`design` SET TAGS ('dbx_domain' = 'design');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Foundry Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `block_count` SET TAGS ('dbx_business_glossary_term' = 'Block Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Design Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `dfm_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Dfm Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `dft_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dft Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `eda_tool_suite` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Suite');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `eda_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `gate_count_target_k` SET TAGS ('dbx_business_glossary_term' = 'Gate Count Target K');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `gds_file_path` SET TAGS ('dbx_business_glossary_term' = 'Gds File Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `iatf_automotive_grade` SET TAGS ('dbx_business_glossary_term' = 'Iatf Automotive Grade');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `ip_core_count` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `nre_actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Nre Actual Spend Usd');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `nre_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Nre Budget Usd');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Pdk Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `plm_item_reference` SET TAGS ('dbx_business_glossary_term' = 'Plm Item Reference');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `reach_svhc_assessed` SET TAGS ('dbx_business_glossary_term' = 'Reach Svhc Assessed');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Revision');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `rtl_freeze_date` SET TAGS ('dbx_business_glossary_term' = 'Rtl Freeze Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Sap Wbs Element');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `tapeout_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Actual Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `tapeout_target_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Target Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `target_clock_freq_mhz` SET TAGS ('dbx_business_glossary_term' = 'Target Clock Freq Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `target_die_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Target Die Area Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `target_power_budget_mw` SET TAGS ('dbx_business_glossary_term' = 'Target Power Budget Mw');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `tsv_required` SET TAGS ('dbx_business_glossary_term' = 'Tsv Required');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` SET TAGS ('dbx_subdomain' = 'reusable_assets');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` SET TAGS ('dbx_ssot_owner' = 'ip_core');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `ip_core_development_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Development Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `area_um2` SET TAGS ('dbx_business_glossary_term' = 'Area Um2');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `datasheet_url` SET TAGS ('dbx_business_glossary_term' = 'Datasheet Url');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `dfm_compliant` SET TAGS ('dbx_business_glossary_term' = 'Dfm Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `dft_compliant` SET TAGS ('dbx_business_glossary_term' = 'Dft Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `eda_tool_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `foundry_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Foundry Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `function_category` SET TAGS ('dbx_business_glossary_term' = 'Function Category');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `functional_description` SET TAGS ('dbx_business_glossary_term' = 'Functional Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `gds_available` SET TAGS ('dbx_business_glossary_term' = 'Gds Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `interface_standard` SET TAGS ('dbx_business_glossary_term' = 'Interface Standard');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `ip_core_code` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `ip_type` SET TAGS ('dbx_business_glossary_term' = 'Ip Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `lef_available` SET TAGS ('dbx_business_glossary_term' = 'Lef Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `license_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'License Fee Usd');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `max_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Max Frequency Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `mpw_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mpw Eligible');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `design_ip_core_name` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `nda_required` SET TAGS ('dbx_business_glossary_term' = 'Nda Required');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `power_uw` SET TAGS ('dbx_business_glossary_term' = 'Power Uw');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Pct');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `rtl_language` SET TAGS ('dbx_business_glossary_term' = 'Rtl Language');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `scan_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Scan Coverage Pct');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `silicon_proven` SET TAGS ('dbx_business_glossary_term' = 'Silicon Proven');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `silicon_proven_date` SET TAGS ('dbx_business_glossary_term' = 'Silicon Proven Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Tier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `timing_model_available` SET TAGS ('dbx_business_glossary_term' = 'Timing Model Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_ip_core` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` SET TAGS ('dbx_subdomain' = 'reusable_assets');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Product Process Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `agile_plm_part_number` SET TAGS ('dbx_business_glossary_term' = 'Agile Plm Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum Sha256');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `pdk_code` SET TAGS ('dbx_business_glossary_term' = 'Pdk Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `pdk_description` SET TAGS ('dbx_business_glossary_term' = 'Pdk Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `dft_rule_deck_version` SET TAGS ('dbx_business_glossary_term' = 'Dft Rule Deck Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `drc_rule_deck_version` SET TAGS ('dbx_business_glossary_term' = 'Drc Rule Deck Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `eda_tool_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `foundry_name` SET TAGS ('dbx_business_glossary_term' = 'Foundry Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `gds_format` SET TAGS ('dbx_business_glossary_term' = 'Gds Format');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `io_library_name` SET TAGS ('dbx_business_glossary_term' = 'Io Library Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `ip_library_version` SET TAGS ('dbx_business_glossary_term' = 'Ip Library Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `layer_stack_definition` SET TAGS ('dbx_business_glossary_term' = 'Layer Stack Definition');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `lvs_rule_deck_version` SET TAGS ('dbx_business_glossary_term' = 'Lvs Rule Deck Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `max_supply_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Max Supply Voltage V');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `memory_compiler_supported` SET TAGS ('dbx_business_glossary_term' = 'Memory Compiler Supported');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `min_supply_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Min Supply Voltage V');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `mpw_shuttle_supported` SET TAGS ('dbx_business_glossary_term' = 'Mpw Shuttle Supported');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `pdk_name` SET TAGS ('dbx_business_glossary_term' = 'Pdk Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `nda_required` SET TAGS ('dbx_business_glossary_term' = 'Nda Required');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `nominal_supply_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Nominal Supply Voltage V');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `opc_rule_deck_version` SET TAGS ('dbx_business_glossary_term' = 'Opc Rule Deck Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `operating_temp_max_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temp Max C');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `operating_temp_min_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temp Min C');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `pdk_status` SET TAGS ('dbx_business_glossary_term' = 'Pdk Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `process_corner_set` SET TAGS ('dbx_business_glossary_term' = 'Process Corner Set');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `process_family` SET TAGS ('dbx_business_glossary_term' = 'Process Family');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `release_notes_url` SET TAGS ('dbx_business_glossary_term' = 'Release Notes Url');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `spice_model_set` SET TAGS ('dbx_business_glossary_term' = 'Spice Model Set');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `spice_model_version` SET TAGS ('dbx_business_glossary_term' = 'Spice Model Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `std_cell_library_name` SET TAGS ('dbx_business_glossary_term' = 'Std Cell Library Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `std_cell_library_version` SET TAGS ('dbx_business_glossary_term' = 'Std Cell Library Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `teamcenter_item_reference` SET TAGS ('dbx_business_glossary_term' = 'Teamcenter Item Reference');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `rtl_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Rtl Specification Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Mpw Shuttle Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `to_ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `ams_behavioral_model_ref` SET TAGS ('dbx_business_glossary_term' = 'Ams Behavioral Model Ref');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `cdc_annotation_status` SET TAGS ('dbx_business_glossary_term' = 'Cdc Annotation Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `clock_domain_count` SET TAGS ('dbx_business_glossary_term' = 'Clock Domain Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `commit_hash` SET TAGS ('dbx_business_glossary_term' = 'Commit Hash');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `design_block_name` SET TAGS ('dbx_business_glossary_term' = 'Design Block Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `design_block_type` SET TAGS ('dbx_business_glossary_term' = 'Design Block Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `design_intent_description` SET TAGS ('dbx_business_glossary_term' = 'Design Intent Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `dfm_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Dfm Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `dft_strategy` SET TAGS ('dbx_business_glossary_term' = 'Dft Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Ear Eccn Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `fpga_device_family` SET TAGS ('dbx_business_glossary_term' = 'Fpga Device Family');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `functional_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Functional Coverage Target Pct');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `hdl_language` SET TAGS ('dbx_business_glossary_term' = 'Hdl Language');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `interface_protocols` SET TAGS ('dbx_business_glossary_term' = 'Interface Protocols');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `ip_reuse_source` SET TAGS ('dbx_business_glossary_term' = 'Ip Reuse Source');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `is_analog_mixed_signal` SET TAGS ('dbx_business_glossary_term' = 'Is Analog Mixed Signal');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `is_fpga_target` SET TAGS ('dbx_business_glossary_term' = 'Is Fpga Target');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `lint_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Lint Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `logic_gate_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Logic Gate Count Estimate');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Nre Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Pdk Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `power_domain_count` SET TAGS ('dbx_business_glossary_term' = 'Power Domain Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `power_intent_format` SET TAGS ('dbx_business_glossary_term' = 'Power Intent Format');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `repository_path` SET TAGS ('dbx_business_glossary_term' = 'Repository Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `reset_strategy` SET TAGS ('dbx_business_glossary_term' = 'Reset Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `revision_control_system` SET TAGS ('dbx_business_glossary_term' = 'Revision Control System');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `specification_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Approved Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `specification_released_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Released Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `tapeout_target_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Target Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `target_clock_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Target Clock Frequency Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `target_process_node` SET TAGS ('dbx_business_glossary_term' = 'Target Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `teamcenter_item_reference` SET TAGS ('dbx_business_glossary_term' = 'Teamcenter Item Reference');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `eda_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Pdk Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `rtl_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Rtl Specification Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `to_ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `to_pdk_id` SET TAGS ('dbx_business_glossary_term' = 'To Pdk Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `to_rtl_specification_id` SET TAGS ('dbx_business_glossary_term' = 'To Rtl Specification Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `area_estimate_um2` SET TAGS ('dbx_business_glossary_term' = 'Area Estimate Um2');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `cell_instance_count` SET TAGS ('dbx_business_glossary_term' = 'Cell Instance Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `cell_library_name` SET TAGS ('dbx_business_glossary_term' = 'Cell Library Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `cell_library_version` SET TAGS ('dbx_business_glossary_term' = 'Cell Library Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum Sha256');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `combinational_cell_count` SET TAGS ('dbx_business_glossary_term' = 'Combinational Cell Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `constraints_file_ref` SET TAGS ('dbx_business_glossary_term' = 'Constraints File Ref');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `critical_path_delay_ps` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Delay Ps');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `design_block_name` SET TAGS ('dbx_business_glossary_term' = 'Design Block Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `design_iteration` SET TAGS ('dbx_business_glossary_term' = 'Design Iteration');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `dfm_rule_check_status` SET TAGS ('dbx_business_glossary_term' = 'Dfm Rule Check Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `dft_scan_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Dft Scan Coverage Pct');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `dynamic_power_mw` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Power Mw');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Format');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `leakage_power_uw` SET TAGS ('dbx_business_glossary_term' = 'Leakage Power Uw');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `netlist_name` SET TAGS ('dbx_business_glossary_term' = 'Netlist Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `netlist_type` SET TAGS ('dbx_business_glossary_term' = 'Netlist Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `sequential_cell_count` SET TAGS ('dbx_business_glossary_term' = 'Sequential Cell Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `synthesis_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Run Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `synthesis_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Runtime Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `synthesis_status` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `tapeout_target_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Target Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `target_clock_freq_mhz` SET TAGS ('dbx_business_glossary_term' = 'Target Clock Freq Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `timing_closure_achieved` SET TAGS ('dbx_business_glossary_term' = 'Timing Closure Achieved');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `timing_slack_hold_ps` SET TAGS ('dbx_business_glossary_term' = 'Timing Slack Hold Ps');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `timing_slack_setup_ps` SET TAGS ('dbx_business_glossary_term' = 'Timing Slack Setup Ps');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `timing_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Timing Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `total_power_estimate_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Power Estimate Mw');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` SET TAGS ('dbx_subdomain' = 'verification_execution');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `timing_analysis_run_id` SET TAGS ('dbx_business_glossary_term' = 'Static Timing Analysis (STA) Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `primary_timing_ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'IC Design ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `analysis_mode` SET TAGS ('dbx_business_glossary_term' = 'STA Analysis Mode');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `analysis_mode` SET TAGS ('dbx_value_regex' = 'setup|hold|setup_hold|ocv|aocv|pocv');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `clock_domain_count` SET TAGS ('dbx_business_glossary_term' = 'Clock Domain Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `clock_frequency_target_mhz` SET TAGS ('dbx_business_glossary_term' = 'Clock Frequency Target (MHz)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `clock_period_target_ps` SET TAGS ('dbx_business_glossary_term' = 'Clock Period Target (ps)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `critical_path_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `derating_factor_hold` SET TAGS ('dbx_business_glossary_term' = 'Hold Timing Derating Factor');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `derating_factor_setup` SET TAGS ('dbx_business_glossary_term' = 'Setup Timing Derating Factor');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `design_stage` SET TAGS ('dbx_business_glossary_term' = 'Design Stage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `design_stage` SET TAGS ('dbx_value_regex' = 'pre_synthesis|post_synthesis|pre_cts|post_cts|post_route|signoff');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `design_version` SET TAGS ('dbx_business_glossary_term' = 'Design Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `hold_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Hold Timing Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `is_multi_corner_run` SET TAGS ('dbx_business_glossary_term' = 'Multi-Corner STA Run Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `is_signoff_run` SET TAGS ('dbx_business_glossary_term' = 'Signoff Run Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `liberty_library_version` SET TAGS ('dbx_business_glossary_term' = 'Liberty Timing Library Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `max_capacitance_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacitance Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `max_transition_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transition Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `primetime_version` SET TAGS ('dbx_business_glossary_term' = 'Synopsys PrimeTime Tool Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `pvt_corner` SET TAGS ('dbx_business_glossary_term' = 'Process-Voltage-Temperature (PVT) Corner');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'STA Run Review Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'STA Run Reviewed By');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'STA Run Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'STA Run Duration (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_identifier` SET TAGS ('dbx_business_glossary_term' = 'STA Run Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_iteration` SET TAGS ('dbx_business_glossary_term' = 'STA Run Iteration Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'STA Run Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_notes` SET TAGS ('dbx_business_glossary_term' = 'STA Run Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'STA Run Execution Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'submitted|running|completed|failed|aborted');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'STA Run Execution Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `sdc_constraints_version` SET TAGS ('dbx_business_glossary_term' = 'Synopsys Design Constraints (SDC) Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `setup_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Setup Timing Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `spef_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Parasitic Exchange Format (SPEF) Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `supply_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Supply Voltage (V)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `timing_closure_status` SET TAGS ('dbx_business_glossary_term' = 'Timing Closure Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `timing_closure_status` SET TAGS ('dbx_value_regex' = 'pass|fail|waived|in_progress|pending_review');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `total_hold_negative_slack_ps` SET TAGS ('dbx_business_glossary_term' = 'Total Hold Negative Slack (THNS) in Picoseconds');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `total_negative_slack_ps` SET TAGS ('dbx_business_glossary_term' = 'Total Negative Slack (TNS) in Picoseconds');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `waiver_count` SET TAGS ('dbx_business_glossary_term' = 'Timing Violation Waiver Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `worst_hold_slack_ps` SET TAGS ('dbx_business_glossary_term' = 'Worst Hold Slack (WHS) in Picoseconds');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ALTER COLUMN `worst_negative_slack_ps` SET TAGS ('dbx_business_glossary_term' = 'Worst Negative Slack (WNS) in Picoseconds');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Design Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `primary_physical_ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'IC Design ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `antenna_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Antenna Rule Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `cell_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Cell Utilization Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `core_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Core Area (Square Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `cts_insertion_delay_ps` SET TAGS ('dbx_business_glossary_term' = 'Clock Tree Synthesis (CTS) Insertion Delay (Picoseconds)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `cts_skew_ps` SET TAGS ('dbx_business_glossary_term' = 'Clock Tree Synthesis (CTS) Skew (Picoseconds)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `dfm_score` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Score');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `dft_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `die_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Area (Square Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `die_height_um` SET TAGS ('dbx_business_glossary_term' = 'Die Height (Micrometers)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `die_width_um` SET TAGS ('dbx_business_glossary_term' = 'Die Width (Micrometers)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `drc_critical_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Design Rule Check (DRC) Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `drc_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Check (DRC) Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `eda_tool` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `eda_tool` SET TAGS ('dbx_value_regex' = 'cadence_innovus|synopsys_icc2|siemens_aprisa|cadence_virtuoso');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `eda_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `em_compliant` SET TAGS ('dbx_business_glossary_term' = 'Electromigration (EM) Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `gds_file_checksum` SET TAGS ('dbx_business_glossary_term' = 'Layout File Checksum (SHA-256)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `gds_file_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `gds_file_format` SET TAGS ('dbx_business_glossary_term' = 'Layout File Format');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `gds_file_format` SET TAGS ('dbx_value_regex' = 'gdsii|oasis|lef_def');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `gds_file_path` SET TAGS ('dbx_business_glossary_term' = 'Graphic Data System II (GDSII) File Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `implementation_stage` SET TAGS ('dbx_business_glossary_term' = 'Physical Implementation Stage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `implementation_stage` SET TAGS ('dbx_value_regex' = 'floorplan|placement|cts|routing|signoff|tapeout');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `ir_drop_max_mv` SET TAGS ('dbx_business_glossary_term' = 'Maximum IR Drop (Millivolts)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `iteration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Layout Iteration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `layout_name` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `layout_status` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `layout_status` SET TAGS ('dbx_value_regex' = 'in_progress|review|approved|rejected|archived');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `layout_version` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `layout_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `leakage_power_uw` SET TAGS ('dbx_business_glossary_term' = 'Leakage Power (Microwatts)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `lvs_clean` SET TAGS ('dbx_business_glossary_term' = 'Layout Versus Schematic (LVS) Clean Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `metal_fill_density_pct` SET TAGS ('dbx_business_glossary_term' = 'Metal Fill Density Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Estimated Power Consumption (Milliwatts)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `routing_congestion_layer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Routing Congestion Metal Layer');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `routing_congestion_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Routing Congestion Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `tns_ps` SET TAGS ('dbx_business_glossary_term' = 'Total Negative Slack (TNS) (Picoseconds)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `total_cell_count` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Cell Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `wns_ps` SET TAGS ('dbx_business_glossary_term' = 'Worst Negative Slack (WNS) (Picoseconds)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Foundry Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `to_ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `design_name` SET TAGS ('dbx_business_glossary_term' = 'Design Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `design_revision` SET TAGS ('dbx_business_glossary_term' = 'Design Revision');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `design_revision` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{1,2}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Design Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `dfm_score` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Score');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `dft_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Size (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `drc_clean` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Check (DRC) Clean Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `erc_clean` SET TAGS ('dbx_business_glossary_term' = 'Electrical Rule Check (ERC) Clean Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `expected_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Die Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN_3E001|ECCN_3A001|ITAR_controlled|not_classified');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `foundry_name` SET TAGS ('dbx_business_glossary_term' = 'Foundry Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `foundry_submission_ref` SET TAGS ('dbx_business_glossary_term' = 'Foundry Submission Reference');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `gds_file_path` SET TAGS ('dbx_business_glossary_term' = 'Graphic Data System II (GDSII) File Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `gds_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `gds_file_version` SET TAGS ('dbx_business_glossary_term' = 'Graphic Data System II (GDSII) File Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `ip_sign_off_complete` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Sign-Off Completion Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|i-line|g-line|multi-patterning');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `lvs_clean` SET TAGS ('dbx_business_glossary_term' = 'Layout Versus Schematic (LVS) Clean Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `mask_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `mask_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `mask_count` SET TAGS ('dbx_business_glossary_term' = 'Mask Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `opc_ret_status` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction / Resolution Enhancement Technology (OPC/RET) Processing Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `opc_ret_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|waived');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `signoff_checklist_complete` SET TAGS ('dbx_business_glossary_term' = 'Design Sign-Off Checklist Completion Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_number` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_number` SET TAGS ('dbx_value_regex' = '^TO-[A-Z0-9]{4,20}-[0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_status` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_status` SET TAGS ('dbx_value_regex' = 'draft|pending_signoff|submitted|accepted|rejected|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_type` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_type` SET TAGS ('dbx_value_regex' = 'full_custom|mpw|engineering_sample|production');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `target_tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Target Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `timing_closure_status` SET TAGS ('dbx_business_glossary_term' = 'Timing Closure Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `timing_closure_status` SET TAGS ('dbx_value_regex' = 'clean|waived|failed');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `wafer_count_ordered` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count Ordered');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Foundry Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `supplier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Mpw Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `actual_die_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Die Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `actual_tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `actual_wafer_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Wafer Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `allocated_project_count` SET TAGS ('dbx_business_glossary_term' = 'Allocated Project Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Eligibility Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `cost_per_mm2_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Square Millimeter (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `cost_per_mm2_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `cost_sharing_model` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Model');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `cost_sharing_model` SET TAGS ('dbx_value_regex' = 'proportional_area|fixed_slot|tiered|negotiated');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `dfm_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `dft_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Requirement Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN_3E001|ECCN_3E002|ECCN_3E003|ITAR_controlled');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `foundry_account_manager` SET TAGS ('dbx_business_glossary_term' = 'Foundry Account Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `gds_submission_format` SET TAGS ('dbx_business_glossary_term' = 'Graphic Data System (GDS) Submission Format');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `gds_submission_format` SET TAGS ('dbx_value_regex' = 'GDSII|OASIS|LEF_DEF');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `ip_nda_required` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Non-Disclosure Agreement (NDA) Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_value_regex' = 'EUV|DUV|i-line|g-line|multi-patterning');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `nre_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `process_design_kit_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `scheduled_die_release_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Die Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `scheduled_tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `scheduled_wafer_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Wafer Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `shuttle_code` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `shuttle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `shuttle_description` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `shuttle_name` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `shuttle_status` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `shuttle_type` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `shuttle_type` SET TAGS ('dbx_value_regex' = 'standard_mpw|engineering_run|risk_production|prototype');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `special_process_options` SET TAGS ('dbx_business_glossary_term' = 'Special Process Options');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `submission_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Design Submission Deadline Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `total_reticle_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Total Reticle Area (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `total_shuttle_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Multi-Project Wafer (MPW) Shuttle Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `total_shuttle_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `total_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Total Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`mpw_shuttle` ALTER COLUMN `wafer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` SET TAGS ('dbx_subdomain' = 'reusable_assets');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `eda_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `annual_license_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual EDA License Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `annual_license_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `approved_user_groups` SET TAGS ('dbx_business_glossary_term' = 'Approved EDA Tool User Groups');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `compute_platform_type` SET TAGS ('dbx_business_glossary_term' = 'EDA Compute Platform Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `compute_platform_type` SET TAGS ('dbx_value_regex' = 'on_premise|cloud|hybrid');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `concurrent_users_peak` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent EDA Tool Users');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `design_flow_stage` SET TAGS ('dbx_business_glossary_term' = 'IC Design Flow Stage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `dfm_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `dft_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Support Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `euv_process_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Extreme Ultraviolet (EUV) Lithography Process Support Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification (EAR/ITAR)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `flow_integration_point` SET TAGS ('dbx_business_glossary_term' = 'EDA Flow Integration Point');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `formal_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Formal Verification Support Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `installation_path` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Installation Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Last Used Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_count` SET TAGS ('dbx_business_glossary_term' = 'EDA License Seat Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'EDA License Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_server_host` SET TAGS ('dbx_business_glossary_term' = 'EDA License Server Hostname');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_server_host` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'EDA License Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'EDA License Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'node_locked|floating|subscription|cloud|perpetual');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `license_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'EDA License Utilization Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `maintenance_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Maintenance Renewal Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `maintenance_renewal_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `pdk_compatibility_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Compatibility Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|in_qualification|not_qualified|waived');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `qualified_by` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Qualified By (Engineer)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `release_notes_url` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Release Notes URL');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `supported_os_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Operating System Platforms');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `supported_process_nodes` SET TAGS ('dbx_business_glossary_term' = 'Supported Process Nodes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_category` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Category');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_code` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_description` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_name` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_status` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|evaluation|retired|pending_qualification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_version` SET TAGS ('dbx_business_glossary_term' = 'EDA Tool Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `tool_version` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9.-_]{1,40}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `vendor_contract_number` SET TAGS ('dbx_business_glossary_term' = 'EDA Vendor Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `vendor_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'EDA Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `vendor_support_tier` SET TAGS ('dbx_business_glossary_term' = 'EDA Vendor Support Tier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`eda_tool` ALTER COLUMN `vendor_support_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|elite|end_of_support');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` SET TAGS ('dbx_subdomain' = 'reusable_assets');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Approver Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `eda_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Owner Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `parent_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Design Rule Set ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `primary_superseded_by_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Design Rule Set ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `applicable_design_phase` SET TAGS ('dbx_business_glossary_term' = 'Applicable Design Phase');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `applicable_design_phase` SET TAGS ('dbx_value_regex' = 'RTL|Synthesis|Floorplan|Place-and-Route|Signoff|Tapeout');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `approved_waiver_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Waiver Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `authored_by_team` SET TAGS ('dbx_business_glossary_term' = 'Authored By Team');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_category` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Category');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_category` SET TAGS ('dbx_value_regex' = 'Supplemental|Project-Specific|Foundry-Standard|Internal-Engineering|Customer-Mandated');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (CCN)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CCN-[0-9]{6,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_code` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,40}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_description` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `deviation_approval_workflow` SET TAGS ('dbx_business_glossary_term' = 'Deviation Approval Workflow');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `deviation_approval_workflow` SET TAGS ('dbx_value_regex' = 'None|Single-Approver|Dual-Approver|Change-Control-Board');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN-3E001|ECCN-3E002|ITAR-Controlled|Not-Classified');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `feol_beol_scope` SET TAGS ('dbx_business_glossary_term' = 'Front End of Line / Back End of Line (FEOL/BEOL) Scope');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `feol_beol_scope` SET TAGS ('dbx_value_regex' = 'FEOL|BEOL|MOL|Full-Stack|Not-Applicable');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `foundry_source` SET TAGS ('dbx_business_glossary_term' = 'Foundry Source');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `ip_classification` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `ip_classification` SET TAGS ('dbx_value_regex' = 'Proprietary|Foundry-Confidential|Third-Party-Licensed|Open-Standard');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `ip_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|Multi-Patterning|Nanoimprint|Not-Applicable');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `mpw_compatible` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Compatible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_name` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `nre_impact` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Impact Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `opc_required` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_count` SET TAGS ('dbx_business_glossary_term' = 'Rule Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_deck_checksum` SET TAGS ('dbx_business_glossary_term' = 'Rule Deck File Checksum (SHA-256)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_deck_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_deck_file_path` SET TAGS ('dbx_business_glossary_term' = 'Rule Deck File Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_deck_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_status` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_status` SET TAGS ('dbx_value_regex' = 'Draft|Under-Review|Approved|Active|Deprecated|Superseded');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `rule_set_type` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'Error|Warning|Advisory|Waivable');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `technology_family` SET TAGS ('dbx_business_glossary_term' = 'Technology Family');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?(-[A-Za-z0-9]+)?$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `waiver_policy` SET TAGS ('dbx_business_glossary_term' = 'Waiver Policy');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rule_set` ALTER COLUMN `waiver_policy` SET TAGS ('dbx_value_regex' = 'No-Waiver|Engineering-Approval|Management-Approval|Foundry-Approval');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` SET TAGS ('dbx_subdomain' = 'verification_execution');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `simulation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `eda_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Signoff Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `assertion_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Assertion Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `code_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Code Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `compute_cluster` SET TAGS ('dbx_business_glossary_term' = 'Compute Cluster Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `cpu_hours_consumed` SET TAGS ('dbx_business_glossary_term' = 'CPU Hours Consumed');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `design_stage` SET TAGS ('dbx_business_glossary_term' = 'Design Stage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `design_stage` SET TAGS ('dbx_value_regex' = 'pre_synthesis|post_synthesis|post_layout|post_mask|tapeout');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `design_version` SET TAGS ('dbx_business_glossary_term' = 'Design Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `functional_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Functional Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|waived|inconclusive');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `peak_memory_gb` SET TAGS ('dbx_business_glossary_term' = 'Peak Memory Usage (Gigabytes)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `process_corner` SET TAGS ('dbx_business_glossary_term' = 'Process Corner (PVT - Process)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `regression_suite_name` SET TAGS ('dbx_business_glossary_term' = 'Regression Suite Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `rule_deck_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Deck Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `rule_deck_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Deck Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `run_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Run Duration (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `run_identifier` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Identifier (External Reference)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `run_notes` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'queued|running|completed|failed|aborted|timed_out');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `run_subtype` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Subtype');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `signoff_approved` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Approved Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `simulation_to_ruleset` SET TAGS ('dbx_business_glossary_term' = 'Simulation To Ruleset');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `supply_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Supply Voltage (Volts)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `tapeout_milestone` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Milestone');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `tapeout_milestone` SET TAGS ('dbx_value_regex' = 'pre_tapeout|tapeout_freeze|post_tapeout|mpw_shuttle|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature (Degrees Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `testbench_name` SET TAGS ('dbx_business_glossary_term' = 'Testbench Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `toggle_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Toggle Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `violation_count_error` SET TAGS ('dbx_business_glossary_term' = 'Error Severity Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `violation_count_total` SET TAGS ('dbx_business_glossary_term' = 'Total Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `violation_count_waived` SET TAGS ('dbx_business_glossary_term' = 'Waived Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`simulation_run` ALTER COLUMN `violation_count_warning` SET TAGS ('dbx_business_glossary_term' = 'Warning Severity Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `ip_core_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Usage ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'IP Core Integration Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'IP Core License Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'IC Design Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `source_design_project_ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Source Design Project ID (IP Reuse Origin)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `area_consumed_um2` SET TAGS ('dbx_business_glossary_term' = 'IP Core Physical Area Consumed (µm²)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `clock_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'IP Core Clock Frequency (MHz)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `configuration_parameters` SET TAGS ('dbx_business_glossary_term' = 'IP Core Configuration Parameters');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `design_hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'IP Core Design Hierarchy Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification (EAR/ITAR)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN_3E001|ECCN_3E002|ECCN_3E003|ITAR|unrestricted');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `functional_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'IP Core Functional Coverage Percentage (%)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `instance_count` SET TAGS ('dbx_business_glossary_term' = 'IP Core Instance Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `integration_start_date` SET TAGS ('dbx_business_glossary_term' = 'IP Core Integration Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'IP Core Integration Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `integration_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|verified|silicon_proven');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `interface_protocol` SET TAGS ('dbx_business_glossary_term' = 'IP Core Interface Bus Protocol');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `ip_core_version` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `ip_core_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?([a-zA-Z0-9_-]*)?$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `ip_reuse_flag` SET TAGS ('dbx_business_glossary_term' = 'IP Core Reuse Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `ip_usage_to_core` SET TAGS ('dbx_business_glossary_term' = 'Ip Usage To Core');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `is_dfm_compliant` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `is_dft_enabled` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Enabled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `is_silicon_proven` SET TAGS ('dbx_business_glossary_term' = 'IP Core Silicon-Proven Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'IP Core License Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'royalty_bearing|perpetual|subscription|internal|open_source');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `license_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'IP Core Integration Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `pdk_node` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `power_contribution_mw` SET TAGS ('dbx_business_glossary_term' = 'IP Core Power Contribution (mW)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `royalty_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'IP Core Royalty Rate Per Unit (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `royalty_rate_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'IP Core Integration Sign-Off Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'IP Core Integration Sign-Off Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|waived');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `silicon_validation_date` SET TAGS ('dbx_business_glossary_term' = 'IP Core Silicon Validation Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `supply_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'IP Core Supply Voltage (V)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `timing_budget_ns` SET TAGS ('dbx_business_glossary_term' = 'IP Core Timing Budget Contribution (ns)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `usage_to_core` SET TAGS ('dbx_business_glossary_term' = 'Usage To Core');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `verification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'IP Core Verification Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core_usage` ALTER COLUMN `verification_methodology` SET TAGS ('dbx_business_glossary_term' = 'IP Core Verification Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` SET TAGS ('dbx_ssot_owner' = 'research.research_milestone');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `design_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Design Milestone ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Authority ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `research_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Research Milestone Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `research_milestone_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Achievement Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `approval_disposition` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Approval Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `approval_disposition` SET TAGS ('dbx_value_regex' = 'approved|conditionally_approved|rejected|deferred|waived');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `blocker_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Blocker Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `blocker_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Blocker Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `dfm_sign_off` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Sign-Off Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `dft_sign_off` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Sign-Off Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `die_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Area in Square Millimeters (PPA)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `drc_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Check (DRC) Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `eda_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification (EAR/ITAR)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN_3E001|ECCN_3E002|ECCN_3E003|ITAR_controlled|not_classified');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Findings Summary');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `gate_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Gate Entry Criteria Met Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `gate_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `gds_version` SET TAGS ('dbx_business_glossary_term' = 'GDS/GDSII Layout Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `gds_version` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._-]{1,50}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `ip_clearance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Clearance Confirmed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `lvs_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Layout Versus Schematic (LVS) Violation Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Design Milestone Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Design Milestone Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Design Milestone Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_review|approved|conditionally_approved|rejected|waived');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Design Milestone Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `nre_phase` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Phase');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `open_action_item_count` SET TAGS ('dbx_business_glossary_term' = 'Open Action Item Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `open_waiver_count` SET TAGS ('dbx_business_glossary_term' = 'Open Waiver Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `pdk_version` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._-]{1,50}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `power_budget_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Budget in Milliwatts (PPA)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `review_iteration` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Iteration Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `review_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Meeting Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `review_participant_list` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Participant List');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `revised_target_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Target Milestone Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance in Days');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `tapeout_authorized` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Authorization Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `timing_slack_worst_ps` SET TAGS ('dbx_business_glossary_term' = 'Worst Timing Slack in Picoseconds');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_milestone` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` SET TAGS ('dbx_subdomain' = 'verification_execution');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `verification_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan (DVP) ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `design_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Verification Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit (IC) Design Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `assertion_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Assertion Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `bug_tracking_project_key` SET TAGS ('dbx_business_glossary_term' = 'Bug Tracking Project Key');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `bug_tracking_system` SET TAGS ('dbx_business_glossary_term' = 'Bug Tracking System');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `code_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Code Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Design Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `dft_strategy` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `emulation_platform` SET TAGS ('dbx_business_glossary_term' = 'Emulation Platform');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `fault_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Fault Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `fault_injection_campaign_planned` SET TAGS ('dbx_business_glossary_term' = 'Fault Injection Campaign Planned Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `fmeda_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Effects and Diagnostic Analysis (FMEDA) Document ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `formal_verification_tool` SET TAGS ('dbx_business_glossary_term' = 'Formal Verification Tool');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `fpga_prototype_platform` SET TAGS ('dbx_business_glossary_term' = 'Field-Programmable Gate Array (FPGA) Prototype Platform');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `functional_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Functional Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `ip_reuse_count` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Reuse Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `iso26262_asil_decomposition` SET TAGS ('dbx_business_glossary_term' = 'ISO 26262 Automotive Safety Integrity Level (ASIL) Decomposition Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Plan End Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan (DVP) Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^DVP-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Plan Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `regression_run_frequency` SET TAGS ('dbx_business_glossary_term' = 'Regression Run Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `regression_run_frequency` SET TAGS ('dbx_value_regex' = 'continuous|nightly|weekly|milestone_triggered|on_demand');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `regression_suite_name` SET TAGS ('dbx_business_glossary_term' = 'Regression Suite Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `safety_criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Automotive Safety Integrity Level (ASIL) / Safety Integrity Level (SIL) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `safety_mechanism_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Safety Mechanism Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `scan_chain_count` SET TAGS ('dbx_business_glossary_term' = 'Scan Chain Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `signoff_approved` SET TAGS ('dbx_business_glossary_term' = 'Verification Sign-Off Approved Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `signoff_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Verification Sign-Off Criteria Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Sign-Off Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `simulation_tool` SET TAGS ('dbx_business_glossary_term' = 'Simulation Tool');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `tapeout_target_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Target Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `target_process_node` SET TAGS ('dbx_business_glossary_term' = 'Target Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `testbench_architecture` SET TAGS ('dbx_business_glossary_term' = 'Testbench Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `testbench_architecture` SET TAGS ('dbx_value_regex' = 'UVM_layered|directed|constrained_random|hybrid|cocotb|SystemC');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `toggle_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Toggle Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `verification_methodology` SET TAGS ('dbx_business_glossary_term' = 'Verification Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `verification_methodology` SET TAGS ('dbx_value_regex' = 'UVM|formal|emulation|FPGA_prototyping|hybrid|mixed_signal');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` SET TAGS ('dbx_subdomain' = 'reusable_assets');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` SET TAGS ('dbx_association_edges' = 'design.ic_design_project,packaging.package_type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `package_compatibility_id` SET TAGS ('dbx_business_glossary_term' = 'Package Compatibility Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `assessed_date` SET TAGS ('dbx_business_glossary_term' = 'Assessed Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `ball_count` SET TAGS ('dbx_business_glossary_term' = 'Ball Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `body_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Body Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `compatibility_grade` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Grade');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `compatibility_notes` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `compatibility_status` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `constraints` SET TAGS ('dbx_business_glossary_term' = 'Constraints');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `io_count` SET TAGS ('dbx_business_glossary_term' = 'Io Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `is_recommended` SET TAGS ('dbx_business_glossary_term' = 'Is Recommended');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `max_die_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Max Die Area Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `max_die_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Max Die Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `max_io_count` SET TAGS ('dbx_business_glossary_term' = 'Max Io Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `max_junction_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Max Junction Temp C');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `max_power_dissipation_w` SET TAGS ('dbx_business_glossary_term' = 'Max Power Dissipation W');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `max_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Max Temp C');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `mechanical_fit_notes` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Fit Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `min_ball_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Min Ball Pitch Um');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `min_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Min Temp C');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `package_type_code` SET TAGS ('dbx_business_glossary_term' = 'Package Type Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Pin Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `pin_pitch_mm` SET TAGS ('dbx_business_glossary_term' = 'Pin Pitch Mm');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `pitch_mm` SET TAGS ('dbx_business_glossary_term' = 'Pitch Mm');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `qualification_reference` SET TAGS ('dbx_business_glossary_term' = 'Qualification Reference');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `qualified_date` SET TAGS ('dbx_business_glossary_term' = 'Qualified Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `required_die_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Required Die Pitch Um');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `substrate_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Substrate Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `thermal_budget_c` SET TAGS ('dbx_business_glossary_term' = 'Thermal Budget C');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `thermal_rating` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `thermal_rating_c` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating C');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `thermal_resistance` SET TAGS ('dbx_business_glossary_term' = 'Thermal Resistance');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `thermal_resistance_jc` SET TAGS ('dbx_business_glossary_term' = 'Thermal Resistance Jc');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `thermal_resistance_rating` SET TAGS ('dbx_business_glossary_term' = 'Thermal Resistance Rating');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `validated_date` SET TAGS ('dbx_business_glossary_term' = 'Validated Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`package_compatibility` ALTER COLUMN `validation_method` SET TAGS ('dbx_business_glossary_term' = 'Validation Method');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `design_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `prior_design_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Design Revision Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `prior_design_revision_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `area_um2` SET TAGS ('dbx_business_glossary_term' = 'Area Um2');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Checksum');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `design_complexity_metric` SET TAGS ('dbx_business_glossary_term' = 'Design Complexity Metric');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `design_file_path` SET TAGS ('dbx_business_glossary_term' = 'Design File Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `design_owner_team` SET TAGS ('dbx_business_glossary_term' = 'Design Owner Team');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `design_revision_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `design_stage` SET TAGS ('dbx_business_glossary_term' = 'Design Stage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Design Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `designer` SET TAGS ('dbx_business_glossary_term' = 'Designer');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `place_and_route_tool` SET TAGS ('dbx_business_glossary_term' = 'Place And Route Tool');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `power_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Mw');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `power_report_available` SET TAGS ('dbx_business_glossary_term' = 'Power Report Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `reviewer` SET TAGS ('dbx_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `revision_label` SET TAGS ('dbx_business_glossary_term' = 'Revision Label');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `synthesis_tool` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Tool');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `timing_report_available` SET TAGS ('dbx_business_glossary_term' = 'Timing Report Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `timing_slack_ns` SET TAGS ('dbx_business_glossary_term' = 'Timing Slack Ns');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `tool_version` SET TAGS ('dbx_business_glossary_term' = 'Tool Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Valid Until');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `version_control_branch` SET TAGS ('dbx_business_glossary_term' = 'Version Control Branch');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`design_revision` ALTER COLUMN `version_control_commit` SET TAGS ('dbx_business_glossary_term' = 'Version Control Commit');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Design Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `requester_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `superseded_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Change Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `superseded_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `communication_plan` SET TAGS ('dbx_business_glossary_term' = 'Communication Plan');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost Actual');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `deployment_window` SET TAGS ('dbx_business_glossary_term' = 'Deployment Window');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `change_request_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `impact_analysis` SET TAGS ('dbx_business_glossary_term' = 'Impact Analysis');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `impacted_modules` SET TAGS ('dbx_business_glossary_term' = 'Impacted Modules');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Change Request Origin');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `planned_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `post_implementation_review` SET TAGS ('dbx_business_glossary_term' = 'Post Implementation Review');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `related_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Related Ticket Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `rollback_plan` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Change Request Source');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `target_release` SET TAGS ('dbx_business_glossary_term' = 'Target Release');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `testing_status` SET TAGS ('dbx_business_glossary_term' = 'Testing Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`change_request` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
