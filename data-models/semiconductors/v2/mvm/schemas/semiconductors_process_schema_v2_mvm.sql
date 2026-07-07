-- Schema for Domain: process | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:14:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`process` COMMENT 'Process engineering data for all semiconductor manufacturing process flows including photolithography, etch, diffusion, implant, deposition, and metrology steps. Manages SPC control charts, process capability indices, OPC rule sets, MEEF parameters, process qualification, yield optimization, and technology node readiness.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`flow` (
    `flow_id` BIGINT COMMENT 'Unique identifier for the semiconductor manufacturing process flow definition. Primary key.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Process flows are scoped to a product family (e.g., automotive MCU family). The plain column device_family is a denormalized string reference to product.family. A proper FK enables product family pr',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) that defines the design rules, device models, and technology files associated with this process flow.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Process flows are explicitly designed for a specific product process node — process engineers query which flows are qualified for node X? daily. The existing plain column flow_for_node is a denorm',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: A process flow is designed and qualified against specific quality specifications (defect density, CD uniformity). Quality engineers reference quality_spec when reviewing process flows for node qualifi',
    `baseline_cpk` DECIMAL(18,2) COMMENT 'Baseline process capability index (Cpk) representing the statistical process control capability of the flow at qualification.',
    `beol_step_count` STRING COMMENT 'Number of process steps in the Back End of Line (BEOL) phase, covering metal interconnect layers and passivation.',
    `flow_code` STRING COMMENT 'Unique alphanumeric code identifying the process flow in manufacturing execution systems and production planning. Used as the external business identifier.',
    `cool_optimization_enabled` BOOLEAN COMMENT 'Whether cool optimization options are enabled for the flow.',
    `cooling_step_count` STRING COMMENT 'Number of cooling steps in the flow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was first created in the system.',
    `critical_layer_count` STRING COMMENT 'Number of critical layers requiring advanced lithography techniques (EUV, multi-patterning, or tight overlay control).',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Standard manufacturing cycle time in days for a wafer lot to complete the entire process flow under normal production conditions.',
    `flow_description` STRING COMMENT 'Detailed textual description of the process flow, including key process characteristics, intended applications, and any special considerations.',
    `dfm_rule_set_version` STRING COMMENT 'Version identifier of the Design for Manufacturability (DFM) rule set associated with this process flow.',
    `effective_end_date` DATE COMMENT 'Date when this process flow version was superseded or retired from production use. Null for currently active flows.',
    `effective_start_date` DATE COMMENT 'Date when this process flow version became effective and available for production use.',
    `euv_layer_count` STRING COMMENT 'Number of layers using Extreme Ultraviolet (EUV) lithography in the process flow.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility (FAB) where this process flow is qualified and executed.',
    `feol_step_count` STRING COMMENT 'Number of process steps in the Front End of Line (FEOL) phase, covering transistor formation and isolation.',
    `flow_type` STRING COMMENT 'Classification of the process flow by device application domain (logic, memory, analog, mixed-signal, power, RF, sensor). [ENUM-REF-CANDIDATE: logic|memory|analog|mixed_signal|power|rf|sensor — 7 candidates stripped; promote to reference product]',
    `is_baseline_flow` BOOLEAN COMMENT 'Flag indicating whether this is the baseline (reference) process flow for the technology node. True if baseline, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was last modified or updated.',
    `lithography_layer_count` STRING COMMENT 'Total number of photolithography (patterning) layers in the complete process flow.',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers defined in the BEOL portion of the process flow.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `mol_step_count` STRING COMMENT 'Number of process steps in the Middle of Line (MOL) phase, covering contact formation and local interconnects.',
    `flow_name` STRING COMMENT 'Business name of the process flow, typically indicating the technology node and device family (e.g., 5nm FinFET Logic Flow, 28nm CMOS Analog Flow).',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the process flow execution, qualification, or usage.',
    `opc_rule_set_version` STRING COMMENT 'Version identifier of the Optical Proximity Correction (OPC) rule set used for mask data preparation in this process flow.',
    `owner_organization` STRING COMMENT 'Process engineering organization or department responsible for this process flow (e.g., Advanced Logic Process, Memory Process Engineering).',
    `qualification_date` DATE COMMENT 'Date when the process flow successfully completed qualification testing and was approved for production release.',
    `qualification_status` STRING COMMENT 'Current qualification and release status of the process flow. Indicates readiness for production use.. Valid values are `development|qualification|qualified|production|deprecated|obsolete`',
    `revision` STRING COMMENT 'Version or revision identifier for the process flow definition. Incremented when process steps, parameters, or sequences are modified.',
    `supports_multi_patterning` BOOLEAN COMMENT 'Flag indicating whether the process flow includes multi-patterning lithography techniques (LELE, SADP, SAQP). True if multi-patterning is used, False otherwise.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target die yield percentage (good dies per wafer) for production lots running this qualified process flow.',
    `total_step_count` STRING COMMENT 'Total number of unit process steps in the complete flow from wafer start through final inspection.',
    `waste_heat_recovery_enabled` BOOLEAN COMMENT 'Whether waste heat recovery is enabled in the flow.',
    CONSTRAINT pk_flow PRIMARY KEY(`flow_id`)
) COMMENT 'Master definition of a semiconductor manufacturing process flow (recipe sequence) for a given technology node. Captures the ordered sequence of unit process steps from FEOL through MOL and BEOL, including process node designation (e.g., 5nm, 3nm, 28nm), flow revision, qualification status, applicable device families, and PDK linkage. SSOT for all process flow definitions used in wafer fabrication.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`step` (
    `step_id` BIGINT COMMENT 'Unique identifier for the individual process step within the semiconductor manufacturing process flow. Primary key.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Production planning assigns each process step a primary fab tool; the step definition must reference the specific fab_tool for scheduling and capacity planning.',
    `technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this process step is designed and qualified.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Step definition includes the default chamber where the operation occurs; linking enables chamber allocation, maintenance, and utilization reporting.',
    `cooling_target_temperature_celsius` DECIMAL(18,2) COMMENT 'Target temperature after cooling at this step.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was first created in the system.',
    `cycle_time_target_minutes` DECIMAL(18,2) COMMENT 'Target processing time for this step in minutes, used for manufacturing planning, scheduling, and throughput optimization.',
    `step_description` STRING COMMENT 'Detailed textual description of the process step, including technical objectives, materials used, and special handling requirements.',
    `dose_target` DECIMAL(18,2) COMMENT 'Target ion implantation dose in ions per square centimeter, or exposure dose in millijoules per square centimeter for lithography steps.',
    `effective_end_date` DATE COMMENT 'Date when this process step version was superseded or retired from active use. Null indicates currently active.',
    `effective_start_date` DATE COMMENT 'Date when this process step version became effective and available for use in production flows.',
    `energy_target_kev` DECIMAL(18,2) COMMENT 'Target ion implantation energy in kilo-electron volts (keV), controlling the depth of dopant penetration into the silicon substrate.',
    `gas_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Nominal gas flow rate in standard cubic centimeters per minute (SCCM) for process steps involving gas delivery such as CVD or etch.',
    `is_cooling_step` BOOLEAN COMMENT 'Whether this step is a cooling step.',
    `is_critical_step` BOOLEAN COMMENT 'Boolean flag indicating whether this step is classified as critical for yield, quality, or device performance, requiring enhanced monitoring and control.',
    `is_rework_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether wafers can be reworked or reprocessed through this step if defects or out-of-spec conditions are detected.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was most recently updated, supporting audit trail and change tracking.',
    `meef_value` DECIMAL(18,2) COMMENT 'Mask Error Enhancement Factor for lithography steps, quantifying how mask CD errors are amplified on the wafer.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `step_name` STRING COMMENT 'Human-readable name of the process step, describing the operation performed (e.g., Gate Oxide CVD, Contact Lithography, Metal 1 Etch).',
    `operation_type` STRING COMMENT 'Classification of the manufacturing operation performed in this step. Categorizes the fundamental process technology applied. [ENUM-REF-CANDIDATE: photolithography|etch|deposition|implant|diffusion|cmp|metrology|inspection|cleaning|annealing — 10 candidates stripped; promote to reference product]',
    `power_setpoint_watts` DECIMAL(18,2) COMMENT 'Nominal RF or DC power setpoint in watts for plasma-based process steps such as reactive ion etch or PECVD.',
    `pressure_setpoint_torr` DECIMAL(18,2) COMMENT 'Nominal chamber pressure setpoint in Torr for vacuum process steps such as CVD, PVD, or plasma etch.',
    `process_category` STRING COMMENT 'High-level classification indicating whether this step belongs to Front End of Line (FEOL), Middle of Line (MOL), or Back End of Line (BEOL) processing stages.. Valid values are `feol|mol|beol`',
    `process_time_seconds` DECIMAL(18,2) COMMENT 'Nominal duration of the actual process operation in seconds, excluding load/unload and setup time.',
    `qualification_date` DATE COMMENT 'Date when this process step successfully completed qualification and was approved for production release.',
    `qualification_status` STRING COMMENT 'Status of process qualification for this step, indicating whether it has passed validation testing and is approved for production use.. Valid values are `not_started|in_progress|qualified|failed|waived`',
    `sequence_order` STRING COMMENT 'Numeric ordering of this step within the parent process flow, determining the execution sequence in the manufacturing line.',
    `step_number` STRING COMMENT 'Business identifier for the process step, typically a hierarchical or sequential code used in manufacturing documentation and traveler cards.',
    `step_status` STRING COMMENT 'Current lifecycle status of the process step, indicating whether it is in active production use, under development, or retired.. Valid values are `active|inactive|development|qualification|deprecated|obsolete`',
    `target_cd_nm` DECIMAL(18,2) COMMENT 'Target critical dimension in nanometers for lithography and etch steps, defining the feature size specification.',
    `target_layer` STRING COMMENT 'The specific material layer or structure being processed in this step (e.g., Poly Gate, Metal 2, Contact Via, STI Oxide).',
    `target_thickness_angstrom` DECIMAL(18,2) COMMENT 'Target film thickness in angstroms for deposition steps, used as the process control specification.',
    `temperature_setpoint_celsius` DECIMAL(18,2) COMMENT 'Nominal process temperature setpoint in degrees Celsius for thermal process steps such as deposition, diffusion, or annealing.',
    `tool_class` STRING COMMENT 'Equipment class or tool type required to execute this process step (e.g., EUV Scanner, PECVD Reactor, CMP Polisher, Ion Implanter).',
    `version_number` STRING COMMENT 'Version identifier for this process step definition, supporting change control and revision tracking.',
    CONSTRAINT pk_step PRIMARY KEY(`step_id`)
) COMMENT 'Individual unit process step within a process flow, representing a discrete manufacturing operation such as photolithography exposure, CVD deposition, CMP planarization, ion implantation, dry etch, wet clean, or metrology measurement. Captures step sequence number, operation type, tool class, target layer, nominal recipe parameters, and step classification (FEOL/MOL/BEOL). Owned by the process domain as the atomic building block of all process flows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`recipe` (
    `recipe_id` BIGINT COMMENT 'Primary key for recipe',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: A recipe is authored for a specific fab tool model; the FK supports recipe‑tool compatibility checks and tool‑specific parameter validation.',
    `step_id` BIGINT COMMENT 'FK to process.process_step.process_step_id — Every recipe is defined for a specific process step (operation type + tool class). This FK connects the equipment-level parameters to the logical process step they implement.',
    `technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this recipe is qualified.',
    `approval_status` STRING COMMENT 'Current approval and qualification state of the recipe: draft (under development), under_review (pending approval), approved (released for use), qualified (validated on production tool), deprecated (phasing out), or obsolete (no longer valid).. Valid values are `draft|under_review|approved|qualified|deprecated|obsolete`',
    `chamber_configuration` STRING COMMENT 'Specific chamber or module configuration within the tool class, including chamber ID and hardware configuration state.',
    `cmp_pad_type` STRING COMMENT 'CMP polishing pad material and type identifier. Null for non-CMP recipes.',
    `cmp_platen_pressure_psi` DECIMAL(18,2) COMMENT 'Downforce pressure in PSI applied to wafer during CMP. Null for non-CMP recipes.',
    `cmp_removal_target_nm` DECIMAL(18,2) COMMENT 'Target material removal thickness in nanometers for CMP process. Null for non-CMP recipes.',
    `cmp_slurry_type` STRING COMMENT 'CMP slurry formulation identifier (e.g., oxide slurry, tungsten slurry, copper slurry). Null for non-CMP recipes.',
    `cmp_table_speed_rpm` DECIMAL(18,2) COMMENT 'Platen rotation speed in RPM during CMP. Null for non-CMP recipes.',
    `coolant_type` STRING COMMENT 'The coolant type of the recipe record in the process domain.',
    `cooling_rate_celsius_per_minute` DECIMAL(18,2) COMMENT 'The cooling rate celsius per minute of the recipe record in the process domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was first created in the manufacturing execution system.',
    `deposition_method` STRING COMMENT 'Thin film deposition technique: LPCVD (low pressure chemical vapor deposition), PECVD (plasma enhanced CVD), ALD (atomic layer deposition), PVD (physical vapor deposition), EPI (epitaxy), MOCVD (metal-organic CVD), or MBE (molecular beam epitaxy). Null for non-deposition recipes. [ENUM-REF-CANDIDATE: lpcvd|pecvd|ald|pvd|epi|mocvd|mbe — 7 candidates stripped; promote to reference product]',
    `deposition_pressure_torr` DECIMAL(18,2) COMMENT 'Process chamber pressure in Torr during deposition. Null for non-deposition recipes.',
    `deposition_rf_power_w` DECIMAL(18,2) COMMENT 'Radio frequency power in Watts for plasma-enhanced deposition processes (PECVD). Null for non-plasma deposition recipes.',
    `deposition_target_thickness_nm` DECIMAL(18,2) COMMENT 'Target film thickness in nanometers for deposition processes. Null for non-deposition recipes.',
    `deposition_temperature_c` DECIMAL(18,2) COMMENT 'Process chamber temperature in degrees Celsius during deposition. Null for non-deposition recipes.',
    `effective_end_date` DATE COMMENT 'Date when this recipe version is no longer valid for production use. Null for currently active recipes.',
    `effective_start_date` DATE COMMENT 'Date when this recipe version becomes effective and available for production use.',
    `etch_chemistry` STRING COMMENT 'Primary etchant chemistry or gas mixture (e.g., CF4/O2, HBr/Cl2, SF6, HF/HNO3). Null for non-etch recipes.',
    `etch_pressure_mtorr` DECIMAL(18,2) COMMENT 'Process chamber pressure in milliTorr during dry etch. Null for non-dry-etch recipes.',
    `etch_rf_bias_power_w` DECIMAL(18,2) COMMENT 'RF bias power in Watts controlling ion bombardment energy in reactive ion etch. Null for non-plasma-etch recipes.',
    `etch_rf_source_power_w` DECIMAL(18,2) COMMENT 'RF source power in Watts for plasma generation in reactive ion etch. Null for non-plasma-etch recipes.',
    `etch_selectivity_ratio` DECIMAL(18,2) COMMENT 'Ratio of etch rate of target material to etch rate of mask or underlying material, indicating process selectivity. Null for non-etch recipes.',
    `etch_type` STRING COMMENT 'Etch process category: dry (gas-phase), wet (liquid chemical), plasma, reactive ion etch (RIE), or deep reactive ion etch (DRIE). Null for non-etch recipes.. Valid values are `dry|wet|plasma|reactive_ion|deep_reactive_ion`',
    `implant_dose_cm2` DECIMAL(18,2) COMMENT 'Ion implantation dose in ions per square centimeter controlling dopant concentration. Null for non-implant recipes.',
    `implant_energy_kev` DECIMAL(18,2) COMMENT 'Ion implantation energy in kilo-electron volts (keV) controlling implant depth. Null for non-implant recipes.',
    `implant_species` STRING COMMENT 'Dopant species for ion implantation processes (e.g., Boron, Phosphorus, Arsenic, BF2, Germanium). Null for non-implant recipes.',
    `implant_tilt_angle_deg` DECIMAL(18,2) COMMENT 'Wafer tilt angle in degrees during ion implantation to control channeling effects. Null for non-implant recipes.',
    `implant_twist_angle_deg` DECIMAL(18,2) COMMENT 'Wafer twist (rotation) angle in degrees during ion implantation to control channeling effects. Null for non-implant recipes.',
    `litho_exposure_dose_mj_cm2` DECIMAL(18,2) COMMENT 'Exposure energy dose in mJ/cm² for photoresist exposure. Null for non-lithography recipes.',
    `litho_focus_offset_nm` DECIMAL(18,2) COMMENT 'Focus offset in nanometers from best focus position for process window optimization. Null for non-lithography recipes.',
    `litho_illumination_mode` STRING COMMENT 'Illumination source configuration (e.g., conventional, annular, dipole, quadrupole, freeform). Null for non-lithography recipes.',
    `litho_numerical_aperture` DECIMAL(18,2) COMMENT 'Numerical aperture of the lithography lens system controlling resolution. Null for non-lithography recipes.',
    `litho_scanner_model` STRING COMMENT 'Photolithography scanner tool model (e.g., ASML NXT:2000i, Nikon NSR-S630D). Null for non-lithography recipes.',
    `litho_wavelength_nm` DECIMAL(18,2) COMMENT 'Exposure wavelength in nanometers (e.g., 193 for ArF DUV, 13.5 for EUV). Null for non-lithography recipes.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was last modified or updated.',
    `recipe_name` STRING COMMENT 'Human-readable name of the process recipe used for identification and reference in manufacturing execution systems.',
    `process_type` STRING COMMENT 'Primary process category that this recipe executes: implant (ion implantation), deposition (CVD/PVD/ALD/EPI), etch (dry/wet), CMP (chemical mechanical planarization), lithography (photolithography), anneal (thermal treatment), clean (wafer cleaning), or metrology (measurement). [ENUM-REF-CANDIDATE: implant|deposition|etch|cmp|lithography|anneal|clean|metrology — 8 candidates stripped; promote to reference product]',
    `tool_class` STRING COMMENT 'Equipment tool class or model family for which this recipe is designed (e.g., Applied Materials Centura, LAM 2300, ASML NXT).',
    `version` STRING COMMENT 'Version identifier of the recipe indicating revision level. Follows semantic versioning or sequential numbering per fab standards.',
    CONSTRAINT pk_recipe PRIMARY KEY(`recipe_id`)
) COMMENT 'Detailed equipment-level process recipe defining all controllable parameters for a specific unit process step on a specific tool class. Captures recipe name, version, tool class, chamber configuration, and all process parameter setpoints organized by process type: implant conditions (species, energy, dose, tilt, twist, beam current, anneal recipe), deposition conditions (method such as LPCVD/PECVD/ALD/PVD/EPI, target material, thickness, temperature, pressure, precursor flows, RF power, deposition rate, uniformity spec), etch conditions (type, chemistry, gas flows, pressure, RF source/bias power, etch rate, selectivity, CD bias, endpoint detection), CMP conditions (slurry, pad, platen pressure, carrier speed, table speed, endpoint detection, removal target, post-CMP clean, uniformity spec), and lithography conditions (scanner, wavelength, NA, sigma, illumination mode, resist type/thickness, exposure dose, focus offset, develop process, bake temperatures, OPC rule set reference). Includes recipe approval status, effective date range, qualification linkage, and full revision history. Sourced from Applied Materials SmartFactory MES and Camstar MES recipe management modules. SSOT for ALL equipment-level process parameters and conditions; no separate condition products exist — all process-type-specific parameters are attributes within this unified recipe entity.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` (
    `lot_process_run_id` BIGINT COMMENT 'Unique identifier for the lot process run record. Primary key for this transactional event capturing a wafer lot executing a specific process step on specific equipment.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Needed for Order Traceability: lot process runs are executed for a specific customer account, enabling billing, compliance, and yield reporting per customer.',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to equipment.calibration_record. Business justification: SEMI E10/ISO 9001 traceability requires knowing which calibration was active when a lot was processed. If a calibration is later found out-of-tolerance, all lots processed under that calibration must ',
    `fab_tool_id` BIGINT COMMENT 'Reference to the specific fabrication equipment tool that processed this lot. Critical for equipment performance analysis, utilization tracking, and SPC (Statistical Process Control) correlation.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: A wafer lot is fabricated for a specific IC design (ic_catalog) — the die design determines the process flow, reticle set, and yield targets. Fab execution systems track lot-to-IC-design assignment fo',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: After a lot_process_run completes, an inspection_lot is created to inspect the wafers. This run-to-inspection traceability is fundamental to fab quality workflow — required for AQL sampling reports an',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: WIP inventory reconciliation: MES process execution records must link to inventory lot records for real-time WIP tracking, lot disposition, and yield accounting. Semiconductor fabs require this link t',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: When a lot_process_run produces out-of-spec results (SPC violation, defect excursion), an NCR is raised against that run. This traceability is required for IATF 16949 corrective action workflows and f',
    `recipe_id` BIGINT COMMENT 'Reference to the actual recipe executed for this process step. May differ from the planned recipe if engineering overrides or recipe revisions occurred. Links to the recipe master in the fabrication domain.',
    `step_id` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — Every lot process run is an execution of a specific process step. This FK is essential for WIP tracking and SPC data collection context.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module within the equipment tool where the lot was processed. Critical for multi-chamber tools to isolate chamber-specific process variation and matching.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Semiconductor lot traceability requires recording which tool qualification was active when a lot was processed. If a tool qualification is later found invalid, all affected lots must be identified for',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the lot processing completed on the equipment. Used to calculate actual process duration and equipment throughput.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the lot processing began on the equipment. Captured from MES equipment interface for cycle time analysis and equipment utilization tracking.',
    `control_chart_rule_violated` STRING COMMENT 'Specific SPC rule violated if control_chart_violation_flag is true (e.g., Western Electric Rule 1: Point beyond 3-sigma, Nelson Rule 2: Nine points in a row on same side of centerline). Null if no violation.',
    `control_chart_violation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this process run violated SPC control chart rules (e.g., out-of-control limits, run rules, trend rules). True indicates a violation requiring engineering investigation.',
    `defect_count` STRING COMMENT 'Total number of defects detected on the lot at this process step by in-line inspection tools. Used for defect density calculation and yield prediction.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Calculated defect density in defects per square centimeter for this lot at this process step. Key yield predictor and process health indicator.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the reason for lot hold if lot_disposition is hold. Examples include out-of-spec measurement, equipment alarm, material shortage, engineering investigation. Null if lot not on hold.',
    `lot_disposition` STRING COMMENT 'Outcome disposition of the lot after completing this process step. Pass indicates the lot met all specifications and proceeds to the next step; hold indicates engineering review required; scrap indicates lot rejected; rework indicates lot requires reprocessing; conditional_pass indicates lot passed with waiver or deviation.. Valid values are `pass|hold|scrap|rework|conditional_pass`',
    `measurement_result_value` DECIMAL(18,2) COMMENT 'Primary in-line measurement result collected at this process step (e.g., film thickness, CD (Critical Dimension), overlay, resistivity). The specific measurement type is defined by the process step. Used for real-time SPC and process control.',
    `measurement_site_count` STRING COMMENT 'Number of measurement sites sampled on the wafer(s) for this in-line measurement. Used to assess measurement sampling adequacy and statistical confidence.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the in-line measurement result. Common units include nm (nanometers) for thickness and CD, angstrom for thin films, um (micrometers) for overlay, ohm_per_square for sheet resistance, percent for uniformity, ppm (parts per million) for defect density, degree for angular measurements. [ENUM-REF-CANDIDATE: nm|angstrom|um|ohm_per_square|percent|ppm|degree — 7 candidates stripped; promote to reference product]',
    `process_duration_seconds` STRING COMMENT 'Actual elapsed time in seconds for this process run, calculated from start to end timestamp. Used for cycle time analysis, equipment performance monitoring, and throughput optimization.',
    `process_gas_flow_sccm` DECIMAL(18,2) COMMENT 'Total process gas flow rate in standard cubic centimeters per minute (SCCM) for this run. Aggregated flow for multi-gas processes; individual gas flows tracked in separate metrology records.',
    `process_notes` STRING COMMENT 'Free-text notes entered by the operator or process engineer documenting any anomalies, deviations, or special conditions during this process run. Used for root cause analysis and process improvement.',
    `process_power_watts` DECIMAL(18,2) COMMENT 'Actual RF or DC power in watts applied during this process run. Key parameter for plasma-based processes including etch, PVD, and PECVD (Plasma-Enhanced Chemical Vapor Deposition).',
    `process_pressure_torr` DECIMAL(18,2) COMMENT 'Actual process chamber pressure in Torr recorded during this run. Critical parameter for vacuum processes including PVD (Physical Vapor Deposition), CVD, etch, and implant.',
    `process_qualification_status` STRING COMMENT 'Qualification status of the process step execution. Qualified indicates the process met all capability and stability requirements; not_qualified indicates process failed qualification criteria; pending_qualification indicates qualification in progress; requalification_required indicates process drift detected requiring re-qualification.. Valid values are `qualified|not_qualified|pending_qualification|requalification_required`',
    `process_temperature_c` DECIMAL(18,2) COMMENT 'Actual process temperature in degrees Celsius recorded during this run. Key process parameter for thermal processes such as CVD (Chemical Vapor Deposition), diffusion, annealing, and oxidation.',
    `recipe_version` STRING COMMENT 'Version identifier of the recipe executed. Critical for process change control and correlation of recipe revisions to yield and quality outcomes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process run record was first created in the source MES system. Used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this process run record was last updated in the source MES system. Tracks modifications to disposition, measurements, or other attributes after initial creation.',
    `rework_count` STRING COMMENT 'Number of times this lot has been reworked at this process step. Tracks process stability and identifies chronic problem areas. Zero indicates first-pass processing.',
    `run_number` STRING COMMENT 'Business identifier for this process run event. Typically a sequential or timestamp-based identifier assigned by the MES (Manufacturing Execution System) for traceability and audit purposes.',
    `scrap_reason_code` STRING COMMENT 'Standardized code indicating the reason for lot scrap if lot_disposition is scrap. Examples include catastrophic defect, process excursion, contamination, equipment failure. Null if lot not scrapped.',
    `wafer_count` STRING COMMENT 'Number of wafers in the lot that were processed in this run. May differ from the original lot size if wafers were scrapped or held at prior steps.',
    `waste_heat_recovered_kwh` DECIMAL(18,2) COMMENT 'The waste heat recovered kwh of the lot process run record in the process domain.',
    CONSTRAINT pk_lot_process_run PRIMARY KEY(`lot_process_run_id`)
) COMMENT 'Transactional record of a wafer lot executing a specific process step on a specific piece of equipment. Captures lot ID reference, process step reference, equipment ID, operator ID, actual start and end timestamps, actual recipe used, chamber ID, lot disposition (pass/hold/scrap), and any in-line measurement results collected at that step. This is the core WIP tracking event for process engineering analysis. SSOT boundary: process domain owns the process-step-level execution record for engineering analysis; fabrication domain owns the lot lifecycle (lot creation, split, merge, hold, scrap, ship) and overall WIP status. Sourced from Camstar MES and Applied SmartFactory MES lot history.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` (
    `spc_control_chart_id` BIGINT COMMENT 'Primary key for spc_control_chart',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the metrology tool or equipment used to take the measurement (e.g., KLA ICOS tool ID, inline metrology tool ID). Enables tool-to-tool variation analysis.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: SPC control charts in semiconductor fabs are product-specific — control limits for CD uniformity differ by IC design. Process engineers set up charts per IC catalog entry to monitor parameters critica',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: SPC control chart limits are derived from quality_spec specification limits. Quality engineers audit chart-to-spec alignment during periodic reviews and ISO 9001 audits — this link is required for tha',
    `step_id` BIGINT COMMENT 'FK to process.process_step.process_step_id — Every SPC control chart monitors a parameter at a specific process step. This FK is essential for SPC chart setup and process monitoring workflows.',
    `technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this SPC chart is defined. Links to the technology node master data.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: SPC charts in semiconductor fabs are frequently chamber-specific because chamber-to-chamber variation is a critical monitored parameter. Chamber-level SPC enables detection of chamber-specific process',
    `baseline_data_points` STRING COMMENT 'Number of data points collected during the baseline period to establish initial control limits. Typically 25-30 subgroups are required for reliable limit calculation.',
    `chart_activation_date` DATE COMMENT 'Date when the SPC chart was first activated for production monitoring. Marks the beginning of the charts operational lifecycle.',
    `chart_name` STRING COMMENT 'Business-friendly name of the SPC control chart for identification and reporting purposes.',
    `chart_owner` STRING COMMENT 'Name or identifier of the process engineer or team responsible for monitoring and maintaining this SPC chart.',
    `chart_retirement_date` DATE COMMENT 'Date when the SPC chart was retired from active monitoring. Nullable for active charts. Retired charts are preserved for historical analysis.',
    `chart_status` STRING COMMENT 'Current lifecycle status of the SPC chart. Active charts are in production monitoring; suspended charts are temporarily paused; retired charts are no longer used; under review charts are being evaluated for limit adjustments; baseline collection charts are gathering initial data to establish control limits.. Valid values are `active|suspended|retired|under_review|baseline_collection`',
    `chart_type` STRING COMMENT 'Type of SPC control chart used for monitoring. Xbar-R (average and range), Xbar-S (average and standard deviation), EWMA (exponentially weighted moving average), CUSUM (cumulative sum), IMR (individual and moving range), P-chart (proportion defective), NP-chart (number defective), C-chart (count of defects), U-chart (defects per unit). [ENUM-REF-CANDIDATE: xbar_r|xbar_s|ewma|cusum|imr|p_chart|np_chart|c_chart|u_chart — 9 candidates stripped; promote to reference product]',
    `control_limit_calculation_method` STRING COMMENT 'Method used to calculate the control limits for this SPC chart. Three sigma uses standard deviation-based limits; six sigma uses tighter limits; Cpk-based derives limits from process capability index; historical baseline uses past performance data; engineering specification uses design requirements.. Valid values are `three_sigma|six_sigma|cpk_based|historical_baseline|engineering_specification`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SPC control chart record was first created in the system. Audit trail for record creation.',
    `data_source_system` STRING COMMENT 'Name of the source system that provided the measurement data (e.g., KLA ICOS, Camstar MES, inline metrology tool). Enables data lineage tracking.',
    `last_limit_revision_date` DATE COMMENT 'Date when the control limits were last revised or recalculated. Control limits should be periodically reviewed and updated as process capability improves.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SPC control chart record was last modified. Audit trail for record changes.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower control limit (LCL) for the SPC chart. Typically set at -3 sigma from the target value. Measurements below this limit indicate an out-of-control process.',
    `lower_warning_limit` DECIMAL(18,2) COMMENT 'Lower warning limit (LWL) for the SPC chart. Typically set at -2 sigma from the target value. Measurements below this limit trigger a warning but do not necessarily indicate an out-of-control process.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual measured value of the monitored parameter at the time of measurement. This is the primary data point plotted on the SPC chart.',
    `measurement_sequence_number` STRING COMMENT 'Sequential number of this measurement within the SPC chart history. Used for time-series analysis and trend detection.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was taken by the metrology tool. Represents the actual measurement event time.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `monitored_parameter_name` STRING COMMENT 'Name of the process parameter being monitored by this SPC chart (e.g., critical dimension, film thickness, overlay, etch rate, resistivity).',
    `ocap_reference_number` STRING COMMENT 'Reference number of the Out-of-Control Action Plan (OCAP) triggered by this measurement, if applicable. Links to the OCAP tracking system for root cause analysis and corrective action.',
    `parameter_unit_of_measure` STRING COMMENT 'Unit of measure for the monitored parameter (e.g., nm, angstrom, ohm-cm, percent, degrees Celsius).',
    `process_action_taken` STRING COMMENT 'Action taken in response to the measurement and any rule violations. None indicates no action required; warning issued indicates notification sent; OCAP triggered indicates Out-of-Control Action Plan initiated; lot hold indicates lot placed on hold; equipment hold indicates equipment taken offline; process adjustment indicates recipe or parameter adjustment made; engineering review indicates escalation to process engineering. [ENUM-REF-CANDIDATE: none|warning_issued|ocap_triggered|lot_hold|equipment_hold|process_adjustment|engineering_review — 7 candidates stripped; promote to reference product]',
    `process_capability_index_cp` DECIMAL(18,2) COMMENT 'Process capability index Cp, calculated as (USL - LSL) / (6 * sigma). Measures the potential capability of the process to meet specifications, assuming the process is centered. Values > 1.33 are typically considered acceptable.',
    `process_capability_index_cpk` DECIMAL(18,2) COMMENT 'Process capability index Cpk, calculated as min[(USL - mean) / (3 * sigma), (mean - LSL) / (3 * sigma)]. Measures the actual capability of the process to meet specifications, accounting for process centering. Values > 1.33 are typically considered acceptable.',
    `rule_violations_triggered` STRING COMMENT 'Comma-separated list of SPC rule violations detected for this measurement (e.g., Western Electric rules 1-4, Nelson rules 1-8). Examples: Rule 1 (one point beyond 3 sigma), Rule 2 (nine points in a row on same side of center line), Rule 3 (six points in a row steadily increasing or decreasing).',
    `sample_size` STRING COMMENT 'Number of measurements or observations taken per sampling event for this SPC chart (e.g., 5 wafers per lot, 9 sites per wafer).',
    `sampling_frequency` STRING COMMENT 'Frequency at which measurements are taken for this SPC chart (e.g., every lot, every 5 lots, every 8 hours, per wafer).',
    `site_x_coordinate` DECIMAL(18,2) COMMENT 'X-axis coordinate of the measurement site on the wafer surface. Used for spatial analysis and mapping of process uniformity.',
    `site_y_coordinate` DECIMAL(18,2) COMMENT 'Y-axis coordinate of the measurement site on the wafer surface. Used for spatial analysis and mapping of process uniformity.',
    `specification_lower_limit` DECIMAL(18,2) COMMENT 'Lower specification limit (LSL) defined by the process design or customer requirements. Represents the minimum acceptable value for the parameter. Used in capability index calculations.',
    `specification_upper_limit` DECIMAL(18,2) COMMENT 'Upper specification limit (USL) defined by the process design or customer requirements. Represents the maximum acceptable value for the parameter. Used in capability index calculations.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or nominal value for the monitored parameter. Represents the ideal process center line.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper control limit (UCL) for the SPC chart. Typically set at +3 sigma from the target value. Measurements exceeding this limit indicate an out-of-control process.',
    `upper_warning_limit` DECIMAL(18,2) COMMENT 'Upper warning limit (UWL) for the SPC chart. Typically set at +2 sigma from the target value. Measurements exceeding this limit trigger a warning but do not necessarily indicate an out-of-control process.',
    CONSTRAINT pk_spc_control_chart PRIMARY KEY(`spc_control_chart_id`)
) COMMENT 'Statistical Process Control (SPC) control chart definition and complete measurement history for a monitored process parameter at a specific process step. Chart definition captures chart type (Xbar-R, Xbar-S, EWMA, CUSUM, IMR), monitored parameter name, control limits (UCL, LCL, UWL, LWL), target value, sample size, sampling frequency, chart owner, and current chart status. Measurement detail (header+line pattern) captures all individual data points: measured value, measurement timestamp, lot reference, wafer number, site coordinates, measurement tool ID, chart rule violations triggered (Western Electric rules, Nelson rules), and resulting process action (none, warning, OCAP triggered). Implements SEMI E10 and JEDEC SPC guidelines. Sourced from KLA ICOS and in-line metrology tools. SSOT for all SPC monitoring definitions and measurement data in the process domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` (
    `spc_measurement_id` BIGINT COMMENT 'Unique identifier for the SPC measurement data point. Primary key for the SPC measurement record.',
    `equipment_process_recipe_id` BIGINT COMMENT 'Foreign key linking to equipment.equipment_process_recipe. Business justification: SPC excursion investigations require correlating out-of-control measurements with the specific equipment recipe version active at measurement time. Equipment engineers use this link to determine if re',
    `fab_tool_id` BIGINT COMMENT 'Reference to the metrology or inspection equipment that captured this measurement. Links to the KLA ICOS or in-line metrology tool used for data collection.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot being measured. Links to the fabrication lot that was sampled for this SPC measurement.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: An SPC measurement data point is collected during a specific lot process run. Linking spc_measurement to lot_process_run provides direct traceability from the SPC data point to the exact run that gene',
    `recipe_id` BIGINT COMMENT 'The identifier of the process recipe that was active when this measurement was taken. Links the measurement to the specific process parameters and settings used during fabrication.',
    `spc_control_chart_id` BIGINT COMMENT 'Reference to the SPC control chart against which this measurement is plotted. Links to the control chart configuration defining control limits, chart type, and monitoring rules.',
    `technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for which this measurement was taken. Links to the semiconductor technology node (e.g., 7nm, 5nm, 3nm) being manufactured.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Individual SPC measurements must be traceable to the specific chamber used, not just the tool, because chamber-to-chamber variation is a primary source of process excursions. Chamber-level SPC measure',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer within the lot that was measured. Identifies the individual wafer substrate on which the measurement was taken.',
    `comments` STRING COMMENT 'Free-text field for operator or engineer comments regarding this measurement. Used to capture contextual information, anomalies, or special conditions observed during measurement.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'The lower control limit of the SPC chart at the time of measurement. Represents the lower boundary of acceptable process variation (typically mean - 3 sigma).',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'The upper control limit of the SPC chart at the time of measurement. Represents the upper boundary of acceptable process variation (typically mean + 3 sigma).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SPC measurement record was first created in the system. Represents the audit trail of when the data was captured into the lakehouse.',
    `deviation_from_target` DECIMAL(18,2) COMMENT 'The calculated difference between the measured value and the target value. Positive values indicate measurements above target; negative values indicate measurements below target.',
    `measured_value` DECIMAL(18,2) COMMENT 'The numeric value of the process parameter measured at this data point. Represents the actual measurement result (e.g., film thickness, critical dimension, overlay, resistivity) captured by the metrology tool.',
    `measurement_on_chart` BIGINT COMMENT 'FK to process.process_spc_control_chart.process_spc_control_chart_id — Every SPC measurement data point belongs to a specific control chart. This is the fundamental transaction-to-master relationship for SPC.',
    `measurement_status` STRING COMMENT 'The quality status of the measurement data point. Indicates whether the measurement is valid for SPC analysis or requires review, retest, or exclusion due to equipment errors or data quality issues.. Valid values are `valid|invalid|suspect|retest_required|equipment_error`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was captured by the metrology tool. Represents the real-world event time of the SPC data point collection.',
    `measurement_type` STRING COMMENT 'The category of measurement based on when and how it was taken. Distinguishes between inline production measurements, offline lab measurements, final inspection, process qualification runs, and dedicated monitor wafer measurements.. Valid values are `inline|offline|final_inspection|qualification|monitor_wafer`',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `out_of_control_flag` BOOLEAN COMMENT 'Boolean indicator of whether this measurement triggered an out-of-control condition. True if the measurement violated control limits or SPC rules requiring corrective action.',
    `out_of_spec_flag` BOOLEAN COMMENT 'Boolean indicator of whether this measurement exceeded specification limits. True if the measured value fell outside the upper or lower specification limits defined by engineering.',
    `parameter_code` STRING COMMENT 'The standardized code or abbreviation for the measured parameter. Used for system integration and cross-tool correlation (e.g., CD_GATE, THICK_OXIDE, OVL_X, RS_POLY).',
    `parameter_name` STRING COMMENT 'The name of the process parameter being measured. Examples include critical dimension (CD), film thickness, overlay, sheet resistance, particle count, or other process-specific metrics.',
    `process_action_taken` STRING COMMENT 'The immediate process action triggered by this measurement result. Indicates the response to out-of-control or out-of-spec conditions, ranging from no action to lot holds, equipment stops, or engineering escalation. [ENUM-REF-CANDIDATE: none|warning_issued|lot_hold|equipment_hold|rework_initiated|scrap_initiated|engineering_review|corrective_action_plan — 8 candidates stripped; promote to reference product]',
    `rule_violation_flags` STRING COMMENT 'Comma-separated list of SPC rule violations triggered by this measurement. Includes Western Electric rules (e.g., WE1, WE2, WE3, WE4) and Nelson rules (e.g., N1, N2, N3) that detected out-of-control conditions or trends.',
    `sigma_level` DECIMAL(18,2) COMMENT 'The number of standard deviations the measured value is from the process mean. Used to assess process capability and identify outliers.',
    `site_number` STRING COMMENT 'The sequential identifier of the measurement site within the wafer sampling plan. Corresponds to the predefined site map used for metrology sampling.',
    `site_x_coordinate` DECIMAL(18,2) COMMENT 'The X-axis coordinate of the measurement site on the wafer surface. Used for spatial mapping and within-wafer uniformity analysis.',
    `site_y_coordinate` DECIMAL(18,2) COMMENT 'The Y-axis coordinate of the measurement site on the wafer surface. Used for spatial mapping and within-wafer uniformity analysis.',
    `specification_limit_lower` DECIMAL(18,2) COMMENT 'The lower specification limit defined by the process design. Represents the minimum acceptable value for the parameter as defined by engineering requirements.',
    `specification_limit_upper` DECIMAL(18,2) COMMENT 'The upper specification limit defined by the process design. Represents the maximum acceptable value for the parameter as defined by engineering requirements.',
    `target_value` DECIMAL(18,2) COMMENT 'The nominal or target value for the measured parameter as defined by the process recipe. Represents the ideal center point for process control.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed. Common units include nanometers (nm) for critical dimensions, angstroms for film thickness, ohms per square for sheet resistance, and percent for uniformity metrics. [ENUM-REF-CANDIDATE: nm|um|mm|angstrom|ohm|ohm_per_sq|percent|degree|mV|mA — 10 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SPC measurement record was last modified. Used for tracking data corrections, status updates, or reanalysis events.',
    CONSTRAINT pk_spc_measurement PRIMARY KEY(`spc_measurement_id`)
) COMMENT 'Individual SPC data point recorded against a control chart for a specific lot or wafer at a process step. Captures the measured value, measurement timestamp, lot reference, wafer number, site coordinates, measurement tool ID, chart rule violations triggered (Western Electric rules, Nelson rules), and resulting process action (none, warning, out-of-control action plan triggered). Primary transactional feed for real-time SPC monitoring sourced from KLA ICOS and in-line metrology tools.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the process qualification program record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific qualification: certain process qualifications are performed for a particular customer, required for compliance reports and customer approval tracking.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to invoice.ar_invoice. Business justification: Qualification Service Invoice ties a process qualification activity to the invoice billing the customer for qualification services.',
    `ate_configuration_id` BIGINT COMMENT 'Foreign key linking to test.ate_configuration. Business justification: Process qualification includes electrical testing on a specific ATE configuration. The qualification package must document which ATE hardware configuration was used, as ATE changes can affect qualific',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to equipment.calibration_record. Business justification: Process qualification packages must document the calibration status of all tools used during qualification runs. Direct FK to calibration_record enables qualification packages to reference the specifi',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Foundry process qualifications require a designated customer contact (quality engineer or program manager) to provide approval sign-off. process_qualification.requires_customer_approval and customer_a',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Process qualifications are frequently initiated to support a specific customer design win (e.g., qualifying a new process node for a customers product). This FK enables design-win-to-qualification tr',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Qualification runs are executed on a specific fab tool; the FK records which tool was qualified, supporting qualification history and tool eligibility checks.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Process qualification sign-off is scoped to a product family in semiconductor fabs — e.g., this etch process is qualified for the 5nm automotive MCU family. Qualification reports and customer approv',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Process qualifications are often tied to a specific IC design — e.g., AEC-Q100 qualification for a specific automotive IC. Customer approval workflows and qualification certificates reference the spec',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: A process qualification program validates a specific recipe (or set of recipe parameters) for production readiness. The qualification is often recipe-version-specific — when a recipe is modified, a ne',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: A process qualification program can be scoped to a specific process step (e.g., qualifying a new etch or implant step independently). This 1:N relationship (one process_step can have many qualificatio',
    `technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this qualification applies.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Process qualifications in semiconductor fabs are chamber-specific — a process qualified on chamber A is not automatically qualified on chamber B. Chamber-level process qualification tracking is requir',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Process qualification and tool qualification are formally linked in semiconductor manufacturing — a process qualification package must reference the tool qualification that was active during qualifica',
    `acceptance_criteria_summary` STRING COMMENT 'High-level summary of the key acceptance criteria that must be met for qualification to pass (e.g., yield > 95%, Cpk > 1.33, defect density < 0.1/cm²).',
    `actual_completion_date` DATE COMMENT 'Actual date when the qualification program was completed. Populated when status transitions to passed, failed, waived, or cancelled.',
    `actual_cpk` DECIMAL(18,2) COMMENT 'Actual process capability index (Cpk) achieved during qualification testing. Populated upon completion of qualification runs.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Actual wafer yield percentage achieved during qualification testing. Populated upon completion of qualification runs.',
    `cooling_optimization_evaluated` BOOLEAN COMMENT 'The cooling optimization evaluated of the process qualification record in the process domain.',
    `corrective_action_plan` STRING COMMENT 'Description of corrective actions planned or taken to address issues identified during qualification. Applicable for failed qualifications or qualifications requiring follow-up.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_approval_status` STRING COMMENT 'Status of customer approval for this qualification: not_required (no customer approval needed), pending (awaiting customer review), approved (customer approved), rejected (customer rejected).. Valid values are `not_required|pending|approved|rejected`',
    `disposition` STRING COMMENT 'Final disposition or outcome of the qualification program. Detailed explanation of pass/fail decision, waiver justification, or cancellation reason.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where the qualification is being conducted. Format: 3 letters + 2 digits (e.g., FAB01, SJC02).. Valid values are `^[A-Z]{3}[0-9]{2}$`',
    `failure_mode_summary` STRING COMMENT 'Summary of failure modes observed during qualification testing, if applicable. Used for failed or waived qualifications to document issues encountered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lot_count` STRING COMMENT 'Total number of fabrication lots planned or executed for the qualification program.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `qualification_name` STRING COMMENT 'Descriptive name of the qualification program, identifying the process or change being qualified.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the qualification program. Free-text field for supplementary information.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer responsible for managing and executing the qualification program.',
    `owner_organization` STRING COMMENT 'Organizational unit or department responsible for the qualification program (e.g., Process Engineering, Integration, Module Development).',
    `plan_reference` STRING COMMENT 'Document reference or identifier for the formal qualification plan that defines acceptance criteria, test methodology, and success metrics. May reference PLM document number or file path.',
    `plm_system_source` STRING COMMENT 'Source PLM system from which this qualification record was extracted: oracle_agile (Oracle Agile PLM), siemens_teamcenter (Siemens Teamcenter PLM), other.. Valid values are `oracle_agile|siemens_teamcenter|other`',
    `plm_workflow_reference` STRING COMMENT 'Workflow or change order identifier in the source PLM system that tracks the qualification approval process.',
    `qualification_number` STRING COMMENT 'Business identifier for the qualification program, typically assigned by PLM system. Format: PQ-XXXXXX.. Valid values are `^PQ-[A-Z0-9]{6,12}$`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification program: planned (not yet started), in_progress (active qualification), on_hold (temporarily suspended), passed (met all acceptance criteria), failed (did not meet criteria), waived (approved without full completion), cancelled (terminated). [ENUM-REF-CANDIDATE: planned|in_progress|on_hold|passed|failed|waived|cancelled — 7 candidates stripped; promote to reference product]',
    `qualification_type` STRING COMMENT 'Category of qualification program: new_process (entirely new process flow), process_change (modification to existing process), tool_qualification (new equipment or chamber), node_readiness (technology node transition), recipe_qualification (new process recipe), material_qualification (new consumable or chemical).. Valid values are `new_process|process_change|tool_qualification|node_readiness|recipe_qualification|material_qualification`',
    `requires_customer_approval` BOOLEAN COMMENT 'Flag indicating whether this qualification requires formal customer approval before production deployment. True for customer-specific processes or foundry qualifications.',
    `risk_assessment` STRING COMMENT 'Risk level associated with deploying the qualified process to production: low (minimal risk), medium (moderate risk with mitigation), high (significant risk requiring close monitoring), critical (severe risk requiring executive approval).. Valid values are `low|medium|high|critical`',
    `sign_off_date` DATE COMMENT 'Date when the qualification results were formally signed off and approved.',
    `sign_off_engineer_name` STRING COMMENT 'Name of the process engineer or technical authority who signed off on the qualification results.',
    `start_date` DATE COMMENT 'Date when the qualification program officially started or is planned to start.',
    `target_completion_date` DATE COMMENT 'Planned or target date for completion of the qualification program.',
    `target_cpk` DECIMAL(18,2) COMMENT 'Target process capability index (Cpk) that must be achieved for qualification to pass. Typical semiconductor requirement is Cpk >= 1.33.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target wafer yield percentage that must be achieved for qualification to pass.',
    `wafer_count` STRING COMMENT 'Total number of wafers planned or executed for the qualification program.',
    CONSTRAINT pk_qualification PRIMARY KEY(`qualification_id`)
) COMMENT 'Process qualification program record tracking the formal qualification of a new process flow, process step, or process change against defined acceptance criteria. Captures qualification type (new process, process change, tool qualification, node readiness), qualification plan reference, start date, target completion date, actual completion date, qualification status (in-progress, passed, failed, waived), sign-off engineer, and disposition. Sourced from Oracle Agile PLM and Siemens Teamcenter PLM qualification workflows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` (
    `yield_loss_event_id` BIGINT COMMENT 'Unique identifier for the yield loss event record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom the affected wafer lot is being fabricated. Used for customer-specific yield reporting and quality metrics.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to invoice.ar_invoice. Business justification: Yield Loss Charge Invoice records the invoice that compensates the customer for a specific yield loss event.',
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Yield loss events are categorized by the failing test bin. Bin-based yield loss Pareto analysis and failure mode classification require linking yield loss events to the specific bin definition that ch',
    `capa_record_id` BIGINT COMMENT 'Reference to the corrective action or OCAP (Out of Control Action Plan) initiated in response to this yield loss event. Links to corrective action tracking system.',
    `dispute_id` BIGINT COMMENT 'Foreign key linking to invoice.dispute. Business justification: Yield loss events are the primary root cause of customer invoice disputes in semiconductor foundry operations. Linking yield_loss_event directly to dispute enables dispute resolution teams to referenc',
    `fab_tool_id` BIGINT COMMENT 'Reference to the fabrication equipment or tool associated with the process step where the yield loss occurred. Used for equipment-specific yield trending and FMEA.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Yield loss events triggered by final test failures require direct traceability to the final test run for investigation. Yield loss reporting and customer quality notifications depend on linking the ev',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Yield loss events during wafer fabrication are tied to the IC design (die layout, design rules) — yield engineers analyze which IC designs have highest yield loss? The existing sku_id FK covers pack',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Yield loss events must be traced to the originating design project to determine if root cause is design-related (DFM violations, layout hotspots, IP core issues). Design engineers use yield loss data ',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Lot disposition and inventory impact: yield loss events must link directly to inventory_wafer_lot to trigger lot holds, update inventory valuation, and support disposition decisions. Fab quality engin',
    `lot_hold_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_lot_hold. Business justification: yield_loss_event has lot_hold_applied (boolean flag) but no FK to the actual hold record. Yield engineers and fab managers need to navigate from a yield loss event directly to the resulting fabricatio',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: A yield loss event is triggered by a specific lot process run execution. Linking yield_loss_event to lot_process_run enables direct traceability from the yield loss back to the exact run (equipment, r',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Yield loss events are frequently caused by maintenance activities (post-PM contamination, chamber seasoning failures, incorrect part installation). Direct FK enables yield-maintenance correlation anal',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Significant yield loss events trigger formal NCR documentation in semiconductor fabs. This link enables traceability from yield excursions to corrective actions and is required for yield management re',
    `recipe_id` BIGINT COMMENT 'Reference to the process recipe or run card that was active when the yield loss event occurred. Used for recipe-specific yield correlation and optimization.',
    `sku_id` BIGINT COMMENT 'Reference to the IC design product or device family being fabricated on the affected wafer lot. Used for product-specific yield analysis and customer impact assessment.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: A yield loss event is detected at a specific process step (e.g., etch step causing CD deviation, implant step causing dose non-uniformity). This is a fundamental operational relationship — root cause ',
    `technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for the affected wafer lot. Used for node-specific yield trending and benchmarking.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Yield loss events must be traceable to the specific chamber, not just the tool, because chamber-specific contamination or process drift is a primary yield loss mechanism. Chamber-level yield loss trac',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Yield loss events are frequently triggered by wafer probe yield failures. Root cause analysis and CAPA workflows require linking the yield loss event to the specific probe run that detected the yield ',
    `affected_die_count` STRING COMMENT 'Number of individual die on the wafer affected by this yield loss event. Used to calculate yield impact and prioritize corrective actions.',
    `assigned_to` STRING COMMENT 'Name or identifier of the engineer or team assigned to investigate and resolve the yield loss event. Used for workload management and escalation.',
    `cpk_value` DECIMAL(18,2) COMMENT 'Process capability index (Cpk) calculated at the time of the yield loss event. Indicates how well the process is centered and controlled relative to specification limits. Values below 1.33 typically indicate process capability issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this yield loss event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Measured defect density for this yield loss event, expressed as defects per square centimeter of wafer area. Used for SPC trending and yield modeling.',
    `defect_size_nm` DECIMAL(18,2) COMMENT 'Measured or estimated size of the defect in nanometers. Critical for determining defect criticality and kill ratio at advanced technology nodes.',
    `defect_type` STRING COMMENT 'Specific defect type or signature identified during inspection or test. Examples include scratch, particle, void, short, open, bridging, residue, etc. May reference defect classification taxonomy.',
    `detection_method` STRING COMMENT 'Method or technique used to detect the yield loss event. Indicates whether detected via inline inspection, offline inspection, electrical test, parametric test, visual inspection, or metrology measurement.. Valid values are `inline_inspection|offline_inspection|electrical_test|parametric_test|visual_inspection|metrology`',
    `disposition_action` STRING COMMENT 'Disposition decision for the affected wafer lot following yield loss event investigation. Continue indicates lot proceeds to next step; rework indicates reprocessing required; scrap indicates lot rejected; quarantine indicates lot held pending further analysis; use as is indicates lot accepted with deviation; return to vendor indicates supplier material issue.. Valid values are `continue|rework|scrap|quarantine|use_as_is|return_to_vendor`',
    `estimated_yield_impact_percent` DECIMAL(18,2) COMMENT 'Estimated percentage point impact on wafer yield attributable to this event. Calculated from affected die count and total die per wafer. Used for yield loss Pareto analysis.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the yield loss event was detected or recorded. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where the yield loss event occurred. Used for multi-site yield benchmarking and site-specific trending.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Date and time when root cause investigation of the yield loss event was initiated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this yield loss event record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `layer_name` STRING COMMENT 'Name of the process layer or mask level at which the yield loss event occurred. Examples include M1, M2, POLY, CONTACT, VIA1, etc. Aligns with GDS layer naming convention.',
    `lot_hold_applied` BOOLEAN COMMENT 'Indicates whether a lot hold was placed on the affected wafer lot as a result of this yield loss event. True if hold applied; false if no hold applied.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or context related to the yield loss event. May include investigation findings, lessons learned, or special handling instructions.',
    `reported_by` STRING COMMENT 'Name or identifier of the engineer, operator, or automated system that reported or logged the yield loss event. Used for accountability and follow-up.',
    `resolution_status` STRING COMMENT 'Current status of the yield loss event resolution workflow. Open indicates newly detected; under investigation indicates active RCA; root cause identified indicates RCA complete; corrective action implemented indicates fix deployed; closed indicates event resolved; deferred indicates event accepted or postponed.. Valid values are `open|under_investigation|root_cause_identified|corrective_action_implemented|closed|deferred`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the yield loss event was resolved and closed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used to calculate mean time to resolution (MTTR) for yield events.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause of the yield loss event. Equipment indicates tool-related issues; material indicates incoming material defects; process indicates recipe or parameter issues; human indicates operator error; environmental indicates cleanroom or facility issues; design indicates layout or design rule issues.. Valid values are `equipment|material|process|human|environmental|design`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the identified or suspected root cause of the yield loss event. Populated during root cause analysis and investigation.',
    `severity_level` STRING COMMENT 'Business severity classification of the yield loss event based on yield impact, affected volume, and customer impact. Critical indicates immediate action required; major indicates significant yield impact; minor indicates localized impact; negligible indicates minimal business impact.. Valid values are `critical|major|minor|negligible`',
    `spc_rule_violation` STRING COMMENT 'Identification of the SPC control chart rule that was violated and triggered this yield loss event. Examples include Western Electric rules, Nelson rules, or custom SPC rules. Used to link yield events to process control violations.',
    `wafer_position_x_mm` DECIMAL(18,2) COMMENT 'X-coordinate position on the wafer where the yield loss event was detected, in millimeters from wafer center. Used for spatial yield analysis and wafer mapping.',
    `wafer_position_y_mm` DECIMAL(18,2) COMMENT 'Y-coordinate position on the wafer where the yield loss event was detected, in millimeters from wafer center. Used for spatial yield analysis and wafer mapping.',
    `yield_loss_mode` STRING COMMENT 'Classification of the yield loss mechanism. Parametric indicates out-of-spec electrical parameters; systematic indicates repeatable defect patterns; random indicates sporadic defects; electrical indicates functional failures; particle indicates contamination; pattern indicates lithography or etch issues; edge indicates wafer edge exclusion. [ENUM-REF-CANDIDATE: parametric|systematic|random|electrical|particle|pattern|edge — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_yield_loss_event PRIMARY KEY(`yield_loss_event_id`)
) COMMENT 'Transactional record of a yield loss event identified at a specific process step or inspection point for a wafer lot. Captures lot reference, process step, yield loss mode (parametric, systematic, random, electrical), defect density, affected die count, estimated yield impact, root cause category, corrective action reference, and resolution status. Primary input to yield optimization workflows and SPC out-of-control action plans (OCAPs).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` (
    `defect_inspection_result_id` BIGINT COMMENT 'Unique identifier for the defect inspection result record. Primary key.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the inspection equipment used (e.g., KLA 29xx/39xx series, Applied Materials SEMVision). Tool asset identifier from equipment master.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that was inspected. Links to the fabrication wafer lot being monitored.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Defect inspection results are analyzed per IC product for the Defect Analysis per Product report.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A defect_inspection_result is performed as part of a quality inspection_lot. This traceability is required for AQL sampling compliance, quality gate reporting, and linking process-domain inspection da',
    `recipe_id` BIGINT COMMENT 'Identifier of the inspection recipe or program used to configure the tool for this inspection run. Defines sensitivity, scan area, and detection parameters.',
    `lot_process_run_id` BIGINT COMMENT 'FK to process.lot_process_run.lot_process_run_id — Defect inspection results are captured during or after a specific lot process run at an inspection step. This FK enables defect-to-process correlation.',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: When defect_inspection_result shows an excursion (excursion_detected=true), an NCR is raised. Fab quality workflows require direct traceability from the inspection result that triggered the NCR for ro',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Defect inspection results are tied to a specific process step; adding internal FK enables step‑level analysis.',
    `technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for which this inspection was performed, e.g., 7nm, 5nm, 3nm.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Defect inspection results must be traceable to the specific process chamber that produced the wafer, not just the tool. Chamber-level defect tracking enables chamber matching analysis and identificati',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer within the lot that was inspected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this defect inspection result record was first created in the system.',
    `crystal_defect_count` STRING COMMENT 'Number of defects classified as crystal originated particles (COPs) or intrinsic silicon defects.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Calculated defect density expressed as defects per square centimeter of inspected wafer area. Key metric for process monitoring and Statistical Process Control (SPC).',
    `defect_map_file_format` STRING COMMENT 'Format of the defect map file: KLARF (KLA Results File), CSV, XML, or proprietary vendor format.. Valid values are `KLARF|CSV|XML|proprietary`',
    `defect_map_file_path` STRING COMMENT 'File system path or URI to the defect map file (typically KLARF or proprietary format) containing spatial coordinates and attributes of all detected defects.',
    `defect_size_bin_large_count` STRING COMMENT 'Number of defects in the large size bin (typically > 0.5 µm or tool-specific threshold).',
    `defect_size_bin_medium_count` STRING COMMENT 'Number of defects in the medium size bin (typically 0.1-0.5 µm or tool-specific threshold).',
    `defect_size_bin_small_count` STRING COMMENT 'Number of defects in the small size bin (typically < 0.1 µm or tool-specific threshold).',
    `disposition` STRING COMMENT 'Disposition decision based on inspection results: pass (within spec), fail (exceeds limits), review (requires engineering review), hold (lot placed on hold), or rework (requires reprocessing).. Valid values are `pass|fail|review|hold|rework`',
    `excursion_detected` BOOLEAN COMMENT 'Indicates whether a process excursion was detected based on defect density or count exceeding Statistical Process Control (SPC) limits.',
    `inspected_area_cm2` DECIMAL(18,2) COMMENT 'Total wafer surface area inspected, measured in square centimeters. Used to calculate defect density.',
    `inspection_at_step` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — Defect inspections occur at specific process steps in the flow. Step reference provides manufacturing context for defect analysis.',
    `inspection_mode` STRING COMMENT 'Inspection coverage mode: full wafer scan, die sampling, edge exclusion, or hot spot targeted inspection.. Valid values are `full_wafer|die_sampling|edge_exclusion|hot_spot`',
    `inspection_status` STRING COMMENT 'Current status of the inspection run: completed (inspection finished successfully), in_progress (inspection running), failed (tool error), or aborted (inspection cancelled).. Valid values are `completed|in_progress|failed|aborted`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the defect inspection was performed. Primary business event timestamp for this inspection result.',
    `inspection_type` STRING COMMENT 'Type of inspection technology used: brightfield scanner, darkfield scanner, e-beam inspection, optical inspection, or macro inspection.. Valid values are `brightfield|darkfield|e-beam|optical|macro`',
    `killer_defect_count` STRING COMMENT 'Number of defects classified as killer defects (defects large enough or critical enough to cause die failure).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this defect inspection result record was last modified or updated.',
    `layer_name` STRING COMMENT 'Name of the process layer being inspected (e.g., Metal1, Poly, Contact, Via2). Identifies the fabrication layer in the stack.',
    `notes` STRING COMMENT 'Free-text notes or comments about the inspection results, anomalies, or follow-up actions required.',
    `nuisance_defect_count` STRING COMMENT 'Number of defects classified as nuisance (false positives or non-yield-impacting detections filtered by nuisance filter).',
    `nuisance_filter_applied` BOOLEAN COMMENT 'Indicates whether a nuisance filter was applied to remove false positives or non-critical defects from the reported count.',
    `nuisance_filter_version` STRING COMMENT 'Version identifier of the nuisance filter algorithm or rule set applied during this inspection.',
    `particle_defect_count` STRING COMMENT 'Number of defects classified as particles (foreign material on wafer surface).',
    `pattern_defect_count` STRING COMMENT 'Number of defects classified as pattern defects (lithography or etch anomalies in the circuit pattern).',
    `residue_defect_count` STRING COMMENT 'Number of defects classified as residue (chemical or material residue remaining after processing).',
    `review_required` BOOLEAN COMMENT 'Indicates whether engineering review is required based on defect count, type, or pattern analysis.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the engineering review was completed.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the engineer who reviewed the inspection results, if review was performed.',
    `scratch_defect_count` STRING COMMENT 'Number of defects classified as scratches (linear surface damage).',
    `spc_control_limit_lower` DECIMAL(18,2) COMMENT 'Lower control limit for defect density used in SPC monitoring.',
    `spc_control_limit_upper` DECIMAL(18,2) COMMENT 'Upper control limit for defect density used in SPC monitoring. Excursions above this limit trigger alerts.',
    `total_defect_count` STRING COMMENT 'Total number of defects detected on the wafer during this inspection, including all defect types and sizes.',
    CONSTRAINT pk_defect_inspection_result PRIMARY KEY(`defect_inspection_result_id`)
) COMMENT 'Wafer-level defect inspection result record from in-line inspection tools (KLA brightfield/darkfield scanners, e-beam inspection) captured at process engineering inspection steps for process monitoring and excursion detection. Captures wafer lot reference, inspection step, tool ID, inspection recipe, total defect count, defect density (defects/cm²), defect map file reference, defect classification breakdown by type and size, nuisance filter applied, and disposition. SSOT boundary: process domain owns in-line defect inspection results used for process monitoring, SPC, and excursion detection during manufacturing; quality domain owns outgoing quality inspection, reliability defect analysis, and customer-reported defect records. Sourced from KLA 29xx/39xx series and Applied Materials SEMVision.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` (
    `metrology_measurement_id` BIGINT COMMENT 'Unique identifier for the metrology_measurement data product.',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to equipment.calibration_record. Business justification: Metrology measurement validity depends on the calibration status of the measurement tool. SEMI E89/ISO 17025 traceability requires linking metrology results to the active calibration record. If a cali',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the metrology equipment that performed the measurement (e.g., CD-SEM, ellipsometer, overlay tool).',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot on which this measurement was performed.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Metrology measurements are linked to the IC product they verify; used in Metrology Compliance reporting.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: In-line metrology measurements (CD, overlay, film thickness) are taken during or immediately after a specific lot process run. Linking process_metrology_measurement to lot_process_run enables direct t',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: When a metrology measurement is out-of-spec (disposition field indicates failure), an NCR is raised. Direct traceability from the measurement to the NCR is required for root cause analysis, CAPA initi',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Metrology measurements are compared against quality_spec limits for pass/fail disposition. This link enables automated spec-check reporting, quality gate decisions, and ISO 9001 measurement traceabili',
    `recipe_id` BIGINT COMMENT 'Identifier of the metrology recipe or measurement program used for this measurement.',
    `step_id` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — Metrology measurements are taken at specific process steps. Step context is essential for measurement interpretation and SPC feeding.',
    `technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this measurement was performed.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Metrology measurements (CD, thickness, overlay) must be traceable to the specific process chamber to enable chamber-to-chamber matching and uniformity analysis. Chamber-level metrology traceability is',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer within the lot that was measured.',
    `cp_value` DECIMAL(18,2) COMMENT 'Process capability index (Cp) calculated from this measurement, indicating the potential capability of the process without considering centering.',
    `cpk_value` DECIMAL(18,2) COMMENT 'Process capability index (Cpk) calculated from this measurement, indicating how well the process is centered and controlled within specification limits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this measurement record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Flag indicating the quality and reliability of the measurement data. Good indicates reliable data, Suspect indicates questionable data, Bad indicates invalid data, Uncalibrated indicates tool calibration issue.. Valid values are `Good|Suspect|Bad|Uncalibrated`',
    `disposition` STRING COMMENT 'Pass/fail disposition of the measurement against specification limits. Pass indicates within spec, Fail indicates out of spec, Marginal indicates near limits, Rework indicates corrective action required, Hold indicates pending review.. Valid values are `Pass|Fail|Marginal|Rework|Hold`',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where the measurement was performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this measurement record was last updated or modified.',
    `layer_name` STRING COMMENT 'Name of the process layer or mask level at which this measurement was taken (e.g., M1, POLY, CONTACT).',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower control limit for Statistical Process Control (SPC) monitoring. Values below this trigger investigation.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower specification limit for this measurement parameter. Values below this threshold fail specification.',
    `max_value` DECIMAL(18,2) COMMENT 'Maximum measured value across all sites on the wafer.',
    `mean_value` DECIMAL(18,2) COMMENT 'Arithmetic mean of all site measurements for this parameter.',
    `measurement_mode` STRING COMMENT 'Mode in which the measurement was performed. Inline indicates production flow measurement, Offline indicates lab measurement, Engineering indicates development measurement, Qualification indicates process qualification.. Valid values are `Inline|Offline|Engineering|Qualification`',
    `measurement_parameter` STRING COMMENT 'Specific physical parameter being measured (e.g., critical dimension, overlay X/Y, film thickness, resistivity, reflectivity).',
    `measurement_status` STRING COMMENT 'Status of the measurement execution. Completed indicates successful measurement, In Progress indicates measurement underway, Failed indicates measurement error, Aborted indicates user-terminated, Pending indicates queued.. Valid values are `Completed|In Progress|Failed|Aborted|Pending`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the metrology measurement was performed.',
    `measurement_type` STRING COMMENT 'Type of metrology measurement performed: CD-SEM (Critical Dimension Scanning Electron Microscopy), OCD (Optical Critical Dimension), XRF (X-Ray Fluorescence), Ellipsometry, Overlay, or Film Thickness.. Valid values are `CD-SEM|OCD|XRF|Ellipsometry|Overlay|Film Thickness`',
    `median_value` DECIMAL(18,2) COMMENT 'Median value of all site measurements for this parameter.',
    `min_value` DECIMAL(18,2) COMMENT 'Minimum measured value across all sites on the wafer.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free-text notes or comments about the measurement, including any anomalies, special conditions, or operator observations.',
    `range_value` DECIMAL(18,2) COMMENT 'Difference between maximum and minimum site measurements (max - min).',
    `site_count` STRING COMMENT 'Total number of measurement sites sampled on the wafer.',
    `spc_rule_violation` STRING COMMENT 'Description of any SPC rule violations detected (e.g., Western Electric rules, Nelson rules) such as trend, shift, or out-of-control conditions.',
    `std_deviation` DECIMAL(18,2) COMMENT 'Standard deviation (1-sigma) of the site measurements, indicating within-wafer uniformity.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or nominal value for this measurement parameter as defined by the process specification.',
    `three_sigma` DECIMAL(18,2) COMMENT 'Three times the standard deviation, representing the process variation range.',
    `uniformity_percent` DECIMAL(18,2) COMMENT 'Within-wafer uniformity expressed as a percentage, calculated as (range / mean) * 100 or (3-sigma / mean) * 100 depending on convention.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the measurement values (e.g., nm, angstrom, ohm-cm, percent).',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper control limit for Statistical Process Control (SPC) monitoring. Values above this trigger investigation.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper specification limit for this measurement parameter. Values above this threshold fail specification.',
    `wafer_slot_number` STRING COMMENT 'Position of the wafer within the lot carrier or cassette.',
    CONSTRAINT pk_metrology_measurement PRIMARY KEY(`metrology_measurement_id`)
) COMMENT 'In-line metrology measurement record capturing critical dimension (CD), overlay, film thickness, resistivity, or other physical parameter measurements taken on a wafer at a specific process step. Captures measurement type (CD-SEM, OCD, XRF, ellipsometry, overlay), tool ID, wafer lot reference, wafer number, measurement site map, per-site values, mean, 3-sigma, range, and pass/fail disposition against spec limits. Sourced from KLA ICOS and in-line metrology tools.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_step_id` FOREIGN KEY (`step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`step`(`step_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`process` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`process` SET TAGS ('dbx_domain' = 'process');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `baseline_cpk` SET TAGS ('dbx_business_glossary_term' = 'Baseline Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `beol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Back End of Line (BEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `cool_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `cooling_step_count` SET TAGS ('dbx_business_glossary_term' = 'Cooling Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `critical_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `dfm_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `euv_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Extreme Ultraviolet (EUV) Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `feol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Front End of Line (FEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `is_baseline_flow` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Flow');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `lithography_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Lithography Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `mol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Middle of Line (MOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `opc_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'development|qualification|qualified|production|deprecated|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Revision');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `supports_multi_patterning` SET TAGS ('dbx_business_glossary_term' = 'Supports Multi-Patterning');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `total_step_count` SET TAGS ('dbx_business_glossary_term' = 'Total Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow` ALTER COLUMN `waste_heat_recovery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovery Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `cooling_target_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Cooling Target Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `cycle_time_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Target (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `step_description` SET TAGS ('dbx_business_glossary_term' = 'Step Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `dose_target` SET TAGS ('dbx_business_glossary_term' = 'Dose Target');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `energy_target_kev` SET TAGS ('dbx_business_glossary_term' = 'Energy Target (keV)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `is_cooling_step` SET TAGS ('dbx_business_glossary_term' = 'Is Cooling Step');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `is_critical_step` SET TAGS ('dbx_business_glossary_term' = 'Critical Step Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `is_rework_allowed` SET TAGS ('dbx_business_glossary_term' = 'Rework Allowed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Step Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `power_setpoint_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Setpoint (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `pressure_setpoint_torr` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `process_category` SET TAGS ('dbx_business_glossary_term' = 'Process Category (FEOL/MOL/BEOL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `process_category` SET TAGS ('dbx_value_regex' = 'feol|mol|beol');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `process_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Time (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|failed|waived');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'active|inactive|development|qualification|deprecated|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `target_cd_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Critical Dimension (CD) Nanometers (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `target_layer` SET TAGS ('dbx_business_glossary_term' = 'Target Layer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `target_thickness_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Target Thickness (Angstrom)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `temperature_setpoint_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `tool_class` SET TAGS ('dbx_business_glossary_term' = 'Tool Class');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`step` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Default Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|qualified|deprecated|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `chamber_configuration` SET TAGS ('dbx_business_glossary_term' = 'Chamber Configuration');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `cmp_pad_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Pad Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `cmp_platen_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Platen Pressure (pounds per square inch)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `cmp_removal_target_nm` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Removal Target (nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `cmp_slurry_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Slurry Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `cmp_table_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Table Speed (revolutions per minute)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `coolant_type` SET TAGS ('dbx_business_glossary_term' = 'Coolant Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `cooling_rate_celsius_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Cooling Rate Celsius Per Minute');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recipe Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `deposition_method` SET TAGS ('dbx_business_glossary_term' = 'Deposition Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `deposition_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Deposition Pressure (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `deposition_rf_power_w` SET TAGS ('dbx_business_glossary_term' = 'Deposition Radio Frequency (RF) Power (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `deposition_target_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Deposition Target Thickness (nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `deposition_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Deposition Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recipe Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recipe Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `etch_chemistry` SET TAGS ('dbx_business_glossary_term' = 'Etch Chemistry');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `etch_pressure_mtorr` SET TAGS ('dbx_business_glossary_term' = 'Etch Pressure (milliTorr)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `etch_rf_bias_power_w` SET TAGS ('dbx_business_glossary_term' = 'Etch Radio Frequency (RF) Bias Power (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `etch_rf_source_power_w` SET TAGS ('dbx_business_glossary_term' = 'Etch Radio Frequency (RF) Source Power (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `etch_selectivity_ratio` SET TAGS ('dbx_business_glossary_term' = 'Etch Selectivity Ratio');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `etch_type` SET TAGS ('dbx_business_glossary_term' = 'Etch Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `etch_type` SET TAGS ('dbx_value_regex' = 'dry|wet|plasma|reactive_ion|deep_reactive_ion');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `implant_dose_cm2` SET TAGS ('dbx_business_glossary_term' = 'Implant Dose (ions per square centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `implant_energy_kev` SET TAGS ('dbx_business_glossary_term' = 'Implant Energy (keV)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `implant_species` SET TAGS ('dbx_business_glossary_term' = 'Implant Species');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `implant_tilt_angle_deg` SET TAGS ('dbx_business_glossary_term' = 'Implant Tilt Angle (degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `implant_twist_angle_deg` SET TAGS ('dbx_business_glossary_term' = 'Implant Twist Angle (degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `litho_exposure_dose_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'Lithography Exposure Dose (millijoules per square centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `litho_focus_offset_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Focus Offset (nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `litho_illumination_mode` SET TAGS ('dbx_business_glossary_term' = 'Lithography Illumination Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `litho_numerical_aperture` SET TAGS ('dbx_business_glossary_term' = 'Lithography Numerical Aperture (NA)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `litho_scanner_model` SET TAGS ('dbx_business_glossary_term' = 'Lithography Scanner Model');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `litho_wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Wavelength (nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recipe Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `process_type` SET TAGS ('dbx_business_glossary_term' = 'Process Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `tool_class` SET TAGS ('dbx_business_glossary_term' = 'Tool Class');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` SET TAGS ('dbx_subdomain' = 'manufacturing_execution');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Process Chamber ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Process End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Process Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `control_chart_rule_violated` SET TAGS ('dbx_business_glossary_term' = 'SPC (Statistical Process Control) Control Chart Rule Violated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `control_chart_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'SPC (Statistical Process Control) Control Chart Violation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Square Centimeter');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'pass|hold|scrap|rework|conditional_pass');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `measurement_result_value` SET TAGS ('dbx_business_glossary_term' = 'In-Line Measurement Result Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `measurement_site_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Duration in Seconds');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_gas_flow_sccm` SET TAGS ('dbx_business_glossary_term' = 'Process Gas Flow in Standard Cubic Centimeters per Minute (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_notes` SET TAGS ('dbx_business_glossary_term' = 'Process Run Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_power_watts` SET TAGS ('dbx_business_glossary_term' = 'Process Power in Watts');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure in Torr');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|not_qualified|pending_qualification|requalification_required');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature in Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `rework_count` SET TAGS ('dbx_business_glossary_term' = 'Rework Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Process Run Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `waste_heat_recovered_kwh` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovered Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `baseline_data_points` SET TAGS ('dbx_business_glossary_term' = 'Baseline Data Points');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `chart_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Chart Activation Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `chart_name` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Chart Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `chart_owner` SET TAGS ('dbx_business_glossary_term' = 'Chart Owner');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `chart_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Chart Retirement Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `chart_status` SET TAGS ('dbx_business_glossary_term' = 'Chart Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `chart_status` SET TAGS ('dbx_value_regex' = 'active|suspended|retired|under_review|baseline_collection');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Chart Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `control_limit_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Calculation Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `control_limit_calculation_method` SET TAGS ('dbx_value_regex' = 'three_sigma|six_sigma|cpk_based|historical_baseline|engineering_specification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `last_limit_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Limit Revision Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `lower_warning_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Warning Limit (LWL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `measurement_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `monitored_parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Monitored Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `ocap_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Control Action Plan (OCAP) Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `parameter_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Parameter Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `process_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Process Action Taken');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `process_capability_index_cp` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `process_capability_index_cpk` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `rule_violations_triggered` SET TAGS ('dbx_business_glossary_term' = 'Rule Violations Triggered');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Site X Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Site Y Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `specification_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `specification_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `upper_warning_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Warning Limit (UWL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `spc_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Measurement ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `equipment_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Control Chart ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `deviation_from_target` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Target');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `measurement_on_chart` SET TAGS ('dbx_business_glossary_term' = 'Measurement On Chart');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|suspect|retest_required|equipment_error');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'inline|offline|final_inspection|qualification|monitor_wafer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `out_of_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Control Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `out_of_spec_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `process_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Process Action Taken');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `rule_violation_flags` SET TAGS ('dbx_business_glossary_term' = 'Rule Violation Flags');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `sigma_level` SET TAGS ('dbx_business_glossary_term' = 'Sigma Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_number` SET TAGS ('dbx_business_glossary_term' = 'Site Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Site X Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Site Y Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `specification_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `specification_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` SET TAGS ('dbx_subdomain' = 'manufacturing_execution');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `acceptance_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Summary');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `actual_cpk` SET TAGS ('dbx_business_glossary_term' = 'Actual Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `cooling_optimization_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Cooling Optimization Evaluated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Qualification Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2}$');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `failure_mode_summary` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Summary');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `lot_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Reference');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `plm_system_source` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `plm_system_source` SET TAGS ('dbx_value_regex' = 'oracle_agile|siemens_teamcenter|other');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `plm_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Workflow ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^PQ-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_process|process_change|tool_qualification|node_readiness|recipe_qualification|material_qualification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `requires_customer_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Customer Approval');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `sign_off_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `target_cpk` SET TAGS ('dbx_business_glossary_term' = 'Target Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`qualification` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` SET TAGS ('dbx_subdomain' = 'manufacturing_execution');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `yield_loss_event_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Event ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Hold Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `affected_die_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk) Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Square Centimeter');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `defect_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Nanometers');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'inline_inspection|offline_inspection|electrical_test|parametric_test|visual_inspection|metrology');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'continue|rework|scrap|quarantine|use_as_is|return_to_vendor');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `estimated_yield_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Yield Impact Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `lot_hold_applied` SET TAGS ('dbx_business_glossary_term' = 'Lot Hold Applied');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|root_cause_identified|corrective_action_implemented|closed|deferred');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|material|process|human|environmental|design');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|negligible');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `spc_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `wafer_position_x_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Position X Millimeters');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `wafer_position_y_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Position Y Millimeters');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `yield_loss_mode` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Inspection Result Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Recipe Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `crystal_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Crystal Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Square Centimeter (cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_map_file_format` SET TAGS ('dbx_business_glossary_term' = 'Defect Map File Format');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_map_file_format` SET TAGS ('dbx_value_regex' = 'KLARF|CSV|XML|proprietary');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_map_file_path` SET TAGS ('dbx_business_glossary_term' = 'Defect Map File Path');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_size_bin_large_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Bin Large Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_size_bin_medium_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Bin Medium Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_size_bin_small_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Bin Small Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Inspection Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|review|hold|rework');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `excursion_detected` SET TAGS ('dbx_business_glossary_term' = 'Excursion Detected Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspected_area_cm2` SET TAGS ('dbx_business_glossary_term' = 'Inspected Area in Square Centimeters (cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_at_step` SET TAGS ('dbx_business_glossary_term' = 'Inspection At Step');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_mode` SET TAGS ('dbx_business_glossary_term' = 'Inspection Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_mode` SET TAGS ('dbx_value_regex' = 'full_wafer|die_sampling|edge_exclusion|hot_spot');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|aborted');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'brightfield|darkfield|e-beam|optical|macro');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `killer_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Killer Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `nuisance_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Nuisance Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `nuisance_filter_applied` SET TAGS ('dbx_business_glossary_term' = 'Nuisance Filter Applied Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `nuisance_filter_version` SET TAGS ('dbx_business_glossary_term' = 'Nuisance Filter Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `particle_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Particle Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `pattern_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Pattern Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `residue_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Residue Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `review_required` SET TAGS ('dbx_business_glossary_term' = 'Review Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `scratch_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Scratch Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `spc_control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Lower Control Limit');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `spc_control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Upper Control Limit');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `total_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Total Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `metrology_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for metrology_measurement');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology At Step');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `cp_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'Good|Suspect|Bad|Uncalibrated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Marginal|Rework|Hold');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `max_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `mean_value` SET TAGS ('dbx_business_glossary_term' = 'Mean Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'Inline|Offline|Engineering|Qualification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `measurement_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measurement Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'Completed|In Progress|Failed|Aborted|Pending');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'CD-SEM|OCD|XRF|Ellipsometry|Overlay|Film Thickness');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `median_value` SET TAGS ('dbx_business_glossary_term' = 'Median Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `min_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `range_value` SET TAGS ('dbx_business_glossary_term' = 'Range Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `site_count` SET TAGS ('dbx_business_glossary_term' = 'Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `spc_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `std_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `three_sigma` SET TAGS ('dbx_business_glossary_term' = 'Three Sigma (3σ)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `uniformity_percent` SET TAGS ('dbx_business_glossary_term' = 'Uniformity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_measurement` ALTER COLUMN `wafer_slot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Slot Number');
