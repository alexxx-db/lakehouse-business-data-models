-- Schema for Domain: inventory | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:59:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`inventory` COMMENT 'Inventory and warehouse management domain governing raw materials, WIP, finished goods, SKUs, lot/batch tracking, bin locations, cycle counts, stock movements, JIT inventory control, safety stock optimization, and material handling across all facilities. Integrates SAP WM and Microsoft Dynamics 365 SCM for real-time stock visibility and MRP-driven replenishment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` (
    `stock_location_id` BIGINT COMMENT 'Unique identifier for the physical storage location within warehouses and facilities. Primary key for the stock location master record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Customer site locations are often mapped to physical stock locations for site‑specific inventory allocation.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Consignment inventory tracking requires linking each stock location to the owning customer account for ownership and billing.',
    `node_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_node. Business justification: Required for transport‑network planning: mapping each warehouse bin/location to a logistics node enables routing and dock‑assignment reports.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Directly associate stock_location with its plant for clearer reporting and eliminate redundant plant_code string.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Location-specific regulations (fire, environmental) mandate associating each stock location with the applicable regulatory requirement for audit and reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Location Supervisor role is tracked for picking/replenishment performance and safety audits; linking to employee enables supervisor accountability.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: SUPPLY NETWORK PLANNING: links each stock location to its logistics network node for routing and capacity analysis.',
    `warehouse_id` BIGINT COMMENT 'Reference to the parent warehouse or facility where this storage location resides. Links to the facility master for site-level aggregation and reporting.',
    `abc_classification` STRING COMMENT 'ABC classification of the storage location based on inventory velocity and value. A-class locations store high-velocity or high-value items in the most accessible zones. B-class locations store medium-velocity items. C-class locations store slow-moving items in less accessible areas. Used for warehouse slotting optimization and space allocation.. Valid values are `A|B|C`',
    `access_equipment_required` STRING COMMENT 'Type of material handling equipment required to access this storage location. Determines labor and equipment resource planning for put-away and picking operations. Influences cycle time calculations and warehouse operational efficiency metrics (OEE). [ENUM-REF-CANDIDATE: none|forklift|reach_truck|order_picker|crane|agv|manual — 7 candidates stripped; promote to reference product]',
    `aisle_number` STRING COMMENT 'Aisle identifier within the warehouse zone. Aisles are the primary navigation paths for material handlers and automated guided vehicles (AGVs). Used for directed put-away and optimized picking routes.. Valid values are `^[A-Z0-9]{1,10}$`',
    `bin_position` STRING COMMENT 'Horizontal bin position within the shelf level. Represents the finest granularity of storage location addressing. Used for precise material placement and retrieval in high-density storage environments.. Valid values are `^[A-Z0-9]{1,5}$`',
    `capacity_pallet_positions` STRING COMMENT 'Number of standard pallet positions that can be stored in this location. Used for pallet storage locations to calculate available capacity and optimize warehouse space utilization. Assumes standard pallet dimensions (e.g., 1200mm x 1000mm EUR pallet or 1219mm x 1016mm North American pallet).',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the storage location measured in cubic meters. Used for space utilization analysis, slotting optimization, and warehouse capacity planning. Constrains the physical size of materials that can be stored in this location.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location measured in kilograms. Enforces structural load limits for racks and shelves. Critical for safety compliance and preventing equipment damage. Used in slotting algorithms to match heavy materials with appropriate locations.',
    `created_date` DATE COMMENT 'Date when this storage location record was initially created in the warehouse management system. Used for master data audit trails, location lifecycle tracking, and warehouse expansion analysis.',
    `cycle_count_frequency` STRING COMMENT 'Frequency at which this storage location is scheduled for cycle counting inventory verification. High-value or high-velocity locations typically have higher cycle count frequencies. Used to generate cycle count schedules and ensure inventory accuracy per ISO 9001 quality management requirements.. Valid values are `daily|weekly|monthly|quarterly|annual|on_demand`',
    `deactivation_date` DATE COMMENT 'Date when this storage location was deactivated or retired from operational use. Deactivated locations are no longer available for material placement but may retain historical inventory transaction data. Used for warehouse reconfiguration tracking and capacity planning analysis.',
    `fifo_enforced` BOOLEAN COMMENT 'Boolean flag indicating whether this location enforces First In First Out (FIFO) inventory rotation. FIFO ensures older materials are consumed before newer materials, critical for perishable goods, time-sensitive components, and materials with shelf-life constraints. Used by warehouse management systems (WMS) to generate FIFO-compliant pick instructions.',
    `fire_zone` STRING COMMENT 'Fire safety zone identifier for this storage location. Fire zones group locations by fire suppression system coverage and emergency response protocols. Critical for safety compliance, emergency planning, and hazardous material segregation per OSHA and NFPA standards.. Valid values are `^[A-Z0-9]{1,10}$`',
    `humidity_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether this location maintains controlled humidity levels. Humidity control is critical for materials susceptible to moisture damage, corrosion, or degradation such as electronics, metal components, and hygroscopic materials.',
    `humidity_max_percent` DECIMAL(18,2) COMMENT 'Maximum allowable relative humidity percentage for this storage location. Enforces upper humidity boundary to prevent condensation, corrosion, or mold growth. Typically ranges from 50% to 70% for general storage, lower for electronics.',
    `humidity_min_percent` DECIMAL(18,2) COMMENT 'Minimum allowable relative humidity percentage for this storage location. Enforces lower humidity boundary to prevent static electricity buildup or material desiccation. Typically ranges from 20% to 40% for electronics and sensitive components.',
    `is_hazmat_approved` BOOLEAN COMMENT 'Boolean flag indicating whether this location is certified and approved for storing hazardous materials. Hazmat-approved locations must meet specific safety, ventilation, containment, and regulatory requirements per OSHA and EPA standards. Used to enforce material placement rules for dangerous goods.',
    `is_picking_location` BOOLEAN COMMENT 'Boolean flag indicating whether this location is designated as a primary picking location for order fulfillment. Picking locations are typically positioned in ergonomic zones with high accessibility and are replenished from reserve locations. Used by warehouse management systems (WMS) to optimize pick path generation.',
    `is_replenishment_location` BOOLEAN COMMENT 'Boolean flag indicating whether this location serves as a reserve or bulk storage location that feeds picking locations through replenishment processes. Replenishment locations typically have higher capacity and lower accessibility than picking locations.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent cycle count was performed for this storage location. Used to track cycle count compliance, identify overdue counts, and calculate inventory accuracy metrics. Critical for maintaining inventory integrity and meeting audit requirements.',
    `location_code` STRING COMMENT 'Unique alphanumeric code identifying the storage location within the warehouse. Used for barcode scanning, pick lists, and warehouse management system (WMS) transactions. Typically follows a structured format combining zone, aisle, rack, shelf, and bin identifiers.. Valid values are `^[A-Z0-9]{2,20}$`',
    `location_name` STRING COMMENT 'Human-readable descriptive name for the storage location. Provides business context beyond the technical location code for reporting and user interfaces.',
    `location_status` STRING COMMENT 'Current operational status of the storage location. Active locations are available for material placement and retrieval. Blocked locations are temporarily unavailable due to quality holds, damage, or operational restrictions. Maintenance status indicates the location is undergoing repair or inspection. Reserved status indicates the location is allocated for specific materials or operations. Full status indicates the location has reached capacity.. Valid values are `active|inactive|blocked|maintenance|reserved|full`',
    `location_type` STRING COMMENT 'Classification of the storage location based on its operational purpose within the warehouse. Bulk locations store large quantities, pick locations support order fulfillment, reserve locations hold overflow inventory, staging areas facilitate material movement, quarantine zones isolate non-conforming materials, and cross-dock areas enable direct transfer without storage. [ENUM-REF-CANDIDATE: bulk|pick|reserve|staging|receiving|shipping|quarantine|rework|scrap|kitting|cross_dock — 11 candidates stripped; promote to reference product]',
    `lot_control_required` BOOLEAN COMMENT 'Boolean flag indicating whether materials stored in this location must be tracked by lot or batch number. Lot control is mandatory for materials subject to traceability requirements, expiration date management, or quality recall procedures per ISO 9001 and industry-specific regulations.',
    `mixed_sku_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether this location can store multiple different SKUs simultaneously. Single-SKU locations simplify picking and inventory accuracy but reduce space utilization. Mixed-SKU locations increase storage density but require more sophisticated inventory tracking and picking processes.',
    `modified_date` DATE COMMENT 'Date when this storage location record was last modified. Tracks changes to location attributes such as capacity, status, or environmental requirements. Used for change management, audit compliance, and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational comments about this storage location. May include information about structural issues, access restrictions, special handling requirements, or temporary operational changes not captured in structured fields.',
    `pick_sequence` STRING COMMENT 'Numeric sequence number used to optimize picking routes within the warehouse. Lower numbers indicate locations that should be visited earlier in the pick path. Used by warehouse management systems (WMS) to generate efficient pick lists and minimize travel distance for order fulfillment.',
    `rack_number` STRING COMMENT 'Rack or bay identifier within the aisle. Racks are vertical storage structures containing multiple shelf levels. Critical for coordinate-based bin addressing and warehouse layout optimization.. Valid values are `^[A-Z0-9]{1,10}$`',
    `security_level` STRING COMMENT 'Security classification level for this storage location. Determines access control requirements, surveillance coverage, and material handling authorization levels. High-security locations store valuable materials, controlled substances, or proprietary components requiring enhanced protection.. Valid values are `public|restricted|controlled|high_security`',
    `shelf_level` STRING COMMENT 'Vertical shelf or tier position within the rack (e.g., 1, 2, 3 or A, B, C). Shelf level determines accessibility, ergonomics, and suitability for different material handling equipment. Lower shelves typically used for high-velocity or heavy items.. Valid values are `^[A-Z0-9]{1,5}$`',
    `temperature_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether this location is within a temperature-controlled environment. Temperature-controlled locations are required for materials sensitive to heat, cold, or humidity such as chemicals, electronics, pharmaceuticals, and certain raw materials.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for this storage location measured in degrees Celsius. Enforces upper temperature boundary for temperature-sensitive materials. Exceeding this threshold may trigger quality alerts and material quarantine procedures.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for this storage location measured in degrees Celsius. Enforces lower temperature boundary for temperature-sensitive materials. Used in conjunction with maximum temperature to define the acceptable storage environment range.',
    `x_coordinate` DECIMAL(18,2) COMMENT 'Horizontal X-axis coordinate of the storage location within the warehouse floor plan. Used for warehouse mapping, route optimization, and integration with warehouse automation systems and AGVs. Measured in meters or feet from a defined origin point.',
    `y_coordinate` DECIMAL(18,2) COMMENT 'Horizontal Y-axis coordinate of the storage location within the warehouse floor plan. Used in conjunction with X coordinate for precise location mapping and automated material handling system navigation.',
    `z_coordinate` DECIMAL(18,2) COMMENT 'Vertical Z-axis coordinate representing the height of the storage location above the warehouse floor. Critical for automated storage and retrieval systems (AS/RS) and crane operations. Measured in meters or feet.',
    `zone_code` STRING COMMENT 'High-level zone identifier within the warehouse (e.g., A, B, C or NORTH, SOUTH). Zones group locations by physical area, product category, or operational function to optimize picking routes and material flow.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_stock_location PRIMARY KEY(`stock_location_id`)
) COMMENT 'Master record for all physical storage locations within warehouses and facilities, including bin, rack, shelf, zone, and aisle designations. Captures location type (bulk, pick, reserve, staging), capacity constraints, temperature and environmental requirements, and coordinate-based bin addressing. Serves as the single source of truth for all bin-level location data used for real-time stock placement, retrieval, and directed put-away across all manufacturing facilities.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Unique identifier for the warehouse facility. Primary key for the warehouse master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Warehouse Operations process requires a designated manager for each warehouse; manager appears on safety and performance reports, making the link essential.',
    `node_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_node. Business justification: Warehouse is a physical node in the supply‑chain network; linking supports route optimization and carrier‑selection decision models.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Warehouse belongs to a plant; adding plant_id enables hierarchy without creating a cycle.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Warehouse operations must comply with permits and safety standards; linking warehouses to regulatory requirements enables compliance tracking per facility.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: REGIONAL CAPACITY PLANNING: ties warehouses to supply‑chain nodes to allocate inventory across the network.',
    `active_from_date` DATE COMMENT 'Date when the warehouse facility became operational and available for inventory storage. Marks the start of the facility lifecycle.',
    `active_to_date` DATE COMMENT 'Date when the warehouse facility ceased operations or was decommissioned. Null for currently active facilities. Used for historical reporting and capacity planning.',
    `address_line_1` STRING COMMENT 'Primary street address of the warehouse facility. First line of the physical location address.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number, suite, or floor. Optional additional address detail.',
    `automated_storage_flag` BOOLEAN COMMENT 'Indicates whether the warehouse uses automated storage and retrieval systems (AS/RS). Impacts throughput rates, labor requirements, and integration with WMS and MES.',
    `city` STRING COMMENT 'City or municipality where the warehouse facility is located.',
    `climate_controlled_flag` BOOLEAN COMMENT 'Indicates whether the warehouse has climate control capabilities for temperature and humidity-sensitive materials. Critical for pharmaceutical, electronic component, and chemical storage compliance.',
    `warehouse_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the warehouse facility. Used in SAP WM and Microsoft Dynamics 365 SCM for warehouse identification and cross-system integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `contact_email` STRING COMMENT 'Primary email address for warehouse operational communication. Used for shipment notifications, inventory alerts, and administrative correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the warehouse facility. Used for carrier coordination, emergency contact, and operational communication.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the warehouse is located. Used for customs, tax, and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse master record was first created in the system. Used for data lineage and audit trail.',
    `customs_bonded_flag` BOOLEAN COMMENT 'Indicates whether the warehouse is a customs-bonded facility authorized to store imported goods before duty payment. Critical for international supply chain and duty deferral strategies.',
    `erp_plant_code` STRING COMMENT 'ERP system plant code associated with this warehouse. Links warehouse to manufacturing plant in SAP S/4HANA for MRP and production planning integration.',
    `facility_type` STRING COMMENT 'Classification of the warehouse based on the primary type of inventory stored. Determines storage requirements, handling procedures, and integration with MRP and MES systems.. Valid values are `raw_material|work_in_progress|finished_goods|distribution_center|cross_dock|returns_processing`',
    `fire_suppression_system_type` STRING COMMENT 'Type of fire suppression system installed in the warehouse. Critical for insurance, safety compliance, and determining storage eligibility for flammable materials.. Valid values are `sprinkler|foam|gas|dry_chemical|none`',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the warehouse is certified to store hazardous materials. Determines eligibility for storing chemicals, flammables, and regulated substances per OSHA and EPA requirements.',
    `hazmat_storage_classes` STRING COMMENT 'Comma-separated list of hazardous material storage classes the warehouse is certified to handle (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Based on UN hazard classification system.',
    `iso_14001_certified_flag` BOOLEAN COMMENT 'Indicates whether the warehouse facility holds ISO 14001 environmental management system certification. Demonstrates commitment to environmental sustainability and regulatory compliance.',
    `iso_9001_certified_flag` BOOLEAN COMMENT 'Indicates whether the warehouse facility holds ISO 9001 quality management system certification. Impacts supplier qualification and customer audit requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse master record was last updated. Used for change tracking and data synchronization across systems.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the warehouse facility. Used for logistics optimization, route planning, and TMS integration.',
    `lease_expiration_date` DATE COMMENT 'Date when the warehouse lease agreement expires. Null for owned facilities. Used for facility planning and contract renewal management.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the warehouse facility. Used for logistics optimization, route planning, and TMS integration.',
    `warehouse_name` STRING COMMENT 'Full business name of the warehouse facility. Human-readable identifier used in operational documentation and reporting.',
    `number_of_loading_docks` STRING COMMENT 'Total count of loading and unloading dock positions. Determines receiving and shipping throughput capacity.',
    `number_of_storage_bins` STRING COMMENT 'Total count of discrete storage bin locations within the warehouse. Used for bin location management and inventory tracking granularity in SAP WM.',
    `operating_hours_description` STRING COMMENT 'Textual description of standard operating hours and shift patterns (e.g., 24/7, Monday-Friday 8am-5pm, Three-shift operation). Used for carrier scheduling and labor planning.',
    `operational_status` STRING COMMENT 'Current operational state of the warehouse facility. Determines availability for inventory allocation and order fulfillment operations.. Valid values are `active|inactive|under_construction|decommissioned|seasonal|maintenance`',
    `ownership_type` STRING COMMENT 'Classification of warehouse ownership model. Determines financial accounting treatment, CapEx vs OpEx allocation, and operational control level.. Valid values are `owned|leased|third_party_logistics|contract_warehouse`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the warehouse facility address. Used for logistics routing and carrier integration.',
    `record_source_system` STRING COMMENT 'Identifier of the source system that created or owns this warehouse master record (e.g., SAP_S4HANA, DYNAMICS_365_SCM, MDM). Used for data lineage and system-of-record identification.',
    `security_level` STRING COMMENT 'Classification of physical security measures and access controls at the warehouse. Determines eligibility for storing high-value goods, controlled substances, and export-controlled items.. Valid values are `standard|enhanced|high_security|bonded`',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the warehouse is located.',
    `storage_area_square_meters` DECIMAL(18,2) COMMENT 'Floor area dedicated to inventory storage in square meters. Excludes receiving docks, shipping areas, and administrative space.',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature that can be maintained in climate-controlled zones, measured in Celsius. Used for material storage requirement validation.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature that can be maintained in climate-controlled zones, measured in Celsius. Used for material storage requirement validation.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the warehouse location (e.g., America/New_York, Europe/Berlin). Used for scheduling, shift planning, and cross-facility coordination.',
    `total_capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Total storage capacity of the warehouse measured in cubic meters. Represents maximum volumetric storage capability for inventory planning and capacity utilization analysis.',
    `total_floor_area_square_meters` DECIMAL(18,2) COMMENT 'Total floor area of the warehouse facility in square meters. Includes storage, receiving, shipping, and administrative areas.',
    `usable_capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Actual usable storage capacity after accounting for aisles, equipment, and operational space. Used for realistic inventory allocation and safety stock calculations.',
    `wms_system_code` STRING COMMENT 'Code identifying the WMS system deployed at this warehouse (e.g., SAP_WM, DYNAMICS_365_SCM, MANHATTAN). Used for system integration routing and data synchronization.',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master record for each physical warehouse or storage facility in the manufacturing network. Captures warehouse code, name, address, facility type (raw material, WIP, finished goods, distribution), total capacity, climate control capabilities, and operational status. Serves as the top-level organizational unit for all inventory storage hierarchies and warehouse management operations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key for the material master data product.',
    `hazardous_substance_id` BIGINT COMMENT 'Foreign key linking to compliance.hazardous_substance. Business justification: Regulatory reporting of hazardous chemicals requires linking each material master to its hazardous substance record for REACH/OSHA compliance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Linking materials to profit centers enables product‑level profitability reporting and budget planning.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for production planning and cost roll‑up reports that map inventory material to the SKU definition used in sales orders and cost accounting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Preferred supplier per material is required for MRP planning and procurement contracts; experts expect a default vendor_id on material_master.',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management prioritization. A items are high-value requiring tight control, B items are moderate-value, C items are low-value with relaxed controls. Used for cycle counting frequency and safety stock strategies.. Valid values are `A|B|C`',
    `base_unit_of_measure` STRING COMMENT 'Primary unit in which the material is managed in inventory and production. Examples: EA (each), KG (kilogram), L (liter), M (meter). All stock quantities are maintained in this unit.. Valid values are `^[A-Z]{2,3}$`',
    `batch_management_indicator` BOOLEAN COMMENT 'Flag indicating whether the material requires batch or lot tracking. When active, all inventory transactions must reference a batch number for full traceability and quality control.',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system. Used for audit trail and material lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for material valuation. Examples: USD, EUR, GBP. All prices and values are maintained in this currency.. Valid values are `^[A-Z]{3}$`',
    `dimension_unit` STRING COMMENT 'Unit of measure for length, width, and height dimensions. Examples: MM (millimeter), CM (centimeter), M (meter), IN (inch).. Valid values are `^[A-Z]{2,3}$`',
    `goods_receipt_processing_time_days` STRING COMMENT 'Time required for quality inspection and goods receipt posting after physical delivery. Added to planned delivery time for total procurement lead time.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the material including all packaging. Used for logistics planning, freight calculation, and warehouse capacity management.',
    `hazard_class` STRING COMMENT 'Classification of hazardous material type per UN/DOT regulations. Examples: flammable liquid, corrosive, toxic, oxidizer. Determines packaging, labeling, and shipping requirements.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous. Triggers additional safety, handling, storage, and transportation requirements per OSHA and EPA regulations.',
    `height` DECIMAL(18,2) COMMENT 'Height dimension of the material. Used for storage bin assignment, handling equipment selection, and transportation planning.',
    `inspection_setup_indicator` BOOLEAN COMMENT 'Flag indicating whether incoming goods require quality inspection before stock placement. Triggers QM (Quality Management) inspection lot creation at goods receipt.',
    `last_modified_by` STRING COMMENT 'User ID of the person who last modified the material master record. Used for audit trail and data governance.',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last changed. Used for audit trail and change management tracking.',
    `length` DECIMAL(18,2) COMMENT 'Length dimension of the material. Used for storage bin assignment, handling equipment selection, and transportation planning.',
    `lot_size` STRING COMMENT 'Lot-sizing procedure code determining how procurement or production quantities are calculated. Examples: EX (exact order quantity), FX (fixed lot size), HB (lot-for-lot).. Valid values are `^[A-Z0-9]{2,4}$`',
    `manufacturer_name` STRING COMMENT 'Name of the original manufacturer or OEM (Original Equipment Manufacturer) of the material. Used for quality tracking, warranty claims, and supplier management.',
    `manufacturer_part_number` STRING COMMENT 'Original part number assigned by the manufacturer or OEM (Original Equipment Manufacturer). Used for cross-referencing, procurement, and technical documentation.',
    `material_description` STRING COMMENT 'Full textual description of the material including key characteristics, specifications, and usage. Used for identification and communication across procurement, production, and sales.',
    `material_group` STRING COMMENT 'Hierarchical classification code grouping materials with similar characteristics for procurement, planning, and reporting purposes. Used in MRP (Material Requirements Planning) and purchasing strategies.. Valid values are `^[A-Z0-9]{4,10}$`',
    `material_number` STRING COMMENT 'Unique business identifier for the material assigned by the enterprise. This is the externally-known SKU (Stock Keeping Unit) code used across all systems and documentation.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material master record. Controls whether the material can be procured, produced, or sold. Blocked materials cannot be used in new transactions.. Valid values are `active|blocked|obsolete|phase_out|restricted|pending_approval`',
    `material_type` STRING COMMENT 'Classification of the material based on its role in the manufacturing and supply chain process. Determines procurement, production, and inventory management rules. [ENUM-REF-CANDIDATE: raw_material|semi_finished|finished_good|trading_good|spare_part|consumable|packaging_material|service — 8 candidates stripped; promote to reference product]',
    `maximum_lot_size` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or produced in a single transaction. Constrained by storage capacity, shelf life, or supplier limitations.',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or produced in a single transaction. Driven by supplier MOQ (Minimum Order Quantity) or production setup constraints.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life required at goods receipt. Materials with less remaining shelf life are rejected. Ensures adequate usable life for production and customer delivery.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Weighted average cost per base unit of measure, recalculated with each goods receipt. Used when price control is set to moving average price.',
    `mrp_type` STRING COMMENT 'MRP procedure code controlling how the material is planned. Determines reorder point planning, forecast-based planning, or time-phased planning methods.. Valid values are `^[A-Z0-9]{2,4}$`',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the material itself excluding packaging. Used for production planning, yield calculations, and material consumption tracking.',
    `planned_delivery_time_days` STRING COMMENT 'Expected lead time in days from order placement to goods receipt. Used by MRP to calculate order release dates. Includes supplier lead time and internal processing time.',
    `price_control_indicator` STRING COMMENT 'Defines material valuation method. S = standard price (fixed cost), V = moving average price (recalculated with each goods receipt). Determines inventory valuation approach.. Valid values are `S|V`',
    `price_unit` STRING COMMENT 'Quantity unit for which the price is maintained. Example: if price is $100 per 1000 units, price unit is 1000. Allows fractional pricing for low-cost materials.',
    `procurement_type` STRING COMMENT 'Defines whether the material is manufactured internally, purchased externally, or both. Controls MRP (Material Requirements Planning) logic and sourcing decisions.. Valid values are `in_house_production|external_procurement|both`',
    `product_hierarchy` STRING COMMENT 'Multi-level classification structure organizing materials into product families and categories. Used for sales reporting, forecasting, and product portfolio management.. Valid values are `^[A-Z0-9]{5,18}$`',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers automatic replenishment. When stock falls below this level, MRP generates procurement proposals. Critical for JIT (Just In Time) inventory control.',
    `safety_stock` DECIMAL(18,2) COMMENT 'Minimum inventory buffer maintained to protect against demand variability and supply disruptions. Never falls below this level under normal planning. Used in safety stock optimization algorithms.',
    `serial_number_profile` STRING COMMENT 'Configuration code defining serial number management requirements. Determines whether material requires unique serial number tracking for traceability, warranty, and asset management.. Valid values are `^[A-Z0-9]{4}$`',
    `shelf_life_expiration_days` STRING COMMENT 'Total shelf life of the material from production or goods receipt date. After this period, material expires and cannot be used. Critical for perishable materials and chemicals.',
    `standard_price` DECIMAL(18,2) COMMENT 'Fixed valuation price per base unit of measure. Used when price control is set to standard price. Updated periodically through cost accounting processes.',
    `storage_conditions` STRING COMMENT 'Required environmental conditions for material storage. Examples: temperature range, humidity control, light protection, hazardous material segregation. Used for warehouse bin assignment and handling instructions.',
    `temperature_conditions` STRING COMMENT 'Specific temperature range requirements for storage and transportation. Examples: ambient, refrigerated (2-8°C), frozen (-20°C), controlled room temperature (15-25°C).',
    `valuation_class` STRING COMMENT 'Accounting classification code linking material to general ledger accounts. Determines which GL (General Ledger) accounts are posted for inventory movements and consumption.. Valid values are `^[0-9]{4}$`',
    `volume` DECIMAL(18,2) COMMENT 'Physical volume occupied by the material. Used for warehouse space planning, container loading optimization, and transportation planning.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume field. Examples: L (liter), M3 (cubic meter), GAL (gallon).. Valid values are `^[A-Z]{2,3}$`',
    `weight_unit` STRING COMMENT 'Unit of measure for gross and net weight fields. Examples: KG (kilogram), LB (pound), TON (metric ton).. Valid values are `^[A-Z]{2,3}$`',
    `width` DECIMAL(18,2) COMMENT 'Width dimension of the material. Used for storage bin assignment, handling equipment selection, and transportation planning.',
    `created_by` STRING COMMENT 'User ID of the person who created the material master record. Used for audit trail and data governance.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Authoritative master record for every raw material, component, sub-assembly, WIP item, and finished good managed in inventory. Captures SKU code, material description, material type (raw, semi-finished, finished), base unit of measure, weight, dimensions, shelf life, hazardous material classification, planning type, reorder point, safety stock level, ABC classification, and storage conditions. Serves as the single source of truth for material identity and attributes referenced by all inventory transactions, stock balances, and planning processes across the enterprise.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` (
    `stock_balance_id` BIGINT COMMENT 'Unique identifier for the stock balance record. Primary key for the stock balance entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost‑center accounting of on‑hand inventory supports internal cost reporting and variance analysis per production site.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑owned stock balances (e.g., VMI) need a FK to the customer account for reporting on on‑hand quantities per customer.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Stock balance includes inspection status; linking to the specific inspection lot enables detailed traceability for quality release decisions.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which this stock balance is maintained. Links to the material product in the Product Engineering domain.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: INVENTORY RECONCILIATION: each stock balance snapshot is associated with the MRP run that calculated it.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the stock is physically located. Links to the plant master data.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Project Material Reservation Report requires tracking inventory reserved for each project to ensure accurate cost allocation.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location within the plant where the material is stored. Links to storage location master data.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Consignment stock ownership must be tracked; vendor_id links stock_balance to the supplying vendor for liability and reporting.',
    `abc_classification` STRING COMMENT 'ABC analysis classification based on material value and consumption. A items are high-value/high-usage requiring tight control; B items are moderate; C items are low-value/low-usage with relaxed control.. Valid values are `A|B|C`',
    `available_quantity` DECIMAL(18,2) COMMENT 'Quantity available for new orders or production, calculated as unrestricted quantity on hand minus reserved quantity. Used for Available-to-Promise (ATP) calculations.',
    `batch_number` STRING COMMENT 'Batch or lot number for batch-managed materials. Used for traceability and quality control. Null for non-batch-managed materials.',
    `blocked_reason_code` STRING COMMENT 'Code indicating the reason why stock is blocked from use. Examples include quality hold, pending investigation, customer return, damaged goods, regulatory hold. Null if stock is not blocked.',
    `consignment_indicator` BOOLEAN COMMENT 'Flag indicating whether this stock is consignment stock owned by the supplier but held at the customer location. True for consignment stock; false for own stock.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this stock balance record was first created in the system. Used for audit trail and data lineage tracking.',
    `expiration_date` DATE COMMENT 'Date after which the material should not be used due to shelf life limitations. Applicable for perishable materials, chemicals, and time-sensitive components. Null for non-expiring materials.',
    `inventory_turnover_days` STRING COMMENT 'Average number of days this material remains in stock before being consumed or sold. Calculated as (quantity on hand / average daily usage). Used for inventory performance KPI tracking.',
    `last_count_variance_quantity` DECIMAL(18,2) COMMENT 'Difference between book quantity and physical count quantity from the last inventory count. Positive values indicate surplus; negative values indicate shortage.',
    `last_goods_issue_date` DATE COMMENT 'Date of the most recent goods issue transaction that decreased stock for this material at this location. Used for inventory turnover analysis.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt transaction that increased stock for this material at this location. Used for inventory aging analysis.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count performed for this material at this location. Used to track count frequency and compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this stock balance record was last modified. Updated with each stock movement transaction. Used for change tracking and data freshness monitoring.',
    `manufacture_date` DATE COMMENT 'Date when the material or batch was manufactured or produced. Used for traceability and shelf life calculations. Applicable for batch-managed materials.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Upper limit for stock quantity to prevent overstocking and excess inventory carrying costs. Used in inventory optimization and replenishment planning.',
    `obsolete_indicator` BOOLEAN COMMENT 'Flag indicating whether this material is classified as obsolete and should be phased out or written off. True if material is no longer used in production or sales.',
    `period_end_snapshot_date` DATE COMMENT 'Date representing the period-end for which this stock balance snapshot was captured. Used for month-end, quarter-end, and year-end inventory reporting and financial close processes.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current physical quantity of material available in this storage location and stock category. Measured in the materials base unit of measure.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Stock level at which a replenishment order should be triggered. Calculated based on lead time demand and safety stock requirements.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of material reserved for specific sales orders, production orders, or other commitments. Reduces available-to-promise quantity.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum stock level maintained as buffer against demand variability and supply disruptions. Used in MRP calculations and reorder point determination.',
    `slow_moving_indicator` BOOLEAN COMMENT 'Flag indicating whether this material is classified as slow-moving based on consumption patterns. True if no movement in the defined threshold period (e.g., 90 days).',
    `source_system_key` STRING COMMENT 'Natural key or unique identifier from the source operational system. Used for data lineage, reconciliation, and troubleshooting integration issues.',
    `special_stock_type` STRING COMMENT 'Classification of special stock scenarios. Standard is regular stock; consignment is supplier-owned; project stock is allocated to specific projects; sales order stock is customer-specific; subcontracting is at vendor location; returnable packaging is reusable containers.. Valid values are `standard|consignment|project|sales_order|subcontracting|returnable_packaging`',
    `stock_category` STRING COMMENT 'Classification of stock availability status. Unrestricted stock is available for use; quality inspection stock is pending QA approval; blocked stock cannot be used; in-transit stock is moving between locations; reserved stock is allocated to specific orders or production.. Valid values are `unrestricted|quality_inspection|blocked|in_transit|reserved`',
    `stock_status` STRING COMMENT 'Overall status of the stock balance record. Active indicates normal operations; frozen indicates temporary hold; blocked indicates quality or compliance issues; pending disposal indicates scheduled for write-off or scrap.. Valid values are `active|frozen|blocked|pending_disposal`',
    `stock_type` STRING COMMENT 'Classification of material by its role in the production process. Raw material is input to production; WIP is work in progress; finished goods are ready for sale; semi-finished are intermediate products; spare parts support maintenance; packaging materials; MRO is maintenance, repair, and operations supplies. [ENUM-REF-CANDIDATE: raw_material|wip|finished_goods|semi_finished|spare_parts|packaging|mro — 7 candidates stripped; promote to reference product]',
    `total_stock_value` DECIMAL(18,2) COMMENT 'Total financial value of the stock on hand, calculated as quantity on hand multiplied by valuation price. Used for inventory valuation reporting and balance sheet preparation.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for the quantity on hand. Examples include EA (each), KG (kilogram), L (liter), M (meter), etc.',
    `valuation_class` STRING COMMENT 'Financial accounting classification used to determine the general ledger accounts for inventory postings. Links material movements to specific GL accounts for financial reporting.',
    `valuation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation price. Typically the plant or company code currency.. Valid values are `^[A-Z]{3}$`',
    `valuation_price` DECIMAL(18,2) COMMENT 'Standard or moving average price used to value the stock for financial reporting. Price per base unit of measure.',
    `vendor_batch_number` STRING COMMENT 'Batch or lot number assigned by the supplier for purchased materials. Used for supplier traceability and quality issue resolution.',
    `warehouse_bin_location` STRING COMMENT 'Specific bin, rack, or shelf location within the storage location where the material is physically stored. Used for warehouse picking and putaway operations.',
    CONSTRAINT pk_stock_balance PRIMARY KEY(`stock_balance_id`)
) COMMENT 'Current and period-end stock balance record capturing on-hand quantity by stock category (unrestricted, quality inspection, blocked, in-transit, reserved) for each material at each storage location. Tracks valuation price, total stock value, last physical count date, and last movement date. Serves as the single source of truth for real-time stock position used by material planning, available-to-promise calculations, and inventory reporting across all facilities.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` (
    `lot_batch_id` BIGINT COMMENT 'Unique identifier for the lot or batch record. Primary key for lot and batch master data tracking.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Regulated batch tracking often requires associating a batch with the specific customer that ordered it.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record that this lot or batch belongs to. Links to the material product for which batch management is enabled.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Lot_batch records the originating plant; a foreign key enforces referential integrity.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the production order under which this batch was manufactured. Links batch to specific manufacturing execution records for full production traceability.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order under which this batch was procured from an external supplier. Applicable only to purchased materials and components.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Batch production in regulated industries (pharma, chemicals) is subject to specific regulatory requirements; linking batches to those requirements supports batch release compliance.',
    `stock_location_id` BIGINT COMMENT 'Reference to the primary storage location or warehouse where this batch is currently stored. Supports location-based inventory tracking and warehouse management.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who provided this batch for purchased materials. Null for internally manufactured batches. Supports supplier quality tracking and traceability.',
    `available_quantity` DECIMAL(18,2) COMMENT 'The current unrestricted quantity of this batch available for use in production or shipment. Updated in real-time based on goods movements, consumption, and quality status changes.',
    `batch_classification` STRING COMMENT 'The material type classification for this batch indicating its stage in the production process. Used for inventory segmentation and MRP planning logic.. Valid values are `raw_material|work_in_progress|finished_goods|semi_finished|packaging`',
    `batch_cost_amount` DECIMAL(18,2) COMMENT 'The total production or procurement cost for this batch in the company currency. Used for inventory valuation, cost of goods sold calculation, and financial reporting per IFRS/GAAP standards.',
    `batch_notes` STRING COMMENT 'Free-text field for capturing additional information, special handling instructions, quality observations, or deviation notes specific to this batch. Used by production, quality, and warehouse personnel.',
    `batch_number` STRING COMMENT 'The unique alphanumeric identifier assigned to this specific lot or batch. This is the externally-known business identifier used across procurement, production, quality, and shipment processes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_status` STRING COMMENT 'Current lifecycle status of the batch indicating its usability. Unrestricted: available for use; Quality Inspection: under QA review; Restricted: limited use with approval; Blocked: not available for use due to quality or compliance issues.. Valid values are `unrestricted|quality_inspection|restricted|blocked`',
    `blocked_quantity` DECIMAL(18,2) COMMENT 'The quantity of this batch that is blocked and not available for any use. Set when batch fails quality inspection or is subject to hold for investigation per CAPA or NCR processes.',
    `created_by_user` STRING COMMENT 'The user ID or username of the person who created this batch record. Audit field for accountability and data governance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this batch record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the batch cost amount. Typically the company code currency for manufactured batches or purchase order currency for procured batches.. Valid values are `^[A-Z]{3}$`',
    `customer_batch_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this batch must be tracked and reported to customers on shipping documents and certificates of analysis. True when customer contracts require batch-level traceability.',
    `expiry_date` DATE COMMENT 'The date after which the batch should not be used due to degradation, safety, or regulatory constraints. Applicable to materials with limited shelf life such as chemicals, adhesives, and perishable components.',
    `goods_receipt_date` DATE COMMENT 'The date when this batch was received into inventory via goods receipt posting. Marks the start of inventory availability and shelf life tracking for purchased materials.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this batch contains hazardous materials requiring special handling, storage, and transportation per OSHA and EPA regulations. True for materials classified as dangerous goods.',
    `last_goods_movement_date` DATE COMMENT 'The date of the most recent goods movement transaction for this batch (receipt, issue, transfer, or adjustment). Used for inventory aging analysis and slow-moving stock identification.',
    `last_modified_by_user` STRING COMMENT 'The user ID or username of the person who last modified this batch record. Audit field for accountability and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this batch record was last updated. Audit field for change tracking and data quality monitoring.',
    `manufacturing_date` DATE COMMENT 'The date on which this batch was produced or manufactured. Critical for shelf life calculation, expiry determination, and lot traceability per ISO 9001 and PPAP requirements.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country of origin for this batch. Required for customs, trade compliance, and country-of-origin labeling.. Valid values are `^[A-Z]{3}$`',
    `quality_certificate_number` STRING COMMENT 'The certificate number or document identifier for the quality certificate issued for this batch. Required for customer shipments and regulatory compliance documentation.',
    `quality_decision` STRING COMMENT 'The final quality decision for this batch based on inspection results. Accepted: meets all specifications; Rejected: fails quality criteria; Conditional: accepted with restrictions; Pending: awaiting inspection completion.. Valid values are `accepted|rejected|conditional|pending`',
    `quantity_produced` DECIMAL(18,2) COMMENT 'The total quantity of material produced in this batch, expressed in the base unit of measure for the material. Used for inventory valuation and yield analysis.',
    `restricted_quantity` DECIMAL(18,2) COMMENT 'The quantity of this batch that is restricted and requires special approval for use. Typically set during quality inspection or when quality issues are identified.',
    `shelf_life_expiration_date` DATE COMMENT 'The calculated shelf life expiration date based on manufacturing date and material-specific shelf life duration. Used in SAP MM for automatic batch determination and FEFO (First Expired First Out) logic.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types such as consignment stock, project stock, or customer stock. Used for specialized inventory management scenarios and ownership tracking.',
    `supplier_batch_number` STRING COMMENT 'The batch or lot number assigned by the supplier or vendor for raw materials and purchased components. Used for upstream traceability and supplier quality management.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity produced (e.g., KG for kilograms, EA for each, L for liters, M for meters). Aligns with material master UOM configuration.. Valid values are `^[A-Z]{2,6}$`',
    `valuation_type` STRING COMMENT 'The valuation type or split valuation indicator for this batch when multiple valuations exist for the same material (e.g., domestic vs. imported, new vs. refurbished). Used for financial accounting and cost segregation.',
    CONSTRAINT pk_lot_batch PRIMARY KEY(`lot_batch_id`)
) COMMENT 'Lot and batch master record for materials subject to batch management, capturing batch number, material reference, manufacturing date, expiry date, shelf life expiration date (SLED), batch status (unrestricted, restricted, blocked), origin plant, supplier batch number, and quality inspection results. Supports full lot traceability from raw material receipt through production and customer shipment per ISO 9001 and PPAP requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for each stock movement transaction. Primary key for the stock movement data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each inventory movement is charged to a cost center for activity‑based costing; the FK enables accurate cost allocation in the general ledger.',
    `customer_account_id` BIGINT COMMENT 'Foreign key reference to the customer when this movement is a goods issue for sales delivery or a return from customer.',
    `delivery_id` BIGINT COMMENT 'Foreign key reference to the outbound delivery document when this movement is part of a shipment to customer.',
    `employee_id` BIGINT COMMENT 'System user ID of the person who created or posted this stock movement transaction, supporting accountability and audit requirements.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Goods movements that trigger inspections must reference the inspection lot to associate movement data with inspection outcomes, used in compliance reporting.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Goods‑issue movement must be tied to the invoicing event for revenue recognition and downstream reporting.',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record representing the SKU, raw material, WIP component, or finished good that was moved.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the sales order when this movement is a goods issue for customer delivery.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Stock movement occurs within a plant; adding plant_id enforces correct plant association.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key reference to the production order when this movement is a goods issue to manufacturing or a goods receipt from production.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Project material issue/receipt movements are reported in the Project Material Movement report for traceability.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the purchase order when this movement is a goods receipt from procurement.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Shipment‑movement reconciliation report requires tying each inventory posting to the originating shipment for traceability and audit.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Link stock movement to its source location for traceability; replace free‑text code with FK.',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier when this movement is a goods receipt from external procurement.',
    `batch_number` STRING COMMENT 'Lot or batch number for batch-managed materials, enabling traceability for quality control, expiration management, and recall scenarios.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this stock movement record was first created in the system.',
    `destination_bin_location` STRING COMMENT 'Specific bin, shelf, or warehouse location identifier to which the material was placed or moved.',
    `destination_storage_location_code` STRING COMMENT 'For transfer movements, the receiving storage location to which the material was moved.. Valid values are `^[A-Z0-9]{4}$`',
    `document_date` DATE COMMENT 'The date on the source document (e.g., delivery note, production confirmation) that triggered this stock movement. May differ from posting date due to processing delays.',
    `entry_timestamp` TIMESTAMP COMMENT 'The precise date and time when this stock movement record was created in the system, capturing the moment of transaction entry.',
    `gl_account_code` STRING COMMENT 'General ledger account number to which the inventory value change is posted for financial accounting integration.. Valid values are `^[0-9]{10}$`',
    `goods_issue_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this movement decreases inventory (goods issue scenario).',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this movement increases inventory (goods receipt scenario).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this stock movement record was last updated, supporting change tracking and audit trail requirements.',
    `material_document_item` STRING COMMENT 'Line item number within the material document, representing the sequence of this movement within a multi-line transaction.',
    `material_document_number` STRING COMMENT 'The externally-known SAP material document number that uniquely identifies this inventory movement transaction in the ERP system. This is the business identifier used for audit trails and cross-system reconciliation.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year of the material document posting, used in combination with material document number for unique identification in SAP systems.',
    `material_number` STRING COMMENT 'The business material number (SKU) identifying the specific product, component, or raw material involved in this movement.. Valid values are `^[A-Z0-9]{18}$`',
    `movement_indicator` STRING COMMENT 'High-level classification of the movement direction: receipt (inbound), issue (outbound), transfer (location-to-location), or adjustment (correction/write-off).. Valid values are `receipt|issue|transfer|adjustment`',
    `movement_reason_code` STRING COMMENT 'Code explaining the business reason for the movement (e.g., damaged goods, quality defect, process scrap, customer return, inventory correction). Used for root cause analysis and continuous improvement.',
    `movement_status` STRING COMMENT 'Current lifecycle status of the stock movement transaction: posted (completed and effective), pending (awaiting confirmation), cancelled (voided before posting), or reversed (corrected after posting).. Valid values are `posted|pending|cancelled|reversed`',
    `movement_type_code` STRING COMMENT 'Three-digit SAP movement type code that classifies the nature of the inventory transaction (e.g., 101=Goods Receipt from PO, 261=Goods Issue to Production Order, 311=Transfer Posting, 551=Scrapping). This code determines the accounting impact and stock ledger behavior.. Valid values are `^[0-9]{3}$`',
    `posting_date` DATE COMMENT 'The date on which the stock movement was posted to the inventory ledger and became effective for stock balance and financial accounting purposes. This is the principal business event timestamp for the transaction.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material moved in this transaction, expressed in the base unit of measure. Positive for receipts, negative for issues in some system configurations.',
    `reference_document_item` STRING COMMENT 'Line item number within the reference document that corresponds to this stock movement.',
    `reference_document_number` STRING COMMENT 'The document number of the source transaction (e.g., purchase order number, production order number, sales order number) that initiated this stock movement.',
    `reference_document_type` STRING COMMENT 'Type of source document that triggered this stock movement (e.g., purchase order for goods receipt, production order for goods issue, delivery for shipment). [ENUM-REF-CANDIDATE: purchase_order|production_order|sales_order|delivery|transfer_order|physical_inventory|reservation — 7 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this movement is a reversal (correction) of a previously posted transaction.',
    `reversed_material_document_number` STRING COMMENT 'The material document number of the original transaction that this movement reverses, establishing audit trail linkage for corrections.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized materials, providing individual unit-level traceability for high-value or regulated items.',
    `source_bin_location` STRING COMMENT 'Specific bin, shelf, or warehouse location identifier from which the material was picked or moved, enabling precise warehouse management and cycle count accuracy.',
    `special_stock_indicator` STRING COMMENT 'Code indicating special stock categories such as consignment stock, project stock, sales order stock, or returnable packaging.',
    `stock_type` STRING COMMENT 'Classification of the stock status: unrestricted (available for use), quality_inspection (awaiting QA approval), blocked (not usable), or restricted (limited use).. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `storage_location_code` STRING COMMENT 'Code identifying the storage location (warehouse, stockroom, or inventory area) within the plant where the material is stored or was moved from.. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the quantity is expressed (e.g., EA=Each, KG=Kilogram, L=Liter, M=Meter). Follows ISO standard UOM codes.. Valid values are `^[A-Z]{2,3}$`',
    `valuation_type` STRING COMMENT 'Split valuation indicator used when the same material is valued differently based on procurement type or quality grade (e.g., own production vs. external procurement).',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record of every inventory movement event including goods receipts, goods issues, stock transfers, internal transfers between bins, returns, adjustments, write-offs, and scrapping. Captures movement type code, quantity, unit of measure, source and destination storage locations, plant, cost center, reference document (purchase order, production order, delivery, cost center), posting date, movement reason code, picker/operator assignment, and confirmation status. Serves as the single source of truth for all inventory transaction activity, supporting stock balance updates, audit trails, and material document history across all facilities.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` (
    `cycle_count_id` BIGINT COMMENT 'Unique identifier for the cycle count event. Primary key for the cycle count record.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Cycle count is performed at a plant; plant_id replaces the string code.',
    `employee_id` BIGINT COMMENT 'Employee or user identifier of the person who performed the physical count. Used for accountability and quality tracking.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Link cycle count header to the physical location where the count occurs; replace code with FK.',
    `tertiary_cycle_approved_by_employee_id` BIGINT COMMENT 'Employee identifier of the supervisor or manager who approved the count results. Required for audit trail and segregation of duties.',
    `tertiary_quinary_cycle_last_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier who last updated the cycle count record. Used for audit trail and change tracking.',
    `abc_indicator` STRING COMMENT 'ABC classification of materials included in this count. A=high-value/high-frequency, B=medium, C=low-value/low-frequency, X=unclassified. Drives cycle count frequency per ABC methodology.. Valid values are `A|B|C|X`',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'Inventory accuracy rate for this count, calculated as (items with zero variance / total items counted) × 100. Key Performance Indicator (KPI) for inventory management.',
    `approval_status` STRING COMMENT 'Approval workflow status for the cycle count results. Counts with material variances typically require supervisor or manager approval before posting.. Valid values are `Pending Approval|Approved|Rejected|Not Required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count was approved. Used for compliance reporting and cycle time tracking.',
    `count_date` DATE COMMENT 'The actual date when the physical count was performed. Principal business event timestamp for the cycle count activity.',
    `count_document_number` STRING COMMENT 'Business identifier for the cycle count document. Externally-known unique reference number used in SAP WM and warehouse operations.. Valid values are `^CC-[0-9]{8,12}$`',
    `count_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the physical counting activity was completed. Used to calculate count duration and resource utilization.',
    `count_method` STRING COMMENT 'Technology or method used to perform the physical count. Impacts count accuracy and efficiency metrics.. Valid values are `Manual|Barcode Scan|RFID|Mobile Device|Automated`',
    `count_scope` STRING COMMENT 'Defines the breadth of the counting activity. Indicates whether count covers entire warehouse, specific zones, material categories, or individual items.. Valid values are `Full Warehouse|Zone|Material Group|Single Material|Bin Location`',
    `count_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the physical counting activity began. Used for labor tracking and cycle time analysis.',
    `count_status` STRING COMMENT 'Current lifecycle status of the cycle count event. Tracks progression from planning through execution, approval, and posting to inventory ledger. [ENUM-REF-CANDIDATE: Planned|In Progress|Completed|Approved|Posted|Cancelled|On Hold — 7 candidates stripped; promote to reference product]',
    `count_type` STRING COMMENT 'Classification of the cycle count event. Defines the counting methodology and business purpose (ABC-based frequency, annual compliance, variance investigation, or continuous counting program).. Valid values are `ABC Cycle|Annual Physical|Ad-Hoc Recount|Spot Count|Blind Count|Perpetual Inventory`',
    `count_zone` STRING COMMENT 'Physical zone or area within the warehouse designated for this count. Used to organize counting activities by geographic sections or material groupings.',
    `counter_name` STRING COMMENT 'Full name of the employee who performed the physical count. Used for operational visibility and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was first created in the system. Audit field for record lifecycle tracking.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the cycle count was performed. Used for annual physical inventory compliance and year-over-year accuracy trending.',
    `freeze_book_inventory_flag` BOOLEAN COMMENT 'Indicates whether book inventory was frozen (locked from transactions) during the count to ensure data integrity. True=frozen, False=not frozen.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was last updated. Audit field for tracking record changes and data currency.',
    `material_document_number` STRING COMMENT 'SAP Material Management (MM) document number generated when inventory adjustments are posted. Links cycle count to inventory movement transactions.. Valid values are `^[0-9]{10}$`',
    `notes` STRING COMMENT 'Free-text notes or comments about the cycle count event. Used to document unusual conditions, issues encountered, or explanations for variances.',
    `planned_count_date` DATE COMMENT 'The originally scheduled date for the cycle count. Used to track adherence to ABC cycle count schedules and annual physical inventory calendars.',
    `posting_date` DATE COMMENT 'Accounting date when inventory adjustments from this count were posted to the financial ledger. May differ from count_date for period-end controls.',
    `posting_period` STRING COMMENT 'Fiscal period (YYYY-MM format) to which inventory adjustments are posted. Used for period-end close and financial reporting.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `posting_status` STRING COMMENT 'Status of inventory adjustment posting to the general ledger and inventory subledger. Posted=variances reflected in stock balances, Not Posted=count complete but not yet posted.. Valid values are `Not Posted|Posted|Posting Error|Reversed`',
    `recount_reason` STRING COMMENT 'Business reason or justification for requiring a recount. Populated when recount_required_flag is True.',
    `recount_required_flag` BOOLEAN COMMENT 'Indicates whether a recount is required due to significant variances exceeding tolerance thresholds. True=recount needed, False=count accepted.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as a percentage of book quantity. Variances within tolerance may auto-approve; exceeding tolerance triggers recount or management review.',
    `total_items_counted` STRING COMMENT 'Total number of distinct Stock Keeping Units (SKUs) or material numbers included in this cycle count event.',
    `total_variance_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity variance across all materials in this count (sum of absolute differences between book and physical quantities). Measured in base unit of measure.',
    `total_variance_value` DECIMAL(18,2) COMMENT 'Aggregate financial value of inventory variances in this count. Calculated as sum of (variance quantity × standard cost) across all materials. Used for materiality assessment and financial impact analysis.',
    `variance_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total variance value. Typically plant or company code default currency.. Valid values are `^[A-Z]{3}$`',
    `warehouse_number` STRING COMMENT 'Warehouse Management (WM) number for complex warehouse structures. Used when storage location has multiple warehouse subdivisions.. Valid values are `^WH[0-9]{3}$`',
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Cycle count event header record capturing scheduled and ad-hoc physical inventory counts for specific materials, storage locations, or zones. Tracks count document number, count date, count type (ABC cycle, annual physical, ad-hoc recount), counter assignment, zone or location scope, planned vs actual count date, overall variance summary, approval status, and posting status. Supports ABC-based cycle count programs, annual physical inventory compliance, and inventory accuracy KPI tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` (
    `cycle_count_line_id` BIGINT COMMENT 'Unique identifier for the cycle count line item. Primary key for the cycle count line entity.',
    `cycle_count_id` BIGINT COMMENT 'Foreign key reference to the parent cycle count document header. Links this line item to its containing cycle count execution.',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record being counted. Identifies the specific Stock Keeping Unit (SKU) or raw material subject to physical verification.',
    `plant_data_id` BIGINT COMMENT 'Foreign key reference to the manufacturing plant or facility where the cycle count is being performed. Supports multi-site inventory management and consolidation.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the warehouse employee who performed the physical count. Enables accountability and audit trail per ISO 9001 quality management requirements.',
    `stock_location_id` BIGINT COMMENT 'Foreign key reference to the storage location where the material is physically located. Represents the warehouse or plant-level storage area.',
    `accounting_document_number` STRING COMMENT 'Reference number of the financial accounting document generated when the variance was posted. Links the physical inventory adjustment to General Ledger (GL) entries in SAP Financial Accounting (FI).',
    `batch_number` STRING COMMENT 'Batch or lot number for batch-managed materials. Enables traceability and quality control per ISO 9001 requirements. Null for non-batch-managed materials.',
    `book_quantity` DECIMAL(18,2) COMMENT 'System-recorded quantity of material in the storage bin at the time of cycle count initiation. Represents the expected quantity per Enterprise Resource Planning (ERP) records before physical verification.',
    `count_date` DATE COMMENT 'Business date on which the physical count was scheduled or performed. May differ from counted_timestamp for counts spanning multiple shifts or days.',
    `count_status` STRING COMMENT 'Current lifecycle status of this cycle count line item. Tracks progression from initiation through counting, verification, and posting stages.. Valid values are `not_started|in_progress|counted|recounted|posted|cancelled`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'Actual physical quantity counted by warehouse personnel during the cycle count execution. This is the verified on-hand quantity observed in the storage bin.',
    `counted_timestamp` TIMESTAMP COMMENT 'Date and time when the physical count was completed by warehouse personnel. Represents the actual business event time of inventory verification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cycle count line record was first created in the system. Audit trail field for record lifecycle tracking.',
    `difference_quantity` DECIMAL(18,2) COMMENT 'Variance between book quantity and counted quantity. Calculated as counted_quantity minus book_quantity. Positive values indicate surplus, negative values indicate shortage. Critical for inventory accuracy Key Performance Indicator (KPI) measurement.',
    `freeze_book_inventory_indicator` BOOLEAN COMMENT 'Flag indicating whether the book inventory quantity was frozen at the time of count initiation to prevent changes during the count period. True if frozen, false if dynamic.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cycle count line record was last updated. Audit trail field for change tracking and data governance.',
    `line_number` STRING COMMENT 'Sequential line item number within the cycle count document. Determines the ordering and position of this count line within the parent document.',
    `material_document_number` STRING COMMENT 'Reference number of the material document generated when the variance was posted. Links the cycle count result to the inventory movement transaction in SAP MM.',
    `material_number` STRING COMMENT 'Business identifier for the material being counted. The externally-known Stock Keeping Unit (SKU) code or material code from the Enterprise Resource Planning (ERP) system.',
    `notes` STRING COMMENT 'Free-text field for counter observations, exceptions, or additional context regarding the count result. Supports audit trail and Non-Conformance Report (NCR) documentation.',
    `posting_date` DATE COMMENT 'Date when the inventory variance was posted to the Enterprise Resource Planning (ERP) system and financial ledgers. Null if not yet posted. Critical for period-end inventory valuation per International Financial Reporting Standards (IFRS) and Generally Accepted Accounting Principles (GAAP).',
    `posting_indicator` BOOLEAN COMMENT 'Flag indicating whether the variance on this line has been posted to inventory and financial ledgers. True if posted, false if pending approval or recount.',
    `recount_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item requires or has undergone a recount due to variance exceeding tolerance thresholds. True if recount is required or completed, false otherwise.',
    `recount_reason_code` STRING COMMENT 'Standardized code indicating the reason a recount was triggered. Used for root cause analysis and Corrective and Preventive Action (CAPA) processes per ISO 9001.. Valid values are `variance_threshold|damaged_goods|misplaced_stock|system_error|quality_hold|other`',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock categories that require separate tracking. Consignment stock is vendor-owned, project stock is allocated to specific projects, sales order stock is reserved for customer orders.. Valid values are `consignment|project|sales_order|subcontracting|pipeline|none`',
    `stock_type` STRING COMMENT 'Classification of inventory stock status at the time of count. Unrestricted stock is available for use, quality inspection stock is pending Quality Management (QM) approval, blocked stock is unavailable due to quality or legal holds.. Valid values are `unrestricted|quality_inspection|blocked|restricted|returns`',
    `storage_bin` STRING COMMENT 'Specific bin, shelf, or rack location within the storage location where the material is stored. Enables precise physical location tracking for Warehouse Management System (WMS) operations.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as a percentage of book quantity. Variances within this tolerance may be auto-posted without recount. Supports Just In Time (JIT) inventory control and Material Requirements Planning (MRP) accuracy.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields on this line. Examples include EA (each), KG (kilogram), L (liter), M (meter). Must align with material master base unit of measure.',
    `valuation_type` STRING COMMENT 'Split valuation indicator for materials managed with multiple valuation types. Examples include origin-based valuation, quality-based valuation. Null for materials without split valuation.',
    `variance_reason_code` STRING COMMENT 'Root cause classification for inventory variance identified during cycle count. Enables variance analysis and process improvement initiatives. Required when difference_quantity is non-zero and exceeds tolerance. [ENUM-REF-CANDIDATE: counting_error|theft|damage|obsolescence|system_error|goods_receipt_not_posted|goods_issue_not_posted|transfer_not_posted|other — 9 candidates stripped; promote to reference product]',
    `verified_timestamp` TIMESTAMP COMMENT 'Date and time when the count result was verified by a supervisor or second counter. Null if verification is not required or not yet completed.',
    CONSTRAINT pk_cycle_count_line PRIMARY KEY(`cycle_count_line_id`)
) COMMENT 'Individual line item within a cycle count document representing the count result for a specific material-batch-bin combination. Captures line number, material, batch, storage bin, book quantity, counted quantity, difference quantity, unit of measure, recount indicator, and posting result. Enables granular variance analysis and audit trail for physical inventory reconciliation per ISO 9001 inventory accuracy requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that will be charged for this replenishment, used for financial accounting and cost allocation.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Vendor‑Managed Inventory (VMI) orders are generated per customer; linking the order to the customer account enables demand‑driven replenishment.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or SKU being replenished. Links to the material master record.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: MRP ORDER CONVERSION: replenishment orders are created from MRP planned orders; linking enables traceability.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the material is being replenished.',
    `employee_id` BIGINT COMMENT 'Reference to the MRP controller or planner responsible for managing the replenishment of this material.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Replenishment orders generated for project consumption must be linked to the project for cost and schedule tracking.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location or warehouse bin where the replenished material will be stored.',
    `supplier_id` BIGINT COMMENT 'Reference to the external supplier or vendor from whom the material will be procured, applicable when source type is external procurement.',
    `tertiary_replenishment_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system process that last modified this replenishment order record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order was approved for execution, marking transition from draft to active status.',
    `batch_number` STRING COMMENT 'Specific batch or lot number assigned to the replenished material for traceability and quality control purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order was closed after complete fulfillment or cancellation.',
    `confirmed_delivery_date` DATE COMMENT 'Actual confirmed delivery date provided by the supplier or internal source, may differ from requested date based on availability and lead time.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost and financial transactions related to this replenishment order.. Valid values are `^[A-Z]{3}$`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost for fulfilling this replenishment order, including material cost, freight, and handling charges.',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of material that has been delivered and received against this replenishment order.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the replenishment cost or inventory value will be posted for financial reporting.. Valid values are `^[0-9]{4,10}$`',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether incoming quality inspection is required before the replenished material can be released for use.',
    `kanban_card_number` STRING COMMENT 'Unique identifier of the kanban card that triggered this replenishment, applicable when replenishment type is kanban-based pull system.. Valid values are `^[A-Z0-9]{6,15}$`',
    `lead_time_days` STRING COMMENT 'Expected number of calendar days from order placement to material availability at the storage location, used for planning and scheduling.',
    `lot_size_quantity` DECIMAL(18,2) COMMENT 'Standard or economic order quantity used for replenishment, may be based on MOQ (Minimum Order Quantity), EOQ (Economic Order Quantity), or fixed lot size rules.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information related to this replenishment order.',
    `order_number` STRING COMMENT 'Business-facing unique identifier for the replenishment order, used for tracking and reference across systems and documents.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the replenishment order indicating its progress through the fulfillment workflow. [ENUM-REF-CANDIDATE: draft|open|in_progress|partially_fulfilled|fulfilled|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'Business priority level assigned to this replenishment order, used for scheduling and allocation decisions when material is constrained.. Valid values are `critical|high|medium|low`',
    `reference_order_number` BIGINT COMMENT 'Reference to the consuming order that requires this replenishment (e.g., production order, sales order, maintenance order). Used to link demand to supply.',
    `reference_order_type` STRING COMMENT 'Classification of the reference order type that is consuming or requiring this replenishment.. Valid values are `production_order|sales_order|maintenance_order|project|none`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level threshold that triggers automatic replenishment when stock falls below this point, used in min-max and reorder point planning strategies.',
    `replenishment_type` STRING COMMENT 'Classification of the replenishment trigger mechanism: planning-driven (MRP-based), kanban (pull-based), min-max (reorder point), JIT (Just In Time), manual reservation, or safety stock replenishment.. Valid values are `planning_driven|kanban|min_max|jit|manual_reservation|safety_stock`',
    `requested_delivery_date` DATE COMMENT 'Target date by which the replenished material is required to be available at the storage location to meet production or demand requirements.',
    `required_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material required to meet the replenishment target or reservation commitment, expressed in the base unit of measure.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently reserved or committed against this replenishment order, used for available-to-promise (ATP) calculation.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum buffer stock quantity that should be maintained at the storage location to protect against demand variability and supply disruptions.',
    `serial_number_required` BOOLEAN COMMENT 'Indicates whether individual serial number tracking is required for the replenished material items.',
    `source_document_number` STRING COMMENT 'Reference number of the originating document that triggered or fulfills this replenishment order (e.g., purchase requisition number, production order number, stock transfer order number).. Valid values are `^[A-Z0-9]{8,20}$`',
    `source_type` STRING COMMENT 'Classification of the source from which the material will be replenished: purchase requisition (external procurement), production order (internal manufacturing), stock transfer (inter-plant), external procurement, or internal transfer.. Valid values are `purchase_requisition|production_order|stock_transfer|external_procurement|internal_transfer`',
    `special_procurement_type` STRING COMMENT 'Classification of special procurement arrangements such as consignment stock, subcontracting, pipeline materials, or inter-plant stock transfers.. Valid values are `standard|consignment|subcontracting|pipeline|stock_transfer|none`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the material quantity (e.g., EA for each, KG for kilogram, L for liter, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Planning-driven, kanban-triggered, or manually-created replenishment and reservation record for restocking materials to safety stock or reorder point levels, or committing stock for planned consumption. Captures order number, material, plant, storage location, replenishment type (planning-driven, kanban, min-max, JIT, manual reservation), required quantity, requested delivery date, source (purchase requisition, production order, stock transfer), reference order (production order, sales order, maintenance order), priority, reserved quantity, and fulfillment status. Unifies demand commitment and replenishment execution into a single record for available-to-promise calculation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` (
    `wip_stock_id` BIGINT COMMENT 'Unique identifier for the work-in-progress inventory record. Primary key for the WIP stock entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: WIP valuation must be assigned to a cost center for work‑in‑process accounting and financial statements.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: WIP stock may be subject to in‑process inspection; linking to the inspection lot records results for each batch, supporting real‑time quality control.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or assembly being produced. Identifies the semi-finished good, subassembly, or component currently in work-in-progress status.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: WIP stock records the plant where work is in progress; plant_id provides a proper reference.',
    `employee_id` BIGINT COMMENT 'Reference to the production operator or worker currently responsible for processing this WIP stock. Used for labor tracking and quality accountability.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the production order under which this WIP stock is being manufactured. Links to the production order that authorized the manufacturing of this semi-finished material or assembly.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: WIP stock is tied to a specific project; project execution dashboards need a FK to link WIP to its project.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production station where this WIP stock is currently being processed. Identifies the specific manufacturing resource performing the current operation.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual timestamp when this WIP stock completed all production operations. Null if production is still in progress. Used for lead time analysis and schedule adherence tracking.',
    `bin_location` STRING COMMENT 'Specific bin, rack, or staging position within the storage location where the WIP stock is placed. Provides granular physical location tracking for material handling and retrieval.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `bom_version` STRING COMMENT 'Version number of the bill of materials used for producing this WIP stock. Tracks which BOM configuration was applied, important for engineering change management and traceability.. Valid values are `^[A-Z0-9.]{1,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this WIP stock record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the WIP valuation amount. Standard codes include USD, EUR, GBP, JPY, CNY.. Valid values are `^[A-Z]{3}$`',
    `customer_order_number` STRING COMMENT 'Customer sales order number for which this WIP stock is being produced, if applicable. Used for make-to-order production tracking and customer-specific inventory management. Null for make-to-stock production.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `expected_completion_date` DATE COMMENT 'Planned or scheduled date when this WIP stock is expected to complete all production operations and be ready for transfer to finished goods inventory. Used for production planning and delivery commitment.',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason why this WIP stock is on hold, if applicable. Values: quality_issue (failed inspection), material_shortage (awaiting components), equipment_failure (machine breakdown), engineering_change (ECO/ECN pending), customer_request (order change), other (miscellaneous reasons). Null if not on hold.. Valid values are `quality_issue|material_shortage|equipment_failure|engineering_change|customer_request|other`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Accumulated direct labor cost incurred in producing this WIP stock up to the current operation. Includes operator wages and benefits allocated to this production activity.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent stock movement or status change for this WIP stock. Used for tracking material flow and identifying stagnant inventory.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this WIP stock record was last modified in the system. Used for audit trail and change tracking.',
    `material_cost` DECIMAL(18,2) COMMENT 'Accumulated cost of raw materials and components consumed in producing this WIP stock up to the current operation. Component of total WIP valuation.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this WIP stock record. May include special handling instructions, quality observations, or production issues. Used for operational communication and documentation.',
    `operation_sequence_number` STRING COMMENT 'Current operation step or routing sequence number in the production process where this WIP stock is located. Indicates the specific manufacturing stage within the overall production routing.',
    `operation_start_timestamp` TIMESTAMP COMMENT 'Timestamp when processing began at the current operation step. Used for cycle time tracking and operation-level performance analysis.',
    `overhead_cost` DECIMAL(18,2) COMMENT 'Accumulated manufacturing overhead cost allocated to this WIP stock up to the current operation. Includes indirect costs such as utilities, depreciation, and facility expenses.',
    `priority_code` STRING COMMENT 'Production priority level assigned to this WIP stock. Values: urgent (expedited processing required), high (priority customer order), normal (standard production), low (fill-in work). Used for shop floor scheduling and resource allocation.. Valid values are `urgent|high|normal|low`',
    `production_start_date` DATE COMMENT 'Date when production of this WIP stock began. Marks the start of the manufacturing process for this batch or lot.',
    `quality_inspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether this WIP stock requires quality inspection before moving to the next operation or to finished goods. True if inspection is mandatory, false otherwise.',
    `quantity_completed` DECIMAL(18,2) COMMENT 'Quantity of the material or assembly that has completed processing at the current operation step and is ready to move to the next stage. Used for tracking operation-level progress and yield.',
    `quantity_in_process` DECIMAL(18,2) COMMENT 'Current quantity of the material or assembly in work-in-progress status, measured in the base unit of measure. Represents the number of units currently being manufactured at this operation step.',
    `quantity_scrapped` DECIMAL(18,2) COMMENT 'Quantity of the material or assembly that was scrapped or rejected during processing at the current operation. Used for scrap rate calculation and quality analysis.',
    `rework_operation_sequence` STRING COMMENT 'Operation sequence number to which this WIP stock must be returned for rework, if rework is required. Null if no rework is needed. Used for routing rework items back through the production process.',
    `rework_required` BOOLEAN COMMENT 'Boolean flag indicating whether this WIP stock requires rework or reprocessing due to quality issues. True if rework is needed, false otherwise. Used for quality management and cost tracking.',
    `routing_version` STRING COMMENT 'Version number of the production routing or process plan used for manufacturing this WIP stock. Tracks which manufacturing process was followed, important for process control and traceability.. Valid values are `^[A-Z0-9.]{1,10}$`',
    `serial_number_range_end` STRING COMMENT 'Ending serial number in the range assigned to this WIP stock batch, if serialized tracking is required. Used for individual unit traceability in high-value or regulated products. Null if not serialized.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `serial_number_range_start` STRING COMMENT 'Starting serial number in the range assigned to this WIP stock batch, if serialized tracking is required. Used for individual unit traceability in high-value or regulated products. Null if not serialized.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `shift_code` STRING COMMENT 'Code identifying the production shift during which this WIP stock is being processed. Used for shift-level performance tracking and labor allocation.. Valid values are `^[A-Z0-9]{1,4}$`',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this WIP stock record originated. Values: SAP_PP (SAP Production Planning), OPCENTER_MES (Siemens Opcenter Manufacturing Execution System), DYNAMICS_SCM (Microsoft Dynamics 365 Supply Chain Management), MANUAL (manual entry). Used for data lineage and integration management.. Valid values are `SAP_PP|OPCENTER_MES|DYNAMICS_SCM|MANUAL`',
    `storage_location_code` STRING COMMENT 'Code identifying the storage location, production area, or staging zone where this WIP stock is physically located. May represent shop floor buffer zones, work-in-process storage areas, or production line staging locations.. Valid values are `^[A-Z0-9]{2,10}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the WIP quantity. Standard units include EA (each), KG (kilogram), LB (pound), M (meter), FT (foot), L (liter), GAL (gallon), PC (piece), SET (set). [ENUM-REF-CANDIDATE: EA|KG|LB|M|FT|L|GAL|PC|SET — 9 candidates stripped; promote to reference product]',
    `wip_batch_number` STRING COMMENT 'Unique batch or lot number assigned to this work-in-progress inventory for traceability and quality control purposes. Used for tracking materials through production stages.. Valid values are `^[A-Z0-9]{6,20}$`',
    `wip_status` STRING COMMENT 'Current lifecycle status of the WIP stock. Values: in_process (actively being manufactured), on_hold (production paused), awaiting_inspection (pending quality check), ready_to_move (completed operation, awaiting transfer), scrapped (rejected), completed (finished all operations).. Valid values are `in_process|on_hold|awaiting_inspection|ready_to_move|scrapped|completed`',
    `wip_valuation_amount` DECIMAL(18,2) COMMENT 'Total valuation amount of this WIP stock in the companys base currency. Represents the accumulated cost of materials, labor, and overhead consumed up to the current production stage. Used for inventory valuation and financial reporting.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield percentage for this WIP stock at the current operation, representing the ratio of good output to total input. Used for process performance monitoring and OEE calculation. Formula: (quantity_completed / (quantity_completed + quantity_scrapped)) * 100.',
    CONSTRAINT pk_wip_stock PRIMARY KEY(`wip_stock_id`)
) COMMENT 'Work-in-progress inventory record tracking semi-finished materials and assemblies currently in production on the shop floor. Captures WIP stock identifier, production order reference, material or assembly, current operation step, quantity in process, storage location or production area, start date, expected completion date, and WIP valuation amount. Integrates shop floor execution data with production order status for real-time WIP visibility and cost tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` (
    `inventory_safety_stock_policy_id` BIGINT COMMENT 'Unique identifier for the safety stock policy record.',
    `employee_id` BIGINT COMMENT 'Reference to the inventory planner or supply chain analyst responsible for maintaining and reviewing this safety stock policy.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or Stock Keeping Unit (SKU) governed by this safety stock policy.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this safety stock policy applies.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location or warehouse bin within the plant where the material is stocked.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and consumption: A (high value, tight control), B (moderate value), C (low value, relaxed control).. Valid values are `A|B|C`',
    `approval_status` STRING COMMENT 'The approval workflow status for policy changes, indicating whether the policy has been reviewed and authorized by management.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the manager or authority who approved this safety stock policy for implementation.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock policy was formally approved for use in planning systems.',
    `calculation_method` STRING COMMENT 'The methodology used to determine the safety stock quantity: fixed quantity, fixed days of supply, statistical (using demand variability), forecast error-based, or hybrid approach.. Valid values are `fixed_quantity|fixed_days_supply|statistical|forecast_error|hybrid`',
    `coverage_profile` STRING COMMENT 'The time horizon unit used to express inventory coverage targets (days of supply, weeks of supply, or months of supply).. Valid values are `days|weeks|months`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock policy record was first created in the system.',
    `demand_variability_factor` DECIMAL(18,2) COMMENT 'Statistical measure of demand fluctuation expressed as coefficient of variation or standard deviation factor, used to calculate safety stock buffer size.',
    `effective_end_date` DATE COMMENT 'The date on which this safety stock policy expires or is superseded by a new policy version. Null indicates an open-ended policy.',
    `effective_start_date` DATE COMMENT 'The date from which this safety stock policy becomes active and is used in Material Requirements Planning (MRP) calculations.',
    `forecast_model` STRING COMMENT 'The demand forecasting model used to calculate expected consumption and variability for safety stock determination.. Valid values are `moving_average|exponential_smoothing|linear_regression|seasonal|manual`',
    `holding_cost_per_unit_per_year` DECIMAL(18,2) COMMENT 'The annual cost to hold one unit of this material in inventory, including warehousing, insurance, obsolescence, and capital cost.',
    `jit_enabled_flag` BOOLEAN COMMENT 'Indicates whether this material-plant combination follows Just In Time (JIT) inventory principles with minimal or zero safety stock.',
    `last_review_date` DATE COMMENT 'The most recent date when this safety stock policy was reviewed and validated by inventory planning or supply chain management.',
    `lot_size_rule` STRING COMMENT 'The rule governing replenishment order quantities: fixed quantity, Economic Order Quantity (EOQ), lot-for-lot matching demand, period-based batching, weekly, or monthly aggregation.. Valid values are `fixed|eoq|lot_for_lot|period|weekly|monthly`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'The upper inventory limit for this material-plant combination to prevent overstocking and excess capital tied up in inventory.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The smallest replenishment order quantity allowed by supplier constraints or economic order quantity calculations.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock policy record was last updated or modified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review and potential adjustment of this safety stock policy.',
    `planning_strategy` STRING COMMENT 'The inventory planning methodology applied: Material Requirements Planning (MRP), Manufacturing Resource Planning (MRP II), Distribution Requirements Planning (DRP), Kanban pull system, or manual planning.. Valid values are `mrp|mrp_ii|drp|kanban|manual`',
    `policy_code` STRING COMMENT 'Business identifier code for the safety stock policy, typically combining material, plant, and policy version identifiers.. Valid values are `^[A-Z0-9]{6,20}$`',
    `policy_notes` STRING COMMENT 'Free-text field for planners to document special considerations, exceptions, business rationale, or historical context for this safety stock policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the safety stock policy indicating whether it is actively used in Material Requirements Planning (MRP) calculations.. Valid values are `active|inactive|pending|superseded|expired|draft`',
    `policy_type` STRING COMMENT 'Classification of the safety stock policy approach: fixed buffer, dynamic calculation, seasonal adjustment, Just In Time (JIT) minimal stock, zero stock strategy, or consignment inventory.. Valid values are `fixed|dynamic|seasonal|jit|zero_stock|consignment`',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level threshold that triggers a replenishment order, calculated as safety stock plus demand during lead time.',
    `replenishment_lead_time_days` STRING COMMENT 'The total time in days from order placement to material receipt, including procurement, production, and transportation lead times.',
    `review_cycle_days` STRING COMMENT 'The frequency in days at which inventory levels are reviewed and replenishment decisions are made for periodic review policies.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The minimum buffer stock quantity to be maintained to protect against demand variability and supply lead time uncertainty, expressed in the material base unit of measure.',
    `safety_time_days` STRING COMMENT 'Additional time buffer in days added to the replenishment lead time to protect against supply delays and schedule variability.',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this policy includes seasonal demand pattern adjustments that modify safety stock levels throughout the year.',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'The target probability of not experiencing a stockout during the replenishment lead time, typically expressed as a percentage (e.g., 95%, 99%).',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated business cost incurred per unit when a stockout occurs, including lost sales, expediting costs, and customer dissatisfaction impact.',
    `target_coverage_value` DECIMAL(18,2) COMMENT 'The target number of coverage periods (days, weeks, or months) that the safety stock should protect against stockouts.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure for all quantity fields in this policy (e.g., EA for each, KG for kilograms, M for meters).. Valid values are `^[A-Z]{2,6}$`',
    `xyz_classification` STRING COMMENT 'Demand variability classification: X (stable demand), Y (moderate variability), Z (highly variable or sporadic demand).. Valid values are `X|Y|Z`',
    CONSTRAINT pk_inventory_safety_stock_policy PRIMARY KEY(`inventory_safety_stock_policy_id`)
) COMMENT 'Safety stock and reorder point policy configuration for each material-plant combination, defining the minimum stock buffer to protect against demand variability and supply lead time uncertainty. Captures safety stock quantity, reorder point, maximum stock level, replenishment lead time, demand variability factor, service level target, review cycle, JIT flag, and policy effective dates. Drives planning-based replenishment calculations and inventory optimization across all facilities.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` (
    `kanban_card_id` BIGINT COMMENT 'Unique identifier for the kanban card record. Primary key for the kanban card entity.',
    `control_cycle_id` BIGINT COMMENT 'Reference to the kanban control cycle that governs this card. Defines the replenishment loop parameters.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Kanban loops can be customer‑specific in contract manufacturing; the card needs to identify the customer account.',
    `employee_id` BIGINT COMMENT 'Reference to the person or operator responsible for managing this kanban card and its replenishment.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or component that this kanban card controls. Links to the material master record.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this kanban card operates.',
    `stock_location_id` BIGINT COMMENT 'Reference to the current physical location of the kanban card container. Enables real-time material tracking.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Kanban cards used on project production lines need a project reference to monitor lean execution per project.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier for external kanban cards where material is replenished directly from vendor.',
    `supply_area_id` BIGINT COMMENT 'Reference to the supply area or warehouse location from which material is replenished.',
    `work_center_id` BIGINT COMMENT 'Reference to the responsible work center that uses material from this kanban card.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this kanban card is currently active in the control cycle. Inactive cards are excluded from replenishment processing.',
    `barcode` STRING COMMENT 'Barcode value printed on the physical kanban card for scanning and automated signal processing.. Valid values are `^[0-9]{8,13}$`',
    `blocking_reason` STRING COMMENT 'Free-text explanation for why the kanban card is blocked or locked. Used for quality holds, safety issues, or process exceptions.',
    `consumption_area_code` BIGINT COMMENT 'Reference to the consumption area or work center where material is used.',
    `container_quantity` DECIMAL(18,2) COMMENT 'Standard quantity of material held in one container for this kanban card. Represents the pull signal quantity.',
    `container_type` STRING COMMENT 'Type of physical container used to hold the material quantity for this kanban card.. Valid values are `pallet|bin|tote|rack|cart|container`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this kanban card record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this kanban card is retired or deactivated from the control cycle. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this kanban card becomes effective and active in the control cycle.',
    `kanban_card_number` STRING COMMENT 'Externally visible unique kanban card number used for identification on the shop floor. Typically barcode or RFID-encoded for scanning.. Valid values are `^[A-Z0-9]{8,20}$`',
    `kanban_card_status` STRING COMMENT 'Current lifecycle status of the kanban card. Empty triggers replenishment signal, in_transit indicates material movement, full indicates ready for consumption, in_use indicates active consumption, locked prevents usage, blocked indicates quality or safety hold.. Valid values are `empty|in_transit|full|in_use|locked|blocked`',
    `kanban_loop_time_minutes` STRING COMMENT 'Expected cycle time in minutes for one complete kanban loop from consumption signal to replenishment completion.',
    `last_consumption_timestamp` TIMESTAMP COMMENT 'Timestamp when material was last consumed from this kanban card. Used for demand pattern analysis.',
    `last_replenishment_timestamp` TIMESTAMP COMMENT 'Timestamp when material was last replenished for this kanban card. Used for consumption rate analysis.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the kanban card status was last changed. Critical for tracking loop time performance and identifying bottlenecks.',
    `lead_time_days` DECIMAL(18,2) COMMENT 'Expected lead time in days from replenishment signal to material availability. Used for kanban sizing calculations.',
    `maximum_lot_size` DECIMAL(18,2) COMMENT 'Maximum order quantity for replenishment. Prevents over-stocking and excess WIP inventory.',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'Minimum order quantity (MOQ) for replenishment. Ensures economic order quantities are maintained.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this kanban card record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about this kanban card for operational guidance and special handling instructions.',
    `number_of_containers` STRING COMMENT 'Total number of containers in the kanban control cycle for this card. Determines the total inventory in the loop.',
    `priority` STRING COMMENT 'Priority level for replenishment processing. Critical materials are replenished first to prevent production stoppage.. Valid values are `critical|high|normal|low`',
    `production_version` STRING COMMENT 'Production version or routing variant associated with this kanban card for manufactured materials.. Valid values are `^[A-Z0-9]{1,4}$`',
    `replenishment_strategy` STRING COMMENT 'Strategy for material replenishment. Pull is pure JIT demand-driven, push is forecast-driven, hybrid combines both.. Valid values are `pull|push|hybrid`',
    `rfid_tag` STRING COMMENT 'RFID tag identifier for automated tracking and real-time location monitoring of the kanban card.. Valid values are `^[A-F0-9]{24}$`',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum safety stock quantity maintained in the kanban loop to buffer against demand variability and supply disruptions.',
    `signal_type` STRING COMMENT 'Type of signal mechanism used for this kanban card. Electronic signals integrate with MES, physical cards are manual, barcode and RFID enable automated scanning.. Valid values are `electronic|physical|barcode|rfid|manual`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the container quantity (e.g., EA for each, KG for kilogram, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_kanban_card PRIMARY KEY(`kanban_card_id`)
) COMMENT 'Kanban card master and status record supporting JIT pull-based replenishment on the shop floor. Captures kanban card number, control cycle reference, material, supply area, responsible work center, container quantity, number of containers in cycle, kanban loop time, current status (empty, in transit, full, in use, locked), signal type (electronic, physical, barcode), and last status change timestamp. Enables real-time pull signal processing for lean manufacturing material flow, reducing WIP and supporting continuous flow production.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` (
    `stock_valuation_id` BIGINT COMMENT 'Unique identifier for the stock valuation record. Primary key for the stock valuation entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial reporting requires posting inventory valuation to a specific GL account; linking enables automated journal entry generation for balance‑sheet reporting.',
    `material_master_id` BIGINT COMMENT 'Reference to the material being valued. Links to the material master record in the product engineering domain.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the stock is held. Links to the plant master data.',
    `base_unit_of_measure` STRING COMMENT 'Base unit in which the material quantity is managed (e.g., EA for each, KG for kilogram, L for liter, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    `company_code` STRING COMMENT 'Legal entity code for which the inventory is valued. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center associated with inventory holding costs. Used for internal cost allocation and management reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_of_goods_sold_amount` DECIMAL(18,2) COMMENT 'Total cost of goods sold for this material during the fiscal period. Calculated based on goods issues valued at standard or moving average price.',
    `created_by_user` STRING COMMENT 'User ID of the person or system process that created this valuation record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock valuation record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the material is valued (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year to which this valuation record applies. Typically ranges from 1 to 12.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this valuation record applies. Used for period-based financial reporting and year-over-year analysis.',
    `inventory_accounting_method` STRING COMMENT 'Cost flow assumption method used for inventory valuation. FIFO (First In First Out), LIFO (Last In First Out), weighted average, or specific identification.. Valid values are `FIFO|LIFO|weighted_average|specific_identification`',
    `inventory_write_down_amount` DECIMAL(18,2) COMMENT 'Amount by which inventory value has been written down due to obsolescence, damage, or net realizable value being lower than cost. Required for IFRS and GAAP compliance.',
    `is_consignment_stock` BOOLEAN COMMENT 'Boolean flag indicating whether this stock is held on consignment from a vendor. Consignment stock is not valued on the balance sheet until it is withdrawn for use.',
    `is_special_stock` BOOLEAN COMMENT 'Boolean flag indicating whether this is special stock (e.g., project stock, sales order stock, returnable packaging). Special stock may have different valuation rules.',
    `last_goods_issue_date` DATE COMMENT 'Date of the most recent goods issue transaction for this material at this valuation area. Used for inventory turnover and movement analysis.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt transaction for this material at this valuation area. Used for inventory aging and obsolescence analysis.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person or system process that last modified this valuation record. Used for change tracking and audit purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock valuation record was last updated. Used for change tracking and audit purposes.',
    `last_price_change_date` DATE COMMENT 'Date when the standard price or moving average price was last changed. Used for price history tracking and audit purposes.',
    `material_overhead_amount` DECIMAL(18,2) COMMENT 'Total material overhead amount included in the stock valuation. Calculated by applying the material overhead rate to the base material cost.',
    `material_overhead_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to material cost to account for procurement overhead, handling, and storage costs. Used in full costing calculations.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Weighted average price per unit that is recalculated automatically with each goods receipt. Used when price control method is set to moving average.',
    `net_realizable_value` DECIMAL(18,2) COMMENT 'Estimated selling price in the ordinary course of business less estimated costs of completion and estimated costs necessary to make the sale. Used to determine lower of cost or NRV per IAS 2.',
    `previous_period_price` DECIMAL(18,2) COMMENT 'Price per unit from the previous fiscal period. Used for period-over-period variance analysis and price trend tracking.',
    `price_change_amount` DECIMAL(18,2) COMMENT 'Absolute change in price per unit compared to the previous period. Calculated as current price minus previous period price.',
    `price_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change in price compared to the previous period. Used for inflation tracking and cost variance analysis.',
    `price_control_method` STRING COMMENT 'Indicator determining whether material is valued using standard price (S) or moving average price (V). Standard price remains fixed until manually changed; moving average price recalculates with each goods receipt.. Valid values are `S|V`',
    `price_unit` STRING COMMENT 'Number of units to which the price refers. For example, if price unit is 100, the standard price or moving average price applies to 100 units of the material.',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'Total price variance amount for the period, representing the difference between standard price and actual purchase price multiplied by quantity received. Used in standard costing variance analysis.',
    `profit_center_code` STRING COMMENT 'Code identifying the profit center responsible for this inventory. Used for segment reporting and profitability analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `provision_for_obsolescence` DECIMAL(18,2) COMMENT 'Reserve amount set aside for slow-moving, obsolete, or excess inventory. Reduces the carrying value of inventory on the balance sheet.',
    `standard_price` DECIMAL(18,2) COMMENT 'Fixed price per unit used for material valuation when price control method is set to standard price. Used for variance calculation in cost accounting.',
    `total_stock_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material in stock at the valuation area, including unrestricted, quality inspection, and blocked stock. Expressed in base unit of measure.',
    `total_stock_value` DECIMAL(18,2) COMMENT 'Total financial value of all stock for this material at this valuation area. Calculated as total stock quantity multiplied by the applicable price (standard or moving average).',
    `valuation_adjustment_reason` STRING COMMENT 'Free-text explanation for any manual valuation adjustments made during the period. Used for audit trail and management review.',
    `valuation_area_code` STRING COMMENT 'Code identifying the organizational unit for which material is valued. Typically corresponds to plant or company code level valuation.. Valid values are `^[A-Z0-9]{4}$`',
    `valuation_category` STRING COMMENT 'High-level category classifying the type of inventory being valued. Aligns with balance sheet presentation and inventory management strategy.. Valid values are `raw_material|work_in_progress|finished_goods|trading_goods|spare_parts|consumables`',
    `valuation_class` STRING COMMENT 'Classification code that groups materials for accounting purposes and determines the General Ledger (GL) accounts to which inventory value is posted. Maps materials to chart of accounts.. Valid values are `^[0-9]{4}$`',
    `valuation_date` DATE COMMENT 'Date on which this valuation snapshot was taken. Typically corresponds to period-end closing date for financial reporting.',
    `valuation_status` STRING COMMENT 'Current status of the valuation record indicating whether the material is actively valued, blocked from transactions, restricted use, or flagged for write-off.. Valid values are `active|blocked|restricted|obsolete|write_off_pending`',
    `valuation_type` STRING COMMENT 'Differentiates between multiple valuations of the same material within a valuation area (e.g., own production vs. external procurement, different quality grades).. Valid values are `^[A-Z0-9]{4}$`',
    CONSTRAINT pk_stock_valuation PRIMARY KEY(`stock_valuation_id`)
) COMMENT 'Inventory valuation record capturing the financial value of stock for each material at each plant and valuation area. Tracks valuation class, price control method (standard price vs. moving average price), current standard price, moving average price, total stock value, price unit, last valuation date, and period-end valuation adjustments. Supports cost of goods sold calculation, inventory asset reporting, and write-down provisions per IFRS and GAAP requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` (
    `quarantine_stock_id` BIGINT COMMENT 'Unique identifier for the quarantine stock record. Primary key. Inferred role: MASTER_RESOURCE (quarantine stock is a resource state/container with lifecycle). No canonical skip needed.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Quarantined stock often originates from a specific customer complaint; linking to the customer account supports traceability and liability reporting.',
    `customer_complaint_id` BIGINT COMMENT 'Reference to the customer complaint record if the quarantine was triggered by a customer-reported quality issue or product return.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product that is placed under quarantine. Links to the master material record in SAP MM or PLM system.',
    `ncr_id` BIGINT COMMENT 'Reference to the Non-Conformance Report (NCR) that documented the quality issue leading to the quarantine.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Quarantine stock is tied to a plant; plant_id provides referential integrity.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Quarantine decisions are driven by particular regulatory mandates; linking to the regulatory requirement provides traceability for compliance audits.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory compliance requires a qualified quality engineer to approve quarantine releases; linking to employee provides traceability for audits.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom the quarantined material was received, if applicable for incoming inspection or supplier quality issues.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or facility where the quarantined stock is physically located.',
    `actual_release_date` DATE COMMENT 'Actual date when the quarantine was lifted and the material was released, reworked, returned, or scrapped.',
    `batch_number` STRING COMMENT 'Batch or lot number of the quarantined material, enabling traceability to production run, supplier shipment, or manufacturing date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quarantine stock record was first created in the system, supporting audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated financial impact amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|INR|CAD|AUD — 8 candidates stripped; promote to reference product]',
    `disposition_approval_date` DATE COMMENT 'Date when the disposition decision was formally approved by the authorized quality or management personnel.',
    `disposition_approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved the disposition decision, ensuring accountability and traceability.',
    `disposition_decision` STRING COMMENT 'Final disposition decision made by the quality team regarding the quarantined material. Options include release to stock, use as-is with deviation, rework, return to vendor, scrap, or pending decision.. Valid values are `RELEASE|USE_AS_IS|REWORK|RETURN_TO_VENDOR|SCRAP|PENDING`',
    `disposition_justification` STRING COMMENT 'Detailed justification and rationale for the disposition decision, documenting the quality assessment, risk analysis, and approval basis.',
    `erp_system_code` STRING COMMENT 'Code or identifier of the source ERP system (e.g., SAP S/4HANA, Microsoft Dynamics 365) from which the quarantine record originated.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact or cost associated with the quarantined stock, including material value, potential rework costs, or scrap loss.',
    `expected_release_date` DATE COMMENT 'Anticipated date by which the quarantine investigation and disposition decision are expected to be completed, allowing for release or other action.',
    `goods_receipt_number` STRING COMMENT 'Goods receipt document number from SAP MM or WMS that recorded the inbound delivery of the quarantined material.',
    `initiating_document_number` STRING COMMENT 'Reference number of the document that initiated the quarantine, enabling traceability to the root cause investigation or quality event.',
    `initiating_document_type` STRING COMMENT 'Type of document that triggered the quarantine action, such as NCR (Non-Conformance Report), CAPA (Corrective and Preventive Action), inspection report, customer complaint, supplier notification, or regulatory notice.. Valid values are `NCR|CAPA|INSPECTION_REPORT|CUSTOMER_COMPLAINT|SUPPLIER_NOTIFICATION|REGULATORY_NOTICE`',
    `inspection_lot_number` STRING COMMENT 'Inspection lot number from SAP QM or quality management system that tracks the inspection activity associated with the quarantined material.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the quarantine stock record, enabling change tracking and audit compliance.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the receipt of the quarantined material, enabling traceability to procurement records.',
    `quarantine_notes` STRING COMMENT 'Free-text field for additional notes, observations, or instructions related to the quarantine case, supporting investigation and disposition activities.',
    `quarantine_quantity` DECIMAL(18,2) COMMENT 'Quantity of material placed under quarantine, expressed in the base unit of measure for the material.',
    `quarantine_reason_code` STRING COMMENT 'Standardized code indicating the reason for placing the material under quarantine. Values include incoming inspection, in-process failure, customer complaint, NCR (Non-Conformance Report), regulatory hold, or shelf life expiry.. Valid values are `INCOMING_INSPECTION|IN_PROCESS_FAILURE|CUSTOMER_COMPLAINT|NCR|REGULATORY_HOLD|SHELF_LIFE_EXPIRY`',
    `quarantine_reason_description` STRING COMMENT 'Detailed textual description of the reason for quarantine, providing additional context beyond the reason code.',
    `quarantine_record_number` STRING COMMENT 'Business identifier for the quarantine record, externally visible and used for traceability and audit purposes. Typically follows a structured format for easy reference.. Valid values are `^QR-[0-9]{8}$`',
    `quarantine_start_date` DATE COMMENT 'Date when the material was placed under quarantine and blocked from use or shipment.',
    `quarantine_status` STRING COMMENT 'Current lifecycle status of the quarantine record. Values include open, under investigation, pending approval, released, or closed.. Valid values are `OPEN|UNDER_INVESTIGATION|PENDING_APPROVAL|RELEASED|CLOSED`',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the quarantine is due to a regulatory hold imposed by FDA, EPA, or other governing body.',
    `responsible_department` STRING COMMENT 'Department or organizational unit responsible for investigating and resolving the quarantine case (e.g., Quality Assurance, Incoming Inspection, Production).',
    `serial_number` STRING COMMENT 'Serial number of the individual item under quarantine, if applicable for serialized inventory tracking.',
    `shelf_life_expiry_date` DATE COMMENT 'Expiry or best-before date of the material, relevant when quarantine is due to approaching or exceeded shelf life.',
    `storage_bin_location` STRING COMMENT 'Specific bin or rack location within the storage area where the quarantined stock is placed for physical segregation.',
    `storage_location_code` STRING COMMENT 'Storage location code within the warehouse where the quarantined material is held, as defined in SAP WM or WMS.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quarantine quantity (e.g., EA for each, KG for kilograms, L for liters). [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|TON|LB|GAL|FT|PC — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_quarantine_stock PRIMARY KEY(`quarantine_stock_id`)
) COMMENT 'Quarantine and blocked stock record for materials placed on hold pending quality inspection, regulatory review, customer complaint investigation, or supplier dispute resolution. Captures quarantine record number, material, batch, quantity, storage location, quarantine reason (incoming inspection, in-process failure, customer complaint, NCR, regulatory hold, shelf life expiry), initiating document reference, responsible quality engineer, quarantine start date, expected release date, and disposition decision (release, use-as-is, rework, return to vendor, scrap). Supports regulatory traceability for FDA, ISO 9001, and IATF 16949 requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` (
    `serialized_unit_id` BIGINT COMMENT 'Unique identifier for the serialized unit record. Primary key for individual unit tracking across inventory lifecycle.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owns or has been allocated this serialized unit. Used for customer-specific inventory, consignment stock, and field service tracking.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the lot or batch record from which this serialized unit originated. Links unit-level traceability to batch-level quality and production data.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record that defines the product specification, Bill of Materials (BOM), and material characteristics for this serialized unit.',
    `order_header_id` BIGINT COMMENT 'Reference to the sales order for which this serialized unit has been allocated or shipped. Links inventory to order fulfillment and revenue recognition.',
    `parent_unit_serialized_unit_id` BIGINT COMMENT 'Reference to the parent handling unit (pallet, container, tote) that contains this serialized unit. Enables hierarchical packing structure and nested unit tracking for warehouse operations.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Serialized units are produced at a plant; linking via plant_id removes the free‑text code.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the production order that manufactured or assembled this serialized unit. Links unit traceability to production execution and Manufacturing Execution System (MES) data.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Serialized equipment assigned to a project requires linking for asset tracking and project cost allocation.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order through which this serialized unit was procured. Enables procurement traceability and supplier performance analysis.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record if this serialized unit is currently in transit or has been shipped. Enables logistics tracking and delivery confirmation.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier that provided this serialized unit. Links to procurement data and supplier quality management.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse master record where this serialized unit is currently stored. Provides detailed warehouse attributes and operational parameters.',
    `bin_location` STRING COMMENT 'Specific bin, rack, or storage position identifier within the warehouse where this serialized unit is physically located. Enables precise picking and putaway operations.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where this serialized unit was manufactured or assembled. Required for customs declarations and trade compliance.',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created this serialized unit record. Supports audit trail and data governance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this serialized unit record was first created in the system. Provides audit trail for record creation and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount (e.g., USD, EUR, CNY). Enables multi-currency inventory valuation and financial consolidation.',
    `customs_tariff_code` STRING COMMENT 'Harmonized System (HS) code or Harmonized Tariff Schedule (HTS) code for customs classification and duty calculation. Required for international shipments.',
    `expiry_date` DATE COMMENT 'Date when this serialized unit reaches end of shelf life or warranty expiration. Used for First Expired First Out (FEFO) inventory management and compliance reporting.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the serialized unit including packaging and contents, measured in kilograms. Used for logistics planning and transportation compliance.',
    `hazmat_class` STRING COMMENT 'United Nations (UN) hazard classification code for hazardous materials (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Required for transportation and storage compliance.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator whether this serialized unit contains hazardous materials requiring special handling, storage, and transportation compliance.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the serialized unit or handling unit in centimeters. Used for warehouse space planning and transportation optimization.',
    `last_modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this serialized unit record. Supports audit trail and data governance requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this serialized unit record was last updated. Enables change tracking and data synchronization across systems.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent inventory movement transaction for this serialized unit. Used for inventory aging analysis and cycle count prioritization.',
    `last_movement_type` STRING COMMENT 'Type of the most recent inventory movement transaction for this serialized unit (e.g., goods receipt, goods issue, transfer posting, physical inventory). Provides audit trail context.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the serialized unit or handling unit in centimeters. Used for warehouse space planning and transportation optimization.',
    `manufacturing_date` DATE COMMENT 'Date when this serialized unit was manufactured or assembled. Critical for warranty tracking, shelf life management, and regulatory compliance.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the material contents excluding packaging, measured in kilograms. Used for material valuation and yield calculations.',
    `notes` STRING COMMENT 'Free-text notes and comments about this serialized unit. Used for special handling instructions, quality observations, or operational remarks.',
    `ownership_type` STRING COMMENT 'Indicates the legal ownership of the serialized unit. Distinguishes between company-owned inventory, customer consignment, vendor consignment, and third-party logistics (3PL) owned stock.. Valid values are `company_owned|customer_owned|vendor_owned|third_party_owned`',
    `quality_certificate_number` STRING COMMENT 'Certificate of Conformance (CoC) or quality certificate number issued for this serialized unit. Required for regulated industries and customer quality requirements.',
    `quality_inspection_status` STRING COMMENT 'Current quality inspection status of the serialized unit. Indicates whether the unit has passed quality checks and is approved for use or shipment.. Valid values are `not_inspected|pending_inspection|passed|failed|conditional_release`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material contained in this serialized unit. For serialized parts typically 1; for handling units represents the aggregate quantity of contents.',
    `seal_number` STRING COMMENT 'Security seal number applied to handling units (containers, pallets) for tamper detection and customs compliance. Required for international shipments and high-value goods.',
    `serial_number` STRING COMMENT 'Unique serial number or unit identifier assigned to this individual component, assembly, or finished good for traceability throughout its lifecycle. Enables field service tracking and warranty management.',
    `stock_status` STRING COMMENT 'Current lifecycle status of the serialized unit indicating its position in the inventory and production workflow. Drives availability for Material Requirements Planning (MRP) and order fulfillment. [ENUM-REF-CANDIDATE: in_stock|in_production|in_transit|shipped|delivered|returned|blocked|scrapped|consumed — 9 candidates stripped; promote to reference product]',
    `stock_type` STRING COMMENT 'Classification of stock availability indicating whether the unit is unrestricted for use, under quality inspection, blocked, or held as consignment inventory.. Valid values are `unrestricted|quality_inspection|blocked|restricted|customer_consignment|vendor_consignment`',
    `storage_location_code` STRING COMMENT 'Storage location code within the plant identifying the specific warehouse, yard, or storage area where this unit is physically located.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous substance for transportation and emergency response (e.g., UN1203 for gasoline). Required for hazmat shipping documentation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., EA for each, KG for kilograms, M for meters). Aligns with material master UOM definition.',
    `unit_type` STRING COMMENT 'Classification of the serialized unit indicating whether it is a serialized component part, assembly, finished good, or handling unit (pallet, container, tote, drum, reel) used for material handling and logistics. [ENUM-REF-CANDIDATE: serialized_part|assembly|finished_good|pallet|container|tote|drum|reel|handling_unit — 9 candidates stripped; promote to reference product]',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Monetary valuation of this serialized unit for inventory accounting and financial reporting. Represents standard cost, moving average price, or actual cost depending on valuation method.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume of the serialized unit or handling unit in cubic meters. Used for warehouse capacity planning and freight cost calculation.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the serialized unit or handling unit in centimeters. Used for warehouse space planning and transportation optimization.',
    CONSTRAINT pk_serialized_unit PRIMARY KEY(`serialized_unit_id`)
) COMMENT 'Individual unit tracking record for serialized components, assemblies, finished goods, and handling units (pallets, containers, totes, drums, reels) managed by unique identifier throughout their inventory lifecycle. Captures serial/unit number, material, unit type (serialized part, pallet, container, tote), contents (for handling units), batch, quantity, gross/net weight, dimensions, current plant and storage location, status (in stock, in production, shipped, returned, scrapped), seal number, and last movement timestamp. Provides pallet-level and serial-level traceability for warehouse operations, field service, and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` (
    `inventory_plant_id` BIGINT COMMENT 'Primary key for plant',
    `company_code_id` BIGINT COMMENT 'add column finance_company_code_id (BIGINT) with FK to finance.company_code.company_code_id - inventory plants need legal entity assignment for valuation and reporting',
    `asset_plant_id` BIGINT COMMENT 'add column asset_plant_id (BIGINT) with FK to asset.plant.plant_id - inventory plants should reference the canonical plant definition in asset domain',
    `address_line1` STRING COMMENT 'Primary street address of the plant.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `annual_carbon_emission_tons` DECIMAL(18,2) COMMENT 'Estimated CO₂ emissions produced by the plant each year.',
    `annual_energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity or fuel consumption per year measured in megawatt‑hours.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the production capacity.',
    `city` STRING COMMENT 'City where the plant is located.',
    `compliance_status` STRING COMMENT 'Current compliance standing with industry regulations.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the plant location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the plant record was first created in the master system.',
    `data_classification` STRING COMMENT 'Classification level for data governance purposes.',
    `energy_source` STRING COMMENT 'Main energy source powering the plant.',
    `environmental_certifications` STRING COMMENT 'Comma‑separated list of environmental certifications (e.g., ISO 14001).',
    `is_primary_plant` BOOLEAN COMMENT 'Flag indicating if this plant is the primary manufacturing site for the company.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which major maintenance was performed.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the plant site.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the plant site.',
    `maintenance_cycle_days` STRING COMMENT 'Planned interval in days between routine maintenance activities.',
    `manager_email` STRING COMMENT 'Primary email address for the plant manager.',
    `manager_name` STRING COMMENT 'Full legal name of the plant manager.',
    `manager_phone` STRING COMMENT 'Contact telephone number for the plant manager.',
    `inventory_plant_name` STRING COMMENT 'Human‑readable name of the manufacturing plant.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the plant.',
    `number_of_shifts` STRING COMMENT 'Count of work shifts operated per day.',
    `operating_hours_per_day` STRING COMMENT 'Total number of production hours each day.',
    `plant_area_sq_m` DECIMAL(18,2) COMMENT 'Total built‑up area of the plant in square meters.',
    `plant_type` STRING COMMENT 'Categorizes the plant by its primary manufacturing function.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the plant address.',
    `production_capacity` DECIMAL(18,2) COMMENT 'Maximum production output the plant can achieve per capacity unit.',
    `region` STRING COMMENT 'Broad geographic region (e.g., North America, EMEA).',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the plant must submit periodic regulatory reports.',
    `safety_certifications` STRING COMMENT 'Comma‑separated list of safety standards the plant complies with (e.g., ISO 45001).',
    `shutdown_date` DATE COMMENT 'Date when the plant was permanently closed or decommissioned (nullable).',
    `start_date` DATE COMMENT 'Date when the plant began operations or was commissioned.',
    `state` STRING COMMENT 'State or province of the plant location.',
    `inventory_plant_status` STRING COMMENT 'Current operational status of the plant.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the plant (e.g., America/Chicago).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the plant record.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Total waste material generated annually by the plant.',
    CONSTRAINT pk_inventory_plant PRIMARY KEY(`inventory_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` (
    `control_cycle_id` BIGINT COMMENT 'Primary key for control_cycle',
    `parent_control_cycle_id` BIGINT COMMENT 'Self-referencing FK on control_cycle (parent_control_cycle_id)',
    `associated_process` STRING COMMENT 'Primary business process that utilizes this control cycle.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that the control cycle must satisfy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control cycle record was first created.',
    `cycle_code` STRING COMMENT 'Short alphanumeric code representing the control cycle.',
    `cycle_duration_minutes` STRING COMMENT 'Typical duration of the control cycle expressed in minutes.',
    `cycle_name` STRING COMMENT 'Human‑readable name of the control cycle.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the control cycle.',
    `cycle_type` STRING COMMENT 'Category of the control cycle (e.g., setup, run, maintenance, shutdown).',
    `control_cycle_description` STRING COMMENT 'Detailed free‑text description of the control cycle purpose and characteristics.',
    `effective_end_date` DATE COMMENT 'Date when the control cycle expires or is superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the control cycle becomes effective.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the control cycle is critical to production continuity.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this cycle is the default for its type.',
    `last_review_date` DATE COMMENT 'Date when the control cycle definition was last reviewed.',
    `related_equipment_class` STRING COMMENT 'Classification of equipment to which this control cycle applies.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of the control cycle.',
    `safety_level` STRING COMMENT 'Safety risk level associated with the control cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control cycle record.',
    `version_number` STRING COMMENT 'Version identifier of the control cycle definition (e.g., v1.0).',
    CONSTRAINT pk_control_cycle PRIMARY KEY(`control_cycle_id`)
) COMMENT 'Master reference table for control_cycle. Referenced by control_cycle_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` (
    `supply_area_id` BIGINT COMMENT 'Primary key for supply_area',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_supply_area_id` BIGINT COMMENT 'Self-referencing FK on supply_area (parent_supply_area_id)',
    `supply_employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the area.',
    `supply_responsible_manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `area_sq_meters` DECIMAL(18,2) COMMENT 'Floor area of the supply area in square meters.',
    `building_name` STRING COMMENT 'Name of the building that houses the supply area.',
    `capacity_quantity` DECIMAL(18,2) COMMENT 'Maximum amount of material the area can hold.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the capacity quantity.',
    `supply_area_code` STRING COMMENT 'External code used in ERP systems to reference the supply area.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the supply area record was first created.',
    `current_occupancy` DECIMAL(18,2) COMMENT 'Current amount of material stored in the area.',
    `effective_from` DATE COMMENT 'Date when the supply area became operational.',
    `effective_until` DATE COMMENT 'Date when the supply area is scheduled to be retired or become inactive (nullable).',
    `external_system_reference` STRING COMMENT 'Reference code used in external ERP/SCM systems (e.g., SAP WM, Dynamics 365).',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed in the area.',
    `floor_number` STRING COMMENT 'Floor on which the supply area is located.',
    `humidity_controlled` BOOLEAN COMMENT 'Indicates whether humidity is regulated in the area.',
    `humidity_range_percent` STRING COMMENT 'Allowed humidity range for the area, expressed as min‑max percentage.',
    `inspection_status` STRING COMMENT 'Result of the last inspection.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the area has temperature control.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety/quality inspection.',
    `max_load_weight_kg` DECIMAL(18,2) COMMENT 'Maximum permissible load weight for the area in kilograms.',
    `supply_area_name` STRING COMMENT 'Human‑readable name of the supply area.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the supply area.',
    `occupancy_uom` STRING COMMENT 'Unit of measure for the current occupancy.',
    `safety_classification` STRING COMMENT 'Safety category of the area based on stored materials.',
    `supply_area_status` STRING COMMENT 'Current operational status of the supply area.',
    `temperature_range_celsius` STRING COMMENT 'Allowed temperature range for the area, expressed as min‑max in Celsius.',
    `supply_area_type` STRING COMMENT 'Category describing the primary function of the area.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the supply area record.',
    CONSTRAINT pk_supply_area PRIMARY KEY(`supply_area_id`)
) COMMENT 'Master reference table for supply_area. Referenced by supply_area_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_cycle_count_id` FOREIGN KEY (`cycle_count_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`cycle_count`(`cycle_count_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ADD CONSTRAINT `fk_inventory_inventory_safety_stock_policy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ADD CONSTRAINT `fk_inventory_inventory_safety_stock_policy_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_control_cycle_id` FOREIGN KEY (`control_cycle_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`control_cycle`(`control_cycle_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ADD CONSTRAINT `fk_inventory_kanban_card_supply_area_id` FOREIGN KEY (`supply_area_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`supply_area`(`supply_area_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ADD CONSTRAINT `fk_inventory_quarantine_stock_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_parent_unit_serialized_unit_id` FOREIGN KEY (`parent_unit_serialized_unit_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ADD CONSTRAINT `fk_inventory_control_cycle_parent_control_cycle_id` FOREIGN KEY (`parent_control_cycle_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`control_cycle`(`control_cycle_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ADD CONSTRAINT `fk_inventory_supply_area_parent_supply_area_id` FOREIGN KEY (`parent_supply_area_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`supply_area`(`supply_area_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` SET TAGS ('dbx_subdomain' = 'warehouse_management');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `access_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Access Equipment Required');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `aisle_number` SET TAGS ('dbx_business_glossary_term' = 'Aisle Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `aisle_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_business_glossary_term' = 'Bin Position');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Capacity Pallet Positions');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume (Cubic Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Capacity Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_demand');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `fifo_enforced` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Enforced Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `fire_zone` SET TAGS ('dbx_business_glossary_term' = 'Fire Zone Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `fire_zone` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `humidity_controlled` SET TAGS ('dbx_business_glossary_term' = 'Humidity Controlled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `humidity_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Humidity (Percent)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `humidity_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Humidity (Percent)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `is_hazmat_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT) Approved Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `is_picking_location` SET TAGS ('dbx_business_glossary_term' = 'Is Picking Location Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `is_replenishment_location` SET TAGS ('dbx_business_glossary_term' = 'Is Replenishment Location Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|reserved|full');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `lot_control_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Control Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `mixed_sku_allowed` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Modified Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `pick_sequence` SET TAGS ('dbx_business_glossary_term' = 'Pick Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `rack_number` SET TAGS ('dbx_business_glossary_term' = 'Rack Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `rack_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'public|restricted|controlled|high_security');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `shelf_level` SET TAGS ('dbx_business_glossary_term' = 'Shelf Level');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `shelf_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'X Coordinate');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Y Coordinate');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `z_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Z Coordinate');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` SET TAGS ('dbx_subdomain' = 'warehouse_management');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `automated_storage_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Storage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `climate_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Climate Controlled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `customs_bonded_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Bonded Warehouse Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'raw_material|work_in_progress|finished_goods|distribution_center|cross_dock|returns_processing');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_value_regex' = 'sprinkler|foam|gas|dry_chemical|none');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `hazmat_storage_classes` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Storage Classes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `iso_14001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `iso_9001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `number_of_loading_docks` SET TAGS ('dbx_business_glossary_term' = 'Number of Loading Docks');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `number_of_storage_bins` SET TAGS ('dbx_business_glossary_term' = 'Number of Storage Bins');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `operating_hours_description` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Description');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|maintenance');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party_logistics|contract_warehouse');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|high_security|bonded');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `storage_area_square_meters` SET TAGS ('dbx_business_glossary_term' = 'Storage Area (Square Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `total_capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Cubic Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `total_floor_area_square_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Floor Area (Square Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `usable_capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Usable Capacity (Cubic Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `wms_system_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` SET TAGS ('dbx_subdomain' = 'material_control');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `batch_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `dimension_unit` SET TAGS ('dbx_business_glossary_term' = 'Dimension Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `dimension_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `goods_receipt_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Processing Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `height` SET TAGS ('dbx_business_glossary_term' = 'Material Height');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `inspection_setup_indicator` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Setup Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Material Master Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Last Modified Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `length` SET TAGS ('dbx_business_glossary_term' = 'Material Length');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `lot_size` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|blocked|obsolete|phase_out|restricted|pending_approval');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `maximum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life in Days');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Control Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_value_regex' = 'S|V');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'in_house_production|external_procurement|both');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `product_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `product_hierarchy` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,18}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `shelf_life_expiration_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration Period in Days');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `temperature_conditions` SET TAGS ('dbx_business_glossary_term' = 'Temperature Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Material Volume');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `width` SET TAGS ('dbx_business_glossary_term' = 'Material Width');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Material Master Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` SET TAGS ('dbx_subdomain' = 'stock_valuation');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `blocked_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `consignment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consignment Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `inventory_turnover_days` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turnover Days');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_count_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Count Variance Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `obsolete_indicator` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `period_end_snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Snapshot Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `slow_moving_indicator` SET TAGS ('dbx_business_glossary_term' = 'Slow Moving Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Key');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `special_stock_type` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `special_stock_type` SET TAGS ('dbx_value_regex' = 'standard|consignment|project|sales_order|subcontracting|returnable_packaging');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_category` SET TAGS ('dbx_business_glossary_term' = 'Stock Category');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_category` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|in_transit|reserved');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'active|frozen|blocked|pending_disposal');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Value');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_currency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_price` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `warehouse_bin_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Bin Location');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` SET TAGS ('dbx_subdomain' = 'material_control');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_classification` SET TAGS ('dbx_business_glossary_term' = 'Batch Classification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_classification` SET TAGS ('dbx_value_regex' = 'raw_material|work_in_progress|finished_goods|semi_finished|packaging');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Batch Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_notes` SET TAGS ('dbx_business_glossary_term' = 'Batch Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|restricted|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `blocked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `customer_batch_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Batch Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `last_goods_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Movement Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `quality_decision` SET TAGS ('dbx_business_glossary_term' = 'Quality Decision');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `quality_decision` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditional|pending');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `quantity_produced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Produced');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `restricted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Restricted Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `shelf_life_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration Date (SLED)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `supplier_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` SET TAGS ('dbx_subdomain' = 'movement_replenishment');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `destination_bin_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Bin Location');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `destination_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `destination_storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `goods_issue_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_document_item` SET TAGS ('dbx_business_glossary_term' = 'Material Document Item Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{18}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Movement Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_value_regex' = 'receipt|issue|transfer|adjustment');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'posted|pending|cancelled|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_item` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Item Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `reversed_material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `source_bin_location` SET TAGS ('dbx_business_glossary_term' = 'Source Bin Location');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'cycle_counting');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counter ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `tertiary_cycle_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `tertiary_cycle_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `tertiary_cycle_approved_by_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `tertiary_quinary_cycle_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `tertiary_quinary_cycle_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `tertiary_quinary_cycle_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending Approval|Approved|Rejected|Not Required');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_document_number` SET TAGS ('dbx_business_glossary_term' = 'Count Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_document_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'Manual|Barcode Scan|RFID|Mobile Device|Automated');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_scope` SET TAGS ('dbx_business_glossary_term' = 'Count Scope');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_scope` SET TAGS ('dbx_value_regex' = 'Full Warehouse|Zone|Material Group|Single Material|Bin Location');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'ABC Cycle|Annual Physical|Ad-Hoc Recount|Spot Count|Blind Count|Perpetual Inventory');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_zone` SET TAGS ('dbx_business_glossary_term' = 'Count Zone');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `counter_name` SET TAGS ('dbx_business_glossary_term' = 'Counter Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `counter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `counter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `freeze_book_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Freeze Book Inventory Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Count Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `planned_count_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Count Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `posting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'Not Posted|Posted|Posting Error|Reversed');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `recount_reason` SET TAGS ('dbx_business_glossary_term' = 'Recount Reason');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `total_items_counted` SET TAGS ('dbx_business_glossary_term' = 'Total Items Counted');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_value` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Value');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `variance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `variance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `warehouse_number` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `warehouse_number` SET TAGS ('dbx_value_regex' = '^WH[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` SET TAGS ('dbx_subdomain' = 'cycle_counting');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `cycle_count_line_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Line Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Header Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counted By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `book_quantity` SET TAGS ('dbx_business_glossary_term' = 'Book Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|counted|recounted|posted|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `counted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Counted Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `difference_quantity` SET TAGS ('dbx_business_glossary_term' = 'Difference Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `freeze_book_inventory_indicator` SET TAGS ('dbx_business_glossary_term' = 'Freeze Book Inventory Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `posting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Posting Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `recount_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recount Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `recount_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Recount Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `recount_reason_code` SET TAGS ('dbx_value_regex' = 'variance_threshold|damaged_goods|misplaced_stock|system_error|quality_hold|other');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'consignment|project|sales_order|subcontracting|pipeline|none');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted|returns');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `storage_bin` SET TAGS ('dbx_business_glossary_term' = 'Storage Bin');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'movement_replenishment');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Replenishment Cost');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `kanban_card_number` SET TAGS ('dbx_business_glossary_term' = 'Kanban Card Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `kanban_card_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `kanban_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `kanban_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `reference_order_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `reference_order_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `reference_order_type` SET TAGS ('dbx_value_regex' = 'production_order|sales_order|maintenance_order|project|none');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_value_regex' = 'planning_driven|kanban|min_max|jit|manual_reservation|safety_stock');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `serial_number_required` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `source_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Source Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'purchase_requisition|production_order|stock_transfer|external_procurement|internal_transfer');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|pipeline|stock_transfer|none');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` SET TAGS ('dbx_subdomain' = 'material_control');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `wip_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Work-In-Progress (WIP) Stock Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `bin_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `customer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `customer_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `expected_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = 'quality_issue|material_shortage|equipment_failure|engineering_change|customer_request|other');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `operation_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `operation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Overhead Cost');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `overhead_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `quantity_completed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Completed');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `quantity_in_process` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Process');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `quantity_scrapped` SET TAGS ('dbx_business_glossary_term' = 'Quantity Scrapped');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `rework_operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rework Operation Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `rework_required` SET TAGS ('dbx_business_glossary_term' = 'Rework Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `routing_version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `routing_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `serial_number_range_end` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range End');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `serial_number_range_end` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `serial_number_range_start` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range Start');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `serial_number_range_start` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_PP|OPCENTER_MES|DYNAMICS_SCM|MANUAL');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `wip_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Work-In-Progress (WIP) Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `wip_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `wip_status` SET TAGS ('dbx_business_glossary_term' = 'Work-In-Progress (WIP) Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `wip_status` SET TAGS ('dbx_value_regex' = 'in_process|on_hold|awaiting_inspection|ready_to_move|scrapped|completed');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `wip_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Work-In-Progress (WIP) Valuation Amount');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `wip_valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`wip_stock` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` SET TAGS ('dbx_subdomain' = 'stock_valuation');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `inventory_safety_stock_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Policy ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'fixed_quantity|fixed_days_supply|statistical|forecast_error|hybrid');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `coverage_profile` SET TAGS ('dbx_business_glossary_term' = 'Coverage Profile');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `coverage_profile` SET TAGS ('dbx_value_regex' = 'days|weeks|months');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `demand_variability_factor` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Factor');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `forecast_model` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `forecast_model` SET TAGS ('dbx_value_regex' = 'moving_average|exponential_smoothing|linear_regression|seasonal|manual');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `holding_cost_per_unit_per_year` SET TAGS ('dbx_business_glossary_term' = 'Holding Cost Per Unit Per Year');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `holding_cost_per_unit_per_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `jit_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Just In Time (JIT) Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `lot_size_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Rule');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `lot_size_rule` SET TAGS ('dbx_value_regex' = 'fixed|eoq|lot_for_lot|period|weekly|monthly');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_value_regex' = 'mrp|mrp_ii|drp|kanban|manual');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Policy Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `policy_notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|expired|draft');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'fixed|dynamic|seasonal|jit|zero_stock|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `safety_time_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `seasonal_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target (Percent)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `target_coverage_value` SET TAGS ('dbx_business_glossary_term' = 'Target Coverage Value');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Classification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` SET TAGS ('dbx_subdomain' = 'movement_replenishment');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `kanban_card_id` SET TAGS ('dbx_business_glossary_term' = 'Kanban Card Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `control_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Control Cycle Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `supply_area_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Area Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[0-9]{8,13}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `consumption_area_code` SET TAGS ('dbx_business_glossary_term' = 'Consumption Area Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `container_quantity` SET TAGS ('dbx_business_glossary_term' = 'Container Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'pallet|bin|tote|rack|cart|container');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `kanban_card_number` SET TAGS ('dbx_business_glossary_term' = 'Kanban Card Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `kanban_card_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `kanban_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `kanban_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `kanban_card_status` SET TAGS ('dbx_business_glossary_term' = 'Kanban Card Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `kanban_card_status` SET TAGS ('dbx_value_regex' = 'empty|in_transit|full|in_use|locked|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `kanban_loop_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Kanban Loop Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `last_consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Consumption Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `last_replenishment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `maximum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `number_of_containers` SET TAGS ('dbx_business_glossary_term' = 'Number of Containers');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `production_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `replenishment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `replenishment_strategy` SET TAGS ('dbx_value_regex' = 'pull|push|hybrid');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{24}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `signal_type` SET TAGS ('dbx_business_glossary_term' = 'Signal Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `signal_type` SET TAGS ('dbx_value_regex' = 'electronic|physical|barcode|rfid|manual');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`kanban_card` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` SET TAGS ('dbx_subdomain' = 'stock_valuation');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `stock_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Valuation ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Accounting Method');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_accounting_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|weighted_average|specific_identification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_write_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Inventory Write-Down Amount');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `is_consignment_stock` SET TAGS ('dbx_business_glossary_term' = 'Is Consignment Stock Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `is_special_stock` SET TAGS ('dbx_business_glossary_term' = 'Is Special Stock Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_price_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Price Change Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `material_overhead_amount` SET TAGS ('dbx_business_glossary_term' = 'Material Overhead Amount');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `material_overhead_rate` SET TAGS ('dbx_business_glossary_term' = 'Material Overhead Rate');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `net_realizable_value` SET TAGS ('dbx_business_glossary_term' = 'Net Realizable Value (NRV)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `previous_period_price` SET TAGS ('dbx_business_glossary_term' = 'Previous Period Price');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `price_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `price_control_method` SET TAGS ('dbx_business_glossary_term' = 'Price Control Method');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `price_control_method` SET TAGS ('dbx_value_regex' = 'S|V');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Amount');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `provision_for_obsolescence` SET TAGS ('dbx_business_glossary_term' = 'Provision for Obsolescence');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `total_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Value');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Valuation Adjustment Reason');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_category` SET TAGS ('dbx_business_glossary_term' = 'Valuation Category');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_category` SET TAGS ('dbx_value_regex' = 'raw_material|work_in_progress|finished_goods|trading_goods|spare_parts|consumables');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'active|blocked|restricted|obsolete|write_off_pending');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` SET TAGS ('dbx_subdomain' = 'material_control');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Stock ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Quality Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `disposition_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'RELEASE|USE_AS_IS|REWORK|RETURN_TO_VENDOR|SCRAP|PENDING');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `disposition_justification` SET TAGS ('dbx_business_glossary_term' = 'Disposition Justification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `erp_system_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) System Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `expected_release_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `initiating_document_number` SET TAGS ('dbx_business_glossary_term' = 'Initiating Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `initiating_document_type` SET TAGS ('dbx_business_glossary_term' = 'Initiating Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `initiating_document_type` SET TAGS ('dbx_value_regex' = 'NCR|CAPA|INSPECTION_REPORT|CUSTOMER_COMPLAINT|SUPPLIER_NOTIFICATION|REGULATORY_NOTICE');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_notes` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_reason_code` SET TAGS ('dbx_value_regex' = 'INCOMING_INSPECTION|IN_PROCESS_FAILURE|CUSTOMER_COMPLAINT|NCR|REGULATORY_HOLD|SHELF_LIFE_EXPIRY');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_record_number` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Record Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_record_number` SET TAGS ('dbx_value_regex' = '^QR-[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_value_regex' = 'OPEN|UNDER_INVESTIGATION|PENDING_APPROVAL|RELEASED|CLOSED');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `storage_bin_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Bin Location');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`quarantine_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` SET TAGS ('dbx_subdomain' = 'material_control');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `parent_unit_serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Unit ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Tariff Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (Centimeters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (Centimeters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'company_owned|customer_owned|vendor_owned|third_party_owned');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_inspected|pending_inspection|passed|failed|conditional_release');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted|customer_consignment|vendor_consignment');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`serialized_unit` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (Centimeters)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` SET TAGS ('dbx_subdomain' = 'warehouse_management');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `annual_carbon_emission_tons` SET TAGS ('dbx_business_glossary_term' = 'Annual Carbon Emission Tons');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `annual_energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Energy Consumption Mwh');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `energy_source` SET TAGS ('dbx_business_glossary_term' = 'Energy Source');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `environmental_certifications` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certifications');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `is_primary_plant` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Plant');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `maintenance_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle Days');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `inventory_plant_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `number_of_shifts` SET TAGS ('dbx_business_glossary_term' = 'Number Of Shifts');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `operating_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Per Day');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `plant_area_sq_m` SET TAGS ('dbx_business_glossary_term' = 'Plant Area Sq M');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `production_capacity` SET TAGS ('dbx_business_glossary_term' = 'Production Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `safety_certifications` SET TAGS ('dbx_business_glossary_term' = 'Safety Certifications');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `shutdown_date` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `inventory_plant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `waste_generated_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated Tons');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` SET TAGS ('dbx_subdomain' = 'warehouse_management');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `control_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Control Cycle Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `parent_control_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Control Cycle Id');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `parent_control_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `associated_process` SET TAGS ('dbx_business_glossary_term' = 'Associated Process');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `cycle_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Duration Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `control_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `related_equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Related Equipment Class');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `safety_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Level');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`control_cycle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` SET TAGS ('dbx_subdomain' = 'warehouse_management');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_area_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Area Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Id');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `parent_supply_area_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Supply Area Id');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `parent_supply_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_responsible_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_responsible_manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `area_sq_meters` SET TAGS ('dbx_business_glossary_term' = 'Area Sq Meters');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capacity Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Uom');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_area_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `current_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Current Occupancy');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `external_system_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `humidity_controlled` SET TAGS ('dbx_business_glossary_term' = 'Humidity Controlled');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `humidity_range_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Range Percent');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Is Temperature Controlled');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `max_load_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Max Load Weight Kg');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_area_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `occupancy_uom` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Uom');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_area_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `temperature_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Celsius');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `supply_area_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`supply_area` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
