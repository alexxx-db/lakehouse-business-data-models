-- Schema for Domain: fabrication | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`fabrication` COMMENT 'Core wafer fabrication and processing domain governing all FAB operations including FEOL, MOL, and BEOL process steps. Owns wafer lot tracking, WIP management, process recipe execution, and fab line scheduling across CVD, PVD, ALD, CMP, ion implantation, and EUV/DUV lithography operations. Authoritative source for wafer genealogy and lot disposition via MES integration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` (
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the wafer lot tracked through the FAB from wafer start to lot disposition. Primary key for all WIP lot tracking across FEOL, MOL, and BEOL operations.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Unique identifier for the process route (recipe sequence) assigned to this lot. Defines the complete sequence of operations from wafer start to completion.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Wafer lot references a technology node; replace string column with FK to technology_node for normalization.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Required for Production Planning Report linking each wafer lot to the specific IC catalog item being manufactured.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Required for lot‑level cost and yield reporting per design project, enabling profitability analysis and project KPI dashboards.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'add column inventory_wafer_lot_id (BIGINT) with FK to inventory.inventory_wafer_lot.inventory_wafer_lot_id - establish clear SSOT relationship where inventory owns lot tracking',
    `parent_lot_fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the parent lot from which this lot was split or derived. Null for original lots. Enables wafer genealogy tracking and traceability.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the lot completed all FAB processing operations and was dispositioned. Null for lots still in WIP.',
    `current_operation_name` STRING COMMENT 'Descriptive name of the current process operation (e.g., CVD_OXIDE_DEP, EUV_LITHO, CMP_POLISH). Provides human-readable context for lot location.',
    `current_operation_number` STRING COMMENT 'Sequential operation step number in the process route where the lot is currently located. Used for tracking lot position in the manufacturing flow.. Valid values are `^[0-9]{4,6}$`',
    `current_process_area` STRING COMMENT 'High-level FAB area classification where the lot is currently located: FEOL (front-end-of-line transistor formation), MOL (middle-of-line contacts), BEOL (back-end-of-line interconnect), metrology (inspection), or test (electrical probe).. Valid values are `feol|mol|beol|metrology|test`',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Total elapsed time in days from wafer start to lot completion. Key performance metric for manufacturing efficiency and customer responsiveness.',
    `due_date` DATE COMMENT 'Target completion date for the lot to meet customer delivery commitments. Used for scheduling and on-time-delivery tracking.',
    `fab_facility_code` STRING COMMENT 'Identifier for the physical FAB facility where the lot is being processed. Supports multi-site operations and capacity planning.. Valid values are `^[A-Z0-9]{3,6}$`',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the lot is currently on hold and prevented from processing. True when lot is held for quality, engineering, or disposition review.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the reason for lot hold (e.g., QUAL_FAIL, ENG_REVIEW, EQUIP_DOWN, MATL_ISSUE). Null when hold_flag is false.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `hold_timestamp` TIMESTAMP COMMENT 'Date and time when the lot was placed on hold. Used to calculate hold duration and impact on cycle time. Null when lot is not on hold.',
    `initial_wafer_count` STRING COMMENT 'Original number of wafers when the lot was started. Used to calculate yield loss and scrap rate during processing.',
    `is_hot_lot` BOOLEAN COMMENT 'Indicates whether this lot is designated as a hot lot requiring expedited processing and priority resource allocation. True for urgent customer orders.',
    `lot_created_timestamp` TIMESTAMP COMMENT 'Date and time when the lot record was first created in the MES system. May precede wafer start for planning purposes.',
    `lot_disposition` STRING COMMENT 'Final disposition decision for the completed lot: pass (released to next stage), fail (rejected), partial (some wafers pass), rework (reprocess), scrap (discard), or engineering_hold (pending review).. Valid values are `pass|fail|partial|rework|scrap|engineering_hold`',
    `lot_notes` STRING COMMENT 'Free-text field for operators and engineers to record important observations, special handling instructions, or process deviations for this lot.',
    `lot_number` STRING COMMENT 'Externally-known unique business identifier for the wafer lot assigned by MES at wafer start. Used for tracking and traceability across all FAB operations and external communications.. Valid values are `^[A-Z0-9]{8,16}$`',
    `lot_on_node` BIGINT COMMENT 'FK to fabrication.technology_node.technology_node_id — Every lot is manufactured on a specific technology node. This is fundamental for WIP classification and routing.',
    `lot_type` STRING COMMENT 'Classification of the wafer lot purpose: production (revenue-generating), engineering (process development), qualification (product validation), MPW (multi-project wafer shuttle), pilot (pre-production), or rework (reprocessed lot).. Valid values are `production|engineering|qualification|mpw|pilot|rework`',
    `lot_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the lot record was last modified in the MES system. Tracks most recent status or attribute change.',
    `mes_system_source` STRING COMMENT 'Identifies the source MES system that created and manages this lot record: Camstar MES, Applied Materials SmartFactory MES, or other. Used for data lineage and system integration.. Valid values are `camstar|smartfactory|other`',
    `planned_completion_date` DATE COMMENT 'Forecasted completion date based on current WIP position, remaining operations, and standard cycle times. Updated dynamically as lot progresses.',
    `priority_class` STRING COMMENT 'Scheduling priority assigned to the lot for FAB resource allocation. Hot and expedite lots receive preferential processing to meet urgent customer commitments.. Valid values are `hot|expedite|normal|engineering|low`',
    `process_node_nm` STRING COMMENT 'Technology node of the semiconductor process measured in nanometers (e.g., 7nm, 5nm, 3nm). Defines the minimum feature size and process complexity.',
    `process_time_hours` DECIMAL(18,2) COMMENT 'Cumulative time in hours the lot has spent in active processing on equipment. Excludes queue and hold time. Used for capacity planning.',
    `product_name` STRING COMMENT 'Human-readable name of the IC product being manufactured. Used for reporting and customer communications.',
    `queue_time_hours` DECIMAL(18,2) COMMENT 'Cumulative time in hours the lot has spent waiting in queue between operations. Excludes active processing time. Used to identify bottlenecks.',
    `rework_count` STRING COMMENT 'Number of times the lot has been reworked or reprocessed through specific operations. Tracks process stability and quality issues.',
    `route_version` STRING COMMENT 'Version number of the process route. Tracks recipe changes and process improvements over time for traceability and yield analysis.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `sampling_plan_code` STRING COMMENT 'Code identifying the quality sampling and inspection plan applied to this lot. Defines which wafers are sampled and at which operations for metrology and defect inspection.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `scrap_wafer_count` STRING COMMENT 'Total number of wafers scrapped during processing due to defects, breakage, or sampling. Used to calculate yield loss and process capability.',
    `split_sequence_number` STRING COMMENT 'Sequential number assigned when a lot is split into multiple child lots. Used with parent_lot_id to track lot genealogy and wafer provenance.',
    `wafer_count` STRING COMMENT 'Current number of wafers in the lot. May decrease due to scraps, breakage, or sampling during processing. Initial count typically 25 wafers per lot for standard production.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafers in the lot measured in millimeters. Standard sizes include 200mm (8-inch) and 300mm (12-inch).',
    `wafer_start_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot was officially started in the FAB and entered WIP tracking. Represents the beginning of the lots manufacturing lifecycle.',
    `wip_status` STRING COMMENT 'Current lifecycle status of the wafer lot in the FAB workflow. Tracks lot progression from queue through processing to final disposition.. Valid values are `queued|in_process|on_hold|completed|scrapped|shipped`',
    CONSTRAINT pk_fabrication_wafer_lot PRIMARY KEY(`fabrication_wafer_lot_id`)
) COMMENT 'Core master entity representing a wafer lot (batch of wafers) tracked through the FAB from wafer start to lot disposition. Authoritative source for lot identity, wafer count, lot type (production, engineering, qualification, MPW), process node, technology node, product code, priority class, WIP status, hold flags, and genealogy linkage. Sourced from Camstar MES and Applied Materials SmartFactory MES. SSOT for all WIP lot tracking across FEOL, MOL, and BEOL operations. Quality and metrology data for this lot is owned by the quality domain and referenced via cross-domain FK.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` (
    `wafer_id` BIGINT COMMENT 'Unique identifier for the individual silicon wafer within the fabrication facility. Primary key for wafer tracking across all FAB (Fabrication Facility) process steps.',
    `account_id` BIGINT COMMENT 'Reference to the customer who ordered this wafer fabrication. Relevant for foundry operations and MPW (Multi-Project Wafer) services.',
    `fab_facility_id` BIGINT COMMENT 'Reference to the fabrication facility where this wafer is being processed. Supports multi-site operations and capacity planning.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Reference to the process route or recipe that defines the sequence of fabrication steps for this wafer. Routes vary by product technology node and design.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Wafer references a technology node; add FK to technology_node and remove numeric node column.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the parent wafer lot that this wafer belongs to. Wafers are processed in lots through the FAB (Fabrication Facility).',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Needed for Yield Analysis linking each wafer to its IC product for defect tracking.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the IC (Integrated Circuit) design project that this wafer is fabricating. Links to design specifications, GDS (Graphic Data System) files, and tapeout records.',
    `mask_set_id` BIGINT COMMENT 'Reference to the photomask set used for lithography steps on this wafer. Each mask set corresponds to a specific design and technology node.',
    `belongs_to_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Every wafer must reference its parent lot. This is the most fundamental relationship in FAB WIP tracking - wafers are always tracked within the context of their lot.',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer completed all FAB (Fabrication Facility) process steps and is ready for wafer probing or shipment to OSAT (Outsourced Semiconductor Assembly and Test). Null for in-process wafers.',
    `critical_defect_count` STRING COMMENT 'Number of critical defects that are likely to cause die failure. Subset of total defect count, used for yield prediction and SPC (Statistical Process Control).',
    `crystal_orientation` STRING COMMENT 'Crystallographic orientation of the silicon wafer surface, specified using Miller indices. <100> is most common for CMOS (Complementary Metal-Oxide-Semiconductor) fabrication.. Valid values are `100|110|111`',
    `current_operation_number` STRING COMMENT 'Sequential operation number in the process route that the wafer is currently at. Used for tracking progress through the hundreds of steps in IC (Integrated Circuit) fabrication.',
    `current_process_step` STRING COMMENT 'Name or code of the current fabrication process step the wafer is at or has completed. Examples: lithography, CVD (Chemical Vapor Deposition), CMP (Chemical Mechanical Planarization), ion implantation.',
    `defect_count` STRING COMMENT 'Total number of defects detected on the wafer surface through inspection systems. Tracked across process steps to monitor yield and process control.',
    `diameter_mm` STRING COMMENT 'Diameter of the wafer in millimeters. Standard sizes include 150mm (6 inch), 200mm (8 inch), and 300mm (12 inch). Larger diameters enable more dies per wafer.',
    `disposition_status` STRING COMMENT 'Current disposition status of the wafer in the FAB (Fabrication Facility) workflow. Tracks lifecycle state from WIP (Work in Process) through completion or scrap.. Valid values are `in_process|completed|scrapped|quarantined|on_hold|awaiting_inspection`',
    `doping_type` STRING COMMENT 'Electrical doping type of the substrate. P-type (boron-doped) or N-type (phosphorus/arsenic-doped) determines the majority carrier type. Intrinsic wafers are undoped.. Valid values are `p_type|n_type|intrinsic`',
    `epitaxial_layer_flag` BOOLEAN COMMENT 'Indicates whether the wafer has an epitaxial layer grown on the substrate. Epitaxial wafers have a thin crystalline layer with controlled properties for advanced device fabrication.',
    `epitaxial_resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'Electrical resistivity of the epitaxial layer in ohm-centimeters, if present. Null for non-epitaxial wafers. Often differs from substrate resistivity.',
    `epitaxial_thickness_um` DECIMAL(18,2) COMMENT 'Thickness of the epitaxial layer in micrometers, if present. Null for non-epitaxial wafers. Typical range: 1-20 micrometers.',
    `expected_die_count` STRING COMMENT 'Expected number of dies (individual chips) on this wafer based on die size and wafer diameter. Used for yield calculation and planning.',
    `genealogy_path` STRING COMMENT 'Hierarchical path tracking the wafer lineage from ingot to lot to wafer. Enables traceability for quality investigations and compliance. Format varies by MES (Manufacturing Execution System).',
    `good_die_count` STRING COMMENT 'Actual number of dies that passed electrical testing and quality inspection. Populated after wafer probing and testing. Used to calculate wafer yield.',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason for wafer hold or quarantine, if applicable. Examples: out-of-spec measurement, equipment issue, quality investigation. Null for non-held wafers.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent defect inspection or metrology measurement performed on this wafer. Null if no inspection has been performed yet.',
    `last_process_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent process step or operation performed on this wafer. Used for WIP (Work in Process) tracking and cycle time analysis.',
    `notch_orientation_degrees` STRING COMMENT 'Angular position of the wafer notch in degrees, used for wafer alignment and orientation during automated processing. Standard is 0 degrees for <110> direction.',
    `priority_level` STRING COMMENT 'Processing priority level for this wafer. Critical and high priority wafers receive expedited processing to meet customer commitments or TTM (Time to Market) requirements.. Valid values are `critical|high|normal|low`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this wafer record was first created in the data system. Audit field for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this wafer record was last updated in the data system. Audit field for data lineage and change tracking.',
    `resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'Electrical resistivity of the wafer substrate in ohm-centimeters. Indicates doping concentration and electrical properties. Typical range: 0.001 to 100+ ohm-cm.',
    `rework_count` STRING COMMENT 'Number of times this wafer has been reworked or reprocessed due to process excursions or quality issues. Tracked for yield analysis and process improvement.',
    `scrap_reason_code` STRING COMMENT 'Code indicating the reason for wafer scrap, if applicable. Examples: excessive defects, process excursion, handling damage, contamination. Null for non-scrapped wafers.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `slot_position` STRING COMMENT 'Physical slot position of the wafer within the carrier or cassette during processing. Used for tracking and automation.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer entered the FAB (Fabrication Facility) and began processing. Marks the beginning of the wafer lifecycle for cycle time tracking.',
    `substrate_type` STRING COMMENT 'Material composition of the wafer substrate. Silicon is most common, but compound semiconductors like GaAs (Gallium Arsenide), SiC (Silicon Carbide), and GaN (Gallium Nitride) are used for specialized applications.. Valid values are `silicon|gallium_arsenide|silicon_carbide|gallium_nitride|sapphire|germanium`',
    `thickness_um` DECIMAL(18,2) COMMENT 'Thickness of the wafer in micrometers. Typical range is 500-800 micrometers depending on diameter and application. Critical for mechanical stability and process control.',
    `wafer_number` STRING COMMENT 'Business identifier for the wafer within its lot. Typically a sequential number or alphanumeric code assigned during lot creation.. Valid values are `^[A-Z0-9]{1,20}$`',
    CONSTRAINT pk_wafer PRIMARY KEY(`wafer_id`)
) COMMENT 'Individual silicon wafer entity within a lot, tracking wafer number, substrate type, diameter, orientation, resistivity, epitaxial layer specs, and current disposition. Enables per-wafer genealogy and yield tracking across all FAB process steps. Sourced from Camstar MES wafer tracking module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` (
    `fabrication_process_recipe_id` BIGINT COMMENT 'Unique identifier for the fabrication process recipe. Primary key for this entity.',
    `equipment_process_recipe_id` BIGINT COMMENT 'Unique identifier for the equipment process recipe record within the fabrication process recipe fabrication entity.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Recipe qualification and change‑control require explicit reference to the PDK version the recipe supports, ensuring process compatibility.',
    `approval_date` DATE COMMENT 'Date when the recipe was formally approved for production use.',
    `approval_status` STRING COMMENT 'Engineering approval status indicating whether the recipe has been reviewed and authorized for use by process engineering and quality teams.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the process engineer or quality manager who approved this recipe for production use.',
    `chamber_configuration` STRING COMMENT 'Specific chamber or module configuration within the equipment where the recipe is executed, enabling multi-chamber tool recipe management.',
    `change_control_reference` STRING COMMENT 'Reference to the Engineering Change Order (ECO) or Product Change Notification (PCN) that authorized the creation or modification of this recipe.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was first created in the MES system.',
    `defect_density_target_per_cm2` DECIMAL(18,2) COMMENT 'Target defect density in defects per square centimeter for wafers processed with this recipe, critical for yield management.',
    `effective_end_date` DATE COMMENT 'Date when this recipe version is superseded or retired. Null indicates the recipe is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this recipe version becomes effective and available for production use.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this recipe complies with environmental regulations including RoHS, REACH, and TSCA for chemical usage and emissions.',
    `equipment_type` STRING COMMENT 'Type or model of fabrication equipment (tool) for which this recipe is designed, such as Applied Materials Centura, Lam Research Flex, or ASML NXT scanner.',
    `fmea_reference` STRING COMMENT 'Reference to the Failure Mode and Effects Analysis (FMEA) document that identifies potential failure modes and mitigation strategies for this recipe.',
    `gas_flow_parameters` STRING COMMENT 'Detailed gas flow settings including gas types, flow rates (sccm), and ratios for CVD, PVD, ALD, and etch processes. Stored as structured text or JSON.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this recipe is subject to International Traffic in Arms Regulations (ITAR) export control restrictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was last modified, supporting change tracking and audit requirements.',
    `power_settings_watts` DECIMAL(18,2) COMMENT 'RF or DC power settings in watts for plasma-based processes such as PVD, etch, and plasma-enhanced CVD.',
    `process_duration_seconds` STRING COMMENT 'Total duration in seconds for the recipe execution from start to completion.',
    `process_layer_type` STRING COMMENT 'Fabrication layer classification: Front End of Line (FEOL) for transistor formation, Middle of Line (MOL) for contacts, or Back End of Line (BEOL) for interconnects.. Valid values are `FEOL|MOL|BEOL`',
    `process_node_nm` STRING COMMENT 'Technology node in nanometers for which this recipe is designed (e.g., 7nm, 5nm, 3nm), indicating the target feature size.',
    `process_operation_type` STRING COMMENT 'Type of FAB operation this recipe defines: Chemical Vapor Deposition (CVD), Physical Vapor Deposition (PVD), Atomic Layer Deposition (ALD), Chemical Mechanical Planarization (CMP), etch, lithography (EUV/DUV), ion implantation, diffusion, oxidation, annealing, or cleaning. [ENUM-REF-CANDIDATE: CVD|PVD|ALD|CMP|etch|lithography|ion_implantation|diffusion|oxidation|annealing|cleaning — 11 candidates stripped; promote to reference product]',
    `process_pressure_torr` DECIMAL(18,2) COMMENT 'Target chamber pressure in Torr for the recipe execution, critical for CVD, PVD, and ALD processes.',
    `process_temperature_celsius` DECIMAL(18,2) COMMENT 'Target process temperature in degrees Celsius for the recipe execution.',
    `product_family` STRING COMMENT 'Product family or IC design family for which this recipe is optimized (e.g., mobile processors, automotive chips, AI accelerators).',
    `qualification_date` DATE COMMENT 'Date when the recipe successfully completed qualification testing and was certified for production.',
    `qualification_status` STRING COMMENT 'Qualification state indicating whether the recipe has passed validation testing and is certified for production use.. Valid values are `not_qualified|in_qualification|qualified|requalification_required`',
    `recipe_code` STRING COMMENT 'Unique alphanumeric code assigned to the recipe for system identification and traceability across MES and ERP systems.',
    `recipe_description` STRING COMMENT 'Detailed textual description of the recipes purpose, process objectives, and special considerations for operators and engineers.',
    `recipe_name` STRING COMMENT 'Human-readable name of the process recipe used for identification and reference by FAB operators and process engineers.',
    `recipe_status` STRING COMMENT 'Current lifecycle status of the recipe: draft (under development), under_review (pending approval), approved (validated but not yet active), active (in production use), suspended (temporarily disabled), or obsolete (retired).. Valid values are `draft|under_review|approved|active|suspended|obsolete`',
    `recipe_version` STRING COMMENT 'Version identifier for the recipe enabling change control and traceability of recipe evolution over time.',
    `requalification_due_date` DATE COMMENT 'Date by which the recipe must be requalified to remain in active production status, per quality management requirements.',
    `safety_classification` STRING COMMENT 'Safety classification indicating special handling requirements: standard, hazardous_material, high_temperature, high_pressure, or toxic_gas.. Valid values are `standard|hazardous_material|high_temperature|high_pressure|toxic_gas`',
    `spc_control_plan_reference` STRING COMMENT 'Reference to the Statistical Process Control (SPC) plan that monitors this recipes performance and detects process drift.',
    `step_sequence_definition` STRING COMMENT 'Ordered sequence of process steps within the recipe, including step names, durations, and parameter transitions. Stored as structured text or JSON.',
    `target_material` STRING COMMENT 'Material being deposited, etched, or processed by this recipe (e.g., silicon dioxide, tungsten, copper, photoresist, low-k dielectric).',
    `target_thickness_nm` DECIMAL(18,2) COMMENT 'Target thickness in nanometers for deposition or remaining thickness after etch/CMP operations.',
    `uniformity_target_percent` DECIMAL(18,2) COMMENT 'Target uniformity percentage for thickness, composition, or other critical parameters across the wafer surface.',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target yield percentage for wafers processed using this recipe, used for performance monitoring and continuous improvement.',
    CONSTRAINT pk_fabrication_process_recipe PRIMARY KEY(`fabrication_process_recipe_id`)
) COMMENT 'Master record for a validated process recipe defining the exact sequence of process parameters, tool settings, gas flows, temperatures, pressures, and timing for a specific FAB operation (CVD, PVD, ALD, CMP, implant, etch, lithography). Includes recipe version history, approval status, change control reference, qualification status, and effective date range. Versioning managed within this entity via version number and effective dates. Sourced from Applied Materials SmartFactory MES recipe management and integrated with engineering change order workflow.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` (
    `fabrication_process_step_id` BIGINT COMMENT 'Unique identifier for the process step within the FAB routing. Primary key for the process step entity.',
    `equipment_group_id` BIGINT COMMENT 'Reference to the equipment group or tool set qualified to run this process step. Enables flexible dispatching across multiple qualified tools.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Reference to the parent process flow routing that contains this step. Links the step to its overall manufacturing route.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Reference to the target process recipe that defines the detailed parameters, settings, and control logic for executing this step on the equipment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Process Step Ownership tracking; accountability and engineering reports need the responsible engineers employee ID.',
    `rework_target_step_id` BIGINT COMMENT 'Reference to the target process step to which lots are routed when rework is triggered from this step. Null if no rework loop exists.',
    `spc_control_plan_id` BIGINT COMMENT 'Linkage to the SPC control plan governing this step. Defines control charts, control limits, sampling rules, and out-of-control response actions.',
    `approval_date` DATE COMMENT 'Date when the process step was approved for production use. Used for change control and audit trails.',
    `approval_status` STRING COMMENT 'Approval workflow status for the process step definition. Tracks engineering change control and qualification approval.. Valid values are `draft|submitted|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the engineer or manager who approved this process step for production use. Used for traceability and accountability.',
    `batch_size` STRING COMMENT 'Number of wafers or lots that can be processed together in a single batch at this step. Null for single-wafer processing steps.',
    `change_control_number` STRING COMMENT 'Engineering change order or change control number associated with the creation or modification of this process step. Links to formal change management process.',
    `cost_center` STRING COMMENT 'Financial cost center to which this process step is allocated for cost accounting and budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was first created in the system. Used for audit trails and data lineage.',
    `critical_step_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this step is critical to product quality or yield. Critical steps require enhanced monitoring, control, and approval workflows.',
    `effective_end_date` DATE COMMENT 'Date when this process step definition is retired or superseded. Null for currently active steps. Supports historical tracking and version control.',
    `effective_start_date` DATE COMMENT 'Date when this process step definition becomes effective and can be used in production routing. Supports time-based version control.',
    `equipment_class` STRING COMMENT 'Constraint specifying the class or type of equipment required to execute this process step. Used by MES for equipment qualification and dispatching.',
    `inspection_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether inline inspection or metrology is required after this step. True if inspection is mandatory before proceeding to the next step.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this process step record. Used for accountability and audit trails.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was last modified. Used for change tracking and audit trails.',
    `max_queue_time_minutes` DECIMAL(18,2) COMMENT 'Maximum allowable queue time in minutes before the step must be processed or the lot is flagged for hold. Critical for time-sensitive processes.',
    `min_batch_size` STRING COMMENT 'Minimum number of wafers or lots required to start processing at this step. Used for batch tool optimization and scheduling.',
    `operation_type` STRING COMMENT 'High-level classification of the process step into Front End of Line (FEOL), Middle of Line (MOL), or Back End of Line (BEOL) manufacturing phases.. Valid values are `FEOL|MOL|BEOL`',
    `process_category` STRING COMMENT 'Detailed classification of the process step by operation category such as lithography, etch, deposition (CVD/PVD/ALD), Chemical Mechanical Planarization (CMP), ion implant, thermal anneal, clean, wet clean, inspection, or metrology. [ENUM-REF-CANDIDATE: lithography|etch|deposition|CMP|implant|anneal|clean|wet_clean|inspection|metrology — 10 candidates stripped; promote to reference product]',
    `process_subcategory` STRING COMMENT 'Granular subcategory within the process category, such as EUV lithography, DUV lithography, plasma etch, reactive ion etch, CVD, PVD, ALD, etc. Provides detailed process technology classification.',
    `rework_loop_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this step is part of a rework loop. True if the step can route back to an earlier step for defect correction or reprocessing.',
    `sampling_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of lots or wafers that must be sampled for inspection or metrology at this step. Used for statistical quality control.',
    `skip_allowed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this step can be skipped under certain conditions (e.g., engineering wafers, test lots). True if skip is permitted.',
    `standard_queue_time_minutes` DECIMAL(18,2) COMMENT 'Expected queue time in minutes before the step begins processing. Used for scheduling and WIP prediction.',
    `step_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the step type across all FAB operations. Used for cross-facility consistency and reporting.',
    `step_cost_per_wafer` DECIMAL(18,2) COMMENT 'Standard cost per wafer for executing this process step. Used for product costing, yield analysis, and financial planning. Business-confidential financial data.',
    `step_description` STRING COMMENT 'Detailed textual description of the process step, including purpose, key parameters, and special handling instructions for operators and engineers.',
    `step_name` STRING COMMENT 'Human-readable name or identifier for the process step. Used for operator reference and MES display.',
    `step_sequence_number` STRING COMMENT 'Sequential ordering of this step within the process flow routing. Determines the execution order of operations in the FAB.',
    `step_status` STRING COMMENT 'Current lifecycle status of the process step definition. Active steps are in production use; inactive or obsolete steps are retired; engineering steps are under development; pending approval steps await qualification.. Valid values are `active|inactive|engineering|obsolete|pending_approval`',
    `target_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Step-level target cycle time in minutes. Used for capacity planning, scheduling, and WIP flow optimization.',
    `version_number` STRING COMMENT 'Version identifier for the process step definition. Incremented with each engineering change. Supports change control and traceability.',
    CONSTRAINT pk_fabrication_process_step PRIMARY KEY(`fabrication_process_step_id`)
) COMMENT 'Individual process step definition within a process flow routing, specifying step sequence number, operation type (FEOL/MOL/BEOL), process category (lithography, etch, deposition, CMP, implant, anneal, clean, wet clean), target recipe reference, equipment class constraint, SPC control plan linkage, rework loop indicators, and step-level cycle time targets. Forms the authoritative step catalog for all FAB routing and is the granular unit of WIP tracking. Aligned with SEMI E40 process management standard for step-level definition.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` (
    `fabrication_process_flow_id` BIGINT COMMENT 'Unique identifier for the process flow. Primary key for the process flow entity.',
    `cooling_process_flow_id` BIGINT COMMENT 'Identifier for cooling process flow id on the fabrication process flow record.',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) that provides device models, design rules, and technology files for this process flow.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Process Flow Owner is an employee; ownership reports and change‑control need the employee ID.',
    `rule_set_id` BIGINT COMMENT 'Reference to the design rule set (DRC/LVS rules) that physical layouts must comply with for this process flow.',
    `spc_control_plan_id` BIGINT COMMENT 'Reference to the Statistical Process Control (SPC) plan governing in-line monitoring and process control for this flow.',
    `approval_date` DATE COMMENT 'Date when this process flow received formal approval for use in FAB operations.',
    `approved_by` STRING COMMENT 'Name or identifier of the process engineer or manager who approved this process flow for production use.',
    `beol_step_count` STRING COMMENT 'Number of process steps in the Back End Of Line (BEOL) phase covering metal interconnect layers and passivation.',
    `cool_optimization_mode` STRING COMMENT 'The cool optimization mode of the fabrication process flow record in the fabrication domain.',
    `coolant_type` STRING COMMENT 'The coolant type for the fabrication process flow record.',
    `cooling_method` STRING COMMENT 'The cooling method for fabrication process flow.',
    `cooling_optimization_mode` STRING COMMENT 'The cooling optimization mode of the fabrication process flow record in the fabrication domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was first created in the system.',
    `fabrication_process_flow_description` STRING COMMENT 'Detailed textual description of the process flow including its purpose, key characteristics, and intended applications.',
    `effective_end_date` DATE COMMENT 'Date when this process flow is no longer valid for new wafer lot starts. Nullable for flows with indefinite validity.',
    `effective_start_date` DATE COMMENT 'Date when this process flow becomes valid and available for wafer lot routing and WIP scheduling.',
    `environmental_classification` STRING COMMENT 'Environmental and chemical safety classification for materials and processes used in this flow (e.g., RoHS compliant, REACH registered).',
    `estimated_cycle_time_days` DECIMAL(18,2) COMMENT 'Estimated total manufacturing cycle time in days for a wafer lot to complete this entire process flow under normal conditions.',
    `export_control_classification` STRING COMMENT 'Export control classification number (ECCN) or ITAR designation governing international transfer and use of this process technology.',
    `fab_facility_code` STRING COMMENT 'Code identifying the FAB facility or fabrication site where this process flow is executed.',
    `feol_step_count` STRING COMMENT 'Number of process steps in the Front End Of Line (FEOL) phase covering transistor formation and active device fabrication.',
    `flow_code` STRING COMMENT 'Unique business identifier code for the process flow used across FAB operations and MES systems.',
    `flow_name` STRING COMMENT 'Human-readable name of the process flow identifying the manufacturing route.',
    `flow_revision` STRING COMMENT 'Revision identifier tracking version changes to the process flow definition.',
    `flow_status` STRING COMMENT 'Current lifecycle status of the process flow indicating its approval and usage state in FAB operations.. Valid values are `draft|under_review|approved|active|frozen|obsolete`',
    `flow_type` STRING COMMENT 'Classification of the process flow indicating its purpose: standard production, Multi-Project Wafer (MPW), engineering evaluation, qualification, or research and development (R&D).. Valid values are `standard|mpw|engineering|qualification|rnd`',
    `is_customer_specific` BOOLEAN COMMENT 'Boolean flag indicating whether this process flow is customized for a specific customer or represents a standard foundry offering.',
    `last_modified_by` STRING COMMENT 'Name or identifier of the user who last modified this process flow record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was last updated or modified.',
    `lithography_technology` STRING COMMENT 'Primary lithography technology used in critical patterning steps: EUV (Extreme Ultraviolet), DUV (Deep Ultraviolet), immersion, or dry lithography.. Valid values are `euv|duv|immersion|dry`',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers defined in the BEOL portion of this process flow.',
    `mol_step_count` STRING COMMENT 'Number of process steps in the Middle Of Line (MOL) phase covering contact formation and local interconnect.',
    `qualification_completion_date` DATE COMMENT 'Date when the process flow successfully completed qualification testing and was certified for production use.',
    `qualification_status` STRING COMMENT 'Status of the process flow qualification indicating whether it has passed reliability and performance validation testing.. Valid values are `not_started|in_progress|qualified|requalification_required`',
    `requires_nre` BOOLEAN COMMENT 'Boolean flag indicating whether this process flow requires Non-Recurring Engineering (NRE) investment for setup and qualification.',
    `substrate_type` STRING COMMENT 'Type of substrate material used in this process flow (e.g., silicon, silicon-on-insulator, gallium arsenide, silicon carbide).',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target yield percentage (good dies per wafer) expected for wafer lots processed through this flow. Business-sensitive manufacturing performance metric.',
    `technology_node` STRING COMMENT 'Semiconductor process technology node generation defining the minimum feature size and manufacturing capability (e.g., 5nm, 7nm, 28nm). [ENUM-REF-CANDIDATE: 3nm|5nm|7nm|10nm|14nm|16nm|22nm|28nm|40nm|65nm|90nm|130nm|180nm — 13 candidates stripped; promote to reference product]',
    `total_process_steps` STRING COMMENT 'Total number of discrete process steps defined in this flow spanning FEOL, MOL, and BEOL operations.',
    `transistor_architecture` STRING COMMENT 'Transistor device architecture employed in this process flow: planar MOSFET, FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), or nanosheet.. Valid values are `planar|finfet|gaa|nanosheet`',
    `wafer_size_mm` STRING COMMENT 'Wafer diameter in millimeters that this process flow is designed for (e.g., 200mm, 300mm, 450mm).',
    `waste_elimination_strategy` STRING COMMENT 'The waste elimination strategy of the fabrication process flow record in the fabrication domain.',
    `waste_elimination_target_pct` DECIMAL(18,2) COMMENT 'The waste elimination target pct of the fabrication process flow record in the fabrication domain.',
    CONSTRAINT pk_fabrication_process_flow PRIMARY KEY(`fabrication_process_flow_id`)
) COMMENT 'Ordered sequence of process steps defining the complete manufacturing route for a product on a given technology node. Captures flow revision, node generation (e.g., 5nm, 7nm, 28nm), flow type (standard, MPW, engineering), effective dates, and approval status. SSOT for FAB routing and WIP scheduling. Aligned with SEMI E40 process management standard for flow-level routing definition.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` (
    `lot_move_id` BIGINT COMMENT 'Unique identifier for the lot move transaction. Primary key for this WIP (Work in Process) lot movement event through a FAB (Fabrication Facility) process step.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Internal cost tracking of lot movements charges labor and handling to the appropriate cost center.',
    `employee_id` BIGINT COMMENT 'Identifier for the FAB (Fabrication Facility) operator or technician who executed or supervised this lot move. Links to workforce/employee master data.',
    `equipment_run_id` BIGINT COMMENT 'FK to fabrication.equipment_run.equipment_run_id — Each lot move through a process step is executed via an equipment run. Links WIP tracking to process execution for traceability.',
    `fab_tool_id` BIGINT COMMENT 'Identifier for the FAB (Fabrication Facility) equipment or tool used to process this lot move (e.g., ATE (Automatic Test Equipment), lithography stepper, etcher, deposition chamber). Links to equipment master data.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier for the IC (Integrated Circuit) product or device being manufactured in this lot. Links to product master data (e.g., SoC (System on Chip), ASIC (Application-Specific Integrated Circuit), FPGA (Field-Programmable Gate Array)).',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Lot move corresponds to a specific process step; linking supports operation tracking and step‑level performance reporting.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the WIP (Work in Process) lot being moved. References the wafer lot entity tracked through the FAB (Fabrication Facility).',
    `recipe_id` BIGINT COMMENT 'Identifier for the process recipe executed during this lot move. Defines the specific parameter set, process conditions, and control settings used for this operation.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier for the specific process chamber or module within the equipment used for this lot move. Relevant for multi-chamber tools (e.g., CVD (Chemical Vapor Deposition), PVD (Physical Vapor Deposition), ALD (Atomic Layer Deposition) systems).',
    `order_id` BIGINT COMMENT 'Identifier for the manufacturing work order or production order associated with this lot move. Links to ERP (Enterprise Resource Planning) or MES (Manufacturing Execution System) work order master data.',
    `actual_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Actual gas flow rate in SCCM (Standard Cubic Centimeters per Minute) for process gases during this lot move. Critical parameter for deposition and etch processes.',
    `actual_power_watts` DECIMAL(18,2) COMMENT 'Actual RF (Radio Frequency) or DC power in watts applied during this lot move. Critical parameter for plasma processes (etch, PVD (Physical Vapor Deposition), PECVD (Plasma-Enhanced Chemical Vapor Deposition)).',
    `actual_pressure_torr` DECIMAL(18,2) COMMENT 'Actual process chamber pressure in Torr recorded during this lot move. Critical parameter for vacuum processes (PVD (Physical Vapor Deposition), CVD (Chemical Vapor Deposition), etch, implant).',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Actual process temperature in degrees Celsius recorded during this lot move. Critical parameter for thermal processes (CVD (Chemical Vapor Deposition), diffusion, anneal, oxidation).',
    `at_step` BIGINT COMMENT 'FK to fabrication.process_step.process_step_id — Every lot move occurs at a specific process step. This links the transaction to the routing position.',
    `comments` STRING COMMENT 'Free-text comments or notes entered by the operator or engineer regarding this lot move. Captures contextual information, issues, or special handling instructions.',
    `control_job_code` STRING COMMENT 'Identifier for the MES (Manufacturing Execution System) control job that orchestrated this lot move. Links to the higher-level job or batch execution context in Camstar MES or SmartFactory MES.. Valid values are `^[A-Z0-9_-]{4,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot move record was first created in the source system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for data lineage and audit trail.',
    `defect_count` STRING COMMENT 'Number of defects detected during or after this lot move, as reported by inline inspection or metrology systems. Used for yield analysis and SPC (Statistical Process Control).',
    `disposition` STRING COMMENT 'Quality disposition or pass/fail outcome of the lot move. Determines whether the lot proceeds to the next step, requires rework, is scrapped, or is placed on hold for further inspection.. Valid values are `pass|fail|rework|scrap|hold|conditional_pass`',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason for a lot hold, if applicable (e.g., quality issue, equipment failure, engineering review, customer request). Empty if lot is not on hold.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot move record was last updated in the source system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and data synchronization.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the measurement_value field (e.g., nm (nanometers), um (micrometers), angstrom, ohm-cm (resistivity), percent, ppm (parts per million)).. Valid values are `nm|um|angstrom|ohm_cm|percent|ppm`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Primary metrology measurement value captured during this lot move (e.g., film thickness, CD (Critical Dimension), overlay, resistivity). Unit of measure is context-dependent on the operation type.',
    `move_in_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot was moved into the process step or equipment. Marks the start of processing for this operation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `move_out_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot was moved out of the process step or equipment. Marks the completion of processing for this operation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `move_status` STRING COMMENT 'Current lifecycle status of the lot move transaction. Indicates whether the move completed successfully, is still in progress, was aborted, held for review, or skipped.. Valid values are `completed|in_progress|aborted|held|skipped`',
    `priority_code` STRING COMMENT 'Scheduling priority level for this lot move. Hot and expedite lots receive preferential processing to meet urgent customer commitments or TTM (Time to Market) targets.. Valid values are `hot|expedite|normal|low`',
    `process_layer` STRING COMMENT 'Manufacturing layer classification for this process step. FEOL (Front End of Line) covers transistor formation, MOL (Middle of Line) covers contacts, BEOL (Back End of Line) covers interconnects and metallization.. Valid values are `FEOL|MOL|BEOL`',
    `process_module` STRING COMMENT 'High-level process module category for this operation (e.g., lithography, etch, deposition, ion implantation, CMP (Chemical Mechanical Planarization), diffusion, metrology, inspection, test). [ENUM-REF-CANDIDATE: lithography|etch|deposition|implant|CMP|diffusion|metrology|inspection|test — 9 candidates stripped; promote to reference product]',
    `process_time_seconds` STRING COMMENT 'Actual processing time in seconds for this lot move, calculated as the duration between move-in and move-out timestamps. Used for cycle time analysis and equipment utilization tracking.',
    `quantity_in` STRING COMMENT 'Number of wafers or units in the lot at move-in. Represents the starting quantity before processing.',
    `quantity_out` STRING COMMENT 'Number of wafers or units in the lot at move-out. Represents the ending quantity after processing. May differ from quantity_in due to scrap, breakage, or sampling.',
    `queue_time_seconds` STRING COMMENT 'Time in seconds the lot spent waiting in queue before move-in. Measures WIP (Work in Process) wait time and identifies bottlenecks in the FAB (Fabrication Facility) flow.',
    `recipe_version` STRING COMMENT 'Version number of the process recipe executed. Tracks recipe revisions and enables traceability for process changes and yield analysis.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `rework_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this lot move is a rework operation (True) or a first-pass operation (False). Rework lots are reprocessed due to defects or out-of-spec conditions.',
    `sampling_flag` BOOLEAN COMMENT 'Boolean flag indicating whether wafers were sampled from this lot during this move (True) for destructive testing, metrology, or inspection. False if no sampling occurred.',
    `scrap_quantity` STRING COMMENT 'Number of wafers or units scrapped during this lot move due to breakage, defects, or process failures. Used for yield loss tracking and DPPM (Defective Parts Per Million) calculation.',
    `technology_node` STRING COMMENT 'Process technology node for this lot (e.g., 5nm, 7nm, 14nm, 28nm, 180nm). Defines the minimum feature size and process generation.. Valid values are `^[0-9]{1,3}nm$|^[0-9]{1,3}um$`',
    `tracks_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Every lot move transaction must reference the lot being moved. Core MES transaction integrity — cannot track WIP without this FK.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafers in this lot in millimeters (e.g., 200mm, 300mm, 450mm). Standard wafer size for the FAB (Fabrication Facility).',
    CONSTRAINT pk_lot_move PRIMARY KEY(`lot_move_id`)
) COMMENT 'Transactional record of each WIP lot movement through a process step in the FAB, capturing move-in timestamp, move-out timestamp, operator ID, equipment used, recipe executed, actual process parameters, pass/fail disposition, and quantity in/out. Core MES transaction sourced from Camstar MES and SmartFactory MES. Enables cycle time analysis and WIP genealogy.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` (
    `wafer_start_id` BIGINT COMMENT 'Unique identifier for the wafer start transaction. Primary key for the wafer start record.',
    `photomask_id` BIGINT COMMENT 'Identifier for the photomask set (reticle set) used for lithography steps in this wafer lot. Links to the physical layout and GDS data.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Identifier for the manufacturing process flow (recipe sequence) that this wafer lot will follow. Defines the FEOL, MOL, and BEOL steps.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Supports Wafer Start Scheduling report tying start orders to the IC catalog entry.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Needed for Wafer Start Material Certification process, tying each wafer start to the supplied material master record for quality and compliance tracking.',
    `mpw_shuttle_id` BIGINT COMMENT 'Identifier for the MPW shuttle run if this wafer start combines multiple customer designs on shared wafers. Null for dedicated production lots.',
    `employee_id` BIGINT COMMENT 'User ID of the production planner or manufacturing engineer who authorized this wafer start. Used for accountability and audit trail.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Project‑level production scheduling and cost allocation depend on associating each wafer start order with the research project that requested it.',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Required for Wafer Start Planning report linking each wafer start to its originating sales order, enabling traceability from order to production schedule.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer start was formally authorized in the MES system. Precedes the actual release to the FAB line.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this wafer start record was first created in the MES database. Used for audit trail and data lineage.',
    `creates_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Wafer start transaction creates a new lot. Required for lot lifecycle tracking from inception.',
    `crystal_orientation` STRING COMMENT 'Crystallographic orientation of the silicon wafer, expressed in Miller indices (e.g., <100>, <111>). Affects electrical properties and process compatibility.. Valid values are `^<[0-9]{3}>$`',
    `doping_type` STRING COMMENT 'Electrical doping type of the starting wafer substrate: p-type (boron-doped), n-type (phosphorus or arsenic-doped), or intrinsic (undoped).. Valid values are `p_type|n_type|intrinsic`',
    `ear_classification` STRING COMMENT 'Export Control Classification Number (ECCN) under EAR for this product. Format: 5-character code (e.g., 3A001). Null if not export-controlled.. Valid values are `^[0-9][A-Z][0-9]{3}$`',
    `estimated_cycle_time_days` DECIMAL(18,2) COMMENT 'Planned total cycle time from wafer start to completion, measured in days. Based on standard process flow duration and current FAB loading.',
    `fab_facility_code` STRING COMMENT 'Identifier for the fabrication facility where this wafer lot is being processed. Used for multi-site capacity planning and yield tracking.. Valid values are `^FAB[0-9]{2,4}$`',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason for placing this wafer start on hold, if applicable. Examples: quality issue, material shortage, engineering review, customer request.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `itar_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this wafer lot contains ITAR-controlled technology requiring export compliance controls. True if ITAR applies; False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this wafer start record was last updated. Tracks the most recent change to any field in the record.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier assigned to the wafer batch at start. This is the primary tracking identifier throughout FAB operations.. Valid values are `^[A-Z0-9]{8,16}$`',
    `nre_project_code` STRING COMMENT 'Reference to the NRE project if this wafer start is part of a customer-funded development program. Used for cost tracking and milestone billing.. Valid values are `^NRE[A-Z0-9]{6,12}$`',
    `parent_lot_number` STRING COMMENT 'Lot number of the parent lot if this wafer start is a split or rework from an existing lot. Null for original starts. Enables wafer genealogy tracking.. Valid values are `^[A-Z0-9]{8,16}$`',
    `planned_completion_date` DATE COMMENT 'Target date for completing all FAB processing steps and releasing the lot to wafer test. Based on standard cycle time for the process flow.',
    `priority_class` STRING COMMENT 'Scheduling priority for this wafer lot in the FAB line. Hot lots receive expedited processing; engineering lots may have flexible timing; standard and low follow normal queue discipline.. Valid values are `hot|standard|engineering|low`',
    `production_line` STRING COMMENT 'Specific production line or bay within the FAB facility assigned to this wafer start. Determines equipment set and process capability.. Valid values are `^LINE[A-Z0-9]{2,6}$`',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot was physically released into the FAB line and began processing. Marks the start of cycle time measurement.',
    `requested_delivery_date` DATE COMMENT 'Customer-requested delivery date for finished wafers or packaged units. Drives priority and scheduling decisions.',
    `resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'Electrical resistivity of the starting wafer substrate, measured in ohm-centimeters. Indicates doping concentration and electrical characteristics.',
    `special_instructions` STRING COMMENT 'Free-text field for any special handling instructions, process deviations, or notes that operators and engineers should be aware of for this wafer lot.',
    `split_reason` STRING COMMENT 'Free-text explanation of why this lot was split from a parent lot, if applicable. Examples: process experiment, capacity balancing, quality segregation.',
    `start_creates_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Wafer start transactions create/authorize new lots. This links lot creation to the lot master.',
    `substrate_type` STRING COMMENT 'Type of semiconductor substrate material used for this wafer lot. Silicon is standard; SOI (Silicon on Insulator), GaAs (Gallium Arsenide), GaN (Gallium Nitride), and SiC (Silicon Carbide) are specialty materials.. Valid values are `silicon|soi|gaas|gan|sic`',
    `technology_node` STRING COMMENT 'Process technology node for this wafer start, expressed in nanometers (e.g., 7nm, 5nm, 3nm). Determines the process recipe and equipment set.. Valid values are `^[0-9]+(nm|NM)$`',
    `wafer_quantity` STRING COMMENT 'Number of wafers authorized and started in this lot. Represents the initial wafer count at FAB entry before any processing losses.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafer in millimeters. Standard values are 200mm or 300mm. Determines compatible equipment and process chambers.',
    `wafer_start_date` DATE COMMENT 'Calendar date when the wafer lot was authorized and initiated into the FAB line. Principal business event timestamp for capacity planning and WIP tracking.',
    `wafer_start_number` STRING COMMENT 'Business identifier for the wafer start transaction, externally visible and used for tracking and reporting. Format: WS followed by 10 digits.. Valid values are `^WS[0-9]{10}$`',
    `wafer_start_status` STRING COMMENT 'Current lifecycle status of the wafer start transaction. Authorized: approved but not yet released; Released: entered FAB line; In Process: active WIP; Completed: all steps finished; Cancelled: terminated before completion; On Hold: temporarily suspended.. Valid values are `authorized|released|in_process|completed|cancelled|on_hold`',
    `wafer_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the wafer lot was released into the FAB line, including time zone. Used for detailed cycle time analysis and shift-level tracking.',
    `wafer_start_type` STRING COMMENT 'Classification of the wafer start purpose: production (customer orders), engineering (process development), qualification (product validation), MPW (multi-project wafer), pilot (pre-production), or rework (reprocessing).. Valid values are `production|engineering|qualification|mpw|pilot|rework`',
    `work_center` STRING COMMENT 'SAP work center code representing the initial processing area for this wafer start. Used for capacity planning and cost allocation.. Valid values are `^WC[0-9]{4}$`',
    CONSTRAINT pk_wafer_start PRIMARY KEY(`wafer_start_id`)
) COMMENT 'Transactional record authorizing and recording the initiation of a new wafer lot into the FAB line, capturing wafer start date, authorized quantity, product code, technology node, priority class, customer order reference, and wafer start type (production, engineering, qualification, MPW). SSOT for FAB capacity consumption and WIP entry.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` (
    `fabrication_lot_hold_id` BIGINT COMMENT 'Unique identifier for the fabrication lot hold event record.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom the lot is being fabricated, relevant for customer-initiated holds or customer notification.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who approved the hold release.',
    `fab_facility_id` BIGINT COMMENT 'Reference to the fabrication facility where the hold event occurred.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the equipment unit associated with the hold event, if applicable (e.g., tool that triggered the excursion).',
    `fabrication_process_step_id` BIGINT COMMENT 'Reference to the specific process step (FEOL, MOL, BEOL operation) where the lot was held.',
    `inventory_lot_hold_id` BIGINT COMMENT 'add column inventory_lot_hold_id (BIGINT) with FK to inventory.inventory_lot_hold.inventory_lot_hold_id - establish clear SSOT relationship where inventory owns hold records',
    `primary_fabrication_employee_id` BIGINT COMMENT 'Employee or operator identifier who placed the hold on the lot.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that is placed on hold.',
    `sku_id` BIGINT COMMENT 'Reference to the product (IC design, SoC, ASIC) being fabricated in the lot under hold.',
    `approval_required` BOOLEAN COMMENT 'Indicator whether management or engineering approval is required before the hold can be released.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the hold release was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was first created in the data system.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicator whether the customer must be notified of this hold event per contractual or quality agreement terms.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified of the hold event.',
    `defect_density_threshold_exceeded` BOOLEAN COMMENT 'Indicator whether the hold was triggered by defect density exceeding acceptable limits.',
    `disposition_action` STRING COMMENT 'Action taken upon hold release or closure (resume normal processing, rework, scrap, quarantine, return to customer, engineering review).. Valid values are `resume|rework|scrap|quarantine|return_to_customer|engineering_review`',
    `disposition_notes` STRING COMMENT 'Free-text notes documenting the disposition decision, corrective actions taken, or investigation findings.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator whether the hold has been escalated to senior engineering or management for resolution.',
    `hold_cycle_time_hours` DECIMAL(18,2) COMMENT 'Duration in hours between hold placement and release, used for cycle time tracking and excursion management KPIs.',
    `hold_expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the hold automatically expires if not explicitly released or extended, used for time-bound holds.',
    `hold_placement_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was placed on the lot, representing the principal business event timestamp.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the reason for placing the lot on hold (e.g., process excursion, quality issue, engineering investigation, customer request).',
    `hold_reason_description` STRING COMMENT 'Detailed textual description of the reason for the hold, providing additional context beyond the reason code.',
    `hold_release_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was released and the lot was cleared to resume processing. Null if hold is still active.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold event (active, released, cancelled, expired).. Valid values are `active|released|cancelled|expired`',
    `hold_type` STRING COMMENT 'Classification of the hold event by functional area or trigger source (engineering, quality, process excursion, customer, equipment, material, safety). [ENUM-REF-CANDIDATE: engineering|quality|process_excursion|customer|equipment|material|safety — 7 candidates stripped; promote to reference product]',
    `initiating_system` STRING COMMENT 'Name or identifier of the system that triggered the hold event (e.g., MES, SPC, ATE, manual entry).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was last updated in the data system.',
    `lot_number` STRING COMMENT 'Business identifier for the wafer lot under hold, typically assigned by MES system.',
    `mes_transaction_code` STRING COMMENT 'Unique transaction identifier from the MES system that recorded this hold event.',
    `ncr_number` STRING COMMENT 'Non-conformance report number associated with the hold event, if a formal NCR was raised.',
    `priority_level` STRING COMMENT 'Urgency classification for resolving the hold (critical, high, medium, low), used for escalation and resource allocation.. Valid values are `critical|high|medium|low`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause determined during investigation (e.g., equipment malfunction, operator error, material defect).',
    `spc_rule_violation` STRING COMMENT 'Specific SPC rule that was violated and triggered the hold (e.g., Western Electric Rule 1, 2, 3, 4).',
    `wafer_count` STRING COMMENT 'Number of wafers in the lot at the time the hold was placed.',
    CONSTRAINT pk_fabrication_lot_hold PRIMARY KEY(`fabrication_lot_hold_id`)
) COMMENT 'Transactional record capturing all hold events placed on a wafer lot, including hold reason code, hold type (engineering, quality, process excursion, customer), initiating system or operator, hold placement timestamp, release timestamp, and disposition action taken. Enables hold cycle time tracking and excursion management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` (
    `lot_disposition_id` BIGINT COMMENT 'Unique identifier for the lot disposition record. Primary key for the lot disposition entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lot disposition approvals are recorded; linking to employee supports traceability and financial liability reports.',
    `capa_record_id` BIGINT COMMENT 'Identifier of the associated corrective action record if corrective action is required. Links to the corrective action entity for CAPA tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial reporting of lot disposition costs requires linking each disposition to the responsible cost center for expense allocation.',
    `equipment_fab_id` BIGINT COMMENT 'Identifier of the fabrication facility where the disposition decision was made. Links to the fab entity for multi-site operations.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fabrication equipment associated with the disposition event. Links to the equipment entity for equipment-related root causes.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Identifier of the rework process route assigned to the lot if disposition type is rework. Defines the sequence of process steps for lot recovery.',
    `fabrication_process_step_id` BIGINT COMMENT 'Identifier of the fabrication process step where the issue triggering disposition was detected. Links to the process step entity.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot subject to this disposition decision. Links to the wafer lot entity in the fabrication domain.',
    `sku_id` BIGINT COMMENT 'Identifier of the target product specification if disposition type is downgrade. Represents the lower-grade product to which the lot is reassigned.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production area where the disposition event occurred. Links to the work center entity for area-level tracking.',
    `affected_wafer_count` STRING COMMENT 'Number of wafers in the lot subject to this disposition decision. Represents the quantity of wafers impacted by the disposition action.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition decision was approved. Represents the moment of final authorization.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether a formal corrective action is required to prevent recurrence. Triggers Corrective and Preventive Action (CAPA) workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition record was first created in the system. Audit field for record creation tracking.',
    `customer_approval_received` BOOLEAN COMMENT 'Flag indicating whether customer approval has been received for ship-as-is or downgrade dispositions. Applicable when customer notification is required.',
    `customer_notification_required` BOOLEAN COMMENT 'Flag indicating whether customer notification is required for this disposition decision. True if Product Change Notification (PCN) or customer approval is needed.',
    `defect_code` STRING COMMENT 'Standardized defect classification code from the fab defect taxonomy. Links to the defect type reference table for detailed defect characteristics.',
    `defect_die_count` STRING COMMENT 'Total number of defective or failing die across all wafers in the lot at the time of disposition. Used for yield loss analysis.',
    `disposition_authority` STRING COMMENT 'Name or identifier of the person, role, or system that authorized the disposition decision. Typically a quality engineer, production supervisor, or automated MES rule.',
    `disposition_authority_role` STRING COMMENT 'Organizational role of the disposition authority. Defines the level of authorization for the disposition decision.. Valid values are `quality_engineer|production_supervisor|process_engineer|fab_manager|automated_system`',
    `disposition_date` DATE COMMENT 'Date when the disposition decision was made. Business event date for the disposition action.',
    `disposition_notes` STRING COMMENT 'Free-text notes and comments related to the disposition decision. Captures additional context, special instructions, or engineering judgment.',
    `disposition_number` STRING COMMENT 'Externally-known business identifier for the disposition decision. Format: DISP-YYYYMMDD-XXXXXX where YYYYMMDD is date and XXXXXX is sequence.. Valid values are `^DISP-[0-9]{8}-[A-Z0-9]{6}$`',
    `disposition_of_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Disposition decisions reference the lot being dispositioned. Required for lot closure and yield accounting.',
    `disposition_status` STRING COMMENT 'Current lifecycle status of the disposition decision. Pending: awaiting approval. Approved: authorized for execution. Rejected: disposition denied. Executed: disposition action completed. Cancelled: disposition voided.. Valid values are `pending|approved|rejected|executed|cancelled`',
    `disposition_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the disposition decision was recorded in the Manufacturing Execution System (MES). Captures exact moment of disposition event.',
    `disposition_type` STRING COMMENT 'Type of disposition decision applied to the lot. Accept: lot meets specifications and proceeds. Scrap: lot is discarded. Rework: lot requires reprocessing. Downgrade: lot is reassigned to lower grade. Hold: lot is quarantined pending review. Ship-as-is: lot ships with known deviations under waiver.. Valid values are `accept|scrap|rework|downgrade|hold|ship_as_is`',
    `executed_by` STRING COMMENT 'Name or identifier of the person or system that executed the disposition action. Captures who performed the physical disposition.',
    `executed_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition action was physically executed. Represents the moment when the lot was scrapped, moved to rework, or released.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the disposition decision in USD. Includes scrap cost, rework cost, or revenue loss from downgrade. Used for cost accounting and yield loss reporting.',
    `good_die_count` STRING COMMENT 'Total number of Known Good Die (KGD) across all wafers in the lot at the time of disposition. Used for yield accounting and financial valuation.',
    `hold_reason_code` STRING COMMENT 'Standardized reason code for hold disposition. Links to the hold reason reference table for detailed hold classification and tracking.',
    `lot_yield_percent` DECIMAL(18,2) COMMENT 'Calculated yield percentage for the lot at disposition time. Represents the ratio of good die to total die, expressed as a percentage.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition record was last modified. Audit field for change tracking and data lineage.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause that triggered the disposition decision. Used for Failure Mode and Effects Analysis (FMEA) and continuous improvement.. Valid values are `equipment_failure|process_deviation|material_defect|operator_error|design_issue|contamination`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings. Captures the specific failure mode, contributing factors, and technical details.',
    `scrap_reason_code` STRING COMMENT 'Standardized reason code for scrap disposition. Links to the scrap reason reference table for detailed scrap classification and reporting.',
    `waiver_number` STRING COMMENT 'Engineering waiver authorization number if disposition type is ship-as-is. Format: WVR-YYYYMMDD-XXXX. Authorizes shipment of lot with known deviations.. Valid values are `^WVR-[0-9]{8}-[A-Z0-9]{4}$`',
    CONSTRAINT pk_lot_disposition PRIMARY KEY(`lot_disposition_id`)
) COMMENT 'Transactional record of final or interim lot disposition decisions including scrap, rework, accept, downgrade, or ship-as-is. Captures disposition type, disposition authority, disposition date, affected wafer count, yield impact, and root cause classification. Authoritative record for lot closure and yield accounting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` (
    `fab_run_card_id` BIGINT COMMENT 'Unique identifier for the fabrication run card. Primary key for the fab run card entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom this lot is being fabricated. Enables tracking of customer-specific requirements and instructions.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Run Card approval must be traceable to an employee for quality and compliance audits.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Run card execution costs are charged to a cost center for budgeting and variance analysis.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export Control compliance requires each fab run card to reference the export license authorizing production of the controlled technology, used in Export License Management reports.',
    `fab_facility_id` BIGINT COMMENT 'Reference to the fabrication facility where this run card is executed. Supports multi-site manufacturing operations.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Reference to the approved process flow that defines the sequence of fabrication steps (Front End of Line (FEOL), Middle of Line (MOL), Back End of Line (BEOL)) for this wafer lot.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Run card includes technology node information; replace string column with FK to technology_node.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that this run card governs. Links the run card to the specific lot being processed through the fabrication line.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the product being manufactured. Links the run card to the specific Integrated Circuit (IC), System on Chip (SoC), or Application-Specific Integrated Circuit (ASIC) design.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the specific IC design project or tapeout that this run card supports. Links to the Register Transfer Level (RTL), Graphic Data System II (GDSII), and Process Design Kit (PDK) used.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center performance reporting includes fab run card production output and associated revenue.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this run card was formally approved for manufacturing execution. Marks the transition from draft to approved status.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot completed all process steps defined in this run card. Marks the end of the fabrication cycle. Null if lot is still in process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this run card record was first created in the Manufacturing Execution System (MES). Audit trail for record creation.',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Actual or planned cycle time for this run card from start to completion, measured in days. Key metric for manufacturing efficiency and Time to Market (TTM).',
    `deviation_description` STRING COMMENT 'Detailed description of any engineering deviations, process exceptions, or non-standard procedures authorized for this run card. Null if no deviations exist.',
    `deviation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this run card contains any approved engineering deviations from the standard process flow. True indicates deviations are present.',
    `ear_classification` STRING COMMENT 'Export Administration Regulations (EAR) classification code for this run card, if applicable. Governs export control compliance for semiconductor technology.',
    `eco_number` STRING COMMENT 'Reference number of the Engineering Change Order (ECO) associated with this run card, if applicable. Links to formal change management documentation.',
    `hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether this run card is currently under a manufacturing hold. True indicates the lot cannot proceed until the hold is released.',
    `hold_reason` STRING COMMENT 'Explanation of why the run card is on hold, if applicable. May reference quality issues, engineering review, or customer requests. Null if no hold exists.',
    `itar_controlled` BOOLEAN COMMENT 'Boolean indicator of whether this run card is subject to International Traffic in Arms Regulations (ITAR) export control restrictions. True indicates ITAR-controlled technology.',
    `lot_disposition` STRING COMMENT 'Final disposition status of the wafer lot upon run card completion: pass (meets all specifications), fail (rejected), conditional (partial acceptance), quarantine (under review), or scrap (discarded).. Valid values are `pass|fail|conditional|quarantine|scrap`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this run card record was last modified. Audit trail for tracking changes to the run card throughout its lifecycle.',
    `notes` STRING COMMENT 'General notes, comments, or observations recorded during the execution of this run card. Captures operator feedback, process anomalies, or engineering observations.',
    `pcn_number` STRING COMMENT 'Product Change Notification (PCN) number if this run card implements a customer-notified product change. Ensures traceability to customer communications.',
    `priority_level` STRING COMMENT 'Manufacturing priority assigned to this run card. Determines scheduling precedence on the fabrication line. Critical lots receive expedited processing.. Valid values are `critical|high|normal|low`',
    `quality_grade` STRING COMMENT 'Quality and reliability grade for this run card: automotive (IATF 16949 compliant), industrial (extended temperature/reliability), commercial (standard), or consumer (cost-optimized).. Valid values are `automotive|industrial|commercial|consumer`',
    `reach_compliant` BOOLEAN COMMENT 'Boolean indicator of whether the process materials comply with Registration Evaluation Authorization and Restriction of Chemicals (REACH) regulation requirements.',
    `rohs_compliant` BOOLEAN COMMENT 'Boolean indicator of whether the process materials and chemicals used in this run card comply with Restriction of Hazardous Substances (RoHS) directive requirements.',
    `run_card_follows_flow` BIGINT COMMENT 'FK to fabrication.process_flow.process_flow_id — Run cards define the approved process flow for a lot run.',
    `run_card_for_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Run cards (travelers) are associated with specific lots as their manufacturing instructions.',
    `run_card_number` STRING COMMENT 'The externally-known business identifier for this run card. Human-readable traveler document number used by operators and engineers to reference this specific run card.',
    `run_card_specifies_flow` BIGINT COMMENT 'FK to fabrication.process_flow.process_flow_id — Run card defines the approved process flow for the lot. Required for routing compliance verification.',
    `run_card_status` STRING COMMENT 'Current lifecycle status of the run card: draft (being prepared), approved (ready for use), active (lot in process), on_hold (temporarily suspended), completed (lot finished), or cancelled (run card voided).. Valid values are `draft|approved|active|on_hold|completed|cancelled`',
    `run_card_type` STRING COMMENT 'Classification of the run card based on its purpose: production (standard manufacturing), engineering (experimental or test lots), qualification (product validation), rework (reprocessing), pilot (pre-production), or development (process development).. Valid values are `production|engineering|qualification|rework|pilot|development`',
    `run_card_version` STRING COMMENT 'Version number of the run card document. Tracks revisions and updates to the process flow or instructions for this lot.',
    `special_instructions` STRING COMMENT 'Free-text field containing operator instructions, handling requirements, or process notes specific to this run card. May include customer-specific requirements or engineering guidance.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot began processing under this run card. Marks the beginning of the fabrication cycle for this lot.',
    `target_completion_date` DATE COMMENT 'Planned or committed completion date for this run card. Used for scheduling, capacity planning, and customer delivery commitments.',
    `wafer_quantity` STRING COMMENT 'Number of wafers in the lot governed by this run card. Tracks lot size for capacity planning and yield calculations.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafers in this lot, measured in millimeters (e.g., 200mm, 300mm, 450mm). Determines compatible equipment and handling procedures.',
    CONSTRAINT pk_fab_run_card PRIMARY KEY(`fab_run_card_id`)
) COMMENT 'Master traveler document associated with a wafer lot defining the approved process flow, special instructions, engineering deviations, customer-specific requirements, and step-level notes for a given lot run. Captures run card version, approval status, deviation flags, and associated engineering change orders. Sourced from Camstar MES and Oracle Agile PLM.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` (
    `equipment_run_id` BIGINT COMMENT 'Unique identifier for the equipment run. Primary key for this transactional record of a specific tool chamber run executed on a wafer lot or wafer set.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment run cost accounting allocates depreciation and overhead to the cost center responsible for the run.',
    `employee_id` BIGINT COMMENT 'Identifier of the FAB operator who initiated or supervised this equipment run. Used for accountability and training tracking.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fabrication equipment tool that executed this run. Links to the equipment master record.',
    `photomask_id` BIGINT COMMENT 'Identifier of the photomask reticle used in lithography exposure. Links to the photomask asset inventory. Applicable only when process_type is lithography.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'FK to fabrication.fabrication_process_recipe.fabrication_process_recipe_id — Equipment runs execute a specific recipe version. Links actual processing to recipe management.',
    `fabrication_process_step_id` BIGINT COMMENT 'Identifier of the process step within the overall fabrication flow. Links this run to the routing and process flow definition.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot processed in this equipment run. Links to the wafer lot master record for WIP tracking and genealogy.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Supports Equipment Run Material Consumption Log, associating chemicals/materials used in each run with their master record for SPC and safety compliance.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Equipment run must reference the exact process recipe applied; essential for audit, yield analysis, and SPC control.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific process chamber within the equipment tool where this run was executed. Multi-chamber tools may have multiple concurrent runs.',
    `abort_reason` STRING COMMENT 'Reason code or description if the run was aborted or failed. Used for root cause analysis and yield improvement.',
    `actual_pressure_torr` DECIMAL(18,2) COMMENT 'Actual measured chamber pressure in Torr during the run. Used for process control and deviation analysis.',
    `actual_temperature_celsius` DECIMAL(18,2) COMMENT 'Actual measured process temperature in degrees Celsius during the run. Used for process control and deviation analysis.',
    `alarm_count` STRING COMMENT 'Number of equipment alarms triggered during this run. Indicator of process stability and equipment health.',
    `chamber_cooling_temperature_celsius` DECIMAL(18,2) COMMENT 'The chamber cooling temperature celsius for the equipment run.',
    `cmp_removal_rate_angstrom_per_min` DECIMAL(18,2) COMMENT 'Material removal rate during CMP in Angstroms per minute. Critical parameter for planarization control and endpoint detection.',
    `cmp_slurry_type` STRING COMMENT 'Type of slurry used in CMP process (e.g., oxide slurry, tungsten slurry, copper slurry). Applicable only when process_type is CMP.',
    `cmp_wiwnu_percent` DECIMAL(18,2) COMMENT 'Within-wafer non-uniformity percentage for CMP process. Measures variation in material removal across the wafer surface. Lower values indicate better planarization quality.',
    `coolant_flow_rate_lpm` DECIMAL(18,2) COMMENT 'Coolant flow rate, measured in liters per minute, recorded for the equipment run (coolant flow rate lpm).',
    `cooling_rate_celsius_per_min` DOUBLE COMMENT 'The cooling rate celsius per min recorded for the equipment run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment run record was first created in the data platform. Audit trail for data lineage.',
    `deposition_film_material` STRING COMMENT 'Material deposited during CVD, PVD, or ALD runs (e.g., SiO2, Si3N4, TiN, Tungsten, Copper). Applicable for deposition process types.',
    `deposition_rate_angstrom_per_min` DECIMAL(18,2) COMMENT 'Film deposition rate in Angstroms per minute. Used for process control and cycle time optimization.',
    `deposition_thickness_angstrom` DECIMAL(18,2) COMMENT 'Target or measured film thickness in Angstroms deposited during the run. Critical parameter for film uniformity and device performance.',
    `deposition_uniformity_percent` DECIMAL(18,2) COMMENT 'Film thickness uniformity across the wafer expressed as a percentage. Lower values indicate better uniformity. Critical quality metric for deposition processes.',
    `implant_dose_atoms_per_cm2` DECIMAL(18,2) COMMENT 'Total ion dose implanted in atoms per square centimeter. Critical parameter for doping concentration control in ion implantation processes.',
    `implant_energy_kev` DECIMAL(18,2) COMMENT 'Ion beam energy in kiloelectron volts (keV) for ion implantation. Determines the depth of ion penetration into the wafer substrate.',
    `implant_species` STRING COMMENT 'Ion species implanted during ion implantation runs (e.g., Boron, Phosphorus, Arsenic, BF2). Applicable only when process_type is implant.',
    `implant_tilt_angle_degrees` DECIMAL(18,2) COMMENT 'Wafer tilt angle in degrees during ion implantation. Used to control channeling effects and implant profile.',
    `implant_twist_angle_degrees` DECIMAL(18,2) COMMENT 'Wafer twist (rotation) angle in degrees during ion implantation. Used in conjunction with tilt to control channeling effects.',
    `lithography_cd_measurement_nm` DECIMAL(18,2) COMMENT 'Measured critical dimension (CD) in nanometers after lithography exposure and development. Key quality metric for pattern fidelity.',
    `lithography_exposure_dose_mj_per_cm2` DECIMAL(18,2) COMMENT 'Exposure energy dose in millijoules per square centimeter for lithography. Critical parameter for pattern transfer and critical dimension (CD) control.',
    `lithography_focus_offset_nm` DECIMAL(18,2) COMMENT 'Focus offset in nanometers applied during lithography exposure. Used for depth-of-focus optimization and process window control.',
    `lithography_overlay_x_nm` DECIMAL(18,2) COMMENT 'Measured overlay error in the X-axis direction in nanometers. Indicates alignment accuracy between successive lithography layers.',
    `lithography_overlay_y_nm` DECIMAL(18,2) COMMENT 'Measured overlay error in the Y-axis direction in nanometers. Indicates alignment accuracy between successive lithography layers.',
    `mes_transaction_code` STRING COMMENT 'Transaction identifier from the Manufacturing Execution System (MES) that recorded this equipment run. Provides traceability to the source system.',
    `process_type` STRING COMMENT 'Discriminator identifying the category of fabrication process executed in this run. Determines which process-specific parameters are relevant. CVD=Chemical Vapor Deposition, PVD=Physical Vapor Deposition, ALD=Atomic Layer Deposition, CMP=Chemical Mechanical Planarization. [ENUM-REF-CANDIDATE: CVD|PVD|ALD|CMP|implant|etch|lithography|anneal|clean|wet_clean|diffusion|oxidation|metrology — 13 candidates stripped; promote to reference product]',
    `processes_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Equipment run must reference the lot/wafers being processed. Core traceability requirement for process parameter linkage to product.',
    `run_duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the equipment run in seconds, calculated from start to end timestamp. Used for cycle time analysis and equipment utilization metrics.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment run completed processing. Marks the end of the process execution cycle.',
    `run_number` STRING COMMENT 'Business identifier for this equipment run, typically assigned by the Manufacturing Execution System (MES). Used for operational tracking and traceability.',
    `run_processes_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Equipment runs are executed on wafer lots. This is the core tool-to-WIP linkage.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment run started processing. Marks the beginning of the process execution cycle.',
    `run_status` STRING COMMENT 'Current lifecycle status of the equipment run. Indicates whether the run completed successfully, was aborted, failed due to error, is currently in progress, or was paused.. Valid values are `completed|aborted|failed|in_progress|paused`',
    `run_uses_recipe` BIGINT COMMENT 'FK to fabrication.process_recipe.process_recipe_id — Every equipment run executes a specific process recipe. Critical for recipe traceability, excursion investigation, and process control.',
    `target_pressure_torr` DECIMAL(18,2) COMMENT 'Target chamber pressure in Torr as specified by the recipe. Critical control parameter for vacuum and deposition processes.',
    `target_temperature_celsius` DECIMAL(18,2) COMMENT 'Target process temperature in degrees Celsius as specified by the recipe. Critical control parameter for thermal processes.',
    `uses_recipe` BIGINT COMMENT 'FK to fabrication.process_recipe.process_recipe_id — Every equipment run executes a specific recipe. Required for recipe-to-outcome traceability and process capability analysis.',
    `wafer_count` STRING COMMENT 'Number of wafers processed in this equipment run. Batch size for the run.',
    `wafer_slot_map` STRING COMMENT 'Mapping of wafer identifiers to slot positions within the carrier or chamber. Structured representation of wafer placement during processing.',
    `waste_heat_recovered_kwh` DOUBLE COMMENT 'The waste heat recovered kwh of the equipment run record in the fabrication domain.',
    CONSTRAINT pk_equipment_run PRIMARY KEY(`equipment_run_id`)
) COMMENT 'Transactional record of a specific equipment tool run (chamber run, process run) executed on a wafer lot or wafer set. Captures tool ID, chamber ID, run start/end timestamps, recipe name and version, process type discriminator (CVD, PVD, ALD, CMP, implant, etch, lithography, anneal, clean, wet clean), actual vs. target parameter deviations, run status, and wafers processed. Process-type-specific parameters stored as structured attributes: implant (species, dose, energy, tilt, twist, beam current), deposition (film material, thickness, rate, precursor flows, uniformity), CMP (slurry type, removal rate, WIWNU, endpoint detection), lithography (reticle ID, exposure dose, focus offset, overlay, CD measurement). Unified model aligned with SEMI E10/E142 equipment event patterns. SSOT for all FAB process execution records.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` (
    `photomask_id` BIGINT COMMENT 'Primary key for photomask',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key reference to the IC design project for which this mask was created. Links mask to product design lineage and tapeout records.',
    `mask_set_id` BIGINT COMMENT 'Business identifier for the complete mask set to which this photomask belongs. A mask set comprises all reticles required for a complete wafer fabrication process flow.',
    `reticle_set_id` BIGINT COMMENT 'Foreign key linking to fabrication.reticle_set. Business justification: Photomask belongs to a reticle set; adding reticle_set_id FK groups masks for lithography and eliminates reticle_set silo.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Ensures Photomask Supplier Traceability required by mask qualification and export control audits linking each mask to its supplier record.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire this photomask including mask fabrication, OPC, inspection, and shipping. Denominated in USD. Used for asset valuation and depreciation.',
    `cd_uniformity_specification` DECIMAL(18,2) COMMENT 'Maximum allowed CD variation across the mask field in nanometers (3-sigma). Tighter specifications required for advanced nodes. Typical range 1-5nm.',
    `cleaning_cycle_count` STRING COMMENT 'Number of times this mask has undergone wet or dry cleaning to remove particles and contamination. Excessive cleaning can damage mask patterns.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this photomask record was first created in the system. Audit trail for data governance and compliance.',
    `critical_defect_count` STRING COMMENT 'Number of critical (killer) defects that will print on wafer and cause yield loss. Subset of total defect count. Mask must be retired or repaired when this exceeds threshold.',
    `critical_dimension_target_nm` DECIMAL(18,2) COMMENT 'Target critical dimension (minimum feature size) for this mask layer in nanometers. Used to verify mask pattern fidelity and wafer print quality.',
    `cumulative_exposure_hours` DECIMAL(18,2) COMMENT 'Total hours this mask has been exposed to lithography light source (EUV or DUV). Tracks photochemical degradation and pellicle aging.',
    `cumulative_usage_count` STRING COMMENT 'Total number of wafer exposures performed with this mask since first use. Primary metric for mask wear tracking and lifecycle management.',
    `defect_count_last_inspection` STRING COMMENT 'Number of defects detected during the most recent mask inspection. Tracked to monitor mask degradation and determine cleaning or retirement needs.',
    `defect_retirement_threshold` STRING COMMENT 'Maximum critical defect count allowed before mask must be retired or sent for repair. Typically 1-5 defects depending on technology node and layer criticality.',
    `gds_file_checksum` STRING COMMENT 'MD5 or SHA-256 checksum of the GDSII file used to generate this mask. Ensures mask-to-design traceability and detects unauthorized pattern changes.. Valid values are `^[A-F0-9]{32,64}$`',
    `last_cleaning_date` DATE COMMENT 'Date when the mask was last cleaned. Used to schedule preventive cleaning and correlate defect growth with cleaning intervals.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent mask inspection performed by KLA or equivalent metrology tool. Used to enforce periodic inspection schedules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this photomask record was last updated. Tracks data currency and supports change auditing.',
    `layer_name` STRING COMMENT 'Process layer designation for which this photomask is used (e.g., POLY, METAL1, VIA2, CONTACT). Corresponds to the GDS layer in the design database.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `lithography_wavelength` STRING COMMENT 'Exposure wavelength for which this mask is optimized: EUV (13.5nm), DUV ArF (193nm), DUV KrF (248nm), or i-line (365nm).. Valid values are `euv_13.5nm|duv_193nm|duv_248nm|i_line_365nm`',
    `mask_generation` STRING COMMENT 'Generation number of this mask within the mask set. Incremented when a mask is replaced due to defects, pattern revisions, or wear-out. Generation 1 is the original mask.',
    `mask_serial_number` STRING COMMENT 'Unique serial number assigned by the mask shop vendor for traceability and warranty purposes. Engraved on the reticle substrate.. Valid values are `^[A-Z0-9-]{10,25}$`',
    `mask_status` STRING COMMENT 'Current lifecycle status of the photomask: qualified (ready for production), in production (actively used), in inspection, in cleaning, in repair, quarantined (defect investigation), retired (end of life), or scrapped (disposed). [ENUM-REF-CANDIDATE: qualified|in_production|in_inspection|in_cleaning|in_repair|quarantined|retired|scrapped — 8 candidates stripped; promote to reference product]',
    `mask_type` STRING COMMENT 'Classification of photomask technology: binary (chrome on glass), attenuated phase shift mask (PSM), alternating PSM, EUV with pellicle, EUV without pellicle, or OPC-enhanced mask.. Valid values are `binary|attenuated_psm|alternating_psm|euv_pellicle|euv_non_pellicle|optical_proximity_correction`',
    `meef_value` DECIMAL(18,2) COMMENT 'Mask Error Enhancement Factor quantifying how mask pattern errors are amplified on the wafer. Higher MEEF indicates greater sensitivity to mask defects. Typical range 1.0 to 8.0.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory mask inspection. Calculated based on usage count, exposure hours, or calendar interval per mask management policy.',
    `notes` STRING COMMENT 'Free-text field for recording mask-specific observations, special handling instructions, repair history, or other contextual information not captured in structured fields.',
    `opc_version` STRING COMMENT 'Version identifier of the OPC software and recipe used to generate the mask pattern. Critical for mask-to-mask consistency and reticle enhancement technology tracking.. Valid values are `^[A-Z0-9._]{3,20}$`',
    `pellicle_installation_date` DATE COMMENT 'Date when the current pellicle was installed on the mask. Used to track pellicle aging and replacement cycles.',
    `pellicle_status` STRING COMMENT 'Current status of the protective pellicle membrane: installed (protecting mask surface), removed (for inspection or repair), damaged (requires replacement), or not applicable (EUV masks without pellicle).. Valid values are `installed|removed|damaged|not_applicable`',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which this mask was procured. Links mask asset to procurement and financial records.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `qualification_date` DATE COMMENT 'Date when the mask passed final qualification inspection and was approved for production use. Marks the start of the masks production lifecycle.',
    `received_date` DATE COMMENT 'Date when the mask was received from the vendor and logged into the FAB inventory system. Marks the start of the masks asset lifecycle.',
    `registration_error_specification_nm` DECIMAL(18,2) COMMENT 'Maximum allowed pattern placement error relative to alignment marks in nanometers. Critical for layer-to-layer overlay accuracy. Typical range 2-10nm.',
    `retirement_date` DATE COMMENT 'Date when the mask was retired from production due to reaching usage threshold, excessive defects, or process obsolescence. Null if mask is still active.',
    `retirement_reason` STRING COMMENT 'Primary reason for mask retirement: usage limit reached, defect limit exceeded, pattern revision required, process obsolescence, physical damage, or lost/missing.. Valid values are `usage_limit|defect_limit|pattern_revision|process_obsolescence|physical_damage|lost`',
    `storage_location_code` STRING COMMENT 'Code identifying the physical storage location (reticle pod, SMIF pod, or automated reticle storage system slot) where the mask is currently stored when not in use.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `technology_node` STRING COMMENT 'Semiconductor process technology node for which this mask was designed (e.g., 5nm, 7nm, 14nm, 28nm). Defines minimum feature size and design rules.. Valid values are `^[0-9]{1,3}nm$|^[0-9]{1,2}um$`',
    `usage_retirement_threshold` STRING COMMENT 'Maximum cumulative usage count allowed before mask must be retired from production. Defined per technology node and mask type to ensure yield protection.',
    `warranty_expiration_date` DATE COMMENT 'Date when the vendor warranty for this mask expires. After this date, repair or replacement costs are borne by the FAB.',
    CONSTRAINT pk_photomask PRIMARY KEY(`photomask_id`)
) COMMENT 'Master record for photomasks (reticles) used in EUV and DUV lithography operations, capturing mask set ID, layer name, technology node, mask type (binary, PSM, EUV pellicle), OPC version, MEEF value, mask generation, pellicle status, inspection history summary, usage count, cleaning cycle count, and retirement threshold. SSOT for mask inventory, lithography step qualification, and reticle lifecycle management within the FAB.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` (
    `fabrication_lot_genealogy_id` BIGINT COMMENT 'Unique identifier for the fabrication lot genealogy relationship record. Primary key for the association entity.',
    `account_id` BIGINT COMMENT 'Identifier of the customer for whom the lot genealogy event was performed. Used for customer-specific lot tracking and MPW (Multi-Project Wafer) separation.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the child wafer lot created from the parent lot. References the resulting lot in split, merge, or rework operations.',
    `employee_id` BIGINT COMMENT 'Identifier of the FAB operator who executed the genealogy event. Used for accountability and process audit trails.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the FAB equipment or tool used to perform the lot split, merge, or rework operation. Enables equipment-specific traceability.',
    `fabrication_process_step_id` BIGINT COMMENT 'Identifier of the FAB operation or process step where the genealogy event occurred. Links to the specific manufacturing operation in the process flow.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the semiconductor product or design associated with the lot genealogy event. Links to the IC (Integrated Circuit) design or ASIC (Application-Specific Integrated Circuit) being fabricated.',
    `primary_fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the parent wafer lot from which the child lot originated. References the source lot in split, merge, or rework operations.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe or procedure used during the genealogy event. Captures the specific process parameters and settings applied.',
    `inventory_lot_genealogy_id` BIGINT COMMENT 'add column inventory_lot_genealogy_id (BIGINT) with FK to inventory.inventory_lot_genealogy.inventory_lot_genealogy_id - establish clear SSOT relationship where inventory owns genealogy',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the genealogy event was performed to meet regulatory or customer compliance requirements. True for ITAR, EAR, or customer-mandated lot segregation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this genealogy record was first created in the system. Audit trail for record creation.',
    `destination_fab_line` STRING COMMENT 'Identifier of the FAB production line where the child lot was routed after the genealogy event. Tracks lot movement across production lines.',
    `is_reversible` BOOLEAN COMMENT 'Indicates whether the genealogy relationship can be reversed or undone. True for temporary splits or holds that can be re-merged; false for permanent transformations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this genealogy record was last updated. Audit trail for record modifications.',
    `mes_transaction_code` STRING COMMENT 'Unique transaction identifier from the MES (Manufacturing Execution System) that recorded the genealogy event. Enables integration with Camstar or Applied Materials SmartFactory systems.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the lot genealogy event. Used for capturing context not covered by structured fields.',
    `priority_level` STRING COMMENT 'Priority classification assigned to the genealogy event. Influences scheduling and resource allocation for the resulting child lot.. Valid values are `critical|high|normal|low`',
    `process_stage` STRING COMMENT 'Major process stage where the genealogy event occurred. FEOL (Front End of Line) for transistor formation, MOL (Middle of Line) for contacts, or BEOL (Back End of Line) for interconnects.. Valid values are `feol|mol|beol`',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether the genealogy event was triggered by a quality hold or defect isolation requirement. True if the split or rework was quality-driven.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the lot genealogy event. Examples include capacity balancing, defect isolation, customer priority, or process optimization.',
    `reason_description` STRING COMMENT 'Detailed textual explanation of why the lot split, merge, or rework was performed. Provides context for genealogy analysis and root cause investigation.',
    `relationship_timestamp` TIMESTAMP COMMENT 'Date and time when the lot genealogy relationship was established. Records the exact moment of the split, merge, or rework event in the FAB.',
    `relationship_type` STRING COMMENT 'Type of genealogy relationship between parent and child lots. Defines the nature of the lot transformation event.. Valid values are `split|merge|rework|mpw_separation|scrap|hold_release`',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when a reversible genealogy relationship was reversed or undone. Null if the relationship has not been reversed or is not reversible.',
    `source_fab_line` STRING COMMENT 'Identifier of the FAB production line where the parent lot was located before the genealogy event. Enables cross-line traceability.',
    `technology_node` STRING COMMENT 'Process technology node of the wafer lots involved in the genealogy event. Examples include 7nm, 5nm, 3nm FinFET (Fin Field-Effect Transistor) or GAA (Gate All Around) technologies.',
    `traceability_code` STRING COMMENT 'Unique traceability identifier linking this genealogy event to upstream and downstream lot history. Enables end-to-end wafer genealogy tracking across the entire FAB process flow.',
    `wafer_count_transferred` STRING COMMENT 'Number of wafers transferred from parent lot to child lot during the genealogy event. Critical for WIP (Work in Process) tracking and yield analysis.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafers involved in the genealogy event, measured in millimeters. Standard values include 200mm, 300mm, or 450mm wafers.',
    CONSTRAINT pk_fabrication_lot_genealogy PRIMARY KEY(`fabrication_lot_genealogy_id`)
) COMMENT 'Association entity capturing parent-child relationships between wafer lots arising from lot splits, lot merges, rework re-entry, and MPW lot separation events. Records relationship type, split/merge timestamp, wafer count transferred, and traceability linkage. Authoritative source for wafer genealogy and lot traceability across the FAB.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` (
    `fabrication_technology_node_id` BIGINT COMMENT 'Unique identifier for the semiconductor technology node record. Primary key.',
    `fab_facility_id` BIGINT COMMENT 'Identifier of the primary fabrication facility where this technology node is manufactured. Links to the fab facility master data.',
    `process_technology_node_id` BIGINT COMMENT 'Identifier for the process technology node id associated with the fabrication technology node record.',
    `research_technology_node_id` BIGINT COMMENT 'Unique identifier for the research technology node record within the fabrication technology node fabrication entity.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this technology node record is currently active and available for use in manufacturing and design operations. False indicates archived or deprecated nodes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was first created in the system. Audit trail for data lineage and compliance.',
    `design_rule_complexity` STRING COMMENT 'Complexity level of Design for Manufacturability (DFM) rules required for this node. Higher complexity nodes require more sophisticated Optical Proximity Correction (OPC) and restricted design rules.. Valid values are `low|medium|high|extreme`',
    `dfm_enabled_flag` BOOLEAN COMMENT 'Indicates whether Design for Manufacturability (DFM) checks and optimizations are mandatory for designs targeting this node. True for advanced nodes requiring OPC, dummy fill, and restricted design rules.',
    `dft_enabled_flag` BOOLEAN COMMENT 'Indicates whether Design for Testability (DFT) structures (scan chains, BIST, ATPG patterns) are required for designs on this node. Ensures adequate test coverage for quality assurance.',
    `ear_classification` STRING COMMENT 'Export Control Classification Number (ECCN) under US Export Administration Regulations (EAR) for this technology node. Determines export licensing requirements to restricted countries.',
    `eol_announcement_date` DATE COMMENT 'Date when the technology node was officially announced for end-of-life phase-out. Triggers Product Change Notification (PCN) and Last Time Buy (LTB) processes for customers.',
    `iatf16949_certified_flag` BOOLEAN COMMENT 'Indicates whether this technology node is certified under IATF 16949 Automotive Quality Management standards, required for automotive-grade semiconductor production.',
    `iso9001_certified_flag` BOOLEAN COMMENT 'Indicates whether the manufacturing process for this technology node is certified under ISO 9001 Quality Management System standards.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether this technology node is subject to ITAR (International Traffic in Arms Regulations) export controls due to defense or aerospace applications. Restricts international technology transfer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was last updated. Tracks data currency and change history for audit and compliance purposes.',
    `lithography_technology` STRING COMMENT 'Primary lithography technology used for patterning in this node. DUV (Deep Ultraviolet) for mature nodes, EUV (Extreme Ultraviolet) for advanced nodes below 7nm.. Valid values are `duv|euv|immersion|dry`',
    `mask_set_cost_usd` DECIMAL(18,2) COMMENT 'Cost of a full photomask set for this technology node in US dollars. Significant cost driver for advanced nodes using EUV lithography. Business-confidential pricing data.',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers available in the Back End of Line (BEOL) stack for this technology node. Typically ranges from 6 to 15+ layers depending on node complexity.',
    `minimum_feature_size_nm` DECIMAL(18,2) COMMENT 'The smallest feature dimension that can be reliably manufactured in this technology node, measured in nanometers. Critical dimension for lithography and patterning capability.',
    `modified_by_user` STRING COMMENT 'Identifier of the user or system process that last modified this technology node record. Supports audit trail and accountability requirements.',
    `node_code` STRING COMMENT 'Internal alphanumeric code used to uniquely identify the technology node in manufacturing execution systems and product lifecycle management systems.',
    `node_generation` STRING COMMENT 'Generation classification of the node (e.g., Leading Edge, Mature, Legacy). Indicates the relative maturity and market positioning of the process technology.',
    `node_name` STRING COMMENT 'Human-readable name of the technology node (e.g., 5nm, 7nm, 14nm, 28nm, 65nm, 90nm). Industry-standard designation for the process generation.',
    `nre_cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated Non-Recurring Engineering (NRE) cost in US dollars for a typical design tapeout on this technology node. Includes mask set costs, design services, and qualification expenses. Business-confidential pricing data.',
    `pdk_version` STRING COMMENT 'Version identifier of the Process Design Kit (PDK) that defines the design rules, device models, and technology files for this node. Used by EDA (Electronic Design Automation) tools.',
    `power_performance_area_rating` STRING COMMENT 'Qualitative or quantitative assessment of the nodes Power, Performance, and Area (PPA) characteristics relative to prior generations. Critical metric for competitive positioning.',
    `process_flow_version` STRING COMMENT 'Version identifier of the manufacturing process flow (sequence of FEOL, MOL, BEOL steps) defined for this technology node. Tracks process recipe evolution and engineering changes.',
    `production_readiness_date` DATE COMMENT 'Date when the technology node was certified as production-ready and available for high-volume manufacturing (HVM). Null if still in development or qualification.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the technology node. Development: R&D phase. Qualification: undergoing reliability and yield validation. Qualified: approved for production. Production: active manufacturing. Mature: stable high-volume. EOL (End of Life): phase-out planned.. Valid values are `development|qualification|qualified|production|mature|eol`',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the chemicals and materials used in this technology node comply with EU REACH Regulation for chemical safety and substance registration.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the manufacturing process for this technology node complies with EU RoHS Directive restrictions on hazardous substances (lead, mercury, cadmium, etc.).',
    `supported_application_types` STRING COMMENT 'Comma-separated list of target application domains optimized for this node (e.g., Mobile, Automotive, AI/ML, IoT, High-Performance Computing, Networking). Guides product design-in decisions.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target percentage of good dies per wafer for this technology node at maturity. Key performance indicator for manufacturing efficiency and cost competitiveness.',
    `transistor_architecture` STRING COMMENT 'Type of transistor structure used in this technology node. Planar for older nodes, FinFET (Fin Field-Effect Transistor) for 22nm-7nm, GAA (Gate All Around) for 3nm and below.. Valid values are `planar|finfet|gaa|nanosheet|nanowire`',
    `wafer_size_mm` STRING COMMENT 'Standard wafer diameter supported by this technology node, typically 200mm (8-inch) or 300mm (12-inch). Determines fab equipment compatibility and die yield economics.',
    CONSTRAINT pk_fabrication_technology_node PRIMARY KEY(`fabrication_technology_node_id`)
) COMMENT 'Reference master for semiconductor technology nodes supported in the FAB, capturing node name (e.g., 5nm, 7nm, 28nm, 65nm), node generation, transistor architecture (planar, FinFET, GAA), minimum feature size, metal layer count, PDK version reference, qualification status, and production readiness date. SSOT for node-level process and product classification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` (
    `fab_yield_record_id` BIGINT COMMENT 'Unique identifier for the FAB yield record. Primary key for this transactional yield capture event.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield loss financial impact is allocated to the cost center overseeing the wafer lot.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or technician who performed the yield measurement. Supports traceability and training effectiveness analysis.',
    `fab_facility_id` BIGINT COMMENT 'Reference to the FAB facility where this yield measurement was captured. Enables multi-site yield comparison and benchmarking.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the inspection or metrology equipment used to capture this yield measurement (e.g., KLA ICOS system). Enables equipment-specific yield correlation.',
    `wafer_id` BIGINT COMMENT 'FK to fabrication.wafer.wafer_id — Yield records can be at wafer level for per-wafer yield tracking. Required for wafer-level yield maps and die-level analysis.',
    `photomask_id` BIGINT COMMENT 'Reference to the photomask set used for lithography on this wafer. Enables correlation of yield to mask quality and OPC effectiveness.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Reference to the process route or recipe used for this wafer. Links yield outcomes to specific process flows.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Yield record captures technology node; add FK to technology_node and remove redundant numeric column.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot to which this yield record belongs. Enables lot-level yield aggregation and genealogy tracking.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Enables Yield Dashboard to aggregate yields per IC catalog product.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Yield analysis reports are aggregated per design project; direct FK enables automated project‑level yield dashboards and root‑cause tracking.',
    `primary_fab_wafer_id` BIGINT COMMENT 'Reference to the specific wafer for which yield is being recorded. Links to the wafer master record in the fabrication domain.',
    `bin_1_die_count` STRING COMMENT 'Number of die classified into bin 1 (typically highest quality/performance bin). Part of bin-level yield breakdown.',
    `bin_2_die_count` STRING COMMENT 'Number of die classified into bin 2 (typically second-tier quality/performance bin). Part of bin-level yield breakdown.',
    `bin_3_die_count` STRING COMMENT 'Number of die classified into bin 3 (typically third-tier quality/performance bin). Part of bin-level yield breakdown.',
    `checkpoint_code` STRING COMMENT 'The FAB inline checkpoint at which this yield measurement was captured. Distinguishes FEOL, MOL, BEOL, and pre-probe stages. [ENUM-REF-CANDIDATE: POST_FEOL|POST_MOL|POST_BEOL|PRE_PROBE|POST_CMP|POST_LITHO|POST_ETCH|POST_IMPLANT|INLINE_INSPECTION — 9 candidates stripped; promote to reference product]',
    `comments` STRING COMMENT 'Free-text comments or notes about this yield measurement, including observations, anomalies, or contextual information for root cause analysis.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'Lower control limit for yield percentage at this checkpoint. Part of Statistical Process Control (SPC) monitoring.',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'Upper control limit for yield percentage at this checkpoint. Part of Statistical Process Control (SPC) monitoring.',
    `design_loss_die_count` STRING COMMENT 'Number of die lost due to design-related issues (DFM violations, timing failures, functional failures). Part of yield loss pareto analysis.',
    `disposition_status` STRING COMMENT 'The disposition decision for the wafer or lot based on this yield measurement. Determines next processing step or lot hold.. Valid values are `PASS|FAIL|HOLD|REWORK|SCRAP`',
    `excursion_severity_level` STRING COMMENT 'Severity classification of the yield excursion event. Determines escalation path and response urgency.. Valid values are `CRITICAL|MAJOR|MINOR|NONE`',
    `good_die_count` STRING COMMENT 'Number of die that passed yield criteria at this checkpoint. Represents the actual usable die count after defect screening and binning.',
    `gross_die_count` STRING COMMENT 'Total number of die on the wafer before yield screening. Represents the theoretical maximum die count based on wafer size and die layout.',
    `hold_reason_code` STRING COMMENT 'The reason code if the wafer or lot was placed on hold due to yield excursion. Links to hold reason reference data.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The date and time when the yield measurement was captured at the inline checkpoint. Represents the business event time of the yield observation.',
    `process_loss_die_count` STRING COMMENT 'Number of die lost due to process-related defects (CVD, PVD, ALD, CMP, etch, implant issues). Part of yield loss pareto analysis.',
    `random_defect_die_count` STRING COMMENT 'Number of die lost due to random defects (particles, contamination, handling damage). Part of yield loss pareto analysis.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this yield record was first created in the data platform. Audit trail for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this yield record was last updated in the data platform. Audit trail for data lineage and compliance.',
    `reject_bin_die_count` STRING COMMENT 'Number of die classified into reject bins (failed die that do not meet minimum specifications). Part of bin-level yield breakdown.',
    `rework_flag` BOOLEAN COMMENT 'Boolean indicator that this wafer is eligible for rework based on yield results. Drives rework routing decisions.',
    `scrap_flag` BOOLEAN COMMENT 'Boolean indicator that this wafer should be scrapped based on yield results. Triggers scrap disposition and cost accounting.',
    `specification_limit_lower` DECIMAL(18,2) COMMENT 'Lower specification limit for yield percentage at this checkpoint. Represents minimum acceptable yield threshold.',
    `systematic_defect_die_count` STRING COMMENT 'Number of die lost due to systematic defects (OPC errors, MEEF issues, lithography hotspots). Part of yield loss pareto analysis.',
    `yield_excursion_flag` BOOLEAN COMMENT 'Boolean indicator that this yield record represents an excursion event (yield below control limits or specification). Triggers root cause analysis and corrective action.',
    `yield_for_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Yield records are captured at lot level at key FAB checkpoints.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield percentage at this checkpoint (good_die_count / gross_die_count * 100). Primary yield metric for FAB inline performance tracking.',
    `yield_record_for_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Yield records reference the lot measured. Required for lot-level yield tracking and excursion detection.',
    CONSTRAINT pk_fab_yield_record PRIMARY KEY(`fab_yield_record_id`)
) COMMENT 'Transactional record capturing wafer-level and lot-level yield outcomes at key FAB inline checkpoints (post-FEOL, post-MOL, post-BEOL, pre-probe), recording gross die count, good die count, yield percentage, yield loss pareto by category (process, design, random defect, systematic), bin-level yield breakdown, and yield excursion flags. SSOT for FAB inline yield data distinct from final test yield (owned by test domain) and distinct from SPC/metrology analysis (owned by quality domain).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` (
    `mask_set_id` BIGINT COMMENT 'Primary key for mask_set',
    `derived_from_mask_set_id` BIGINT COMMENT 'Self-referencing FK on mask_set (derived_from_mask_set_id)',
    `ic_design_project_id` BIGINT COMMENT 'FK to design.ic_design_project.ic_design_project_id',
    `application_area` STRING COMMENT 'Primary product domain where the mask set is applied.',
    `mask_set_category` STRING COMMENT 'Category indicating whether the mask set is a standard, custom, or prototype design.',
    `mask_set_code` STRING COMMENT 'External catalogue or part number assigned to the mask set by the fab.',
    `compliance_status` STRING COMMENT 'Regulatory or internal compliance status of the mask set.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the mask set record was first created in the system.',
    `mask_set_description` STRING COMMENT 'Free‑form description of the mask sets purpose and characteristics.',
    `effective_end_date` DATE COMMENT 'Date after which the mask set is no longer valid (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the mask set is considered valid for production.',
    `exposure_tool` STRING COMMENT 'Name or identifier of the lithography tool that uses this mask set.',
    `inspection_date` DATE COMMENT 'Date of the most recent quality inspection of the mask set.',
    `inspection_result` STRING COMMENT 'Outcome of the latest inspection.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the mask set record.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time the mask set was most recently used in production.',
    `lithography_technology` STRING COMMENT 'Lithography technology for which the mask set is designed.',
    `mask_cost_usd` DECIMAL(18,2) COMMENT 'Acquisition cost of the mask set in US dollars.',
    `mask_layer_count` STRING COMMENT 'Number of patterned layers contained in the mask set.',
    `mask_material` STRING COMMENT 'Material composition of the mask (e.g., quartz, glass, silicon).',
    `mask_set_status` STRING COMMENT 'Current lifecycle state of the mask set.',
    `mask_thickness_nm` DECIMAL(18,2) COMMENT 'Physical thickness of the mask substrate in nanometres.',
    `mask_type` STRING COMMENT 'Category of mask based on its physical principle.',
    `mask_set_name` STRING COMMENT 'Human‑readable name of the mask set used by engineers and planners.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the mask set.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the mask set.',
    `priority` STRING COMMENT 'Priority level for scheduling mask set usage in fab planning.',
    `quality_grade` STRING COMMENT 'Quality grade assigned after inspection (A‑highest, D‑lowest).',
    `revision_date` DATE COMMENT 'Date when the current revision of the mask set was released.',
    `revision_number` STRING COMMENT 'Sequential revision number for engineering changes to the mask set.',
    `safety_classification` STRING COMMENT 'Safety handling class for the mask set according to fab safety standards.',
    `storage_location` STRING COMMENT 'Physical storage location or vault identifier for the mask set.',
    `usage_count` BIGINT COMMENT 'Total number of wafer lots processed with this mask set.',
    `version` STRING COMMENT 'Alphanumeric version label for the mask set (e.g., V1.2).',
    `wafer_size_mm` DECIMAL(18,2) COMMENT 'Diameter of wafers that the mask set is intended for, expressed in millimetres.',
    `wavelength_nm` DECIMAL(18,2) COMMENT 'Design wavelength of the lithography exposure system in nanometres.',
    CONSTRAINT pk_mask_set PRIMARY KEY(`mask_set_id`)
) COMMENT 'Master reference table for mask_set. Referenced by mask_set_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` (
    `fab_facility_id` BIGINT COMMENT 'Primary key for fab_facility',
    `parent_fab_facility_id` BIGINT COMMENT 'Self-referencing FK on fab_facility (parent_fab_facility_id)',
    `capacity_wafer_per_month` BIGINT COMMENT 'Maximum number of wafers the facility can process in a calendar month.',
    `carbon_footprint_kgco2e` DECIMAL(18,2) COMMENT 'Monthly greenhouse‑gas emissions expressed in kilograms CO₂ equivalent.',
    `city` STRING COMMENT 'City where the facility is located.',
    `cleanroom_class` STRING COMMENT 'ISO cleanroom classification of the facilitys most stringent environment.',
    `compliance_status` STRING COMMENT 'Current compliance standing with regulatory and industry standards.',
    `contact_email` STRING COMMENT 'Primary email address for facility communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for facility communications.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the facility location.',
    `fab_facility_description` STRING COMMENT 'Free‑form description of the facilitys capabilities and role.',
    `end_date` DATE COMMENT 'Date when the facility ceased operations (null if still active).',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Average monthly energy consumption measured in megawatt‑hours.',
    `environmental_certifications` STRING COMMENT 'Comma‑separated list of environmental certifications (e.g., ISO 14001).',
    `equipment_summary` STRING COMMENT 'Free‑text summary of key equipment types and models present.',
    `fab_area_sqft` DECIMAL(18,2) COMMENT 'Total usable floor area of the fab in square feet.',
    `facility_code` STRING COMMENT 'External business code or identifier used to reference the facility in enterprise systems.',
    `facility_name` STRING COMMENT 'Human‑readable name of the fabrication facility.',
    `facility_type` STRING COMMENT 'Category of the facility based on its primary function.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the facility (decimal degrees).',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the facility.',
    `lithography_type` STRING COMMENT 'Primary lithography technology employed at the fab.',
    `location_address_line1` STRING COMMENT 'Primary street address of the facility.',
    `location_address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the facility (decimal degrees).',
    `maintenance_window` STRING COMMENT 'Typical time window (e.g., weekly, monthly) allocated for planned maintenance.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for overall facility management.',
    `next_audit_due` DATE COMMENT 'Scheduled date for the next compliance audit.',
    `notes` STRING COMMENT 'Any supplemental information or remarks about the facility.',
    `number_of_cleanrooms` STRING COMMENT 'Count of cleanroom spaces within the facility.',
    `number_of_equipment_units` STRING COMMENT 'Total number of major equipment units (e.g., lithography, etch, deposition) installed.',
    `operational_status` STRING COMMENT 'Current operational condition of the facility.',
    `process_technology_node` STRING COMMENT 'Primary semiconductor process node supported (e.g., 7nm, 5nm).',
    `restricted_access` BOOLEAN COMMENT 'Indicates whether the facility requires restricted (security‑cleared) access.',
    `safety_certifications` STRING COMMENT 'Comma‑separated list of safety certifications held (e.g., ISO 45001).',
    `shift_schedule` STRING COMMENT 'Number of production shifts operated per day.',
    `start_date` DATE COMMENT 'Date when the facility began operations.',
    `state_province` STRING COMMENT 'State or province of the facility location.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Total waste generated per month measured in metric tons.',
    `water_usage_m3` DECIMAL(18,2) COMMENT 'Average monthly water usage in cubic meters.',
    CONSTRAINT pk_fab_facility PRIMARY KEY(`fab_facility_id`)
) COMMENT 'Master reference table for fab_facility. Referenced by fab_facility_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Primary key for work_center',
    `fab_facility_id` BIGINT COMMENT 'Unique identifier for the fab facility record within the work center fabrication entity.',
    `parent_work_center_id` BIGINT COMMENT 'Self-referencing FK on work_center (parent_work_center_id)',
    `area_sq_m` DECIMAL(18,2) COMMENT 'Floor area of the work center in square meters.',
    `capacity_wafers_per_hour` STRING COMMENT 'Maximum number of wafers the work center can process in one hour.',
    `work_center_code` STRING COMMENT 'External or legacy code that uniquely identifies the work center within manufacturing systems.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the work center.',
    `control_system_version` STRING COMMENT 'Software version of the work centers control system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work center record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level applied to data generated by this work center.',
    `work_center_description` STRING COMMENT 'Free‑form description providing additional context about the work center.',
    `effective_from` DATE COMMENT 'Date when the work center became operationally active.',
    `effective_until` DATE COMMENT 'Date when the work center is scheduled to be retired or decommissioned (nullable).',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Average energy usage of the work center measured in kilowatt‑hours per day.',
    `equipment_count` STRING COMMENT 'Number of major pieces of equipment installed in the work center.',
    `fab_line` STRING COMMENT 'Identifier of the fab line to which the work center belongs.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Average relative humidity within the work center.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the work center operates with automated equipment (true) or manual processes (false).',
    `last_calibration_date` DATE COMMENT 'Date when the work centers critical equipment was last calibrated.',
    `location` STRING COMMENT 'Physical location identifier (building, floor, or area) where the work center resides.',
    `maintenance_window_end` TIMESTAMP COMMENT 'Timestamp when the scheduled maintenance period ends.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Timestamp when the scheduled maintenance period begins.',
    `manager_contact` STRING COMMENT 'Primary phone number for the work center manager.',
    `manager_name` STRING COMMENT 'Name of the person responsible for the work centers operations.',
    `work_center_name` STRING COMMENT 'Human‑readable name of the work center used in reports and dashboards.',
    `next_calibration_due` DATE COMMENT 'Planned date for the next calibration of the work centers equipment.',
    `notes` STRING COMMENT 'Additional free‑form remarks or operational notes.',
    `operational_status` STRING COMMENT 'Real‑time operational condition of the work center.',
    `process_step` STRING COMMENT 'Manufacturing process step primarily performed at this work center.',
    `safety_rating` STRING COMMENT 'Safety classification of the work center based on internal risk assessments.',
    `shift_schedule` STRING COMMENT 'Standard shift pattern assigned to the work center.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Typical ambient temperature inside the work center.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the work center record.',
    `work_center_status` STRING COMMENT 'Current operational state of the work center.',
    `work_center_type` STRING COMMENT 'Category of the work center based on the manufacturing process it supports.',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master reference table for work_center. Referenced by work_center_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` (
    `spc_control_plan_id` BIGINT COMMENT 'Primary key for spc_control_plan',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the fabrication technology node associated with this spc control plan record (fabrication technology node id).',
    `process_spc_control_plan_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `superseded_spc_control_plan_id` BIGINT COMMENT 'Self-referencing FK on spc_control_plan (superseded_spc_control_plan_id)',
    `approval_date` DATE COMMENT 'Date on which the control plan received formal approval.',
    `approved_by` STRING COMMENT 'Name of the engineer or manager who approved the control plan.',
    `change_reason` STRING COMMENT 'Reason for the most recent revision of the control plan.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'Statistical lower control limit used for SPC charting.',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'Statistical upper control limit used for SPC charting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the control plan record was first created in the system.',
    `spc_control_plan_description` STRING COMMENT 'Detailed description of the control plan purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the control plan is retired or superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the control plan becomes active.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the control plan is considered critical for product quality.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower acceptable specification limit for the metric.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target metric and limits.',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the control plan.',
    `plan_code` STRING COMMENT 'Business identifier code for the control plan, used in manufacturing documentation and MES.',
    `plan_name` STRING COMMENT 'Human‑readable name of the control plan.',
    `plan_type` STRING COMMENT 'Classification of the plan based on what is being controlled.',
    `responsible_engineer` STRING COMMENT 'Engineer accountable for maintaining the control plan.',
    `revision_number` STRING COMMENT 'Sequential revision number incremented on each change.',
    `sample_size` STRING COMMENT 'Number of units measured per sampling event.',
    `sampling_frequency` STRING COMMENT 'How often samples are taken for the control plan.',
    `spc_control_plan_status` STRING COMMENT 'Current lifecycle status of the control plan.',
    `target_metric` STRING COMMENT 'Key process metric that the control plan monitors (e.g., wafer thickness).',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal target value for the monitored metric.',
    `updated_by` STRING COMMENT 'User identifier who last modified the control plan record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the control plan record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper acceptable specification limit for the metric.',
    `version` STRING COMMENT 'Version identifier for the control plan, following the internal versioning scheme.',
    `created_by` STRING COMMENT 'User identifier who initially created the control plan record.',
    CONSTRAINT pk_spc_control_plan PRIMARY KEY(`spc_control_plan_id`)
) COMMENT 'Master reference table for spc_control_plan. Referenced by spc_control_plan_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` (
    `equipment_group_id` BIGINT COMMENT 'Primary key for equipment_group',
    `fab_facility_id` BIGINT COMMENT 'Unique identifier for the fab facility record within the equipment group fabrication entity.',
    `parent_equipment_group_id` BIGINT COMMENT 'Self-referencing FK on equipment_group (parent_equipment_group_id)',
    `parent_group_id` BIGINT COMMENT 'Identifier of the parent equipment group, if this group is part of a hierarchy.',
    `capacity_wafers_per_hour` STRING COMMENT 'The capacity wafers per hour for the equipment group entity.',
    `equipment_group_code` STRING COMMENT 'Short alphanumeric code used to reference the equipment group in MES and ERP systems.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the equipment group.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code associated with the equipment group for financial tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment group record was first created in the system.',
    `default_capacity` STRING COMMENT 'Typical production capacity of the equipment group expressed in wafers per day.',
    `equipment_group_description` STRING COMMENT 'Free‑form description providing additional context about the equipment group.',
    `effective_end_date` DATE COMMENT 'The effective end date for the equipment group record.',
    `effective_from` DATE COMMENT 'Date when the equipment group became operational.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the equipment group fabrication record.',
    `effective_until` DATE COMMENT 'Date when the equipment group is scheduled to be decommissioned (null if open‑ended).',
    `equipment_class` STRING COMMENT 'The equipment class of the equipment group record in the fabrication domain.',
    `equipment_count` BIGINT COMMENT 'The equipment count of the equipment group record in the fabrication domain.',
    `equipment_group_status` STRING COMMENT 'Current lifecycle state of the equipment group.',
    `fab_location` STRING COMMENT 'Identifier of the fab site or cleanroom where the equipment group is located.',
    `group_code` STRING COMMENT 'Coded value representing the group code of the equipment group fabrication record.',
    `group_hierarchy_level` STRING COMMENT 'Numeric level indicating the position of the group within the equipment hierarchy.',
    `group_name` STRING COMMENT 'The group name of the equipment group record in the fabrication domain.',
    `group_type` STRING COMMENT 'Category of the equipment group indicating its primary function within the fab.',
    `is_active` BOOLEAN COMMENT 'The is active of the equipment group record in the fabrication domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the equipment group record in the fabrication domain.',
    `location` STRING COMMENT 'The location of the equipment group record in the fabrication domain.',
    `maintenance_strategy` STRING COMMENT 'The maintenance strategy of the equipment group record in the fabrication domain.',
    `maintenance_window` STRING COMMENT 'Preferred maintenance window for the equipment group.',
    `manager_name` STRING COMMENT 'The manager name of the equipment group record in the fabrication domain.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum temperature at which the equipment group can safely operate.',
    `equipment_group_name` STRING COMMENT 'Human‑readable name of the equipment group.',
    `notes` STRING COMMENT 'The notes of the equipment group record in the fabrication domain.',
    `operational_status` STRING COMMENT 'The operational status of the equipment group record in the fabrication domain.',
    `process_area` STRING COMMENT 'The process area of the equipment group record in the fabrication domain.',
    `process_technology` STRING COMMENT 'Process node (technology) supported by the equipment group.',
    `safety_class` STRING COMMENT 'Safety class assigned to the equipment group according to industry standards.',
    `tool_count` STRING COMMENT 'The tool count of the equipment group record in the fabrication domain.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the equipment group record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the equipment group record.',
    `utilization_target_percent` DECIMAL(18,2) COMMENT 'The utilization target percent of the equipment group record in the fabrication domain.',
    `voltage_rating_v` DECIMAL(18,2) COMMENT 'Nominal voltage rating for the equipment group.',
    `created_by` STRING COMMENT 'User identifier of the person who created the equipment group record.',
    CONSTRAINT pk_equipment_group PRIMARY KEY(`equipment_group_id`)
) COMMENT 'Master reference table for equipment_group. Referenced by equipment_group_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` (
    `fabrication_fab_id` BIGINT COMMENT 'Primary key for fab',
    `fab_facility_id` BIGINT COMMENT 'Unique identifier for the fab facility record within the fabrication fab fabrication entity.',
    `fab_site_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_site. Business justification: Each fab belongs to a fab site; adding fab_site_id FK to fab links fab to its site and resolves fab_site isolation.',
    `capacity_wafer_per_month` BIGINT COMMENT 'The capacity wafer per month of the fabrication fab record in the fabrication domain.',
    `capacity_wafers_per_month` STRING COMMENT 'Maximum number of wafers the fab can process in a month.',
    `capacity_wspm` BIGINT COMMENT 'The capacity wspm of the fabrication fab record in the fabrication domain.',
    `cleanroom_class` STRING COMMENT 'Cleanroom class rating of the fab environment.',
    `compliance_status` STRING COMMENT 'Current compliance standing with industry regulations.',
    `contact_email` STRING COMMENT 'Primary email address for fab communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the fab.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fab record was first created.',
    `end_date` DATE COMMENT 'Date when the fab ceased operations (null if still active).',
    `environmental_certification` STRING COMMENT 'Environmental management certification held by the fab.',
    `fab_code` STRING COMMENT 'Business‑assigned unique code for the fab.',
    `fab_description` STRING COMMENT 'Free‑form textual description of the fab.',
    `fab_name` STRING COMMENT 'Human‑readable name of the fab.',
    `fab_status` STRING COMMENT 'Current operational status of the fab.',
    `fab_type` STRING COMMENT 'Classification of the fab based on process focus.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the fabrication fab record in the fabrication domain.',
    `location` STRING COMMENT 'The location of the fabrication fab record in the fabrication domain.',
    `location_city` STRING COMMENT 'City where the fab is situated.',
    `location_country` STRING COMMENT 'Three‑letter ISO country code where the fab resides.',
    `location_state` STRING COMMENT 'State or province of the fab location.',
    `manager_name` STRING COMMENT 'Name of the manager overseeing the fab.',
    `next_scheduled_maintenance` DATE COMMENT 'Planned date for the next maintenance event.',
    `notes` STRING COMMENT 'The notes of the fabrication fab record in the fabrication domain.',
    `number_of_cleanrooms` STRING COMMENT 'Total count of cleanrooms within the fab.',
    `operational_status` STRING COMMENT 'The operational status of the fabrication fab record in the fabrication domain.',
    `owner_department` STRING COMMENT 'Internal department responsible for the fab.',
    `power_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical power capacity of the fab in megawatts.',
    `region` STRING COMMENT 'Broad geographic region where the fab is located.',
    `safety_incident_count` STRING COMMENT 'Cumulative number of safety incidents recorded at the fab.',
    `start_date` DATE COMMENT 'Date when the fab began operations.',
    `technology_node` STRING COMMENT 'The technology node of the fabrication fab record in the fabrication domain.',
    `technology_node_nm` DECIMAL(18,2) COMMENT 'Minimum feature size of the process technology in nanometers.',
    `total_area_sq_m` DECIMAL(18,2) COMMENT 'Overall floor area of the fab in square meters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fab record.',
    `wafer_size_mm` STRING COMMENT 'The wafer size mm of the fabrication fab record in the fabrication domain.',
    `waste_treatment_capacity_kg_per_day` DECIMAL(18,2) COMMENT 'Maximum waste treatment capacity per day in kilograms.',
    `water_usage_cubic_m_per_day` DECIMAL(18,2) COMMENT 'Average water consumption per day in cubic meters.',
    CONSTRAINT pk_fabrication_fab PRIMARY KEY(`fabrication_fab_id`)
) COMMENT 'Master reference table for fab. Referenced by fab_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` (
    `reticle_set_id` BIGINT COMMENT 'Primary key for reticle_set',
    `derived_from_reticle_set_id` BIGINT COMMENT 'Self-referencing FK on reticle_set (derived_from_reticle_set_id)',
    `fabrication_technology_node_id` BIGINT COMMENT 'Unique identifier for the fabrication technology node record within the reticle set fabrication entity.',
    `ic_design_project_id` BIGINT COMMENT 'Unique identifier for the ic design project record within the reticle set fabrication entity.',
    `mask_set_id` BIGINT COMMENT 'Unique identifier for the mask set record within the reticle set fabrication entity.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration of the reticle set.',
    `reticle_set_code` STRING COMMENT 'Business identifier or part number assigned to the reticle set.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard the reticle set complies with.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Acquisition cost of the reticle set in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reticle set record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost field.',
    `current_cycle_count` BIGINT COMMENT 'Accumulated exposure cycles to date.',
    `defect_rate_ppm` DECIMAL(18,2) COMMENT 'Measured defect density in parts per million.',
    `reticle_set_description` STRING COMMENT 'Free‑form description of the reticle set and its purpose.',
    `expected_lifetime_cycles` BIGINT COMMENT 'Projected number of exposure cycles before retirement.',
    `exposure_tool` STRING COMMENT 'Name or identifier of the exposure tool compatible with the reticle set.',
    `fab_location` STRING COMMENT 'Fabrication plant or line where the reticle set is stored/used.',
    `field_size_mm` DOUBLE COMMENT 'The field size mm of the reticle set record in the fabrication domain.',
    `field_size_x_mm` DECIMAL(18,2) COMMENT 'The field size x mm of the reticle set record in the fabrication domain.',
    `field_size_y_mm` DECIMAL(18,2) COMMENT 'The field size y mm of the reticle set record in the fabrication domain.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the reticle set is critical for high‑volume production.',
    `is_licensed` BOOLEAN COMMENT 'True if the reticle set is covered by a licensing agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the reticle set record in the fabrication domain.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date‑time when the reticle set was last used.',
    `lithography_technology` STRING COMMENT 'The lithography technology of the reticle set record in the fabrication domain.',
    `lithography_type` STRING COMMENT 'Lithography technology used with the reticle set.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier for traceability.',
    `magnification_factor` DOUBLE COMMENT 'The magnification factor of the reticle set record in the fabrication domain.',
    `maintenance_status` STRING COMMENT 'Current maintenance state of the reticle set.',
    `material` STRING COMMENT 'Base material of the reticle substrate.',
    `reticle_set_name` STRING COMMENT 'Human‑readable name identifying the reticle set.',
    `notes` STRING COMMENT 'Additional remarks or operational notes.',
    `number_of_reticles` STRING COMMENT 'Count of individual reticles contained in the set.',
    `qualification_date` DATE COMMENT 'Date when qualification was performed.',
    `qualification_status` STRING COMMENT 'Qualification outcome for the reticle set.',
    `reduction_ratio` STRING COMMENT 'The reduction ratio of the reticle set record in the fabrication domain.',
    `reticle_count` STRING COMMENT 'The reticle count of the reticle set record in the fabrication domain.',
    `reticle_set_status` STRING COMMENT 'Current lifecycle status of the reticle set.',
    `reticle_set_type` STRING COMMENT 'Category of the set (e.g., mask, reticle, blank, dummy).',
    `retire_date` DATE COMMENT 'Date the reticle set was retired from service.',
    `retire_reason` STRING COMMENT 'Reason for retiring the reticle set (e.g., wear, obsolescence).',
    `revision` STRING COMMENT 'Version or revision code of the reticle set design.',
    `safety_classification` STRING COMMENT 'Safety class based on material and handling requirements.',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Controlled storage humidity level for the reticle set.',
    `storage_location` STRING COMMENT 'The storage location of the reticle set record in the fabrication domain.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Controlled storage temperature for the reticle set.',
    `total_area_mm2` DECIMAL(18,2) COMMENT 'Combined active area of all reticles in square millimetres.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reticle set record.',
    `usage_count` BIGINT COMMENT 'Number of times the reticle set has been used in production.',
    `vendor` STRING COMMENT 'Supplier of the reticle set.',
    `vendor_part_number` STRING COMMENT 'Vendor‑assigned part number for the reticle set.',
    `wavelength_nm` STRING COMMENT 'Design wavelength in nanometers for the reticle set.',
    CONSTRAINT pk_reticle_set PRIMARY KEY(`reticle_set_id`)
) COMMENT 'Master reference table for reticle_set. Referenced by reticle_set_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` (
    `plant_id` BIGINT COMMENT 'Primary key for plant',
    `fab_facility_id` BIGINT COMMENT 'Unique identifier for the fab facility record within the plant fabrication entity.',
    `parent_plant_id` BIGINT COMMENT 'Self-referencing FK on plant (parent_plant_id)',
    `site_id` BIGINT COMMENT 'Identifier used by external systems (e.g., MES) to reference the plant.',
    `address_line1` STRING COMMENT 'Primary street address of the plant.',
    `area_sq_m` DECIMAL(18,2) COMMENT 'Total built‑up area of the plant in square meters.',
    `capacity_wafer_per_month` DECIMAL(18,2) COMMENT 'Maximum number of wafers the plant can produce in a typical month.',
    `city` STRING COMMENT 'City where the plant is located.',
    `cleanroom_class` STRING COMMENT 'Cleanroom class rating based on particle count standards.',
    `plant_code` STRING COMMENT 'External business code assigned to the plant, often used in ERP and MES systems.',
    `compliance_certifications` STRING COMMENT 'List of key compliance certifications held by the plant.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the plant.',
    `country_code` STRING COMMENT 'Coded value representing the country code of the plant fabrication record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant record was first created in the data lake.',
    `data_classification` STRING COMMENT 'Classification level for data governance purposes.',
    `plant_description` STRING COMMENT 'Free‑form textual description of the plants capabilities and purpose.',
    `environmental_rating` STRING COMMENT 'Environmental performance rating of the plant.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which major maintenance was performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the plant record in the fabrication domain.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the plant location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the plant location.',
    `maintenance_cycle_days` STRING COMMENT 'Planned interval in days between routine maintenance activities.',
    `manager_email` STRING COMMENT 'Primary email address of the plant manager.',
    `manager_name` STRING COMMENT 'Full name of the plant manager.',
    `manager_phone` STRING COMMENT 'Contact phone number for the plant manager.',
    `plant_name` STRING COMMENT 'Human‑readable name of the plant used in reports and dashboards.',
    `notes` STRING COMMENT 'The notes of the plant record in the fabrication domain.',
    `number_of_cleanrooms` STRING COMMENT 'Total number of cleanroom suites in the plant.',
    `number_of_fabs` STRING COMMENT 'Count of distinct fabrication lines within the plant.',
    `operational_shift` STRING COMMENT 'Number of production shifts run per day.',
    `operational_status` STRING COMMENT 'The operational status of the plant record in the fabrication domain.',
    `owner_department` STRING COMMENT 'Internal department responsible for the plants overall governance.',
    `plant_status` STRING COMMENT 'Current operational state of the plant within its lifecycle.',
    `plant_type` STRING COMMENT 'Category of the plant based on its primary manufacturing function.',
    `power_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical power capacity of the plant in megawatts.',
    `region` STRING COMMENT 'Broad business region where the plant is located.',
    `security_level` STRING COMMENT 'Security classification of the plant based on risk and access controls.',
    `shutdown_date` DATE COMMENT 'Date when the plant was permanently closed or decommissioned, if applicable.',
    `start_date` DATE COMMENT 'Date when the plant began operations.',
    `state` STRING COMMENT 'State or province of the plant location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plant record.',
    `waste_treatment_capacity_tons_per_day` DECIMAL(18,2) COMMENT 'Maximum daily waste treatment capacity in metric tons.',
    `water_usage_m3_per_day` DECIMAL(18,2) COMMENT 'Average daily water consumption of the plant.',
    `zip_code` STRING COMMENT 'Postal code for the plants address.',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` (
    `fab_site_id` BIGINT COMMENT 'Primary key for fab_site',
    `fab_facility_id` BIGINT COMMENT 'Unique identifier for the fab facility record within the fab site fabrication entity.',
    `parent_fab_site_id` BIGINT COMMENT 'Self-referencing FK on fab_site (parent_fab_site_id)',
    `plant_id` BIGINT COMMENT 'Foreign key linking to fabrication.plant. Business justification: Fab site is part of a plant; adding plant_id FK to fab_site establishes hierarchy and connects plant.',
    `address_line1` STRING COMMENT 'Primary street address of the fab site.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite, building).',
    `audit_status` STRING COMMENT 'Result of the most recent audit.',
    `capacity_wafer_per_month` STRING COMMENT 'Maximum number of wafers the site can process each month.',
    `city` STRING COMMENT 'City where the fab site is located.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the fab site.',
    `country_code` STRING COMMENT 'Coded value representing the country code of the fab site fabrication record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created.',
    `fab_site_description` STRING COMMENT 'Free‑form description of the fab site.',
    `end_date` DATE COMMENT 'Date when the site was decommissioned or closed (nullable).',
    `environmental_certification` STRING COMMENT 'Environmental compliance certifications held by the site.',
    `fab_site_status` STRING COMMENT 'Current lifecycle status of the site.',
    `ghs_compliance` STRING COMMENT 'Globally Harmonized System chemical safety compliance.',
    `is_primary_site` BOOLEAN COMMENT 'Indicates whether this site is the primary manufacturing location for the company.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the fab site record in the fabrication domain.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the fab site.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the fab site.',
    `maintenance_window_start` STRING COMMENT 'Daily start time for scheduled maintenance (HH:mm, 24‑hour).',
    `manager_email` STRING COMMENT 'Email address of the site manager.',
    `manager_name` STRING COMMENT 'Full name of the site manager.',
    `manager_phone` STRING COMMENT 'Contact phone number for the site manager.',
    `fab_site_name` STRING COMMENT 'Human‑readable name of the fab site.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the upcoming audit.',
    `notes` STRING COMMENT 'Additional remarks or operational notes.',
    `number_of_cleanrooms` STRING COMMENT 'Count of classified cleanroom environments at the site.',
    `number_of_employees` STRING COMMENT 'Headcount of staff assigned to the site.',
    `number_of_tools` STRING COMMENT 'Total count of lithography, etch, deposition, and other equipment.',
    `operational_hours_per_day` STRING COMMENT 'Standard number of production hours each day.',
    `operational_status` STRING COMMENT 'The operational status of the fab site record in the fabrication domain.',
    `owner_department` STRING COMMENT 'Internal department responsible for the site.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the fab site address.',
    `power_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical power available to the site in megawatts.',
    `region` STRING COMMENT 'Broad region (e.g., APAC, EMEA, Americas) where the site resides.',
    `safety_incident_count` STRING COMMENT 'Number of recorded safety incidents at the site in the past year.',
    `security_level` STRING COMMENT 'Physical and logical security classification of the site.',
    `site_area_sq_m` DECIMAL(18,2) COMMENT 'Total built‑up area of the fab site in square meters.',
    `site_code` STRING COMMENT 'Business code used to reference the fab site in external systems.',
    `site_name` STRING COMMENT 'The site name of the fab site record in the fabrication domain.',
    `site_type` STRING COMMENT 'Category of the site (e.g., fab, test, R&D, assembly).',
    `start_date` DATE COMMENT 'Date when the fab site became operational.',
    `state` STRING COMMENT 'State or province of the fab site location.',
    `state_province` STRING COMMENT 'The state province of the fab site record in the fabrication domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `waste_treatment_capacity_tons_per_day` DECIMAL(18,2) COMMENT 'Maximum waste treatment throughput per day.',
    `water_capacity_m3_per_day` DECIMAL(18,2) COMMENT 'Daily water supply capacity for the fab site.',
    CONSTRAINT pk_fab_site PRIMARY KEY(`fab_site_id`)
) COMMENT 'Master reference table for fab_site. Referenced by fab_site_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_parent_lot_fabrication_wafer_lot_id` FOREIGN KEY (`parent_lot_fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_mask_set_id` FOREIGN KEY (`mask_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ADD CONSTRAINT `fk_fabrication_fabrication_process_step_equipment_group_id` FOREIGN KEY (`equipment_group_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`equipment_group`(`equipment_group_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ADD CONSTRAINT `fk_fabrication_fabrication_process_step_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ADD CONSTRAINT `fk_fabrication_fabrication_process_step_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ADD CONSTRAINT `fk_fabrication_fabrication_process_step_rework_target_step_id` FOREIGN KEY (`rework_target_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ADD CONSTRAINT `fk_fabrication_fabrication_process_step_spc_control_plan_id` FOREIGN KEY (`spc_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan`(`spc_control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ADD CONSTRAINT `fk_fabrication_fabrication_process_flow_spc_control_plan_id` FOREIGN KEY (`spc_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan`(`spc_control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_equipment_run_id` FOREIGN KEY (`equipment_run_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`equipment_run`(`equipment_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_mask_set_id` FOREIGN KEY (`mask_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_reticle_set_id` FOREIGN KEY (`reticle_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`reticle_set`(`reticle_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_fabrication_process_step_id` FOREIGN KEY (`fabrication_process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`(`fabrication_process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ADD CONSTRAINT `fk_fabrication_fabrication_lot_genealogy_primary_fabrication_wafer_lot_id` FOREIGN KEY (`primary_fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ADD CONSTRAINT `fk_fabrication_fabrication_technology_node_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fabrication_process_flow_id` FOREIGN KEY (`fabrication_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`(`fabrication_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_primary_fab_wafer_id` FOREIGN KEY (`primary_fab_wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_derived_from_mask_set_id` FOREIGN KEY (`derived_from_mask_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ADD CONSTRAINT `fk_fabrication_fab_facility_parent_fab_facility_id` FOREIGN KEY (`parent_fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ADD CONSTRAINT `fk_fabrication_work_center_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ADD CONSTRAINT `fk_fabrication_work_center_parent_work_center_id` FOREIGN KEY (`parent_work_center_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ADD CONSTRAINT `fk_fabrication_spc_control_plan_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ADD CONSTRAINT `fk_fabrication_spc_control_plan_superseded_spc_control_plan_id` FOREIGN KEY (`superseded_spc_control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan`(`spc_control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ADD CONSTRAINT `fk_fabrication_equipment_group_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ADD CONSTRAINT `fk_fabrication_equipment_group_parent_equipment_group_id` FOREIGN KEY (`parent_equipment_group_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`equipment_group`(`equipment_group_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ADD CONSTRAINT `fk_fabrication_equipment_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`equipment_group`(`equipment_group_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ADD CONSTRAINT `fk_fabrication_fabrication_fab_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ADD CONSTRAINT `fk_fabrication_fabrication_fab_fab_site_id` FOREIGN KEY (`fab_site_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_site`(`fab_site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ADD CONSTRAINT `fk_fabrication_reticle_set_derived_from_reticle_set_id` FOREIGN KEY (`derived_from_reticle_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`reticle_set`(`reticle_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ADD CONSTRAINT `fk_fabrication_reticle_set_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ADD CONSTRAINT `fk_fabrication_reticle_set_mask_set_id` FOREIGN KEY (`mask_set_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ADD CONSTRAINT `fk_fabrication_plant_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ADD CONSTRAINT `fk_fabrication_plant_parent_plant_id` FOREIGN KEY (`parent_plant_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`plant`(`plant_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ADD CONSTRAINT `fk_fabrication_fab_site_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ADD CONSTRAINT `fk_fabrication_fab_site_parent_fab_site_id` FOREIGN KEY (`parent_fab_site_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_site`(`fab_site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ADD CONSTRAINT `fk_fabrication_fab_site_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`plant`(`plant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`fabrication` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`fabrication` SET TAGS ('dbx_domain' = 'fabrication');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_ssot_owner' = 'wafer_lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `parent_lot_fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_name` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_number` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_process_area` SET TAGS ('dbx_business_glossary_term' = 'Current Process Area');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_process_area` SET TAGS ('dbx_value_regex' = 'feol|mol|beol|metrology|test');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fab_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fab_facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `hold_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `initial_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Initial Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `is_hot_lot` SET TAGS ('dbx_business_glossary_term' = 'Is Hot Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|partial|rework|scrap|engineering_hold');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_notes` SET TAGS ('dbx_business_glossary_term' = 'Lot Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_on_node` SET TAGS ('dbx_business_glossary_term' = 'Lot On Node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'production|engineering|qualification|mpw|pilot|rework');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `mes_system_source` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) System Source');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `mes_system_source` SET TAGS ('dbx_value_regex' = 'camstar|smartfactory|other');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `priority_class` SET TAGS ('dbx_value_regex' = 'hot|expedite|normal|engineering|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Process Time (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `product_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `queue_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Queue Time (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `rework_count` SET TAGS ('dbx_business_glossary_term' = 'Rework Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `route_version` SET TAGS ('dbx_business_glossary_term' = 'Route Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `route_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `sampling_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `sampling_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `scrap_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Scrap Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `split_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Split Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wafer_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wip_status` SET TAGS ('dbx_business_glossary_term' = 'Work In Process (WIP) Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wip_status` SET TAGS ('dbx_value_regex' = 'queued|in_process|on_hold|completed|scrapped|shipped');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'FAB (Fabrication Facility) Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `belongs_to_lot` SET TAGS ('dbx_business_glossary_term' = 'Belongs To Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_business_glossary_term' = 'Crystal Orientation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_value_regex' = '100|110|111');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `current_operation_number` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `current_process_step` SET TAGS ('dbx_business_glossary_term' = 'Current Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Wafer Disposition Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'in_process|completed|scrapped|quarantined|on_hold|awaiting_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `doping_type` SET TAGS ('dbx_business_glossary_term' = 'Doping Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `doping_type` SET TAGS ('dbx_value_regex' = 'p_type|n_type|intrinsic');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `epitaxial_layer_flag` SET TAGS ('dbx_business_glossary_term' = 'Epitaxial Layer Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `epitaxial_resistivity_ohm_cm` SET TAGS ('dbx_business_glossary_term' = 'Epitaxial Layer Resistivity (Ohm-Centimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `epitaxial_thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Epitaxial Layer Thickness (Micrometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `expected_die_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `genealogy_path` SET TAGS ('dbx_business_glossary_term' = 'Wafer Genealogy Path');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `last_process_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Process Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `notch_orientation_degrees` SET TAGS ('dbx_business_glossary_term' = 'Notch Orientation (Degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `resistivity_ohm_cm` SET TAGS ('dbx_business_glossary_term' = 'Resistivity (Ohm-Centimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `rework_count` SET TAGS ('dbx_business_glossary_term' = 'Rework Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `slot_position` SET TAGS ('dbx_business_glossary_term' = 'Slot Position');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `substrate_type` SET TAGS ('dbx_value_regex' = 'silicon|gallium_arsenide|silicon_carbide|gallium_nitride|sapphire|germanium');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Wafer Thickness (Micrometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `wafer_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `wafer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` SET TAGS ('dbx_ssot_owner' = 'process_recipe');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `equipment_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Process Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `chamber_configuration` SET TAGS ('dbx_business_glossary_term' = 'Chamber Configuration');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Control Reference');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `defect_density_target_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Target (Per Square Centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `fmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Reference');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `gas_flow_parameters` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Parameters');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `power_settings_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Settings (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Duration (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_layer_type` SET TAGS ('dbx_business_glossary_term' = 'Process Layer Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_layer_type` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_operation_type` SET TAGS ('dbx_business_glossary_term' = 'Process Operation Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_qualified|in_qualification|qualified|requalification_required');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_description` SET TAGS ('dbx_business_glossary_term' = 'Recipe Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|suspended|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'standard|hazardous_material|high_temperature|high_pressure|toxic_gas');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `spc_control_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Plan Reference');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `step_sequence_definition` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Definition');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `target_material` SET TAGS ('dbx_business_glossary_term' = 'Target Material');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `target_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Thickness (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `uniformity_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Uniformity Target (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `equipment_group_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Group Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `rework_target_step_id` SET TAGS ('dbx_business_glossary_term' = 'Rework Target Step Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `rework_target_step_id` SET TAGS ('dbx_renamed_from' = 'rework_target_step_id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `spc_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Plan Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `critical_step_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Step Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `max_queue_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Queue Time (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `min_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type (Front End of Line / Middle of Line / Back End of Line)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `process_category` SET TAGS ('dbx_business_glossary_term' = 'Process Category');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `process_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Process Subcategory');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `rework_loop_indicator` SET TAGS ('dbx_business_glossary_term' = 'Rework Loop Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `sampling_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `skip_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Skip Allowed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `standard_queue_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Queue Time (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `step_code` SET TAGS ('dbx_business_glossary_term' = 'Process Step Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `step_cost_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Step Cost Per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `step_cost_per_wafer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `step_description` SET TAGS ('dbx_business_glossary_term' = 'Process Step Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Process Step Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `step_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Process Step Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'active|inactive|engineering|obsolete|pending_approval');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `target_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Cycle Time (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `cooling_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Cooling Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Process Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `spc_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Plan Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `beol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Back End Of Line (BEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `cool_optimization_mode` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Mode');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `coolant_type` SET TAGS ('dbx_business_glossary_term' = 'Coolant Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `cooling_method` SET TAGS ('dbx_business_glossary_term' = 'Cooling Method');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `cooling_optimization_mode` SET TAGS ('dbx_business_glossary_term' = 'Cooling Optimization Mode');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `fabrication_process_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `estimated_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `fab_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `feol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Front End Of Line (FEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `flow_revision` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Revision');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|frozen|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_value_regex' = 'standard|mpw|engineering|qualification|rnd');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `is_customer_specific` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Specific Flow Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_value_regex' = 'euv|duv|immersion|dry');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `mol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Middle Of Line (MOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|requalification_required');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `requires_nre` SET TAGS ('dbx_business_glossary_term' = 'Requires Non-Recurring Engineering (NRE) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Generation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `total_process_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Process Steps Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `waste_elimination_strategy` SET TAGS ('dbx_business_glossary_term' = 'Waste Elimination Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow` ALTER COLUMN `waste_elimination_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Waste Elimination Target Pct');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Operation Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `actual_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Actual Flow Rate (SCCM)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `actual_power_watts` SET TAGS ('dbx_business_glossary_term' = 'Actual Power (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `actual_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `at_step` SET TAGS ('dbx_business_glossary_term' = 'At Step');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `control_job_code` SET TAGS ('dbx_business_glossary_term' = 'Control Job ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `control_job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|rework|scrap|hold|conditional_pass');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|angstrom|ohm_cm|percent|ppm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `move_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Move-In Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `move_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Move-Out Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `move_status` SET TAGS ('dbx_business_glossary_term' = 'Move Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `move_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|aborted|held|skipped');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'hot|expedite|normal|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `process_layer` SET TAGS ('dbx_business_glossary_term' = 'Process Layer');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `process_layer` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `process_module` SET TAGS ('dbx_business_glossary_term' = 'Process Module');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `process_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Time (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `quantity_in` SET TAGS ('dbx_business_glossary_term' = 'Quantity In');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `quantity_out` SET TAGS ('dbx_business_glossary_term' = 'Quantity Out');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `queue_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Queue Time (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `recipe_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `sampling_flag` SET TAGS ('dbx_business_glossary_term' = 'Sampling Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `technology_node` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}nm$|^[0-9]{1,3}um$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `tracks_lot` SET TAGS ('dbx_business_glossary_term' = 'Tracks Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By User Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `creates_lot` SET TAGS ('dbx_business_glossary_term' = 'Creates Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_business_glossary_term' = 'Crystal Orientation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_value_regex' = '^<[0-9]{3}>$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `doping_type` SET TAGS ('dbx_business_glossary_term' = 'Doping Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `doping_type` SET TAGS ('dbx_value_regex' = 'p_type|n_type|intrinsic');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `ear_classification` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `estimated_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `fab_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `fab_facility_code` SET TAGS ('dbx_value_regex' = '^FAB[0-9]{2,4}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `nre_project_code` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Project Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `nre_project_code` SET TAGS ('dbx_value_regex' = '^NRE[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `nre_project_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `parent_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `parent_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `priority_class` SET TAGS ('dbx_value_regex' = 'hot|standard|engineering|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `production_line` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `production_line` SET TAGS ('dbx_value_regex' = '^LINE[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `resistivity_ohm_cm` SET TAGS ('dbx_business_glossary_term' = 'Resistivity (Ohm-Centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `split_reason` SET TAGS ('dbx_business_glossary_term' = 'Split Reason');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `start_creates_lot` SET TAGS ('dbx_business_glossary_term' = 'Start Creates Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `substrate_type` SET TAGS ('dbx_value_regex' = 'silicon|soi|gaas|gan|sic');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `technology_node` SET TAGS ('dbx_value_regex' = '^[0-9]+(nm|NM)$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_date` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_number` SET TAGS ('dbx_value_regex' = '^WS[0-9]{10}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_status` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_status` SET TAGS ('dbx_value_regex' = 'authorized|released|in_process|completed|cancelled|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_type` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_type` SET TAGS ('dbx_value_regex' = 'production|engineering|qualification|mpw|pilot|rework');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `work_center` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `work_center` SET TAGS ('dbx_value_regex' = '^WC[0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` SET TAGS ('dbx_ssot_owner' = 'lot_hold');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fabrication_lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `primary_fabrication_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `primary_fabrication_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `primary_fabrication_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `primary_fabrication_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `primary_fabrication_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `defect_density_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Threshold Exceeded Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'resume|rework|scrap|quarantine|return_to_customer|engineering_review');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_cycle_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Cycle Time (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_placement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|cancelled|expired');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `initiating_system` SET TAGS ('dbx_business_glossary_term' = 'Initiating System');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `mes_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `spc_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `lot_disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `equipment_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Facility (FAB) ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Rework Route ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `affected_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `customer_approval_received` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Received');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `defect_die_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_authority` SET TAGS ('dbx_business_glossary_term' = 'Disposition Authority');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Disposition Authority Role');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_authority_role` SET TAGS ('dbx_value_regex' = 'quality_engineer|production_supervisor|process_engineer|fab_manager|automated_system');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_number` SET TAGS ('dbx_business_glossary_term' = 'Disposition Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_number` SET TAGS ('dbx_value_regex' = '^DISP-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_of_lot` SET TAGS ('dbx_business_glossary_term' = 'Disposition Of Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|executed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_business_glossary_term' = 'Disposition Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_value_regex' = 'accept|scrap|rework|downgrade|hold|ship_as_is');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `executed_by` SET TAGS ('dbx_business_glossary_term' = 'Executed By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Executed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `lot_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Lot Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment_failure|process_deviation|material_defect|operator_error|design_issue|contamination');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `waiver_number` SET TAGS ('dbx_business_glossary_term' = 'Waiver Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_disposition` ALTER COLUMN `waiver_number` SET TAGS ('dbx_value_regex' = '^WVR-[0-9]{8}-[A-Z0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `fab_run_card_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Run Card Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|quarantine|scrap');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'automotive|industrial|commercial|consumer');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_follows_flow` SET TAGS ('dbx_business_glossary_term' = 'Run Card Follows Flow');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_for_lot` SET TAGS ('dbx_business_glossary_term' = 'Run Card For Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_number` SET TAGS ('dbx_business_glossary_term' = 'Run Card Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_specifies_flow` SET TAGS ('dbx_business_glossary_term' = 'Run Card Specifies Flow');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_status` SET TAGS ('dbx_business_glossary_term' = 'Run Card Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_type` SET TAGS ('dbx_business_glossary_term' = 'Run Card Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_type` SET TAGS ('dbx_value_regex' = 'production|engineering|qualification|rework|pilot|development');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_version` SET TAGS ('dbx_business_glossary_term' = 'Run Card Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_run_card` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Lithography Reticle ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `abort_reason` SET TAGS ('dbx_business_glossary_term' = 'Abort Reason');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `actual_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure Torr');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `actual_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `alarm_count` SET TAGS ('dbx_business_glossary_term' = 'Alarm Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `chamber_cooling_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Chamber Cooling Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_removal_rate_angstrom_per_min` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Removal Rate Angstrom Per Minute');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_slurry_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Slurry Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_wiwnu_percent` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Within-Wafer Non-Uniformity (WIWNU) Percent');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `coolant_flow_rate_lpm` SET TAGS ('dbx_business_glossary_term' = 'Coolant Flow Rate Lpm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `cooling_rate_celsius_per_min` SET TAGS ('dbx_business_glossary_term' = 'Cooling Rate Celsius Per Min');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `deposition_film_material` SET TAGS ('dbx_business_glossary_term' = 'Deposition Film Material');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `deposition_rate_angstrom_per_min` SET TAGS ('dbx_business_glossary_term' = 'Deposition Rate Angstrom Per Minute');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `deposition_thickness_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Deposition Thickness Angstrom');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `deposition_uniformity_percent` SET TAGS ('dbx_business_glossary_term' = 'Deposition Uniformity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `implant_dose_atoms_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Implant Dose Atoms Per Square Centimeter');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `implant_energy_kev` SET TAGS ('dbx_business_glossary_term' = 'Implant Energy Kiloelectron Volts (keV)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `implant_species` SET TAGS ('dbx_business_glossary_term' = 'Implant Species');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `implant_tilt_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Implant Tilt Angle Degrees');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `implant_twist_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Implant Twist Angle Degrees');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_cd_measurement_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Critical Dimension (CD) Measurement Nanometers');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_exposure_dose_mj_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Lithography Exposure Dose Millijoules Per Square Centimeter');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_focus_offset_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Focus Offset Nanometers');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_overlay_x_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Overlay X-Axis Nanometers');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_overlay_y_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Overlay Y-Axis Nanometers');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `mes_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `process_type` SET TAGS ('dbx_business_glossary_term' = 'Process Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `processes_lot` SET TAGS ('dbx_business_glossary_term' = 'Processes Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration Seconds');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `run_processes_lot` SET TAGS ('dbx_business_glossary_term' = 'Run Processes Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'completed|aborted|failed|in_progress|paused');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `run_uses_recipe` SET TAGS ('dbx_business_glossary_term' = 'Run Uses Recipe');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `target_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Target Pressure Torr');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `target_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `uses_recipe` SET TAGS ('dbx_business_glossary_term' = 'Uses Recipe');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `wafer_slot_map` SET TAGS ('dbx_business_glossary_term' = 'Wafer Slot Map');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `waste_heat_recovered_kwh` SET TAGS ('dbx_business_glossary_term' = 'Waste Heat Recovered Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` SET TAGS ('dbx_subdomain' = 'tooling_resources');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Project Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `reticle_set_id` SET TAGS ('dbx_business_glossary_term' = 'Reticle Set Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `cd_uniformity_specification` SET TAGS ('dbx_business_glossary_term' = 'Critical Dimension (CD) Uniformity Specification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `cleaning_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Cycle Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `critical_dimension_target_nm` SET TAGS ('dbx_business_glossary_term' = 'Critical Dimension (CD) Target Nanometers (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `cumulative_exposure_hours` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Exposure Hours');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `cumulative_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Usage Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `defect_count_last_inspection` SET TAGS ('dbx_business_glossary_term' = 'Defect Count Last Inspection');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `defect_retirement_threshold` SET TAGS ('dbx_business_glossary_term' = 'Defect Retirement Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `gds_file_checksum` SET TAGS ('dbx_business_glossary_term' = 'Graphic Data System (GDS) File Checksum');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `gds_file_checksum` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{32,64}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `last_cleaning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaning Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `layer_name` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `lithography_wavelength` SET TAGS ('dbx_business_glossary_term' = 'Lithography Wavelength');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `lithography_wavelength` SET TAGS ('dbx_value_regex' = 'euv_13.5nm|duv_193nm|duv_248nm|i_line_365nm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `mask_generation` SET TAGS ('dbx_business_glossary_term' = 'Mask Generation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `mask_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Mask Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `mask_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,25}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `mask_status` SET TAGS ('dbx_business_glossary_term' = 'Mask Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `mask_type` SET TAGS ('dbx_business_glossary_term' = 'Mask Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `mask_type` SET TAGS ('dbx_value_regex' = 'binary|attenuated_psm|alternating_psm|euv_pellicle|euv_non_pellicle|optical_proximity_correction');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `opc_version` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `opc_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._]{3,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `pellicle_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Pellicle Installation Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `pellicle_status` SET TAGS ('dbx_business_glossary_term' = 'Pellicle Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `pellicle_status` SET TAGS ('dbx_value_regex' = 'installed|removed|damaged|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `registration_error_specification_nm` SET TAGS ('dbx_business_glossary_term' = 'Registration Error Specification Nanometers (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'usage_limit|defect_limit|pattern_revision|process_obsolescence|physical_damage|lost');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `technology_node` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}nm$|^[0-9]{1,2}um$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `usage_retirement_threshold` SET TAGS ('dbx_business_glossary_term' = 'Usage Retirement Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` SET TAGS ('dbx_ssot_owner' = 'lot_genealogy');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `fabrication_lot_genealogy_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Genealogy ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Child Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Operation ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `primary_fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `destination_fab_line` SET TAGS ('dbx_business_glossary_term' = 'Destination FAB (Fabrication Facility) Line');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `is_reversible` SET TAGS ('dbx_business_glossary_term' = 'Is Reversible');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `mes_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'MES (Manufacturing Execution System) Transaction ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `process_stage` SET TAGS ('dbx_business_glossary_term' = 'Process Stage');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `process_stage` SET TAGS ('dbx_value_regex' = 'feol|mol|beol');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `relationship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Relationship Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'split|merge|rework|mpw_separation|scrap|hold_release');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `source_fab_line` SET TAGS ('dbx_business_glossary_term' = 'Source FAB (Fabrication Facility) Line');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `wafer_count_transferred` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count Transferred');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` SET TAGS ('dbx_ssot_owner' = 'technology_node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Complexity Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `dfm_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Enabled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `dft_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Enabled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `iatf16949_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'International Automotive Task Force (IATF) 16949 Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `iso9001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_value_regex' = 'duv|euv|immersion|dry');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `minimum_feature_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Feature Size (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `node_generation` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Generation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `nre_cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost Estimate (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `nre_cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `power_performance_area_rating` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area (PPA) Rating');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `process_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `production_readiness_date` SET TAGS ('dbx_business_glossary_term' = 'Production Readiness Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'development|qualification|qualified|production|mature|eol');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `supported_application_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Application Types');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet|nanowire');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Yield Record Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `primary_fab_wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_1_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 1 Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_2_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 2 Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_3_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 3 Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `checkpoint_code` SET TAGS ('dbx_business_glossary_term' = 'Yield Checkpoint Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Comments');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Lower');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Upper');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `design_loss_die_count` SET TAGS ('dbx_business_glossary_term' = 'Design Loss Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|HOLD|REWORK|SCRAP');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `excursion_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Excursion Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `excursion_severity_level` SET TAGS ('dbx_value_regex' = 'CRITICAL|MAJOR|MINOR|NONE');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `gross_die_count` SET TAGS ('dbx_business_glossary_term' = 'Gross Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Yield Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `process_loss_die_count` SET TAGS ('dbx_business_glossary_term' = 'Process Loss Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `random_defect_die_count` SET TAGS ('dbx_business_glossary_term' = 'Random Defect Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `reject_bin_die_count` SET TAGS ('dbx_business_glossary_term' = 'Reject Bin Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `scrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Scrap Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `specification_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit Lower');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `systematic_defect_die_count` SET TAGS ('dbx_business_glossary_term' = 'Systematic Defect Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Yield Excursion Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_for_lot` SET TAGS ('dbx_business_glossary_term' = 'Yield For Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_record_for_lot` SET TAGS ('dbx_business_glossary_term' = 'Yield Record For Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` SET TAGS ('dbx_subdomain' = 'tooling_resources');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `derived_from_mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Derived From Mask Set Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `derived_from_mask_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `application_area` SET TAGS ('dbx_business_glossary_term' = 'Application Area');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_set_category` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Category');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_set_code` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_set_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `exposure_tool` SET TAGS ('dbx_business_glossary_term' = 'Exposure Tool');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Mask Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Mask Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_material` SET TAGS ('dbx_business_glossary_term' = 'Mask Material');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_set_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Mask Thickness Nm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_type` SET TAGS ('dbx_business_glossary_term' = 'Mask Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `mask_set_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Priority');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`mask_set` ALTER COLUMN `wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Wavelength Nm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` SET TAGS ('dbx_subdomain' = 'tooling_resources');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `parent_fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fab Facility Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `parent_fab_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `capacity_wafer_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafer Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `carbon_footprint_kgco2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Kgco2e');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Class');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `fab_facility_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Mwh');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `environmental_certifications` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `equipment_summary` SET TAGS ('dbx_business_glossary_term' = 'Equipment Summary');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `fab_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Fab Area Sqft');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Location Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Location Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `next_audit_due` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `number_of_cleanrooms` SET TAGS ('dbx_business_glossary_term' = 'Number Of Cleanrooms');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `number_of_equipment_units` SET TAGS ('dbx_business_glossary_term' = 'Number Of Equipment Units');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `process_technology_node` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `restricted_access` SET TAGS ('dbx_business_glossary_term' = 'Restricted Access');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `safety_certifications` SET TAGS ('dbx_business_glossary_term' = 'Safety Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `shift_schedule` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `waste_generated_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated Tons');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `water_usage_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Usage M3');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `parent_work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `parent_work_center_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `area_sq_m` SET TAGS ('dbx_business_glossary_term' = 'Area Sq M');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `capacity_wafers_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafers Per Hour');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `control_system_version` SET TAGS ('dbx_business_glossary_term' = 'Control System Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `work_center_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `equipment_count` SET TAGS ('dbx_business_glossary_term' = 'Equipment Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `fab_line` SET TAGS ('dbx_business_glossary_term' = 'Fab Line');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `manager_contact` SET TAGS ('dbx_business_glossary_term' = 'Manager Contact');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `manager_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `manager_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `next_calibration_due` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `shift_schedule` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`work_center` ALTER COLUMN `work_center_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `spc_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `process_spc_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Process Spc Control Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `superseded_spc_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Spc Control Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `superseded_spc_control_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Lower');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Upper');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `spc_control_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `spc_control_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`spc_control_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `equipment_group_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Group Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `parent_equipment_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Equipment Group Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `parent_equipment_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `parent_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Group Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `capacity_wafers_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafers Per Hour');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `equipment_group_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `default_capacity` SET TAGS ('dbx_business_glossary_term' = 'Default Capacity');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `equipment_group_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `equipment_count` SET TAGS ('dbx_business_glossary_term' = 'Equipment Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `equipment_group_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `fab_location` SET TAGS ('dbx_business_glossary_term' = 'Fab Location');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `group_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Group Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Max Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `equipment_group_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `safety_class` SET TAGS ('dbx_business_glossary_term' = 'Safety Class');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `tool_count` SET TAGS ('dbx_business_glossary_term' = 'Tool Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `utilization_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `voltage_rating_v` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating V');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_group` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `fabrication_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Site Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `capacity_wafer_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafer Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `capacity_wafers_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafers Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `capacity_wspm` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wspm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Class');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `fab_code` SET TAGS ('dbx_business_glossary_term' = 'Fab Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `fab_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `fab_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `fab_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `fab_type` SET TAGS ('dbx_business_glossary_term' = 'Fab Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Location State');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `next_scheduled_maintenance` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `number_of_cleanrooms` SET TAGS ('dbx_business_glossary_term' = 'Number Of Cleanrooms');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `power_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity Mw');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Fab Region');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `technology_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `total_area_sq_m` SET TAGS ('dbx_business_glossary_term' = 'Total Area Sq M');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `waste_treatment_capacity_kg_per_day` SET TAGS ('dbx_business_glossary_term' = 'Waste Treatment Capacity Kg Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `waste_treatment_capacity_kg_per_day` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `waste_treatment_capacity_kg_per_day` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_fab` ALTER COLUMN `water_usage_cubic_m_per_day` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Cubic M Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` SET TAGS ('dbx_subdomain' = 'tooling_resources');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `reticle_set_id` SET TAGS ('dbx_business_glossary_term' = 'Reticle Set Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `derived_from_reticle_set_id` SET TAGS ('dbx_business_glossary_term' = 'Derived From Reticle Set Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `derived_from_reticle_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `reticle_set_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `current_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Current Cycle Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `defect_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Defect Rate Ppm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `reticle_set_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `expected_lifetime_cycles` SET TAGS ('dbx_business_glossary_term' = 'Expected Lifetime Cycles');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `exposure_tool` SET TAGS ('dbx_business_glossary_term' = 'Exposure Tool');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `fab_location` SET TAGS ('dbx_business_glossary_term' = 'Fab Location');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `field_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Field Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `field_size_x_mm` SET TAGS ('dbx_business_glossary_term' = 'Field Size X Mm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `field_size_y_mm` SET TAGS ('dbx_business_glossary_term' = 'Field Size Y Mm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `is_licensed` SET TAGS ('dbx_business_glossary_term' = 'Is Licensed');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `magnification_factor` SET TAGS ('dbx_business_glossary_term' = 'Magnification Factor');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Material');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `reticle_set_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `number_of_reticles` SET TAGS ('dbx_business_glossary_term' = 'Number Of Reticles');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `reduction_ratio` SET TAGS ('dbx_business_glossary_term' = 'Reduction Ratio');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `reticle_count` SET TAGS ('dbx_business_glossary_term' = 'Reticle Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `reticle_set_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `reticle_set_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `retire_date` SET TAGS ('dbx_business_glossary_term' = 'Retire Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `retire_reason` SET TAGS ('dbx_business_glossary_term' = 'Retire Reason');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Revision');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `total_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Total Area Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`reticle_set` ALTER COLUMN `wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Wavelength Nm');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` SET TAGS ('dbx_subdomain' = 'tooling_resources');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `parent_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Plant Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `parent_plant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `area_sq_m` SET TAGS ('dbx_business_glossary_term' = 'Area Sq M');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `capacity_wafer_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafer Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Class');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `plant_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `environmental_rating` SET TAGS ('dbx_business_glossary_term' = 'Environmental Rating');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `maintenance_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle Days');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `plant_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `number_of_cleanrooms` SET TAGS ('dbx_business_glossary_term' = 'Number Of Cleanrooms');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `number_of_fabs` SET TAGS ('dbx_business_glossary_term' = 'Number Of Fabs');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `operational_shift` SET TAGS ('dbx_business_glossary_term' = 'Operational Shift');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `plant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `power_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity Mw');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `shutdown_date` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `waste_treatment_capacity_tons_per_day` SET TAGS ('dbx_business_glossary_term' = 'Waste Treatment Capacity Tons Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `waste_treatment_capacity_tons_per_day` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `waste_treatment_capacity_tons_per_day` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `water_usage_m3_per_day` SET TAGS ('dbx_business_glossary_term' = 'Water Usage M3 Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`plant` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` SET TAGS ('dbx_subdomain' = 'tooling_resources');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Site Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `parent_fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fab Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `parent_fab_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `capacity_wafer_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafer Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `fab_site_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `fab_site_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `ghs_compliance` SET TAGS ('dbx_business_glossary_term' = 'Ghs Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `is_primary_site` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Site');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `fab_site_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `number_of_cleanrooms` SET TAGS ('dbx_business_glossary_term' = 'Number Of Cleanrooms');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `number_of_tools` SET TAGS ('dbx_business_glossary_term' = 'Number Of Tools');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `operational_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `power_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity Mw');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `site_area_sq_m` SET TAGS ('dbx_business_glossary_term' = 'Site Area Sq M');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `waste_treatment_capacity_tons_per_day` SET TAGS ('dbx_business_glossary_term' = 'Waste Treatment Capacity Tons Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `waste_treatment_capacity_tons_per_day` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `waste_treatment_capacity_tons_per_day` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_site` ALTER COLUMN `water_capacity_m3_per_day` SET TAGS ('dbx_business_glossary_term' = 'Water Capacity M3 Per Day');
