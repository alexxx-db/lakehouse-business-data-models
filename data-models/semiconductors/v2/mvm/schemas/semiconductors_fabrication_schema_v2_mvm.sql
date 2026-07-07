-- Schema for Domain: fabrication | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:13:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`fabrication` COMMENT 'Core wafer fabrication and processing domain governing all FAB operations including FEOL, MOL, and BEOL process steps. Owns wafer lot tracking, WIP management, process recipe execution, and fab line scheduling across CVD, PVD, ALD, CMP, ion implantation, and EUV/DUV lithography operations. Authoritative source for wafer genealogy and lot disposition via MES integration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` (
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the wafer lot tracked through the FAB from wafer start to lot disposition. Primary key for all WIP lot tracking across FEOL, MOL, and BEOL operations.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Foundry customer-specific lot tracking: a wafer lot is started for a specific customer account, enabling customer WIP visibility, capacity allocation reporting, and revenue recognition by customer. Do',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Quality audits and customer complaint investigations require knowing which tool qualification was active when a lot was processed. ISO 9001 and IATF 16949 traceability requirements mandate linking pro',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: WIP visibility and hot-lot expediting require knowing which fab_tool currently holds a lot. MES WIP dashboards, cycle-time reports, and tool utilization tracking all depend on this link. No existing c',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Design-win production execution traceability: the wafer lot executing a customers design win must reference that design win for production ramp tracking, estimated annual volume vs. actual volume rec',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Required for Production Planning Report linking each wafer lot to the specific IC catalog item being manufactured.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: In semiconductor build-to-order operations, each wafer lot is started against a specific order line for ATP/CTP tracking and delivery commitment. The existing link to order.order is header-level only;',
    `parent_lot_fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the parent lot from which this lot was split or derived. Null for original lots. Enables wafer genealogy tracking and traceability.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: PDK-version yield analysis and process compliance reporting require direct lot-to-PDK traceability. Fab engineers verify PDK version compatibility at lot release. Current path via ic_design_project re',
    `process_flow_id` BIGINT COMMENT 'Unique identifier for the process route (recipe sequence) assigned to this lot. Defines the complete sequence of operations from wafer start to completion.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Wafer lots are started and tracked against a specific product process node for capacity planning, cost accounting, and yield reporting by node. Fab planners use this link in WIP-by-node reports and no',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Wafer lot references a technology node; replace string column with FK to technology_node for normalization.',
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
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the parent wafer lot that this wafer belongs to. Wafers are processed in lots through the FAB (Fabrication Facility).',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Needed for Yield Analysis linking each wafer to its IC product for defect tracking.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Each wafer is processed under a specific PDK version governing layer stack, design rules, and process parameters. Direct wafer-to-PDK link enables per-wafer PDK compliance traceability required for fa',
    `process_flow_id` BIGINT COMMENT 'Reference to the process route or recipe that defines the sequence of fabrication steps for this wafer. Routes vary by product technology node and design.',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Wafer references a technology node; add FK to technology_node and remove numeric node column.',
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
    `number` STRING COMMENT 'Business identifier for the wafer within its lot. Typically a sequential number or alphanumeric code assigned during lot creation.. Valid values are `^[A-Z0-9]{1,20}$`',
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
    CONSTRAINT pk_wafer PRIMARY KEY(`wafer_id`)
) COMMENT 'Individual silicon wafer entity within a lot, tracking wafer number, substrate type, diameter, orientation, resistivity, epitaxial layer specs, and current disposition. Enables per-wafer genealogy and yield tracking across all FAB process steps. Sourced from Camstar MES wafer tracking module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` (
    `fabrication_process_recipe_id` BIGINT COMMENT 'Unique identifier for the fabrication process recipe. Primary key for this entity.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Process recipes are qualified and change-controlled per product family. PCN (Product Change Notification) processes require knowing which product families are affected by a recipe change. product_fami',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: A fabrication process recipe is scoped to a specific process flow. Recipe qualification and change control workflows require knowing which process.process_flow a recipe belongs to, enabling process en',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Recipe qualification and change‑control require explicit reference to the PDK version the recipe supports, ensuring process compatibility.',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: A fabrication process recipe is qualified and validated for a specific technology node. The existing process_node_nm (INT) column stores the node size in nanometers as a denormalized value. Replacing ',
    `approval_date` DATE COMMENT 'Date when the recipe was formally approved for production use.',
    `approval_status` STRING COMMENT 'Engineering approval status indicating whether the recipe has been reviewed and authorized for use by process engineering and quality teams.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the process engineer or quality manager who approved this recipe for production use.',
    `chamber_configuration` STRING COMMENT 'Specific chamber or module configuration within the equipment where the recipe is executed, enabling multi-chamber tool recipe management.',
    `change_control_reference` STRING COMMENT 'Reference to the Engineering Change Order (ECO) or Product Change Notification (PCN) that authorized the creation or modification of this recipe.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was first created in the MES system.',
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
    `process_operation_type` STRING COMMENT 'Type of FAB operation this recipe defines: Chemical Vapor Deposition (CVD), Physical Vapor Deposition (PVD), Atomic Layer Deposition (ALD), Chemical Mechanical Planarization (CMP), etch, lithography (EUV/DUV), ion implantation, diffusion, oxidation, annealing, or cleaning. [ENUM-REF-CANDIDATE: CVD|PVD|ALD|CMP|etch|lithography|ion_implantation|diffusion|oxidation|annealing|cleaning — 11 candidates stripped; promote to reference product]',
    `process_pressure_torr` DECIMAL(18,2) COMMENT 'Target chamber pressure in Torr for the recipe execution, critical for CVD, PVD, and ALD processes.',
    `process_temperature_celsius` DECIMAL(18,2) COMMENT 'Target process temperature in degrees Celsius for the recipe execution.',
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
    CONSTRAINT pk_fabrication_process_recipe PRIMARY KEY(`fabrication_process_recipe_id`)
) COMMENT 'Master record for a validated process recipe defining the exact sequence of process parameters, tool settings, gas flows, temperatures, pressures, and timing for a specific FAB operation (CVD, PVD, ALD, CMP, implant, etch, lithography). Includes recipe version history, approval status, change control reference, qualification status, and effective date range. Versioning managed within this entity via version number and effective dates. Sourced from Applied Materials SmartFactory MES recipe management and integrated with engineering change order workflow.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` (
    `process_flow_id` BIGINT COMMENT 'Unique identifier for the process flow. Primary key for the process flow entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-proprietary process flow ownership: the is_customer_specific flag on fabrication_process_flow indicates customer-owned flows exist. Linking to account enforces IP protection, NDA compliance, ',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) that provides device models, design rules, and technology files for this process flow.',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: A process flow is designed and qualified for a specific semiconductor technology node (e.g., 5nm, 7nm, 28nm). fabrication_technology_node is the authoritative reference master for node definitions. Th',
    `approval_date` DATE COMMENT 'Date when this process flow received formal approval for use in FAB operations.',
    `approved_by` STRING COMMENT 'Name or identifier of the process engineer or manager who approved this process flow for production use.',
    `beol_step_count` STRING COMMENT 'Number of process steps in the Back End Of Line (BEOL) phase covering metal interconnect layers and passivation.',
    `cool_optimization_mode` STRING COMMENT 'The cool optimization mode of the fabrication process flow record in the fabrication domain.',
    `coolant_type` STRING COMMENT 'The coolant type for the fabrication process flow record.',
    `cooling_method` STRING COMMENT 'The cooling method for fabrication process flow.',
    `cooling_optimization_mode` STRING COMMENT 'The cooling optimization mode of the fabrication process flow record in the fabrication domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was first created in the system.',
    `process_flow_description` STRING COMMENT 'Detailed textual description of the process flow including its purpose, key characteristics, and intended applications.',
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
    `total_process_steps` STRING COMMENT 'Total number of discrete process steps defined in this flow spanning FEOL, MOL, and BEOL operations.',
    `transistor_architecture` STRING COMMENT 'Transistor device architecture employed in this process flow: planar MOSFET, FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), or nanosheet.. Valid values are `planar|finfet|gaa|nanosheet`',
    `wafer_size_mm` STRING COMMENT 'Wafer diameter in millimeters that this process flow is designed for (e.g., 200mm, 300mm, 450mm).',
    `waste_elimination_strategy` STRING COMMENT 'The waste elimination strategy of the fabrication process flow record in the fabrication domain.',
    `waste_elimination_target_pct` DECIMAL(18,2) COMMENT 'The waste elimination target pct of the fabrication process flow record in the fabrication domain.',
    CONSTRAINT pk_process_flow PRIMARY KEY(`process_flow_id`)
) COMMENT 'Ordered sequence of process steps defining the complete manufacturing route for a product on a given technology node. Captures flow revision, node generation (e.g., 5nm, 7nm, 28nm), flow type (standard, MPW, engineering), effective dates, and approval status. SSOT for FAB routing and WIP scheduling. Aligned with SEMI E40 process management standard for flow-level routing definition.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` (
    `lot_move_id` BIGINT COMMENT 'Unique identifier for the lot move transaction. Primary key for this WIP (Work in Process) lot movement event through a FAB (Fabrication Facility) process step.',
    `fab_tool_id` BIGINT COMMENT 'Identifier for the FAB (Fabrication Facility) equipment or tool used to process this lot move (e.g., ATE (Automatic Test Equipment), lithography stepper, etcher, deposition chamber). Links to equipment master data.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: A lot move executes a specific fabrication process recipe (CVD, PVD, ALD, CMP, etc.). The existing recipe_id FK points to fabrication.recipe (cross-domain generic recipe), but fabrication_process_recipe i',
    `ic_catalog_id` BIGINT COMMENT 'Identifier for the IC (Integrated Circuit) product or device being manufactured in this lot. Links to product master data (e.g., SoC (System on Chip), ASIC (Application-Specific Integrated Circuit), FPGA (Field-Programmable Gate Array)).',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: In semiconductor MES, lot moves at inspection steps create or reference an inspection lot for in-line quality checks. Linking lot_move to inspection_lot supports in-line SPC reporting, process control',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: When a tool goes down mid-processing, the interrupted lot_move must be linked to the maintenance_event for cycle-time impact analysis, yield impact assessment, and OEE calculation. This is a standard ',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Lot move corresponds to a specific process step; linking supports operation tracking and step‑level performance reporting.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Lot moves are tracked per process node for node-level capacity utilization, cycle time analysis, and equipment loading reports. technology_node is a denormalized plain attribute referencing the proces',
    `recipe_id` BIGINT COMMENT 'Identifier for the process recipe executed during this lot move. Defines the specific parameter set, process conditions, and control settings used for this operation.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier for the specific process chamber or module within the equipment used for this lot move. Relevant for multi-chamber tools (e.g., CVD (Chemical Vapor Deposition), PVD (Physical Vapor Deposition), ALD (Atomic Layer Deposition) systems).',
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
    `tracks_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Every lot move transaction must reference the lot being moved. Core MES transaction integrity — cannot track WIP without this FK.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafers in this lot in millimeters (e.g., 200mm, 300mm, 450mm). Standard wafer size for the FAB (Fabrication Facility).',
    CONSTRAINT pk_lot_move PRIMARY KEY(`lot_move_id`)
) COMMENT 'Transactional record of each WIP lot movement through a process step in the FAB, capturing move-in timestamp, move-out timestamp, operator ID, equipment used, recipe executed, actual process parameters, pass/fail disposition, and quantity in/out. Core MES transaction sourced from Camstar MES and SmartFactory MES. Enables cycle time analysis and WIP genealogy.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` (
    `wafer_start_id` BIGINT COMMENT 'Unique identifier for the wafer start transaction. Primary key for the wafer start record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-level wafer start reporting: foundries track wafer starts per customer per period for capacity planning and revenue recognition. Direct account FK enables this without joining through sales o',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Design-win-to-production-ramp traceability: wafer starts are authorized when a design win reaches production phase. Linking wafer_start to customer_design_win enables the semiconductor industrys crit',
    `photomask_id` BIGINT COMMENT 'Identifier for the photomask set (reticle set) used for lithography steps in this wafer lot. Links to the physical layout and GDS data.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Wafer start transaction creates a new lot. Required for lot lifecycle tracking from inception.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Supports Wafer Start Scheduling report tying start orders to the IC catalog entry.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Wafer start authorization is gated on PDK version approval — the PDK defines which process recipe, design rules, and layer stack apply to the production run. Direct pdk_id enables NRE wafer-start auth',
    `process_flow_id` BIGINT COMMENT 'Identifier for the manufacturing process flow (recipe sequence) that this wafer lot will follow. Defines the FEOL, MOL, and BEOL steps.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Wafer starts are authorized against a product process node for NRE cost allocation, capacity planning, and production release decisions. Fab planning teams use this link to track starts-per-node for n',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Wafer start authorization consumes specific raw material lots (silicon substrate wafers). Linking wafer_start to raw_material enables raw material consumption tracking, lot traceability for quality ho',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: A wafer start authorization is issued for a specific technology node — this determines the process flow, recipe set, mask set, and compliance requirements (ITAR, EAR) applicable to the lot. The existi',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer start was formally authorized in the MES system. Precedes the actual release to the FAB line.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this wafer start record was first created in the MES database. Used for audit trail and data lineage.',
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
    `number` STRING COMMENT 'Business identifier for the wafer start transaction, externally visible and used for tracking and reporting. Format: WS followed by 10 digits.. Valid values are `^WS[0-9]{10}$`',
    `parent_lot_number` STRING COMMENT 'Lot number of the parent lot if this wafer start is a split or rework from an existing lot. Null for original starts. Enables wafer genealogy tracking.. Valid values are `^[A-Z0-9]{8,16}$`',
    `planned_completion_date` DATE COMMENT 'Target date for completing all FAB processing steps and releasing the lot to wafer test. Based on standard cycle time for the process flow.',
    `priority_class` STRING COMMENT 'Scheduling priority for this wafer lot in the FAB line. Hot lots receive expedited processing; engineering lots may have flexible timing; standard and low follow normal queue discipline.. Valid values are `hot|standard|engineering|low`',
    `production_line` STRING COMMENT 'Specific production line or bay within the FAB facility assigned to this wafer start. Determines equipment set and process capability.. Valid values are `^LINE[A-Z0-9]{2,6}$`',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot was physically released into the FAB line and began processing. Marks the start of cycle time measurement.',
    `requested_delivery_date` DATE COMMENT 'Customer-requested delivery date for finished wafers or packaged units. Drives priority and scheduling decisions.',
    `resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'Electrical resistivity of the starting wafer substrate, measured in ohm-centimeters. Indicates doping concentration and electrical characteristics.',
    `special_instructions` STRING COMMENT 'Free-text field for any special handling instructions, process deviations, or notes that operators and engineers should be aware of for this wafer lot.',
    `split_reason` STRING COMMENT 'Free-text explanation of why this lot was split from a parent lot, if applicable. Examples: process experiment, capacity balancing, quality segregation.',
    `substrate_type` STRING COMMENT 'Type of semiconductor substrate material used for this wafer lot. Silicon is standard; SOI (Silicon on Insulator), GaAs (Gallium Arsenide), GaN (Gallium Nitride), and SiC (Silicon Carbide) are specialty materials.. Valid values are `silicon|soi|gaas|gan|sic`',
    `timestamp` TIMESTAMP COMMENT 'Precise date and time when the wafer lot was released into the FAB line, including time zone. Used for detailed cycle time analysis and shift-level tracking.',
    `wafer_quantity` STRING COMMENT 'Number of wafers authorized and started in this lot. Represents the initial wafer count at FAB entry before any processing losses.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafer in millimeters. Standard values are 200mm or 300mm. Determines compatible equipment and process chambers.',
    `wafer_start_date` DATE COMMENT 'Calendar date when the wafer lot was authorized and initiated into the FAB line. Principal business event timestamp for capacity planning and WIP tracking.',
    `wafer_start_status` STRING COMMENT 'Current lifecycle status of the wafer start transaction. Authorized: approved but not yet released; Released: entered FAB line; In Process: active WIP; Completed: all steps finished; Cancelled: terminated before completion; On Hold: temporarily suspended.. Valid values are `authorized|released|in_process|completed|cancelled|on_hold`',
    `wafer_start_type` STRING COMMENT 'Classification of the wafer start purpose: production (customer orders), engineering (process development), qualification (product validation), MPW (multi-project wafer), pilot (pre-production), or rework (reprocessing).. Valid values are `production|engineering|qualification|mpw|pilot|rework`',
    `work_center` STRING COMMENT 'SAP work center code representing the initial processing area for this wafer start. Used for capacity planning and cost allocation.. Valid values are `^WC[0-9]{4}$`',
    CONSTRAINT pk_wafer_start PRIMARY KEY(`wafer_start_id`)
) COMMENT 'Transactional record authorizing and recording the initiation of a new wafer lot into the FAB line, capturing wafer start date, authorized quantity, product code, technology node, priority class, customer order reference, and wafer start type (production, engineering, qualification, MPW). SSOT for FAB capacity consumption and WIP entry.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` (
    `lot_hold_id` BIGINT COMMENT 'Unique identifier for the fabrication lot hold event record.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the equipment unit associated with the hold event, if applicable (e.g., tool that triggered the excursion).',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Lot holds are reported and escalated by product (ic_catalog) for customer impact assessment, yield excursion reporting, and regulatory disposition. Direct ic_catalog FK enables product-level hold dash',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Lot holds triggered by design marginality, DRC post-silicon findings, or ECO requirements must be routed to the responsible design project team. Hold disposition and root-cause analysis workflows requ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: In-line inspection failures are a primary trigger for MES lot holds. The fabrication lot hold must reference the inspection lot that caused the hold placement, enabling quality engineers to trace hold',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: When a fab hold is placed on a wafer lot, the corresponding inventory_wafer_lot must be flagged to prevent unauthorized shipment or consumption. Direct FK supports MES-to-ERP hold synchronization, a c',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: NCRs directly trigger fab lot holds in semiconductor MES operations. Quality engineers raise an NCR for a process excursion; the fab system places a lot hold referencing that NCR. ncr_number is a deno',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Customer hold notification workflow: fabrication_lot_hold has customer_notification_required and customer_notification_timestamp flags, indicating a named process of notifying a specific customer cont',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that is placed on hold.',
    `sku_id` BIGINT COMMENT 'Reference to the product (IC design, SoC, ASIC) being fabricated in the lot under hold.',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: fabrication_lot_hold has spc_rule_violation (boolean) but no FK to the triggering SPC chart. Hold management and OCAP workflows require identifying the exact spc_control_chart that triggered the hold ',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Lot holds are frequently triggered by chamber-specific SPC violations or contamination events. Root-cause analysis, CAPA reports, and chamber quarantine decisions require linking the hold to the speci',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Lot holds are frequently triggered by a specific process run result (e.g., out-of-spec measurement, defect excursion). Root cause analysis and hold disposition workflows require tracing the hold back ',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: When unplanned maintenance (tool failure, chamber swap) triggers a lot hold, linking the hold to the maintenance_event is a mandatory CAPA and quality audit traceability requirement. Disposition revie',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Lot holds are frequently triggered by probe run results falling below yield thresholds. Linking the hold to the triggering probe run enables hold disposition traceability and root cause analysis — a s',
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
    `priority_level` STRING COMMENT 'Urgency classification for resolving the hold (critical, high, medium, low), used for escalation and resource allocation.. Valid values are `critical|high|medium|low`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause determined during investigation (e.g., equipment malfunction, operator error, material defect).',
    `spc_rule_violation` STRING COMMENT 'Specific SPC rule that was violated and triggered the hold (e.g., Western Electric Rule 1, 2, 3, 4).',
    `wafer_count` STRING COMMENT 'Number of wafers in the lot at the time the hold was placed.',
    CONSTRAINT pk_lot_hold PRIMARY KEY(`lot_hold_id`)
) COMMENT 'Transactional record capturing all hold events placed on a wafer lot, including hold reason code, hold type (engineering, quality, process excursion, customer), initiating system or operator, hold placement timestamp, release timestamp, and disposition action taken. Enables hold cycle time tracking and excursion management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` (
    `photomask_id` BIGINT COMMENT 'Primary key for photomask',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-owned mask asset tracking: in foundry models, photomasks are frequently customer-supplied or customer-paid assets. Linking mask to owning account is required for asset management, mask storag',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Photomasks are manufactured for specific IC catalog entries at tapeout. Mask lifecycle management (retirement, requalification, PCN) requires direct product association. A mask set engineer would expe',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Photomasks are generated using PDK-specific OPC rule decks, layer definitions, and DRC constraints. Mask qualification, reuse eligibility, and retirement decisions are made at the PDK version level. D',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Photomasks are qualified on specific lithography tools (scanners/steppers) per SEMI mask qualification protocols. Mask-tool compatibility management, qualification audits, and mask retirement decision',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Photomask production release requires a formal tool qualification record confirming the lithography tool meets overlay, CD, and focus specs for that mask. Mask qualification protocols (SEMI standards)',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Photomasks are qualified for and assigned to specific lithography process steps. Mask management systems track which process step each mask is used in for usage tracking, retirement decisions, and pro',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Photomasks are high-value physical assets stored in controlled mask rooms. storage_location has a photomask_storage_capable flag confirming this relationship. Linking enables mask retrieval scheduling',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: A photomask (reticle) is manufactured and qualified for a specific technology node — the mask geometry, critical dimensions, and OPC settings are all node-specific. The existing technology_node STRING',
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
    `usage_retirement_threshold` STRING COMMENT 'Maximum cumulative usage count allowed before mask must be retired from production. Defined per technology node and mask type to ensure yield protection.',
    `warranty_expiration_date` DATE COMMENT 'Date when the vendor warranty for this mask expires. After this date, repair or replacement costs are borne by the FAB.',
    CONSTRAINT pk_photomask PRIMARY KEY(`photomask_id`)
) COMMENT 'Master record for photomasks (reticles) used in EUV and DUV lithography operations, capturing mask set ID, layer name, technology node, mask type (binary, PSM, EUV pellicle), OPC version, MEEF value, mask generation, pellicle status, inspection history summary, usage count, cleaning cycle count, and retirement threshold. SSOT for mask inventory, lithography step qualification, and reticle lifecycle management within the FAB.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` (
    `technology_node_id` BIGINT COMMENT 'Unique identifier for the semiconductor technology node record. Primary key.',
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
    CONSTRAINT pk_technology_node PRIMARY KEY(`technology_node_id`)
) COMMENT 'Reference master for semiconductor technology nodes supported in the FAB, capturing node name (e.g., 5nm, 7nm, 28nm, 65nm), node generation, transistor architecture (planar, FinFET, GAA), minimum feature size, metal layer count, PDK version reference, qualification status, and production readiness date. SSOT for node-level process and product classification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` (
    `fab_yield_record_id` BIGINT COMMENT 'Unique identifier for the FAB yield record. Primary key for this transactional yield capture event.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Yield engineers run daily yield-vs-maintenance correlation analysis to identify PM events, repairs, or chamber swaps that caused yield excursions. This is a named yield engineering workflow (excursion',
    `fab_tool_id` BIGINT COMMENT 'Reference to the inspection or metrology equipment used to capture this yield measurement (e.g., KLA ICOS system). Enables equipment-specific yield correlation.',
    `photomask_id` BIGINT COMMENT 'Reference to the photomask set used for lithography on this wafer. Enables correlation of yield to mask quality and OPC effectiveness.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot to which this yield record belongs. Enables lot-level yield aggregation and genealogy tracking.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Enables Yield Dashboard to aggregate yields per IC catalog product.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Fab yield records are generated at inspection checkpoints co-located with quality inspection lots. Linking fab_yield_record to inspection_lot enables yield-vs-inspection correlation reports critical f',
    `lot_move_id` BIGINT COMMENT 'Foreign key linking to fabrication.lot_move. Business justification: A fab yield record captures wafer-level and lot-level yield outcomes at FAB inline checkpoints — these checkpoints correspond directly to specific lot move events (move-in/move-out at a process step).',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer for which yield is being recorded. Links to the wafer master record in the fabrication domain.',
    `process_flow_id` BIGINT COMMENT 'Reference to the process route or recipe used for this wafer. Links yield outcomes to specific process flows.',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Yield record captures technology node; add FK to technology_node and remove redundant numeric column.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level yield analysis (chamber matching, chamber qualification impact) is a standard yield engineering practice. fab_yield_record links to fab_tool but not to the specific chamber, preventing c',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Correlating in-line fab yield records with wafer probe run results is a core yield learning process — engineers compare in-line defect density to final probe yield for systematic defect root cause ana',
    `bin_1_die_count` STRING COMMENT 'Number of die classified into bin 1 (typically highest quality/performance bin). Part of bin-level yield breakdown.',
    `bin_2_die_count` STRING COMMENT 'Number of die classified into bin 2 (typically second-tier quality/performance bin). Part of bin-level yield breakdown.',
    `bin_3_die_count` STRING COMMENT 'Number of die classified into bin 3 (typically third-tier quality/performance bin). Part of bin-level yield breakdown.',
    `checkpoint_code` STRING COMMENT 'The FAB inline checkpoint at which this yield measurement was captured. Distinguishes FEOL, MOL, BEOL, and pre-probe stages. [ENUM-REF-CANDIDATE: POST_FEOL|POST_MOL|POST_BEOL|PRE_PROBE|POST_CMP|POST_LITHO|POST_ETCH|POST_IMPLANT|INLINE_INSPECTION — 9 candidates stripped; promote to reference product]',
    `comments` STRING COMMENT 'Free-text comments or notes about this yield measurement, including observations, anomalies, or contextual information for root cause analysis.',
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
    `systematic_defect_die_count` STRING COMMENT 'Number of die lost due to systematic defects (OPC errors, MEEF issues, lithography hotspots). Part of yield loss pareto analysis.',
    `yield_excursion_flag` BOOLEAN COMMENT 'Boolean indicator that this yield record represents an excursion event (yield below control limits or specification). Triggers root cause analysis and corrective action.',
    `yield_for_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Yield records are captured at lot level at key FAB checkpoints.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield percentage at this checkpoint (good_die_count / gross_die_count * 100). Primary yield metric for FAB inline performance tracking.',
    `yield_record_for_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Yield records reference the lot measured. Required for lot-level yield tracking and excursion detection.',
    CONSTRAINT pk_fab_yield_record PRIMARY KEY(`fab_yield_record_id`)
) COMMENT 'Transactional record capturing wafer-level and lot-level yield outcomes at key FAB inline checkpoints (post-FEOL, post-MOL, post-BEOL, pre-probe), recording gross die count, good die count, yield percentage, yield loss pareto by category (process, design, random defect, systematic), bin-level yield breakdown, and yield excursion flags. SSOT for FAB inline yield data distinct from final test yield (owned by test domain) and distinct from SPC/metrology analysis (owned by quality domain).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` (
    `process_flow_step_recipe_id` BIGINT COMMENT 'Unique identifier for this process flow step recipe assignment. Primary key for the association entity.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Foreign key linking to the specific process recipe assigned to this flow step',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to the process flow that contains this recipe step',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe-to-flow assignment was first created in the MES system, supporting audit trail and change tracking.',
    `effective_end_date` DATE COMMENT 'Date when this recipe assignment is superseded or retired for this flow step. Null indicates the assignment is currently active. Supports historical tracking of flow changes.',
    `effective_start_date` DATE COMMENT 'Date when this recipe assignment becomes effective for this flow step. Supports change control and versioning of flow definitions as recipes are qualified and updated.',
    `is_mandatory_step` BOOLEAN COMMENT 'Boolean flag indicating whether this recipe step is mandatory for all wafer lots following this flow, or optional based on product variant or engineering requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe-to-flow assignment was last modified, supporting change control and audit requirements.',
    `modified_by` STRING COMMENT 'Name or identifier of the process engineer who last modified this recipe assignment, supporting accountability and change control workflows.',
    `step_description` STRING COMMENT 'Detailed textual description of this specific step within the flow context, including its purpose, critical parameters, and any step-specific notes for process engineers or operators.',
    `step_sequence_number` STRING COMMENT 'Ordered position of this recipe within the process flow. Defines the execution order for FAB routing and WIP scheduling. Critical for SEMI E40 compliance.',
    `step_type` STRING COMMENT 'Classification of the process step within the manufacturing flow: Front End Of Line (FEOL), Middle Of Line (MOL), Back End Of Line (BEOL), metrology checkpoint, or inspection gate.',
    CONSTRAINT pk_process_flow_step_recipe PRIMARY KEY(`process_flow_step_recipe_id`)
) COMMENT 'This association product represents the assignment of a specific fabrication process recipe to a step within a fabrication process flow. It captures the ordered sequence of recipes that define the complete manufacturing route for a semiconductor product. Each record links one recipe to one flow step with step-specific attributes including sequence order, step type classification, mandatory execution flag, and effective date range for change control and versioning.. Existence Justification: In semiconductor FAB operations, process flows are constructed by assigning specific recipes to ordered steps within the manufacturing route. A single recipe (e.g., a CVD oxide deposition recipe) is reused across multiple flows (5nm logic, 7nm SRAM, 28nm analog) to reduce qualification costs and ensure process consistency. Conversely, a single flow contains dozens to hundreds of recipe steps spanning FEOL, MOL, and BEOL phases. This is a core MES concept actively managed by process engineers through route definition and change control workflows.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_parent_lot_fabrication_wafer_lot_id` FOREIGN KEY (`parent_lot_fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_lot_move_id` FOREIGN KEY (`lot_move_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`lot_move`(`lot_move_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ADD CONSTRAINT `fk_fabrication_process_flow_step_recipe_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ADD CONSTRAINT `fk_fabrication_process_flow_step_recipe_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`fabrication` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`fabrication` SET TAGS ('dbx_domain' = 'fabrication');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_subdomain' = 'wafer_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Active Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Current Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `parent_lot_fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` SET TAGS ('dbx_subdomain' = 'wafer_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `chamber_configuration` SET TAGS ('dbx_business_glossary_term' = 'Chamber Configuration');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Control Reference');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_operation_type` SET TAGS ('dbx_business_glossary_term' = 'Process Operation Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature (Celsius)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `beol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Back End Of Line (BEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `cool_optimization_mode` SET TAGS ('dbx_business_glossary_term' = 'Cool Optimization Mode');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `coolant_type` SET TAGS ('dbx_business_glossary_term' = 'Coolant Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `cooling_method` SET TAGS ('dbx_business_glossary_term' = 'Cooling Method');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `cooling_optimization_mode` SET TAGS ('dbx_business_glossary_term' = 'Cooling Optimization Mode');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `process_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `estimated_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `fab_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `feol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Front End Of Line (FEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `flow_revision` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Revision');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|frozen|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_value_regex' = 'standard|mpw|engineering|qualification|rnd');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `is_customer_specific` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Specific Flow Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_value_regex' = 'euv|duv|immersion|dry');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `mol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Middle Of Line (MOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|requalification_required');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `requires_nre` SET TAGS ('dbx_business_glossary_term' = 'Requires Non-Recurring Engineering (NRE) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `total_process_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Process Steps Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `waste_elimination_strategy` SET TAGS ('dbx_business_glossary_term' = 'Waste Elimination Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `waste_elimination_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Waste Elimination Target Pct');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` SET TAGS ('dbx_subdomain' = 'wafer_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Interrupting Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Operation Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `tracks_lot` SET TAGS ('dbx_business_glossary_term' = 'Tracks Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` SET TAGS ('dbx_subdomain' = 'wafer_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Creates Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^WS[0-9]{10}$');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `substrate_type` SET TAGS ('dbx_value_regex' = 'silicon|soi|gaas|gan|sic');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_date` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_status` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_status` SET TAGS ('dbx_value_regex' = 'authorized|released|in_process|completed|cancelled|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_type` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_type` SET TAGS ('dbx_value_regex' = 'production|engineering|qualification|mpw|pilot|rework');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `work_center` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `work_center` SET TAGS ('dbx_value_regex' = '^WC[0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` SET TAGS ('dbx_subdomain' = 'wafer_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `defect_density_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Threshold Exceeded Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'resume|rework|scrap|quarantine|return_to_customer|engineering_review');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_cycle_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Cycle Time (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_placement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|cancelled|expired');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `initiating_system` SET TAGS ('dbx_business_glossary_term' = 'Initiating System');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `mes_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `spc_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `usage_retirement_threshold` SET TAGS ('dbx_business_glossary_term' = 'Usage Retirement Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Complexity Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `dfm_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Enabled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `dft_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Enabled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `iatf16949_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'International Automotive Task Force (IATF) 16949 Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `iso9001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_value_regex' = 'duv|euv|immersion|dry');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `minimum_feature_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Feature Size (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `node_generation` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Generation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `nre_cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost Estimate (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `nre_cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `power_performance_area_rating` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area (PPA) Rating');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `process_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `production_readiness_date` SET TAGS ('dbx_business_glossary_term' = 'Production Readiness Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'development|qualification|qualified|production|mature|eol');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `supported_application_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Application Types');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet|nanowire');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Yield Record Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Correlated Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_1_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 1 Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_2_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 2 Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_3_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 3 Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `checkpoint_code` SET TAGS ('dbx_business_glossary_term' = 'Yield Checkpoint Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Comments');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `systematic_defect_die_count` SET TAGS ('dbx_business_glossary_term' = 'Systematic Defect Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Yield Excursion Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_for_lot` SET TAGS ('dbx_business_glossary_term' = 'Yield For Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_record_for_lot` SET TAGS ('dbx_business_glossary_term' = 'Yield Record For Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` SET TAGS ('dbx_association_edges' = 'fabrication.fabrication_process_recipe,fabrication.fabrication_process_flow');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `process_flow_step_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Step Recipe Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Step Recipe - Fabrication Process Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Step Recipe - Fabrication Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Step Assignment Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Step Assignment Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `is_mandatory_step` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Step Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `step_description` SET TAGS ('dbx_business_glossary_term' = 'Step Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `step_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe` ALTER COLUMN `step_type` SET TAGS ('dbx_business_glossary_term' = 'Step Type Classification');
