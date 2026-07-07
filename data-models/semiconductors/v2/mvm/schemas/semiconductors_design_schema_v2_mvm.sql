-- Schema for Domain: design | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:13:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`design` COMMENT 'IC design and architecture lifecycle from RTL specification through GDS/GDSII tapeout. Manages IP cores, PDK libraries, EDA tool flows, DFM and DFT rule sets, logic synthesis, physical design, timing closure data, and MPW shuttle assignments. Integrates with Cadence Virtuoso, Synopsys Design Compiler, and PrimeTime for design data provenance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` (
    `ic_design_project_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'FK to customer account',
    `ic_catalog_id` BIGINT COMMENT 'FK to product ic catalog',
    `nda_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.nda_agreement. Business justification: NDA compliance tracking: semiconductor design projects share PDK, IP, and design data under a specific customer NDA. Export control and IP protection audits require knowing which NDA governs each desi',
    `pdk_id` BIGINT COMMENT 'FK to design pdk',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`ip_core` (
    `ip_core_id` BIGINT COMMENT 'Primary key',
    `pdk_id` BIGINT COMMENT 'FK to design PDK',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: IP qualification matrix: semiconductor engineers track which IP cores are qualified for each process node to enable IP reuse decisions. This is a standard deliverable in PDK/IP qualification workflows',
    `area_um2` DECIMAL(18,2) COMMENT 'Area in um2',
    `ip_core_code` STRING COMMENT 'Coded value representing the ip core code of the design ip core design record.',
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
    `ip_type` STRING COMMENT 'The ip type of the design ip core record in the design domain.',
    `lef_available` BOOLEAN COMMENT 'LEF available flag',
    `license_expiry_date` DATE COMMENT 'The license expiry date associated with the design ip core design record.',
    `license_fee_usd` DECIMAL(18,2) COMMENT 'License fee in USD',
    `license_type` STRING COMMENT 'The license type of the design ip core record in the design domain.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status of the design ip core record in the design domain.',
    `max_frequency_mhz` DECIMAL(18,2) COMMENT 'Max frequency in MHz',
    `mpw_eligible` BOOLEAN COMMENT 'MPW eligible flag',
    `ip_core_name` STRING COMMENT 'IP core name',
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
    CONSTRAINT pk_ip_core PRIMARY KEY(`ip_core_id`)
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`netlist` (
    `netlist_id` BIGINT COMMENT 'Primary key',
    `ip_core_id` BIGINT COMMENT 'FK to design IP core',
    `pdk_id` BIGINT COMMENT 'FK to design PDK',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Netlists are synthesized targeting a specific process node; timing closure, power analysis, and cell library selection are all process-node-driven. Normalizing process_node_nm into a proper FK enables',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.design_revision. Business justification: A synthesized netlist is produced from a specific RTL design revision. Linking netlist to design_revision establishes full design provenance: which revision of the RTL was synthesized to produce this ',
    `ic_design_project_id` BIGINT COMMENT 'FK to design IC design project',
    `to_pdk_id` BIGINT COMMENT 'FK to design PDK',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` (
    `physical_layout_id` BIGINT COMMENT 'Unique surrogate identifier for each physical design layout record in the Databricks Silver Layer. Serves as the primary key for the physical_layout data product.',
    `netlist_id` BIGINT COMMENT 'FK to design.netlist.netlist_id — Physical layout (place and route) takes a netlist as input. This is the core PnR flow linkage required for design provenance.',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) version used for this physical layout. The PDK defines the technology node rules, design rule checks (DRC), and layer stack for the target fabrication process.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the parent IC design record for which this physical layout iteration was produced. Links the layout to its originating design project.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.design_revision. Business justification: A physical layout (floorplan, placement, routing) is implemented against a specific design revision. Linking physical_layout to design_revision provides the provenance chain from RTL revision through ',
    `to_ic_design_project_id` BIGINT COMMENT 'FK to design.ic_design_project.ic_design_project_id — Physical layouts belong to a specific IC design project. Required for design artifact management.',
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
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Enables tracking of each tapeout against its originating design win for NRE cost recovery and warranty reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA) associated with this tapeout event. Links the tapeout to the product master record.',
    `nda_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.nda_agreement. Business justification: Tapeout GDS file and design IP sharing with customers requires a governing NDA. Tapeout sign-off checklists and export control audits must reference the specific NDA authorizing data disclosure. Tapeo',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) version used for this tapeout. The PDK defines the foundry-specific design rules, device models, and layer stack used during physical design.',
    `physical_layout_id` BIGINT COMMENT 'FK to design.physical_layout.physical_layout_id — Tapeout submits a final physical layout (GDS) to the foundry. Must reference which layout version was taped out.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Tapeout is a foundry submission for a specific process node; yield analysis, mask cost tracking, and NRE reporting are all grouped by process node. Normalizing the plain process_node attribute into a ',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.design_revision. Business justification: A tapeout event captures the final design submission for manufacturing and must reference the exact design_revision that was submitted. The tapeout table currently has a denormalized STRING column de',
    `ic_design_project_id` BIGINT COMMENT 'FK to design.ic_design_project.ic_design_project_id — A tapeout event is the culmination of an IC design project. This is the critical milestone linkage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tapeout record was first created in the system. Used for audit trail and data lineage tracking.',
    `design_name` STRING COMMENT 'Human-readable name of the IC design being taped out (e.g., product code name or internal design designation). Used for identification in design review meetings and foundry communications.',
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
    `number` STRING COMMENT 'Externally-known business identifier for the tapeout event, used in communications with the foundry, mask house, and internal design teams. Follows the format TO-<DESIGN_CODE>-<YEAR>.. Valid values are `^TO-[A-Z0-9]{4,20}-[0-9]{4}$`',
    `opc_ret_status` STRING COMMENT 'Processing status of Optical Proximity Correction (OPC) and Resolution Enhancement Technology (RET) applied to the GDS data prior to mask tape-out. OPC/RET is mandatory for sub-28nm nodes to compensate for photolithographic distortion effects.. Valid values are `not_started|in_progress|completed|waived`',
    `packaging_type` STRING COMMENT 'Intended die packaging technology for the taped-out design (e.g., WLCSP, CoWoS, InFO, flip-chip BGA, QFN). Informs OSAT engagement, assembly NRE planning, and downstream packaging domain linkage. [ENUM-REF-CANDIDATE: WLCSP|CoWoS|InFO|flip_chip_BGA|QFN|BGA|LGA|SiP — promote to reference product]',
    `process_technology` STRING COMMENT 'Transistor architecture and process technology type used for this tapeout. Distinguishes between planar CMOS, FinFET, Gate-All-Around (GAA), and specialty process technologies relevant to device performance and yield modeling. [ENUM-REF-CANDIDATE: CMOS|FinFET|GAA|BiCMOS|SiGe|GaN|SiC|SOI — 8 candidates stripped; promote to reference product]',
    `signoff_checklist_complete` BOOLEAN COMMENT 'Indicates whether all items on the design sign-off checklist have been completed and approved prior to tapeout submission. The checklist covers DRC, LVS, ERC, timing closure, power analysis, DFT, and IP sign-off milestones.',
    `tapeout_date` DATE COMMENT 'The principal real-world business event date on which the final GDS/GDSII design data was submitted to the foundry or mask house for manufacturing. This is the definitive tapeout milestone date used in project tracking and TTM reporting.',
    `tapeout_status` STRING COMMENT 'Current lifecycle state of the tapeout event. Tracks progression from internal preparation through foundry acceptance or rejection. [ENUM-REF-CANDIDATE: draft|pending_signoff|submitted|accepted|rejected|cancelled — promote to reference product if additional states are needed]. Valid values are `draft|pending_signoff|submitted|accepted|rejected|cancelled`',
    `tapeout_type` STRING COMMENT 'Classification of the tapeout run type. Distinguishes full custom dedicated wafer tapeouts, Multi-Project Wafer (MPW) shuttle runs, engineering sample tapeouts, and production tapeouts. Drives cost allocation and foundry scheduling.. Valid values are `full_custom|mpw|engineering_sample|production`',
    `target_market_segment` STRING COMMENT 'Primary market segment for which the taped-out IC is designed. Used for business reporting, revenue forecasting, and strategic portfolio analysis. [ENUM-REF-CANDIDATE: mobile|automotive|datacenter|IoT|industrial|consumer|aerospace_defense|networking — promote to reference product]',
    `target_tapeout_date` DATE COMMENT 'Originally planned tapeout date as committed in the project schedule. Used to measure schedule adherence and Time to Market (TTM) variance against the actual tapeout date.',
    `timing_closure_status` STRING COMMENT 'Status of static timing analysis (STA) sign-off at tapeout. Indicates whether all timing paths met setup and hold constraints (clean), had approved waivers (waived), or had unresolved violations (failed). Sourced from Synopsys PrimeTime or Cadence Tempus.. Valid values are `clean|waived|failed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the tapeout record was last modified. Used for change tracking, audit compliance, and incremental data pipeline processing.',
    `wafer_count_ordered` STRING COMMENT 'Number of wafers ordered from the foundry for this tapeout run. Used for production planning, yield forecasting, and supply chain management. Applicable for dedicated tapeouts; for MPW runs, this reflects the allocated wafer share.',
    CONSTRAINT pk_tapeout PRIMARY KEY(`tapeout_id`)
) COMMENT 'Tapeout event record capturing the final design submission milestone for manufacturing. Records tapeout date, GDS/GDSII file version, mask set identifier, foundry submission reference, PDK version used, final DRC/LVS clean status, OPC/RET processing status, design sign-off checklist completion, NRE cost committed, and MPW shuttle assignment if applicable. SSOT for tapeout provenance linking design to fabrication domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` (
    `verification_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the design verification plan record within the Databricks Silver Layer lakehouse. Primary key for this entity.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the parent IC design project for which this verification plan is authored. Links the plan to the RTL-to-GDSII design project record managed in Cadence Virtuoso/Innovus or Siemens Teamcenter PLM.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Verification plans are scoped to a process node for qualification sign-off; process node qualification requires verification coverage evidence. Normalizing target_process_node into a FK enables proces',
    `revision_id` BIGINT COMMENT 'Reference to the specific RTL or netlist design revision under verification. Ensures the verification plan is tied to a precise design snapshot, supporting traceability from verification results back to the design state at time of sign-off.',
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
    `testbench_architecture` STRING COMMENT 'Structural architecture of the simulation testbench. UVM_layered follows the standard UVM agent/scoreboard/coverage hierarchy; directed uses manually written test vectors; constrained_random uses SystemVerilog randomization; cocotb uses Python-based co-simulation; SystemC uses transaction-level modeling. [ENUM-REF-CANDIDATE: UVM_layered|directed|constrained_random|hybrid|cocotb|SystemC — promote to reference product]. Valid values are `UVM_layered|directed|constrained_random|hybrid|cocotb|SystemC`',
    `toggle_coverage_target_pct` DECIMAL(18,2) COMMENT 'Target toggle coverage percentage for all RTL signals, ensuring each net transitions both 0→1 and 1→0 during simulation. Used as a DFT readiness indicator and a structural verification completeness metric.',
    `verification_methodology` STRING COMMENT 'Primary pre-silicon verification methodology employed for this plan. UVM (Universal Verification Methodology) is the industry-standard constrained-random simulation approach; formal uses mathematical property checking; emulation uses hardware accelerators; FPGA_prototyping uses field-programmable gate arrays for early software bring-up. [ENUM-REF-CANDIDATE: UVM|formal|emulation|FPGA_prototyping|hybrid|mixed_signal — promote to reference product]. Valid values are `UVM|formal|emulation|FPGA_prototyping|hybrid|mixed_signal`',
    CONSTRAINT pk_verification_plan PRIMARY KEY(`verification_plan_id`)
) COMMENT 'Design verification plan master record defining the pre-silicon verification strategy for an IC design project. Captures verification methodology (UVM, formal, emulation, FPGA prototyping), coverage goals (functional, code, toggle, assertion), testbench architecture, simulation environment configuration, DFT strategy (ATPG, BIST, scan chain, boundary scan), verification milestones and schedule, tool assignments, regression suite definitions, bug tracking integration, and sign-off criteria. For automotive and safety-critical designs, captures ISO 26262 functional safety verification requirements including ASIL decomposition, safety mechanism coverage targets, fault injection campaign plans, and FMEDA linkage. Ensures systematic verification coverage and regulatory compliance before tapeout.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`revision` (
    `revision_id` BIGINT COMMENT 'Primary key for design_revision',
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
    `design_stage` STRING COMMENT 'Current development stage of the design for this revision.',
    `design_type` STRING COMMENT 'Technology category of the design.',
    `designer` STRING COMMENT 'Name of the primary engineer or team that authored the revision.',
    `file_format` STRING COMMENT 'Standard file format of the stored design data.',
    `gate_count` BIGINT COMMENT 'Total number of logic gates in the design for this revision.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the revision addresses a critical issue.',
    `label` STRING COMMENT 'Human‑readable label or name for the design revision (e.g., "Rev_A1").',
    `place_and_route_tool` STRING COMMENT 'Name of the place‑and‑route tool used (e.g., Cadence Innovus).',
    `power_mw` DECIMAL(18,2) COMMENT 'Estimated power consumption of the design in milliwatts.',
    `power_report_available` BOOLEAN COMMENT 'Indicates whether a post‑layout power analysis report exists for this revision.',
    `release_date` DATE COMMENT 'Calendar date when the revision was officially released to downstream teams.',
    `release_notes` STRING COMMENT 'Detailed notes accompanying the release of this revision.',
    `review_status` STRING COMMENT 'Outcome of the design review process.',
    `reviewer` STRING COMMENT 'Name of the engineer or manager who performed the formal review.',
    `revision_number` STRING COMMENT 'External version number assigned to the revision (e.g., "1.0.3").',
    `revision_status` STRING COMMENT 'Current lifecycle state of the design revision.',
    `revision_type` STRING COMMENT 'Category of the revision indicating its impact scope.',
    `synthesis_tool` STRING COMMENT 'Name of the logic synthesis tool used (e.g., Synopsys Design Compiler).',
    `timing_report_available` BOOLEAN COMMENT 'Indicates whether a timing analysis report exists for this revision.',
    `timing_slack_ns` DECIMAL(18,2) COMMENT 'Worst negative timing slack for the design in nanoseconds.',
    `tool_version` STRING COMMENT 'Version of the EDA tool suite used to generate this revision.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revision record.',
    `valid_until` DATE COMMENT 'Date after which the revision is considered obsolete or superseded.',
    `version_control_branch` STRING COMMENT 'Source‑control branch name where the revision is tracked.',
    `version_control_commit` STRING COMMENT 'Commit hash or identifier linking to the exact source code snapshot.',
    CONSTRAINT pk_revision PRIMARY KEY(`revision_id`)
) COMMENT 'Master reference table for design_revision. Referenced by design_revision_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` (
    `ip_integration_id` BIGINT COMMENT 'Primary key uniquely identifying each IP core integration instance within a design project',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key to the IP core being integrated',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to the IC design project that integrates the IP core',
    `ip_core_id` BIGINT COMMENT 'Foreign key linking to the IP core being integrated into the design project',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration record was created in the system',
    `instance_count` STRING COMMENT 'Number of instances of this IP core instantiated within the design project. Affects area, power, and licensing calculations.',
    `integration_date` DATE COMMENT 'Date when the IP core was integrated into the design project. Used for milestone tracking and schedule management.',
    `integration_engineer_name` BIGINT COMMENT 'Engineer responsible for integrating and verifying this IP core instance within the design project',
    `integration_status` STRING COMMENT 'Current status of the IP integration workflow (planned, in_progress, integrated, verified, signed_off, failed). Tracks progression through integration gates.',
    `ip_core_count` STRING COMMENT 'Number of IP cores [Moved from ic_design_project: This attribute currently on ic_design_project is a derived count that would be calculated by aggregating ip_integration records. It represents the cardinality of the M:N relationship and should not be stored redundantly on the project table.]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this integration record',
    `license_usage_count` STRING COMMENT 'Number of license seats consumed by this integration instance. Used for royalty calculation and license compliance tracking.',
    `sign_off_status` STRING COMMENT 'Design review sign-off status for this IP integration (pending, approved, rejected, conditional). Required for tapeout gate progression.',
    `verification_completion_pct` DECIMAL(18,2) COMMENT 'Percentage of verification test cases completed for this IP integration instance',
    `version_used` STRING COMMENT 'Specific version of the IP core integrated into this design project. Critical for silicon-proven status tracking and tapeout documentation.',
    CONSTRAINT pk_ip_integration PRIMARY KEY(`ip_integration_id`)
) COMMENT 'This association product represents the integration instance of a reusable IP core into a specific IC design project. It captures the operational relationship between IP cores and design projects, tracking version compatibility, licensing consumption, integration status, and sign-off gates. Each record represents one IP core integrated into one design project with attributes that exist only in the context of this specific integration instance.. Existence Justification: In semiconductor IC design, IP core integration is a recognized operational business process with dedicated workflows, sign-off gates, and license tracking managed in EDA tools (Cadence Virtuoso, Synopsys). A single IP core (e.g., ARM CPU, Synopsys DDR controller) is reused across multiple design projects simultaneously, and each design project integrates multiple IP cores to compose the complete SoC. The business actively manages each integration instance with version selection, license consumption tracking, verification status, and design review sign-offs.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ADD CONSTRAINT `fk_design_ip_core_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_ip_core_id` FOREIGN KEY (`ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ip_core`(`ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_to_pdk_id` FOREIGN KEY (`to_pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_netlist_id` FOREIGN KEY (`netlist_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`netlist`(`netlist_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_to_ic_design_project_id` FOREIGN KEY (`to_ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_prior_design_revision_id` FOREIGN KEY (`prior_design_revision_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`revision`(`revision_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ADD CONSTRAINT `fk_design_ip_integration_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ip_core`(`ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ADD CONSTRAINT `fk_design_ip_integration_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ADD CONSTRAINT `fk_design_ip_integration_ip_core_id` FOREIGN KEY (`ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ip_core`(`ip_core_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`design` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`design` SET TAGS ('dbx_domain' = 'design');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `area_um2` SET TAGS ('dbx_business_glossary_term' = 'Area Um2');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `ip_core_code` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Code');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `datasheet_url` SET TAGS ('dbx_business_glossary_term' = 'Datasheet Url');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `dfm_compliant` SET TAGS ('dbx_business_glossary_term' = 'Dfm Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `dft_compliant` SET TAGS ('dbx_business_glossary_term' = 'Dft Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `eda_tool_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `foundry_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Foundry Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `function_category` SET TAGS ('dbx_business_glossary_term' = 'Function Category');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `functional_description` SET TAGS ('dbx_business_glossary_term' = 'Functional Description');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `gds_available` SET TAGS ('dbx_business_glossary_term' = 'Gds Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `interface_standard` SET TAGS ('dbx_business_glossary_term' = 'Interface Standard');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `ip_type` SET TAGS ('dbx_business_glossary_term' = 'Ip Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `lef_available` SET TAGS ('dbx_business_glossary_term' = 'Lef Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `license_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'License Fee Usd');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `max_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Max Frequency Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `mpw_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mpw Eligible');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `ip_core_name` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `nda_required` SET TAGS ('dbx_business_glossary_term' = 'Nda Required');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `power_uw` SET TAGS ('dbx_business_glossary_term' = 'Power Uw');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Pct');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `rtl_language` SET TAGS ('dbx_business_glossary_term' = 'Rtl Language');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `scan_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Scan Coverage Pct');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `silicon_proven` SET TAGS ('dbx_business_glossary_term' = 'Silicon Proven');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `silicon_proven_date` SET TAGS ('dbx_business_glossary_term' = 'Silicon Proven Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Tier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `timing_model_available` SET TAGS ('dbx_business_glossary_term' = 'Timing Model Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
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
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` SET TAGS ('dbx_subdomain' = 'physical_implementation');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Pdk Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`netlist` ALTER COLUMN `to_pdk_id` SET TAGS ('dbx_business_glossary_term' = 'To Pdk Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` SET TAGS ('dbx_subdomain' = 'physical_implementation');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'IC Design ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`physical_layout` ALTER COLUMN `to_ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` SET TAGS ('dbx_subdomain' = 'physical_implementation');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `design_name` SET TAGS ('dbx_business_glossary_term' = 'Design Name');
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
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^TO-[A-Z0-9]{4,20}-[0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `opc_ret_status` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction / Resolution Enhancement Technology (OPC/RET) Processing Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `opc_ret_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|waived');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `signoff_checklist_complete` SET TAGS ('dbx_business_glossary_term' = 'Design Sign-Off Checklist Completion Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
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
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `verification_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan (DVP) ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit (IC) Design Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `testbench_architecture` SET TAGS ('dbx_business_glossary_term' = 'Testbench Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `testbench_architecture` SET TAGS ('dbx_value_regex' = 'UVM_layered|directed|constrained_random|hybrid|cocotb|SystemC');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `toggle_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Toggle Coverage Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `verification_methodology` SET TAGS ('dbx_business_glossary_term' = 'Verification Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`verification_plan` ALTER COLUMN `verification_methodology` SET TAGS ('dbx_value_regex' = 'UVM|formal|emulation|FPGA_prototyping|hybrid|mixed_signal');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `prior_design_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Design Revision Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `prior_design_revision_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `area_um2` SET TAGS ('dbx_business_glossary_term' = 'Area Um2');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Checksum');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `design_complexity_metric` SET TAGS ('dbx_business_glossary_term' = 'Design Complexity Metric');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `design_file_path` SET TAGS ('dbx_business_glossary_term' = 'Design File Path');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `design_owner_team` SET TAGS ('dbx_business_glossary_term' = 'Design Owner Team');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `design_stage` SET TAGS ('dbx_business_glossary_term' = 'Design Stage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Design Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `designer` SET TAGS ('dbx_business_glossary_term' = 'Designer');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Revision Label');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `place_and_route_tool` SET TAGS ('dbx_business_glossary_term' = 'Place And Route Tool');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `power_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Mw');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `power_report_available` SET TAGS ('dbx_business_glossary_term' = 'Power Report Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `reviewer` SET TAGS ('dbx_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Type');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `synthesis_tool` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Tool');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `timing_report_available` SET TAGS ('dbx_business_glossary_term' = 'Timing Report Available');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `timing_slack_ns` SET TAGS ('dbx_business_glossary_term' = 'Timing Slack Ns');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `tool_version` SET TAGS ('dbx_business_glossary_term' = 'Tool Version');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Valid Until');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `version_control_branch` SET TAGS ('dbx_business_glossary_term' = 'Version Control Branch');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`revision` ALTER COLUMN `version_control_commit` SET TAGS ('dbx_business_glossary_term' = 'Version Control Commit');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` SET TAGS ('dbx_subdomain' = 'project_lifecycle');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` SET TAGS ('dbx_association_edges' = 'design.design_ip_core,design.ic_design_project');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `ip_integration_id` SET TAGS ('dbx_business_glossary_term' = 'IP Integration Instance Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'IP Core Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Integration - Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Integration - Design Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `instance_count` SET TAGS ('dbx_business_glossary_term' = 'Instance Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `integration_date` SET TAGS ('dbx_business_glossary_term' = 'Integration Date');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `integration_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Integration Engineer');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `ip_core_count` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `license_usage_count` SET TAGS ('dbx_business_glossary_term' = 'License Usage Count');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign-off Status');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `verification_completion_pct` SET TAGS ('dbx_business_glossary_term' = 'Verification Completion Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_integration` ALTER COLUMN `version_used` SET TAGS ('dbx_business_glossary_term' = 'IP Core Version Used');
