-- Schema for Domain: process | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`process` COMMENT 'Process engineering data for all semiconductor manufacturing process flows including photolithography, etch, diffusion, implant, deposition, and metrology steps. Manages SPC control charts, process capability indices, OPC rule sets, MEEF parameters, process qualification, yield optimization, and technology node readiness.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`process_flow` (
    `process_flow_id` BIGINT COMMENT 'Unique identifier for the semiconductor manufacturing process flow definition. Primary key.',
    `cooling_condition_id` BIGINT COMMENT 'Default cooling condition for this flow.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation of a process flow to a cost center is required for internal cost‑of‑goods‑sold calculations and budgeting.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Governance report requires each process flow to be owned by a specific org unit for accountability and performance tracking.',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) that defines the design rules, device models, and technology files associated with this process flow.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: A process flow is defined for a particular technology node; linking directly within the process domain eliminates cross‑domain indirection.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Process flows generate revenue for specific product lines; profit‑center linkage supports profitability reporting per flow.',
    `baseline_cpk` DECIMAL(18,2) COMMENT 'Baseline process capability index (Cpk) representing the statistical process control capability of the flow at qualification.',
    `beol_step_count` STRING COMMENT 'Number of process steps in the Back End of Line (BEOL) phase, covering metal interconnect layers and passivation.',
    `cool_optimization_enabled` BOOLEAN COMMENT 'Whether cool optimization options are enabled for the flow.',
    `cooling_step_count` STRING COMMENT 'Number of cooling steps in the flow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was first created in the system.',
    `critical_layer_count` STRING COMMENT 'Number of critical layers requiring advanced lithography techniques (EUV, multi-patterning, or tight overlay control).',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Standard manufacturing cycle time in days for a wafer lot to complete the entire process flow under normal production conditions.',
    `process_flow_description` STRING COMMENT 'Detailed textual description of the process flow, including key process characteristics, intended applications, and any special considerations.',
    `device_family` STRING COMMENT 'The device family or product line for which this process flow is applicable (e.g., FinFET, GAA, Planar CMOS, DRAM, NAND Flash).',
    `dfm_rule_set_version` STRING COMMENT 'Version identifier of the Design for Manufacturability (DFM) rule set associated with this process flow.',
    `effective_end_date` DATE COMMENT 'Date when this process flow version was superseded or retired from production use. Null for currently active flows.',
    `effective_start_date` DATE COMMENT 'Date when this process flow version became effective and available for production use.',
    `euv_layer_count` STRING COMMENT 'Number of layers using Extreme Ultraviolet (EUV) lithography in the process flow.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility (FAB) where this process flow is qualified and executed.',
    `feol_step_count` STRING COMMENT 'Number of process steps in the Front End of Line (FEOL) phase, covering transistor formation and isolation.',
    `flow_code` STRING COMMENT 'Unique alphanumeric code identifying the process flow in manufacturing execution systems and production planning. Used as the external business identifier.',
    `flow_for_node` BIGINT COMMENT 'FK to process.technology_node.technology_node_id — Every process flow is designed for a specific technology node. This is the top-level classification relationship enabling node-based process management.',
    `flow_name` STRING COMMENT 'Business name of the process flow, typically indicating the technology node and device family (e.g., 5nm FinFET Logic Flow, 28nm CMOS Analog Flow).',
    `flow_revision` STRING COMMENT 'Version or revision identifier for the process flow definition. Incremented when process steps, parameters, or sequences are modified.',
    `flow_type` STRING COMMENT 'Classification of the process flow by device application domain (logic, memory, analog, mixed-signal, power, RF, sensor). [ENUM-REF-CANDIDATE: logic|memory|analog|mixed_signal|power|rf|sensor — 7 candidates stripped; promote to reference product]',
    `is_baseline_flow` BOOLEAN COMMENT 'Flag indicating whether this is the baseline (reference) process flow for the technology node. True if baseline, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was last modified or updated.',
    `lithography_layer_count` STRING COMMENT 'Total number of photolithography (patterning) layers in the complete process flow.',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers defined in the BEOL portion of the process flow.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `mol_step_count` STRING COMMENT 'Number of process steps in the Middle of Line (MOL) phase, covering contact formation and local interconnects.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the process flow execution, qualification, or usage.',
    `opc_rule_set_version` STRING COMMENT 'Version identifier of the Optical Proximity Correction (OPC) rule set used for mask data preparation in this process flow.',
    `owner_organization` STRING COMMENT 'Process engineering organization or department responsible for this process flow (e.g., Advanced Logic Process, Memory Process Engineering).',
    `qualification_date` DATE COMMENT 'Date when the process flow successfully completed qualification testing and was approved for production release.',
    `qualification_status` STRING COMMENT 'Current qualification and release status of the process flow. Indicates readiness for production use.. Valid values are `development|qualification|qualified|production|deprecated|obsolete`',
    `supports_multi_patterning` BOOLEAN COMMENT 'Flag indicating whether the process flow includes multi-patterning lithography techniques (LELE, SADP, SAQP). True if multi-patterning is used, False otherwise.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target die yield percentage (good dies per wafer) for production lots running this qualified process flow.',
    `total_step_count` STRING COMMENT 'Total number of unit process steps in the complete flow from wafer start through final inspection.',
    `waste_heat_recovery_enabled` BOOLEAN COMMENT 'Whether waste heat recovery is enabled in the flow.',
    CONSTRAINT pk_process_flow PRIMARY KEY(`process_flow_id`)
) COMMENT 'Master definition of a semiconductor manufacturing process flow (recipe sequence) for a given technology node. Captures the ordered sequence of unit process steps from FEOL through MOL and BEOL, including process node designation (e.g., 5nm, 3nm, 28nm), flow revision, qualification status, applicable device families, and PDK linkage. SSOT for all process flow definitions used in wafer fabrication.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`process_step` (
    `process_step_id` BIGINT COMMENT 'Unique identifier for the individual process step within the semiconductor manufacturing process flow. Primary key.',
    `cooling_condition_id` BIGINT COMMENT 'Cooling condition applied at this step.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the process engineer responsible for maintaining and optimizing this process step.',
    `fab_operator_qualification_id` BIGINT COMMENT 'Foreign key linking to workforce.fab_operator_qualification. Business justification: Operator qualification records must be tied to the steps they qualify for to enforce qualification compliance.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this process step is designed and qualified.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Required for material traceability per step in Yield Loss Analysis and compliance reports; experts expect each step to reference the exact material used.',
    `metrology_plan_id` BIGINT COMMENT 'Reference to the metrology measurement plan for this step, specifying what measurements are taken and at what frequency.',
    `opc_rule_set_id` BIGINT COMMENT 'Reference to the OPC rule set applied during mask data preparation for lithography steps, compensating for optical diffraction effects.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Production planning assigns each process step a primary fab tool; the step definition must reference the specific fab_tool for scheduling and capacity planning.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: A process step belongs to a process flow; adding internal FK enables direct navigation within the process domain.',
    `process_spc_control_plan_id` BIGINT COMMENT 'Reference to the SPC control plan governing this process step, defining control charts, sampling frequency, and control limits.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Step definition includes the default chamber where the operation occurs; linking enables chamber allocation, maintenance, and utilization reporting.',
    `recipe_id` BIGINT COMMENT 'Reference to the nominal equipment recipe or parameter set used for this process step. Links to the detailed process control parameters.',
    `cooling_target_temperature_celsius` DECIMAL(18,2) COMMENT 'Target temperature after cooling at this step.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was first created in the system.',
    `cycle_time_target_minutes` DECIMAL(18,2) COMMENT 'Target processing time for this step in minutes, used for manufacturing planning, scheduling, and throughput optimization.',
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
    `operation_type` STRING COMMENT 'Classification of the manufacturing operation performed in this step. Categorizes the fundamental process technology applied. [ENUM-REF-CANDIDATE: photolithography|etch|deposition|implant|diffusion|cmp|metrology|inspection|cleaning|annealing — 10 candidates stripped; promote to reference product]',
    `power_setpoint_watts` DECIMAL(18,2) COMMENT 'Nominal RF or DC power setpoint in watts for plasma-based process steps such as reactive ion etch or PECVD.',
    `pressure_setpoint_torr` DECIMAL(18,2) COMMENT 'Nominal chamber pressure setpoint in Torr for vacuum process steps such as CVD, PVD, or plasma etch.',
    `process_category` STRING COMMENT 'High-level classification indicating whether this step belongs to Front End of Line (FEOL), Middle of Line (MOL), or Back End of Line (BEOL) processing stages.. Valid values are `feol|mol|beol`',
    `process_time_seconds` DECIMAL(18,2) COMMENT 'Nominal duration of the actual process operation in seconds, excluding load/unload and setup time.',
    `qualification_date` DATE COMMENT 'Date when this process step successfully completed qualification and was approved for production release.',
    `qualification_status` STRING COMMENT 'Status of process qualification for this step, indicating whether it has passed validation testing and is approved for production use.. Valid values are `not_started|in_progress|qualified|failed|waived`',
    `sequence_order` STRING COMMENT 'Numeric ordering of this step within the parent process flow, determining the execution sequence in the manufacturing line.',
    `step_description` STRING COMMENT 'Detailed textual description of the process step, including technical objectives, materials used, and special handling requirements.',
    `step_name` STRING COMMENT 'Human-readable name of the process step, describing the operation performed (e.g., Gate Oxide CVD, Contact Lithography, Metal 1 Etch).',
    `step_number` STRING COMMENT 'Business identifier for the process step, typically a hierarchical or sequential code used in manufacturing documentation and traveler cards.',
    `step_status` STRING COMMENT 'Current lifecycle status of the process step, indicating whether it is in active production use, under development, or retired.. Valid values are `active|inactive|development|qualification|deprecated|obsolete`',
    `target_cd_nm` DECIMAL(18,2) COMMENT 'Target critical dimension in nanometers for lithography and etch steps, defining the feature size specification.',
    `target_layer` STRING COMMENT 'The specific material layer or structure being processed in this step (e.g., Poly Gate, Metal 2, Contact Via, STI Oxide).',
    `target_thickness_angstrom` DECIMAL(18,2) COMMENT 'Target film thickness in angstroms for deposition steps, used as the process control specification.',
    `temperature_setpoint_celsius` DECIMAL(18,2) COMMENT 'Nominal process temperature setpoint in degrees Celsius for thermal process steps such as deposition, diffusion, or annealing.',
    `tool_class` STRING COMMENT 'Equipment class or tool type required to execute this process step (e.g., EUV Scanner, PECVD Reactor, CMP Polisher, Ion Implanter).',
    `version_number` STRING COMMENT 'Version identifier for this process step definition, supporting change control and revision tracking.',
    CONSTRAINT pk_process_step PRIMARY KEY(`process_step_id`)
) COMMENT 'Individual unit process step within a process flow, representing a discrete manufacturing operation such as photolithography exposure, CVD deposition, CMP planarization, ion implantation, dry etch, wet clean, or metrology measurement. Captures step sequence number, operation type, tool class, target layer, nominal recipe parameters, and step classification (FEOL/MOL/BEOL). Owned by the process domain as the atomic building block of all process flows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`recipe` (
    `recipe_id` BIGINT COMMENT 'Primary key for recipe',
    `cooling_condition_id` BIGINT COMMENT 'Unique identifier for the cooling condition record within the recipe process entity.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: A recipe is authored for a specific fab tool model; the FK supports recipe‑tool compatibility checks and tool‑specific parameter validation.',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the process step in the overall process flow that this recipe executes.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this recipe is qualified.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Recipes define usage of specific chemicals/materials; linking to material_master enables supplier certification, lot tracking, and regulatory compliance.',
    `process_step_id` BIGINT COMMENT 'FK to process.process_step.process_step_id — Every recipe is defined for a specific process step (operation type + tool class). This FK connects the equipment-level parameters to the logical process step they implement.',
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
    `cooling_condition_id` BIGINT COMMENT 'Unique identifier for the cooling condition record within the lot process run process entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: MES cost accounting assigns each lot run to a cost center for budgeting and variance analysis, required for daily production cost reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the fab operator who initiated or supervised this process run. Used for training effectiveness analysis and operator certification tracking.',
    `experimental_lot_id` BIGINT COMMENT 'Foreign key linking to research.experimental_lot. Business justification: Production tracking of research experimental lots is required for yield learning and cost accounting; linking run to experimental lot enables this.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the specific fabrication equipment tool that processed this lot. Critical for equipment performance analysis, utilization tracking, and SPC (Statistical Process Control) correlation.',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the specific process step in the technology node process flow that this lot executed. Defines the operation type (photolithography, etch, deposition, implant, CMP, metrology, etc.).',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that executed this process step. Links to the fabrication domain lot master record for WIP (Work in Process) tracking and genealogy.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to invoice.invoice_line. Business justification: Run Billing Detail Report maps each lot process run to the invoice line that charges the customer for that run.',
    `recipe_id` BIGINT COMMENT 'FK to process.process_process_recipe.process_process_recipe_id — Each lot run uses a specific recipe version. Critical for traceability - which recipe was actually used for a given lot at a given step.',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Required for Order Fulfillment Tracking report that ties each production run to the sales order it fulfills.',
    `primary_lot_recipe_id` BIGINT COMMENT 'Reference to the actual recipe executed for this process step. May differ from the planned recipe if engineering overrides or recipe revisions occurred. Links to the recipe master in the fabrication domain.',
    `process_step_id` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — Every lot process run is an execution of a specific process step. This FK is essential for WIP tracking and SPC data collection context.',
    `shift_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_schedule. Business justification: Labor costing and compliance audits require linking each lot run to the shift schedule that covered it.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Lot Traceability report ties each run to the SKU being produced, enabling yield and compliance tracking.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module within the equipment tool where the lot was processed. Critical for multi-chamber tools to isolate chamber-specific process variation and matching.',
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
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the specific process step (e.g., photolithography, etch, deposition, implant) being monitored by this SPC chart.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this SPC chart is defined. Links to the technology node master data.',
    `process_step_id` BIGINT COMMENT 'FK to process.process_step.process_step_id — Every SPC control chart monitors a parameter at a specific process step. This FK is essential for SPC chart setup and process monitoring workflows.',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer within the lot from which the measurement was taken. Enables wafer-level traceability.',
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
    `employee_id` BIGINT COMMENT 'The identifier of the operator or technician who initiated or supervised the measurement. Used for traceability and training purposes.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the metrology or inspection equipment that captured this measurement. Links to the KLA ICOS or in-line metrology tool used for data collection.',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the process step at which this measurement was taken. Identifies the specific fabrication operation (photolithography, etch, deposition, implant, etc.) being monitored.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for which this measurement was taken. Links to the semiconductor technology node (e.g., 7nm, 5nm, 3nm) being manufactured.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot being measured. Links to the fabrication lot that was sampled for this SPC measurement.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: SPC measurements are recorded per product for quality analysis; required by the SPC Data Analysis process.',
    `metrology_run_id` BIGINT COMMENT 'The identifier of the measurement run or batch that this data point belongs to. Groups multiple measurements taken during a single metrology session or sampling event.',
    `recipe_id` BIGINT COMMENT 'The identifier of the process recipe that was active when this measurement was taken. Links the measurement to the specific process parameters and settings used during fabrication.',
    `sampling_plan_id` BIGINT COMMENT 'The identifier of the sampling plan that defined which wafers and sites to measure. Links to the metrology sampling strategy for this process step.',
    `spc_control_chart_id` BIGINT COMMENT 'Reference to the SPC control chart against which this measurement is plotted. Links to the control chart configuration defining control limits, chart type, and monitoring rules.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`capability` (
    `capability_id` BIGINT COMMENT 'Unique identifier for the process capability record.',
    `employee_id` BIGINT COMMENT 'Identifier of the process engineer or quality analyst who performed the capability assessment.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the specific fabrication equipment or tool on which the process capability was assessed.',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the specific process step being monitored for capability.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node for which this capability assessment applies.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Capability data (Cp, Cpk) is tracked per IC product for the Process Capability Review.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe or fabrication process recipe used during the evaluation period.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific process chamber within multi-chamber equipment where measurements were taken.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Date and time when the capability analysis was performed and this record was generated.',
    `assessment_method` STRING COMMENT 'Method used for capability assessment: short-term (initial process qualification), long-term (ongoing production monitoring), initial (pre-production), or ongoing (continuous monitoring).. Valid values are `short_term|long_term|initial|ongoing`',
    `capability_status` STRING COMMENT 'Overall assessment of process capability status based on Cpk threshold criteria. Typically capable (Cpk >= 1.33), marginal (1.0 <= Cpk < 1.33), incapable (Cpk < 1.0).. Valid values are `capable|marginal|incapable|not_assessed`',
    `comments` STRING COMMENT 'Additional notes, observations, or context regarding the capability assessment, including any special causes identified or improvement actions planned.',
    `control_chart_type` STRING COMMENT 'Type of Statistical Process Control (SPC) control chart used for monitoring this parameter (e.g., X-bar R, X-bar S, Individuals, P-chart, C-chart, U-chart).. Valid values are `xbar_r|xbar_s|individuals|p_chart|c_chart|u_chart`',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether corrective action is required based on capability assessment results falling below acceptable thresholds.',
    `cp_index` DECIMAL(18,2) COMMENT 'Process capability index Cp measuring the potential capability of the process assuming it is centered on target. Calculated as (USL - LSL) / (6 * standard deviation).',
    `cpk_index` DECIMAL(18,2) COMMENT 'Process capability index Cpk measuring the actual capability of the process accounting for centering. Calculated as minimum of [(USL - mean) / (3 * standard deviation), (mean - LSL) / (3 * standard deviation)].',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process capability record was first created in the system.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the time window over which process capability was calculated.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the time window over which process capability was calculated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process capability record was last updated or modified.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'Lower specification limit defining the minimum acceptable value for the parameter.',
    `mean_value` DECIMAL(18,2) COMMENT 'Arithmetic mean of the parameter measurements over the evaluation period.',
    `measurement_method` STRING COMMENT 'Metrology technique or measurement method used to collect parameter data (e.g., optical CD, SEM, ellipsometry, XRF, electrical test).',
    `normality_test_result` STRING COMMENT 'Result of statistical normality test (e.g., Anderson-Darling, Shapiro-Wilk) to validate that data follows normal distribution, a prerequisite for capability index calculation.. Valid values are `normal|non_normal|not_tested`',
    `out_of_control_points` STRING COMMENT 'Number of data points that violated SPC control rules during the evaluation period, indicating special cause variation.',
    `parameter_code` STRING COMMENT 'Standardized code or identifier for the process parameter in the Manufacturing Execution System (MES).',
    `parameter_name` STRING COMMENT 'Name of the monitored process parameter for which capability is being assessed (e.g., etch rate, film thickness, overlay error, critical dimension).',
    `pp_index` DECIMAL(18,2) COMMENT 'Process performance index Pp measuring the overall performance of the process over time. Calculated as (USL - LSL) / (6 * overall standard deviation).',
    `ppk_index` DECIMAL(18,2) COMMENT 'Process performance index Ppk measuring the actual performance of the process accounting for centering over time. Calculated as minimum of [(USL - mean) / (3 * overall standard deviation), (mean - LSL) / (3 * overall standard deviation)].',
    `process_area` STRING COMMENT 'Major process area classification: FEOL (Front End of Line), MOL (Middle of Line), or BEOL (Back End of Line).. Valid values are `feol|mol|beol`',
    `process_layer` STRING COMMENT 'Specific process layer or mask level in the fabrication flow where this capability assessment applies (e.g., poly gate, metal 1, contact).',
    `product_family` STRING COMMENT 'Product family or device type for which this capability assessment applies (e.g., logic, memory, analog, mixed-signal).',
    `qualification_status` STRING COMMENT 'Qualification status of the process step for production release based on capability assessment results and technology node readiness criteria.. Valid values are `qualified|conditional|not_qualified|pending`',
    `sample_count` STRING COMMENT 'Number of measurement samples included in the capability calculation.',
    `standard_deviation` DECIMAL(18,2) COMMENT 'Standard deviation of the parameter measurements, representing process variation.',
    `subgroup_size` STRING COMMENT 'Number of measurements per subgroup used in the SPC control chart analysis.',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal or target value for the process parameter as specified in the process recipe or design requirements.',
    `trend_direction` STRING COMMENT 'Directional trend of capability indices compared to previous evaluation periods, indicating process improvement or degradation.. Valid values are `improving|stable|degrading|insufficient_data`',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the parameter values (e.g., nanometers, angstroms, degrees Celsius, torr, sccm).',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'Upper specification limit defining the maximum acceptable value for the parameter.',
    `wafer_size_mm` STRING COMMENT 'Wafer diameter in millimeters for which this capability assessment applies (e.g., 200mm, 300mm, 450mm).',
    CONSTRAINT pk_capability PRIMARY KEY(`capability_id`)
) COMMENT 'Process capability index record for a monitored parameter at a specific process step over a defined evaluation period. Captures Cp, Cpk, Pp, Ppk indices, mean, standard deviation, sample count, evaluation window start/end dates, specification limits (USL, LSL), target value, capability status (capable/marginal/incapable), and trend direction. Used for technology node readiness assessments and continuous improvement tracking per IATF 16949 and ISO 9001 requirements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` (
    `opc_rule_set_id` BIGINT COMMENT 'Unique identifier for the OPC rule set record. Primary key.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process geometry) for which this OPC rule set is designed.',
    `assist_feature_rules` STRING COMMENT 'Description or reference to the sub-resolution assist feature (SRAF) placement rules included in this OPC rule set.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this OPC rule set record was first created in the system.',
    `eda_tool_name` STRING COMMENT 'Name of the specific EDA tool product used for OPC processing (e.g., Proteus, Calibre nmOPC).',
    `eda_tool_vendor` STRING COMMENT 'Vendor of the EDA tool used to generate and apply this OPC rule set (e.g., Synopsys, Cadence, Mentor Graphics).',
    `eda_tool_version` STRING COMMENT 'Version of the EDA tool used to generate this OPC rule set.',
    `illumination_mode` STRING COMMENT 'Illumination configuration used in the scanner (e.g., conventional, annular, dipole, quadrupole, freeform).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this OPC rule set is currently active and available for use in production flows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this OPC rule set record was last modified or updated.',
    `lithography_type` STRING COMMENT 'Type of lithography technology used (EUV = Extreme Ultraviolet, DUV = Deep Ultraviolet).. Valid values are `EUV|DUV|i-line|g-line`',
    `lithography_wavelength_nm` DECIMAL(18,2) COMMENT 'Wavelength of the lithography exposure light in nanometers (e.g., 193 for DUV, 13.5 for EUV).',
    `meef_feature_type` STRING COMMENT 'Type of feature for which the MEEF value was characterized (e.g., line, space, contact, via, dense, isolated).',
    `meef_measurement_methodology` STRING COMMENT 'Methodology used to measure and characterize MEEF (e.g., wafer metrology, simulation, focus-exposure matrix).',
    `meef_pitch_nm` DECIMAL(18,2) COMMENT 'Feature pitch in nanometers at which the MEEF value was measured.',
    `meef_target_cd_nm` DECIMAL(18,2) COMMENT 'Target critical dimension in nanometers for the MEEF characterization measurement.',
    `meef_value` DECIMAL(18,2) COMMENT 'Primary MEEF value characterizing the mask-to-wafer CD error amplification for this layer and process. MEEF = (wafer CD change) / (mask CD change).',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this OPC rule set.',
    `opc_for_node` BIGINT COMMENT 'FK to process.process_technology_node.process_technology_node_id — OPC rule sets are defined per technology node and layer. Node reference is essential for OPC management.',
    `opc_model_type` STRING COMMENT 'Type of OPC correction methodology employed in this rule set.. Valid values are `rule_based|model_based|hybrid|inverse_lithography`',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer or lithography engineer responsible for this OPC rule set.',
    `owner_organization` STRING COMMENT 'Organization or department responsible for maintaining this OPC rule set (e.g., Lithography Engineering, Process Integration).',
    `process_bias_table_reference` STRING COMMENT 'Reference identifier to the process bias lookup tables used for CD correction in this OPC rule set.',
    `process_window_dof_nm` DECIMAL(18,2) COMMENT 'Depth of focus in nanometers defining the usable focus range for this OPC rule set and layer.',
    `process_window_el_percent` DECIMAL(18,2) COMMENT 'Exposure latitude as a percentage defining the usable dose range for this OPC rule set and layer.',
    `qualification_date` DATE COMMENT 'Date when this OPC rule set was qualified and approved for production use.',
    `qualification_status` STRING COMMENT 'Current qualification and approval status of this OPC rule set for production use.. Valid values are `draft|under_qualification|qualified|production|deprecated`',
    `rule_set_file_format` STRING COMMENT 'File format of the OPC rule set (e.g., proprietary Synopsys format, Cadence format, industry standard).',
    `rule_set_file_path` STRING COMMENT 'File system path or repository location of the OPC rule set file used by EDA tools (Synopsys, Cadence).',
    `rule_set_name` STRING COMMENT 'Business name or identifier for this OPC rule set, typically including layer and node information.',
    `rule_set_version` STRING COMMENT 'Version identifier for this OPC rule set, tracking revisions and updates to the correction algorithms.',
    `scanner_numerical_aperture` DECIMAL(18,2) COMMENT 'Numerical aperture of the lithography scanner lens system, defining the light-gathering capability and resolution.',
    `sigma_inner` DECIMAL(18,2) COMMENT 'Inner sigma value defining the illumination pupil fill for off-axis illumination modes.',
    `sigma_outer` DECIMAL(18,2) COMMENT 'Outer sigma value defining the illumination pupil fill for off-axis illumination modes.',
    `target_layer_name` STRING COMMENT 'Name of the lithography layer (e.g., Metal1, Poly, Contact) for which this OPC rule set applies.',
    CONSTRAINT pk_opc_rule_set PRIMARY KEY(`opc_rule_set_id`)
) COMMENT 'Optical Proximity Correction (OPC) rule set and MEEF characterization record for a specific lithography layer and technology node. Captures OPC model version, target layer name, technology node, lithography wavelength (EUV/DUV), scanner NA, illumination mode, rule set file reference, process bias tables, assist feature rules, qualification status, and complete MEEF characterization (MEEF value per feature type, pitch, CD target, process window DOF/EL, sigma illumination, NA, wavelength, measurement methodology). MEEF parameters are integral attributes of the OPC rule set as they characterize mask-to-wafer CD transfer fidelity within the OPC model context. Managed in conjunction with Synopsys and Cadence EDA OPC flows. SSOT for all OPC, MEEF, and lithography proximity correction data used in mask data preparation and CD tolerance specification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` (
    `meef_parameter_id` BIGINT COMMENT 'Unique identifier for the MEEF parameter record. Primary key for this entity.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this MEEF parameter is defined.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot used for MEEF characterization experiments.',
    `opc_rule_set_id` BIGINT COMMENT 'Reference to the OPC rule set associated with this MEEF parameter, used for mask data preparation and correction.',
    `photomask_id` BIGINT COMMENT 'Reference to the photomask (reticle) for which this MEEF parameter applies.',
    `application_scope` STRING COMMENT 'Description of the application scope for this MEEF parameter (e.g., specific product families, process flows, or design rules).',
    `cd_target_nm` DECIMAL(18,2) COMMENT 'Target critical dimension in nanometers for the feature at wafer level.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MEEF parameter record was first created in the system.',
    `depth_of_focus_nm` DECIMAL(18,2) COMMENT 'Depth of focus in nanometers representing the process window in the Z-axis (focus direction) for acceptable CD control.',
    `effective_date` DATE COMMENT 'Date from which this MEEF parameter becomes effective for use in production mask procurement and OPC.',
    `expiration_date` DATE COMMENT 'Date when this MEEF parameter expires or is superseded by a newer version.',
    `exposure_latitude_percent` DECIMAL(18,2) COMMENT 'Exposure latitude as a percentage representing the allowable variation in exposure dose while maintaining acceptable CD control.',
    `feature_type` STRING COMMENT 'Type of lithographic feature being characterized (line, space, contact, via, trench, island).. Valid values are `line|space|contact|via|trench|island`',
    `illumination_mode` STRING COMMENT 'Type of illumination mode used during exposure (conventional, annular, dipole, quadrupole, quasar, freeform).. Valid values are `conventional|annular|dipole|quadrupole|quasar|freeform`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MEEF parameter record was last modified or updated.',
    `layer_name` STRING COMMENT 'Name of the critical layer in the semiconductor fabrication process (e.g., Metal1, Poly, Contact) for which MEEF is characterized.',
    `lithography_type` STRING COMMENT 'Type of lithography technology used (DUV - Deep Ultraviolet, EUV - Extreme Ultraviolet, i-line, KrF, ArF).. Valid values are `DUV|EUV|i-line|KrF|ArF`',
    `mask_cd_target_nm` DECIMAL(18,2) COMMENT 'Target critical dimension on the photomask in nanometers (at 4X or 5X magnification).',
    `mask_cd_tolerance_nm` DECIMAL(18,2) COMMENT 'Allowable tolerance for mask CD in nanometers, derived from MEEF and wafer CD specifications.',
    `measurement_date` DATE COMMENT 'Date when the MEEF measurement was performed.',
    `measurement_method` STRING COMMENT 'Method used to measure MEEF (SEM - Scanning Electron Microscopy, optical metrology, AFM - Atomic Force Microscopy, scatterometry).. Valid values are `SEM|optical|AFM|scatterometry`',
    `measurement_tool` STRING COMMENT 'Specific metrology tool or equipment used to characterize the MEEF parameter.',
    `meef_value` DECIMAL(18,2) COMMENT 'The MEEF value representing the ratio of wafer critical dimension (CD) error to mask CD error. Higher MEEF indicates greater sensitivity to mask errors.',
    `notes` STRING COMMENT 'Additional notes, observations, or comments related to the MEEF parameter characterization and usage.',
    `numerical_aperture` DECIMAL(18,2) COMMENT 'Numerical aperture of the lithography exposure tool lens system used for this MEEF characterization.',
    `pitch_nm` DECIMAL(18,2) COMMENT 'The pitch (center-to-center spacing) of the feature in nanometers at which the MEEF was measured.',
    `process_condition` STRING COMMENT 'Description of the specific process conditions (resist type, bake temperatures, development time) under which MEEF was characterized.',
    `process_window_score` DECIMAL(18,2) COMMENT 'Composite score representing the overall process window quality, combining DOF and exposure latitude metrics.',
    `qualification_date` DATE COMMENT 'Date when the MEEF parameter was qualified and approved for production use.',
    `qualification_status` STRING COMMENT 'Current qualification status of the MEEF parameter record (draft, under review, qualified, rejected, obsolete).. Valid values are `draft|under_review|qualified|rejected|obsolete`',
    `qualified_by` STRING COMMENT 'Name or identifier of the engineer or team who qualified this MEEF parameter.',
    `resist_type` STRING COMMENT 'Type of photoresist material used during MEEF characterization.',
    `sigma_inner` DECIMAL(18,2) COMMENT 'Inner sigma illumination setting (partial coherence factor) for the exposure tool, defining the inner radius of the illumination pupil.',
    `sigma_outer` DECIMAL(18,2) COMMENT 'Outer sigma illumination setting (partial coherence factor) for the exposure tool, defining the outer radius of the illumination pupil.',
    `version` STRING COMMENT 'Version identifier for this MEEF parameter record, supporting version control and change tracking.',
    `wavelength_nm` DECIMAL(18,2) COMMENT 'Wavelength of the lithography exposure light source in nanometers (e.g., 193nm for ArF, 13.5nm for EUV).',
    CONSTRAINT pk_meef_parameter PRIMARY KEY(`meef_parameter_id`)
) COMMENT 'Mask Error Enhancement Factor (MEEF) parameter record for a specific critical layer, feature type, and process condition. Captures MEEF value, pitch, CD target, process window (DOF, EL), sigma illumination, NA, wavelength, measurement methodology, and associated OPC rule set. Used to characterize mask-to-wafer CD transfer fidelity and to set mask CD tolerances for reticle procurement.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` (
    `process_qualification_id` BIGINT COMMENT 'Unique identifier for the process qualification program record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific qualification: certain process qualifications are performed for a particular customer, required for compliance reports and customer approval tracking.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to invoice.ar_invoice. Business justification: Qualification Service Invoice ties a process qualification activity to the invoice billing the customer for qualification services.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Process qualification must be backed by a certification (e.g., ISO, ISO‑9001) to satisfy customer and regulatory requirements.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the process engineer who signed off on the qualification results.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Qualification runs are executed on a specific fab tool; the FK records which tool was qualified, supporting qualification history and tool eligibility checks.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this qualification applies.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: A qualification is scoped to a specific process flow; linking directly avoids cross‑domain indirection.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: Qualification reports must be associated with the originating research program for readiness assessment and stakeholder communication.',
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
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the qualification program. Free-text field for supplementary information.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer responsible for managing and executing the qualification program.',
    `owner_organization` STRING COMMENT 'Organizational unit or department responsible for the qualification program (e.g., Process Engineering, Integration, Module Development).',
    `plan_reference` STRING COMMENT 'Document reference or identifier for the formal qualification plan that defines acceptance criteria, test methodology, and success metrics. May reference PLM document number or file path.',
    `plm_system_source` STRING COMMENT 'Source PLM system from which this qualification record was extracted: oracle_agile (Oracle Agile PLM), siemens_teamcenter (Siemens Teamcenter PLM), other.. Valid values are `oracle_agile|siemens_teamcenter|other`',
    `plm_workflow_reference` STRING COMMENT 'Workflow or change order identifier in the source PLM system that tracks the qualification approval process.',
    `qualification_name` STRING COMMENT 'Descriptive name of the qualification program, identifying the process or change being qualified.',
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
    CONSTRAINT pk_process_qualification PRIMARY KEY(`process_qualification_id`)
) COMMENT 'Process qualification program record tracking the formal qualification of a new process flow, process step, or process change against defined acceptance criteria. Captures qualification type (new process, process change, tool qualification, node readiness), qualification plan reference, start date, target completion date, actual completion date, qualification status (in-progress, passed, failed, waived), sign-off engineer, and disposition. Sourced from Oracle Agile PLM and Siemens Teamcenter PLM qualification workflows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`change_notification` (
    `change_notification_id` BIGINT COMMENT 'Primary key for change_notification',
    `process_flow_id` BIGINT COMMENT 'FK to process.process_flow.process_flow_id — Process change notifications document changes to qualified process flows. This FK enables impact analysis of changes on production flows.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Identifier of the primary process flow impacted by this change notification.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Identifier of the technology node impacted by this change, such as 7nm, 5nm, or 3nm process technology.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Change notifications affect particular IC products; essential for the Product Change Impact Assessment.',
    `primary_change_process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Change notifications affect a specific process flow; an internal FK provides direct reference within the process domain.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: Change notifications are routed to the owning research program to evaluate impact on program milestones and compliance.',
    `actual_implementation_date` DATE COMMENT 'Actual date when the process change was implemented in production manufacturing.',
    `affected_customer_list` STRING COMMENT 'List of customer names or identifiers who have products affected by this change and require notification per contractual agreements.',
    `affected_equipment_list` STRING COMMENT 'List of manufacturing equipment tools or tool sets impacted by this process change, including tool IDs or model numbers.',
    `affected_material_list` STRING COMMENT 'List of raw materials, chemicals, gases, or consumables that are being changed or affected by this process modification.',
    `affected_product_list` STRING COMMENT 'Comma-separated list or description of product families, part numbers, or device types impacted by this process change.',
    `approval_date` DATE COMMENT 'Date when the process change notification received final internal approval to proceed.',
    `approval_status` STRING COMMENT 'Internal approval status from engineering, quality, and management stakeholders for proceeding with the process change.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who provided final approval for the process change notification.',
    `attachments` STRING COMMENT 'References to supporting documentation such as technical specifications, test reports, FMEA analyses, customer communications, or qualification data associated with this PCN.',
    `change_classification` STRING COMMENT 'Impact classification of the change: major (requires customer approval and qualification), minor (notification required but no requalification), or notification_only (informational, no customer action required).. Valid values are `major|minor|notification_only`',
    `change_description` STRING COMMENT 'Detailed description of the process change including what is being changed, why the change is necessary, and the technical details of the modification.',
    `change_reason` STRING COMMENT 'Business or technical justification for the change, such as yield improvement, cost reduction, obsolescence mitigation, reliability enhancement, or regulatory compliance.',
    `change_status` STRING COMMENT 'Current lifecycle status of the process change notification in the approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|customer_notified|implemented|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `change_title` STRING COMMENT 'Brief descriptive title summarizing the nature of the process change.',
    `change_type` STRING COMMENT 'Category of change being notified: process (recipe or flow modification), material (raw material or chemical change), equipment (tool or configuration change), design (mask or layout change), facility (fab site or cleanroom change), or supplier (vendor or subcontractor change).. Valid values are `process|material|equipment|design|facility|supplier`',
    `cooling_process_impact` STRING COMMENT 'The cooling process impact of the change notification record in the process domain.',
    `cost_impact` STRING COMMENT 'Assessment of the financial impact of the process change including implementation costs, ongoing cost savings or increases, and return on investment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the process change notification record was first created in the system.',
    `customer_approval_required` BOOLEAN COMMENT 'Indicates whether explicit customer approval is required before implementing the change, typically for major changes affecting form, fit, function, or reliability.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether customer notification is required per contractual agreements, regulatory requirements, or change impact assessment.',
    `cycle_time_impact_hours` DECIMAL(18,2) COMMENT 'Expected change in manufacturing cycle time resulting from the process change, measured in hours (positive for increase, negative for reduction).',
    `environmental_impact` STRING COMMENT 'Description of any environmental, health, or safety impacts resulting from the process change, including changes to hazardous material usage or waste generation.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility or site where the process change will be implemented.. Valid values are `^[A-Z0-9]{2,6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the process change notification record was last updated or modified.',
    `last_time_buy_date` DATE COMMENT 'Final date for customers to place orders for products manufactured using the old process before the change is implemented.',
    `last_time_ship_date` DATE COMMENT 'Final date for shipping products manufactured using the old process before transitioning to the new process.',
    `notes` STRING COMMENT 'Additional comments, observations, or context related to the process change notification.',
    `notification_date` DATE COMMENT 'Date when affected customers were formally notified of the pending process change.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer or technical owner responsible for managing this change notification through implementation.',
    `owner_organization` STRING COMMENT 'Department or organizational unit responsible for the process change, such as Process Engineering, Equipment Engineering, or Quality Assurance.',
    `pcn_number` STRING COMMENT 'Business identifier for the process change notification, typically formatted as PCN-NNNNNN. Used for external communication and tracking.. Valid values are `^PCN-[0-9]{6,10}$`',
    `planned_implementation_date` DATE COMMENT 'Target date for implementing the process change in production manufacturing.',
    `qualification_completion_date` DATE COMMENT 'Date when all qualification and validation activities for the process change were successfully completed.',
    `qualification_status` STRING COMMENT 'Status of the qualification and validation activities required to verify that the process change does not adversely affect product quality or reliability.. Valid values are `not_started|in_progress|completed|failed|waived`',
    `regulatory_impact` STRING COMMENT 'Assessment of whether the process change affects compliance with regulatory requirements such as RoHS, REACH, ITAR, EAR, or automotive quality standards (IATF 16949).',
    `risk_assessment` STRING COMMENT 'Evaluation of potential risks associated with the change including impact on product performance, reliability, quality, and manufacturability. May reference Failure Mode and Effects Analysis (FMEA) results.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to this change based on potential impact to product quality, reliability, and customer operations.. Valid values are `low|medium|high|critical`',
    `yield_impact_percent` DECIMAL(18,2) COMMENT 'Expected or measured change in manufacturing yield resulting from the process change, expressed as a percentage point change (positive for improvement, negative for degradation).',
    CONSTRAINT pk_change_notification PRIMARY KEY(`change_notification_id`)
) COMMENT 'Process Change Notification (PCN) record documenting a planned or executed change to a qualified process flow, recipe, material, or equipment configuration that may affect product performance or reliability. Captures PCN number, change type (process, material, equipment, design), affected products, change description, risk assessment, customer notification requirements, implementation date, and approval status. Managed through Oracle Agile PLM and SAP QM change management workflows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` (
    `yield_loss_event_id` BIGINT COMMENT 'Unique identifier for the yield loss event record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom the affected wafer lot is being fabricated. Used for customer-specific yield reporting and quality metrics.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to invoice.ar_invoice. Business justification: Yield Loss Charge Invoice records the invoice that compensates the customer for a specific yield loss event.',
    `capa_record_id` BIGINT COMMENT 'Reference to the corrective action or OCAP (Out of Control Action Plan) initiated in response to this yield loss event. Links to corrective action tracking system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield loss events are charged to the responsible cost center to quantify financial impact in loss‑analysis reports.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the fabrication equipment or tool associated with the process step where the yield loss occurred. Used for equipment-specific yield trending and FMEA.',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the specific process step at which the yield loss was identified. Links to process step master data.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for the affected wafer lot. Used for node-specific yield trending and benchmarking.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot in which the yield loss event was detected. Links to fabrication wafer lot master data.',
    `inspection_point_id` BIGINT COMMENT 'Reference to the inspection or metrology point where the yield loss was detected. May be inline or offline inspection station.',
    `recipe_id` BIGINT COMMENT 'Reference to the process recipe or run card that was active when the yield loss event occurred. Used for recipe-specific yield correlation and optimization.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Yield loss events on research wafers are reported to the responsible research project for root‑cause analysis and budget impact.',
    `sku_id` BIGINT COMMENT 'Reference to the IC design product or device family being fabricated on the affected wafer lot. Used for product-specific yield analysis and customer impact assessment.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the operator or automated system that initiated the inspection.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the inspection equipment used (e.g., KLA 29xx/39xx series, Applied Materials SEMVision). Tool asset identifier from equipment master.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for which this inspection was performed, e.g., 7nm, 5nm, 3nm.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that was inspected. Links to the fabrication wafer lot being monitored.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Defect inspection results are analyzed per IC product for the Defect Analysis per Product report.',
    `recipe_id` BIGINT COMMENT 'Identifier of the inspection recipe or program used to configure the tool for this inspection run. Defines sensitivity, scan area, and detection parameters.',
    `lot_process_run_id` BIGINT COMMENT 'FK to process.lot_process_run.lot_process_run_id — Defect inspection results are captured during or after a specific lot process run at an inspection step. This FK enables defect-to-process correlation.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Defect inspection results are tied to a specific process step; adding internal FK enables step‑level analysis.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` (
    `process_metrology_measurement_id` BIGINT COMMENT 'Unique identifier for the metrology_measurement data product.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or automated system that initiated the measurement.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the metrology equipment that performed the measurement (e.g., CD-SEM, ellipsometer, overlay tool).',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the process step at which this metrology measurement was taken.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this measurement was performed.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot on which this measurement was performed.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Metrology measurements are linked to the IC product they verify; used in Metrology Compliance reporting.',
    `recipe_id` BIGINT COMMENT 'Identifier of the metrology recipe or measurement program used for this measurement.',
    `process_site_map_id` BIGINT COMMENT 'Identifier of the measurement site map or sampling plan used to define measurement locations on the wafer.',
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
    `metrology_at_step` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — Metrology measurements are taken at specific process steps. Step context is essential for measurement interpretation and SPC feeding.',
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
    CONSTRAINT pk_process_metrology_measurement PRIMARY KEY(`process_metrology_measurement_id`)
) COMMENT 'In-line metrology measurement record capturing critical dimension (CD), overlay, film thickness, resistivity, or other physical parameter measurements taken on a wafer at a specific process step. Captures measurement type (CD-SEM, OCD, XRF, ellipsometry, overlay), tool ID, wafer lot reference, wafer number, measurement site map, per-site values, mean, 3-sigma, range, and pass/fail disposition against spec limits. Sourced from KLA ICOS and in-line metrology tools.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` (
    `implant_condition_id` BIGINT COMMENT 'Unique identifier for the ion implantation process condition master record. Primary key for the implant condition entity.',
    `recipe_id` BIGINT COMMENT 'Reference to the thermal anneal recipe applied after implantation to activate dopants and repair crystal damage. Critical for electrical junction formation.',
    `employee_id` BIGINT COMMENT 'Reference to the process engineer responsible for developing, qualifying, and maintaining this implant condition.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Reference to the parent process flow that contains this implant step. Links this implant condition to the overall manufacturing process sequence.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this implant condition is qualified. Critical for process design kit alignment.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Implant condition is associated with a specific process step; adding internal FK creates the needed relationship.',
    `spc_control_chart_id` BIGINT COMMENT 'Reference to the SPC control plan that defines monitoring parameters, sampling frequency, and control limits for this implant condition.',
    `anneal_temperature_celsius` DECIMAL(18,2) COMMENT 'Peak temperature of the post-implant anneal process in degrees Celsius. Typical range: 400°C to 1100°C depending on anneal type and dopant activation requirements.',
    `anneal_time_seconds` DECIMAL(18,2) COMMENT 'Duration of the anneal process at peak temperature, measured in seconds. RTA processes are typically 1-60 seconds, while furnace anneals may be minutes to hours.',
    `anneal_type` STRING COMMENT 'Type of thermal anneal process used for dopant activation. RTA (Rapid Thermal Anneal), furnace anneal, spike anneal, laser anneal, or flash anneal. Each has different thermal budget characteristics.. Valid values are `rta|furnace|spike|laser|flash`',
    `baseline_cpk` DECIMAL(18,2) COMMENT 'Baseline process capability index (Cpk) measured during qualification. Indicates the process capability to meet specifications. Target Cpk typically ≥1.33 for production.',
    `beam_current_ma` DECIMAL(18,2) COMMENT 'Ion beam current in milliamperes (mA). Determines the implantation rate and throughput. Higher beam currents enable faster processing but may increase wafer heating.',
    `condition_code` STRING COMMENT 'Unique business identifier code for this implant condition, used in manufacturing execution systems and process travelers.',
    `condition_name` STRING COMMENT 'Human-readable name for this implant condition, typically describing the implant purpose (e.g., Source/Drain Boron Implant, Threshold Voltage Adjust Phosphorus).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this implant condition record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `implant_condition_description` STRING COMMENT 'Detailed textual description of this implant condition, including its purpose, special considerations, and any process integration notes.',
    `device_type` STRING COMMENT 'Type of semiconductor device this implant condition is designed for (e.g., NMOS, PMOS transistors, bipolar devices, diodes, or implanted resistors). [ENUM-REF-CANDIDATE: nmos|pmos|nfet|pfet|bipolar|diode|resistor — 7 candidates stripped; promote to reference product]',
    `dopant_species` STRING COMMENT 'Chemical element or compound used for ion implantation. Common species include boron (p-type), phosphorus and arsenic (n-type), BF2 (boron difluoride for shallow junctions), and specialty dopants. [ENUM-REF-CANDIDATE: boron|phosphorus|arsenic|antimony|indium|bf2|germanium|silicon|nitrogen|carbon — 10 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date after which this implant condition is no longer valid for new production starts. Null indicates the condition is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this implant condition becomes valid and available for use in production process flows.',
    `implant_dose_ions_per_cm2` DECIMAL(18,2) COMMENT 'Total number of ions implanted per square centimeter of wafer surface. Expressed in scientific notation (e.g., 1.0E15 ions/cm²). Controls the dopant concentration.',
    `implant_energy_kev` DECIMAL(18,2) COMMENT 'Ion implantation energy in kilo-electron volts (keV). Controls the depth of ion penetration into the silicon substrate. Typical range: 0.5 keV to 500 keV.',
    `implant_layer_name` STRING COMMENT 'Name of the device layer being implanted (e.g., PWELL, NWELL, LDD, HDD, VT_ADJUST). Identifies the target region in the device structure.',
    `implant_purpose` STRING COMMENT 'Functional purpose of this implant step in the device structure. Examples: well formation, threshold voltage adjustment, lightly-doped drain (LDD), heavily-doped drain (HDD), source/drain, halo/pocket implants, or isolation. [ENUM-REF-CANDIDATE: well|vt_adjust|ldd|hdd|source_drain|halo|pocket|channel_stop|field_implant — 9 candidates stripped; promote to reference product]',
    `implant_tool_class` STRING COMMENT 'Classification of ion implanter equipment type required for this condition. Different tool classes are optimized for specific energy and dose ranges.. Valid values are `high_current|medium_current|low_energy|high_energy|ultra_high_dose`',
    `implant_tool_model` STRING COMMENT 'Specific model or type of ion implanter equipment qualified for this condition (e.g., Applied Materials Quantum X, Axcelis Purion).',
    `is_baseline_condition` BOOLEAN COMMENT 'Boolean flag indicating whether this is the baseline or reference implant condition for this layer and technology node. True if baseline, false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this implant condition record was most recently updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and audit purposes.',
    `notes` STRING COMMENT 'Additional technical notes, warnings, or special instructions for manufacturing operators and process engineers regarding this implant condition.',
    `owner_organization` STRING COMMENT 'Name of the engineering organization or department responsible for this implant condition (e.g., Ion Implant Process Engineering, FEOL Integration).',
    `process_window_dose_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable variation in implant dose as a percentage of target dose, defining the process window for dose control. Typical values: ±1% to ±5%.',
    `process_window_energy_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable variation in implant energy as a percentage of target energy, defining the process window for energy control. Typical values: ±1% to ±3%.',
    `qualification_date` DATE COMMENT 'Date when this implant condition successfully completed qualification testing and was approved for production use.',
    `qualification_status` STRING COMMENT 'Current qualification and release status of this implant condition. Indicates whether the condition is approved for production use or still under development.. Valid values are `draft|under_qualification|qualified|production|suspended|obsolete`',
    `requires_pre_amorphization` BOOLEAN COMMENT 'Boolean flag indicating whether a pre-amorphization implant (typically germanium or silicon) is required before the main dopant implant to reduce channeling effects.',
    `target_junction_depth_nm` DECIMAL(18,2) COMMENT 'Intended electrical junction depth in nanometers after implant and anneal. Critical specification for transistor performance and short-channel effect control.',
    `target_sheet_resistance_ohms_per_sq` DECIMAL(18,2) COMMENT 'Target electrical sheet resistance in ohms per square after implant and anneal. Key electrical parameter for verifying dopant activation and concentration.',
    `target_threshold_voltage_mv` DECIMAL(18,2) COMMENT 'Target transistor threshold voltage in millivolts that this implant condition is designed to achieve. Critical for device performance and power consumption.',
    `tilt_angle_degrees` DECIMAL(18,2) COMMENT 'Angle of wafer tilt relative to the ion beam axis, measured in degrees. Used to control channeling effects and implant profile symmetry. Typical range: 0° to 7°.',
    `twist_angle_degrees` DECIMAL(18,2) COMMENT 'Rotational angle of the wafer around its normal axis during implantation, measured in degrees. Used in conjunction with tilt angle to optimize implant uniformity. Typical range: 0° to 360°.',
    `version_number` STRING COMMENT 'Version identifier for this implant condition. Incremented when process parameters are modified. Enables change tracking and configuration management.',
    CONSTRAINT pk_implant_condition PRIMARY KEY(`implant_condition_id`)
) COMMENT 'Ion implantation process condition master record defining the implant species, energy, dose, tilt angle, twist angle, beam current, and anneal conditions for a specific doping step in a process flow. Captures implant layer name, dopant species (boron, phosphorus, arsenic, etc.), implant energy (keV), dose (ions/cm²), tilt/twist angles, beam current, implant tool class, and associated anneal recipe. Critical for transistor threshold voltage and junction depth control.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` (
    `deposition_condition_id` BIGINT COMMENT 'Unique identifier for the thin film deposition process condition record.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this deposition condition is qualified.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Deposition conditions are product‑specific; required for the Deposition Process Specification.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Deposition condition records are defined for a particular process step; linking directly improves traceability.',
    `spc_control_chart_id` BIGINT COMMENT 'Reference to the SPC control plan defining monitoring strategy, control limits, and sampling frequency for this deposition condition.',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Deposition processes use chemicals; linking to substance inventory enables REACH and hazardous‑substance tracking.',
    `carrier_gas` STRING COMMENT 'Inert carrier gas used to transport precursors and maintain chamber environment (e.g., Ar, N2, He).',
    `carrier_gas_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Flow rate of carrier gas in standard cubic centimeters per minute (sccm).',
    `chamber_configuration` STRING COMMENT 'Specific chamber setup or hardware configuration required (e.g., single-wafer, batch, showerhead type, electrode spacing).',
    `condition_code` STRING COMMENT 'Unique alphanumeric code used to identify this deposition condition in manufacturing execution systems and process documentation.',
    `condition_name` STRING COMMENT 'Human-readable name or identifier for this deposition condition recipe.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deposition condition record was first created in the system.',
    `deposition_method` STRING COMMENT 'Thin film deposition technique used: LPCVD (Low Pressure Chemical Vapor Deposition), PECVD (Plasma Enhanced Chemical Vapor Deposition), ALD (Atomic Layer Deposition), PVD (Physical Vapor Deposition), EPI (Epitaxial Growth), MOCVD (Metal Organic Chemical Vapor Deposition).. Valid values are `LPCVD|PECVD|ALD|PVD|EPI|MOCVD`',
    `deposition_pressure_torr` DECIMAL(18,2) COMMENT 'Process chamber pressure in Torr during deposition. Affects film density, step coverage, and deposition rate.',
    `deposition_rate_angstrom_per_minute` DECIMAL(18,2) COMMENT 'Target deposition rate in angstroms per minute. Key process control parameter affecting throughput and film quality.',
    `deposition_temperature_celsius` DECIMAL(18,2) COMMENT 'Process chamber temperature in degrees Celsius during deposition. Critical parameter affecting film quality, stress, and conformality.',
    `deposition_time_seconds` DECIMAL(18,2) COMMENT 'Total duration of the deposition step in seconds required to achieve target thickness.',
    `deposition_condition_description` STRING COMMENT 'Detailed textual description of the deposition condition, including application notes, special considerations, and process intent.',
    `effective_end_date` DATE COMMENT 'Date when this deposition condition is retired or superseded. Null indicates currently active condition.',
    `effective_start_date` DATE COMMENT 'Date when this deposition condition becomes effective and available for production use.',
    `fab_site_code` STRING COMMENT 'Manufacturing site or fab location where this deposition condition is qualified and used.',
    `film_stress_mpa` DECIMAL(18,2) COMMENT 'Intrinsic mechanical stress in the deposited film measured in megapascals (MPa). Positive values indicate tensile stress, negative values indicate compressive stress. Affects wafer bow and device reliability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this deposition condition record was last updated or modified.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer responsible for developing, maintaining, and supporting this deposition condition.',
    `owner_organization` STRING COMMENT 'Engineering organization or department responsible for this deposition condition (e.g., Thin Films Engineering, BEOL Integration).',
    `precursor_gas_1` STRING COMMENT 'Primary precursor gas or chemical reactant used in the deposition process (e.g., SiH4, TiCl4, WF6, TEOS).',
    `precursor_gas_1_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Flow rate of primary precursor gas in standard cubic centimeters per minute (sccm). Controls deposition rate and film stoichiometry.',
    `precursor_gas_2` STRING COMMENT 'Secondary precursor gas or reactant used in the deposition process (e.g., NH3, O2, N2, H2).',
    `precursor_gas_2_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Flow rate of secondary precursor gas in standard cubic centimeters per minute (sccm).',
    `process_capability_cpk` DECIMAL(18,2) COMMENT 'Statistical process capability index (Cpk) for this deposition condition, measuring process centering and variation relative to specification limits. Target is typically ≥1.33 for production.',
    `process_category` STRING COMMENT 'Manufacturing stage where deposition occurs: FEOL (Front End of Line) for gate dielectrics and transistor formation, MOL (Middle of Line) for contacts, BEOL (Back End of Line) for metal interconnects.. Valid values are `FEOL|MOL|BEOL`',
    `qualification_date` DATE COMMENT 'Date when this deposition condition was formally qualified and approved for production use.',
    `qualification_status` STRING COMMENT 'Current qualification and release status of this deposition condition for production use.. Valid values are `draft|under_qualification|qualified|production|suspended|obsolete`',
    `refractive_index` DECIMAL(18,2) COMMENT 'Optical refractive index of the deposited film at specified wavelength. Used for film characterization and thickness measurement via ellipsometry.',
    `rf_frequency_mhz` DECIMAL(18,2) COMMENT 'Radio frequency in megahertz used for plasma generation (e.g., 13.56 MHz, 27.12 MHz).',
    `rf_power_watts` DECIMAL(18,2) COMMENT 'Radio frequency power applied in watts for plasma-enhanced deposition methods (PECVD). Controls plasma density and ion bombardment energy.',
    `step_coverage_percent` DECIMAL(18,2) COMMENT 'Ratio of film thickness on vertical sidewalls to horizontal surfaces, expressed as percentage. Critical for via and trench filling in advanced nodes.',
    `target_layer` STRING COMMENT 'Functional layer name in the device stack where material is deposited (e.g., gate oxide, barrier layer, metal1, via2, passivation).',
    `target_material` STRING COMMENT 'Chemical composition or material being deposited (e.g., SiO2, Si3N4, TiN, W, Cu, HfO2, Al2O3, Ta, TaN, Co).',
    `target_thickness_angstrom` DECIMAL(18,2) COMMENT 'Specified target thickness of the deposited film in angstroms (Å). Critical for device electrical performance and process control.',
    `thickness_tolerance_angstrom` DECIMAL(18,2) COMMENT 'Allowable deviation from target thickness in angstroms, defining the acceptable process window.',
    `tool_class` STRING COMMENT 'Equipment type or platform family qualified for this deposition condition (e.g., Applied Materials Centura, Lam Vector, Tokyo Electron Telius).',
    `uniformity_specification_percent` DECIMAL(18,2) COMMENT 'Maximum allowable thickness non-uniformity across the wafer surface, expressed as percentage (e.g., ±2% 1-sigma). Critical for yield and device performance.',
    `version_number` STRING COMMENT 'Version identifier for this deposition condition, tracking revisions and updates over time.',
    CONSTRAINT pk_deposition_condition PRIMARY KEY(`deposition_condition_id`)
) COMMENT 'Thin film deposition process condition master record for CVD, PVD, ALD, and epitaxial deposition steps. Captures deposition method (LPCVD, PECVD, ALD, PVD, EPI), target material, target thickness, deposition temperature, pressure, precursor gases and flow rates, RF power, deposition rate, uniformity spec, and associated process step. Covers FEOL gate dielectric, BEOL metal interconnect, and barrier/liner deposition conditions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` (
    `etch_condition_id` BIGINT COMMENT 'Unique identifier for the etch process condition master record. Primary key for the etch condition entity.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this etch condition is qualified. Links to the technology node master record.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Etch conditions are tied to each IC product to ensure consistent etch performance; used in Etch Process Specification.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Etch condition records belong to a specific process step; internal FK provides direct association.',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Etch steps involve etchant chemicals; compliance requires associating each etch condition with the regulated substance record.',
    `application_scope` STRING COMMENT 'Description of the intended application scope or use case for this etch condition (e.g., high aspect ratio contact etch, metal gate patterning, shallow trench isolation).',
    `chamber_pressure_torr` DECIMAL(18,2) COMMENT 'Operating pressure inside the etch chamber measured in Torr. Critical parameter for plasma density and etch uniformity control.',
    `condition_code` STRING COMMENT 'Unique alphanumeric code assigned to the etch condition for system tracking and Manufacturing Execution System (MES) integration.',
    `condition_name` STRING COMMENT 'Human-readable name or identifier for the etch condition recipe. Used for operational reference and communication among process engineers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this etch condition record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `critical_dimension_bias_nm` DECIMAL(18,2) COMMENT 'Expected change in critical dimension (CD) due to the etch process in nanometers. Positive value indicates CD growth, negative indicates CD shrinkage. Used for Optical Proximity Correction (OPC) and Design for Manufacturability (DFM).',
    `effective_end_date` DATE COMMENT 'Date when this etch condition is retired or superseded. Null if still active. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date when this etch condition becomes effective and available for production use. Format: yyyy-MM-dd.',
    `endpoint_detection_method` STRING COMMENT 'Method used to detect the completion of the etch process. Options include time-based, Optical Emission Spectroscopy (OES), laser interferometry, mass spectrometry, or none for over-etch strategies.. Valid values are `time_based|optical_emission_spectroscopy|laser_interferometry|mass_spectrometry|none`',
    `etch_method` STRING COMMENT 'Specific etch method or technology used. For dry etch: Reactive Ion Etch (RIE), Inductively Coupled Plasma (ICP), Capacitively Coupled Plasma (CCP). For wet etch: immersion or spray.. Valid values are `RIE|ICP|CCP|wet_immersion|wet_spray`',
    `etch_rate_angstrom_per_minute` DECIMAL(18,2) COMMENT 'Target etch rate for the primary material in angstroms per minute. Key process parameter for throughput and uniformity control.',
    `etch_time_seconds` DECIMAL(18,2) COMMENT 'Duration of the etch process in seconds. May be time-based or endpoint-detection-based depending on the process control strategy.',
    `etch_type` STRING COMMENT 'Classification of the etch process as either dry etch (plasma-based: RIE, ICP, CCP) or wet etch (chemical immersion).. Valid values are `dry|wet`',
    `etchant_chemistry` STRING COMMENT 'The chemical composition of the etchant used. For dry etch: gas mixture (e.g., CF4/O2, SF6/O2, Cl2/BCl3). For wet etch: liquid chemistry (e.g., HF, BOE, H3PO4).',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where this etch condition is qualified and used. Supports multi-site manufacturing operations.',
    `is_baseline_condition` BOOLEAN COMMENT 'Boolean flag indicating whether this is the baseline or reference etch condition for the process step. True if this is the standard condition, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this etch condition record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the etch condition. Used for operational guidance and knowledge capture.',
    `over_etch_percent` DECIMAL(18,2) COMMENT 'Percentage of additional etch time beyond endpoint detection to ensure complete material removal. Expressed as a percentage of the main etch time.',
    `owner_organization` STRING COMMENT 'Organizational unit or department responsible for this etch condition (e.g., FEOL Process Engineering, BEOL Integration).',
    `primary_gas_flow_sccm` DECIMAL(18,2) COMMENT 'Flow rate of the primary etch gas in standard cubic centimeters per minute (SCCM). Applicable to dry etch processes.',
    `process_category` STRING COMMENT 'Classification of the etch step within the fabrication flow: Front End of Line (FEOL) for gate patterning, Middle of Line (MOL) for contact/via etch, or Back End of Line (BEOL) for metal etch.. Valid values are `FEOL|MOL|BEOL`',
    `profile_angle_degrees` DECIMAL(18,2) COMMENT 'Target sidewall angle of the etched feature in degrees from vertical. 90 degrees indicates perfectly vertical (anisotropic) etch. Critical for device performance and yield.',
    `qualification_date` DATE COMMENT 'Date when the etch condition was formally qualified and approved for production use. Format: yyyy-MM-dd.',
    `qualification_status` STRING COMMENT 'Current qualification and approval status of the etch condition. Indicates whether the condition is ready for production use or still under development.. Valid values are `draft|under_qualification|qualified|production|deprecated|obsolete`',
    `recipe_version` STRING COMMENT 'Version identifier for the etch recipe. Used for change control and traceability when recipe parameters are updated.',
    `rf_bias_power_watts` DECIMAL(18,2) COMMENT 'RF power applied to the substrate electrode (bias power) in watts. Controls ion energy and directionality for anisotropic etching.',
    `rf_source_power_watts` DECIMAL(18,2) COMMENT 'RF power applied to the plasma source coil or electrode in watts. Controls plasma density and etch rate in ICP and CCP systems.',
    `secondary_gas_flow_sccm` DECIMAL(18,2) COMMENT 'Flow rate of the secondary or carrier gas in standard cubic centimeters per minute (SCCM). Used for process tuning and selectivity control.',
    `selectivity_ratio` DECIMAL(18,2) COMMENT 'Ratio of etch rate of the target material to the etch rate of the underlying or masking material. Critical for process control and preventing over-etch damage.',
    `substrate_temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature of the wafer substrate during the etch process in degrees Celsius. Affects etch rate, selectivity, and profile control.',
    `target_cd_nm` DECIMAL(18,2) COMMENT 'Target critical dimension after etch in nanometers. Defines the intended feature size for the etched structure.',
    `target_layer` STRING COMMENT 'The specific layer or material being etched (e.g., polysilicon, oxide, nitride, metal1, metal2, via1, contact). Identifies the layer in the device stack.',
    `target_material` STRING COMMENT 'The material composition of the target layer being etched (e.g., silicon, silicon dioxide, silicon nitride, tungsten, copper, aluminum, titanium nitride).',
    `tool_class` STRING COMMENT 'Classification or family of etch equipment for which this condition is designed (e.g., Applied Materials Centura, Lam Research Kiyo, Tokyo Electron Tactras).',
    `uniformity_target_percent` DECIMAL(18,2) COMMENT 'Target uniformity of etch depth or CD across the wafer, expressed as a percentage (1-sigma or 3-sigma). Lower values indicate better uniformity.',
    CONSTRAINT pk_etch_condition PRIMARY KEY(`etch_condition_id`)
) COMMENT 'Etch process condition master record for dry etch (RIE, ICP, CCP) and wet etch steps. Captures etch type (dry/wet), etchant chemistry, gas flows, chamber pressure, RF power (source and bias), etch rate, selectivity targets, critical dimension bias, endpoint detection method, and associated process step. Covers FEOL gate patterning, contact/via etch, and BEOL metal etch conditions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` (
    `cmp_condition_id` BIGINT COMMENT 'Unique identifier for the CMP process condition master record. Primary key.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process geometry) for which this CMP condition is qualified, such as 7nm, 5nm, 3nm FinFET or GAA nodes.',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: CMP slurry chemicals are regulated; linking condition to substance inventory supports substance reporting and safety.',
    `carrier_speed_rpm` DECIMAL(18,2) COMMENT 'Rotational speed of the wafer carrier head during CMP processing, measured in revolutions per minute. Affects relative velocity and material removal uniformity.',
    `cmp_step_type` STRING COMMENT 'Classification of the CMP process step based on the material and layer being planarized. STI (Shallow Trench Isolation) for FEOL, ILD (Inter-Layer Dielectric) for MOL/BEOL, W-plug for tungsten contact fill, Cu damascene for copper interconnect, barrier for barrier metal removal. [ENUM-REF-CANDIDATE: STI|ILD|W-plug|Cu damascene|barrier|poly|tungsten contact|cobalt contact — 8 candidates stripped; promote to reference product]',
    `condition_code` STRING COMMENT 'Unique alphanumeric code assigned to this CMP condition for tracking and reference in Manufacturing Execution System (MES) and process control systems.',
    `condition_name` STRING COMMENT 'Human-readable name or identifier for this CMP process condition, typically including the CMP step type and target layer.',
    `conditioner_type` STRING COMMENT 'Type of diamond conditioning disk or brush used to maintain pad surface texture and porosity during CMP processing. Conditioning prevents pad glazing and maintains consistent removal rates.',
    `conditioning_frequency` STRING COMMENT 'Schedule for pad conditioning operations, such as ex-situ (between wafers), in-situ (during polishing), or time-based intervals. Maintains pad performance and removal rate stability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CMP condition record was first created in the system.',
    `defect_density_spec_per_wafer` DECIMAL(18,2) COMMENT 'Maximum allowable number of CMP-induced defects per wafer, including scratches, particles, residue, and surface damage. Measured by post-CMP inspection tools.',
    `cmp_condition_description` STRING COMMENT 'Detailed textual description of this CMP process condition, including special considerations, application scope, and any unique characteristics or constraints.',
    `dishing_spec_angstrom` DECIMAL(18,2) COMMENT 'Maximum allowable depression or dishing in metal features (copper lines, tungsten plugs) after CMP, measured in angstroms. Excessive dishing degrades electrical performance and reliability.',
    `effective_end_date` DATE COMMENT 'Date when this CMP condition version was superseded or retired from production use. Null for currently active conditions.',
    `effective_start_date` DATE COMMENT 'Date when this CMP condition version became active and available for production use.',
    `endpoint_detection_method` STRING COMMENT 'Technology used to determine when the target material removal amount has been achieved. Optical methods detect reflectivity changes, motor current monitors torque variations, time-based uses fixed duration, acoustic detects friction changes, eddy current senses metal thickness.. Valid values are `optical|motor current|time-based|acoustic|eddy current`',
    `equipment_class` STRING COMMENT 'Classification of CMP tool type qualified for this condition, such as rotary single-wafer, linear, or orbital polisher. Different tool architectures may require condition adjustments.',
    `erosion_spec_angstrom` DECIMAL(18,2) COMMENT 'Maximum allowable thinning of dielectric material in dense pattern areas relative to isolated areas, measured in angstroms. Erosion affects metal line height uniformity and interconnect reliability.',
    `fab_site_code` STRING COMMENT 'Identifier of the fabrication facility where this CMP condition is qualified and used. Enables multi-site process tracking and technology transfer.',
    `is_baseline_condition` BOOLEAN COMMENT 'Indicates whether this is the baseline or reference CMP condition for this step type and technology node. Baseline conditions serve as the standard for process capability and yield comparisons.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CMP condition record was most recently updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to this CMP condition, including troubleshooting guidance, known issues, or optimization opportunities.',
    `owner_organization` STRING COMMENT 'Engineering organization or department responsible for maintaining and updating this CMP process condition.',
    `pad_product_name` STRING COMMENT 'Commercial product name or part number of the CMP polishing pad as designated by the vendor.',
    `pad_type` STRING COMMENT 'Classification and material composition of the CMP polishing pad, including hardness, porosity, groove pattern, and surface texture characteristics that affect removal rate and uniformity.',
    `pad_vendor` STRING COMMENT 'Manufacturer or supplier of the CMP polishing pad used in this process condition.',
    `platen_pressure_psi` DECIMAL(18,2) COMMENT 'Downforce pressure applied by the wafer carrier to the polishing pad surface, measured in pounds per square inch. Critical parameter controlling removal rate and within-wafer uniformity.',
    `polish_time_seconds` DECIMAL(18,2) COMMENT 'Target duration of the CMP polishing step in seconds, from wafer contact with pad to endpoint detection or time-based completion.',
    `post_cmp_clean_recipe` STRING COMMENT 'Cleaning process recipe applied immediately after CMP to remove slurry residue, particles, and contaminants from the wafer surface. Typically includes brush scrubbing, chemical rinse, and DI water rinse steps.',
    `process_layer` STRING COMMENT 'Manufacturing layer classification indicating whether this CMP step occurs in Front End of Line (FEOL), Middle of Line (MOL), or Back End of Line (BEOL) processing.. Valid values are `FEOL|MOL|BEOL`',
    `qualification_date` DATE COMMENT 'Date when this CMP condition successfully completed qualification testing and was approved for production use.',
    `qualification_status` STRING COMMENT 'Current lifecycle state of this CMP condition in the process qualification workflow. Draft conditions are under development, under qualification are being validated, qualified have passed testing, production approved are released for volume manufacturing, suspended are temporarily disabled, obsolete are retired.. Valid values are `draft|under qualification|qualified|production approved|suspended|obsolete`',
    `qualified_by_engineer_name` STRING COMMENT 'Name of the process engineer responsible for qualifying and approving this CMP condition for production use.',
    `removal_rate_angstrom_per_min` DECIMAL(18,2) COMMENT 'Expected rate of material removal during CMP processing, measured in angstroms per minute. Determined by slurry chemistry, pad type, pressure, and speed parameters.',
    `selectivity_ratio` DECIMAL(18,2) COMMENT 'Ratio of removal rates between the target material and underlying stop layer or adjacent materials. High selectivity ensures controlled polishing without excessive removal of barrier or dielectric layers.',
    `slurry_chemistry_type` STRING COMMENT 'Chemical composition classification of the CMP slurry used in this condition, including abrasive type (silica, ceria, alumina), pH level, and chemical additives for selectivity and removal rate control.',
    `slurry_flow_rate_ml_per_min` DECIMAL(18,2) COMMENT 'Target volumetric flow rate of CMP slurry delivered to the polishing pad surface during processing, measured in milliliters per minute.',
    `slurry_product_name` STRING COMMENT 'Commercial product name or part number of the CMP slurry as designated by the vendor.',
    `slurry_vendor` STRING COMMENT 'Manufacturer or supplier of the CMP slurry chemical used in this process condition.',
    `table_speed_rpm` DECIMAL(18,2) COMMENT 'Rotational speed of the CMP platen table holding the polishing pad, measured in revolutions per minute. Combined with carrier speed determines relative motion and removal characteristics.',
    `target_layer_name` STRING COMMENT 'Specific layer or film stack being planarized by this CMP process, such as oxide, nitride, metal layer designation (M1, M2, etc.), or via layer.',
    `target_removal_amount_angstrom` DECIMAL(18,2) COMMENT 'Specified thickness of material to be removed during the CMP process, measured in angstroms. Critical for achieving target post-CMP film thickness and planarity.',
    `version_number` STRING COMMENT 'Version identifier for this CMP condition record, incremented when process parameters are modified. Enables change tracking and process history analysis.',
    `wafer_to_wafer_uniformity_spec_percent` DECIMAL(18,2) COMMENT 'Maximum allowable variation in average material removal between wafers processed under this condition, expressed as a percentage. Ensures consistent lot-level processing.',
    `within_wafer_uniformity_spec_percent` DECIMAL(18,2) COMMENT 'Maximum allowable variation in material removal across the wafer surface, expressed as a percentage. Calculated as (max - min) / (2 * mean) * 100. Critical for device performance uniformity.',
    CONSTRAINT pk_cmp_condition PRIMARY KEY(`cmp_condition_id`)
) COMMENT 'Chemical Mechanical Planarization (CMP) process condition master record defining slurry chemistry, pad type, platen pressure, carrier speed, table speed, endpoint detection method, target removal amount, post-CMP clean recipe, and within-wafer uniformity spec. Covers STI CMP, ILD CMP, W-plug CMP, Cu damascene CMP, and barrier CMP steps across FEOL, MOL, and BEOL.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` (
    `litho_condition_id` BIGINT COMMENT 'Unique identifier for the photolithography process condition master record.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this lithography condition is defined.',
    `opc_rule_set_id` BIGINT COMMENT 'Reference to the OPC rule set used to correct mask patterns for optical proximity effects at this lithography condition.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Lithography condition is applied to a particular process step; internal FK enables step‑level linkage.',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Lithography uses photoresist and developers; linking to substance inventory satisfies REACH and hazardous‑material compliance.',
    `cd_tolerance_nm` DECIMAL(18,2) COMMENT 'Allowable tolerance range for critical dimension variation in nanometers.',
    `condition_code` STRING COMMENT 'Unique business code or identifier used to reference this lithography condition in manufacturing execution systems.',
    `condition_name` STRING COMMENT 'Human-readable name or identifier for this specific lithography process condition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lithography condition record was first created in the system.',
    `depth_of_focus_nm` DECIMAL(18,2) COMMENT 'Depth of focus in nanometers, representing the range over which acceptable image quality is maintained.',
    `develop_process_type` STRING COMMENT 'Method used for resist development (e.g., puddle, spray, immersion).. Valid values are `puddle|spray|immersion`',
    `develop_time_seconds` DECIMAL(18,2) COMMENT 'Duration in seconds for the resist development step.',
    `effective_end_date` DATE COMMENT 'Date after which this lithography condition is no longer valid for production use.',
    `effective_start_date` DATE COMMENT 'Date from which this lithography condition becomes effective for production use.',
    `exposure_dose_mj_cm2` DECIMAL(18,2) COMMENT 'Exposure energy dose in millijoules per square centimeter required to properly expose the resist.',
    `exposure_latitude_percent` DECIMAL(18,2) COMMENT 'Exposure latitude as a percentage, indicating the allowable variation in exposure dose while maintaining acceptable CD control.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where this lithography condition is used.',
    `focus_offset_nm` DECIMAL(18,2) COMMENT 'Focus offset from best focus position in nanometers, used to optimize depth of focus and process window.',
    `hard_bake_temperature_c` DECIMAL(18,2) COMMENT 'Temperature in Celsius for the hard bake step performed after development to stabilize the resist pattern.',
    `hard_bake_time_seconds` DECIMAL(18,2) COMMENT 'Duration in seconds for the hard bake step.',
    `illumination_mode` STRING COMMENT 'Off-axis illumination mode used to enhance resolution and process window (e.g., dipole, quadrupole, freeform).. Valid values are `conventional|annular|dipole|quadrupole|quasar|freeform`',
    `is_baseline_condition` BOOLEAN COMMENT 'Flag indicating whether this is the baseline or reference lithography condition for the layer and technology node.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lithography condition record was last modified or updated.',
    `layer_name` STRING COMMENT 'Name of the semiconductor layer (e.g., Metal1, Poly, Contact) to which this lithography condition applies.',
    `lithography_type` STRING COMMENT 'Type of lithography technology used: EUV (Extreme Ultraviolet), DUV (Deep Ultraviolet), i-line, or g-line.. Valid values are `EUV|DUV|i-line|g-line`',
    `multi_patterning_type` STRING COMMENT 'Multi-patterning technique used: none, LELE (Litho-Etch-Litho-Etch), SADP (Self-Aligned Double Patterning), SAQP (Self-Aligned Quadruple Patterning), or EUV single exposure.. Valid values are `none|LELE|SADP|SAQP|EUV_single`',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this lithography condition.',
    `numerical_aperture` DECIMAL(18,2) COMMENT 'Numerical aperture of the scanner lens system, determining resolution capability (e.g., 0.33 for EUV, 1.35 for immersion DUV).',
    `overlay_tolerance_nm` DECIMAL(18,2) COMMENT 'Maximum allowable overlay error in nanometers between this layer and previous layers.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer responsible for this lithography condition definition and maintenance.',
    `owner_organization` STRING COMMENT 'Organization or department responsible for this lithography condition (e.g., Lithography Engineering, Process Integration).',
    `post_exposure_bake_temperature_c` DECIMAL(18,2) COMMENT 'Temperature in Celsius for the post-exposure bake step, critical for chemically amplified resists.',
    `post_exposure_bake_time_seconds` DECIMAL(18,2) COMMENT 'Duration in seconds for the post-exposure bake step.',
    `qualification_date` DATE COMMENT 'Date when this lithography condition was qualified for production use.',
    `qualification_status` STRING COMMENT 'Current qualification status of this lithography condition in the process development lifecycle.. Valid values are `draft|under_qualification|qualified|production|deprecated`',
    `resist_thickness_nm` DECIMAL(18,2) COMMENT 'Target thickness of the photoresist coating in nanometers.',
    `resist_type` STRING COMMENT 'Type or brand of photoresist material used (e.g., chemically amplified resist, metal oxide resist for EUV).',
    `scanner_model` STRING COMMENT 'Model name or identifier of the photolithography scanner equipment (e.g., ASML NXE:3400, Nikon NSR-S630D) used for this condition.',
    `sigma_inner` DECIMAL(18,2) COMMENT 'Inner sigma value defining the inner radius of the illumination pupil, used for off-axis illumination optimization.',
    `sigma_outer` DECIMAL(18,2) COMMENT 'Outer sigma value defining the outer radius of the illumination pupil, used for off-axis illumination optimization.',
    `target_cd_nm` DECIMAL(18,2) COMMENT 'Target critical dimension (linewidth or feature size) in nanometers that this lithography condition is designed to achieve.',
    `version_number` STRING COMMENT 'Version identifier for this lithography condition, used to track revisions and changes over time.',
    `wavelength_nm` DECIMAL(18,2) COMMENT 'Exposure wavelength in nanometers (e.g., 13.5 for EUV, 193 for ArF DUV, 248 for KrF DUV).',
    CONSTRAINT pk_litho_condition PRIMARY KEY(`litho_condition_id`)
) COMMENT 'Photolithography process condition master record for a specific layer and technology node. Captures scanner model, wavelength (EUV 13.5nm / DUV 193nm / 248nm), NA, sigma (inner/outer), illumination mode (dipole, quadrupole, freeform), resist type, resist thickness, exposure dose, focus offset, develop process, bake temperatures, and associated OPC rule set reference. Critical for CD control and overlay performance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` (
    `ocap_action_id` BIGINT COMMENT 'Unique identifier for the OCAP action record triggered by an SPC rule violation or process excursion event.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the manufacturing equipment where the process excursion was detected.',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the specific process step where the SPC excursion occurred and triggered the OCAP action.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node associated with the process flow where the excursion occurred.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that was in process when the SPC excursion was detected and OCAP action was triggered.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: OCAP actions are logged against the specific IC product they affect; used in OCAP Action Tracking per Product.',
    `employee_id` BIGINT COMMENT 'Reference to the process engineer or quality engineer assigned to investigate and resolve the OCAP action.',
    `spc_control_chart_id` BIGINT COMMENT 'FK to process.spc_control_chart.spc_control_chart_id — OCAP actions are triggered by SPC rule violations on a specific control chart. This FK enables traceability from corrective action back to the triggering monitoring event.',
    `spc_measurement_id` BIGINT COMMENT 'FK to process.spc_measurement.spc_measurement_id — OCAP actions are triggered by specific SPC rule violations on measurements. This link connects the corrective action to its triggering event.',
    `tertiary_ocap_assigned_engineer_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `action_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the OCAP action was completed and the process excursion was resolved.',
    `action_initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the OCAP action was formally initiated in response to the detected excursion.',
    `action_status` STRING COMMENT 'Current status of the OCAP action in its lifecycle from initiation through resolution.. Valid values are `initiated|in_progress|completed|escalated|cancelled`',
    `action_type` STRING COMMENT 'Type of corrective action taken in response to the SPC excursion. Defines the immediate response workflow per OCAP procedure. [ENUM-REF-CANDIDATE: hold_lot|notify_engineer|adjust_recipe|escalate|rework|scrap|continue_with_monitoring|equipment_maintenance — 8 candidates stripped; promote to reference product]',
    `affected_wafer_count` STRING COMMENT 'Number of wafers in the lot that were affected by the process excursion and subject to the OCAP action.',
    `assigned_organization` STRING COMMENT 'Organizational unit or department responsible for executing the OCAP action (e.g., Process Engineering, Quality Assurance, Equipment Engineering).',
    `closure_notes` STRING COMMENT 'Final notes and comments documenting the closure of the OCAP action, including lessons learned and recommendations for process improvement.',
    `containment_action_flag` BOOLEAN COMMENT 'Boolean flag indicating whether immediate containment actions were taken to prevent further processing of potentially defective material.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions taken to address the root cause and prevent recurrence of the process excursion.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the OCAP action record was first created in the manufacturing execution system.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified about the process excursion and its potential impact on product quality.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether customer notification is required due to the potential impact of the excursion on delivered product quality.',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the SPC rule violation or process excursion was detected by the control chart monitoring system.',
    `escalation_level` STRING COMMENT 'Level of management escalation required for the OCAP action based on severity and business impact.. Valid values are `none|supervisor|manager|director|executive`',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the OCAP action required escalation to senior engineering or management due to severity or complexity.',
    `excursion_severity` STRING COMMENT 'Severity classification of the process excursion based on the magnitude of deviation from control limits and potential impact on product quality.. Valid values are `minor|moderate|major|critical`',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where the process excursion occurred and the OCAP action was executed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the OCAP action record was last updated or modified.',
    `lot_disposition` STRING COMMENT 'Final disposition decision for the affected wafer lot after OCAP action completion (e.g., released to next step, held for further investigation, scrapped).. Valid values are `released|held|rework|scrap|quarantine|conditional_release`',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the OCAP action that provide context for future reference and continuous improvement.',
    `ocap_procedure_reference` STRING COMMENT 'Reference number or identifier of the documented OCAP procedure that defines the corrective response workflow for this type of excursion.',
    `ocap_responds_to_excursion` BIGINT COMMENT 'FK to process.process_excursion.process_excursion_id — OCAP actions are triggered by excursions/SPC violations. This link connects the corrective action to its triggering event for audit trail and effectiveness tracking.',
    `preventive_action_description` STRING COMMENT 'Detailed description of preventive actions implemented to reduce the likelihood of similar excursions occurring in the future.',
    `priority_level` STRING COMMENT 'Priority level assigned to the OCAP action based on the severity of the process excursion and its potential impact on yield and quality.. Valid values are `critical|high|medium|low`',
    `resolution_time_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes from excursion detection to OCAP action completion. Key metric for evaluating effectiveness of corrective response.',
    `response_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time in minutes from excursion detection to OCAP action initiation. Key metric for evaluating responsiveness of the quality control system.',
    `root_cause_classification` STRING COMMENT 'High-level classification of the root cause identified during OCAP investigation (e.g., equipment drift, recipe deviation, material variation). [ENUM-REF-CANDIDATE: equipment_drift|recipe_deviation|material_variation|operator_error|environmental_factor|measurement_error|unknown — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause identified during the OCAP investigation, including contributing factors and failure mode analysis.',
    `spc_rule_violated` STRING COMMENT 'Specific SPC rule that was violated and triggered the OCAP action (e.g., Western Electric Rule 1, Rule 2, Nelson Rule 1-8).',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of the corrective action (e.g., SPC monitoring, metrology inspection, yield analysis).',
    `verification_result` STRING COMMENT 'Result of the verification activity confirming whether the corrective action successfully resolved the process excursion.. Valid values are `effective|ineffective|partially_effective|pending`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the effectiveness of the corrective action was verified.',
    CONSTRAINT pk_ocap_action PRIMARY KEY(`ocap_action_id`)
) COMMENT 'Out-of-Control Action Plan (OCAP) action record triggered when an SPC rule violation or process excursion is detected. Captures the triggering SPC event reference, OCAP procedure reference, action type (hold lot, notify engineer, adjust recipe, escalate), assigned engineer, action timestamp, resolution description, lot disposition, and root cause classification. Implements the corrective response workflow for process excursions per IATF 16949 and SEMI SPC guidelines.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` (
    `process_technology_node_id` BIGINT COMMENT 'Unique identifier for the semiconductor technology node record. Primary key.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Technology Node Mapping aligns process nodes with product process nodes for the Technology Node Compatibility Matrix.',
    `technology_control_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.technology_control_plan. Business justification: Each technology node has an associated technology control plan that defines access and export controls.',
    `authoritative_fabrication_technology_node_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `fabrication_technology_node_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner fabrication.fabrication_technology_node (resolves MVM SSOT duplicate).',
    `fabrication_technology_node_ref_id` BIGINT COMMENT 'Unique identifier for the fabrication technology node ref record within the process technology node process entity.',
    `application_scope` STRING COMMENT 'Primary application domains or product families this technology node is designed to support (e.g., High Performance Computing, Mobile, Automotive, IoT, AI/ML Accelerators).',
    `baseline_cpk` DECIMAL(18,2) COMMENT 'Baseline process capability index (Cpk) target for critical parameters in this technology node. Cpk measures process capability relative to specification limits.',
    `baseline_yield_target_percent` DECIMAL(18,2) COMMENT 'Target baseline yield percentage (good dies per wafer) for production qualification of this technology node.',
    `beol_layer_count` STRING COMMENT 'Number of process layers in the Back End of Line, covering metal interconnect formation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was first created in the system.',
    `process_technology_node_description` STRING COMMENT 'Detailed textual description of the technology node, including key features, capabilities, and differentiators.',
    `design_rule_complexity` STRING COMMENT 'Complexity level of design rules for this technology node. Higher complexity indicates more restrictive DFM (Design for Manufacturability) constraints and OPC (Optical Proximity Correction) requirements.. Valid values are `low|medium|high|very_high`',
    `device_architecture` STRING COMMENT 'Transistor architecture type used in this technology node. Planar for traditional flat transistors, FinFET (Fin Field-Effect Transistor) for 3D fin structures, GAA (Gate All Around) for next-generation wrap-around gates, nanowire or nanosheet for advanced GAA variants.. Valid values are `planar|finfet|gaa|nanowire|nanosheet`',
    `dram_half_pitch_nm` DECIMAL(18,2) COMMENT 'DRAM half-pitch in nanometers, a key metric for memory density and technology node classification per ITRS standards.',
    `effective_end_date` DATE COMMENT 'Date when this technology node is scheduled to be retired or phased out. Null for active nodes with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this technology node became effective and available for use in production or design activities.',
    `euv_layer_count` STRING COMMENT 'Number of critical layers that use EUV lithography in this technology node. Zero for nodes that do not use EUV.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility (fab) where this technology node is implemented. Multiple fabs may support the same node.',
    `feol_layer_count` STRING COMMENT 'Number of process layers in the Front End of Line, covering transistor formation steps.',
    `gate_pitch_nm` DECIMAL(18,2) COMMENT 'Gate pitch in nanometers, representing the distance between adjacent transistor gates in the Front End of Line (FEOL). Key dimension for transistor density.',
    `introduction_year` STRING COMMENT 'Calendar year when this technology node was first introduced or qualified for production.',
    `is_baseline_node` BOOLEAN COMMENT 'Indicates whether this is the baseline or reference technology node for a given generation. Used for comparison and benchmarking purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was last modified or updated.',
    `lithography_type` STRING COMMENT 'Primary lithography technology used for this node. DUV (Deep Ultraviolet), EUV (Extreme Ultraviolet Lithography), immersion lithography, dry lithography, or e-beam (electron beam) lithography.. Valid values are `duv|euv|immersion|dry|ebeam`',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers in the Back End of Line (BEOL) stack for this technology node.',
    `minimum_metal_pitch_nm` DECIMAL(18,2) COMMENT 'Minimum metal interconnect pitch in nanometers, representing the smallest distance between adjacent metal lines in the Back End of Line (BEOL).',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `node_code` STRING COMMENT 'Standardized alphanumeric code for the technology node used across systems and documentation.',
    `node_generation` STRING COMMENT 'Generation classification of the technology node (e.g., Gen 1, Gen 2, Gen 3, Advanced Node, Mature Node, Legacy Node).',
    `node_name` STRING COMMENT 'Human-readable name of the technology node (e.g., 5nm, 3nm, 7nm, 28nm, 65nm, 90nm). This is the primary business identifier for the process generation.',
    `node_nm` STRING COMMENT 'The node nm of the process technology node record in the process domain.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to this technology node.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer or engineering manager responsible for this technology node definition and maintenance.',
    `owner_organization` STRING COMMENT 'Organization or department responsible for managing and maintaining this technology node (e.g., Process Engineering, Advanced Technology Development).',
    `pdk_version` STRING COMMENT 'Version identifier of the Process Design Kit (PDK) associated with this technology node. PDK contains design rules, device models, and libraries for IC design.',
    `production_readiness_status` STRING COMMENT 'Current production readiness state of the technology node. Research: early R&D phase. Development: active development. Qualification: undergoing process qualification. Pilot: pilot production runs. Production: full production ready. Mature: established high-volume production. EOL (End of Life): being phased out. [ENUM-REF-CANDIDATE: research|development|qualification|pilot|production|mature|eol — 7 candidates stripped; promote to reference product]',
    `qualification_date` DATE COMMENT 'Date when the technology node successfully completed qualification and was approved for production use.',
    `qualification_status` STRING COMMENT 'Current qualification status of the technology node. Tracks progress through formal qualification and approval process.. Valid values are `not_started|in_progress|qualified|production_approved|failed|on_hold`',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the technology_node concept (fabrication.fabrication_technology_node)',
    `supports_multi_patterning` BOOLEAN COMMENT 'Indicates whether this technology node requires or supports multi-patterning lithography techniques (e.g., double patterning, triple patterning, quadruple patterning) to achieve target dimensions.',
    `target_performance_improvement_percent` DECIMAL(18,2) COMMENT 'Target percentage improvement in performance (speed/frequency) compared to the previous technology node generation. Part of PPA (Power Performance Area) metrics.',
    `target_power_efficiency_improvement_percent` DECIMAL(18,2) COMMENT 'Target percentage improvement in power efficiency compared to the previous technology node generation. Part of PPA (Power Performance Area) metrics.',
    `target_transistor_density_per_mm2` DECIMAL(18,2) COMMENT 'Target transistor density in millions of transistors per square millimeter for this technology node. Key metric for comparing node scaling and integration capability.',
    `wavelength_nm` DECIMAL(18,2) COMMENT 'Primary lithography wavelength in nanometers (e.g., 193nm for DUV, 13.5nm for EUV). Critical parameter for resolution and patterning capability.',
    CONSTRAINT pk_process_technology_node PRIMARY KEY(`process_technology_node_id`)
) COMMENT 'Reference master for semiconductor technology nodes (process generations) supported by the fab. Captures node name (e.g., 5nm, 3nm, 28nm, 65nm), node generation, device architecture (planar, FinFET, GAA), minimum metal pitch, gate pitch, DRAM half-pitch, introduction year, production readiness status, and associated PDK version. Serves as the top-level classification anchor for process flows, OPC rule sets, and process capability records.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`excursion` (
    `excursion_id` BIGINT COMMENT 'Primary key for excursion',
    `employee_id` BIGINT COMMENT 'Reference to the process engineer responsible for investigating and resolving this excursion. Links to employee or engineer master data.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the manufacturing equipment where the excursion occurred. Links to equipment master data.',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the specific process step where the excursion was detected. Links to process step master data.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node of the affected product. Links to technology node master data.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the primary wafer lot affected by this excursion. Links to the fabrication wafer lot master data.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Excursions are recorded per IC product to assess impact; required for the Excursion Impact Report.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Excursions on wafers derived from a research project must be logged to the project for risk tracking and corrective action.',
    `affected_die_count` STRING COMMENT 'Estimated total number of die units affected by this excursion. Used for financial impact assessment and customer notification.',
    `affected_lot_count` STRING COMMENT 'Total number of wafer lots affected by this excursion event. Used for impact assessment and containment scope determination.',
    `affected_wafer_count` STRING COMMENT 'Total number of individual wafers affected by this excursion across all lots. Used for yield impact calculation.',
    `containment_action_taken` STRING COMMENT 'Immediate containment actions taken upon excursion detection. Describes steps such as lot hold, equipment quarantine, process parameter adjustment, or rework initiation.',
    `containment_timestamp` TIMESTAMP COMMENT 'Date and time when containment actions were completed. Used to measure response time and containment effectiveness.',
    `corrective_action_reference` STRING COMMENT 'Reference number or identifier for the corrective action plan. Links to the formal corrective and preventive action (CAPA) system or Out-of-Control Action Plan (OCAP) record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this excursion record was first created in the system. Audit trail for record creation.',
    `customer_notification_required` BOOLEAN COMMENT 'Flag indicating whether customer notification is required for this excursion. True if the excursion impacts shipped product or customer-specific quality requirements.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when customer was notified of the excursion. Used for compliance tracking and customer relationship management.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Measured defect density in defects per square centimeter for the affected wafers. Key metric for yield impact assessment.',
    `detection_source` STRING COMMENT 'Source system or method that detected the excursion event. Indicates whether the excursion was identified through Statistical Process Control (SPC), inspection, metrology measurement, electrical test, operator observation, or automated monitoring system.. Valid values are `SPC|inspection|metrology|electrical_test|operator|automated_system`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the excursion was first detected. Represents the business event time of excursion identification.',
    `disposition` STRING COMMENT 'Final disposition decision for the affected material. Determines whether lots are released, reworked, scrapped, returned, or require additional review.. Valid values are `use_as_is|rework|scrap|return_to_vendor|engineering_review|customer_notification`',
    `disposition_timestamp` TIMESTAMP COMMENT 'Date and time when the final disposition decision was made. Marks the completion of the excursion investigation and material release decision.',
    `estimated_financial_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of the excursion in US dollars. Includes scrap cost, rework cost, yield loss, and potential customer claims.',
    `estimated_yield_impact_percent` DECIMAL(18,2) COMMENT 'Estimated percentage point impact on wafer yield due to this excursion. Calculated based on defect density, affected area, and historical correlation data.',
    `excursion_number` STRING COMMENT 'Business identifier for the excursion event. Human-readable reference number used for tracking and communication across engineering teams.',
    `excursion_type` STRING COMMENT 'Classification of the excursion event. Categorizes whether the excursion is due to out-of-specification parameters, out-of-control process conditions, yield loss, excessive defect density, parametric drift, or equipment fault.. Valid values are `out_of_spec|out_of_control|yield_loss|defect_density|parametric_drift|equipment_fault`',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the excursion investigation. Tracks progression from initial detection through root cause analysis to closure.. Valid values are `open|investigating|root_cause_identified|corrective_action_pending|closed|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this excursion record was last updated. Audit trail for tracking investigation progress and status changes.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower control limit from the Statistical Process Control (SPC) chart at the time of excursion detection. Used to determine out-of-control conditions.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual measured value of the parameter that triggered the excursion. Used for root cause analysis and process capability assessment.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the excursion investigation. Captures engineering insights and lessons learned.',
    `owner_organization` STRING COMMENT 'Engineering organization or department responsible for this excursion. Examples include Process Integration, Lithography, Etch, Thin Films, or Metrology.',
    `parameter_name` STRING COMMENT 'Name of the process parameter that triggered the excursion. Examples include critical dimension (CD), film thickness, overlay, resistance, or other measured characteristics.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause. Categories include equipment malfunction, material variation, process recipe issue, human error, environmental condition, or unknown pending investigation.. Valid values are `equipment|material|process|human|environmental|unknown`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause. Captures engineering analysis findings and technical explanation of the excursion mechanism.',
    `severity_level` STRING COMMENT 'Severity classification of the excursion impact. Minor excursions require monitoring, major excursions require corrective action, and critical excursions require immediate containment and investigation.. Valid values are `minor|major|critical`',
    `spc_rule_violated` STRING COMMENT 'Specific Statistical Process Control (SPC) rule that was violated to trigger the excursion. Examples include Western Electric rules, Nelson rules, or custom fab-specific control rules.',
    `specification_lower_limit` DECIMAL(18,2) COMMENT 'Lower specification limit for the parameter. Used to determine out-of-specification conditions and product quality impact.',
    `specification_upper_limit` DECIMAL(18,2) COMMENT 'Upper specification limit for the parameter. Used to determine out-of-specification conditions and product quality impact.',
    `target_value` DECIMAL(18,2) COMMENT 'Target specification value for the parameter. Used to calculate deviation magnitude and assess excursion severity.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the parameter values. Examples include nanometers (nm), angstroms, ohms, degrees Celsius, or other engineering units.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper control limit from the Statistical Process Control (SPC) chart at the time of excursion detection. Used to determine out-of-control conditions.',
    `yield_loss_mode` STRING COMMENT 'Classification of the yield loss mechanism. Parametric indicates parameter drift, systematic indicates repeatable pattern defects, random indicates sporadic defects, electrical indicates functional test failures, none indicates no yield impact detected.. Valid values are `parametric|systematic|random|electrical|none`',
    CONSTRAINT pk_excursion PRIMARY KEY(`excursion_id`)
) COMMENT 'Process excursion record capturing any significant out-of-spec, out-of-control, or yield-impacting condition detected during wafer manufacturing that requires formal engineering investigation. Encompasses all yield loss events as a unified excursion type. Captures excursion detection source (SPC, inspection, metrology, electrical test), affected lot list, process step, excursion severity (minor/major/critical), yield loss mode (parametric, systematic, random, electrical), defect density, affected die count, estimated yield impact, detection timestamp, containment actions taken, root cause category, corrective action reference, investigation status, and final disposition. Serves as the single parent investigation record for all process-related yield and excursion events. Distinct from individual OCAP actions which are the immediate corrective responses. SSOT for process excursion and yield loss tracking; quality domain owns outgoing quality excursions and customer returns.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` (
    `doe_experiment_id` BIGINT COMMENT 'Unique identifier for the DOE experiment record. Primary key for the DOE experiment entity.',
    `employee_id` BIGINT COMMENT 'Reference to the process engineer responsible for designing, executing, and analyzing the DOE experiment.',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the specific process step under study in this DOE experiment (e.g., photolithography, etch, deposition, implant).',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this DOE experiment is being conducted.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: DOE experiments are conducted for a specific IC product; results feed the DOE Results per Product analysis.',
    `process_step_id` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — DOE experiments study specific process steps. The step reference identifies what is being optimized.',
    `actual_completion_date` DATE COMMENT 'Actual date when the DOE experiment was completed, including all runs, analysis, and final reporting.',
    `actual_start_date` DATE COMMENT 'Actual date when the DOE experiment began wafer processing and data collection.',
    `analysis_software` STRING COMMENT 'Software tool or platform used for DOE design and statistical analysis (e.g., JMP, Minitab, Design-Expert, R, Python).',
    `approval_date` DATE COMMENT 'Date when the DOE experiment plan or results were formally approved.',
    `approval_status` STRING COMMENT 'Approval status of the DOE experiment plan and results by management or technical review board.. Valid values are `pending|approved|rejected`',
    `baseline_cpk` DECIMAL(18,2) COMMENT 'Process capability index (Cpk) measured before the DOE experiment, serving as the baseline for comparison.',
    `blocking_factor` STRING COMMENT 'Factor used to group experimental runs into blocks to control for known sources of variation (e.g., different lots, different days, different chambers).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DOE experiment record was first created in the system.',
    `doe_type` STRING COMMENT 'Statistical design methodology used for the experiment. Full factorial explores all factor combinations; fractional factorial reduces runs; RSM optimizes response surfaces; Taguchi focuses on robustness; Plackett-Burman screens many factors efficiently; Central Composite designs for quadratic models.. Valid values are `full_factorial|fractional_factorial|response_surface_methodology|taguchi|plackett_burman|central_composite`',
    `experiment_number` STRING COMMENT 'Business identifier for the DOE experiment, typically a human-readable code used for tracking and reference across engineering teams.',
    `experiment_objective` STRING COMMENT 'Detailed description of the business and technical objectives of the DOE experiment, including the problem statement, hypothesis, and expected outcomes.',
    `experiment_status` STRING COMMENT 'Current lifecycle status of the DOE experiment. Tracks progression from planning through execution to completion. [ENUM-REF-CANDIDATE: planned|in_progress|data_collection|analysis|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `experiment_title` STRING COMMENT 'Descriptive title of the DOE experiment that summarizes the objective and scope of the study.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where the DOE experiment was conducted.',
    `factor_count` STRING COMMENT 'Number of independent variables (factors) being studied in the DOE experiment. Each factor represents a process parameter that may influence the response variables.',
    `factor_levels` STRING COMMENT 'Description of the levels (values) tested for each factor in the experiment. Typically includes low, medium, and high settings or specific numerical values.',
    `factor_list` STRING COMMENT 'Comma-separated list of factors (independent variables) being studied, such as temperature, pressure, dose, time, gas flow rate, power, etc.',
    `interaction_effects` STRING COMMENT 'Description of any significant interaction effects between factors, where the effect of one factor depends on the level of another factor.',
    `key_findings` STRING COMMENT 'Summary of the main conclusions from the DOE experiment, including significant factors, interactions, optimal settings, and process insights.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the DOE experiment record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, observations, or comments related to the DOE experiment, including any deviations from plan, special conditions, or lessons learned.',
    `owner_organization` STRING COMMENT 'Engineering organization or department responsible for the DOE experiment (e.g., Process Integration, Lithography, Etch, Thin Films).',
    `planned_completion_date` DATE COMMENT 'Planned date for the DOE experiment to complete all runs, analysis, and reporting.',
    `planned_start_date` DATE COMMENT 'Planned date for the DOE experiment to begin wafer processing and data collection.',
    `post_doe_cpk` DECIMAL(18,2) COMMENT 'Process capability index (Cpk) measured after implementing the DOE recommendations, demonstrating the improvement achieved.',
    `primary_response_variable` STRING COMMENT 'The main response variable of interest for optimization or characterization in this DOE experiment.',
    `process_capability_improvement` STRING COMMENT 'Quantitative or qualitative assessment of process capability improvement achieved through the DOE experiment, such as Cpk improvement, defect reduction, or yield enhancement.',
    `process_window_lower_limit` STRING COMMENT 'Lower boundary of the acceptable process window for key factors, defining the range within which the process remains stable and meets specifications.',
    `process_window_upper_limit` STRING COMMENT 'Upper boundary of the acceptable process window for key factors, defining the range within which the process remains stable and meets specifications.',
    `recommended_setpoints` STRING COMMENT 'Optimal or recommended process parameter settings derived from the DOE analysis to achieve desired response variable targets.',
    `replication_count` STRING COMMENT 'Number of times each experimental condition is replicated to assess measurement variability and improve statistical power.',
    `response_variable_count` STRING COMMENT 'Number of dependent variables (responses) being measured in the DOE experiment. Response variables are the outcomes being optimized or characterized.',
    `response_variable_list` STRING COMMENT 'Comma-separated list of response variables being measured, such as Critical Dimension (CD), uniformity, defect density, yield, thickness, etch rate, etc.',
    `run_count` STRING COMMENT 'Total number of experimental runs (treatment combinations) planned or executed in the DOE study.',
    `run_order_strategy` STRING COMMENT 'Strategy used to sequence experimental runs. Randomization minimizes bias; blocking controls for known sources of variation; center point replication assesses curvature and repeatability.. Valid values are `randomized|sequential|blocked|center_point_replicated`',
    `significant_factors` STRING COMMENT 'List of factors that were statistically significant in affecting the response variables, based on the analysis results.',
    `statistical_analysis_method` STRING COMMENT 'Statistical techniques applied to analyze the DOE results, such as ANOVA, regression analysis, main effects plots, interaction plots, contour plots, or optimization algorithms.',
    `wafer_count` STRING COMMENT 'Total number of wafers allocated to the DOE experiment across all runs and splits.',
    `wafer_split_plan` STRING COMMENT 'Description of how wafers are allocated across different experimental conditions, including split assignments, replication strategy, and randomization approach.',
    `yield_impact_percent` DECIMAL(18,2) COMMENT 'Estimated or measured impact on wafer yield resulting from the DOE experiment and implementation of recommended changes, expressed as a percentage change.',
    CONSTRAINT pk_doe_experiment PRIMARY KEY(`doe_experiment_id`)
) COMMENT 'Design of Experiments (DOE) record for process optimization and characterization studies. Captures experiment title, process step under study, DOE type (full factorial, fractional factorial, RSM, Taguchi), factors and levels, response variables, wafer split plan, run order, statistical analysis method, key findings, recommended setpoint changes, and process window characterization results. Supports process capability improvement, new technology node development, and recipe optimization.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` (
    `flow_qualification_id` BIGINT COMMENT 'Primary key for the process_flow_qualification association',
    `account_id` BIGINT COMMENT 'Foreign key linking to the customer account',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record within the flow qualification process entity.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Unique identifier for the fabrication technology node record within the flow qualification process entity.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to the process flow definition',
    `achieved_yield_percent` DECIMAL(18,2) COMMENT 'The achieved yield percent of the flow qualification record in the process domain.',
    `actual_completion_date` DATE COMMENT 'The actual completion date associated with the flow qualification process record.',
    `actual_cpk` DECIMAL(18,2) COMMENT 'The actual cpk of the flow qualification record in the process domain.',
    `actual_yield_pct` DECIMAL(18,2) COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'The actual yield percent of the flow qualification record in the process domain.',
    `approval_date` DATE COMMENT 'The approval date associated with the flow qualification process record.',
    `approval_signoff` STRING COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `approved_by` STRING COMMENT 'The approved by of the flow qualification record in the process domain.',
    `baseline_yield_percent` DECIMAL(18,2) COMMENT 'Baseline yield percentage before qualification',
    `completion_date` DATE COMMENT 'The completion date associated with the flow qualification process record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the flow qualification record in the process domain.',
    `customer_approval_date` DATE COMMENT 'The customer approval date associated with the flow qualification process record.',
    `customer_approval_required_flag` BOOLEAN COMMENT 'Whether customer approval is required for this qualification',
    `defect_density_actual` STRING COMMENT 'The defect density actual of the flow qualification record in the process domain.',
    `defect_density_actual_per_cm2` DECIMAL(18,2) COMMENT 'Actual measured defect density per square centimeter',
    `defect_density_target` STRING COMMENT 'The defect density target of the flow qualification record in the process domain.',
    `defect_density_target_per_cm2` DECIMAL(18,2) COMMENT 'The defect density target per cm2 of the flow qualification record in the process domain.',
    `disposition` STRING COMMENT 'The disposition of the flow qualification record in the process domain.',
    `effective_end_date` DATE COMMENT 'Date when the qualification expires or is superseded',
    `effective_start_date` DATE COMMENT 'Date when the qualification becomes effective for the account',
    `environmental_condition` STRING COMMENT 'Environmental conditions during qualification testing',
    `expiry_date` DATE COMMENT 'Enriched attribute for flow_qualification.',
    `failure_mode_summary` STRING COMMENT 'Summary of identified failure modes during qualification',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the flow qualification record in the process domain.',
    `lot_count` STRING COMMENT 'The lot count of the flow qualification record in the process domain.',
    `notes` STRING COMMENT 'The notes of the flow qualification record in the process domain.',
    `owner_organization` STRING COMMENT 'The owner organization of the flow qualification record in the process domain.',
    `qual_completion_date` DATE COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `qual_criteria` STRING COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `qual_lot_count` STRING COMMENT 'Enriched attribute for flow_qualification.',
    `qual_start_date` DATE COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `qualification_date` DATE COMMENT 'The qualification date associated with the flow qualification process record.',
    `qualification_end_date` DATE COMMENT 'The qualification end date associated with the flow qualification process record.',
    `qualification_lot_count` STRING COMMENT 'The qualification lot count of the flow qualification record in the process domain.',
    `qualification_method` STRING COMMENT 'The qualification method of the flow qualification record in the process domain.',
    `qualification_name` STRING COMMENT 'The qualification name of the flow qualification record in the process domain.',
    `qualification_notes` STRING COMMENT 'The qualification notes of the flow qualification record in the process domain.',
    `qualification_number` STRING COMMENT 'The qualification number of the flow qualification record in the process domain.',
    `qualification_owner` STRING COMMENT 'The qualification owner of the flow qualification record in the process domain.',
    `qualification_report_ref` STRING COMMENT 'The qualification report ref of the flow qualification record in the process domain.',
    `qualification_result` STRING COMMENT 'The qualification result of the flow qualification record in the process domain.',
    `qualification_revision` STRING COMMENT 'Revision number of the qualification document',
    `qualification_scope` STRING COMMENT 'Scope of qualification (full flow, partial, delta)',
    `qualification_start_date` DATE COMMENT 'The qualification start date associated with the flow qualification process record.',
    `qualification_status` STRING COMMENT 'Current qualification status of the process flow for the account',
    `qualification_type` STRING COMMENT 'The qualification type of the flow qualification record in the process domain.',
    `qualified_by` STRING COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `qualified_date` DATE COMMENT 'Enriched attribute for flow_qualification.',
    `qualified_lot_count` STRING COMMENT 'The qualified lot count of the flow qualification record in the process domain.',
    `qualifying_engineer` STRING COMMENT 'Enriched attribute for flow_qualification.',
    `reliability_hours` STRING COMMENT 'Total reliability test hours completed',
    `reliability_hours_completed` STRING COMMENT 'The reliability hours completed of the flow qualification record in the process domain.',
    `reliability_hours_required` STRING COMMENT 'The reliability hours required of the flow qualification record in the process domain.',
    `requalification_due_date` DATE COMMENT 'The requalification due date associated with the flow qualification process record.',
    `requalification_trigger` STRING COMMENT 'Condition that triggers requalification (e.g., recipe change, tool change)',
    `risk_level` STRING COMMENT 'Risk classification of the flow qualification (low/medium/high)',
    `sample_size` STRING COMMENT 'Number of samples used in qualification testing',
    `sign_off_date` DATE COMMENT 'Enriched attribute for flow_qualification.',
    `sign_off_engineer_name` STRING COMMENT 'The sign off engineer name of the flow qualification record in the process domain.',
    `start_date` DATE COMMENT 'The start date associated with the flow qualification process record.',
    `statistical_confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level of qualification results (e.g., 95.00)',
    `target_completion_date` DATE COMMENT 'The target completion date associated with the flow qualification process record.',
    `target_cpk` DECIMAL(18,2) COMMENT 'The target cpk of the flow qualification record in the process domain.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target die yield percentage agreed for the account',
    `wafer_count` STRING COMMENT 'The wafer count of the flow qualification record in the process domain.',
    `wafer_qty_completed` STRING COMMENT 'The wafer qty completed of the flow qualification record in the process domain.',
    `wafer_qty_required` STRING COMMENT 'The wafer qty required of the flow qualification record in the process domain.',
    `yield_achieved_percent` DECIMAL(18,2) COMMENT 'The yield achieved percent of the flow qualification record in the process domain.',
    `yield_actual` DECIMAL(18,2) COMMENT 'The yield actual of the flow qualification record in the process domain.',
    `yield_actual_pct` DECIMAL(18,2) COMMENT 'The yield actual pct of the flow qualification record in the process domain.',
    `yield_target` DECIMAL(18,2) COMMENT 'The yield target of the flow qualification record in the process domain.',
    `yield_target_pct` DECIMAL(18,2) COMMENT 'Added in v2 to expand attribute depth for thin product.',
    CONSTRAINT pk_flow_qualification PRIMARY KEY(`flow_qualification_id`)
) COMMENT 'This association product records the qualification of a semiconductor process flow for a specific customer account. It captures qualification status, target yield, and the effective date range for each customer‑process flow pairing.. Existence Justification: Customers (accounts) qualify for specific semiconductor process flows. Each qualification record captures the qualification status, target yield, and the effective date range, and a single process flow can be qualified for many customers while a customer can be qualified for many process flows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` (
    `process_supply_agreement_id` BIGINT COMMENT 'Primary key',
    `fabrication_technology_node_id` BIGINT COMMENT 'FK to fabrication technology node',
    `process_flow_id` BIGINT COMMENT 'FK to process flow',
    `process_step_id` BIGINT COMMENT 'FK to process step',
    `sourcing_contract_id` BIGINT COMMENT 'FK to sourcing contract',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `agreement_end_date` DATE COMMENT 'The agreement end date associated with the process supply agreement process record.',
    `agreement_name` STRING COMMENT 'The agreement name of the process supply agreement record in the process domain.',
    `agreement_number` STRING COMMENT 'The agreement number of the process supply agreement record in the process domain.',
    `agreement_start_date` DATE COMMENT 'The agreement start date associated with the process supply agreement process record.',
    `agreement_status` STRING COMMENT 'The agreement status of the process supply agreement record in the process domain.',
    `agreement_type` STRING COMMENT 'The agreement type of the process supply agreement record in the process domain.',
    `capacity_allocation_pct` DECIMAL(18,2) COMMENT 'Capacity allocation percentage',
    `capacity_commitment` DECIMAL(18,2) COMMENT 'The capacity commitment of the process supply agreement record in the process domain.',
    `capacity_reservation` DECIMAL(18,2) COMMENT 'The capacity reservation of the process supply agreement record in the process domain.',
    `capacity_reservation_pct` DECIMAL(18,2) COMMENT 'Capacity reservation percentage',
    `committed_capacity_pct` DECIMAL(18,2) COMMENT 'Committed capacity percentage',
    `committed_capacity_percent` DECIMAL(18,2) COMMENT 'The committed capacity percent of the process supply agreement record in the process domain.',
    `committed_volume` DECIMAL(18,2) COMMENT 'The committed volume of the process supply agreement record in the process domain.',
    `committed_volume_units` STRING COMMENT 'Committed volume in units',
    `committed_volume_wafers` STRING COMMENT 'Committed volume in wafers',
    `committed_wafer_volume` STRING COMMENT 'The committed wafer volume of the process supply agreement record in the process domain.',
    `contract_number` STRING COMMENT 'The contract number of the process supply agreement record in the process domain.',
    `created_at` TIMESTAMP COMMENT 'Created at timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency` STRING COMMENT 'The currency of the process supply agreement record in the process domain.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the process supply agreement process record.',
    `delivery_terms` STRING COMMENT 'The delivery terms of the process supply agreement record in the process domain.',
    `effective_date` DATE COMMENT 'The effective date associated with the process supply agreement process record.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the process supply agreement process record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the process supply agreement process record.',
    `end_date` DATE COMMENT 'The end date associated with the process supply agreement process record.',
    `expiration_date` DATE COMMENT 'The expiration date associated with the process supply agreement process record.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the process supply agreement process record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the process supply agreement record in the process domain.',
    `lead_time_days` STRING COMMENT 'Lead time in days',
    `lead_time_weeks` STRING COMMENT 'Lead time in weeks',
    `material_category` STRING COMMENT 'The material category of the process supply agreement record in the process domain.',
    `min_order_quantity` STRING COMMENT 'Minimum order quantity',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the process supply agreement record in the process domain.',
    `notes` STRING COMMENT 'General notes',
    `owner_organization` STRING COMMENT 'The owner organization of the process supply agreement record in the process domain.',
    `payment_terms` STRING COMMENT 'The payment terms of the process supply agreement record in the process domain.',
    `penalty_clause_flag` BOOLEAN COMMENT 'The penalty clause flag of the process supply agreement record in the process domain.',
    `price_currency` STRING COMMENT 'The price currency of the process supply agreement record in the process domain.',
    `price_per_unit` STRING COMMENT 'The price per unit of the process supply agreement record in the process domain.',
    `price_per_wafer` DECIMAL(18,2) COMMENT 'The price per wafer of the process supply agreement record in the process domain.',
    `price_terms` STRING COMMENT 'The price terms of the process supply agreement record in the process domain.',
    `pricing_terms` STRING COMMENT 'The pricing terms of the process supply agreement record in the process domain.',
    `process_supply_agreement_status` STRING COMMENT 'Current status',
    `qualification_status` STRING COMMENT 'The qualification status of the process supply agreement record in the process domain.',
    `quality_spec_reference` STRING COMMENT 'The quality spec reference of the process supply agreement record in the process domain.',
    `renewal_clause` STRING COMMENT 'The renewal clause of the process supply agreement record in the process domain.',
    `renewal_terms` STRING COMMENT 'The renewal terms of the process supply agreement record in the process domain.',
    `signed_by` STRING COMMENT 'Person who signed the agreement',
    `signed_date` DATE COMMENT 'The signed date associated with the process supply agreement process record.',
    `start_date` DATE COMMENT 'The start date associated with the process supply agreement process record.',
    `take_or_pay_flag` BOOLEAN COMMENT 'The take or pay flag of the process supply agreement record in the process domain.',
    `termination_clause` STRING COMMENT 'Termination clause details',
    `terms_notes` STRING COMMENT 'Notes on terms',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the process supply agreement record in the process domain.',
    `updated_at` TIMESTAMP COMMENT 'Updated at timestamp',
    `volume_commitment_qty` DECIMAL(18,2) COMMENT 'The volume commitment qty of the process supply agreement record in the process domain.',
    `volume_commitment_units` DECIMAL(18,2) COMMENT 'The volume commitment units of the process supply agreement record in the process domain.',
    `wafer_price_usd` DECIMAL(18,2) COMMENT 'Wafer price in USD',
    `yield_commitment_percent` DECIMAL(18,2) COMMENT 'Yield commitment percentage',
    CONSTRAINT pk_process_supply_agreement PRIMARY KEY(`process_supply_agreement_id`)
) COMMENT 'Represents the contractual relationship between a manufacturing process step and a supplier. Each record links one process_process_step to one supplier and stores contract-specific data such as contract number, lead time, and qualification status.. Existence Justification: A process step can require consumables, tools, or materials from multiple suppliers, and a given supplier can provide those items for many different process steps across multiple process flows. The relationship is managed through supply contracts that capture contract numbers, lead times, and qualification status, and it is actively created and maintained by procurement and engineering teams.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` (
    `process_site_map_id` BIGINT COMMENT 'Primary key for site_map',
    `equipment_site_map_id` BIGINT COMMENT 'Cross-domain SSOT reference to authoritative owner equipment.site_map.site_map_id',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id (P16 VREQ-042)',
    `address_line1` STRING COMMENT 'Primary street address of the site.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `capacity` DECIMAL(18,2) COMMENT 'Primary quantitative capacity of the site (e.g., wafers per month).',
    `capacity_unit` STRING COMMENT 'Unit of measure for the site capacity.',
    `city` STRING COMMENT 'City where the site is located.',
    `closing_date` DATE COMMENT 'Date the site was decommissioned or ceased operations (nullable).',
    `compliance_classification` STRING COMMENT 'Regulatory compliance category applicable to the site (e.g., ISO‑9001, CMMC).',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the site.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the system.',
    `data_classification` STRING COMMENT 'Overall data classification for records originating from this site.',
    `effective_from` DATE COMMENT 'Date from which the site record is considered valid for reporting.',
    `effective_until` DATE COMMENT 'Date until which the site record remains valid (nullable for open‑ended).',
    `is_primary_site` BOOLEAN COMMENT 'Indicates whether this site is the primary manufacturing location for its product line.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the site in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the site in decimal degrees.',
    `manager_email` STRING COMMENT 'Email address of the site manager.',
    `manager_name` STRING COMMENT 'Full name of the primary manager responsible for the site.',
    `manager_phone` STRING COMMENT 'Contact phone number of the site manager.',
    `measurement_site_count` STRING COMMENT 'The measurement site count of the process site map record in the process domain.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `opening_date` DATE COMMENT 'Date the site became operational.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address.',
    `region` STRING COMMENT 'Higher‑level geographic region (e.g., APAC, EMEA, Americas).',
    `security_level` STRING COMMENT 'Security classification of the site (e.g., public, confidential, restricted).',
    `site_code` STRING COMMENT 'Business identifier code assigned to the site (e.g., FAB01, RND‑NY).',
    `site_count` STRING COMMENT 'The site count of the process site map record in the process domain.',
    `site_map_code` STRING COMMENT 'Coded value representing the site map code of the process site map process record.',
    `site_map_description` STRING COMMENT 'Free‑form description providing additional context about the site.',
    `site_map_name` STRING COMMENT 'The site map name of the process site map record in the process domain.',
    `site_map_status` STRING COMMENT 'Current lifecycle status of the site.',
    `site_name` STRING COMMENT 'Human‑readable name of the manufacturing or corporate site.',
    `site_type` STRING COMMENT 'Category of the site indicating its primary function.',
    `state_province` STRING COMMENT 'State or province of the site location.',
    `sub_region` STRING COMMENT 'More granular region within the main region (e.g., West Coast, Southeast Asia).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    `wafer_size_mm` STRING COMMENT 'The wafer size mm of the process site map record in the process domain.',
    CONSTRAINT pk_process_site_map PRIMARY KEY(`process_site_map_id`)
) COMMENT 'Master reference table for site_map. Referenced by site_map_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` (
    `process_spc_control_plan_id` BIGINT COMMENT 'Primary key for spc_control_plan',
    `employee_id` BIGINT COMMENT 'Identifier of the operator responsible for executing the plan.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Unique identifier for the fabrication technology node record within the process spc control plan process entity.',
    `primary_authoritative_spc_control_plan_id` BIGINT COMMENT 'Authoritative cross-domain reference for spc_control_plan; SSOT owner is process.spc_control_plan',
    `control_plan_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner process.spc_control_plan (resolves MVM SSOT duplicate).',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan was approved.',
    `approved_by` STRING COMMENT 'Name of the person who approved the current version of the plan.',
    `capability_index_cp_k` DECIMAL(18,2) COMMENT 'Calculated Cpk value indicating process capability.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level used for control limits.',
    `control_chart_type` STRING COMMENT 'Type of SPC chart used (if more than 6 types, consider reference product).',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'Statistical lower control limit for the monitored measurement.',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'Statistical upper control limit for the monitored measurement.',
    `control_plan_code` STRING COMMENT 'Coded value representing the control plan code of the process spc control plan process record.',
    `control_plan_name` STRING COMMENT 'The control plan name of the process spc control plan record in the process domain.',
    `control_plan_status` STRING COMMENT 'The control plan status of the process spc control plan record in the process domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control plan record was first created in the system.',
    `data_source` STRING COMMENT 'Origin of the measurement data feeding the control plan.',
    `deprecation_date` DATE COMMENT 'Date when the plan was officially deprecated.',
    `deprecation_reason` STRING COMMENT 'Reason for deprecating the control plan.',
    `effective_end_date` DATE COMMENT 'Date when the SPC control plan is retired or expires (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the SPC control plan becomes active.',
    `equipment_identifier` STRING COMMENT 'Identifier of the equipment (e.g., tool ID) used for the measurement.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the plan is considered critical for product quality.',
    `last_review_date` DATE COMMENT 'Date when the control plan was last reviewed for relevance.',
    `lot_size` STRING COMMENT 'Number of wafers in a production lot governed by this plan.',
    `measurement_frequency` STRING COMMENT 'Frequency at which measurements are taken.',
    `measurement_name` STRING COMMENT 'Name of the process metric being controlled (e.g., film thickness, CD).',
    `measurement_unit` STRING COMMENT 'Unit of measure for the monitored metric.',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the control plan.',
    `plan_code` STRING COMMENT 'Business identifier code used to reference the SPC control plan across systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the SPC control plan.',
    `plan_type` STRING COMMENT 'Classification of the plan indicating its purpose or origin.',
    `process_step` STRING COMMENT 'Manufacturing step to which the control plan applies (e.g., lithography, etch).',
    `review_status` STRING COMMENT 'Current status of the most recent plan review.',
    `rule_set_name` STRING COMMENT 'Name of the SPC rule set applied (e.g., Western Electric).',
    `rule_set_version` STRING COMMENT 'Version identifier for the rule set definition.',
    `sample_size` STRING COMMENT 'Number of units in each statistical sample.',
    `sampling_rate_per_hour` DECIMAL(18,2) COMMENT 'Number of samples collected per hour for the measurement.',
    `spc_control_plan_description` STRING COMMENT 'Detailed free‑text description of the plans intent and scope.',
    `spc_control_plan_status` STRING COMMENT 'Current lifecycle status of the SPC control plan.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the spc_control_plan concept (fabrication.spc_control_plan)',
    `target_value` DECIMAL(18,2) COMMENT 'Desired nominal value for the measurement within the control plan.',
    `technology_node_nm` STRING COMMENT 'Target technology node size in nanometers for the plan.',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Maximum acceptable deviation below the target value.',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Maximum acceptable deviation above the target value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the control plan record.',
    `version_number` STRING COMMENT 'Sequential version number of the control plan.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafer in millimeters for which the plan is defined.',
    `created_by` STRING COMMENT 'User name of the person who initially created the control plan record.',
    CONSTRAINT pk_process_spc_control_plan PRIMARY KEY(`process_spc_control_plan_id`)
) COMMENT 'Master reference table for spc_control_plan. Referenced by spc_control_plan_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` (
    `metrology_plan_id` BIGINT COMMENT 'Primary key for metrology_plan',
    `fabrication_technology_node_id` BIGINT COMMENT 'Unique identifier for the fabrication technology node record within the metrology plan process entity.',
    `superseded_metrology_plan_id` BIGINT COMMENT 'Self-referencing FK on metrology_plan (superseded_metrology_plan_id)',
    `metrology_plan_code` STRING COMMENT 'Coded value representing the code of the metrology plan process record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the metrology plan record was first created in the system.',
    `metrology_plan_description` STRING COMMENT 'Detailed free‑text description of the plans purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the metrology plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the metrology plan expires or is superseded (null if open‑ended).',
    `frequency_per_day` STRING COMMENT 'Number of times the metrology measurement is performed each day.',
    `is_active` BOOLEAN COMMENT 'The is active of the metrology plan record in the process domain.',
    `last_modified_by` STRING COMMENT 'User or system identifier that performed the most recent modification.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the plan.',
    `measurement_category` STRING COMMENT 'High‑level category of measurements covered (e.g., critical dimension, film thickness, overlay).',
    `measurement_parameter` STRING COMMENT 'The measurement parameter of the metrology plan record in the process domain.',
    `measurement_tool` STRING COMMENT 'Identifier of the equipment used to perform the measurements.',
    `measurement_unit` STRING COMMENT 'Unit of measure used for the primary metrology values.',
    `metrology_type` STRING COMMENT 'The metrology type of the metrology plan record in the process domain.',
    `metrology_plan_name` STRING COMMENT 'The name of the metrology plan record in the process domain.',
    `plan_code` STRING COMMENT 'External code or number used to reference the metrology plan in manufacturing systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the metrology plan.',
    `plan_type` STRING COMMENT 'Category of the plan indicating its purpose (e.g., critical, routine, calibration).',
    `process_step` STRING COMMENT 'Manufacturing process step to which the metrology plan applies (e.g., photolithography, etch, deposition).',
    `qualification_status` STRING COMMENT 'Current qualification state of the metrology plan.',
    `revision_number` STRING COMMENT 'Incremental revision identifier for version control of the plan.',
    `target_technology_node` STRING COMMENT 'Technology node (e.g., 7nm, 5nm, 3nm) for which the plan is defined.',
    `target_wafer_size` STRING COMMENT 'Wafer size the plan is intended for (e.g., 300mm, 200mm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the metrology plan record.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_metrology_plan PRIMARY KEY(`metrology_plan_id`)
) COMMENT 'Master reference table for metrology_plan. Referenced by metrology_plan_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` (
    `sampling_plan_id` BIGINT COMMENT 'Primary key for sampling_plan',
    `process_flow_id` BIGINT COMMENT 'FK to process.process_flow.process_flow_id (P14 VREQ-040)',
    `superseded_sampling_plan_id` BIGINT COMMENT 'Self-referencing FK on sampling_plan (superseded_sampling_plan_id)',
    `approval_date` DATE COMMENT 'Date when the sampling plan was formally approved.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the sampling plan.',
    `sampling_plan_code` STRING COMMENT 'Coded value representing the code of the sampling plan process record.',
    `compliance_regulation` STRING COMMENT 'Regulatory or industry standard that the sampling plan adheres to.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'Lower statistical control limit for the target metric.',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'Upper statistical control limit for the target metric.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sampling plan record was first created in the system.',
    `sampling_plan_description` STRING COMMENT 'Detailed textual description of the sampling plan purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the sampling plan expires or is superseded (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the sampling plan becomes binding.',
    `is_active` BOOLEAN COMMENT 'The is active of the sampling plan record in the process domain.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the sampling plan is considered critical for product quality.',
    `last_executed_by` STRING COMMENT 'Operator who most recently executed the sampling plan.',
    `last_executed_date` DATE COMMENT 'Most recent date the sampling plan was executed.',
    `lot_size` STRING COMMENT 'Number of wafers or units in a production lot covered by the plan.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target metric (e.g., nm, µm, percent).',
    `model_lineage_source` STRING COMMENT 'System of record lineage tag for v2 rebuild normalization.',
    `sampling_plan_name` STRING COMMENT 'The name of the sampling plan record in the process domain.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the sampling plan.',
    `operator` STRING COMMENT 'Name of the primary operator responsible for executing the plan.',
    `plan_code` STRING COMMENT 'Business identifier code assigned to the sampling plan.',
    `plan_name` STRING COMMENT 'Human‑readable name of the sampling plan.',
    `plan_type` STRING COMMENT 'Category of the plan (e.g., Statistical Process Control, Manufacturing Readiness Level, OPC rule set, MEEF parameter, Qualification).',
    `qualification_status` STRING COMMENT 'Current qualification state of the sampling plan.',
    `revision_number` STRING COMMENT 'Sequential revision identifier for the sampling plan.',
    `sample_frequency` STRING COMMENT 'How often the sampling plan is applied.',
    `sample_rate_percent` DECIMAL(18,2) COMMENT 'The sample rate percent of the sampling plan record in the process domain.',
    `sample_size` STRING COMMENT 'Number of units to be sampled per execution of the plan.',
    `sampling_method` STRING COMMENT 'Method used to select units for measurement.',
    `sampling_plan_status` STRING COMMENT 'Current lifecycle status of the sampling plan.',
    `sampling_rate_percent` DECIMAL(18,2) COMMENT 'The sampling rate percent of the sampling plan record in the process domain.',
    `target_metric` STRING COMMENT 'Process metric that the sampling plan monitors (e.g., critical dimension, film thickness).',
    `technology_node` STRING COMMENT 'Process technology node associated with the plan (e.g., 7nm, 5nm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sampling plan record.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafer in millimetres for which the plan applies.',
    CONSTRAINT pk_sampling_plan PRIMARY KEY(`sampling_plan_id`)
) COMMENT 'Master reference table for sampling_plan. Referenced by sampling_plan_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` (
    `inspection_point_id` BIGINT COMMENT 'Primary key for inspection_point',
    `process_step_id` BIGINT COMMENT 'Unique identifier for the process step record within the inspection point process entity.',
    `upstream_inspection_point_id` BIGINT COMMENT 'Self-referencing FK on inspection_point (upstream_inspection_point_id)',
    `classification` STRING COMMENT 'Classification indicating regulatory or quality requirement level.',
    `inspection_point_code` STRING COMMENT 'Unique alphanumeric code used to identify the inspection point within the manufacturing system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection point record was created in the system.',
    `data_source_system` STRING COMMENT 'Source system that provides the inspection point definition (e.g., MES, SPC).',
    `effective_from` DATE COMMENT 'Date from which the inspection point becomes effective for use.',
    `effective_until` DATE COMMENT 'Date after which the inspection point is no longer valid (nullable).',
    `equipment_name` STRING COMMENT 'Name of the equipment or tool used for the inspection.',
    `inspection_frequency` STRING COMMENT 'Frequency at which inspections are performed at this point.',
    `inspection_method` STRING COMMENT 'Method by which the inspection is performed.',
    `inspection_point_status` STRING COMMENT 'Current lifecycle status of the inspection point.',
    `inspection_type` STRING COMMENT 'Category of inspection performed at this point.',
    `is_active` BOOLEAN COMMENT 'The is active of the inspection point record in the process domain.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the inspection point is critical for yield or safety.',
    `last_calibrated_date` DATE COMMENT 'Date when the inspection equipment was last calibrated.',
    `location` STRING COMMENT 'Physical location within the fab (e.g., line, bay, zone).',
    `measurement_type` STRING COMMENT 'Physical measurement type captured during inspection.',
    `inspection_point_name` STRING COMMENT 'Human‑readable name of the inspection point.',
    `notes` STRING COMMENT 'Free‑text comments or observations about the inspection point.',
    `process_stage` STRING COMMENT 'Manufacturing process stage (e.g., lithography, etch, diffusion) where the inspection occurs.',
    `sampling_frequency` STRING COMMENT 'The sampling frequency of the inspection point record in the process domain.',
    `target_value` DECIMAL(18,2) COMMENT 'Target value for the primary measurement at this inspection point.',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Lower tolerance limit for the target measurement.',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Upper tolerance limit for the target measurement.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the target and tolerance values.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection point record.',
    `version` STRING COMMENT 'Version identifier for the inspection point definition.',
    CONSTRAINT pk_inspection_point PRIMARY KEY(`inspection_point_id`)
) COMMENT 'Master reference table for inspection_point. Referenced by inspection_point_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` (
    `cooling_process_flow_id` BIGINT COMMENT 'Unique identifier for the cooling process flow record within the cooling process flow process entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the cooling created by employee record within the cooling process flow process entity.',
    `cooling_employee_id` BIGINT COMMENT 'Unique identifier for the cooling employee record within the cooling process flow process entity.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Unique identifier for the fabrication technology node record within the cooling process flow process entity.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the owner org unit record within the cooling process flow process entity.',
    `process_flow_id` BIGINT COMMENT 'Unique identifier for the process flow record within the cooling process flow process entity.',
    `cooling_condition_id` BIGINT COMMENT 'Unique identifier for the cooling condition record within the cooling process flow process entity.',
    `baseline_energy_consumption_kwh` DECIMAL(18,2) COMMENT 'The baseline energy consumption kwh of the cooling process flow record in the process domain.',
    `closed_loop_recirculation_flag` BOOLEAN COMMENT 'The closed loop recirculation flag of the cooling process flow record in the process domain.',
    `co2_reduction_kg` DECIMAL(18,2) COMMENT 'The co2 reduction kg of the cooling process flow record in the process domain.',
    `cool_optimization_enabled` BOOLEAN COMMENT 'The cool optimization enabled of the cooling process flow record in the process domain.',
    `cool_optimization_mode` STRING COMMENT 'The cool optimization mode of the cooling process flow record in the process domain.',
    `cool_optimization_objective` STRING COMMENT 'The cool optimization objective of the cooling process flow record in the process domain.',
    `coolant_recovery_target_percent` DECIMAL(18,2) COMMENT 'The coolant recovery target percent of the cooling process flow record in the process domain.',
    `coolant_type` STRING COMMENT 'The coolant type of the cooling process flow record in the process domain.',
    `cooling_stage_count` STRING COMMENT 'The cooling stage count of the cooling process flow record in the process domain.',
    `cooling_step_count` STRING COMMENT 'The cooling step count of the cooling process flow record in the process domain.',
    `cooling_strategy` STRING COMMENT 'The cooling strategy of the cooling process flow record in the process domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the cooling process flow record in the process domain.',
    `cycle_time_sec` DECIMAL(18,2) COMMENT 'The cycle time sec of the cooling process flow record in the process domain.',
    `effective_date` DATE COMMENT 'The effective date associated with the cooling process flow process record.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the cooling process flow process record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the cooling process flow process record.',
    `energy_efficiency_rating` STRING COMMENT 'The energy efficiency rating of the cooling process flow record in the process domain.',
    `energy_efficiency_target_percent` DECIMAL(18,2) COMMENT 'The energy efficiency target percent of the cooling process flow record in the process domain.',
    `energy_savings_target_percent` DECIMAL(18,2) COMMENT 'The energy savings target percent of the cooling process flow record in the process domain.',
    `estimated_energy_savings_kwh` DECIMAL(18,2) COMMENT 'The estimated energy savings kwh of the cooling process flow record in the process domain.',
    `flow_code` STRING COMMENT 'Coded value representing the flow code of the cooling process flow process record.',
    `flow_description` STRING COMMENT 'The flow description of the cooling process flow record in the process domain.',
    `flow_name` STRING COMMENT 'The flow name of the cooling process flow record in the process domain.',
    `flow_revision` STRING COMMENT 'The flow revision of the cooling process flow record in the process domain.',
    `flow_status` STRING COMMENT 'The flow status of the cooling process flow record in the process domain.',
    `flow_version` STRING COMMENT 'The flow version of the cooling process flow record in the process domain.',
    `is_baseline_flow` BOOLEAN COMMENT 'The is baseline flow of the cooling process flow record in the process domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the cooling process flow record in the process domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the cooling process flow record in the process domain.',
    `notes` STRING COMMENT 'The notes of the cooling process flow record in the process domain.',
    `optimization_method` STRING COMMENT 'The optimization method of the cooling process flow record in the process domain.',
    `optimization_objective` STRING COMMENT 'The optimization objective of the cooling process flow record in the process domain.',
    `optimization_target` STRING COMMENT 'The optimization target of the cooling process flow record in the process domain.',
    `optimized_energy_consumption_kwh` DECIMAL(18,2) COMMENT 'The optimized energy consumption kwh of the cooling process flow record in the process domain.',
    `owner_organization` STRING COMMENT 'The owner organization of the cooling process flow record in the process domain.',
    `primary_coolant_type` STRING COMMENT 'The primary coolant type of the cooling process flow record in the process domain.',
    `qualification_date` DATE COMMENT 'The qualification date associated with the cooling process flow process record.',
    `qualification_status` STRING COMMENT 'The qualification status of the cooling process flow record in the process domain.',
    `sequence_order` STRING COMMENT 'The sequence order of the cooling process flow record in the process domain.',
    `target_energy_savings_kwh` DECIMAL(18,2) COMMENT 'The target energy savings kwh of the cooling process flow record in the process domain.',
    `target_exit_temperature_celsius` DECIMAL(18,2) COMMENT 'The target exit temperature celsius of the cooling process flow record in the process domain.',
    `thermal_budget_c_sec` DECIMAL(18,2) COMMENT 'The thermal budget c sec of the cooling process flow record in the process domain.',
    `total_coolant_consumption_lpm` DECIMAL(18,2) COMMENT 'The total coolant consumption lpm of the cooling process flow record in the process domain.',
    `total_coolant_flow_lpm` DECIMAL(18,2) COMMENT 'The total coolant flow lpm of the cooling process flow record in the process domain.',
    `total_cooling_step_count` STRING COMMENT 'The total cooling step count of the cooling process flow record in the process domain.',
    `waste_elimination_method` STRING COMMENT 'The waste elimination method of the cooling process flow record in the process domain.',
    `waste_elimination_strategy` STRING COMMENT 'The waste elimination strategy of the cooling process flow record in the process domain.',
    `waste_heat_recovery_efficiency_percent` DECIMAL(18,2) COMMENT 'The waste heat recovery efficiency percent of the cooling process flow record in the process domain.',
    `waste_heat_recovery_enabled` BOOLEAN COMMENT 'The waste heat recovery enabled of the cooling process flow record in the process domain.',
    `waste_heat_recovery_target_kwh` DECIMAL(18,2) COMMENT 'The waste heat recovery target kwh of the cooling process flow record in the process domain.',
    `waste_reduction_target_percent` DECIMAL(18,2) COMMENT 'The waste reduction target percent of the cooling process flow record in the process domain.',
    CONSTRAINT pk_cooling_process_flow PRIMARY KEY(`cooling_process_flow_id`)
) COMMENT 'Cooling process flow with waste elimination and cool optimization options.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` (
    `cooling_condition_id` BIGINT COMMENT 'Unique identifier for the cooling condition record within the cooling condition process entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the created by employee record within the cooling condition process entity.',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier for the fab tool record within the cooling condition process entity.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Unique identifier for the fabrication technology node record within the cooling condition process entity.',
    `substance_inventory_id` BIGINT COMMENT 'Unique identifier for the substance inventory record within the cooling condition process entity.',
    `ambient_humidity_pct` DECIMAL(18,2) COMMENT 'The ambient humidity pct of the cooling condition record in the process domain.',
    `backside_helium_pressure_torr` DECIMAL(18,2) COMMENT 'The backside helium pressure torr of the cooling condition record in the process domain.',
    `chamber_pressure_torr` DECIMAL(18,2) COMMENT 'The chamber pressure torr of the cooling condition record in the process domain.',
    `chiller_setpoint_celsius` DECIMAL(18,2) COMMENT 'The chiller setpoint celsius of the cooling condition record in the process domain.',
    `condition_code` STRING COMMENT 'Coded value representing the condition code of the cooling condition process record.',
    `condition_name` STRING COMMENT 'The condition name of the cooling condition record in the process domain.',
    `cool_optimization_enabled` BOOLEAN COMMENT 'The cool optimization enabled of the cooling condition record in the process domain.',
    `cool_optimization_mode` STRING COMMENT 'The cool optimization mode of the cooling condition record in the process domain.',
    `cool_optimization_strategy` STRING COMMENT 'The cool optimization strategy of the cooling condition record in the process domain.',
    `cool_optimization_target_percent` DECIMAL(18,2) COMMENT 'The cool optimization target percent of the cooling condition record in the process domain.',
    `coolant_flow_rate` DECIMAL(18,2) COMMENT 'The coolant flow rate of the cooling condition record in the process domain.',
    `coolant_flow_rate_lpm` DECIMAL(18,2) COMMENT 'The coolant flow rate lpm of the cooling condition record in the process domain.',
    `coolant_inlet_temperature_celsius` DECIMAL(18,2) COMMENT 'The coolant inlet temperature celsius of the cooling condition record in the process domain.',
    `coolant_outlet_temperature_celsius` DECIMAL(18,2) COMMENT 'The coolant outlet temperature celsius of the cooling condition record in the process domain.',
    `coolant_recirculation_flag` BOOLEAN COMMENT 'The coolant recirculation flag of the cooling condition record in the process domain.',
    `coolant_recovery_percent` DECIMAL(18,2) COMMENT 'The coolant recovery percent of the cooling condition record in the process domain.',
    `coolant_recycle_percent` DECIMAL(18,2) COMMENT 'The coolant recycle percent of the cooling condition record in the process domain.',
    `coolant_type` STRING COMMENT 'The coolant type of the cooling condition record in the process domain.',
    `cooling_method` STRING COMMENT 'The cooling method of the cooling condition record in the process domain.',
    `cooling_rate_celsius_per_minute` DECIMAL(18,2) COMMENT 'The cooling rate celsius per minute of the cooling condition record in the process domain.',
    `cooling_rate_celsius_per_second` DECIMAL(18,2) COMMENT 'The cooling rate celsius per second of the cooling condition record in the process domain.',
    `cooling_time_seconds` DECIMAL(18,2) COMMENT 'The cooling time seconds of the cooling condition record in the process domain.',
    `created_date` DATE COMMENT 'The created date associated with the cooling condition process record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the cooling condition record in the process domain.',
    `cooling_condition_description` STRING COMMENT 'The description of the cooling condition record in the process domain.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the cooling condition process record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the cooling condition process record.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'The energy consumption kwh of the cooling condition record in the process domain.',
    `energy_efficiency_ratio` DECIMAL(18,2) COMMENT 'The energy efficiency ratio of the cooling condition record in the process domain.',
    `energy_efficiency_target_percent` DECIMAL(18,2) COMMENT 'The energy efficiency target percent of the cooling condition record in the process domain.',
    `heat_load_watts` DECIMAL(18,2) COMMENT 'The heat load watts of the cooling condition record in the process domain.',
    `hold_time_sec` DECIMAL(18,2) COMMENT 'The hold time sec of the cooling condition record in the process domain.',
    `inlet_temperature_celsius` DECIMAL(18,2) COMMENT 'The inlet temperature celsius of the cooling condition record in the process domain.',
    `is_baseline_condition` BOOLEAN COMMENT 'The is baseline condition of the cooling condition record in the process domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the cooling condition record in the process domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the cooling condition record in the process domain.',
    `notes` STRING COMMENT 'The notes of the cooling condition record in the process domain.',
    `optimization_achieved_percent` DECIMAL(18,2) COMMENT 'The optimization achieved percent of the cooling condition record in the process domain.',
    `optimization_mode` STRING COMMENT 'The optimization mode of the cooling condition record in the process domain.',
    `optimization_status` STRING COMMENT 'The optimization status of the cooling condition record in the process domain.',
    `outlet_temperature_celsius` DECIMAL(18,2) COMMENT 'The outlet temperature celsius of the cooling condition record in the process domain.',
    `owner_organization` STRING COMMENT 'The owner organization of the cooling condition record in the process domain.',
    `qualification_date` DATE COMMENT 'The qualification date associated with the cooling condition process record.',
    `qualification_status` STRING COMMENT 'The qualification status of the cooling condition record in the process domain.',
    `ramp_rate_c_per_min` DECIMAL(18,2) COMMENT 'The ramp rate c per min of the cooling condition record in the process domain.',
    `target_chuck_temperature_celsius` DECIMAL(18,2) COMMENT 'The target chuck temperature celsius of the cooling condition record in the process domain.',
    `target_temperature_c` DECIMAL(18,2) COMMENT 'The target temperature c of the cooling condition record in the process domain.',
    `target_temperature_celsius` DECIMAL(18,2) COMMENT 'The target temperature celsius of the cooling condition record in the process domain.',
    `temperature_tolerance_c` DECIMAL(18,2) COMMENT 'The temperature tolerance c of the cooling condition record in the process domain.',
    `temperature_tolerance_celsius` DECIMAL(18,2) COMMENT 'The temperature tolerance celsius of the cooling condition record in the process domain.',
    `version_number` STRING COMMENT 'The version number of the cooling condition record in the process domain.',
    `waste_coolant_volume_liters` DECIMAL(18,2) COMMENT 'The waste coolant volume liters of the cooling condition record in the process domain.',
    `waste_disposal_classification` STRING COMMENT 'The waste disposal classification of the cooling condition record in the process domain.',
    `waste_elimination_method` STRING COMMENT 'The waste elimination method of the cooling condition record in the process domain.',
    `waste_heat_recovered_kwh` DECIMAL(18,2) COMMENT 'The waste heat recovered kwh of the cooling condition record in the process domain.',
    `waste_heat_recovery_enabled` BOOLEAN COMMENT 'The waste heat recovery enabled of the cooling condition record in the process domain.',
    `waste_heat_recovery_flag` BOOLEAN COMMENT 'The waste heat recovery flag of the cooling condition record in the process domain.',
    `waste_reduction_percent` DECIMAL(18,2) COMMENT 'The waste reduction percent of the cooling condition record in the process domain.',
    CONSTRAINT pk_cooling_condition PRIMARY KEY(`cooling_condition_id`)
) COMMENT 'Cooling process condition covering coolant, waste heat elimination and cool optimization options.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ADD CONSTRAINT `fk_process_process_flow_cooling_condition_id` FOREIGN KEY (`cooling_condition_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`cooling_condition`(`cooling_condition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ADD CONSTRAINT `fk_process_process_flow_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_cooling_condition_id` FOREIGN KEY (`cooling_condition_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`cooling_condition`(`cooling_condition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_metrology_plan_id` FOREIGN KEY (`metrology_plan_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`metrology_plan`(`metrology_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_process_spc_control_plan_id` FOREIGN KEY (`process_spc_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_spc_control_plan`(`process_spc_control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ADD CONSTRAINT `fk_process_process_step_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_cooling_condition_id` FOREIGN KEY (`cooling_condition_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`cooling_condition`(`cooling_condition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_cooling_condition_id` FOREIGN KEY (`cooling_condition_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`cooling_condition`(`cooling_condition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_primary_lot_recipe_id` FOREIGN KEY (`primary_lot_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ADD CONSTRAINT `fk_process_meef_parameter_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ADD CONSTRAINT `fk_process_process_qualification_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_primary_change_process_flow_id` FOREIGN KEY (`primary_change_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_inspection_point_id` FOREIGN KEY (`inspection_point_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`inspection_point`(`inspection_point_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ADD CONSTRAINT `fk_process_process_metrology_measurement_process_site_map_id` FOREIGN KEY (`process_site_map_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_site_map`(`process_site_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ADD CONSTRAINT `fk_process_implant_condition_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ADD CONSTRAINT `fk_process_implant_condition_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ADD CONSTRAINT `fk_process_implant_condition_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ADD CONSTRAINT `fk_process_deposition_condition_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ADD CONSTRAINT `fk_process_deposition_condition_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ADD CONSTRAINT `fk_process_etch_condition_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ADD CONSTRAINT `fk_process_litho_condition_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ADD CONSTRAINT `fk_process_litho_condition_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ADD CONSTRAINT `fk_process_ocap_action_spc_measurement_id` FOREIGN KEY (`spc_measurement_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`spc_measurement`(`spc_measurement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ADD CONSTRAINT `fk_process_doe_experiment_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ADD CONSTRAINT `fk_process_flow_qualification_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ADD CONSTRAINT `fk_process_process_supply_agreement_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ADD CONSTRAINT `fk_process_process_supply_agreement_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ADD CONSTRAINT `fk_process_process_spc_control_plan_primary_authoritative_spc_control_plan_id` FOREIGN KEY (`primary_authoritative_spc_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_spc_control_plan`(`process_spc_control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ADD CONSTRAINT `fk_process_metrology_plan_superseded_metrology_plan_id` FOREIGN KEY (`superseded_metrology_plan_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`metrology_plan`(`metrology_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ADD CONSTRAINT `fk_process_sampling_plan_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ADD CONSTRAINT `fk_process_sampling_plan_superseded_sampling_plan_id` FOREIGN KEY (`superseded_sampling_plan_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ADD CONSTRAINT `fk_process_inspection_point_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ADD CONSTRAINT `fk_process_inspection_point_upstream_inspection_point_id` FOREIGN KEY (`upstream_inspection_point_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`inspection_point`(`inspection_point_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ADD CONSTRAINT `fk_process_cooling_process_flow_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ADD CONSTRAINT `fk_process_cooling_process_flow_cooling_condition_id` FOREIGN KEY (`cooling_condition_id`) REFERENCES `vibe_semiconductors_v1`.`process`.`cooling_condition`(`cooling_condition_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`process` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`process` SET TAGS ('dbx_domain' = 'process');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` SET TAGS ('dbx_subdomain' = 'flow_definition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `cooling_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Cooling Condition Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `baseline_cpk` SET TAGS ('dbx_business_glossary_term' = 'Baseline Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `beol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Back End of Line (BEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `cool_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `cooling_step_count` SET TAGS ('dbx_business_glossary_term' = 'Cooling Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `critical_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `process_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `device_family` SET TAGS ('dbx_business_glossary_term' = 'Device Family');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `dfm_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `euv_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Extreme Ultraviolet (EUV) Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `feol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Front End of Line (FEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `flow_for_node` SET TAGS ('dbx_business_glossary_term' = 'Flow For Node');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `flow_revision` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Revision');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `is_baseline_flow` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Flow');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `lithography_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Lithography Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `mol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Middle of Line (MOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `opc_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'development|qualification|qualified|production|deprecated|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `supports_multi_patterning` SET TAGS ('dbx_business_glossary_term' = 'Supports Multi-Patterning');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `total_step_count` SET TAGS ('dbx_business_glossary_term' = 'Total Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_flow` ALTER COLUMN `waste_heat_recovery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovery Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` SET TAGS ('dbx_subdomain' = 'flow_definition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `cooling_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Cooling Condition Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `fab_operator_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Operator Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `metrology_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Plan Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `process_spc_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Plan Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `cooling_target_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Cooling Target Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `cycle_time_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Target (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `dose_target` SET TAGS ('dbx_business_glossary_term' = 'Dose Target');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `energy_target_kev` SET TAGS ('dbx_business_glossary_term' = 'Energy Target (keV)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `is_cooling_step` SET TAGS ('dbx_business_glossary_term' = 'Is Cooling Step');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `is_critical_step` SET TAGS ('dbx_business_glossary_term' = 'Critical Step Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `is_rework_allowed` SET TAGS ('dbx_business_glossary_term' = 'Rework Allowed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `power_setpoint_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Setpoint (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `pressure_setpoint_torr` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `process_category` SET TAGS ('dbx_business_glossary_term' = 'Process Category (FEOL/MOL/BEOL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `process_category` SET TAGS ('dbx_value_regex' = 'feol|mol|beol');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `process_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Time (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|failed|waived');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `step_description` SET TAGS ('dbx_business_glossary_term' = 'Step Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Step Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'active|inactive|development|qualification|deprecated|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `target_cd_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Critical Dimension (CD) Nanometers (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `target_layer` SET TAGS ('dbx_business_glossary_term' = 'Target Layer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `target_thickness_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Target Thickness (Angstrom)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `temperature_setpoint_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `tool_class` SET TAGS ('dbx_business_glossary_term' = 'Tool Class');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_step` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` SET TAGS ('dbx_subdomain' = 'flow_definition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `cooling_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Cooling Condition Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Default Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`recipe` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `cooling_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Cooling Condition Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `primary_lot_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`lot_process_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Process Chamber ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` SET TAGS ('dbx_subdomain' = 'statistical_control');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_control_chart` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` SET TAGS ('dbx_subdomain' = 'statistical_control');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `spc_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Measurement ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `metrology_run_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`spc_measurement` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Control Chart ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` SET TAGS ('dbx_subdomain' = 'statistical_control');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `capability_id` SET TAGS ('dbx_business_glossary_term' = 'Process Capability ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'short_term|long_term|initial|ongoing');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `capability_status` SET TAGS ('dbx_business_glossary_term' = 'Capability Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `capability_status` SET TAGS ('dbx_value_regex' = 'capable|marginal|incapable|not_assessed');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Chart Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_value_regex' = 'xbar_r|xbar_s|individuals|p_chart|c_chart|u_chart');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `cp_index` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `cpk_index` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `mean_value` SET TAGS ('dbx_business_glossary_term' = 'Mean Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `normality_test_result` SET TAGS ('dbx_business_glossary_term' = 'Normality Test Result');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `normality_test_result` SET TAGS ('dbx_value_regex' = 'normal|non_normal|not_tested');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `out_of_control_points` SET TAGS ('dbx_business_glossary_term' = 'Out of Control Points');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `pp_index` SET TAGS ('dbx_business_glossary_term' = 'Process Performance Index (Pp)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `ppk_index` SET TAGS ('dbx_business_glossary_term' = 'Process Performance Index (Ppk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `process_area` SET TAGS ('dbx_value_regex' = 'feol|mol|beol');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `process_layer` SET TAGS ('dbx_business_glossary_term' = 'Process Layer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditional|not_qualified|pending');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `subgroup_size` SET TAGS ('dbx_business_glossary_term' = 'Subgroup Size');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|stable|degrading|insufficient_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`capability` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` SET TAGS ('dbx_subdomain' = 'flow_definition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `assist_feature_rules` SET TAGS ('dbx_business_glossary_term' = 'Assist Feature Rules');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `eda_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `eda_tool_vendor` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Vendor');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `eda_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `illumination_mode` SET TAGS ('dbx_business_glossary_term' = 'Illumination Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|i-line|g-line');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `lithography_wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Wavelength (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `meef_feature_type` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Feature Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `meef_measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Measurement Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `meef_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Pitch (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `meef_target_cd_nm` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Target Critical Dimension (CD) (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `opc_for_node` SET TAGS ('dbx_business_glossary_term' = 'Opc For Node');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `opc_model_type` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Model Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `opc_model_type` SET TAGS ('dbx_value_regex' = 'rule_based|model_based|hybrid|inverse_lithography');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `process_bias_table_reference` SET TAGS ('dbx_business_glossary_term' = 'Process Bias Table Reference');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `process_window_dof_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Window Depth of Focus (DOF) (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `process_window_el_percent` SET TAGS ('dbx_business_glossary_term' = 'Process Window Exposure Latitude (EL) (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under_qualification|qualified|production|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_file_format` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set File Format');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_file_path` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set File Path');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_name` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `scanner_numerical_aperture` SET TAGS ('dbx_business_glossary_term' = 'Scanner Numerical Aperture (NA)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `sigma_inner` SET TAGS ('dbx_business_glossary_term' = 'Sigma Inner Illumination Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `sigma_outer` SET TAGS ('dbx_business_glossary_term' = 'Sigma Outer Illumination Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`opc_rule_set` ALTER COLUMN `target_layer_name` SET TAGS ('dbx_business_glossary_term' = 'Target Lithography Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` SET TAGS ('dbx_subdomain' = 'flow_definition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `meef_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Parameter ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `application_scope` SET TAGS ('dbx_business_glossary_term' = 'Application Scope');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `cd_target_nm` SET TAGS ('dbx_business_glossary_term' = 'Critical Dimension (CD) Target (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `depth_of_focus_nm` SET TAGS ('dbx_business_glossary_term' = 'Depth of Focus (DOF) (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `exposure_latitude_percent` SET TAGS ('dbx_business_glossary_term' = 'Exposure Latitude (EL) Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `exposure_latitude_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `exposure_latitude_percent` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `feature_type` SET TAGS ('dbx_value_regex' = 'line|space|contact|via|trench|island');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `illumination_mode` SET TAGS ('dbx_business_glossary_term' = 'Illumination Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `illumination_mode` SET TAGS ('dbx_value_regex' = 'conventional|annular|dipole|quadrupole|quasar|freeform');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Critical Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'DUV|EUV|i-line|KrF|ArF');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `mask_cd_target_nm` SET TAGS ('dbx_business_glossary_term' = 'Mask Critical Dimension (CD) Target (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `mask_cd_tolerance_nm` SET TAGS ('dbx_business_glossary_term' = 'Mask Critical Dimension (CD) Tolerance (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'SEM|optical|AFM|scatterometry');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `measurement_tool` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `numerical_aperture` SET TAGS ('dbx_business_glossary_term' = 'Numerical Aperture (NA)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Pitch (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `process_condition` SET TAGS ('dbx_business_glossary_term' = 'Process Condition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `process_window_score` SET TAGS ('dbx_business_glossary_term' = 'Process Window Score');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|qualified|rejected|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `qualified_by` SET TAGS ('dbx_business_glossary_term' = 'Qualified By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `resist_type` SET TAGS ('dbx_business_glossary_term' = 'Resist Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `sigma_inner` SET TAGS ('dbx_business_glossary_term' = 'Sigma Inner Illumination Setting');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `sigma_outer` SET TAGS ('dbx_business_glossary_term' = 'Sigma Outer Illumination Setting');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`meef_parameter` ALTER COLUMN `wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Exposure Wavelength (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` SET TAGS ('dbx_subdomain' = 'qualification_management');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `process_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `acceptance_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Summary');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `actual_cpk` SET TAGS ('dbx_business_glossary_term' = 'Actual Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `cooling_optimization_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Cooling Optimization Evaluated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Qualification Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2}$');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `failure_mode_summary` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Summary');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `lot_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Reference');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `plm_system_source` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `plm_system_source` SET TAGS ('dbx_value_regex' = 'oracle_agile|siemens_teamcenter|other');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `plm_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Workflow ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^PQ-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_process|process_change|tool_qualification|node_readiness|recipe_qualification|material_qualification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `requires_customer_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Customer Approval');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `sign_off_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `target_cpk` SET TAGS ('dbx_business_glossary_term' = 'Target Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_qualification` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` SET TAGS ('dbx_subdomain' = 'qualification_management');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Flow ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `primary_change_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Flow Internal Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `affected_customer_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer List');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `affected_customer_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `affected_equipment_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Equipment List');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `affected_material_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Material List');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `affected_product_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Product List');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `attachments` SET TAGS ('dbx_business_glossary_term' = 'Attachments');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_classification` SET TAGS ('dbx_business_glossary_term' = 'Change Classification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_classification` SET TAGS ('dbx_value_regex' = 'major|minor|notification_only');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'process|material|equipment|design|facility|supplier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `cooling_process_impact` SET TAGS ('dbx_business_glossary_term' = 'Cooling Process Impact');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `customer_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `cycle_time_impact_hours` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Impact Hours');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `environmental_impact` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `last_time_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Process Change Notification (PCN) Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `pcn_number` SET TAGS ('dbx_value_regex' = '^PCN-[0-9]{6,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `planned_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|waived');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `yield_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`change_notification` ALTER COLUMN `yield_impact_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `yield_loss_event_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Event ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `inspection_point_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Point ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`yield_loss_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `defect_inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Inspection Result Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Recipe Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`defect_inspection_result` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `process_metrology_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for metrology_measurement');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `process_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Site Map ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `cp_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'Good|Suspect|Bad|Uncalibrated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Marginal|Rework|Hold');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `max_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `mean_value` SET TAGS ('dbx_business_glossary_term' = 'Mean Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'Inline|Offline|Engineering|Qualification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `measurement_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measurement Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'Completed|In Progress|Failed|Aborted|Pending');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'CD-SEM|OCD|XRF|Ellipsometry|Overlay|Film Thickness');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `median_value` SET TAGS ('dbx_business_glossary_term' = 'Median Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `metrology_at_step` SET TAGS ('dbx_business_glossary_term' = 'Metrology At Step');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `min_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `range_value` SET TAGS ('dbx_business_glossary_term' = 'Range Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `site_count` SET TAGS ('dbx_business_glossary_term' = 'Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `spc_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `std_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `three_sigma` SET TAGS ('dbx_business_glossary_term' = 'Three Sigma (3σ)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `uniformity_percent` SET TAGS ('dbx_business_glossary_term' = 'Uniformity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_metrology_measurement` ALTER COLUMN `wafer_slot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Slot Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` SET TAGS ('dbx_subdomain' = 'equipment_conditions');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Implant Condition Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Anneal Recipe Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Plan Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `anneal_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Anneal Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `anneal_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Anneal Time (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `anneal_type` SET TAGS ('dbx_business_glossary_term' = 'Anneal Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `anneal_type` SET TAGS ('dbx_value_regex' = 'rta|furnace|spike|laser|flash');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `baseline_cpk` SET TAGS ('dbx_business_glossary_term' = 'Baseline Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `beam_current_ma` SET TAGS ('dbx_business_glossary_term' = 'Beam Current (mA)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Implant Condition Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `condition_name` SET TAGS ('dbx_business_glossary_term' = 'Implant Condition Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Implant Condition Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `dopant_species` SET TAGS ('dbx_business_glossary_term' = 'Dopant Species');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_dose_ions_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Implant Dose (ions/cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_energy_kev` SET TAGS ('dbx_business_glossary_term' = 'Implant Energy (keV)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_layer_name` SET TAGS ('dbx_business_glossary_term' = 'Implant Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_purpose` SET TAGS ('dbx_business_glossary_term' = 'Implant Purpose');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_tool_class` SET TAGS ('dbx_business_glossary_term' = 'Implant Tool Class');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_tool_class` SET TAGS ('dbx_value_regex' = 'high_current|medium_current|low_energy|high_energy|ultra_high_dose');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `implant_tool_model` SET TAGS ('dbx_business_glossary_term' = 'Implant Tool Model');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `is_baseline_condition` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Condition Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Process Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `process_window_dose_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Process Window Dose Tolerance (percent)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `process_window_energy_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Process Window Energy Tolerance (percent)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under_qualification|qualified|production|suspended|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `requires_pre_amorphization` SET TAGS ('dbx_business_glossary_term' = 'Requires Pre-Amorphization Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `target_junction_depth_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Junction Depth (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `target_sheet_resistance_ohms_per_sq` SET TAGS ('dbx_business_glossary_term' = 'Target Sheet Resistance (Ω/sq)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `target_threshold_voltage_mv` SET TAGS ('dbx_business_glossary_term' = 'Target Threshold Voltage (mV)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `tilt_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Tilt Angle (degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `twist_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Twist Angle (degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`implant_condition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` SET TAGS ('dbx_subdomain' = 'equipment_conditions');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `deposition_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Deposition Condition ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Plan ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `carrier_gas` SET TAGS ('dbx_business_glossary_term' = 'Carrier Gas');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `carrier_gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Carrier Gas Flow Rate (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `chamber_configuration` SET TAGS ('dbx_business_glossary_term' = 'Chamber Configuration');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Deposition Condition Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `condition_name` SET TAGS ('dbx_business_glossary_term' = 'Deposition Condition Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `deposition_method` SET TAGS ('dbx_business_glossary_term' = 'Deposition Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `deposition_method` SET TAGS ('dbx_value_regex' = 'LPCVD|PECVD|ALD|PVD|EPI|MOCVD');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `deposition_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Deposition Pressure (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `deposition_rate_angstrom_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Deposition Rate (Angstrom per Minute)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `deposition_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Deposition Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `deposition_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Deposition Time (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `deposition_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Deposition Condition Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `film_stress_mpa` SET TAGS ('dbx_business_glossary_term' = 'Film Stress (MPa)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `precursor_gas_1` SET TAGS ('dbx_business_glossary_term' = 'Precursor Gas 1');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `precursor_gas_1_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Precursor Gas 1 Flow Rate (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `precursor_gas_2` SET TAGS ('dbx_business_glossary_term' = 'Precursor Gas 2');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `precursor_gas_2_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Precursor Gas 2 Flow Rate (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `process_capability_cpk` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `process_category` SET TAGS ('dbx_business_glossary_term' = 'Process Category');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `process_category` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under_qualification|qualified|production|suspended|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `refractive_index` SET TAGS ('dbx_business_glossary_term' = 'Refractive Index');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `rf_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency (RF) Frequency (MHz)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `rf_power_watts` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency (RF) Power (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `step_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Step Coverage (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `target_layer` SET TAGS ('dbx_business_glossary_term' = 'Target Layer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `target_material` SET TAGS ('dbx_business_glossary_term' = 'Target Material');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `target_thickness_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Target Thickness (Angstrom)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `thickness_tolerance_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Thickness Tolerance (Angstrom)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `tool_class` SET TAGS ('dbx_business_glossary_term' = 'Tool Class');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `uniformity_specification_percent` SET TAGS ('dbx_business_glossary_term' = 'Uniformity Specification (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`deposition_condition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` SET TAGS ('dbx_subdomain' = 'equipment_conditions');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `etch_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Etch Condition Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `application_scope` SET TAGS ('dbx_business_glossary_term' = 'Application Scope');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `chamber_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Chamber Pressure (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Etch Condition Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `condition_name` SET TAGS ('dbx_business_glossary_term' = 'Etch Condition Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `critical_dimension_bias_nm` SET TAGS ('dbx_business_glossary_term' = 'Critical Dimension (CD) Bias (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `endpoint_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Detection Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `endpoint_detection_method` SET TAGS ('dbx_value_regex' = 'time_based|optical_emission_spectroscopy|laser_interferometry|mass_spectrometry|none');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `etch_method` SET TAGS ('dbx_business_glossary_term' = 'Etch Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `etch_method` SET TAGS ('dbx_value_regex' = 'RIE|ICP|CCP|wet_immersion|wet_spray');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `etch_rate_angstrom_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Etch Rate (Angstrom per Minute)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `etch_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Etch Time (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `etch_type` SET TAGS ('dbx_business_glossary_term' = 'Etch Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `etch_type` SET TAGS ('dbx_value_regex' = 'dry|wet');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `etchant_chemistry` SET TAGS ('dbx_business_glossary_term' = 'Etchant Chemistry');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `is_baseline_condition` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Condition Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `over_etch_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Etch Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `primary_gas_flow_sccm` SET TAGS ('dbx_business_glossary_term' = 'Primary Gas Flow Rate (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `process_category` SET TAGS ('dbx_business_glossary_term' = 'Process Category');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `process_category` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `profile_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Etch Profile Angle (Degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under_qualification|qualified|production|deprecated|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `rf_bias_power_watts` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency (RF) Bias Power (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `rf_source_power_watts` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency (RF) Source Power (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `secondary_gas_flow_sccm` SET TAGS ('dbx_business_glossary_term' = 'Secondary Gas Flow Rate (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `selectivity_ratio` SET TAGS ('dbx_business_glossary_term' = 'Selectivity Ratio');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `substrate_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Substrate Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `target_cd_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Critical Dimension (CD) (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `target_layer` SET TAGS ('dbx_business_glossary_term' = 'Target Layer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `target_material` SET TAGS ('dbx_business_glossary_term' = 'Target Material');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `tool_class` SET TAGS ('dbx_business_glossary_term' = 'Tool Class');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`etch_condition` ALTER COLUMN `uniformity_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Etch Uniformity Target (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` SET TAGS ('dbx_subdomain' = 'equipment_conditions');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `cmp_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Condition ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `carrier_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Carrier Speed (RPM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `cmp_step_type` SET TAGS ('dbx_business_glossary_term' = 'CMP Step Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'CMP Condition Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `condition_name` SET TAGS ('dbx_business_glossary_term' = 'CMP Condition Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `conditioner_type` SET TAGS ('dbx_business_glossary_term' = 'Pad Conditioner Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `conditioning_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pad Conditioning Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `defect_density_spec_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Specification (Defects per Wafer)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `cmp_condition_description` SET TAGS ('dbx_business_glossary_term' = 'CMP Condition Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `dishing_spec_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Dishing Specification (Angstrom)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `endpoint_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Detection Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `endpoint_detection_method` SET TAGS ('dbx_value_regex' = 'optical|motor current|time-based|acoustic|eddy current');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'CMP Equipment Class');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `erosion_spec_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Erosion Specification (Angstrom)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `is_baseline_condition` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Condition Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Process Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `pad_product_name` SET TAGS ('dbx_business_glossary_term' = 'Polishing Pad Product Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `pad_type` SET TAGS ('dbx_business_glossary_term' = 'Polishing Pad Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `pad_vendor` SET TAGS ('dbx_business_glossary_term' = 'Polishing Pad Vendor');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `platen_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Platen Pressure (PSI)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `polish_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Polish Time (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `post_cmp_clean_recipe` SET TAGS ('dbx_business_glossary_term' = 'Post-CMP Clean Recipe');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `process_layer` SET TAGS ('dbx_business_glossary_term' = 'Process Layer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `process_layer` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under qualification|qualified|production approved|suspended|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `qualified_by_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified By Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `removal_rate_angstrom_per_min` SET TAGS ('dbx_business_glossary_term' = 'Material Removal Rate (Angstrom/min)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `selectivity_ratio` SET TAGS ('dbx_business_glossary_term' = 'CMP Selectivity Ratio');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `slurry_chemistry_type` SET TAGS ('dbx_business_glossary_term' = 'Slurry Chemistry Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `slurry_flow_rate_ml_per_min` SET TAGS ('dbx_business_glossary_term' = 'Slurry Flow Rate (mL/min)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `slurry_product_name` SET TAGS ('dbx_business_glossary_term' = 'Slurry Product Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `slurry_vendor` SET TAGS ('dbx_business_glossary_term' = 'Slurry Vendor');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `table_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Platen Table Speed (RPM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `target_layer_name` SET TAGS ('dbx_business_glossary_term' = 'Target Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `target_removal_amount_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Target Removal Amount (Angstrom)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `wafer_to_wafer_uniformity_spec_percent` SET TAGS ('dbx_business_glossary_term' = 'Wafer-to-Wafer Uniformity Specification (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cmp_condition` ALTER COLUMN `within_wafer_uniformity_spec_percent` SET TAGS ('dbx_business_glossary_term' = 'Within-Wafer Uniformity Specification (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` SET TAGS ('dbx_subdomain' = 'equipment_conditions');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `litho_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Lithography Condition ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `cd_tolerance_nm` SET TAGS ('dbx_business_glossary_term' = 'Critical Dimension (CD) Tolerance (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Lithography Condition Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `condition_name` SET TAGS ('dbx_business_glossary_term' = 'Lithography Condition Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `depth_of_focus_nm` SET TAGS ('dbx_business_glossary_term' = 'Depth of Focus (DOF) (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `develop_process_type` SET TAGS ('dbx_business_glossary_term' = 'Develop Process Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `develop_process_type` SET TAGS ('dbx_value_regex' = 'puddle|spray|immersion');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `develop_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Develop Time (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `exposure_dose_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'Exposure Dose (mJ/cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `exposure_latitude_percent` SET TAGS ('dbx_business_glossary_term' = 'Exposure Latitude (%)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `exposure_latitude_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `exposure_latitude_percent` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `focus_offset_nm` SET TAGS ('dbx_business_glossary_term' = 'Focus Offset (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `hard_bake_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Hard Bake Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `hard_bake_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Hard Bake Time (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `illumination_mode` SET TAGS ('dbx_business_glossary_term' = 'Illumination Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `illumination_mode` SET TAGS ('dbx_value_regex' = 'conventional|annular|dipole|quadrupole|quasar|freeform');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `is_baseline_condition` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Condition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Target Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|i-line|g-line');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `multi_patterning_type` SET TAGS ('dbx_business_glossary_term' = 'Multi-Patterning Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `multi_patterning_type` SET TAGS ('dbx_value_regex' = 'none|LELE|SADP|SAQP|EUV_single');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `numerical_aperture` SET TAGS ('dbx_business_glossary_term' = 'Numerical Aperture (NA)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `overlay_tolerance_nm` SET TAGS ('dbx_business_glossary_term' = 'Overlay Tolerance (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `post_exposure_bake_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Post-Exposure Bake (PEB) Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `post_exposure_bake_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Post-Exposure Bake (PEB) Time (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under_qualification|qualified|production|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `resist_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Resist Thickness (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `resist_type` SET TAGS ('dbx_business_glossary_term' = 'Resist Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `scanner_model` SET TAGS ('dbx_business_glossary_term' = 'Scanner Model');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `sigma_inner` SET TAGS ('dbx_business_glossary_term' = 'Sigma Inner');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `sigma_outer` SET TAGS ('dbx_business_glossary_term' = 'Sigma Outer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `target_cd_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Critical Dimension (CD) (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`litho_condition` ALTER COLUMN `wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Wavelength (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` SET TAGS ('dbx_subdomain' = 'statistical_control');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `ocap_action_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Control Action Plan (OCAP) Action ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Spc Control Chart Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `spc_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Measurement Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `tertiary_ocap_assigned_engineer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Ocap Assigned Engineer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `tertiary_ocap_assigned_engineer_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `tertiary_ocap_assigned_engineer_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `tertiary_ocap_assigned_engineer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `tertiary_ocap_assigned_engineer_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `action_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Completed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `action_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Initiated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|escalated|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `affected_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `assigned_organization` SET TAGS ('dbx_business_glossary_term' = 'Assigned Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Closure Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `containment_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Excursion Detection Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|director|executive');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `excursion_severity` SET TAGS ('dbx_business_glossary_term' = 'Process Excursion Severity');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `excursion_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'released|held|rework|scrap|quarantine|conditional_release');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `ocap_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Control Action Plan (OCAP) Procedure Reference');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `ocap_responds_to_excursion` SET TAGS ('dbx_business_glossary_term' = 'Ocap Responds To Excursion');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'OCAP Resolution Time in Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'OCAP Response Time in Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `spc_rule_violated` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Verification Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Verification Result');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|pending');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`ocap_action` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'OCAP Action Verification Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` SET TAGS ('dbx_subdomain' = 'flow_definition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` SET TAGS ('dbx_ssot_owner' = 'fabrication.fabrication_technology_node');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Product Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `authoritative_fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `fabrication_technology_node_ref_id` SET TAGS ('dbx_ssot_owner' = 'fabrication.fabrication_technology_node');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `fabrication_technology_node_ref_id` SET TAGS ('dbx_references' = 'technology_node');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `application_scope` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Application Scope');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `baseline_cpk` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cpk (Process Capability Index)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `baseline_yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Baseline Yield Target (%)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `beol_layer_count` SET TAGS ('dbx_business_glossary_term' = 'BEOL (Back End of Line) Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `process_technology_node_description` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Complexity Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `device_architecture` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `device_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanowire|nanosheet');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `dram_half_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'DRAM (Dynamic Random-Access Memory) Half-Pitch (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `euv_layer_count` SET TAGS ('dbx_business_glossary_term' = 'EUV (Extreme Ultraviolet Lithography) Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'FAB (Fabrication Facility) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `feol_layer_count` SET TAGS ('dbx_business_glossary_term' = 'FEOL (Front End of Line) Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `gate_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Gate Pitch (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `introduction_year` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Introduction Year');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `is_baseline_node` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Technology Node Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'duv|euv|immersion|dry|ebeam');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `minimum_metal_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Metal Pitch (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `node_generation` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Generation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `node_nm` SET TAGS ('dbx_business_glossary_term' = 'Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Owner Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'PDK (Process Design Kit) Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `production_readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Production Readiness Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|production_approved|failed|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `supports_multi_patterning` SET TAGS ('dbx_business_glossary_term' = 'Supports Multi-Patterning Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `target_performance_improvement_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Improvement (%)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `target_power_efficiency_improvement_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Power Efficiency Improvement (%)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `target_transistor_density_per_mm2` SET TAGS ('dbx_business_glossary_term' = 'Target Transistor Density (per mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_technology_node` ALTER COLUMN `wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Wavelength (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `excursion_id` SET TAGS ('dbx_business_glossary_term' = 'Excursion Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `affected_die_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `affected_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `affected_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `containment_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Taken');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Per Square Centimeter');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'SPC|inspection|metrology|electrical_test|operator|automated_system');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_vendor|engineering_review|customer_notification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `estimated_financial_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `estimated_financial_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `estimated_yield_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Yield Impact Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `excursion_number` SET TAGS ('dbx_business_glossary_term' = 'Excursion Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `excursion_type` SET TAGS ('dbx_business_glossary_term' = 'Excursion Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `excursion_type` SET TAGS ('dbx_value_regex' = 'out_of_spec|out_of_control|yield_loss|defect_density|parametric_drift|equipment_fault');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|investigating|root_cause_identified|corrective_action_pending|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|material|process|human|environmental|unknown');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `spc_rule_violated` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `specification_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit (LSL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `specification_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit (USL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `yield_loss_mode` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`excursion` ALTER COLUMN `yield_loss_mode` SET TAGS ('dbx_value_regex' = 'parametric|systematic|random|electrical|none');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` SET TAGS ('dbx_subdomain' = 'qualification_management');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `doe_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Design of Experiments (DOE) Experiment ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `analysis_software` SET TAGS ('dbx_business_glossary_term' = 'Analysis Software');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `baseline_cpk` SET TAGS ('dbx_business_glossary_term' = 'Baseline Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `blocking_factor` SET TAGS ('dbx_business_glossary_term' = 'Blocking Factor');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `doe_type` SET TAGS ('dbx_business_glossary_term' = 'Design of Experiments (DOE) Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `doe_type` SET TAGS ('dbx_value_regex' = 'full_factorial|fractional_factorial|response_surface_methodology|taguchi|plackett_burman|central_composite');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `experiment_number` SET TAGS ('dbx_business_glossary_term' = 'Experiment Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `experiment_objective` SET TAGS ('dbx_business_glossary_term' = 'Experiment Objective');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `experiment_title` SET TAGS ('dbx_business_glossary_term' = 'Experiment Title');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `factor_count` SET TAGS ('dbx_business_glossary_term' = 'Factor Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `factor_levels` SET TAGS ('dbx_business_glossary_term' = 'Factor Levels');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `factor_list` SET TAGS ('dbx_business_glossary_term' = 'Factor List');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `interaction_effects` SET TAGS ('dbx_business_glossary_term' = 'Interaction Effects');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `key_findings` SET TAGS ('dbx_business_glossary_term' = 'Key Findings');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `post_doe_cpk` SET TAGS ('dbx_business_glossary_term' = 'Post-DOE Process Capability Index (Cpk)');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `primary_response_variable` SET TAGS ('dbx_business_glossary_term' = 'Primary Response Variable');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `process_capability_improvement` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Improvement');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `process_window_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Process Window Lower Limit');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `process_window_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Process Window Upper Limit');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `recommended_setpoints` SET TAGS ('dbx_business_glossary_term' = 'Recommended Setpoints');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `replication_count` SET TAGS ('dbx_business_glossary_term' = 'Replication Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `response_variable_count` SET TAGS ('dbx_business_glossary_term' = 'Response Variable Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `response_variable_list` SET TAGS ('dbx_business_glossary_term' = 'Response Variable List');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `run_count` SET TAGS ('dbx_business_glossary_term' = 'Run Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `run_order_strategy` SET TAGS ('dbx_business_glossary_term' = 'Run Order Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `run_order_strategy` SET TAGS ('dbx_value_regex' = 'randomized|sequential|blocked|center_point_replicated');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `significant_factors` SET TAGS ('dbx_business_glossary_term' = 'Significant Factors');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `statistical_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Analysis Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `wafer_split_plan` SET TAGS ('dbx_business_glossary_term' = 'Wafer Split Plan');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`doe_experiment` ALTER COLUMN `yield_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` SET TAGS ('dbx_subdomain' = 'qualification_management');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` SET TAGS ('dbx_association_edges' = 'process.process_process_flow,customer.account');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `flow_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Qualification - Process Flow Qualification Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Qualification - Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Qualification - Process Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `achieved_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Achieved Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `actual_cpk` SET TAGS ('dbx_business_glossary_term' = 'Actual Cpk');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `actual_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Pct');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `approval_signoff` SET TAGS ('dbx_business_glossary_term' = 'Approval Signoff');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `baseline_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Baseline Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `customer_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `defect_density_actual_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Actual Per Cm2');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `defect_density_target_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Target Per Cm2');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `environmental_condition` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `failure_mode_summary` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Summary');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `lot_count` SET TAGS ('dbx_business_glossary_term' = 'Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qual_criteria` SET TAGS ('dbx_business_glossary_term' = 'Qual Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qual_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Qual Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qual Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_method` SET TAGS ('dbx_business_glossary_term' = 'Qualification Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_owner` SET TAGS ('dbx_business_glossary_term' = 'Qualification Owner');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_revision` SET TAGS ('dbx_business_glossary_term' = 'Qualification Revision');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualified_by` SET TAGS ('dbx_business_glossary_term' = 'Qualified By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualified_date` SET TAGS ('dbx_business_glossary_term' = 'Qualified Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualified_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Qualified Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `qualifying_engineer` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Engineer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `reliability_hours` SET TAGS ('dbx_business_glossary_term' = 'Reliability Hours');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `requalification_trigger` SET TAGS ('dbx_business_glossary_term' = 'Requalification Trigger');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign Off Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `sign_off_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Sign Off Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `statistical_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `target_cpk` SET TAGS ('dbx_business_glossary_term' = 'Target Cpk');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `yield_achieved_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Achieved Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `yield_actual` SET TAGS ('dbx_business_glossary_term' = 'Yield Actual');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `yield_target` SET TAGS ('dbx_business_glossary_term' = 'Yield Target');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`flow_qualification` ALTER COLUMN `yield_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Yield Target Pct');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` SET TAGS ('dbx_subdomain' = 'qualification_management');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` SET TAGS ('dbx_association_edges' = 'process.process_process_step,supply.supplier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `process_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Process Supply Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `capacity_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Pct');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `capacity_commitment` SET TAGS ('dbx_business_glossary_term' = 'Capacity Commitment');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `capacity_reservation` SET TAGS ('dbx_business_glossary_term' = 'Capacity Reservation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `capacity_reservation_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Reservation Pct');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `committed_capacity_pct` SET TAGS ('dbx_business_glossary_term' = 'Committed Capacity Pct');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `committed_capacity_percent` SET TAGS ('dbx_business_glossary_term' = 'Committed Capacity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `committed_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume Units');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `committed_volume_wafers` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume Wafers');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `committed_wafer_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Wafer Volume');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `lead_time_weeks` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Weeks');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Min Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `price_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Price Per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `price_terms` SET TAGS ('dbx_business_glossary_term' = 'Price Terms');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Pricing Terms');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `process_supply_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Process Supply Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `renewal_clause` SET TAGS ('dbx_business_glossary_term' = 'Renewal Clause');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Signed By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `take_or_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Take Or Pay Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `terms_notes` SET TAGS ('dbx_business_glossary_term' = 'Terms Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `wafer_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Wafer Price Usd');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_supply_agreement` ALTER COLUMN `yield_commitment_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Commitment Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` SET TAGS ('dbx_subdomain' = 'flow_definition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` SET TAGS ('dbx_ssot_owner' = 'site_map');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `process_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Site Map Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `equipment_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Site Map Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `capacity` SET TAGS ('dbx_business_glossary_term' = 'Capacity');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `compliance_classification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Classification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `is_primary_site` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Site');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `measurement_site_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `site_count` SET TAGS ('dbx_business_glossary_term' = 'Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `site_map_code` SET TAGS ('dbx_business_glossary_term' = 'Site Map Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `site_map_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `site_map_name` SET TAGS ('dbx_business_glossary_term' = 'Site Map Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `site_map_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `sub_region` SET TAGS ('dbx_business_glossary_term' = 'Sub Region');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_site_map` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` SET TAGS ('dbx_subdomain' = 'statistical_control');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` SET TAGS ('dbx_ssot_owner' = 'spc_control_plan');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `process_spc_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `primary_authoritative_spc_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Spc Control Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `primary_authoritative_spc_control_plan_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Spc Control Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `capability_index_cp_k` SET TAGS ('dbx_business_glossary_term' = 'Capability Index Cp K');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Lower');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Upper');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `control_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `control_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `control_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `equipment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `measurement_name` SET TAGS ('dbx_business_glossary_term' = 'Measurement Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `rule_set_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `sampling_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate Per Hour');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `spc_control_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `spc_control_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `technology_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`process_spc_control_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` SET TAGS ('dbx_subdomain' = 'statistical_control');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `metrology_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `superseded_metrology_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Metrology Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `superseded_metrology_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `metrology_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Metrology Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `metrology_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `frequency_per_day` SET TAGS ('dbx_business_glossary_term' = 'Frequency Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `measurement_category` SET TAGS ('dbx_business_glossary_term' = 'Measurement Category');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `measurement_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measurement Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `measurement_tool` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `metrology_type` SET TAGS ('dbx_business_glossary_term' = 'Metrology Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `metrology_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Metrology Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `target_technology_node` SET TAGS ('dbx_business_glossary_term' = 'Target Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `target_wafer_size` SET TAGS ('dbx_business_glossary_term' = 'Target Wafer Size');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`metrology_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` SET TAGS ('dbx_subdomain' = 'statistical_control');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `superseded_sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Sampling Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `superseded_sampling_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sampling_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Lower');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Upper');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sampling_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `last_executed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Executed By');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `last_executed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sampling_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `operator` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sample_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sample Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sample_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Sample Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sampling_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `sampling_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`sampling_plan` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` SET TAGS ('dbx_subdomain' = 'flow_definition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `inspection_point_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Point Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `upstream_inspection_point_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Inspection Point Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `upstream_inspection_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `inspection_point_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `inspection_point_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `last_calibrated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibrated Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `inspection_point_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `process_stage` SET TAGS ('dbx_business_glossary_term' = 'Process Stage');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`inspection_point` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` SET TAGS ('dbx_subdomain' = 'equipment_conditions');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` SET TAGS ('dbx_table_name' = 'cooling_process_flow');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cooling_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Cooling Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cooling_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cooling_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cooling_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cooling_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Cooling Condition Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `baseline_energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Baseline Energy Consumption Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `closed_loop_recirculation_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Loop Recirculation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `co2_reduction_kg` SET TAGS ('dbx_business_glossary_term' = 'Co2 Reduction Kg');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cool_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cool_optimization_mode` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cool_optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Objective');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `coolant_recovery_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Coolant Recovery Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `coolant_type` SET TAGS ('dbx_business_glossary_term' = 'Coolant Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cooling_stage_count` SET TAGS ('dbx_business_glossary_term' = 'Cooling Stage Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cooling_step_count` SET TAGS ('dbx_business_glossary_term' = 'Cooling Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `cooling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Cooling Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `energy_efficiency_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `energy_savings_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Energy Savings Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `estimated_energy_savings_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Energy Savings Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Flow Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `flow_description` SET TAGS ('dbx_business_glossary_term' = 'Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `flow_revision` SET TAGS ('dbx_business_glossary_term' = 'Flow Revision');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_business_glossary_term' = 'Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `is_baseline_flow` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Flow');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `optimization_method` SET TAGS ('dbx_business_glossary_term' = 'Optimization Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Optimization Objective');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `optimized_energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Optimized Energy Consumption Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `primary_coolant_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Coolant Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `target_energy_savings_kwh` SET TAGS ('dbx_business_glossary_term' = 'Target Energy Savings Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `target_exit_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Exit Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `total_coolant_consumption_lpm` SET TAGS ('dbx_business_glossary_term' = 'Total Coolant Consumption Lpm');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `total_coolant_flow_lpm` SET TAGS ('dbx_business_glossary_term' = 'Total Coolant Flow Lpm');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `total_cooling_step_count` SET TAGS ('dbx_business_glossary_term' = 'Total Cooling Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `waste_elimination_strategy` SET TAGS ('dbx_business_glossary_term' = 'Waste Elimination Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `waste_heat_recovery_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovery Efficiency Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `waste_heat_recovery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovery Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `waste_heat_recovery_target_kwh` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovery Target Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_process_flow` ALTER COLUMN `waste_reduction_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Reduction Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` SET TAGS ('dbx_subdomain' = 'equipment_conditions');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` SET TAGS ('dbx_table_name' = 'cooling_condition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cooling_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Cooling Condition Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `backside_helium_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Backside Helium Pressure Torr');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `chiller_setpoint_celsius` SET TAGS ('dbx_business_glossary_term' = 'Chiller Setpoint Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `condition_name` SET TAGS ('dbx_business_glossary_term' = 'Condition Name');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cool_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cool_optimization_mode` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Mode');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cool_optimization_strategy` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cool_optimization_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `coolant_flow_rate_lpm` SET TAGS ('dbx_business_glossary_term' = 'Coolant Flow Rate Lpm');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `coolant_inlet_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Coolant Inlet Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `coolant_outlet_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Coolant Outlet Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `coolant_recirculation_flag` SET TAGS ('dbx_business_glossary_term' = 'Coolant Recirculation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `coolant_recovery_percent` SET TAGS ('dbx_business_glossary_term' = 'Coolant Recovery Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `coolant_recycle_percent` SET TAGS ('dbx_business_glossary_term' = 'Coolant Recycle Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `coolant_type` SET TAGS ('dbx_business_glossary_term' = 'Coolant Type');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cooling_method` SET TAGS ('dbx_business_glossary_term' = 'Cooling Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cooling_rate_celsius_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Cooling Rate Celsius Per Minute');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cooling_rate_celsius_per_second` SET TAGS ('dbx_business_glossary_term' = 'Cooling Rate Celsius Per Second');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cooling_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cooling Time Seconds');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `cooling_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Cooling Condition Description');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `energy_efficiency_ratio` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Ratio');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `energy_efficiency_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `heat_load_watts` SET TAGS ('dbx_business_glossary_term' = 'Heat Load Watts');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `inlet_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Inlet Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `is_baseline_condition` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Condition');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `optimization_achieved_percent` SET TAGS ('dbx_business_glossary_term' = 'Optimization Achieved Percent');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `optimization_status` SET TAGS ('dbx_business_glossary_term' = 'Optimization Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `outlet_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Outlet Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `target_chuck_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Chuck Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `target_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `temperature_tolerance_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Tolerance Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `waste_coolant_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Waste Coolant Volume Liters');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `waste_disposal_classification` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Classification');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `waste_elimination_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Elimination Method');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `waste_heat_recovered_kwh` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovered Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `waste_heat_recovery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovery Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `waste_heat_recovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovery Flag');
ALTER TABLE `vibe_semiconductors_v1`.`process`.`cooling_condition` ALTER COLUMN `waste_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Reduction Percent');
