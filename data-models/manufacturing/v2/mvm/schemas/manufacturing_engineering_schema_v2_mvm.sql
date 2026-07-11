-- Schema for Domain: engineering | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`engineering` COMMENT 'Product design and engineering lifecycle domain covering CAD/CAM models, BOMs, ECOs, ECNs, DFM analysis, DFMEA, PFMEA, and PLM data managed in Siemens Teamcenter. Serves as the SSOT for product structure, revision history, engineering change governance, technical specifications, drawings, and prototypes for all manufactured automation systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`component` (
    `component_id` BIGINT COMMENT 'Unique identifier for the component. Primary key for the component master record.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer-proprietary components in OEM/contract manufacturing require customer association for IP ownership, export control compliance, and customer-triggered obsolescence notifications. component has',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Inventory Management tracks stock of each engineered component via Material Master for procurement and WIP planning.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Components are designed and developed within engineering projects. The primary engineering project that originated or owns a component is a fundamental PLM relationship. Linking component to engineeri',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Make-or-buy components map directly to SKUs for costing, procurement, and production planning. The component-to-SKU traceability process in PLM-to-ERP integration requires this link. A manufacturing',
    `substitute_component_id` BIGINT COMMENT 'Identifier of an approved substitute component that can be used interchangeably. Supports supply chain flexibility and risk mitigation.',
    `abc_classification` STRING COMMENT 'Inventory classification by value contribution. A items are high-value requiring tight control, C items are low-value with relaxed management.. Valid values are `A|B|C`',
    `cad_model_reference` STRING COMMENT 'File path or URI reference to the authoritative CAD model in PLM. Links to 3D geometry for design, simulation, and manufacturing.',
    `ce_marking_flag` BOOLEAN COMMENT 'Indicates CE marking compliance for European market access. Confirms conformity with EU health, safety, and environmental protection standards.',
    `commodity_code` STRING COMMENT 'Procurement commodity classification code. Groups components by material family for sourcing strategy and supplier alignment.',
    `component_number` STRING COMMENT 'Business identifier for the component. Human-readable unique code used across engineering, procurement, and manufacturing.',
    `component_type` STRING COMMENT 'Classification of the component by procurement and manufacturing strategy. Determines BOM explosion logic and sourcing approach.. Valid values are `raw_material|purchased_part|manufactured_part|sub_assembly|assembly|phantom`',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for standard cost. Enables multi-currency cost management.. Valid values are `^[A-Z]{3}$`',
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
    `asset_plant_id` BIGINT COMMENT 'Foreign key linking to asset.asset_plant. Business justification: BOMs are plant-specific in manufacturing — different plants may have different approved BOMs for the same product due to local tooling, supplier approvals, or regulatory requirements. bom.plant_code i',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: A BOM is defined for a specific root component or assembly. This is the fundamental parent-child relationship: bom belongs to component. The existing plm_item_code (BIGINT) on bom is a denormalized PL',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑specific BOMs are created for contract fulfillment; linking BOM to customer_account enables contract‑BOM reconciliation reports.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: A BOM revision is formally initiated and governed by an Engineering Change Order. The existing engineering_change_order_number (STRING) is a denormalized text reference to the ECO record. Replacing it',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: The ECO-driven BOM release process transfers an engineering BOM into a production BOM header. This header-to-header link tracks which product BOM was created from which engineering BOM, enabling cha',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: A BOM is associated with a specific engineering revision of its parent component/assembly. Linking bom to engineering_revision enables full traceability of which revision state the BOM represents, sup',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Every engineering BOM defines the structure of a specific product SKU. The BOM costing and production planning process requires knowing which SKU a BOM defines. Manufacturing engineers expect a dire',
    `alternative_bom_indicator` STRING COMMENT 'Identifier for alternative BOM variants of the same product, used to represent different manufacturing methods, material substitutions, or regional variations. Blank for primary BOM.',
    `approval_status` STRING COMMENT 'Current approval state of the BOM in the engineering change workflow. Pending indicates awaiting review, Approved means released for use, Rejected means not accepted, Conditional means approved with restrictions or prerequisites.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this BOM revision. Supports audit trail and accountability for engineering change management.',
    `approved_date` DATE COMMENT 'Date on which this BOM revision was formally approved for release. Critical for traceability and compliance with engineering change control processes.',
    `base_unit_of_measure` STRING COMMENT 'The fundamental unit of measure in which the finished product is stocked and sold, independent of the BOM quantity basis. Used for inventory and sales order processing.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM, typically a human-readable code used across engineering, manufacturing, and procurement systems. Serves as the externally-known unique reference.',
    `bom_status` STRING COMMENT 'Current lifecycle state of the BOM. Draft indicates work in progress, In Review means under engineering approval, Approved is ready for release, Active is in production use, Obsolete is no longer valid, Superseded has been replaced by a newer revision, and Frozen is locked for regulatory or contractual reasons. [ENUM-REF-CANDIDATE: draft|in_review|approved|active|obsolete|superseded|frozen — 7 candidates stripped; promote to reference product]',
    `bom_type` STRING COMMENT 'Classification of the BOM by its intended business purpose. Engineering BOM (EBOM) represents design intent, Manufacturing BOM (MBOM) reflects shop floor assembly, Service BOM supports after-sales maintenance, Sales BOM defines customer-facing configurations, Planning BOM is used for MRP, and As-Maintained BOM tracks actual installed configurations.. Valid values are `engineering|manufacturing|service|sales|planning|as_maintained`',
    `bom_category` STRING COMMENT 'High-level classification of the BOM structure. Material BOM lists physical components, Document BOM references technical drawings and specifications, Equipment BOM defines installed assets, Variant BOM supports product families, Configurable BOM enables customer-specific selections.. Valid values are `material|document|equipment|variant|configurable`',
    `configuration_profile` STRING COMMENT 'Identifier for a variant configuration profile or product family definition. Used in configurable BOMs to define which components are included based on customer selections or feature options.',
    `cost_estimate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the BOM cost estimate. Supports multi-currency costing for global manufacturing operations.. Valid values are `USD|EUR|GBP|CNY|JPY|INR`',
    `cost_estimate_total` DECIMAL(18,2) COMMENT 'Estimated total cost of the BOM including all material, labor, and overhead components. Rolled up from component costs and routing operations. Used for product costing and pricing decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was first created in the PLM system. Provides audit trail for data governance and compliance.',
    `bom_description` STRING COMMENT 'Free-text description of the BOM, providing additional context about the product structure, manufacturing method, or special handling requirements. Supplements the BOM number and type.',
    `effective_from_date` DATE COMMENT 'Date from which this BOM revision becomes valid and can be used for production planning, procurement, and manufacturing execution. Supports time-phased BOM management for product transitions.',
    `effective_to_date` DATE COMMENT 'Date until which this BOM revision remains valid. Nullable for open-ended BOMs. Used to manage phase-out of legacy product structures and ensure correct BOM selection in MRP and MES systems.',
    `explosion_type` STRING COMMENT 'Defines how the BOM structure should be expanded for planning and execution. Single Level shows only immediate children, Multi Level recursively expands all sub-assemblies, Summarized aggregates quantities across all levels.. Valid values are `single_level|multi_level|summarized`',
    `is_configurable` BOOLEAN COMMENT 'Flag indicating whether this BOM supports variant configuration, allowing customer-specific or order-specific component selection. True for configurable BOMs, False for fixed BOMs.',
    `is_critical_bom` BOOLEAN COMMENT 'Flag indicating whether this BOM is for a critical or high-value product requiring special handling, approval workflows, or regulatory compliance. True for critical BOMs, False for standard BOMs.',
    `is_phantom_bom` BOOLEAN COMMENT 'Flag indicating whether this is a phantom (transient) BOM that is not stocked as a discrete item but is exploded through to its components during MRP and production. True for phantom BOMs, False for standard stocked assemblies.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production lot or batch size for which this BOM is optimized. Used in MRP calculations to determine component requirements and setup costs. Nullable if not applicable.',
    `modified_by` STRING COMMENT 'Name or identifier of the person or system that last modified this BOM record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was last updated. Distinct from approval and effectivity dates. Provides audit trail for data governance.',
    `notes` STRING COMMENT 'Additional notes, comments, or instructions related to this BOM. May include manufacturing guidelines, quality requirements, or special handling instructions for production planning and shop floor execution.',
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
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Individual BOM line items are added, modified, or deleted as part of Engineering Change Orders. The existing change_number (STRING) on engineering_bom_line is a denormalized text reference to the gove',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: MRP explosion requires each BOM line to reference a material master directly for inventory requirements planning, stock reservation, and procurement triggering. Manufacturing planners use BOM line → m',
    `component_id` BIGINT COMMENT 'Reference to the parent assembly or product that contains this component. Represents the parent side of the parent-child relationship in the BOM structure.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: A BOM line item is effective for a specific revision range of the parent assembly. Linking engineering_bom_line to engineering_revision (the specific revision at which this line was introduced or is v',
    `tertiary_engineering_substitute_component_id` BIGINT COMMENT 'Reference to an approved alternate component that can be used in place of the primary component without requiring an Engineering Change Order (ECO). Enables flexible sourcing and supply chain continuity.',
    `assembly_instruction` STRING COMMENT 'Specific instructions for assembling or installing this component into the parent assembly. May reference work instructions, torque specifications, or special tooling requirements.',
    `bulk_material_flag` BOOLEAN COMMENT 'Indicates whether this component is a bulk material (e.g., paint, adhesive, lubricant) that is consumed in variable quantities and may not be tracked at individual unit level.',
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
    `component_id` BIGINT COMMENT 'Reference to the manufactured component or assembly that this CAD model represents.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer-proprietary CAD models require customer association for IP ownership enforcement, export control classification (ITAR/EAR), and NDA-governed confidentiality management. cad_model has intellec',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to engineering.drawing. Business justification: A CAD model is the 3D source from which the formal 2D engineering drawing is derived. The existing drawing_number (STRING) on cad_model is a denormalized text reference to the drawing record. Replacin',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: A CAD model release or revision is formally governed by an Engineering Change Order. The existing eco_number (STRING) on cad_model is a denormalized text reference. Replacing it with eco_id FK provide',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: A CAD model represents the design geometry for a specific engineering revision of a component. Linking cad_model to engineering_revision enables precise configuration management: which CAD dataset cor',
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
    `dfm_analysis_status` STRING COMMENT 'Status of the Design for Manufacturability analysis for this CAD model, indicating whether the design has been reviewed for manufacturing feasibility.. Valid values are `Not_Started|In_Progress|Completed|Issues_Found|Approved`',
    `dfm_complexity_score` DECIMAL(18,2) COMMENT 'Numerical score representing the manufacturing complexity of the design, derived from DFM analysis (higher scores indicate more complex manufacturing requirements).',
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
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: A drawing documents a component; linking drawing to component provides traceability and connects the drawing product.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Drawings released for a particular customer project must reference the customer_account for release approval and traceability.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: An engineering drawing release or revision is formally governed by an Engineering Change Order. The existing eco_number (STRING) on drawing is a denormalized text reference. Replacing it with eco_id F',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: An engineering drawing is issued at a specific revision level of the component it documents. Linking drawing to engineering_revision enables configuration-controlled drawing management: the correct dr',
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
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: ECOs requiring customer approval (eco.requires_customer_approval=true) must record the specific customer contact who authorized the change for PPAP Level 3/4 documentation and regulatory audit trails.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: ECOs directly result in production BOM changes. The BOM change management process requires linking each ECO to the product BOM header it modifies, enabling change impact traceability, ERP BOM synchr',
    `certification_id` BIGINT COMMENT 'Foreign key linking to product.product_certification. Business justification: ECOs that change materials, dimensions, or processes can invalidate existing product certifications (CE, UL, RoHS). The certification impact assessment step of the ECO approval process requires link',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑driven engineering change orders are tracked via ECO linked to the requesting customer_account for audit trails.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Regulatory Change Management links each ECO to the specific regulatory requirement it addresses, ensuring traceability of compliance-driven changes.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Engineering Change Orders directly trigger material master updates in ERP — changed specifications, procurement types, or descriptions must be synchronized. ECO-to-material-master traceability is requ',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Engineering Change Orders are initiated within the context of engineering projects. A project generates multiple ECOs over its lifecycle. Linking eco to engineering_project enables project-level ECO t',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: ECOs affect specific SKUs and drive inventory disposition, customer change notifications, and ERP item master updates. The ECO impact assessment process requires SKU-level traceability. eco.family_i',
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
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for cost impact amounts (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`revision` (
    `revision_id` BIGINT COMMENT 'Unique identifier for the revision record. Primary key for the revision entity.',
    `component_id` BIGINT COMMENT 'Reference to the component or assembly that this revision applies to. Links to the master component record in the Product Lifecycle Management (PLM) system.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑specific revisions (e.g., custom part revisions) are tracked per customer_account for change management.',
    `eco_id` BIGINT COMMENT 'Reference to the Engineering Change Order (ECO) that authorized and governs this revision. Links the revision to the formal change management process.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Component revisions are often triggered by updates to regulatory requirements; the FK records the governing regulation.',
    `primary_superseded_by_revision_engineering_revision_id` BIGINT COMMENT 'Reference to the newer revision that supersedes this revision. Establishes the revision lineage chain for traceability and configuration management. Null if this is the current active revision.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Engineering revisions are created within the context of engineering projects (R&D initiatives, product development programs). Linking engineering_revision to engineering_project enables project-level ',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Engineering revisions drive SKU revision levels. The product revision management process requires tracing each engineering revision to the specific SKU it affects for change notification, inventory ',
    `approval_date` DATE COMMENT 'The date when this revision was formally approved by the release authority. Distinct from release date, represents the approval event in the workflow.',
    `cad_file_reference` STRING COMMENT 'Reference path or identifier to the Computer-Aided Design (CAD) model file associated with this revision in the Product Data Management (PDM) or PLM system.',
    `ce_marking_required` BOOLEAN COMMENT 'Flag indicating whether CE marking (European Conformity) is required for this revision. True indicates CE marking is mandatory for European market release.',
    `change_category` STRING COMMENT 'Classification of the reason for the revision change. Categorizes the business driver behind the Engineering Change Order (ECO). [ENUM-REF-CANDIDATE: design_improvement|cost_reduction|quality_issue|regulatory_compliance|customer_request|obsolescence|manufacturing_improvement|safety_enhancement — 8 candidates stripped; promote to reference product]',
    `change_impact_level` STRING COMMENT 'Assessment of the impact magnitude of this revision on form, fit, function, quality, cost, or schedule. Critical indicates significant impact requiring extensive validation, low indicates minimal impact.. Valid values are `critical|high|medium|low`',
    `change_justification` STRING COMMENT 'Business justification and summary description of why this revision was created. Captures the rationale for the design change, improvement, or correction.',
    `configuration_baseline` STRING COMMENT 'The configuration baseline identifier that this revision belongs to. Used for configuration management and as-designed vs as-built reconciliation.',
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
    CONSTRAINT pk_revision PRIMARY KEY(`revision_id`)
) COMMENT 'Revision history record for a component or assembly, capturing each discrete revision state managed in PLM. Tracks revision label (A, B, C or 01, 02), lifecycle state (in-work, released, obsolete), release date, superseded revision, release authority, change justification summary, linked ECO, and effectivity window. Provides full revision lineage for traceability, regulatory compliance, configuration audits, and as-designed vs as-built reconciliation. Supports multi-level revision schemes (major/minor) and parallel branch revisions for variant management.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` (
    `engineering_specification_id` BIGINT COMMENT 'Unique identifier for the engineering specification document record. Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Specification applies to a component; adding component_id FK normalizes the relationship and removes the denormalized linked_component_ids list.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑specific specifications are maintained for contract compliance; linking to customer_account enables specification‑customer mapping.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Engineering specifications are created or revised as part of Engineering Change Orders. The existing eco_number (STRING) on engineering_specification is a denormalized text reference. Replacing it wit',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Specifications are authored to meet particular regulatory standards; linking ties each spec to its governing requirement.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Engineering specifications are produced as deliverables of engineering projects. Linking engineering_specification to engineering_project enables project-level tracking of specification completeness, ',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: An engineering specification is written for a specific revision of a component. Linking engineering_specification to engineering_revision enables configuration-controlled specification management: the',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Engineering specifications are written for specific product SKUs to support supplier qualification, PPAP submissions, and make-or-buy decisions. The specification-to-product traceability process req',
    `superseded_by_specification_engineering_specification_id` BIGINT COMMENT 'Reference to the specification that supersedes this specification. Null if this specification is still current. Supports specification revision history and traceability.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`project` (
    `project_id` BIGINT COMMENT 'Unique identifier for the engineering project record. Primary key.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Required for Capital Project Integration Report linking engineering project to overall project schedule, enabling consolidated status and cost tracking across engineering and project management.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: NPI and custom product development projects are initiated for specific customers. Direct customer_account link enables program management reporting, customer-specific project portfolio views, and PPAP',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_plant. Business justification: New Product Introduction (NPI) engineering projects are scoped to specific manufacturing plants for inventory readiness, tooling, and capacity planning. Plant-specific NPI tracking is standard in mult',
    `family_id` BIGINT COMMENT 'Reference to the product family or platform that this engineering project is developing or enhancing.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Engineering projects in NPI (New Product Introduction) create or significantly revise specific SKUs. The NPI gate review process tracks which SKU an engineering project is delivering. engineering_pr',
    `actual_launch_date` DATE COMMENT 'Actual date when the engineering project completed and the product was launched to production or market.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the engineering project for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the engineering project was formally approved for execution.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated to the engineering project for all development activities and resources.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the project budget amounts.. Valid values are `^[A-Z]{3}$`',
    `budget_spent_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of budget spent to date on the engineering project.',
    `business_justification` STRING COMMENT 'Strategic rationale and business case for undertaking the engineering project, including expected ROI and market drivers.',
    `capex_opex_classification` STRING COMMENT 'Financial classification of the project budget as capital expenditure, operational expenditure, or a mix of both.. Valid values are `capex|opex|mixed`',
    `project_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the engineering project for identification and tracking across systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `collaboration_partners` STRING COMMENT 'List of external partners, suppliers, or research institutions collaborating on the engineering project.',
    `complexity_score` STRING COMMENT 'Numerical score (1-10) representing the technical and organizational complexity of the engineering project.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the engineering project record was first created in the system.',
    `project_description` STRING COMMENT 'Detailed narrative description of the engineering project objectives, scope, and deliverables.',
    `design_methodology` STRING COMMENT 'Engineering design and development methodology being applied to the project.. Valid values are `agile|waterfall|stage_gate|lean|concurrent_engineering`',
    `design_review_count` STRING COMMENT 'Number of formal design reviews conducted during the engineering project lifecycle.',
    `dfm_analysis_completed` BOOLEAN COMMENT 'Indicates whether Design for Manufacturability analysis has been completed for the engineering project.',
    `dfmea_completed` BOOLEAN COMMENT 'Indicates whether Design Failure Mode and Effects Analysis has been completed for the engineering project.',
    `eco_count` STRING COMMENT 'Total number of Engineering Change Orders issued during the engineering project.',
    `end_date` DATE COMMENT 'Date when the engineering project was officially closed or completed.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the engineering project record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the engineering project record was last modified in the system.',
    `project_name` STRING COMMENT 'Human-readable name of the engineering project describing the initiative or product being developed.',
    `patent_application_count` STRING COMMENT 'Number of patent applications filed as a result of innovations developed in the engineering project.',
    `pfmea_completed` BOOLEAN COMMENT 'Indicates whether Process Failure Mode and Effects Analysis has been completed for the engineering project.',
    `ppap_required` BOOLEAN COMMENT 'Indicates whether Production Part Approval Process is required for the engineering project deliverables.',
    `priority_level` STRING COMMENT 'Business priority ranking assigned to the engineering project for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `program_phase` STRING COMMENT 'Current lifecycle phase of the engineering project within the product development process. [ENUM-REF-CANDIDATE: concept|feasibility|design|development|validation|launch|production|closed — 8 candidates stripped; promote to reference product]',
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
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Engineering project master record representing a discrete R&D or product development initiative. Captures project code, project name, project type (new product development, product improvement, platform, cost reduction), program phase (concept, development, validation, launch), target launch date, project manager, budget allocation, priority, and linked product family. Serves as the organizing entity for all engineering deliverables, prototypes, and design reviews within a development program.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Unique identifier for the engineering test result record. Primary key for the test result entity.',
    `capa_id` BIGINT COMMENT 'Reference to the linked PFMEA record if the test result validates or identifies a process failure mode. Connects test evidence to manufacturing risk analysis.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to product.product_certification. Business justification: Test results are the primary evidence basis for product certifications (UL, CE, RoHS). The certification submission process requires linking test results to the certification they support. Certifica',
    `component_id` BIGINT COMMENT 'Reference to the component or product master record being tested. Links test result to the engineering item definition in PLM system.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Acceptance test results are recorded per customer; linking test_result to customer_account supports customer‑specific quality reports.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Test results are often conducted to validate engineering changes. The existing eco_number (STRING) on test_result is a denormalized text reference to the governing ECO. Replacing it with eco_id FK pro',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Test results are conducted against engineering specifications (acceptance criteria, test methods, performance criteria are defined in the specification). Linking test_result to engineering_specificati',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the primary test equipment or instrumentation used. Links to calibrated equipment register for measurement traceability.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Test results are captured to demonstrate conformity to a specific regulatory requirement.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Quality Assurance links test results to the specific production batch for traceability and regulatory compliance.',
    `original_test_result_id` BIGINT COMMENT 'Reference to the original test result record if this is a retest. Creates traceability chain for test iterations.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: Test execution is scheduled as a project activity; linking test results to the activity enables traceability in the Project Execution Dashboard.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Test results validate a specific revision of a component or assembly. Linking test_result to engineering_revision enables revision-level test traceability: which revision was tested, what the outcomes',
    `acceptance_criteria_lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the test measurement. Defines the lower boundary of the pass/fail acceptance range.',
    `acceptance_criteria_target` DECIMAL(18,2) COMMENT 'Target or nominal value for the test measurement. Represents the ideal design specification value within the acceptance range.',
    `acceptance_criteria_upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the test measurement. Defines the upper boundary of the pass/fail acceptance range.',
    `build_number` STRING COMMENT 'Prototype build iteration number or production batch identifier. Tracks which manufacturing build or prototype iteration the tested unit belongs to.',
    `certification_body` STRING COMMENT 'Name of the regulatory or certification authority for which this test evidence is required (e.g., UL, TUV, CSA, FCC). Applicable when regulatory submission flag is true.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was first created in the system. Audit trail for record lifecycle tracking.',
    `dvp_r_reference` STRING COMMENT 'Reference to the Design Verification Plan and Report document that governs this test. Links test execution to the master validation plan.',
    `environmental_conditions` STRING COMMENT 'Description of environmental conditions during test execution (e.g., temperature, humidity, pressure). Captures test environment context for result interpretation.',
    `failure_description` STRING COMMENT 'Detailed narrative description of any failure, defect, or non-conformance observed during the test. Captures failure mode, symptoms, and conditions. Populated only when test outcome is fail or conditional pass.',
    `failure_mode_code` STRING COMMENT 'Standardized code or identifier for the observed failure mode. Links test failure to DFMEA or PFMEA failure mode catalog for root cause analysis.',
    `measured_value` DECIMAL(18,2) COMMENT 'Primary quantitative measurement or test result value obtained during the test. The principal measured outcome of the test activity.',
    `measured_value_unit` STRING COMMENT 'Unit of measure for the measured value (e.g., volts, amps, degrees Celsius, newtons, cycles). Ensures correct interpretation of test measurements.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` (
    `eco_affected_item_id` BIGINT COMMENT 'Unique identifier for this ECO-component affected item record. Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to the component affected by this ECO',
    `eco_id` BIGINT COMMENT 'Foreign key linking to the engineering change order that affects this component',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this affected item record was added to the ECO. Audit trail for change control compliance.',
    `disposition_action` STRING COMMENT 'Disposition action for this specific component in the context of this ECO: use_as_is, rework, scrap, or retrofit. Determines how existing inventory and WIP of this component should be handled.',
    `effectivity_date` DATE COMMENT 'Date when the engineering change becomes effective for this specific component. May vary by component within the same ECO based on inventory levels and production schedules.',
    `from_revision` STRING COMMENT 'Current revision level of this component before the ECO is applied. Captures the starting point of the revision transition for this component.',
    `implementation_status` STRING COMMENT 'Implementation status for this specific component within the ECO: pending, in_progress, completed, or cancelled. Tracks per-component implementation progress.',
    `item_type` STRING COMMENT 'Type classification of the affected item: part, assembly, drawing, or document. Determines handling procedures and approval workflows.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this affected item record was last modified. Audit trail for change control compliance.',
    `quantity_affected` DECIMAL(18,2) COMMENT 'Quantity of this component in inventory or WIP that is affected by this ECO and subject to the disposition action.',
    `to_revision` STRING COMMENT 'Target revision level of this component after the ECO is implemented. Captures the ending point of the revision transition for this component.',
    CONSTRAINT pk_eco_affected_item PRIMARY KEY(`eco_affected_item_id`)
) COMMENT 'This association product represents the formal linkage between an Engineering Change Order and each component it affects. It captures the specific disposition, effectivity, and revision transition for each component impacted by the ECO. Each record links one ECO to one affected component with attributes that exist only in the context of this change control relationship. This is the SSOT for ECO-component impact tracking per ISO 9001 change control requirements.. Existence Justification: In manufacturing PLM operations, an ECO formally lists multiple affected components (parts, assemblies, drawings), and each component can be affected by multiple ECOs over its lifecycle. The ECO Affected Item is a recognized business entity in all major PLM systems (Siemens Teamcenter, PTC Windchill, Dassault ENOVIA) that captures disposition instructions, effectivity dates, and revision transitions specific to each ECO-component pair. This relationship is actively managed by engineering teams as part of ISO 9001 change control processes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_substitute_component_id` FOREIGN KEY (`substitute_component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_tertiary_engineering_substitute_component_id` FOREIGN KEY (`tertiary_engineering_substitute_component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ADD CONSTRAINT `fk_engineering_revision_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ADD CONSTRAINT `fk_engineering_revision_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ADD CONSTRAINT `fk_engineering_revision_primary_superseded_by_revision_engineering_revision_id` FOREIGN KEY (`primary_superseded_by_revision_engineering_revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ADD CONSTRAINT `fk_engineering_revision_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_superseded_by_specification_engineering_specification_id` FOREIGN KEY (`superseded_by_specification_engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_original_test_result_id` FOREIGN KEY (`original_test_result_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ADD CONSTRAINT `fk_engineering_eco_affected_item_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ADD CONSTRAINT `fk_engineering_eco_affected_item_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`engineering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`engineering` SET TAGS ('dbx_domain' = 'engineering');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` SET TAGS ('dbx_subdomain' = 'product_structure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `substitute_component_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Component ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `cad_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) Model Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `ce_marking_flag` SET TAGS ('dbx_business_glossary_term' = 'Conformité Européenne (CE) Marking Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_number` SET TAGS ('dbx_business_glossary_term' = 'Component Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'raw_material|purchased_part|manufactured_part|sub_assembly|assembly|phantom');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` SET TAGS ('dbx_subdomain' = 'product_structure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `cost_estimate_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CNY|JPY|INR');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `cost_estimate_total` SET TAGS ('dbx_business_glossary_term' = 'Total BOM Cost Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `cost_estimate_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `bom_description` SET TAGS ('dbx_business_glossary_term' = 'BOM Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective To Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_business_glossary_term' = 'BOM Explosion Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_value_regex' = 'single_level|multi_level|summarized');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `is_configurable` SET TAGS ('dbx_business_glossary_term' = 'Configurable BOM Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `is_critical_bom` SET TAGS ('dbx_business_glossary_term' = 'Critical BOM Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `is_phantom_bom` SET TAGS ('dbx_business_glossary_term' = 'Phantom BOM Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'BOM Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_subdomain' = 'product_structure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Item Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `tertiary_engineering_substitute_component_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Component Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `assembly_instruction` SET TAGS ('dbx_business_glossary_term' = 'Assembly Instruction');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `bulk_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Material Flag');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` SET TAGS ('dbx_subdomain' = 'product_structure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `cad_model_id` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) Model ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `dfm_analysis_status` SET TAGS ('dbx_value_regex' = 'Not_Started|In_Progress|Completed|Issues_Found|Approved');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`cad_model` ALTER COLUMN `dfm_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'DFM Complexity Score');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` SET TAGS ('dbx_subdomain' = 'product_structure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `acknowledgement_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `acknowledgement_required` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `actual_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Impact');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `actual_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `actual_schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Schedule Impact Days');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `affected_items_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Items Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `change_priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `change_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'design|material|process|documentation|specification|tooling');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` SET TAGS ('dbx_subdomain' = 'product_structure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `primary_superseded_by_revision_engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Revision Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `cad_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) File Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `ce_marking_required` SET TAGS ('dbx_business_glossary_term' = 'Conformité Européenne (CE) Marking Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `change_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Change Impact Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `change_impact_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `change_justification` SET TAGS ('dbx_business_glossary_term' = 'Change Justification Summary');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `configuration_baseline` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `dfm_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `dfmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `interchangeability_code` SET TAGS ('dbx_business_glossary_term' = 'Interchangeability Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `interchangeability_code` SET TAGS ('dbx_value_regex' = 'fully_interchangeable|form_fit_function|retrofit_required|not_interchangeable');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Revision Label');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `label` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle State');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `mass_production_approved` SET TAGS ('dbx_business_glossary_term' = 'Mass Production Approved');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `pfmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `ppap_level` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `ppap_required` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `prototype_test_date` SET TAGS ('dbx_business_glossary_term' = 'Prototype Test Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `prototype_tested` SET TAGS ('dbx_business_glossary_term' = 'Prototype Tested');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration, Evaluation, Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending_review|non_compliant|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `release_authority` SET TAGS ('dbx_business_glossary_term' = 'Release Authority');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `release_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Release Authority Role');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_value_regex' = 'major|minor|patch|branch|prototype');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `specification_document` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `ul_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Underwriters Laboratories (UL) Certification Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` SET TAGS ('dbx_subdomain' = 'product_structure');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `superseded_by_specification_engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|obsolete|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` SET TAGS ('dbx_subdomain' = 'development_initiatives');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `budget_spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Spent Amount');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `budget_spent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `business_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) / Operational Expenditure (OpEx) Classification');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'capex|opex|mixed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `collaboration_partners` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partners');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Complexity Score');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `design_methodology` SET TAGS ('dbx_business_glossary_term' = 'Design Methodology');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `design_methodology` SET TAGS ('dbx_value_regex' = 'agile|waterfall|stage_gate|lean|concurrent_engineering');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `design_review_count` SET TAGS ('dbx_business_glossary_term' = 'Design Review Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `dfm_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Analysis Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `dfmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Design Failure Mode and Effects Analysis (DFMEA) Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `eco_count` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `patent_application_count` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `pfmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) Completed');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `ppap_required` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Required');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `program_phase` SET TAGS ('dbx_business_glossary_term' = 'Program Phase');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed|archived');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_product_development|product_improvement|platform_development|cost_reduction|sustaining_engineering|technology_research');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `prototype_count` SET TAGS ('dbx_business_glossary_term' = 'Prototype Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `regulatory_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Scope');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `sustainability_target` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `team_size_count` SET TAGS ('dbx_business_glossary_term' = 'Team Size Count');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` SET TAGS ('dbx_subdomain' = 'development_initiatives');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Process Failure Mode and Effects Analysis (PFMEA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `original_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Test Result ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `acceptance_criteria_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Lower Limit');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `acceptance_criteria_target` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Target Value');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `acceptance_criteria_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Upper Limit');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`test_result` ALTER COLUMN `dvp_r_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan and Report (DVP&R) Reference');
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
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` SET TAGS ('dbx_association_edges' = 'engineering.eco,engineering.component');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `eco_affected_item_id` SET TAGS ('dbx_business_glossary_term' = 'ECO Affected Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Affected Item - Component Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Affected Item - Eco Id');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `effectivity_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Date');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `from_revision` SET TAGS ('dbx_business_glossary_term' = 'From Revision');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Item Type');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco_affected_item` ALTER COLUMN `to_revision` SET TAGS ('dbx_business_glossary_term' = 'To Revision');
