-- Schema for Domain: fabrication | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-07-10 14:04:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`fabrication` COMMENT 'Core wafer fabrication and processing domain governing all FAB operations including FEOL, MOL, and BEOL process steps. Owns wafer lot tracking, WIP management, process recipe execution, and fab line scheduling across CVD, PVD, ALD, CMP, ion implantation, and EUV/DUV lithography operations. Authoritative source for wafer genealogy and lot disposition via MES integration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` (
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the wafer lot tracked through the FAB from wafer start to lot disposition. Primary key for all WIP lot tracking across FEOL, MOL, and BEOL operations.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Needed to associate each wafer lot with the winning customer design contract for production planning and revenue attribution.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Wafer lot references a technology node; replace string column with FK to technology_node for normalization.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: MES lot routing requires a wafer lot to reference the engineering process flow (process.process_flow) for yield-by-flow analysis, qualification status checks, and WIP reporting. Distinct from fabricat',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Required for Production Planning Report linking each wafer lot to the specific IC catalog item being manufactured.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Required for lot‑level cost and yield reporting per design project, enabling profitability analysis and project KPI dashboards.',
    `parent_lot_fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the parent lot from which this lot was split or derived. Null for original lots. Enables wafer genealogy tracking and traceability.',
    `process_flow_id` BIGINT COMMENT 'Unique identifier for the process route (recipe sequence) assigned to this lot. Defines the complete sequence of operations from wafer start to completion.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Wafer lots are produced for specific orderable SKUs to fulfill customer orders. Customer commit tracking, lot prioritization by SKU demand, and production-to-order reconciliation reports all require t',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: A wafer lot is released to fab based on a specific tapeout approval. The tapeout defines the GDS revision, mask set, and process node for the lot. Lot release authorization, NRE billing, and customer ',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the lot completed all FAB processing operations and was dispositioned. Null for lots still in WIP.',
    `current_operation_name` STRING COMMENT 'Descriptive name of the current process operation (e.g., CVD_OXIDE_DEP, EUV_LITHO, CMP_POLISH). Provides human-readable context for lot location.',
    `current_operation_number` STRING COMMENT 'Sequential operation step number in the process route where the lot is currently located. Used for tracking lot position in the manufacturing flow.. Valid values are `^[0-9]{4,6}$`',
    `current_process_area` STRING COMMENT 'High-level FAB area classification where the lot is currently located: FEOL (front-end-of-line transistor formation), MOL (middle-of-line contacts), BEOL (back-end-of-line interconnect), metrology (inspection), or test (electrical probe).. Valid values are `feol|mol|beol|metrology|test`',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Total elapsed time in days from wafer start to lot completion. Key performance metric for manufacturing efficiency and customer responsiveness.',
    `due_date` DATE COMMENT 'Target completion date for the lot to meet customer delivery commitments. Used for scheduling and on-time-delivery tracking.',
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
    `fab_facility_id` BIGINT COMMENT 'Reference to the fabrication facility where this wafer is being processed. Supports multi-site operations and capacity planning.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the parent wafer lot that this wafer belongs to. Wafers are processed in lots through the FAB (Fabrication Facility).',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Needed for Yield Analysis linking each wafer to its IC product for defect tracking.',
    `process_flow_id` BIGINT COMMENT 'Reference to the process route or recipe that defines the sequence of fabrication steps for this wafer. Routes vary by product technology node and design.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Each wafer is fabricated from a specific substrate blank (silicon, SOI, SiC) tracked in material_master. This link enables substrate lot traceability, incoming inspection correlation, and yield-by-sub',
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
    `thickness_um` DECIMAL(18,2) COMMENT 'Thickness of the wafer in micrometers. Typical range is 500-800 micrometers depending on diameter and application. Critical for mechanical stability and process control.',
    `wafer_number` STRING COMMENT 'Business identifier for the wafer within its lot. Typically a sequential number or alphanumeric code assigned during lot creation.. Valid values are `^[A-Z0-9]{1,20}$`',
    CONSTRAINT pk_wafer PRIMARY KEY(`wafer_id`)
) COMMENT 'Individual silicon wafer entity within a lot, tracking wafer number, substrate type, diameter, orientation, resistivity, epitaxial layer specs, and current disposition. Enables per-wafer genealogy and yield tracking across all FAB process steps. Sourced from Camstar MES wafer tracking module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` (
    `process_recipe_id` BIGINT COMMENT 'Unique identifier for the fabrication process recipe. Primary key for this entity.',
    `eda_tool_id` BIGINT COMMENT 'Foreign key linking to design.eda_tool. Business justification: Process recipes are developed and validated using specific EDA tools for process simulation and DFM rule checking. Recipe qualification reports must reference the EDA tool version used. A fab process ',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Process recipes are qualified and maintained per product family in semiconductor fabs. Recipe qualification reports, requalification scheduling, and process control plans are all organized by product ',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Recipe qualification and change‑control require explicit reference to the PDK version the recipe supports, ensuring process compatibility.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Process recipes are qualified against specific supplier-provided chemicals, gases, or deposition targets. When a supplier changes, recipes must be revalidated — a core fab change-control and supplier ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: A process recipe specifies the exact material (gas, chemical, deposition target) it operates on, tracked in material_master. This link enables process change management, material substitution impact a',
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
    `target_thickness_nm` DECIMAL(18,2) COMMENT 'Target thickness in nanometers for deposition or remaining thickness after etch/CMP operations.',
    `uniformity_target_percent` DECIMAL(18,2) COMMENT 'Target uniformity percentage for thickness, composition, or other critical parameters across the wafer surface.',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target yield percentage for wafers processed using this recipe, used for performance monitoring and continuous improvement.',
    CONSTRAINT pk_process_recipe PRIMARY KEY(`process_recipe_id`)
) COMMENT 'Master record for a validated process recipe defining the exact sequence of process parameters, tool settings, gas flows, temperatures, pressures, and timing for a specific FAB operation (CVD, PVD, ALD, CMP, implant, etch, lithography). Includes recipe version history, approval status, change control reference, qualification status, and effective date range. Versioning managed within this entity via version number and effective dates. Sourced from Applied Materials SmartFactory MES recipe management and integrated with engineering change order workflow.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` (
    `process_flow_id` BIGINT COMMENT 'Unique identifier for the process flow. Primary key for the process flow entity.',
    `eda_tool_id` BIGINT COMMENT 'Reference to the design rule set (DRC/LVS rules) that physical layouts must comply with for this process flow.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: fabrication_process_flow has a denormalized fab_facility_code: STRING column that references the fab facility where this process flow is qualified and executed. Normalizing this to a FK (fab_facility_',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Process flows are developed and qualified for specific product families during NPI. Process engineers and NPI program managers track which flows support which product families for qualification status',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: The fabrication process flow (MES route) is derived from and must be traceable to the engineering process flow (process.process_flow) for process change management, qualification tracking, and ensurin',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) that provides device models, design rules, and technology files for this process flow.',
    `approval_date` DATE COMMENT 'Date when this process flow received formal approval for use in FAB operations.',
    `approved_by` STRING COMMENT 'Name or identifier of the process engineer or manager who approved this process flow for production use.',
    `beol_step_count` STRING COMMENT 'Number of process steps in the Back End Of Line (BEOL) phase covering metal interconnect layers and passivation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this process flow is no longer valid for new wafer lot starts. Nullable for flows with indefinite validity.',
    `effective_start_date` DATE COMMENT 'Date when this process flow becomes valid and available for wafer lot routing and WIP scheduling.',
    `environmental_classification` STRING COMMENT 'Environmental and chemical safety classification for materials and processes used in this flow (e.g., RoHS compliant, REACH registered).',
    `estimated_cycle_time_days` DECIMAL(18,2) COMMENT 'Estimated total manufacturing cycle time in days for a wafer lot to complete this entire process flow under normal conditions.',
    `export_control_classification` STRING COMMENT 'Export control classification number (ECCN) or ITAR designation governing international transfer and use of this process technology.',
    `fabrication_process_flow_description` STRING COMMENT 'Detailed textual description of the process flow including its purpose, key characteristics, and intended applications.',
    `feol_step_count` STRING COMMENT 'Number of process steps in the Front End Of Line (FEOL) phase covering transistor formation and active device fabrication.',
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
    CONSTRAINT pk_process_flow PRIMARY KEY(`process_flow_id`)
) COMMENT 'Ordered sequence of process steps defining the complete manufacturing route for a product on a given technology node. Captures flow revision, node generation (e.g., 5nm, 7nm, 28nm), flow type (standard, MPW, engineering), effective dates, and approval status. SSOT for FAB routing and WIP scheduling. Aligned with SEMI E40 process management standard for flow-level routing definition.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` (
    `lot_move_id` BIGINT COMMENT 'Unique identifier for the lot move transaction. Primary key for this WIP (Work in Process) lot movement event through a FAB (Fabrication Facility) process step.',
    `equipment_run_id` BIGINT COMMENT 'FK to fabrication.equipment_run.equipment_run_id — Each lot move through a process step is executed via an equipment run. Links WIP tracking to process execution for traceability.',
    `fab_tool_id` BIGINT COMMENT 'Identifier for the FAB (Fabrication Facility) equipment or tool used to process this lot move (e.g., ATE (Automatic Test Equipment), lithography stepper, etcher, deposition chamber). Links to equipment master data.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Every lot move transaction must reference the lot being moved. Core MES transaction integrity — cannot track WIP without this FK.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier for the IC (Integrated Circuit) product or device being manufactured in this lot. Links to product master data (e.g., SoC (System on Chip), ASIC (Application-Specific Integrated Circuit), FPGA (Field-Programmable Gate Array)).',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Lot move corresponds to a specific process step; linking supports operation tracking and step‑level performance reporting.',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: A lot_move records the execution of a specific FAB process step, which is governed by a validated fabrication_process_recipe. This FK enables full traceability from WIP movement to the exact recipe pa',
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
    `technology_node` STRING COMMENT 'Process technology node for this lot (e.g., 5nm, 7nm, 14nm, 28nm, 180nm). Defines the minimum feature size and process generation.. Valid values are `^[0-9]{1,3}nm$|^[0-9]{1,3}um$`',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafers in this lot in millimeters (e.g., 200mm, 300mm, 450mm). Standard wafer size for the FAB (Fabrication Facility).',
    CONSTRAINT pk_lot_move PRIMARY KEY(`lot_move_id`)
) COMMENT 'Transactional record of each WIP lot movement through a process step in the FAB, capturing move-in timestamp, move-out timestamp, operator ID, equipment used, recipe executed, actual process parameters, pass/fail disposition, and quantity in/out. Core MES transaction sourced from Camstar MES and SmartFactory MES. Enables cycle time analysis and WIP genealogy.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` (
    `wafer_start_id` BIGINT COMMENT 'Unique identifier for the wafer start transaction. Primary key for the wafer start record.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: A booking event formally authorizes a wafer start release in semiconductor foundry operations. Linking wafer_start to booking enables delivery commitment tracking, revenue recognition scheduling, and ',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Wafer starts under long-term supply agreements require contract traceability for pricing verification, volume commitment tracking, and compliance audits. Fab operations teams verify contract terms (mi',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Every wafer start is authorized by a specific customer design win in semiconductor fabs. This link drives production authorization traceability, NRE fulfillment tracking, and customer delivery commitm',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: wafer_start has a denormalized fab_facility_code: STRING column identifying the fab facility where the wafer start is initiated. Normalizing this to a FK (fab_facility_id → fab_facility.fab_facility_i',
    `photomask_id` BIGINT COMMENT 'Identifier for the photomask set (reticle set) used for lithography steps in this wafer lot. Links to the physical layout and GDS data.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Wafer start transaction creates a new lot. Required for lot lifecycle tracking from inception.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Wafer start authorization in semiconductor NPI and production release requires verifying the engineering process flow qualification status (process.process_flow). This is a standard production release',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Supports Wafer Start Scheduling report tying start orders to the IC catalog entry.',
    `ic_design_project_id` BIGINT COMMENT 'Identifier for the MPW shuttle run if this wafer start combines multiple customer designs on shared wafers. Null for dedicated production lots.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Wafer start authorization in semiconductor fabs is issued at order line granularity — each order line specifies quantity, delivery date, and product configuration. Linking wafer_start to order_line en',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Needed for Wafer Start Material Certification process, tying each wafer start to the supplied material master record for quality and compliance tracking.',
    `nre_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_nre_agreement. Business justification: NRE wafer starts (wafer_start_type=NRE) are directly funded by NRE agreements. A proper FK replaces the denormalized nre_project_code string, enabling milestone billing triggers and NRE cost tracking ',
    `process_flow_id` BIGINT COMMENT 'Identifier for the manufacturing process flow (recipe sequence) that this wafer lot will follow. Defines the FEOL, MOL, and BEOL steps.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Wafer start authorization requires verification that the process qualification is approved before releasing a lot to production. This is a standard NPI and production release gate in semiconductor fab',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Required for Wafer Start Planning report linking each wafer start to its originating sales order, enabling traceability from order to production schedule.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Wafer starts are authorized to fulfill specific SKU orders (speed grade, temperature range, voltage variant). Production planning, customer commit date management, and order-to-lot traceability all re',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Wafer starts are authorized against a specific tapeout approval — the tapeout defines the GDS revision, mask set, and process node for the production run. Wafer start authorization, NRE project tracki',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer start was formally authorized in the MES system. Precedes the actual release to the FAB line.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this wafer start record was first created in the MES database. Used for audit trail and data lineage.',
    `crystal_orientation` STRING COMMENT 'Crystallographic orientation of the silicon wafer, expressed in Miller indices (e.g., <100>, <111>). Affects electrical properties and process compatibility.. Valid values are `^<[0-9]{3}>$`',
    `doping_type` STRING COMMENT 'Electrical doping type of the starting wafer substrate: p-type (boron-doped), n-type (phosphorus or arsenic-doped), or intrinsic (undoped).. Valid values are `p_type|n_type|intrinsic`',
    `ear_classification` STRING COMMENT 'Export Control Classification Number (ECCN) under EAR for this product. Format: 5-character code (e.g., 3A001). Null if not export-controlled.. Valid values are `^[0-9][A-Z][0-9]{3}$`',
    `estimated_cycle_time_days` DECIMAL(18,2) COMMENT 'Planned total cycle time from wafer start to completion, measured in days. Based on standard process flow duration and current FAB loading.',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason for placing this wafer start on hold, if applicable. Examples: quality issue, material shortage, engineering review, customer request.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `itar_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this wafer lot contains ITAR-controlled technology requiring export compliance controls. True if ITAR applies; False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this wafer start record was last updated. Tracks the most recent change to any field in the record.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier assigned to the wafer batch at start. This is the primary tracking identifier throughout FAB operations.. Valid values are `^[A-Z0-9]{8,16}$`',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` (
    `lot_hold_id` BIGINT COMMENT 'Unique identifier for the fabrication lot hold event record.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom the lot is being fabricated, relevant for customer-initiated holds or customer notification.',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Lot holds may trigger PCN (Process Change Notification) obligations and customer notification clauses defined in supply contracts. Compliance teams need this link to identify which contracts require n',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Lot holds must trigger customer notification at the design-win level for contractual delivery commitment tracking and customer-facing hold impact reporting. The existing account_id link is insufficien',
    `excursion_id` BIGINT COMMENT 'Foreign key linking to process.excursion. Business justification: Excursion containment management requires linking a lot hold to the triggering process excursion. Semiconductor fabs track this for financial impact reporting, customer notification compliance, and ex',
    `fab_facility_id` BIGINT COMMENT 'Reference to the fabrication facility where the hold event occurred.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the equipment unit associated with the hold event, if applicable (e.g., tool that triggered the excursion).',
    `fab_yield_record_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_yield_record. Business justification: A fabrication_lot_hold can be triggered by a yield excursion detected in a fab_yield_record (e.g., yield_excursion_flag=true, defect_density_threshold_exceeded). Linking fabrication_lot_hold to the tr',
    `lot_move_id` BIGINT COMMENT 'Foreign key linking to fabrication.lot_move. Business justification: A fabrication_lot_hold is frequently triggered by a specific lot_move event — for example, an SPC rule violation detected during a process step move-out, or a defect count threshold exceeded at a spec',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Hold-to-maintenance root cause traceability: lot holds triggered by equipment failures must reference the causal maintenance event for NCR resolution, CAPA reporting, and hold release authorization. S',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that is placed on hold.',
    `process_recipe_id` BIGINT COMMENT 'Reference to the specific process step (FEOL, MOL, BEOL operation) where the lot was held.',
    `sku_id` BIGINT COMMENT 'Reference to the product (IC design, SoC, ASIC) being fabricated in the lot under hold.',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: fabrication_lot_hold has spc_rule_violation attribute indicating SPC-triggered holds. Linking to the specific spc_control_chart that triggered the hold is required for OCAP (Out-of-Control Action Plan',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Lot holds are frequently triggered by incoming material quality issues (out-of-spec chemical batch, contaminated slurry). Linking the hold to the suspect material_master record drives Supplier Correct',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber contamination hold tracking: when a specific chamber has a contamination or excursion event, all lots processed in that chamber are placed on hold. MES hold management requires chamber-level t',
    `tool_downtime_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_downtime. Business justification: Downtime-triggered lot hold traceability: when a tool goes down mid-run, the MES automatically places in-process lots on hold. Linking fabrication_lot_hold to the triggering tool_downtime event enable',
    `yield_loss_event_id` BIGINT COMMENT 'Foreign key linking to process.yield_loss_event. Business justification: Lot disposition and CAPA tracking requires tracing which yield loss event triggered a specific lot hold. Semiconductor fabs require this link for containment action documentation, customer notificatio',
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
    CONSTRAINT pk_lot_hold PRIMARY KEY(`lot_hold_id`)
) COMMENT 'Transactional record capturing all hold events placed on a wafer lot, including hold reason code, hold type (engineering, quality, process excursion, customer), initiating system or operator, hold placement timestamp, release timestamp, and disposition action taken. Enables hold cycle time tracking and excursion management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` (
    `equipment_run_id` BIGINT COMMENT 'Unique identifier for the equipment run. Primary key for this transactional record of a specific tool chamber run executed on a wafer lot or wafer set.',
    `tool_downtime_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_downtime. Business justification: Aborted run root cause analysis: equipment_run has an abort_reason attribute indicating runs terminated by tool failure. Linking to the tool_downtime event that caused the abort enables yield loss att',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fabrication equipment tool that executed this run. Links to the equipment master record.',
    `photomask_id` BIGINT COMMENT 'Identifier of the photomask reticle used in lithography exposure. Links to the photomask asset inventory. Applicable only when process_type is lithography.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot processed in this equipment run. Links to the wafer lot master record for WIP tracking and genealogy.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Supports Equipment Run Material Consumption Log, associating chemicals/materials used in each run with their master record for SPC and safety compliance.',
    `process_recipe_id` BIGINT COMMENT 'FK to fabrication.fabrication_process_recipe.fabrication_process_recipe_id — Equipment runs execute a specific recipe version. Links actual processing to recipe management.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Equipment run must reference the exact process recipe applied; essential for audit, yield analysis, and SPC control.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Equipment run actual process parameters (temperature, pressure, deposition rate) must be tied to the specific process step for SPC control and process capability analysis. Semiconductor process engine',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific process chamber within the equipment tool where this run was executed. Multi-chamber tools may have multiple concurrent runs.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Qualification-gated run authorization: before processing a production lot, the MES verifies the tools qualification status for the given recipe and process node. Linking equipment_run to the tool_qua',
    `abort_reason` STRING COMMENT 'Reason code or description if the run was aborted or failed. Used for root cause analysis and yield improvement.',
    `actual_pressure_torr` DECIMAL(18,2) COMMENT 'Actual measured chamber pressure in Torr during the run. Used for process control and deviation analysis.',
    `actual_temperature_celsius` DECIMAL(18,2) COMMENT 'Actual measured process temperature in degrees Celsius during the run. Used for process control and deviation analysis.',
    `alarm_count` STRING COMMENT 'Number of equipment alarms triggered during this run. Indicator of process stability and equipment health.',
    `cmp_removal_rate_angstrom_per_min` DECIMAL(18,2) COMMENT 'Material removal rate during CMP in Angstroms per minute. Critical parameter for planarization control and endpoint detection.',
    `cmp_slurry_type` STRING COMMENT 'Type of slurry used in CMP process (e.g., oxide slurry, tungsten slurry, copper slurry). Applicable only when process_type is CMP.',
    `cmp_wiwnu_percent` DECIMAL(18,2) COMMENT 'Within-wafer non-uniformity percentage for CMP process. Measures variation in material removal across the wafer surface. Lower values indicate better planarization quality.',
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
    CONSTRAINT pk_equipment_run PRIMARY KEY(`equipment_run_id`)
) COMMENT 'Transactional record of a specific equipment tool run (chamber run, process run) executed on a wafer lot or wafer set. Captures tool ID, chamber ID, run start/end timestamps, recipe name and version, process type discriminator (CVD, PVD, ALD, CMP, implant, etch, lithography, anneal, clean, wet clean), actual vs. target parameter deviations, run status, and wafers processed. Process-type-specific parameters stored as structured attributes: implant (species, dose, energy, tilt, twist, beam current), deposition (film material, thickness, rate, precursor flows, uniformity), CMP (slurry type, removal rate, WIWNU, endpoint detection), lithography (reticle ID, exposure dose, focus offset, overlay, CD measurement). Unified model aligned with SEMI E10/E142 equipment event patterns. SSOT for all FAB process execution records.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` (
    `photomask_id` BIGINT COMMENT 'Primary key for photomask',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Photomasks are procured and owned in the context of a customer design win — NRE cost allocation, mask ownership rights, and customer-authorized mask change control all require this link. A semiconduct',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Photomasks are procured, qualified, and retired per product family. Mask lifecycle management (retirement thresholds, requalification triggers, EOL planning) is organized by product family. Mask inven',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Photomasks are procured from mask shops via purchase orders. Linking mask to its PO enables procurement cost tracking, mask lifecycle cost accounting, and audit traceability for capital tooling. purc',
    `nre_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_nre_agreement. Business justification: Photomask sets are procured and funded through NRE agreements in semiconductor foundry operations. This link enables NRE milestone billing upon mask delivery, IP ownership tracking per contract clause',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Photomasks are manufactured to PDK-specific OPC rules, layer stack definitions, and lithography specifications. Mask qualification and OPC verification are PDK-version-specific. A mask engineer requir',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Each photomask layer is generated from a specific physical layout GDS version. Mask OPC verification, defect inspection, and CD uniformity checks all trace to the physical layout version. A lithograph',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: A photomask (reticle) is designed and qualified for use in a specific process flows lithography layer. The fabrication_process_flow defines the technology node, lithography technology, and metal laye',
    `process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: A photomask is qualified against a specific lithography process recipe that defines the exposure parameters (dose, focus, wavelength) for which the mask was designed. The fabrication_process_recipe ca',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Mask management requires knowing which lithography process step uses each photomask for maintenance scheduling, usage count tracking against retirement thresholds, and yield correlation by mask-step c',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Ensures Photomask Supplier Traceability required by mask qualification and export control audits linking each mask to its supplier record.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Photomasks are physically manufactured from a specific tapeout GDS submission. Mask procurement, cost allocation (mask_cost_usd), revision management, and NRE billing all require tracing each mask set',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` (
    `fab_yield_record_id` BIGINT COMMENT 'Unique identifier for the FAB yield record. Primary key for this transactional yield capture event.',
    `excursion_id` BIGINT COMMENT 'Foreign key linking to process.excursion. Business justification: Excursion financial impact quantification requires linking yield records to the excursion that caused yield loss. Semiconductor operations teams use this for estimated_financial_impact_usd calculation',
    `fab_facility_id` BIGINT COMMENT 'Reference to the FAB facility where this yield measurement was captured. Enables multi-site yield comparison and benchmarking.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the inspection or metrology equipment used to capture this yield measurement (e.g., KLA ICOS system). Enables equipment-specific yield correlation.',
    `photomask_id` BIGINT COMMENT 'Reference to the photomask set used for lithography on this wafer. Enables correlation of yield to mask quality and OPC effectiveness.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot to which this yield record belongs. Enables lot-level yield aggregation and genealogy tracking.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Enables Yield Dashboard to aggregate yields per IC catalog product.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Yield analysis reports are aggregated per design project; direct FK enables automated project‑level yield dashboards and root‑cause tracking.',
    `lot_move_id` BIGINT COMMENT 'Foreign key linking to fabrication.lot_move. Business justification: A fab_yield_record captures yield outcomes at inline FAB checkpoints. Each yield measurement corresponds to a specific lot_move event (the movement of the lot through that checkpoint step). Linking fa',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Yield records are correlated against physical layout versions to identify layout-dependent yield loss (metal density, routing congestion causing random defects). DFM yield analysis and systematic defe',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer for which yield is being recorded. Links to the wafer master record in the fabrication domain.',
    `process_flow_id` BIGINT COMMENT 'Reference to the process route or recipe used for this wafer. Links yield outcomes to specific process flows.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Yield analysis is performed per tapeout revision to assess whether design changes improved or degraded yield. Tapeout-to-yield correlation reports are a standard semiconductor yield engineering delive',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level yield analysis and SPC: yield engineers must correlate yield excursions to specific chambers (not just tools) for chamber matching and chamber qualification decisions. fab_yield_record a',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Fab yield records are reconciled against wafer probe run results to attribute yield loss to fab-induced defects vs. test-induced failures. This yield loss attribution analysis is a standard semiconduc',
    `yield_loss_event_id` BIGINT COMMENT 'Foreign key linking to process.yield_loss_event. Business justification: CAPA and yield loss attribution reporting requires linking a yield record to the specific yield loss event explaining the yield drop. Semiconductor yield engineers use this for systematic defect analy',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_parent_lot_fabrication_wafer_lot_id` FOREIGN KEY (`parent_lot_fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_equipment_run_id` FOREIGN KEY (`equipment_run_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`equipment_run`(`equipment_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_process_recipe_id` FOREIGN KEY (`process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_recipe`(`process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_fab_yield_record_id` FOREIGN KEY (`fab_yield_record_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record`(`fab_yield_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_lot_move_id` FOREIGN KEY (`lot_move_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`lot_move`(`lot_move_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_process_recipe_id` FOREIGN KEY (`process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_recipe`(`process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_process_recipe_id` FOREIGN KEY (`process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_recipe`(`process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_process_recipe_id` FOREIGN KEY (`process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_recipe`(`process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_lot_move_id` FOREIGN KEY (`lot_move_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`lot_move`(`lot_move_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ADD CONSTRAINT `fk_fabrication_fab_facility_parent_fab_facility_id` FOREIGN KEY (`parent_fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`fabrication` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`fabrication` SET TAGS ('dbx_domain' = 'fabrication');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `parent_lot_fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_name` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_number` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_process_area` SET TAGS ('dbx_business_glossary_term' = 'Current Process Area');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_process_area` SET TAGS ('dbx_value_regex' = 'feol|mol|beol|metrology|test');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `product_name` SET TAGS ('dbx_pii_detected' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'FAB (Fabrication Facility) Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Material Master Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Wafer Thickness (Micrometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `wafer_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ALTER COLUMN `wafer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `eda_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `chamber_configuration` SET TAGS ('dbx_business_glossary_term' = 'Chamber Configuration');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Control Reference');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `defect_density_target_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Target (Per Square Centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `fmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Reference');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `gas_flow_parameters` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Parameters');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `power_settings_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Settings (Watts)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `process_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Duration (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `process_layer_type` SET TAGS ('dbx_business_glossary_term' = 'Process Layer Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `process_layer_type` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `process_operation_type` SET TAGS ('dbx_business_glossary_term' = 'Process Operation Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `process_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure (Torr)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `process_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_qualified|in_qualification|qualified|requalification_required');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `recipe_description` SET TAGS ('dbx_business_glossary_term' = 'Recipe Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Status');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|suspended|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'standard|hazardous_material|high_temperature|high_pressure|toxic_gas');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `spc_control_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Plan Reference');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `step_sequence_definition` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Definition');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `target_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Thickness (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `uniformity_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Uniformity Target (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `eda_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `beol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Back End Of Line (BEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `estimated_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `fabrication_process_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `feol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Front End Of Line (FEOL) Step Count');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Generation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `total_process_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Process Steps Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tracks Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Operation Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `technology_node` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}nm$|^[0-9]{1,3}um$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Creates Lot');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Nre Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_business_glossary_term' = 'Crystal Orientation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_value_regex' = '^<[0-9]{3}>$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `doping_type` SET TAGS ('dbx_business_glossary_term' = 'Doping Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `doping_type` SET TAGS ('dbx_value_regex' = 'p_type|n_type|intrinsic');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `ear_classification` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `estimated_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `excursion_id` SET TAGS ('dbx_business_glossary_term' = 'Excursion Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `fab_yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Yield Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Suspect Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `tool_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Tool Downtime Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `yield_loss_event_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Event Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `spc_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violation');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `tool_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Aborting Tool Downtime Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Lithography Reticle ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `abort_reason` SET TAGS ('dbx_business_glossary_term' = 'Abort Reason');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `actual_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure Torr');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `actual_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `alarm_count` SET TAGS ('dbx_business_glossary_term' = 'Alarm Count');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_removal_rate_angstrom_per_min` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Removal Rate Angstrom Per Minute');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_slurry_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Slurry Type');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_wiwnu_percent` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Within-Wafer Non-Uniformity (WIWNU) Percent');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Nre Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ALTER COLUMN `layer_name` SET TAGS ('dbx_pii_detected' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Yield Record Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `excursion_id` SET TAGS ('dbx_business_glossary_term' = 'Excursion Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_loss_event_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Event Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` SET TAGS ('dbx_subdomain' = 'equipment_operations');
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
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_pii_detected' = 'true');
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
