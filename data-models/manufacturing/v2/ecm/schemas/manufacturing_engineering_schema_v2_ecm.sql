-- Schema for Domain: engineering | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`engineering` COMMENT 'Product design and engineering lifecycle domain covering CAD/CAM models, BOMs, ECOs, ECNs, DFM analysis, DFMEA, PFMEA, and PLM data managed in Siemens Teamcenter. Serves as the SSOT for product structure, revision history, engineering change governance, technical specifications, drawings, and prototypes for all manufactured automation systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`component` (
    `component_id` BIGINT COMMENT 'Unique identifier for the component. Primary key for the component master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Component cost tracking for budgeting and cost allocation per cost center; required for cost of goods sold reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Component Design Responsibility report, linking each component to the engineer accountable for its design.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Component expense posting to a GL account enables accurate financial statements and inventory valuation.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Inventory Management tracks stock of each engineered component via Material Master for procurement and WIP planning.',
    `substitute_component_id` BIGINT COMMENT 'Identifier of an approved substitute component that can be used interchangeably. Supports supply chain flexibility and risk mitigation.',
    `supplier_id` BIGINT COMMENT 'Identifier of the preferred supplier for purchased components. Links to supplier master for procurement planning.',
    `abc_classification` STRING COMMENT 'Inventory classification by value contribution. A items are high-value requiring tight control, C items are low-value with relaxed management.. Valid values are `A|B|C`',
    `cad_model_reference` STRING COMMENT 'File path or URI reference to the authoritative CAD model in PLM. Links to 3D geometry for design, simulation, and manufacturing.',
    `ce_marking_flag` BOOLEAN COMMENT 'Indicates CE marking compliance for European market access. Confirms conformity with EU health, safety, and environmental protection standards.',
    `commodity_code` STRING COMMENT 'Procurement commodity classification code. Groups components by material family for sourcing strategy and supplier alignment.',
    `component_number` STRING COMMENT 'Business identifier for the component. Human-readable unique code used across engineering, procurement, and manufacturing.',
    `component_type` STRING COMMENT 'Classification of the component by procurement and manufacturing strategy. Determines BOM explosion logic and sourcing approach.. Valid values are `raw_material|purchased_part|manufactured_part|sub_assembly|assembly|phantom`',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for standard cost. Enables multi-currency cost management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the component record was first created in PLM. Audit trail for lifecycle tracking.',
    `component_description` STRING COMMENT 'Detailed technical description of the component including functional characteristics, application context, and distinguishing features.',
    `dfm_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of component manufacturability. Higher scores indicate easier, lower-cost manufacturing.',
    `dfmea_reference` STRING COMMENT 'Reference identifier to the DFMEA document analyzing potential design failure modes and mitigation strategies.',
    `drawing_number` STRING COMMENT 'Engineering drawing number for 2D technical documentation. References detailed manufacturing and inspection drawings.',
    `effective_date` DATE COMMENT 'Date when the current component revision becomes effective for use in new designs and BOMs. Supports ECO implementation.',
    `functional_group` STRING COMMENT 'Functional classification of the component within the product architecture. Used for design reuse and modular engineering.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the component contains hazardous materials requiring special handling, storage, and disposal procedures.',
    `height_mm` DECIMAL(18,2) COMMENT 'Maximum height dimension of the component envelope in millimeters. Part of dimensional specification for packaging and assembly planning.',
    `lead_time_days` STRING COMMENT 'Procurement or manufacturing lead time in calendar days. Used for MRP planning and order scheduling.',
    `length_mm` DECIMAL(18,2) COMMENT 'Maximum length dimension of the component envelope in millimeters. Part of dimensional specification for packaging and assembly planning.',
    `lifecycle_phase` STRING COMMENT 'Current phase in the component lifecycle from concept through obsolescence. Governs release status and usage authorization. [ENUM-REF-CANDIDATE: concept|design|prototype|validation|production|phase_out|obsolete — 7 candidates stripped; promote to reference product]',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production or procurement lot size. Defines batch quantity for manufacturing execution and inventory replenishment.',
    `make_or_buy` STRING COMMENT 'Strategic sourcing decision indicating whether the component is manufactured in-house, purchased from suppliers, or both.. Valid values are `make|buy|make_and_buy`',
    `material_specification` STRING COMMENT 'Material composition and grade specification. Defines raw material requirements for manufactured components.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by supplier or manufacturing process. Constraint for procurement and production planning.',
    `modified_by` STRING COMMENT 'User identifier of the engineer who last modified the component record. Audit trail for change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the component record was last modified. Audit trail for change tracking and data currency.',
    `component_name` STRING COMMENT 'Descriptive name of the component. Primary human-readable identifier used in engineering documentation and BOMs.',
    `obsolescence_date` DATE COMMENT 'Planned or actual date when the component will be obsoleted and no longer available for new designs. Supports lifecycle planning.',
    `pfmea_reference` STRING COMMENT 'Reference identifier to the PFMEA document analyzing potential manufacturing process failure modes and controls.',
    `plm_item_code` STRING COMMENT 'Unique identifier for this component in Siemens Teamcenter PLM system. External system reference for PLM integration.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates compliance with EU REACH regulation for chemical substance registration and safety assessment.',
    `release_status` STRING COMMENT 'Engineering release status indicating approval state for manufacturing and procurement use.. Valid values are `draft|in_review|released|frozen|obsolete|blocked`',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers replenishment action. Calculated from lead time demand and safety stock.',
    `revision` STRING COMMENT 'Current engineering revision level of the component. Tracks design changes through ECO/ECN processes.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates compliance with EU RoHS directive restricting use of hazardous substances in electrical and electronic equipment.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory buffer quantity to protect against demand variability and supply disruptions. Input to MRP calculations.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost for the component in base currency. Used for BOM costing, inventory valuation, and financial planning.',
    `technology_family` STRING COMMENT 'Engineering technology classification grouping components by functional domain (e.g., electrification, automation, control systems).',
    `tolerance_class` STRING COMMENT 'Manufacturing tolerance classification defining acceptable dimensional variation. Drives manufacturing process selection and quality inspection requirements.',
    `ul_certification_number` STRING COMMENT 'UL certification identifier for product safety compliance. Required for electrical components in North American markets.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for inventory, procurement, and BOM quantity calculations. [ENUM-REF-CANDIDATE: EA|PC|KG|G|M|CM|L|ML|SET|KIT — 10 candidates stripped; promote to reference product]',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of a single component unit in kilograms. Used for logistics planning, shipping cost calculation, and product specifications.',
    `width_mm` DECIMAL(18,2) COMMENT 'Maximum width dimension of the component envelope in millimeters. Part of dimensional specification for packaging and assembly planning.',
    `created_by` STRING COMMENT 'User identifier of the engineer who created the component record in PLM. Audit trail for data governance.',
    CONSTRAINT pk_component PRIMARY KEY(`component_id`)
) COMMENT 'Master record for every discrete engineered part, sub-assembly, or raw material managed in PLM. Serves as the SSOT for component identity, revision state, lifecycle phase, engineering classification, material specification, weight, dimensional envelope, tolerance class, CAD model reference, PLM item ID, and approved substitutes. Covers all manufactured automation system components including electrification modules, PLCs, HMIs, drives, sensors, and structural enclosures. Includes classification taxonomy (commodity, technology family, functional group) for BOM analytics and sourcing alignment.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`bom` (
    `bom_id` BIGINT COMMENT 'Unique identifier for the Bill of Materials record. Primary key for the BOM master data entity.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑specific BOMs are created for contract fulfillment; linking BOM to customer_account enables contract‑BOM reconciliation reports.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Needed for Project BOM Management process, associating each BOM with the specific capital project it supports for cost and material planning.',
    `alternative_bom_indicator` STRING COMMENT 'Identifier for alternative BOM variants of the same product, used to represent different manufacturing methods, material substitutions, or regional variations. Blank for primary BOM.',
    `approval_status` STRING COMMENT 'Current approval state of the BOM in the engineering change workflow. Pending indicates awaiting review, Approved means released for use, Rejected means not accepted, Conditional means approved with restrictions or prerequisites.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this BOM revision. Supports audit trail and accountability for engineering change management.',
    `approved_date` DATE COMMENT 'Date on which this BOM revision was formally approved for release. Critical for traceability and compliance with engineering change control processes.',
    `base_unit_of_measure` STRING COMMENT 'The fundamental unit of measure in which the finished product is stocked and sold, independent of the BOM quantity basis. Used for inventory and sales order processing.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM, typically a human-readable code used across engineering, manufacturing, and procurement systems. Serves as the externally-known unique reference.',
    `bom_status` STRING COMMENT 'Current lifecycle state of the BOM. Draft indicates work in progress, In Review means under engineering approval, Approved is ready for release, Active is in production use, Obsolete is no longer valid, Superseded has been replaced by a newer revision, and Frozen is locked for regulatory or contractual reasons. [ENUM-REF-CANDIDATE: draft|in_review|approved|active|obsolete|superseded|frozen — 7 candidates stripped; promote to reference product]',
    `bom_type` STRING COMMENT 'Classification of the BOM by its intended business purpose. Engineering BOM (EBOM) represents design intent, Manufacturing BOM (MBOM) reflects shop floor assembly, Service BOM supports after-sales maintenance, Sales BOM defines customer-facing configurations, Planning BOM is used for MRP, and As-Maintained BOM tracks actual installed configurations.. Valid values are `engineering|manufacturing|service|sales|planning|as_maintained`',
    `bom_category` STRING COMMENT 'High-level classification of the BOM structure. Material BOM lists physical components, Document BOM references technical drawings and specifications, Equipment BOM defines installed assets, Variant BOM supports product families, Configurable BOM enables customer-specific selections.. Valid values are `material|document|equipment|variant|configurable`',
    `configuration_profile` DECIMAL(18,2) COMMENT 'Identifier for a variant configuration profile or product family definition. Used in configurable BOMs to define which components are included based on customer selections or feature options.',
    `cost_estimate_currency` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the BOM cost estimate. Supports multi-currency costing for global manufacturing operations.',
    `cost_estimate_total` DECIMAL(18,2) COMMENT 'Estimated total cost of the BOM including all material, labor, and overhead components. Rolled up from component costs and routing operations. Used for product costing and pricing decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was first created in the PLM system. Provides audit trail for data governance and compliance.',
    `bom_description` STRING COMMENT 'Free-text description of the BOM, providing additional context about the product structure, manufacturing method, or special handling requirements. Supplements the BOM number and type.',
    `effective_from_date` DATE COMMENT 'Date from which this BOM revision becomes valid and can be used for production planning, procurement, and manufacturing execution. Supports time-phased BOM management for product transitions.',
    `effective_to_date` DATE COMMENT 'Date until which this BOM revision remains valid. Nullable for open-ended BOMs. Used to manage phase-out of legacy product structures and ensure correct BOM selection in MRP and MES systems.',
    `engineering_change_order_number` STRING COMMENT 'Reference to the ECO that created or last modified this BOM revision. Provides traceability to the engineering change management process and links to ECO approval workflows.',
    `explosion_type` STRING COMMENT 'Defines how the BOM structure should be expanded for planning and execution. Single Level shows only immediate children, Multi Level recursively expands all sub-assemblies, Summarized aggregates quantities across all levels.. Valid values are `single_level|multi_level|summarized`',
    `is_configurable` BOOLEAN COMMENT 'Flag indicating whether this BOM supports variant configuration, allowing customer-specific or order-specific component selection. True for configurable BOMs, False for fixed BOMs.',
    `is_critical_bom` BOOLEAN COMMENT 'Flag indicating whether this BOM is for a critical or high-value product requiring special handling, approval workflows, or regulatory compliance. True for critical BOMs, False for standard BOMs.',
    `is_phantom_bom` BOOLEAN COMMENT 'Flag indicating whether this is a phantom (transient) BOM that is not stocked as a discrete item but is exploded through to its components during MRP and production. True for phantom BOMs, False for standard stocked assemblies.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production lot or batch size for which this BOM is optimized. Used in MRP calculations to determine component requirements and setup costs. Nullable if not applicable.',
    `modified_by` STRING COMMENT 'Name or identifier of the person or system that last modified this BOM record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was last updated. Distinct from approval and effectivity dates. Provides audit trail for data governance.',
    `notes` STRING COMMENT 'Additional notes, comments, or instructions related to this BOM. May include manufacturing guidelines, quality requirements, or special handling instructions for production planning and shop floor execution.',
    `plant_code` STRING COMMENT 'Identifier for the manufacturing plant or facility where this BOM is applicable. Supports multi-plant BOM management where different sites may have different manufacturing BOMs for the same product.',
    `plm_item_code` BIGINT COMMENT 'Reference to the owning PLM item in Siemens Teamcenter that this BOM structure represents. Links the BOM to its parent product or assembly definition.',
    `production_version` STRING COMMENT 'Identifier linking this BOM to a specific production version in SAP PP, which combines a BOM with a routing to define a complete manufacturing process. Supports multiple production methods for the same product.',
    `quantity_basis` DECIMAL(18,2) COMMENT 'The base quantity for which this BOM is defined, typically 1 for single-unit BOMs or a batch size for process manufacturing. All component quantities in the BOM structure are expressed relative to this basis.',
    `revision` STRING COMMENT 'Revision level or version identifier for this BOM structure. Tracks engineering changes and ensures traceability across ECO and ECN processes. Critical for change management and configuration control.',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'Expected scrap or waste percentage at the BOM header level, applied to all components. Used in MRP to inflate material requirements. Expressed as a percentage (e.g., 5.00 for 5%).',
    `source_system_key` STRING COMMENT 'The primary key or unique identifier of this BOM record in the source system. Enables bidirectional traceability and reconciliation between the lakehouse and operational PLM system.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity basis, such as EA (each), KG (kilogram), L (liter), M (meter). Must align with the PLM item and material master UOM definitions.',
    `usage` STRING COMMENT 'Defines the business context in which this BOM is intended to be used. Production for shop floor execution, Costing for standard cost calculation, Engineering for design and development, Maintenance for service and repair, Sales Order for customer-specific configurations, Project for one-time builds.. Valid values are `production|costing|engineering|maintenance|sales_order|project`',
    `weight_total` DECIMAL(18,2) COMMENT 'Total weight of the finished assembly including all components, calculated from the BOM structure. Used for logistics planning, freight cost estimation, and product specifications.',
    `weight_unit` STRING COMMENT 'Unit of measure for the total BOM weight. KG (kilogram), LB (pound), G (gram), OZ (ounce), MT (metric ton).. Valid values are `KG|LB|G|OZ|MT`',
    `created_by` STRING COMMENT 'Name or identifier of the person or system that originally created this BOM record. Supports audit trail and data lineage.',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Bill of Materials master record defining the structured product hierarchy for a given component or finished assembly at a specific revision. Captures BOM type (engineering BOM, manufacturing BOM, service BOM), effectivity dates, quantity basis, unit of measure, and the owning PLM item. Acts as the SSOT for product structure consumed by MRP, MES, and production planning.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` (
    `engineering_bom_line_id` BIGINT COMMENT 'Unique identifier for the BOM line item. Primary key for the BOM line entity representing a single parent-child component relationship within a bill of materials structure.',
    `bom_header_id` BIGINT COMMENT 'Reference to the parent BOM header that this line belongs to. Links the line item to its containing bill of materials assembly structure.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: bom_line represents a line item belonging to a BOM; adding bom_id creates the required parent-child relationship and eliminates the BOM silo.',
    `component_id` BIGINT COMMENT 'Reference to the parent assembly or product that contains this component. Represents the parent side of the parent-child relationship in the BOM structure.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: PROCUREMENT: Each BOM line must record the supplier providing that part for purchase order creation and cost tracking.',
    `tertiary_engineering_substitute_component_id` BIGINT COMMENT 'Reference to an approved alternate component that can be used in place of the primary component without requiring an Engineering Change Order (ECO). Enables flexible sourcing and supply chain continuity.',
    `assembly_instruction` STRING COMMENT 'Specific instructions for assembling or installing this component into the parent assembly. May reference work instructions, torque specifications, or special tooling requirements.',
    `bulk_material_flag` BOOLEAN COMMENT 'Indicates whether this component is a bulk material (e.g., paint, adhesive, lubricant) that is consumed in variable quantities and may not be tracked at individual unit level.',
    `change_number` STRING COMMENT 'The Engineering Change Order (ECO) or Engineering Change Notice (ECN) number that introduced or last modified this BOM line. Provides traceability to engineering change governance processes.',
    `co_product_flag` BOOLEAN COMMENT 'Indicates whether this line represents a co-product or by-product that is produced alongside the main assembly. Co-products have negative quantities in the BOM and represent outputs rather than inputs.',
    `cost_rollup_flag` BOOLEAN COMMENT 'Indicates whether the cost of this component should be included in the parent assembly cost rollup calculation. Some components (e.g., reference items, tooling) may be excluded from product costing.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was first created in the system. Used for audit trail and change tracking.',
    `critical_component_flag` BOOLEAN COMMENT 'Indicates whether this component is critical to product functionality, safety, or regulatory compliance. Critical components may require additional quality controls, traceability, or supply chain management.',
    `effectivity_end_date` DATE COMMENT 'The date after which this component is no longer effective in the parent assembly. Used to manage engineering changes and phase-out of obsolete components. Null indicates the component is currently effective with no planned end date.',
    `effectivity_serial_number_end` STRING COMMENT 'The ending serial number of the parent assembly for which this component is effective. Null indicates the component remains effective for all subsequent serial numbers.',
    `effectivity_serial_number_start` STRING COMMENT 'The starting serial number of the parent assembly for which this component is effective. Enables serial-number-based effectivity control for mid-production engineering changes.',
    `effectivity_start_date` DATE COMMENT 'The date from which this component becomes effective in the parent assembly. Used to manage engineering changes and phase-in of new components without creating new BOM versions.',
    `engineering_bom_line_status` STRING COMMENT 'Current lifecycle status of this BOM line. Indicates whether the component relationship is currently in use, pending approval, or has been superseded.. Valid values are `active|inactive|pending|obsolete|prototype`',
    `engineering_notes` STRING COMMENT 'Free-text notes from engineering regarding special assembly instructions, design considerations, quality requirements, or other technical information relevant to this component usage.',
    `find_number` STRING COMMENT 'Reference designator or callout number used to locate this component on engineering drawings, assembly diagrams, and technical documentation. Also known as item number or balloon number.',
    `fixed_quantity_flag` BOOLEAN COMMENT 'Indicates whether the component quantity is fixed regardless of parent assembly batch size. When true, the quantity does not scale with production order quantity (e.g., setup materials, tooling).',
    `installation_point` STRING COMMENT 'The specific location or mounting point within the parent assembly where this component is installed. Used in assembly instructions and maintenance documentation.',
    `lead_time_offset_days` STRING COMMENT 'The number of days before the parent assembly start date that this component must be available. Used in production scheduling and material requirements planning (MRP) to ensure timely component availability.',
    `modified_by` STRING COMMENT 'The user or system account that last modified this BOM line record. Used for audit trail and change management purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was last modified. Used for audit trail and change tracking.',
    `phantom_flag` BOOLEAN COMMENT 'Indicates whether this component is a phantom (transient) assembly that is not stocked or tracked in inventory. Phantom items are exploded through to their child components during MRP processing.',
    `position_number` STRING COMMENT 'Sequential position or line number of this component within the parent assembly BOM. Used for ordering and identifying components in engineering drawings and manufacturing instructions.',
    `procurement_type` STRING COMMENT 'Indicates how this component is obtained: manufactured in-house (make), purchased from suppliers (buy), transferred from another plant (transfer), or subcontracted to external manufacturers.. Valid values are `make|buy|transfer|subcontract`',
    `quantity_per_assembly` DECIMAL(18,2) COMMENT 'The number of units of this component required to build one unit of the parent assembly. Used for material requirements planning (MRP) calculations and cost rollup.',
    `reference_designator` STRING COMMENT 'Alphanumeric code identifying the specific location or function of the component in the assembly (e.g., R1, C5, U3 for electronics; A-01, B-12 for mechanical). Used in assembly instructions and maintenance documentation.',
    `revision_level` STRING COMMENT 'The revision or version of the component that is specified for use in this assembly. Ensures that the correct component revision is used for manufacturing and quality control.',
    `scrap_factor_percentage` DECIMAL(18,2) COMMENT 'Expected scrap or waste percentage for this component during assembly or manufacturing. Used to adjust material requirements planning (MRP) calculations to account for normal production losses.',
    `sort_sequence` STRING COMMENT 'Numeric value used to control the display order of BOM lines in reports, pick lists, and assembly instructions. Lower values appear first.',
    `substitute_qualification_status` STRING COMMENT 'Approval status of the substitute component for use in this assembly. Indicates whether the alternate has passed qualification testing and is approved for production use.. Valid values are `qualified|conditional|pending|not_qualified`',
    `substitute_usage_restriction` STRING COMMENT 'Conditions or limitations on when the substitute component may be used (e.g., only for specific customer orders, only when primary is unavailable, geographic restrictions). Ensures proper alternate sourcing governance.',
    `unit_of_measure` STRING COMMENT 'The unit in which the component quantity is expressed (e.g., each, kilogram, meter, liter). Must align with the component material master UOM for accurate MRP and inventory calculations. [ENUM-REF-CANDIDATE: EA|PC|KG|G|L|ML|M|CM|FT|IN|SET|PAIR|BOX|ROLL|SHEET — 15 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'The user or system account that created this BOM line record. Used for audit trail and change management purposes.',
    CONSTRAINT pk_engineering_bom_line PRIMARY KEY(`engineering_bom_line_id`)
) COMMENT 'Individual line item within a Bill of Materials, representing a single parent-child component relationship. Captures position number, find number, quantity per assembly, unit of measure, reference designator, substitute component references (approved alternates with qualification status and usage restrictions), phantom flag, effectivity start/end dates, and engineering notes. Enables full BOM explosion and implosion queries for MRP, supports alternate sourcing without ECO, and provides the granular structure for production routing and cost rollup.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` (
    `cad_model_id` BIGINT COMMENT 'Unique identifier for the CAD/CAM design file record in the PLM system.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: CAD model author is needed for design ownership, IP protection and change‑management reporting.',
    `component_id` BIGINT COMMENT 'Reference to the manufactured component or assembly that this CAD model represents.',
    `approved_by` STRING COMMENT 'Username or identifier of the engineering manager or authority who approved the CAD model for release to manufacturing.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the CAD model was formally approved for release to manufacturing.',
    `authoring_tool` STRING COMMENT 'Name of the CAD software application used to create the model (e.g., Siemens NX, SolidWorks, CATIA, AutoCAD).',
    `authoring_tool_version` STRING COMMENT 'Version number of the CAD authoring software used to create or last modify the model, critical for file compatibility and migration planning.',
    `bounding_box_height` DECIMAL(18,2) COMMENT 'Maximum height dimension of the CAD model bounding box, used for spatial analysis and packaging planning.',
    `bounding_box_length` DECIMAL(18,2) COMMENT 'Maximum length dimension of the CAD model bounding box, used for spatial analysis and packaging planning.',
    `bounding_box_width` DECIMAL(18,2) COMMENT 'Maximum width dimension of the CAD model bounding box, used for spatial analysis and packaging planning.',
    `cam_program_reference` BIGINT COMMENT 'Reference to the associated CAM toolpath program generated from this CAD model for CNC machining operations.',
    `cam_programming_required` BOOLEAN COMMENT 'Flag indicating whether this CAD model requires CAM toolpath programming for CNC machining or other automated manufacturing processes.',
    `center_of_gravity_x` DECIMAL(18,2) COMMENT 'X-coordinate of the calculated center of gravity for the 3D model, used for balance and assembly analysis.',
    `center_of_gravity_y` DECIMAL(18,2) COMMENT 'Y-coordinate of the calculated center of gravity for the 3D model, used for balance and assembly analysis.',
    `center_of_gravity_z` DECIMAL(18,2) COMMENT 'Z-coordinate of the calculated center of gravity for the 3D model, used for balance and assembly analysis.',
    `checksum_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the CAD file content, used for integrity verification and change detection.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the CAD model record was first created in the PLM system.',
    `dataset_type` STRING COMMENT 'Classification of the CAD dataset indicating whether it is a 3D solid model, 2D drawing, assembly, simulation file, or CAM toolpath file.. Valid values are `3D_Solid_Model|2D_Drawing|Assembly|Simulation|CAM_Toolpath|Sheet_Metal`',
    `design_intent` STRING COMMENT 'Engineering rationale and functional requirements that guided the design of this CAD model, supporting Design for Manufacturability (DFM) analysis.',
    `dfm_analysis_status` BOOLEAN COMMENT 'Status of the Design for Manufacturability analysis for this CAD model, indicating whether the design has been reviewed for manufacturing feasibility.',
    `dfm_complexity_score` DECIMAL(18,2) COMMENT 'Numerical score representing the manufacturing complexity of the design, derived from DFM analysis (higher scores indicate more complex manufacturing requirements).',
    `drawing_number` STRING COMMENT 'Unique identifier for the associated 2D engineering drawing derived from or related to this CAD model.',
    `eco_number` STRING COMMENT 'Reference to the Engineering Change Order that authorized the creation or modification of this CAD model revision.',
    `export_control_classification` STRING COMMENT 'Export control classification number assigned to this CAD model for international trade compliance, if applicable.',
    `file_format` STRING COMMENT 'Native file format of the CAD model (e.g., STEP for neutral exchange, JT for visualization, NX for native Siemens format, DXF for 2D drawings). [ENUM-REF-CANDIDATE: STEP|JT|NX|DXF|DWG|IGES|STL|Parasolid|CATIA|SolidWorks — 10 candidates stripped; promote to reference product]',
    `file_size_bytes` BIGINT COMMENT 'Size of the CAD model file in bytes, used for storage planning and data transfer optimization.',
    `intellectual_property_owner` STRING COMMENT 'Legal entity or business unit that owns the intellectual property rights to this CAD model design.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether this CAD model contains proprietary or confidential design information requiring restricted access controls.',
    `material_specification` STRING COMMENT 'Specification of the material to be used for manufacturing the component represented by this CAD model (e.g., steel grade, aluminum alloy, polymer type).',
    `model_description` STRING COMMENT 'Detailed textual description of the CAD model, including its purpose, key features, and design intent.',
    `model_mass` DECIMAL(18,2) COMMENT 'Calculated mass of the component based on model volume and material density, used for weight analysis and shipping planning.',
    `model_maturity_state` STRING COMMENT 'Current lifecycle state of the CAD model indicating its readiness for manufacturing (e.g., Draft, In Review, Approved, Released, Obsolete).. Valid values are `Draft|In_Review|Approved|Released|Obsolete|Archived`',
    `model_name` STRING COMMENT 'Human-readable name or title of the CAD model file as assigned by the design engineer.',
    `model_number` STRING COMMENT 'Unique business identifier or part number associated with this CAD model, used for cross-referencing with BOM and engineering documentation.',
    `model_surface_area` DECIMAL(18,2) COMMENT 'Calculated surface area of the 3D model, used for coating, painting, and finishing process planning.',
    `model_volume` DECIMAL(18,2) COMMENT 'Calculated volume of the 3D solid model, used for material estimation and weight calculation.',
    `modified_by` STRING COMMENT 'Username or identifier of the design engineer who last modified the CAD model.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the CAD model was last modified or updated in the PLM system.',
    `obsolete_timestamp` TIMESTAMP COMMENT 'Date and time when the CAD model was marked as obsolete and superseded by a newer revision.',
    `released_timestamp` TIMESTAMP COMMENT 'Date and time when the CAD model was officially released to production and made available for manufacturing use.',
    `revision` STRING COMMENT 'Current revision level of the CAD model, incremented with each engineering change (e.g., A, B, C or 1.0, 2.0).',
    `unit_of_measure` STRING COMMENT 'Unit of measurement used for dimensions in the CAD model (e.g., millimeters, inches), critical for accurate interpretation and manufacturing.. Valid values are `mm|cm|m|in|ft`',
    `vault_storage_path` STRING COMMENT 'File system or vault storage location reference where the physical CAD file is stored in the PLM repository.',
    `version` STRING COMMENT 'Detailed version identifier for the CAD model file, tracking iterative changes within a revision (e.g., 2.0.1, 2.0.2).',
    `created_by` STRING COMMENT 'Username or identifier of the design engineer who created the original CAD model.',
    CONSTRAINT pk_cad_model PRIMARY KEY(`cad_model_id`)
) COMMENT 'Master record for CAD/CAM design files managed in PLM, including 3D solid models, 2D drawings, simulation files, and CAM toolpath files. Tracks file format (STEP, JT, NX, DXF), revision, authoring tool version, model maturity state, associated component, dataset type, file size, and vault storage reference. Supports DFM analysis input and downstream CAM programming.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` (
    `drawing_id` BIGINT COMMENT 'Unique identifier for the engineering drawing record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Drawing approval authority must be tracked for release control and traceability in PLM.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: A drawing documents a component; linking drawing to component provides traceability and connects the drawing product.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Drawings released for a particular customer project must reference the customer_account for release approval and traceability.',
    `approval_date` DATE COMMENT 'Date when the drawing was approved by the authorized engineering authority. Precedes the release date.',
    `assembly_level` STRING COMMENT 'Hierarchical level of the item depicted (component, subassembly, assembly, system). Indicates the complexity and position in the product structure.. Valid values are `component|subassembly|assembly|system`',
    `cad_model_reference` STRING COMMENT 'Reference to the associated 3D CAD model file or identifier in the PLM system (e.g., Siemens Teamcenter item ID). Links the 2D drawing to its source 3D model.',
    `checked_by` STRING COMMENT 'Name or identifier of the engineer who reviewed and checked the drawing for accuracy and completeness before approval.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the drawing (public, internal, confidential, restricted, proprietary). Governs access control and distribution.. Valid values are `public|internal|confidential|restricted|proprietary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drawing record was first created in the system. Audit trail for record creation.',
    `drawing_number` STRING COMMENT 'The formal drawing number assigned per engineering numbering scheme. Serves as the externally-known unique identifier for this technical drawing across the product lifecycle.. Valid values are `^[A-Z0-9]{3,20}(-[A-Z0-9]{1,10})?$`',
    `drawing_status` STRING COMMENT 'Current lifecycle status of the drawing (draft, in_review, approved, released, obsolete, superseded). Governs whether the drawing can be used for manufacturing.. Valid values are `draft|in_review|approved|released|obsolete|superseded`',
    `drawing_type` STRING COMMENT 'Classification of the drawing by its purpose and content (assembly, detail, schematic, layout, installation, wiring, piping, fabrication). [ENUM-REF-CANDIDATE: assembly|detail|schematic|layout|installation|wiring|piping|fabrication — 8 candidates stripped; promote to reference product]',
    `drawn_by` STRING COMMENT 'Name or identifier of the engineer or drafter who created the drawing. Recorded in the title block.',
    `eco_number` STRING COMMENT 'Engineering Change Order number that authorized the current revision of this drawing. Links the drawing to the formal change management process.',
    `export_control_classification` STRING COMMENT 'Export control classification number (ECCN) or similar designation if the drawing contains controlled technical data. Required for international compliance.',
    `file_format` STRING COMMENT 'Digital file format of the drawing (PDF, DWG, DXF, STEP, IGES, JT). Determines compatibility and usage.. Valid values are `PDF|DWG|DXF|STEP|IGES|JT`',
    `file_path` STRING COMMENT 'Storage location or URI of the drawing file in the document management system or file server.',
    `is_master_drawing` BOOLEAN COMMENT 'Flag indicating whether this is the master (authoritative) drawing for the part. True if this is the primary reference; false if it is a derivative or copy.',
    `language_code` STRING COMMENT 'ISO 639 language code for the primary language of text and annotations on the drawing (e.g., ENG, DEU, FRA, JPN).. Valid values are `^[A-Z]{2,3}$`',
    `material_callout` STRING COMMENT 'Material specification called out on the drawing (e.g., AISI 304, Al 6061-T6, SAE 1020). Defines the material from which the part is manufactured.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the drawing record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'General notes, instructions, or annotations recorded on the drawing. May include manufacturing instructions, inspection requirements, or special handling.',
    `part_number` STRING COMMENT 'The part number of the component or assembly depicted in this drawing. Links the drawing to the Bill of Materials (BOM) and inventory systems.',
    `plm_item_code` STRING COMMENT 'Unique identifier of the drawing object in the Siemens Teamcenter PLM system. Enables traceability to the system of record.',
    `projection_method` STRING COMMENT 'Orthographic projection method used (first_angle per ISO, third_angle per ANSI). Determines the arrangement of views.. Valid values are `first_angle|third_angle`',
    `release_date` DATE COMMENT 'Date when the drawing was officially released for manufacturing and procurement. Marks the transition from engineering to production.',
    `revision_level` STRING COMMENT 'Current revision level or version of the drawing (e.g., A, B, C, 01, 02). Increments with each approved engineering change.. Valid values are `^[A-Z0-9]{1,5}$`',
    `scale` STRING COMMENT 'Scale ratio of the drawing (e.g., 1:1, 1:2, 2:1, NTS for Not To Scale). Indicates the relationship between drawing dimensions and actual part dimensions.. Valid values are `^(1:[0-9]+|[0-9]+:1|NTS)$`',
    `sheet_count` STRING COMMENT 'Total number of sheets in this drawing set. Multi-sheet drawings are common for complex assemblies.',
    `sheet_size` STRING COMMENT 'Standard sheet size designation (ISO: A0, A1, A2, A3, A4; ANSI: A, B, C, D, E, F) used for this drawing. [ENUM-REF-CANDIDATE: A0|A1|A2|A3|A4|A|B|C|D|E|F — 11 candidates stripped; promote to reference product]',
    `standard` STRING COMMENT 'The drafting standard governing this drawing (ISO, ANSI, ASME, DIN, JIS, BS). Determines dimensioning, tolerancing, and symbology conventions.. Valid values are `ISO|ANSI|ASME|DIN|JIS|BS`',
    `superseded_by_drawing_number` STRING COMMENT 'Drawing number that supersedes this drawing when status is obsolete or superseded. Maintains traceability in the revision chain.',
    `supersedes_drawing_number` STRING COMMENT 'Previous drawing number that this drawing supersedes. Establishes the backward link in the revision history.',
    `surface_finish_specification` STRING COMMENT 'Surface roughness or finish requirement specified on the drawing (e.g., Ra 0.8, N6, 125 microinch). Critical for functional surfaces.',
    `title` STRING COMMENT 'The descriptive title of the drawing that identifies the component, assembly, or system being documented.',
    `tolerance_class` STRING COMMENT 'General tolerance class applied to dimensions not individually toleranced (fine, medium, coarse, precision, general). Defines default dimensional accuracy.. Valid values are `fine|medium|coarse|precision|general`',
    `unit_of_measure` STRING COMMENT 'Primary unit of measure used for dimensions on the drawing (mm, cm, m, in, ft). Typically millimeters for ISO and inches for ANSI.. Valid values are `mm|cm|m|in|ft`',
    `weight_kg` DECIMAL(18,2) COMMENT 'Calculated or estimated weight of the part or assembly in kilograms. Used for logistics, handling, and structural analysis.',
    CONSTRAINT pk_drawing PRIMARY KEY(`drawing_id`)
) COMMENT 'Engineering drawing record representing the formal 2D technical drawing released for a component or assembly. Captures drawing number, revision level, sheet count, drawing standard (ISO, ANSI), tolerance class, surface finish specification, material callout, approval status, release date, and associated CAD model reference. Serves as the authoritative manufacturing and inspection reference document.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`eco` (
    `eco_id` BIGINT COMMENT 'Unique identifier for the engineering change order record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑driven engineering change orders are tracked via ECO linked to the requesting customer_account for audit trails.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ECO initiation must record the engineer who raised the change, used in engineering change management dashboards.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory Change Management links each ECO to the specific regulatory requirement it addresses, ensuring traceability of compliance-driven changes.',
    `acknowledgement_count` STRING COMMENT 'Number of stakeholders who have acknowledged receipt of the ECN.',
    `acknowledgement_required` BOOLEAN COMMENT 'Indicates whether recipients of the ECN are required to formally acknowledge receipt and understanding.',
    `actual_cost_impact` DECIMAL(18,2) COMMENT 'Actual financial impact realized after implementation, including all direct and indirect costs.',
    `actual_schedule_impact_days` STRING COMMENT 'Actual impact on production schedule in days realized after implementation.',
    `affected_items_count` STRING COMMENT 'Total number of product items (parts, assemblies, drawings, documents) affected by this engineering change.',
    `approval_date` DATE COMMENT 'Date when the ECO received final approval authorization to proceed with implementation.',
    `approved_by_name` STRING COMMENT 'Full name of the final approver who authorized the engineering change.',
    `approved_by_title` STRING COMMENT 'Job title or role of the final approver (e.g., Chief Engineer, VP Engineering, Quality Manager).',
    `change_priority` STRING COMMENT 'Business priority level for implementing the change. Critical = safety/regulatory; High = customer impact; Medium = quality improvement; Low = cost reduction.. Valid values are `critical|high|medium|low`',
    `change_type` STRING COMMENT 'Classification of the engineering change by category: design (product geometry/function), material (BOM substitution), process (manufacturing method), documentation (drawing/spec update), specification (performance criteria), or tooling (fixture/jig modification).. Valid values are `design|material|process|documentation|specification|tooling`',
    `closure_date` DATE COMMENT 'Date when the ECO was formally closed after successful implementation and verification.',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for cost impact amounts (e.g., USD, EUR, CNY).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ECO record was first created in the system.',
    `customer_approval_date` DATE COMMENT 'Date when customer approval was received for the engineering change.',
    `customer_approval_received` BOOLEAN COMMENT 'Indicates whether required customer approval has been obtained.',
    `eco_description` STRING COMMENT 'Detailed description of the engineering change including technical rationale, scope, and implementation approach.',
    `disposition_action` STRING COMMENT 'Primary disposition action for existing inventory and work-in-progress: use_as_is (no action required), rework (modify to new spec), scrap (discard), retrofit (field upgrade), return_to_supplier (vendor return).. Valid values are `use_as_is|rework|scrap|retrofit|return_to_supplier`',
    `eco_number` STRING COMMENT 'Business identifier for the engineering change order, externally visible and used across systems. Typically follows format ECO-NNNNNN.. Valid values are `^ECO-[0-9]{6,10}$`',
    `effectivity_date` DATE COMMENT 'Date when the engineering change becomes effective and must be implemented in production. Controls when new revision supersedes old revision.',
    `effectivity_reference` STRING COMMENT 'Reference value for effectivity (e.g., serial number, lot number, or date) that defines the cutover point for the change.',
    `effectivity_type` STRING COMMENT 'Method by which the change takes effect: date (on specific date), serial_number (from specific unit serial), lot_batch (from specific production lot), immediate (next unit produced).. Valid values are `date|serial_number|lot_batch|immediate`',
    `erp_system_reference` STRING COMMENT 'Reference identifier linking this ECO to the corresponding engineering change record in the ERP system (e.g., SAP S/4HANA).',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of implementing the change, including material, labor, tooling, and scrap costs. Positive values indicate cost increase; negative values indicate savings.',
    `estimated_schedule_impact_days` STRING COMMENT 'Estimated impact on production schedule in days. Positive values indicate delay; negative values indicate acceleration.',
    `from_revision` STRING COMMENT 'Current revision level of the primary affected item before the change is applied.',
    `implementation_date` DATE COMMENT 'Actual date when the engineering change was implemented in production systems and processes.',
    `initiated_date` DATE COMMENT 'Date when the engineering change order was formally initiated and entered into the system.',
    `initiator_department` STRING COMMENT 'Organizational department or functional area of the change initiator (e.g., Product Engineering, Quality, Manufacturing Engineering).',
    `initiator_email` STRING COMMENT 'Email address of the change initiator for communication and audit trail purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `last_modified_by` STRING COMMENT 'Name or user ID of the person who last modified this ECO record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ECO record was last updated.',
    `lifecycle_status` STRING COMMENT 'Current state of the ECO in its approval and implementation workflow: draft (being prepared), submitted (awaiting review), under_review (in approval chain), approved (authorized for implementation), rejected (not approved), in_implementation (being executed), completed (closed), cancelled (withdrawn). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|in_implementation|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `plm_system_reference` STRING COMMENT 'Reference identifier or URL linking this ECO to the corresponding record in the PLM system (e.g., Siemens Teamcenter).',
    `reason_code` STRING COMMENT 'Root cause or business driver for initiating the engineering change: safety issue, regulatory compliance, quality improvement, cost reduction, component obsolescence, or customer-requested modification.. Valid values are `safety|regulatory|quality|cost_reduction|obsolescence|customer_request`',
    `reason_description` STRING COMMENT 'Detailed explanation of the business or technical reason necessitating the change, including problem statement and justification.',
    `requires_customer_approval` BOOLEAN COMMENT 'Indicates whether this engineering change requires formal customer notification and approval before implementation.',
    `requires_supplier_notification` BOOLEAN COMMENT 'Indicates whether this change requires notification to suppliers for purchased components or materials.',
    `submitted_date` DATE COMMENT 'Date when the ECO was submitted for formal review and approval.',
    `title` STRING COMMENT 'Short descriptive title summarizing the nature of the engineering change.',
    `to_revision` STRING COMMENT 'New revision level of the primary affected item after the change is applied.',
    CONSTRAINT pk_eco PRIMARY KEY(`eco_id`)
) COMMENT 'Engineering Change Order — the formal governance record initiating, tracking, approving, and closing a controlled change to a released product design. Captures ECO number, change type (design, material, process), priority, reason code, affected items with disposition (use-as-is, rework, scrap, retrofit), effectivity date, cost/schedule impact, initiator, approver chain, closure status, and revision transition (from/to). Includes affected item detail: item reference, type, current/proposed revision, disposition action, quantity affected, and implementation status per item. Upon approval, also serves as the Engineering Change Notice (ECN) — the formal communication record distributed to production, supply chain, quality, and supplier portals capturing notification distribution list, acknowledgement tracking, implementation date, and affected BOM/drawing revisions. SSOT for engineering change governance and change communication per ISO 9001 change control requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` (
    `ecn_id` BIGINT COMMENT 'Unique identifier for the engineering change notice record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or change control board member who approved the release of this ECN.',
    `eco_id` BIGINT COMMENT 'Reference to the parent engineering change order that was approved and is now being communicated via this ECN.',
    `primary_ecn_employee_id` BIGINT COMMENT 'Reference to the employee or engineer who created and released this ECN.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: ECNs implement changes required by a regulatory requirement; linking provides auditability of compliance‑driven engineering changes.',
    `acknowledgement_count` STRING COMMENT 'Number of stakeholders who have formally acknowledged receipt and understanding of this ECN. Used to track distribution completion.',
    `acknowledgement_required` BOOLEAN COMMENT 'Indicates whether recipients must formally acknowledge receipt and understanding of this ECN. True = acknowledgement tracking enabled; False = informational only.',
    `acknowledgement_target_count` STRING COMMENT 'Total number of stakeholders required to acknowledge this ECN before it can be marked as fully distributed.',
    `affected_drawing_count` STRING COMMENT 'Total number of engineering drawings, Computer-Aided Design (CAD) models, or technical documents affected by this ECN.',
    `affected_part_count` STRING COMMENT 'Total number of distinct part numbers or Bill of Materials (BOM) items affected by this ECN.',
    `affected_product_lines` STRING COMMENT 'Comma-separated list or narrative of product lines, families, or platforms impacted by this ECN. Used for scoping and impact analysis.',
    `approval_date` DATE COMMENT 'Date when the ECN was formally approved for release by the designated approver or change control board.',
    `bom_impact_flag` BOOLEAN COMMENT 'Indicates whether this ECN requires changes to one or more Bill of Materials (BOM) structures. True = BOM changes required; False = no BOM impact.',
    `change_category` STRING COMMENT 'Primary category of the engineering change. Design = product design modification; Material = material substitution; Process = manufacturing process change; Documentation = drawing/spec update; Specification = requirement change; Supplier = vendor change.. Valid values are `design|material|process|documentation|specification|supplier`',
    `change_description` STRING COMMENT 'Detailed narrative description of the engineering change being communicated, including technical modifications, affected components, and implementation instructions.',
    `change_reason` STRING COMMENT 'Business justification and rationale for the engineering change, including root cause, customer requirements, regulatory compliance, or quality improvement drivers.',
    `closure_date` DATE COMMENT 'Date when the ECN was closed after successful implementation and acknowledgement by all required stakeholders.',
    `comments` STRING COMMENT 'Additional notes, instructions, or clarifications related to the ECN implementation, distribution, or acknowledgement process.',
    `cost_impact_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the cost impact estimate (e.g., USD, EUR, CNY).',
    `cost_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost impact of implementing this ECN, including material, labor, tooling, and inventory disposition costs. Positive values indicate cost increase; negative values indicate cost savings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ECN record was first created in the system.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether customers must be notified of this ECN due to form, fit, function, or regulatory changes. True = customer notification required; False = internal only.',
    `distribution_list` STRING COMMENT 'Comma-separated list or structured text of roles, departments, or individuals who must receive and acknowledge this ECN (e.g., Production, Quality, Supply Chain, Engineering).',
    `ecn_number` STRING COMMENT 'Business identifier for the engineering change notice, typically formatted as ECN-NNNNNN. Used for external communication and tracking across systems.. Valid values are `^ECN-[0-9]{6,10}$`',
    `ecn_status` STRING COMMENT 'Current lifecycle status of the ECN. Draft = being prepared; Released = approved for distribution; Distributed = sent to stakeholders; Acknowledged = recipients confirmed receipt; Closed = implementation complete; Cancelled = voided.. Valid values are `draft|released|distributed|acknowledged|closed|cancelled`',
    `ecn_type` STRING COMMENT 'Classification of the ECN based on urgency and scope. Standard = normal process; Urgent = expedited review; Emergency = immediate action required; Field Change = affects deployed products; Design Improvement = enhancement.. Valid values are `standard|urgent|emergency|field_change|design_improvement`',
    `effective_date` DATE COMMENT 'Date when the engineering change becomes effective and must be implemented in production, procurement, and quality systems.',
    `erp_sync_status` STRING COMMENT 'Status of synchronization of this ECN to downstream Enterprise Resource Planning (ERP) systems (SAP S/4HANA). Pending = awaiting sync; Synced = successfully transmitted; Failed = sync error; Not Required = no ERP impact.. Valid values are `pending|synced|failed|not_required`',
    `implementation_date` DATE COMMENT 'Actual date when the engineering change was fully implemented across all affected systems and processes.',
    `inventory_impact_flag` BOOLEAN COMMENT 'Indicates whether this ECN affects existing inventory, requiring disposition decisions (scrap, rework, use-as-is). True = inventory action required; False = no inventory impact.',
    `mes_sync_status` STRING COMMENT 'Status of synchronization of this ECN to Manufacturing Execution System (MES) for shop floor implementation. Pending = awaiting sync; Synced = successfully transmitted; Failed = sync error; Not Required = no MES impact.. Valid values are `pending|synced|failed|not_required`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ECN record was last modified or updated.',
    `plm_system_code` STRING COMMENT 'Unique identifier for this ECN in the source Product Lifecycle Management (PLM) system (Siemens Teamcenter). Used for system integration and traceability.',
    `priority` STRING COMMENT 'Priority level for implementation of the ECN. Critical = safety/regulatory; High = customer impact; Medium = quality improvement; Low = documentation only.. Valid values are `critical|high|medium|low`',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether this ECN affects regulatory compliance, certifications, or safety approvals (UL, CE, ISO). True = regulatory review required; False = no regulatory impact.',
    `release_date` DATE COMMENT 'Date when the ECN was officially released and approved for distribution to affected stakeholders.',
    `revision_from` STRING COMMENT 'The previous revision level of the affected item(s) before this ECN takes effect. Used to track revision transitions.. Valid values are `^[A-Z0-9]{1,10}$`',
    `revision_to` STRING COMMENT 'The new revision level of the affected item(s) after this ECN is implemented. Represents the target state.. Valid values are `^[A-Z0-9]{1,10}$`',
    `routing_impact_flag` BOOLEAN COMMENT 'Indicates whether this ECN requires changes to manufacturing routings or process plans. True = routing changes required; False = no routing impact.',
    `supplier_notification_required` BOOLEAN COMMENT 'Indicates whether external suppliers must be notified of this ECN due to purchased part changes or specification updates. True = supplier notification required; False = internal only.',
    CONSTRAINT pk_ecn PRIMARY KEY(`ecn_id`)
) COMMENT 'Engineering Change Notice — the released notification record that communicates an approved and implemented engineering change to all affected stakeholders including production, supply chain, and quality. Captures ECN number, linked ECO, effective revision transition (from/to), implementation date, affected BOM revisions, affected drawings, distribution list, and acknowledgement tracking. Downstream consumers include MES, MRP, and supplier portals.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` (
    `engineering_revision_id` BIGINT COMMENT 'Unique identifier for the revision record. Primary key for the revision entity.',
    `component_id` BIGINT COMMENT 'Reference to the component or assembly that this revision applies to. Links to the master component record in the Product Lifecycle Management (PLM) system.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑specific revisions (e.g., custom part revisions) are tracked per customer_account for change management.',
    `ecn_id` BIGINT COMMENT 'Reference to the Engineering Change Notice (ECN) that communicates this revision to stakeholders. Links the revision to the change notification process.',
    `eco_id` BIGINT COMMENT 'Reference to the Engineering Change Order (ECO) that authorized and governs this revision. Links the revision to the formal change management process.',
    `primary_superseded_by_revision_engineering_revision_id` BIGINT COMMENT 'Reference to the newer revision that supersedes this revision. Establishes the revision lineage chain for traceability and configuration management. Null if this is the current active revision.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Component revisions are often triggered by updates to regulatory requirements; the FK records the governing regulation.',
    `approval_date` DATE COMMENT 'The date when this revision was formally approved by the release authority. Distinct from release date, represents the approval event in the workflow.',
    `cad_file_reference` STRING COMMENT 'Reference path or identifier to the Computer-Aided Design (CAD) model file associated with this revision in the Product Data Management (PDM) or PLM system.',
    `ce_marking_required` BOOLEAN COMMENT 'Flag indicating whether CE marking (European Conformity) is required for this revision. True indicates CE marking is mandatory for European market release.',
    `change_category` STRING COMMENT 'Classification of the reason for the revision change. Categorizes the business driver behind the Engineering Change Order (ECO). [ENUM-REF-CANDIDATE: design_improvement|cost_reduction|quality_issue|regulatory_compliance|customer_request|obsolescence|manufacturing_improvement|safety_enhancement — 8 candidates stripped; promote to reference product]',
    `change_impact_level` STRING COMMENT 'Assessment of the impact magnitude of this revision on form, fit, function, quality, cost, or schedule. Critical indicates significant impact requiring extensive validation, low indicates minimal impact.. Valid values are `critical|high|medium|low`',
    `change_justification` STRING COMMENT 'Business justification and summary description of why this revision was created. Captures the rationale for the design change, improvement, or correction.',
    `configuration_baseline` DECIMAL(18,2) COMMENT 'The configuration baseline identifier that this revision belongs to. Used for configuration management and as-designed vs as-built reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this revision record was first created in the PLM system. Provides audit trail for record creation event.',
    `dfm_analysis_completed` BOOLEAN COMMENT 'Flag indicating whether Design for Manufacturability (DFM) analysis has been completed for this revision. True indicates DFM review is complete and findings are incorporated.',
    `dfmea_completed` BOOLEAN COMMENT 'Flag indicating whether Design Failure Mode and Effects Analysis (DFMEA) has been completed for this revision. True indicates DFMEA is complete and risk mitigation actions are defined.',
    `drawing_number` STRING COMMENT 'The engineering drawing number associated with this revision. Links the revision to the formal technical drawing documentation.',
    `effective_end_date` DATE COMMENT 'The date when this revision ceases to be effective and is superseded or obsoleted. Defines the end of the effectivity window. Null indicates the revision is currently effective with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this revision becomes effective for manufacturing, procurement, and engineering activities. Defines the beginning of the effectivity window.',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number (ECCN) or similar export control designation for this revision. Used to determine export licensing requirements and trade compliance.',
    `interchangeability_code` STRING COMMENT 'Indicates whether this revision is interchangeable with previous revisions. Fully interchangeable means drop-in replacement, form-fit-function means functionally equivalent, retrofit required means modification needed, not interchangeable means incompatible.. Valid values are `fully_interchangeable|form_fit_function|retrofit_required|not_interchangeable`',
    `label` STRING COMMENT 'The human-readable revision identifier following organizational revision scheme (e.g., A, B, C or 01, 02, 03). Represents the discrete revision state of the component.. Valid values are `^[A-Z0-9]{1,10}$`',
    `lifecycle_state` STRING COMMENT 'Current lifecycle state of the revision within the Product Lifecycle Management (PLM) workflow. In-work indicates active development, in-review indicates pending approval, approved indicates ready for release, released indicates production-ready, obsolete indicates no longer valid, superseded indicates replaced by newer revision, frozen indicates locked for reference. [ENUM-REF-CANDIDATE: in_work|in_review|approved|released|obsolete|superseded|frozen — 7 candidates stripped; promote to reference product]',
    `mass_production_approved` BOOLEAN COMMENT 'Flag indicating whether this revision has been approved for mass production. True indicates all validation activities are complete and production release is authorized.',
    `modified_by` STRING COMMENT 'Identifier of the user who last modified this revision record. Provides audit trail for record updates.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this revision record was last modified. Provides audit trail for the most recent update event.',
    `notes` STRING COMMENT 'Additional notes, comments, or detailed description of changes made in this revision. Provides supplementary context beyond the change justification summary.',
    `pfmea_completed` BOOLEAN COMMENT 'Flag indicating whether Process Failure Mode and Effects Analysis (PFMEA) has been completed for this revision. True indicates PFMEA is complete and process controls are established.',
    `ppap_level` STRING COMMENT 'The PPAP submission level required for this revision (1-5). Level 1 is warrant only, Level 5 is full submission with samples. Null if PPAP is not required.',
    `ppap_required` BOOLEAN COMMENT 'Flag indicating whether Production Part Approval Process (PPAP) submission is required for this revision. True indicates customer or regulatory requirement for PPAP documentation.',
    `prototype_test_date` DATE COMMENT 'The date when prototype testing was completed for this revision. Null if prototype testing has not been performed.',
    `prototype_tested` BOOLEAN COMMENT 'Flag indicating whether a physical prototype of this revision has been built and tested. True indicates prototype validation is complete.',
    `reach_compliant` BOOLEAN COMMENT 'Flag indicating whether this revision complies with REACH regulation for chemical substances. True indicates compliance with EU chemical safety requirements.',
    `regulatory_compliance_status` STRING COMMENT 'Status of regulatory compliance assessment for this revision. Indicates whether the revision meets applicable regulatory requirements (ISO, IEC, UL, CE, OSHA, EPA).. Valid values are `compliant|pending_review|non_compliant|not_applicable`',
    `release_authority` STRING COMMENT 'Name or identifier of the person, role, or committee that authorized the release of this revision. Captures the approval authority for traceability and compliance.',
    `release_authority_role` STRING COMMENT 'The organizational role or title of the release authority (e.g., Chief Engineer, Engineering Manager, Change Control Board). Provides context for the approval level.',
    `release_date` DATE COMMENT 'The date when this revision was officially released for production use. Represents the business event timestamp when the revision transitioned to released state.',
    `revision_type` STRING COMMENT 'Classification of the revision indicating the magnitude of change. Major revisions represent significant design changes, minor revisions represent incremental improvements, patch revisions represent corrections, branch revisions represent parallel variant development, and prototype revisions represent pre-release experimental versions.. Valid values are `major|minor|patch|branch|prototype`',
    `rohs_compliant` BOOLEAN COMMENT 'Flag indicating whether this revision complies with Restriction of Hazardous Substances (RoHS) directive. True indicates the design meets RoHS material restrictions.',
    `specification_document` STRING COMMENT 'Reference to the technical specification document that defines the requirements and characteristics for this revision.',
    `ul_certification_required` BOOLEAN COMMENT 'Flag indicating whether Underwriters Laboratories (UL) product safety certification is required for this revision. True indicates UL certification is mandatory for market release.',
    `created_by` STRING COMMENT 'Identifier of the user or engineer who created this revision record in the PLM system. Provides audit trail for record creation.',
    CONSTRAINT pk_engineering_revision PRIMARY KEY(`engineering_revision_id`)
) COMMENT 'Revision history record for a component or assembly, capturing each discrete revision state managed in PLM. Tracks revision label (A, B, C or 01, 02), lifecycle state (in-work, released, obsolete), release date, superseded revision, release authority, change justification summary, linked ECO, and effectivity window. Provides full revision lineage for traceability, regulatory compliance, configuration audits, and as-designed vs as-built reconciliation. Supports multi-level revision schemes (major/minor) and parallel branch revisions for variant management.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` (
    `dfmea_id` BIGINT COMMENT 'Unique identifier for the DFMEA record. Primary key for the DFMEA analysis document.',
    `apqp_project_id` BIGINT COMMENT 'Reference to the parent APQP project under which this DFMEA is conducted. Links to APQP project master.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: A DFMEA evaluates a specific components failure modes; the FK provides direct association for risk analysis reports and regulatory compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DFMEA analysis costs are tracked against cost centers to monitor quality improvement spending.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: DFMEA analyses requested by a customer require linking to the customer_account to tie risk assessments to that customer.',
    `employee_id` BIGINT COMMENT 'Reference to the quality manager or engineering director who approved the DFMEA. Links to employee master. Null if not yet approved.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: DFMEA analyses are required for safety‑related regulations; linking records the applicable regulation.',
    `sku_master_id` BIGINT COMMENT 'Reference to the product or component being analyzed in this DFMEA. Links to the product master in PLM system.',
    `tertiary_dfmea_team_lead_employee_id` BIGINT COMMENT 'Reference to the engineer or quality professional leading the DFMEA team. Responsible for facilitating the analysis and ensuring completeness. Links to employee master.',
    `action_priority` STRING COMMENT 'Action Priority classification per VDA FMEA methodology. Determined by severity and occurrence/detection combination using the AP matrix. High = immediate action required, Medium = action should be taken, Low = action may be considered.. Valid values are `high|medium|low`',
    `action_status` STRING COMMENT 'Current status of the recommended action in its lifecycle. Open = not started, In Progress = work underway, Completed = action finished, Verified = effectiveness confirmed, Cancelled = action no longer required.. Valid values are `open|in_progress|completed|verified|cancelled`',
    `action_taken` STRING COMMENT 'Detailed description of the actual corrective or preventive action that was implemented. Documents what was done to address the failure mode.',
    `actual_completion_date` DATE COMMENT 'Actual date when the recommended action was completed and verified. Null if action is still open or in progress.',
    `analysis_date` DATE COMMENT 'Date when the DFMEA analysis was originally conducted or last updated. Represents the business event timestamp for the analysis session.',
    `approval_date` DATE COMMENT 'Date when the DFMEA document was formally approved by the quality or engineering authority. Null if not yet approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DFMEA record was first created in the system. Audit trail for data lineage and compliance.',
    `current_detection_controls` STRING COMMENT 'Design verification and validation controls currently in place to detect the failure mode or cause before release (e.g., design reviews, prototype testing, Computer-Aided Engineering (CAE) analysis, Design Verification Plan and Report (DVP&R)).',
    `current_prevention_controls` STRING COMMENT 'Design controls currently in place to prevent the failure cause from occurring (e.g., design rules, standards, simulations, Design for Manufacturability (DFM) guidelines, redundancy).',
    `customer_requirement_reference` STRING COMMENT 'Reference to specific customer requirements, specifications, or standards that drive this DFMEA analysis (e.g., customer FMEA requirements, industry standards, regulatory requirements).',
    `design_phase` STRING COMMENT 'The phase of the product design lifecycle when this DFMEA was conducted. Concept = early ideation, Preliminary = initial design, Detailed = final design, Validation = testing phase, Production = manufacturing release.. Valid values are `concept|preliminary|detailed|validation|production`',
    `detection_rating` STRING COMMENT 'Numerical rating (1-10) representing the likelihood that current design controls will detect the failure cause or mode before release to production. 10 = almost certain not to detect, 1 = almost certain to detect. Based on AIAG-VDA detection criteria.',
    `dfmea_number` STRING COMMENT 'Business identifier for the DFMEA document. Human-readable unique number assigned per organizational numbering convention.',
    `dfmea_status` STRING COMMENT 'Current lifecycle status of the DFMEA document. Draft = under development, In Review = undergoing team review, Approved = formally approved, Active = in use, Superseded = replaced by newer revision, Obsolete = no longer applicable.. Valid values are `draft|in_review|approved|active|superseded|obsolete`',
    `eco_number` STRING COMMENT 'Reference to the Engineering Change Order that triggered this DFMEA update or that resulted from DFMEA findings. Links to ECO master in PLM system.',
    `evidence_reference` STRING COMMENT 'Reference to supporting evidence, documentation, or test results that validate the action effectiveness (e.g., test report number, Engineering Change Order (ECO) number, validation protocol ID). Used for Production Part Approval Process (PPAP) evidence packages.',
    `failure_cause` STRING COMMENT 'The root cause or mechanism that leads to the failure mode. Describes why the failure occurs (e.g., design deficiency, material weakness, tolerance stack-up).',
    `failure_effect` STRING COMMENT 'The consequence or impact of the failure mode on the customer, end user, or downstream operations. Describes what the customer experiences.',
    `failure_mode` STRING COMMENT 'The manner in which the design item could potentially fail to meet the intended function. Describes how the failure manifests.',
    `item_function` STRING COMMENT 'The intended function or purpose of the design item being analyzed. Describes what the item is supposed to do under normal operating conditions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DFMEA record was last updated in the system. Audit trail for change tracking and compliance.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to this DFMEA entry. Captures team discussion points, assumptions, or contextual information.',
    `occurrence_rating` STRING COMMENT 'Numerical rating (1-10) representing the likelihood that the failure cause will occur during the design life. 10 = very high probability, 1 = remote probability. Based on AIAG-VDA occurrence criteria.',
    `recommended_action` STRING COMMENT 'Detailed description of the recommended corrective or preventive action to reduce severity, occurrence, or improve detection. May include design changes, additional testing, or enhanced controls.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this failure mode could result in non-compliance with regulatory requirements (e.g., UL, CE, OSHA, EPA). True = regulatory impact.',
    `revised_action_priority` STRING COMMENT 'Recalculated Action Priority per VDA methodology after action implementation. Should show improvement (e.g., High to Medium). Null if action not yet completed.. Valid values are `high|medium|low`',
    `revised_detection_rating` STRING COMMENT 'Updated detection rating (1-10) after corrective action implementation. Should decrease (improve) if detection controls were enhanced. Null if action not yet completed.',
    `revised_occurrence_rating` STRING COMMENT 'Updated occurrence rating (1-10) after corrective action implementation. Should decrease if prevention controls were improved. Null if action not yet completed.',
    `revised_rpn` STRING COMMENT 'Recalculated Risk Priority Number after action implementation: Revised S × Revised O × Revised D. Used to measure risk reduction effectiveness. Null if action not yet completed.',
    `revised_severity_rating` STRING COMMENT 'Updated severity rating (1-10) after corrective action implementation. Typically severity does not change unless design function is modified. Null if action not yet completed.',
    `revision` STRING COMMENT 'Revision level or version of the DFMEA document. Incremented when significant changes are made to the analysis (e.g., A, B, C or 1.0, 2.0).',
    `rpn` STRING COMMENT 'Risk Priority Number calculated as Severity × Occurrence × Detection (S × O × D). Used in traditional AIAG FMEA methodology to prioritize risks. Range: 1-1000.',
    `safety_related_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this failure mode has safety implications for the end user or operator. True = safety-related failure mode.',
    `scope_description` STRING COMMENT 'Detailed textual description of the design scope being analyzed, including boundaries, assumptions, and exclusions.',
    `scope_level` STRING COMMENT 'Hierarchical level at which the DFMEA analysis is performed: system (top-level product), subsystem (major assembly), component (individual part), or interface (interaction between elements).. Valid values are `system|subsystem|component|interface`',
    `severity_rating` STRING COMMENT 'Numerical rating (1-10) representing the seriousness of the failure effect on the customer. 10 = hazardous without warning, 1 = no effect. Based on AIAG-VDA severity criteria.',
    `special_characteristics_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this failure mode relates to a special characteristic (critical or significant product/process characteristic requiring additional controls). True = special characteristic involved.',
    `target_completion_date` DATE COMMENT 'Planned date by which the recommended action should be completed. Used for tracking and accountability in APQP timeline.',
    CONSTRAINT pk_dfmea PRIMARY KEY(`dfmea_id`)
) COMMENT 'Design Failure Mode and Effects Analysis record per AIAG/VDA FMEA methodology. Captures DFMEA number, scope (system, subsystem, component), failure mode, failure effect, failure cause, current design controls (prevention and detection), severity/occurrence/detection ratings, RPN, Action Priority (AP) per VDA method, recommended corrective/preventive actions with responsible engineer, target/completion dates, action status, evidence references, and revised ratings after action closure. Supports APQP deliverables, PPAP evidence packages, and continuous improvement tracking within the design engineering workflow.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` (
    `dfm_analysis_id` BIGINT COMMENT 'Unique identifier for the DFM analysis record. Primary key.',
    `dfmea_id` BIGINT COMMENT 'Reference to a related DFMEA record if the DFM analysis is linked to a design failure mode assessment.',
    `employee_id` BIGINT COMMENT 'Reference to the manufacturing engineer or DFM analyst who performed the analysis.',
    `engineering_revision_id` BIGINT COMMENT 'Reference to the specific component or assembly design revision being evaluated for manufacturability.',
    `fmea_id` BIGINT COMMENT 'Reference to a related PFMEA record if the DFM analysis is linked to a process failure mode assessment.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: DFM FEEDBACK: Supplier feedback on manufacturability is captured to drive design iteration decisions.',
    `actual_resolution_date` DATE COMMENT 'Actual date when the DFM issue was resolved or closed.',
    `affected_feature` STRING COMMENT 'Specific design feature, dimension, tolerance, or characteristic that is causing the manufacturability concern.',
    `alternative_solution` STRING COMMENT 'Alternative approaches or workarounds if the recommended design modification is not feasible (e.g., process change, tooling investment, supplier change).',
    `analysis_number` BOOLEAN COMMENT 'Business identifier for the DFM analysis, typically following organizational numbering convention (e.g., DFM-000012345).',
    `analysis_type` BOOLEAN COMMENT 'Classification of the DFM analysis trigger or purpose (e.g., initial design review, design change review, cost reduction review).',
    `analyst_name` STRING COMMENT 'Name of the manufacturing engineer or DFM analyst who conducted the review.',
    `approval_date` DATE COMMENT 'Date when the DFM analysis disposition or recommended action was formally approved.',
    `approval_required` BOOLEAN COMMENT 'Flag indicating whether formal approval is required before implementing the recommended design modification.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the DFM analysis disposition or recommended action.',
    `cost_impact_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the estimated cost impact (e.g., USD, EUR, CNY).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DFM analysis record was first created in the system.',
    `dfm_issue_detail` STRING COMMENT 'Detailed description of the specific manufacturability issues, constraints, or risks identified during the analysis.',
    `dfm_issue_summary` STRING COMMENT 'High-level summary of the identified DFM issues or concerns with the current design.',
    `disposition_rationale` DECIMAL(18,2) COMMENT 'Justification or reasoning for the disposition decision (e.g., why design change is required, why accepted as-is).',
    `disposition_status` STRING COMMENT 'Current status of the DFM analysis: open (pending review), under_review (being evaluated), design_change_required (ECO initiated), accepted_as_is (no change needed), closed (resolved), cancelled (no longer applicable).. Valid values are `open|under_review|design_change_required|accepted_as_is|closed|cancelled`',
    `eco_initiated` BOOLEAN COMMENT 'Flag indicating whether an Engineering Change Order was initiated as a result of this DFM analysis.',
    `eco_number` STRING COMMENT 'Reference number of the ECO initiated to address the DFM findings, if applicable.',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the DFM issue if not addressed, including increased manufacturing cost, scrap, rework, or yield loss.',
    `estimated_cost_savings` DECIMAL(18,2) COMMENT 'Projected cost savings if the recommended design modification is implemented.',
    `impact_on_lead_time` TIMESTAMP COMMENT 'Assessment of how the DFM issue or recommended change affects manufacturing lead time.',
    `impact_on_quality` STRING COMMENT 'Assessment of how the DFM issue or recommended change affects product quality and conformance.. Valid values are `improves_quality|no_impact|degrades_quality`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the DFM analysis record was last updated.',
    `manufacturing_process_scope` STRING COMMENT 'Primary manufacturing process or processes being evaluated in this DFM analysis (e.g., machining, casting, stamping, PCB assembly). [ENUM-REF-CANDIDATE: machining|casting|stamping|forging|injection_molding|pcb_assembly|sheet_metal_fabrication|welding|additive_manufacturing|assembly|multi_process — 11 candidates stripped; promote to reference product]',
    `manufacturing_site` STRING COMMENT 'Manufacturing facility or site where the component will be produced, relevant to the DFM analysis.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the DFM analysis.',
    `part_name` STRING COMMENT 'Descriptive name of the component or assembly being analyzed.',
    `part_number` STRING COMMENT 'The part number of the component or assembly under DFM review.',
    `priority` STRING COMMENT 'Priority level assigned to the DFM analysis for resolution: urgent (immediate action), high (near-term action), medium (planned action), low (monitor).. Valid values are `urgent|high|medium|low`',
    `process_constraint` STRING COMMENT 'Description of the manufacturing process constraint or limitation that the design violates or challenges (e.g., tool access, tolerance capability, material flow).',
    `product_line` STRING COMMENT 'Product line or family to which the component belongs (e.g., automation systems, electrification solutions).',
    `recommended_design_modification` STRING COMMENT 'Proposed design changes or modifications to resolve the DFM issue and improve manufacturability.',
    `review_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the DFM analysis was completed and documented.',
    `review_date` DATE COMMENT 'Date when the DFM analysis was performed.',
    `revision_level` STRING COMMENT 'Design revision level of the component at the time of DFM analysis (e.g., A, B, C, Rev 01).',
    `risk_priority_number` STRING COMMENT 'Calculated risk priority number based on severity, occurrence, and detection ratings (typical FMEA methodology applied to DFM).',
    `severity_classification` STRING COMMENT 'Severity level of the identified DFM issue: critical (cannot manufacture), major (significant cost/quality impact), moderate (manageable impact), minor (low impact), informational (observation only).. Valid values are `critical|major|moderate|minor|informational`',
    `supplier_feedback` DECIMAL(18,2) COMMENT 'Input or feedback from manufacturing suppliers or contract manufacturers regarding the design manufacturability.',
    `target_resolution_date` DATE COMMENT 'Target date by which the DFM issue should be resolved or design change implemented.',
    `tooling_requirement` STRING COMMENT 'Description of any special tooling, fixtures, or equipment required to manufacture the design as-is or with the recommended modification.',
    CONSTRAINT pk_dfm_analysis PRIMARY KEY(`dfm_analysis_id`)
) COMMENT 'Design for Manufacturability analysis record evaluating a component or assembly design against manufacturing process constraints. Captures DFM analysis number, reviewed component revision, manufacturing process scope (machining, casting, stamping, PCB assembly), identified DFM issues, severity classification, recommended design modifications, estimated cost impact of non-conformance, analyst, review date, and disposition status. Feeds back into ECO initiation when design changes are required.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` (
    `engineering_specification_id` BIGINT COMMENT 'Unique identifier for the engineering specification document record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Specification author is tracked for regulatory compliance and change‑traceability in the specification control process.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Specification applies to a component; adding component_id FK normalizes the relationship and removes the denormalized linked_component_ids list.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑specific specifications are maintained for contract compliance; linking to customer_account enables specification‑customer mapping.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Specifications are authored to meet particular regulatory standards; linking ties each spec to its governing requirement.',
    `superseded_by_specification_engineering_specification_id` BIGINT COMMENT 'Reference to the specification that supersedes this specification. Null if this specification is still current. Supports specification revision history and traceability.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: SPECIFICATION CONTROL: Supplier‑specific specifications are linked to the responsible supplier for qualification and audit reporting.',
    `acceptance_criteria` STRING COMMENT 'Specific criteria and test methods used to determine whether a component or assembly meets the specification requirements. Defines pass/fail thresholds for inspection, testing, and validation activities.',
    `applicable_standards` STRING COMMENT 'Comma-separated list of industry, regulatory, and international standards that this specification must comply with (e.g., IEC 61131, ISO 9001, UL 508, CE Marking, ANSI standards). Critical for design validation, supplier qualification, and regulatory compliance.',
    `approval_date` DATE COMMENT 'Date when the specification was formally approved and released for use. Key milestone in the Product Lifecycle Management (PLM) workflow.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the specification document: draft (initial creation), in_review (under engineering review), approved (released for use), obsolete (no longer valid), or superseded (replaced by newer revision or specification).. Valid values are `draft|in_review|approved|obsolete|superseded`',
    `approver_name` STRING COMMENT 'Name of the authorized individual who approved the specification for release. Part of the document control and approval workflow.',
    `change_reason` STRING COMMENT 'Textual description of the reason for the most recent change to the specification. Captures the business or technical justification for the revision, supporting change traceability and audit requirements.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the specification document: public (no restrictions), internal (internal use only), confidential (business-sensitive), or restricted (highly sensitive, limited access). Governs access control and distribution policies.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was first created in the Product Lifecycle Management (PLM) system. Supports audit trail and data lineage requirements.',
    `design_authority` STRING COMMENT 'Name or identifier of the engineering team, department, or individual responsible for the technical content and maintenance of this specification. Serves as the point of contact for specification-related questions and change requests.',
    `dfm_analysis_completed` BOOLEAN COMMENT 'Indicates whether a Design for Manufacturability (DFM) analysis has been completed for this specification. DFM analysis ensures that the design can be efficiently and cost-effectively manufactured.',
    `dfmea_reference` STRING COMMENT 'Reference identifier or document link to the Design Failure Mode and Effects Analysis (DFMEA) associated with this specification. DFMEA identifies potential failure modes in the design and their effects on product performance and safety.',
    `document_format` STRING COMMENT 'File format of the specification document (e.g., PDF for released documents, DOCX for drafts, DWG for CAD drawings, STEP/IGES for 3D models, XML for structured data exchange).. Valid values are `PDF|DOCX|DWG|STEP|IGES|XML`',
    `document_location` STRING COMMENT 'File path, URL, or document management system reference where the full specification document is stored. Typically points to a location in Siemens Teamcenter PLM Document Management or a shared engineering repository.',
    `ecn_number` STRING COMMENT 'Engineering Change Notice (ECN) number associated with the notification of the change to this specification. ECNs communicate approved changes to stakeholders and trigger updates to related documentation and systems.. Valid values are `^ECN-[A-Z0-9]{6,15}$`',
    `eco_number` STRING COMMENT 'Engineering Change Order (ECO) number associated with the most recent change to this specification. Links the specification to the formal change management process and provides traceability to the reason for the change.. Valid values are `^ECO-[A-Z0-9]{6,15}$`',
    `effective_date` DATE COMMENT 'Date when the specification becomes effective and mandatory for use in design, procurement, and manufacturing activities. Aligns with Product Lifecycle Management (PLM) release workflows.',
    `environmental_conditions` STRING COMMENT 'Specified environmental operating conditions and limits, including temperature range, humidity, vibration, shock, altitude, and exposure to chemicals or contaminants. Critical for environmental-type specifications.',
    `language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language of the specification document (e.g., ENG for English, DEU for German, FRA for French). Supports multi-language engineering documentation in global manufacturing operations.. Valid values are `^[A-Z]{3}$`',
    `material_standard` STRING COMMENT 'Specific material standard or grade required for the component or assembly (e.g., ASTM A36, SAE 304, ISO 898-1). Applicable primarily to material-type specifications.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified the specification record in the PLM system. Tracks responsibility for the most recent change.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was last modified in the Product Lifecycle Management (PLM) system. Tracks the most recent update to the record for audit and change tracking purposes.',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications related to the specification. Captures supplementary information that does not fit into other structured fields.',
    `obsolete_date` DATE COMMENT 'Date when the specification was marked as obsolete or superseded. Null if the specification is still active.',
    `performance_criteria` STRING COMMENT 'Detailed performance requirements and acceptance criteria that the component, assembly, or system must meet. Includes quantitative metrics such as load capacity, operating temperature range, voltage ratings, cycle life, and reliability targets.',
    `pfmea_reference` STRING COMMENT 'Reference identifier or document link to the Process Failure Mode and Effects Analysis (PFMEA) associated with this specification. PFMEA identifies potential failure modes in the manufacturing process and their effects on product quality.',
    `prototype_required` BOOLEAN COMMENT 'Indicates whether a prototype must be built and validated before the specification is approved for production use. Supports the Advanced Product Quality Planning (APQP) and Production Part Approval Process (PPAP) workflows.',
    `revision` STRING COMMENT 'Current revision level of the specification document, typically alphanumeric (e.g., A, B, C, 01, 02). Incremented with each approved change through the Engineering Change Order (ECO) or Engineering Change Notice (ECN) process.. Valid values are `^[A-Z0-9]{1,10}$`',
    `safety_requirements` STRING COMMENT 'Safety-related requirements and compliance criteria, including electrical safety, mechanical safety, functional safety, and hazard mitigation measures. Applicable to safety-type specifications and critical for certification.',
    `scope_description` STRING COMMENT 'Detailed description of the scope, applicability, and boundaries of the specification. Defines what is covered and what is explicitly excluded from the specification requirements.',
    `specification_number` STRING COMMENT 'Business identifier for the specification document, typically following organizational numbering conventions. Externally-known unique code used for reference in engineering documentation, supplier communications, and design reviews.. Valid values are `^[A-Z0-9]{3,20}$`',
    `specification_type` STRING COMMENT 'Classification of the specification document by its primary purpose: material (material properties and composition), functional (operational requirements), interface (connection and integration standards), environmental (operating conditions and environmental compliance), safety (safety requirements and certifications), or performance (performance criteria and benchmarks).. Valid values are `material|functional|interface|environmental|safety|performance`',
    `supplier_qualification_required` BOOLEAN COMMENT 'Indicates whether suppliers must undergo formal qualification and approval before being authorized to supply components or materials meeting this specification. Supports supplier management and procurement processes.',
    `test_method` STRING COMMENT 'Standardized test method or procedure reference used to verify compliance with the specification (e.g., ASTM test methods, IEC test standards, internal test procedures). Links to quality inspection plans and validation protocols.',
    `title` STRING COMMENT 'Descriptive title of the specification document that clearly identifies the component, assembly, or system being specified.',
    `tolerance_specification` STRING COMMENT 'Dimensional, geometric, and functional tolerances specified for the component or assembly. Defines acceptable variation ranges for critical dimensions and characteristics, supporting Design for Manufacturability (DFM) and Statistical Process Control (SPC).',
    `validation_date` DATE COMMENT 'Date when the design validation was completed. Null if validation is not yet complete. Key milestone in the product development lifecycle.',
    `validation_status` STRING COMMENT 'Current status of the design validation and verification activities for this specification: not_started (validation not yet initiated), in_progress (validation activities underway), completed (validation successfully completed), or failed (validation did not meet acceptance criteria).. Valid values are `not_started|in_progress|completed|failed`',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the specification record in the PLM system. Supports accountability and audit trail requirements.',
    CONSTRAINT pk_engineering_specification PRIMARY KEY(`engineering_specification_id`)
) COMMENT 'Engineering specification document record defining technical requirements, performance criteria, material standards, and acceptance criteria for a component, assembly, or system. Captures specification number, revision, specification type (material, functional, interface, environmental, safety), applicable standards (IEC, ISO, UL, CE), scope description, approval status, and linked components. Serves as the authoritative technical requirements baseline for design validation and supplier qualification.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` (
    `design_review_id` BIGINT COMMENT 'Unique identifier for the design review event. Primary key for the design review record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Design review chairperson is required for governance minutes and compliance sign‑off tracking.',
    `control_plan_id` BIGINT COMMENT 'Foreign key reference to the control plan reviewed or approved during this design review. Links design review to quality control planning.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Design review effort costs are charged to cost centers for accurate project cost accounting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Design reviews often include customer stakeholders; linking design_review to customer_account records participation and decisions.',
    `dfmea_id` BIGINT COMMENT 'Foreign key reference to the DFMEA document reviewed or updated during this design review. Links design review to formal risk analysis.',
    `engineering_project_id` BIGINT COMMENT 'Foreign key reference to the parent engineering project or APQP project under which this design review is conducted.',
    `fmea_id` BIGINT COMMENT 'Foreign key reference to the PFMEA document reviewed or updated during this design review. Links design review to process risk analysis.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Design Review governance requires linking each review to its governing project for compliance tracking and gate decision reporting.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Design reviews verify compliance with regulatory requirements; the FK records which requirement is being reviewed.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: DESIGN REVIEW: Supplier participation is recorded to satisfy compliance and capture supplier‑driven design changes.',
    `action_item_count` STRING COMMENT 'Total number of action items generated from the design review. Used for tracking review effectiveness and closure metrics.',
    `action_items` STRING COMMENT 'Structured list of action items generated during the design review, typically stored as JSON or delimited text. Each action item includes description, category, assignee, due date, status, and resolution.',
    `approval_date` DATE COMMENT 'Date on which the design review was formally approved by management or designated authority. Represents gate closure date.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal management approval is required to close this design review gate. True=approval required, False=no approval required.',
    `approver_name` STRING COMMENT 'Full name of the individual who provided formal approval for the design review gate closure. Typically a senior engineering manager or program manager.',
    `apqp_phase` STRING COMMENT 'APQP phase to which this design review is linked. Phase 1=Plan and Define, Phase 2=Product Design and Development, Phase 3=Process Design and Development, Phase 4=Product and Process Validation, Phase 5=Launch Feedback and Corrective Action.. Valid values are `phase_1|phase_2|phase_3|phase_4|phase_5`',
    `attendee_count` STRING COMMENT 'Total number of individuals who attended the design review meeting. Used for quorum validation and meeting effectiveness metrics.',
    `attendee_list` STRING COMMENT 'Comma-separated or semicolon-separated list of attendee names who participated in the design review. Provides audit trail of review participants.',
    `compliance_requirements` STRING COMMENT 'List of regulatory, safety, and industry compliance requirements evaluated during the design review (e.g., UL, CE, IEC 61131, ISO 9001). Stored as delimited text or JSON.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the design against applicable regulatory and industry requirements as assessed during the review.. Valid values are `compliant|non_compliant|pending_verification|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design review record was first created in the system. Audit trail for record creation.',
    `criteria_fail_count` STRING COMMENT 'Number of gate criteria that received a fail status during the review. Indicates areas requiring corrective action before gate closure.',
    `criteria_na_count` STRING COMMENT 'Number of gate criteria marked as not applicable for this specific review. Used to adjust compliance calculations.',
    `criteria_pass_count` STRING COMMENT 'Number of gate criteria that received a pass status during the review. Used to calculate gate compliance percentage.',
    `design_maturity_level` STRING COMMENT 'Maturity level of the design at the time of review. Concept=early ideation, Preliminary=initial design, Detailed=fully specified, Final=pre-release, Released=production-ready.. Valid values are `concept|preliminary|detailed|final|released`',
    `design_validation_status` STRING COMMENT 'Status of design validation activities (customer/user testing) at the time of the design review. Indicates whether design meets intended use requirements.. Valid values are `not_started|in_progress|completed|failed`',
    `design_verification_status` STRING COMMENT 'Status of design verification activities (testing, analysis, inspection) at the time of the design review. Indicates whether design meets specified requirements.. Valid values are `not_started|in_progress|completed|failed`',
    `document_references` STRING COMMENT 'List of supporting documents reviewed during the design review (e.g., CAD drawings, specifications, test reports, FMEA documents). Stored as delimited text or JSON with document IDs and titles.',
    `ecn_number` STRING COMMENT 'Engineering Change Notice number associated with this design review, if the review was triggered by or resulted in an ECN. Links design review to change notification process.',
    `eco_number` STRING COMMENT 'Engineering Change Order number associated with this design review, if the review was triggered by or resulted in an ECO. Links design review to change management process.',
    `gate_criteria_checklist` STRING COMMENT 'Structured checklist of gate criteria evaluated during the review, typically stored as JSON or delimited text. Each criterion includes pass/fail/NA status and comments.',
    `gate_decision` STRING COMMENT 'Final decision outcome of the design review gate. Pass=approved to proceed, Conditional Pass=approved with conditions/action items, Fail=not approved, Deferred=decision postponed pending additional information.. Valid values are `pass|conditional_pass|fail|deferred`',
    `gate_decision_date` DATE COMMENT 'Date on which the formal gate decision was rendered. May differ from review_date if decision was deferred or required additional deliberation.',
    `meeting_duration_minutes` DECIMAL(18,2) COMMENT 'Duration of the design review meeting in minutes. Used for resource planning and meeting effectiveness analysis.',
    `meeting_location` STRING COMMENT 'Physical or virtual location where the design review meeting was conducted (e.g., conference room, site name, or virtual meeting platform).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this design review record was last modified. Audit trail for record updates.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next design review or follow-up review. Used for planning subsequent gate reviews in the product development lifecycle.',
    `open_action_item_count` STRING COMMENT 'Number of action items from this design review that remain open/unresolved. Used to track gate closure readiness.',
    `review_date` DATE COMMENT 'Date on which the formal design review meeting was conducted. Represents the principal business event timestamp for the review gate.',
    `review_number` STRING COMMENT 'Business identifier for the design review event, typically following organizational numbering convention (e.g., DR-2024-001234). Used for external reference and traceability.. Valid values are `^DR-[0-9]{6,10}$`',
    `review_status` STRING COMMENT 'Current lifecycle status of the design review event. Tracks whether the review is scheduled, actively being conducted, completed, cancelled, or postponed.. Valid values are `scheduled|in_progress|completed|cancelled|postponed`',
    `review_summary` STRING COMMENT 'Executive summary of the design review outcomes, key findings, and recommendations. Provides high-level overview for stakeholders.',
    `review_type` STRING COMMENT 'Type of design review gate conducted. PDR=Preliminary Design Review, CDR=Critical Design Review, PRR=Production Readiness Review, TRR=Test Readiness Review, FDR=Final Design Review, MDR=Manufacturing Design Review.. Valid values are `PDR|CDR|PRR|TRR|FDR|MDR`',
    `reviewed_item_description` STRING COMMENT 'Textual description of the item, assembly, or product being reviewed. Provides human-readable context for the reviewed design.',
    `reviewed_item_number` STRING COMMENT 'Part number, assembly number, or product identifier of the item/design being reviewed. Links to the engineering item under evaluation.',
    `reviewed_item_revision` STRING COMMENT 'Revision level of the item/design being reviewed at the time of the design review (e.g., A, B, C, Rev 01). Ensures traceability to specific design iteration.',
    `risk_assessment_summary` STRING COMMENT 'Summary of design risks identified during the review, including risk severity, mitigation plans, and residual risk levels. Links to DFMEA/PFMEA where applicable.',
    CONSTRAINT pk_design_review PRIMARY KEY(`design_review_id`)
) COMMENT 'Formal design review event record capturing structured gate reviews conducted during the product development lifecycle (PDR, CDR, PRR, TRR). Tracks review type, review date, reviewed item/assembly, attendees, gate decision (pass, conditional pass, fail), gate criteria checklist results, linked APQP phase, and embedded action items (description, category, assignee, due date, status, resolution). Provides the audit trail required for ISO 9001 design and development verification and APQP phase gate closure.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` (
    `engineering_project_id` BIGINT COMMENT 'Unique identifier for the engineering project record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Projects are budgeted to specific cost centers for expense tracking and variance analysis.',
    `site_id` BIGINT COMMENT 'Reference to the primary engineering facility or R&D center where the project work is being performed.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Each engineering project references a budget record for approved spending limits and forecasting.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Capital project expenditures are captured via internal orders for capex tracking and settlement.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or division that owns and funds the engineering project.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and delivering the engineering project.',
    `family_id` BIGINT COMMENT 'Reference to the product family or platform that this engineering project is developing or enhancing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Project revenue and profitability are reported to profit centers for segment performance reporting.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Required for Capital Project Integration Report linking engineering project to overall project schedule, enabling consolidated status and cost tracking across engineering and project management.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Projects are often launched to achieve compliance with a new or updated regulatory requirement.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: PROJECT MANAGEMENT: Engineering projects track a lead supplier for budgeting, risk assessment, and contract governance.',
    `actual_launch_date` DATE COMMENT 'Actual date when the engineering project completed and the product was launched to production or market.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the engineering project for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the engineering project was formally approved for execution.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated to the engineering project for all development activities and resources.',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the project budget amounts.',
    `budget_spent_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of budget spent to date on the engineering project.',
    `business_justification` STRING COMMENT 'Strategic rationale and business case for undertaking the engineering project, including expected ROI and market drivers.',
    `capex_opex_classification` STRING COMMENT 'Financial classification of the project budget as capital expenditure, operational expenditure, or a mix of both.. Valid values are `capex|opex|mixed`',
    `collaboration_partners` DECIMAL(18,2) COMMENT 'List of external partners, suppliers, or research institutions collaborating on the engineering project.',
    `complexity_score` STRING COMMENT 'Numerical score (1-10) representing the technical and organizational complexity of the engineering project.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the engineering project record was first created in the system.',
    `design_methodology` STRING COMMENT 'Engineering design and development methodology being applied to the project.. Valid values are `agile|waterfall|stage_gate|lean|concurrent_engineering`',
    `design_review_count` STRING COMMENT 'Number of formal design reviews conducted during the engineering project lifecycle.',
    `dfm_analysis_completed` BOOLEAN COMMENT 'Indicates whether Design for Manufacturability analysis has been completed for the engineering project.',
    `dfmea_completed` BOOLEAN COMMENT 'Indicates whether Design Failure Mode and Effects Analysis has been completed for the engineering project.',
    `eco_count` STRING COMMENT 'Total number of Engineering Change Orders issued during the engineering project.',
    `end_date` DATE COMMENT 'Date when the engineering project was officially closed or completed.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the engineering project record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the engineering project record was last modified in the system.',
    `patent_application_count` STRING COMMENT 'Number of patent applications filed as a result of innovations developed in the engineering project.',
    `pfmea_completed` BOOLEAN COMMENT 'Indicates whether Process Failure Mode and Effects Analysis has been completed for the engineering project.',
    `ppap_required` BOOLEAN COMMENT 'Indicates whether Production Part Approval Process is required for the engineering project deliverables.',
    `priority_level` STRING COMMENT 'Business priority ranking assigned to the engineering project for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `program_phase` STRING COMMENT 'Current lifecycle phase of the engineering project within the product development process. [ENUM-REF-CANDIDATE: concept|feasibility|design|development|validation|launch|production|closed — 8 candidates stripped; promote to reference product]',
    `project_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the engineering project for identification and tracking across systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `project_description` STRING COMMENT 'Detailed narrative description of the engineering project objectives, scope, and deliverables.',
    `project_name` STRING COMMENT 'Human-readable name of the engineering project describing the initiative or product being developed.',
    `project_status` STRING COMMENT 'Current operational status of the engineering project indicating its execution state.. Valid values are `active|on_hold|cancelled|completed|archived`',
    `project_type` STRING COMMENT 'Classification of the engineering project based on its strategic purpose and scope.. Valid values are `new_product_development|product_improvement|platform_development|cost_reduction|sustaining_engineering|technology_research`',
    `prototype_count` STRING COMMENT 'Number of physical or digital prototypes developed as part of the engineering project.',
    `regulatory_compliance_scope` STRING COMMENT 'List of regulatory standards and certifications that the engineering project must comply with (e.g., ISO 9001, CE, UL, IEC 61131).',
    `risk_level` STRING COMMENT 'Overall risk assessment level for the engineering project based on technical complexity, schedule, and resource constraints.. Valid values are `low|medium|high|critical`',
    `start_date` DATE COMMENT 'Date when the engineering project was officially initiated and work began.',
    `sustainability_target` STRING COMMENT 'Environmental sustainability goals and targets for the engineering project (e.g., energy efficiency, carbon reduction, recyclability).',
    `target_launch_date` DATE COMMENT 'Planned date for the engineering project to complete development and transition to production or market launch.',
    `target_market_segment` STRING COMMENT 'Primary market segment or customer group that the engineering project is designed to serve.',
    `team_size_count` STRING COMMENT 'Number of engineers and team members assigned to the engineering project.',
    `technology_platform` STRING COMMENT 'Core technology platform or architecture that the engineering project is based on (e.g., PLC, SCADA, IoT, IIoT).',
    `created_by` STRING COMMENT 'User ID or name of the person who created the engineering project record.',
    CONSTRAINT pk_engineering_project PRIMARY KEY(`engineering_project_id`)
) COMMENT 'Engineering project master record representing a discrete R&D or product development initiative. Captures project code, project name, project type (new product development, product improvement, platform, cost reduction), program phase (concept, development, validation, launch), target launch date, project manager, budget allocation, priority, and linked product family. Serves as the organizing entity for all engineering deliverables, prototypes, and design reviews within a development program.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` (
    `certification_requirement_id` BIGINT COMMENT 'Unique identifier for the certification requirement record. Primary key.',
    `component_id` BIGINT COMMENT 'Reference to the specific component requiring certification, if applicable at component level.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Certification activities incur costs that must be allocated to the responsible cost center for compliance budgeting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Certification requirements may be driven by a specific customer’s market; linking captures customer‑driven compliance needs.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Certification requirements are derived directly from specific regulatory requirements; the FK captures that source.',
    `sku_master_id` BIGINT COMMENT 'Reference to the product or component that requires this certification.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: CERTIFICATION: The supplier responsible for meeting a certification requirement is linked for regulatory compliance tracking.',
    `test_result_id` BIGINT COMMENT 'Reference to the prototype test activity linked to this certification requirement.',
    `actual_completion_date` DATE COMMENT 'Actual date when certification was achieved or testing was completed.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual total cost incurred for achieving this certification, populated after completion.',
    `actual_start_date` DATE COMMENT 'Actual date when certification activities and testing commenced.',
    `certificate_expiry_date` DATE COMMENT 'Date when the certification expires and requires renewal or re-certification.',
    `certificate_issue_date` DATE COMMENT 'Date when the certification certificate was officially issued.',
    `certificate_number` STRING COMMENT 'Official certificate or approval number issued by the certification body upon successful completion.',
    `certification_body` STRING COMMENT 'Name of the accredited certification body or testing laboratory responsible for issuing the certification (e.g., UL, TÜV, CSA, Intertek, Bureau Veritas).',
    `certification_body_accreditation` DECIMAL(18,2) COMMENT 'Accreditation standard or authority under which the certification body operates (e.g., ANAB, UKAS, DAkkS).',
    `certification_priority` STRING COMMENT 'Business priority level for achieving this certification based on market access criticality and project timeline.. Valid values are `critical|high|medium|low`',
    `certification_type` STRING COMMENT 'Category of certification required (product safety, environmental compliance, quality management, cybersecurity, electromagnetic compatibility, functional safety).. Valid values are `product_safety|environmental|quality|cybersecurity|electromagnetic_compatibility|functional_safety`',
    `compliance_status` STRING COMMENT 'Current status of compliance with this certification requirement (not started, planning, testing in progress, testing complete, certified, non-compliant, waived, deferred). [ENUM-REF-CANDIDATE: not_started|planning|testing_in_progress|testing_complete|certified|non_compliant|waived|deferred — 8 candidates stripped; promote to reference product]',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the estimated cost amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification requirement record was first created in the system.',
    `ecn_number` STRING COMMENT 'Engineering Change Notice number associated with this certification requirement.',
    `eco_number` STRING COMMENT 'Engineering Change Order number that triggered or modified this certification requirement.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated total cost for achieving this certification, including testing fees, certification body fees, and related expenses.',
    `estimated_lead_time_days` STRING COMMENT 'Estimated number of calendar days required to complete testing and obtain certification from submission to approval.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this certification is legally mandatory for market release (True) or optional/recommended (False).',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this certification requirement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification requirement record was last modified.',
    `non_compliance_impact` STRING COMMENT 'Description of business impact if this certification is not achieved (e.g., market access blocked, product recall, legal penalties).',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this certification requirement.',
    `planned_completion_date` DATE COMMENT 'Target date for achieving certification approval.',
    `planned_start_date` DATE COMMENT 'Planned date to begin certification activities and testing.',
    `regulation_standard` STRING COMMENT 'The specific regulation, standard, or directive that mandates this certification (e.g., CE Marking, UL 508A, IEC 61131-2, IEC 62443-4-1, RoHS, REACH, ISO 9001).',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals or re-certifications.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether periodic renewal or re-certification is required to maintain compliance.',
    `requirement_code` STRING COMMENT 'Unique business identifier code for the certification requirement within the engineering project.. Valid values are `^[A-Z0-9]{4,20}$`',
    `requirement_name` STRING COMMENT 'Descriptive name of the certification requirement.',
    `responsible_department` STRING COMMENT 'Engineering department or organizational unit responsible for this certification.',
    `responsible_engineer` STRING COMMENT 'Name or identifier of the engineer responsible for managing this certification requirement.',
    `risk_level` STRING COMMENT 'Risk level associated with non-compliance or failure to achieve this certification (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `standard_version` STRING COMMENT 'Version or edition of the regulation or standard applicable to this requirement.',
    `target_country_code` STRING COMMENT 'Three-letter ISO country code for the specific country requiring this certification.. Valid values are `^[A-Z]{3}$`',
    `target_market` STRING COMMENT 'Geographic market or region where this certification is required (e.g., European Union, United States, China, Global).',
    `test_specification` STRING COMMENT 'Detailed specification or protocol defining the test procedures and acceptance criteria.',
    `test_type` STRING COMMENT 'Type of testing or assessment required to achieve certification (type testing, routine testing, witness testing, factory acceptance test, site acceptance test, conformity assessment).. Valid values are `type_testing|routine_testing|witness_testing|factory_acceptance_test|site_acceptance_test|conformity_assessment`',
    `waiver_approval_date` DATE COMMENT 'Date when the waiver or deferral was officially approved.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the authority who approved the waiver or deferral.',
    `waiver_justification` STRING COMMENT 'Business justification if this certification requirement has been waived or deferred.',
    `created_by` STRING COMMENT 'User identifier of the person who created this certification requirement record.',
    CONSTRAINT pk_certification_requirement PRIMARY KEY(`certification_requirement_id`)
) COMMENT 'Engineering certification and regulatory compliance requirement record defining the mandatory certifications, standards, and approvals a product or component must achieve before market release. Captures requirement code, applicable regulation or standard (CE, UL, IEC 61131, IEC 62443, RoHS, REACH), target market or region, certification body, required test type, estimated lead time, cost estimate, and current compliance status. Drives certification planning within engineering projects and links to prototype test activities.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Unique identifier for the engineering test result record. Primary key for the test result entity.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to project.project_activity. Business justification: Test execution is scheduled as a project activity; linking test results to the activity enables traceability in the Project Execution Dashboard.',
    `component_id` BIGINT COMMENT 'Reference to the component or product master record being tested. Links test result to the engineering item definition in PLM system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Test expenses are allocated to cost centers to track R&D cost consumption per department.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Acceptance test results are recorded per customer; linking test_result to customer_account supports customer‑specific quality reports.',
    `dfmea_id` BIGINT COMMENT 'Reference to the linked DFMEA record if the test result validates or identifies a design failure mode. Connects test evidence to risk analysis.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the primary test equipment or instrumentation used. Links to calibrated equipment register for measurement traceability.',
    `fmea_id` BIGINT COMMENT 'Reference to the linked PFMEA record if the test result validates or identifies a process failure mode. Connects test evidence to manufacturing risk analysis.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Quality Assurance links test results to the specific production batch for traceability and regulatory compliance.',
    `original_test_result_id` BIGINT COMMENT 'Reference to the original test result record if this is a retest. Creates traceability chain for test iterations.',
    `ppap_submission_id` BIGINT COMMENT 'Reference to the PPAP submission package that includes this test result as evidence. Links test data to customer approval documentation.',
    `project_document_id` BIGINT COMMENT 'Identifier or reference to the formal test report document stored in the document management system. Links structured test data to detailed report artifacts.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Test results are captured to demonstrate conformity to a specific regulatory requirement.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: TESTING: When a supplier provides test services or equipment, the test result records the supplier for cost and accountability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Test execution accountability; test reports reference the responsible test engineer for quality audits.',
    `acceptance_criteria_lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the test measurement. Defines the lower boundary of the pass/fail acceptance range.',
    `acceptance_criteria_target` DECIMAL(18,2) COMMENT 'Target or nominal value for the test measurement. Represents the ideal design specification value within the acceptance range.',
    `acceptance_criteria_upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the test measurement. Defines the upper boundary of the pass/fail acceptance range.',
    `build_number` STRING COMMENT 'Prototype build iteration number or production batch identifier. Tracks which manufacturing build or prototype iteration the tested unit belongs to.',
    `certification_body` STRING COMMENT 'Name of the regulatory or certification authority for which this test evidence is required (e.g., UL, TUV, CSA, FCC). Applicable when regulatory submission flag is true.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was first created in the system. Audit trail for record lifecycle tracking.',
    `dvp_r_reference` STRING COMMENT 'Reference to the Design Verification Plan and Report document that governs this test. Links test execution to the master validation plan.',
    `eco_number` STRING COMMENT 'Engineering change order number if this test result triggered or validated a design change. Links test evidence to change management process.',
    `environmental_conditions` STRING COMMENT 'Description of environmental conditions during test execution (e.g., temperature, humidity, pressure). Captures test environment context for result interpretation.',
    `failure_description` STRING COMMENT 'Detailed narrative description of any failure, defect, or non-conformance observed during the test. Captures failure mode, symptoms, and conditions. Populated only when test outcome is fail or conditional pass.',
    `failure_mode_code` STRING COMMENT 'Standardized code or identifier for the observed failure mode. Links test failure to DFMEA or PFMEA failure mode catalog for root cause analysis.',
    `measured_value` DECIMAL(18,2) COMMENT 'Primary quantitative measurement or test result value obtained during the test. The principal measured outcome of the test activity.',
    `measured_value_unit` DECIMAL(18,2) COMMENT 'Unit of measure for the measured value (e.g., volts, amps, degrees Celsius, newtons, cycles). Ensures correct interpretation of test measurements.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Quantified uncertainty or tolerance associated with the measured value. Expresses the confidence interval or margin of error in the measurement.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this test result record. Audit trail for record changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was last modified in the system. Audit trail for record lifecycle tracking.',
    `prototype_phase` STRING COMMENT 'Development phase or maturity stage of the tested unit. Indicates whether the unit is a concept prototype, alpha build, beta unit, pre-production sample, or production unit.. Valid values are `concept|alpha|beta|pre_production|production|field_trial`',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this test result is required for regulatory certification or compliance submission (e.g., UL, CE, FCC). Flags test data needed for regulatory dossiers.',
    `retest_flag` BOOLEAN COMMENT 'Indicates whether this test is a retest of a previously failed or inconclusive test. Used to track test iteration history.',
    `root_cause_analysis_required` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis (RCA) is required for this test result. Typically true for test failures or unexpected results.',
    `test_date` DATE COMMENT 'Date when the test was executed. Principal business event timestamp for the test activity.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time for test execution measured in hours. Captures the actual test run time for endurance and long-duration tests.',
    `test_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the test execution completed. Used for duration calculation and detailed test timeline tracking.',
    `test_facility` STRING COMMENT 'Name or identifier of the laboratory, test center, or facility where the test was conducted. May be internal lab or external third-party testing facility.',
    `test_facility_location` STRING COMMENT 'Geographic location or site code of the test facility. Supports multi-site test operations and regulatory reporting.',
    `test_notes` STRING COMMENT 'Free-form notes, observations, or comments recorded by the test engineer during test execution. Captures contextual information not covered by structured fields.',
    `test_number` STRING COMMENT 'Business identifier for the test execution. Externally-known unique test reference number used for traceability and reporting.',
    `test_outcome` STRING COMMENT 'Overall pass/fail result of the test execution. Indicates whether the tested unit met the acceptance criteria defined in the test specification.. Valid values are `pass|fail|conditional_pass|inconclusive|aborted`',
    `test_purpose` STRING COMMENT 'Business objective or reason for conducting the test. Describes the validation goal, such as design verification, production qualification, regulatory compliance, or failure investigation.',
    `test_specification_version` STRING COMMENT 'Version or revision of the test specification document used for this test execution. Ensures traceability to the correct test procedure version.',
    `test_standard_reference` STRING COMMENT 'Industry or regulatory standard governing the test procedure. References the specific standard, specification, or protocol followed during test execution (e.g., IEC 61131-2, UL 508, ISO 16750).',
    `test_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the test execution began. Used for duration calculation and detailed test timeline tracking.',
    `test_status` STRING COMMENT 'Current lifecycle status of the test execution. Tracks the test through its workflow from scheduling to completion.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `test_type` STRING COMMENT 'Classification of the test performed. Defines the category of validation activity conducted on the unit under test. [ENUM-REF-CANDIDATE: functional|environmental|emc|safety|endurance|performance|reliability|thermal|vibration|shock|humidity|salt_spray|dust|ingress_protection — 14 candidates stripped; promote to reference product]',
    `tested_unit_identifier` STRING COMMENT 'Unique identifier of the physical unit or sample subjected to testing. May be a serial number, prototype build number, or sample lot identifier.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this test result record in the system. Audit trail for record creation.',
    CONSTRAINT pk_test_result PRIMARY KEY(`test_result_id`)
) COMMENT 'Engineering test and validation result record capturing outcomes of design verification and validation (DV&V) activities performed on prototypes, pre-production units, or production samples. Captures test type (functional, environmental, EMC, safety, endurance, performance, reliability), test standard reference, tested unit identification (prototype phase, build number, component revision), test date, test facility, pass/fail outcome, measured values vs acceptance criteria, failure description, linked DFMEA failure mode, and prototype build context (phase, purpose, disposition). Supports DVP&R evidence for PPAP, regulatory certification submissions, and R&D program milestone tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` (
    `configuration_baseline_id` BIGINT COMMENT 'Unique system-generated identifier for the configuration baseline record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Baseline creation audit needs the employee ID for configuration control and release approval records.',
    `engineering_project_id` BIGINT COMMENT 'Identifier of the engineering project to which the baseline belongs.',
    `engineering_revision_id` BIGINT COMMENT 'Identifier of the specific product revision captured in the baseline.',
    `previous_configuration_baseline_id` BIGINT COMMENT 'Self-referencing FK on configuration_baseline (previous_configuration_baseline_id)',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Configuration baselines are established to lock in compliance‑required product states.',
    `approval_date` DATE COMMENT 'Date the baseline was formally approved.',
    `approved_by` STRING COMMENT 'Name of the authority who approved the baseline.',
    `associated_ecn_number` STRING COMMENT 'ECN number linked to this baseline, if any.',
    `associated_eco_number` STRING COMMENT 'ECO number linked to this baseline, if any.',
    `baseline_code` STRING COMMENT 'Business identifier or code used externally to reference the baseline.',
    `baseline_name` STRING COMMENT 'Human‑readable name describing the baseline (e.g., "Functional Baseline – Rev A").',
    `baseline_scope` STRING COMMENT 'Scope of the baseline (e.g., entire product, subsystem only).',
    `baseline_type` STRING COMMENT 'Classification of the baseline according to ISO 10007 (functional, allocated, product, etc.).. Valid values are `functional|allocated|product|design|physical`',
    `change_category` STRING COMMENT 'Category of change (e.g., design, material, process).',
    `change_lock_flag` BOOLEAN COMMENT 'Indicates whether further changes to the baseline are locked (true) or allowed (false).',
    `change_reason` STRING COMMENT 'Narrative reason for creating or updating the baseline.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the baseline.. Valid values are `compliant|non_compliant|pending`',
    `configuration_baseline_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the baseline.',
    `cost_impact_currency` DECIMAL(18,2) COMMENT 'Three‑letter ISO currency code for the cost impact estimate.',
    `cost_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial impact of the baseline change.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the baseline record was first created in the system.',
    `configuration_baseline_description` DECIMAL(18,2) COMMENT 'Free‑form description of the baseline purpose and scope.',
    `effective_date` DATE COMMENT 'Date on which the baseline becomes effective.',
    `expiration_date` DATE COMMENT 'Date on which the baseline expires or is superseded (nullable).',
    `export_control_classification` STRING COMMENT 'Export control classification applicable to the baseline.. Valid values are `none|EAR99|ITAR`',
    `is_functional_baseline` BOOLEAN COMMENT 'True if the baseline represents a functional configuration.',
    `is_physical_baseline` BOOLEAN COMMENT 'True if the baseline represents a physical configuration (as opposed to functional).',
    `linked_bom_revision` STRING COMMENT 'Identifier of the BOM revision frozen in this baseline.',
    `linked_component_set` STRING COMMENT 'Reference to the frozen set of component revisions included in the baseline.',
    `linked_drawing_revision` STRING COMMENT 'Identifier of the drawing revision captured in the baseline.',
    `linked_spec_revision` STRING COMMENT 'Identifier of the specification revision associated with the baseline.',
    `lock_reason` STRING COMMENT 'Explanation why the baseline was locked from further changes.',
    `modified_by` STRING COMMENT 'User name or identifier of the person who last modified the baseline record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the baseline record.',
    `project_phase` STRING COMMENT 'Phase of the engineering project at the time of baseline creation.. Valid values are `concept|design|prototype|pilot|production`',
    `regulatory_impact_flag` BOOLEAN COMMENT 'True if the baseline triggers regulatory reporting or filing requirements.',
    `schedule_impact_days` STRING COMMENT 'Estimated change in project schedule (in days) caused by the baseline.',
    `version_number` STRING COMMENT 'Sequential version number of the baseline.',
    CONSTRAINT pk_configuration_baseline PRIMARY KEY(`configuration_baseline_id`)
) COMMENT 'Configuration baseline record representing a formally approved and frozen snapshot of a products complete design configuration at a specific milestone (e.g., functional baseline, allocated baseline, product baseline per ISO 10007). Captures baseline identifier, baseline type, effective date, approval authority, linked component revisions (frozen set), linked BOM revision, linked specification revisions, linked drawing revisions, associated engineering project phase, and change lock status. Serves as the immutable reference point against which all subsequent engineering changes are measured, enabling configuration audits (functional and physical), regulatory submission packages, and customer-contractual design freeze evidence.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` (
    `component_installation_id` BIGINT COMMENT 'Primary key for the component_installation association',
    `component_id` BIGINT COMMENT 'Foreign key linking to the component master record',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to the equipment register master record',
    `created_timestamp` TIMESTAMP COMMENT '',
    `install_date` DATE COMMENT 'Date when the component was installed on the equipment',
    `installation_date` DATE COMMENT '',
    `installation_notes` STRING COMMENT '',
    `installation_number` STRING COMMENT '',
    `installation_position` STRING COMMENT '',
    `installation_sequence` STRING COMMENT '',
    `installation_status` STRING COMMENT 'Current status of the installation record',
    `installed_by` STRING COMMENT '',
    `installed_by_name` STRING COMMENT '',
    `installed_by_user` STRING COMMENT 'installed by user',
    `installed_quantity` DECIMAL(18,2) COMMENT '',
    `installed_timestamp` TIMESTAMP COMMENT 'installed timestamp',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `position_on_equipment` STRING COMMENT 'Physical location or slot identifier on the equipment where the component is installed',
    `position_reference` STRING COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `quantity_installed` DECIMAL(18,2) COMMENT '',
    `reference_designator` STRING COMMENT '',
    `removal_date` DATE COMMENT '',
    `serial_number` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    CONSTRAINT pk_component_installation PRIMARY KEY(`component_installation_id`)
) COMMENT 'Represents the installation of a component onto a piece of equipment. Each record captures the date of installation, the physical position on the equipment, and the status of the installation. The association links one component to one equipment register.. Existence Justification: Components are physically installed onto equipment; each installation is recorded with an install date, position on the equipment, and installation status. A given component type can be installed on many pieces of equipment, and a piece of equipment can contain many component types. The installation records are actively created, updated, and deleted by maintenance personnel as part of the asset management process.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` (
    `project_material_allocation_id` BIGINT COMMENT 'Primary key for the project_material_allocation association',
    `engineering_project_id` BIGINT COMMENT 'Foreign key linking to the engineering project',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master',
    `allocated_cost_amount` DECIMAL(18,2) COMMENT '',
    `allocated_quantity` DECIMAL(18,2) COMMENT '',
    `allocation_date` DATE COMMENT '',
    `allocation_notes` STRING COMMENT '',
    `allocation_number` STRING COMMENT '',
    `allocation_status` STRING COMMENT 'Current status of the material allocation for the project',
    `consumed_quantity` DECIMAL(18,2) COMMENT '',
    `cost_amount` DECIMAL(18,2) COMMENT 'cost amount',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `estimated_cost` DECIMAL(18,2) COMMENT '',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `planned_delivery_date` DATE COMMENT 'Date the material is expected to be delivered for the project',
    `required_by_date` DATE COMMENT '',
    `required_date` TIMESTAMP COMMENT '',
    `required_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material needed for the project',
    `unit_of_measure` STRING COMMENT '',
    CONSTRAINT pk_project_material_allocation PRIMARY KEY(`project_material_allocation_id`)
) COMMENT 'Represents the Bill of Materials for an engineering project, capturing the quantity of each material required, the planned delivery date, and the allocation status. Each record links one engineering_project to one material_master.. Existence Justification: Engineering projects allocate many material types, and each material can be allocated to multiple projects. The allocation is actively managed with quantities, planned delivery dates, and status, forming a distinct business entity (Bill of Materials).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_substitute_component_id` FOREIGN KEY (`substitute_component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_tertiary_engineering_substitute_component_id` FOREIGN KEY (`tertiary_engineering_substitute_component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_primary_superseded_by_revision_engineering_revision_id` FOREIGN KEY (`primary_superseded_by_revision_engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ADD CONSTRAINT `fk_engineering_dfmea_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ADD CONSTRAINT `fk_engineering_dfm_analysis_dfmea_id` FOREIGN KEY (`dfmea_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`dfmea`(`dfmea_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ADD CONSTRAINT `fk_engineering_dfm_analysis_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_superseded_by_specification_engineering_specification_id` FOREIGN KEY (`superseded_by_specification_engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_dfmea_id` FOREIGN KEY (`dfmea_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`dfmea`(`dfmea_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_engineering_project_id` FOREIGN KEY (`engineering_project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_project`(`engineering_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ADD CONSTRAINT `fk_engineering_certification_requirement_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ADD CONSTRAINT `fk_engineering_certification_requirement_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_dfmea_id` FOREIGN KEY (`dfmea_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`dfmea`(`dfmea_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_original_test_result_id` FOREIGN KEY (`original_test_result_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ADD CONSTRAINT `fk_engineering_configuration_baseline_engineering_project_id` FOREIGN KEY (`engineering_project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_project`(`engineering_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ADD CONSTRAINT `fk_engineering_configuration_baseline_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ADD CONSTRAINT `fk_engineering_configuration_baseline_previous_configuration_baseline_id` FOREIGN KEY (`previous_configuration_baseline_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`configuration_baseline`(`configuration_baseline_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ADD CONSTRAINT `fk_engineering_component_installation_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` ADD CONSTRAINT `fk_engineering_project_material_allocation_engineering_project_id` FOREIGN KEY (`engineering_project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_project`(`engineering_project_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`engineering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`engineering` SET TAGS ('dbx_domain' = 'engineering');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `substitute_component_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Component ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `cad_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) Model Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `ce_marking_flag` SET TAGS ('dbx_business_glossary_term' = 'Conformité Européenne (CE) Marking Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_number` SET TAGS ('dbx_business_glossary_term' = 'Component Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'raw_material|purchased_part|manufactured_part|sub_assembly|assembly|phantom');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `dfm_score` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Score');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `dfmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `functional_group` SET TAGS ('dbx_business_glossary_term' = 'Functional Group');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Height in Millimeters (mm)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `length_mm` SET TAGS ('dbx_business_glossary_term' = 'Length in Millimeters (mm)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `lifecycle_phase` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Phase');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `make_or_buy` SET TAGS ('dbx_business_glossary_term' = 'Make or Buy Decision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `make_or_buy` SET TAGS ('dbx_value_regex' = 'make|buy|make_and_buy');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `material_specification` SET TAGS ('dbx_business_glossary_term' = 'Material Specification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `pfmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `plm_item_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|released|frozen|obsolete|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `technology_family` SET TAGS ('dbx_business_glossary_term' = 'Technology Family');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `tolerance_class` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Class');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `ul_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Underwriters Laboratories (UL) Certification Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Width in Millimeters (mm)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `alternative_bom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Alternative BOM Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'engineering|manufacturing|service|sales|planning|as_maintained');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_category` SET TAGS ('dbx_business_glossary_term' = 'BOM Category');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_category` SET TAGS ('dbx_value_regex' = 'material|document|equipment|variant|configurable');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `configuration_profile` SET TAGS ('dbx_business_glossary_term' = 'Configuration Profile');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `cost_estimate_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `cost_estimate_total` SET TAGS ('dbx_business_glossary_term' = 'Total BOM Cost Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `cost_estimate_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_description` SET TAGS ('dbx_business_glossary_term' = 'BOM Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective To Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `engineering_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_business_glossary_term' = 'BOM Explosion Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_value_regex' = 'single_level|multi_level|summarized');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `is_configurable` SET TAGS ('dbx_business_glossary_term' = 'Configurable BOM Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `is_critical_bom` SET TAGS ('dbx_business_glossary_term' = 'Critical BOM Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `is_phantom_bom` SET TAGS ('dbx_business_glossary_term' = 'Phantom BOM Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'BOM Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `plm_item_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `quantity_basis` SET TAGS ('dbx_business_glossary_term' = 'BOM Quantity Basis');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'BOM Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'BOM Scrap Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Primary Key');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'BOM Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'BOM Usage Context');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `usage` SET TAGS ('dbx_value_regex' = 'production|costing|engineering|maintenance|sales_order|project');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `weight_total` SET TAGS ('dbx_business_glossary_term' = 'Total BOM Weight');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'KG|LB|G|OZ|MT');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Created By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Item Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `tertiary_engineering_substitute_component_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Component Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `assembly_instruction` SET TAGS ('dbx_business_glossary_term' = 'Assembly Instruction');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `bulk_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Material Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `co_product_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Product Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `cost_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Rollup Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `effectivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity End Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `effectivity_serial_number_end` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Serial Number End');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `effectivity_serial_number_start` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Serial Number Start');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `effectivity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `engineering_bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `engineering_bom_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete|prototype');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `engineering_notes` SET TAGS ('dbx_business_glossary_term' = 'Engineering Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `find_number` SET TAGS ('dbx_business_glossary_term' = 'Find Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `fixed_quantity_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Quantity Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `installation_point` SET TAGS ('dbx_business_glossary_term' = 'Installation Point');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `lead_time_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Offset Days');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `phantom_flag` SET TAGS ('dbx_business_glossary_term' = 'Phantom Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `position_number` SET TAGS ('dbx_business_glossary_term' = 'Position Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'make|buy|transfer|subcontract');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `quantity_per_assembly` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Assembly');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `reference_designator` SET TAGS ('dbx_business_glossary_term' = 'Reference Designator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `scrap_factor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `sort_sequence` SET TAGS ('dbx_business_glossary_term' = 'Sort Sequence');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `substitute_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Substitute Qualification Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `substitute_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditional|pending|not_qualified');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `substitute_usage_restriction` SET TAGS ('dbx_business_glossary_term' = 'Substitute Usage Restriction');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` SET TAGS ('dbx_subdomain' = 'design_documentation');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `cad_model_id` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) Model ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `authoring_tool` SET TAGS ('dbx_business_glossary_term' = 'CAD Authoring Tool');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `authoring_tool_version` SET TAGS ('dbx_business_glossary_term' = 'CAD Authoring Tool Version');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `bounding_box_height` SET TAGS ('dbx_business_glossary_term' = 'Bounding Box Height');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `bounding_box_length` SET TAGS ('dbx_business_glossary_term' = 'Bounding Box Length');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `bounding_box_width` SET TAGS ('dbx_business_glossary_term' = 'Bounding Box Width');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `cam_program_reference` SET TAGS ('dbx_business_glossary_term' = 'CAM Program ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `cam_programming_required` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Manufacturing (CAM) Programming Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `center_of_gravity_x` SET TAGS ('dbx_business_glossary_term' = 'Center of Gravity X Coordinate');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `center_of_gravity_y` SET TAGS ('dbx_business_glossary_term' = 'Center of Gravity Y Coordinate');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `center_of_gravity_z` SET TAGS ('dbx_business_glossary_term' = 'Center of Gravity Z Coordinate');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'File Checksum Hash');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `dataset_type` SET TAGS ('dbx_business_glossary_term' = 'Dataset Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `dataset_type` SET TAGS ('dbx_value_regex' = '3D_Solid_Model|2D_Drawing|Assembly|Simulation|CAM_Toolpath|Sheet_Metal');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `design_intent` SET TAGS ('dbx_business_glossary_term' = 'Design Intent');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `dfm_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `dfm_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'DFM Complexity Score');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'CAD File Format');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `intellectual_property_owner` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Owner');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Design Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `material_specification` SET TAGS ('dbx_business_glossary_term' = 'Material Specification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_mass` SET TAGS ('dbx_business_glossary_term' = 'Model Mass');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_maturity_state` SET TAGS ('dbx_business_glossary_term' = 'Model Maturity State');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_maturity_state` SET TAGS ('dbx_value_regex' = 'Draft|In_Review|Approved|Released|Obsolete|Archived');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'CAD Model Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'CAD Model Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_surface_area` SET TAGS ('dbx_business_glossary_term' = 'Model Surface Area');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `model_volume` SET TAGS ('dbx_business_glossary_term' = 'Model Volume');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `obsolete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Model Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'mm|cm|m|in|ft');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `vault_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Vault Storage Path');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `vault_storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` SET TAGS ('dbx_subdomain' = 'design_documentation');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `assembly_level` SET TAGS ('dbx_business_glossary_term' = 'Assembly Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `assembly_level` SET TAGS ('dbx_value_regex' = 'component|subassembly|assembly|system');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `cad_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) Model Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `checked_by` SET TAGS ('dbx_business_glossary_term' = 'Checked By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|proprietary');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `drawing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}(-[A-Z0-9]{1,10})?$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `drawing_status` SET TAGS ('dbx_business_glossary_term' = 'Drawing Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `drawing_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|released|obsolete|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `drawing_type` SET TAGS ('dbx_business_glossary_term' = 'Drawing Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `drawn_by` SET TAGS ('dbx_business_glossary_term' = 'Drawn By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DWG|DXF|STEP|IGES|JT');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `is_master_drawing` SET TAGS ('dbx_business_glossary_term' = 'Is Master Drawing');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `material_callout` SET TAGS ('dbx_business_glossary_term' = 'Material Callout');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Drawing Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `plm_item_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `projection_method` SET TAGS ('dbx_business_glossary_term' = 'Projection Method');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `projection_method` SET TAGS ('dbx_value_regex' = 'first_angle|third_angle');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `revision_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `scale` SET TAGS ('dbx_business_glossary_term' = 'Drawing Scale');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `scale` SET TAGS ('dbx_value_regex' = '^(1:[0-9]+|[0-9]+:1|NTS)$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `sheet_count` SET TAGS ('dbx_business_glossary_term' = 'Sheet Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `sheet_size` SET TAGS ('dbx_business_glossary_term' = 'Sheet Size');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Drawing Standard');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `standard` SET TAGS ('dbx_value_regex' = 'ISO|ANSI|ASME|DIN|JIS|BS');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `superseded_by_drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `supersedes_drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `surface_finish_specification` SET TAGS ('dbx_business_glossary_term' = 'Surface Finish Specification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Drawing Title');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `tolerance_class` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Class');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `tolerance_class` SET TAGS ('dbx_value_regex' = 'fine|medium|coarse|precision|general');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'mm|cm|m|in|ft');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `acknowledgement_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `acknowledgement_required` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `actual_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Impact');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `actual_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `actual_schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Schedule Impact Days');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `affected_items_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Items Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `change_priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `change_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'design|material|process|documentation|specification|tooling');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `customer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `customer_approval_received` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Received Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `eco_description` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|retrofit|return_to_supplier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `eco_number` SET TAGS ('dbx_value_regex' = '^ECO-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `effectivity_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `effectivity_reference` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `effectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `effectivity_type` SET TAGS ('dbx_value_regex' = 'date|serial_number|lot_batch|immediate');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `erp_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) System Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `estimated_schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Schedule Impact Days');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `from_revision` SET TAGS ('dbx_business_glossary_term' = 'From Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `initiator_department` SET TAGS ('dbx_business_glossary_term' = 'Initiator Department');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `initiator_email` SET TAGS ('dbx_business_glossary_term' = 'Initiator Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `initiator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `initiator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `initiator_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `initiator_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `plm_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'safety|regulatory|quality|cost_reduction|obsolescence|customer_request');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `requires_customer_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Customer Approval Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `requires_supplier_notification` SET TAGS ('dbx_business_glossary_term' = 'Requires Supplier Notification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Title');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `to_revision` SET TAGS ('dbx_business_glossary_term' = 'To Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Approver ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `primary_ecn_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Originator ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `primary_ecn_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `primary_ecn_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `acknowledgement_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `acknowledgement_required` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `acknowledgement_target_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Target Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `affected_drawing_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Drawing Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `affected_part_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Part Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `affected_product_lines` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Lines');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `bom_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Category');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'design|material|process|documentation|specification|supplier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Comments');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `cost_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `cost_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Distribution List');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `ecn_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `ecn_number` SET TAGS ('dbx_value_regex' = '^ECN-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `ecn_status` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `ecn_status` SET TAGS ('dbx_value_regex' = 'draft|released|distributed|acknowledged|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `ecn_type` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `ecn_type` SET TAGS ('dbx_value_regex' = 'standard|urgent|emergency|field_change|design_improvement');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `erp_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Sync Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `erp_sync_status` SET TAGS ('dbx_value_regex' = 'pending|synced|failed|not_required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Implementation Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `inventory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `mes_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Sync Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `mes_sync_status` SET TAGS ('dbx_value_regex' = 'pending|synced|failed|not_required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `plm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Priority');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `revision_from` SET TAGS ('dbx_business_glossary_term' = 'Revision From');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `revision_from` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `revision_to` SET TAGS ('dbx_business_glossary_term' = 'Revision To');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `revision_to` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `routing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Routing Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ALTER COLUMN `supplier_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `primary_superseded_by_revision_engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Revision Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `cad_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) File Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `ce_marking_required` SET TAGS ('dbx_business_glossary_term' = 'Conformité Européenne (CE) Marking Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `change_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Change Impact Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `change_impact_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `change_justification` SET TAGS ('dbx_business_glossary_term' = 'Change Justification Summary');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `configuration_baseline` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `dfm_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `dfmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `interchangeability_code` SET TAGS ('dbx_business_glossary_term' = 'Interchangeability Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `interchangeability_code` SET TAGS ('dbx_value_regex' = 'fully_interchangeable|form_fit_function|retrofit_required|not_interchangeable');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Revision Label');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `label` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle State');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `mass_production_approved` SET TAGS ('dbx_business_glossary_term' = 'Mass Production Approved');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `pfmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `ppap_level` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `ppap_required` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `prototype_test_date` SET TAGS ('dbx_business_glossary_term' = 'Prototype Test Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `prototype_tested` SET TAGS ('dbx_business_glossary_term' = 'Prototype Tested');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration, Evaluation, Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending_review|non_compliant|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `release_authority` SET TAGS ('dbx_business_glossary_term' = 'Release Authority');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `release_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Release Authority Role');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_value_regex' = 'major|minor|patch|branch|prototype');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `specification_document` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `ul_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Underwriters Laboratories (UL) Certification Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_revision` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` SET TAGS ('dbx_subdomain' = 'design_documentation');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `dfmea_id` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `apqp_project_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Product Quality Planning (APQP) Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `tertiary_dfmea_team_lead_employee_id` SET TAGS ('dbx_business_glossary_term' = 'DFMEA Team Lead ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `tertiary_dfmea_team_lead_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `tertiary_dfmea_team_lead_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `action_priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority (AP)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `action_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|verified|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'DFMEA Analysis Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'DFMEA Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `current_detection_controls` SET TAGS ('dbx_business_glossary_term' = 'Current Detection Controls');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `current_prevention_controls` SET TAGS ('dbx_business_glossary_term' = 'Current Prevention Controls');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `customer_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Requirement Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `design_phase` SET TAGS ('dbx_value_regex' = 'concept|preliminary|detailed|validation|production');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `detection_rating` SET TAGS ('dbx_business_glossary_term' = 'Detection (D) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `dfmea_number` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `dfmea_status` SET TAGS ('dbx_business_glossary_term' = 'DFMEA Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `dfmea_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|active|superseded|obsolete');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `failure_cause` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `failure_effect` SET TAGS ('dbx_business_glossary_term' = 'Failure Effect');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `item_function` SET TAGS ('dbx_business_glossary_term' = 'Item Function');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'DFMEA Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `occurrence_rating` SET TAGS ('dbx_business_glossary_term' = 'Occurrence (O) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Corrective/Preventive Action');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `revised_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Revised Action Priority (AP)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `revised_action_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `revised_detection_rating` SET TAGS ('dbx_business_glossary_term' = 'Revised Detection (D) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `revised_occurrence_rating` SET TAGS ('dbx_business_glossary_term' = 'Revised Occurrence (O) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `revised_rpn` SET TAGS ('dbx_business_glossary_term' = 'Revised Risk Priority Number (RPN)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `revised_severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Revised Severity (S) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'DFMEA Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `rpn` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority Number (RPN)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `safety_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Related Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'DFMEA Scope Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `scope_level` SET TAGS ('dbx_business_glossary_term' = 'DFMEA Scope Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `scope_level` SET TAGS ('dbx_value_regex' = 'system|subsystem|component|interface');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity (S) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `special_characteristics_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Characteristics Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfmea` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` SET TAGS ('dbx_subdomain' = 'design_documentation');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `dfm_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `dfmea_id` SET TAGS ('dbx_business_glossary_term' = 'Related Design Failure Mode and Effects Analysis (DFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Component Revision ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `fmea_id` SET TAGS ('dbx_business_glossary_term' = 'Related Process Failure Mode and Effects Analysis (PFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `affected_feature` SET TAGS ('dbx_business_glossary_term' = 'Affected Feature');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `alternative_solution` SET TAGS ('dbx_business_glossary_term' = 'Alternative Solution');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `dfm_issue_detail` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Issue Detail');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `dfm_issue_summary` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Issue Summary');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rationale');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'open|under_review|design_change_required|accepted_as_is|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `eco_initiated` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Initiated');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `estimated_cost_savings` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Savings');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `estimated_cost_savings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `impact_on_lead_time` SET TAGS ('dbx_business_glossary_term' = 'Impact on Lead Time');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `impact_on_quality` SET TAGS ('dbx_business_glossary_term' = 'Impact on Quality');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `impact_on_quality` SET TAGS ('dbx_value_regex' = 'improves_quality|no_impact|degrades_quality');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `manufacturing_process_scope` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Scope');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `manufacturing_site` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Part Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `part_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `part_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `process_constraint` SET TAGS ('dbx_business_glossary_term' = 'Process Constraint');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `recommended_design_modification` SET TAGS ('dbx_business_glossary_term' = 'Recommended Design Modification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `review_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `risk_priority_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority Number (RPN)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor|informational');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `supplier_feedback` SET TAGS ('dbx_business_glossary_term' = 'Supplier Feedback');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`dfm_analysis` ALTER COLUMN `tooling_requirement` SET TAGS ('dbx_business_glossary_term' = 'Tooling Requirement');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `superseded_by_specification_engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|obsolete|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approver_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `design_authority` SET TAGS ('dbx_business_glossary_term' = 'Design Authority');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `dfm_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `dfmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|DWG|STEP|IGES|XML');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `ecn_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `ecn_number` SET TAGS ('dbx_value_regex' = '^ECN-[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `eco_number` SET TAGS ('dbx_value_regex' = '^ECO-[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `material_standard` SET TAGS ('dbx_business_glossary_term' = 'Material Standard');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Obsolete Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `performance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Performance Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `pfmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `prototype_required` SET TAGS ('dbx_business_glossary_term' = 'Prototype Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Specification Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `revision` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Scope Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'material|functional|interface|environmental|safety|performance');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `supplier_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Specification Title');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `tolerance_specification` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Specification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `design_review_id` SET TAGS ('dbx_business_glossary_term' = 'Design Review ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `dfmea_id` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `engineering_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `fmea_id` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `action_item_count` SET TAGS ('dbx_business_glossary_term' = 'Action Item Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `action_items` SET TAGS ('dbx_business_glossary_term' = 'Action Items');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `apqp_phase` SET TAGS ('dbx_business_glossary_term' = 'Advanced Product Quality Planning (APQP) Phase');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `apqp_phase` SET TAGS ('dbx_value_regex' = 'phase_1|phase_2|phase_3|phase_4|phase_5');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `attendee_list` SET TAGS ('dbx_business_glossary_term' = 'Attendee List');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `attendee_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `attendee_list` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_verification|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `criteria_fail_count` SET TAGS ('dbx_business_glossary_term' = 'Criteria Fail Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `criteria_na_count` SET TAGS ('dbx_business_glossary_term' = 'Criteria Not Applicable (NA) Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `criteria_pass_count` SET TAGS ('dbx_business_glossary_term' = 'Criteria Pass Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `design_maturity_level` SET TAGS ('dbx_business_glossary_term' = 'Design Maturity Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `design_maturity_level` SET TAGS ('dbx_value_regex' = 'concept|preliminary|detailed|final|released');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `design_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Design Validation Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `design_validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `design_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `design_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `document_references` SET TAGS ('dbx_business_glossary_term' = 'Document References');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `ecn_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `gate_criteria_checklist` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria Checklist');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `gate_decision` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `gate_decision` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `gate_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `meeting_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meeting Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `open_action_item_count` SET TAGS ('dbx_business_glossary_term' = 'Open Action Item Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Design Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Design Review Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^DR-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Design Review Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `review_summary` SET TAGS ('dbx_business_glossary_term' = 'Design Review Summary');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Design Review Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'PDR|CDR|PRR|TRR|FDR|MDR');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `reviewed_item_description` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Item Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `reviewed_item_number` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Item Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `reviewed_item_revision` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Item Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`design_review` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `engineering_project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Site ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Supplier Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `budget_spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Spent Amount');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `budget_spent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `business_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) / Operational Expenditure (OpEx) Classification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'capex|opex|mixed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `collaboration_partners` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partners');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Complexity Score');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `design_methodology` SET TAGS ('dbx_business_glossary_term' = 'Design Methodology');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `design_methodology` SET TAGS ('dbx_value_regex' = 'agile|waterfall|stage_gate|lean|concurrent_engineering');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `design_review_count` SET TAGS ('dbx_business_glossary_term' = 'Design Review Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `dfm_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `dfmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `eco_count` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `patent_application_count` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `pfmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `ppap_required` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `program_phase` SET TAGS ('dbx_business_glossary_term' = 'Program Phase');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed|archived');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_product_development|product_improvement|platform_development|cost_reduction|sustaining_engineering|technology_research');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `prototype_count` SET TAGS ('dbx_business_glossary_term' = 'Prototype Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `regulatory_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Scope');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `sustainability_target` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `team_size_count` SET TAGS ('dbx_business_glossary_term' = 'Team Size Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_project` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` SET TAGS ('dbx_subdomain' = 'validation_testing');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certification_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirement Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Prototype Test Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certification_body_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Certification Body Accreditation');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certification_priority` SET TAGS ('dbx_business_glossary_term' = 'Certification Priority');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certification_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'product_safety|environmental|quality|cybersecurity|electromagnetic_compatibility|functional_safety');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `ecn_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `estimated_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lead Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Certification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `non_compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Impact');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirement Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `regulation_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulation or Standard');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirement Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirement Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `target_country_code` SET TAGS ('dbx_business_glossary_term' = 'Target Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `target_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market or Region');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `test_specification` SET TAGS ('dbx_business_glossary_term' = 'Test Specification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Required Test Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'type_testing|routine_testing|witness_testing|factory_acceptance_test|site_acceptance_test|conformity_assessment');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`certification_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` SET TAGS ('dbx_subdomain' = 'validation_testing');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `dfmea_id` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `fmea_id` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `original_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Test Result ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `ppap_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Submission ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `project_document_id` SET TAGS ('dbx_business_glossary_term' = 'Test Report Document ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `acceptance_criteria_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Lower Limit');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `acceptance_criteria_target` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Target Value');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `acceptance_criteria_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Upper Limit');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `dvp_r_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan and Report (DVP&R) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `failure_mode_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `measured_value_unit` SET TAGS ('dbx_business_glossary_term' = 'Measured Value Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `prototype_phase` SET TAGS ('dbx_business_glossary_term' = 'Prototype Phase');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `prototype_phase` SET TAGS ('dbx_value_regex' = 'concept|alpha|beta|pre_production|production|field_trial');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `root_cause_analysis_required` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration Hours');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_facility` SET TAGS ('dbx_business_glossary_term' = 'Test Facility');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_facility_location` SET TAGS ('dbx_business_glossary_term' = 'Test Facility Location');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_outcome` SET TAGS ('dbx_business_glossary_term' = 'Test Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|inconclusive|aborted');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_purpose` SET TAGS ('dbx_business_glossary_term' = 'Test Purpose');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_specification_version` SET TAGS ('dbx_business_glossary_term' = 'Test Specification Version');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Standard Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `tested_unit_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tested Unit Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `configuration_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `engineering_project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Revision Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `previous_configuration_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Configuration Baseline Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `previous_configuration_baseline_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `associated_ecn_number` SET TAGS ('dbx_business_glossary_term' = 'Associated Engineering Change Notice Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `associated_eco_number` SET TAGS ('dbx_business_glossary_term' = 'Associated Engineering Change Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `baseline_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `baseline_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `baseline_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `baseline_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `baseline_scope` SET TAGS ('dbx_business_glossary_term' = 'Baseline Scope Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_value_regex' = 'functional|allocated|product|design|physical');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Baseline Change Category');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `change_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Change Lock Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Baseline Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `configuration_baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cost Impact Currency');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `cost_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cost Impact Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Baseline Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `configuration_baseline_description` SET TAGS ('dbx_business_glossary_term' = 'Baseline Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'none|EAR99|ITAR');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `is_functional_baseline` SET TAGS ('dbx_business_glossary_term' = 'Functional Baseline Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `is_physical_baseline` SET TAGS ('dbx_business_glossary_term' = 'Physical Baseline Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `linked_bom_revision` SET TAGS ('dbx_business_glossary_term' = 'Linked BOM Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `linked_component_set` SET TAGS ('dbx_business_glossary_term' = 'Linked Component Set Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `linked_drawing_revision` SET TAGS ('dbx_business_glossary_term' = 'Linked Drawing Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `linked_spec_revision` SET TAGS ('dbx_business_glossary_term' = 'Linked Specification Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `lock_reason` SET TAGS ('dbx_business_glossary_term' = 'Baseline Lock Reason');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Baseline Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Baseline Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Phase');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'concept|design|prototype|pilot|production');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Schedule Impact (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`configuration_baseline` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` SET TAGS ('dbx_subdomain' = 'validation_testing');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` SET TAGS ('dbx_association_edges' = 'engineering.component,asset.equipment_register');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ALTER COLUMN `component_installation_id` SET TAGS ('dbx_business_glossary_term' = 'Component Installation - Component Installation Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Installation - Component Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Component Installation - Equipment Register Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ALTER COLUMN `install_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ALTER COLUMN `installation_status` SET TAGS ('dbx_business_glossary_term' = 'Installation Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ALTER COLUMN `installed_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ALTER COLUMN `installed_by_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component_installation` ALTER COLUMN `position_on_equipment` SET TAGS ('dbx_business_glossary_term' = 'Installation Position');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` SET TAGS ('dbx_subdomain' = 'validation_testing');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` SET TAGS ('dbx_association_edges' = 'engineering.engineering_project,inventory.material_master');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` ALTER COLUMN `project_material_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Material Allocation - Project Material Allocation Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` ALTER COLUMN `engineering_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Material Allocation - Engineering Project Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Project Material Allocation - Material Master Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project_material_allocation` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
