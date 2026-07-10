-- Schema for Domain: inventory | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`inventory` COMMENT 'Inventory and warehouse management domain governing raw materials, WIP, finished goods, SKUs, lot/batch tracking, bin locations, cycle counts, stock movements, JIT inventory control, safety stock optimization, and material handling across all facilities. Integrates SAP WM and Microsoft Dynamics 365 SCM for real-time stock visibility and MRP-driven replenishment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` (
    `stock_location_id` BIGINT COMMENT 'Unique identifier for the physical storage location within warehouses and facilities. Primary key for the stock location master record.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Directly associate stock_location with its plant for clearer reporting and eliminate redundant plant_code string.',
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
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Warehouse belongs to a plant; adding plant_id enables hierarchy without creating a cycle.',
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
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for production planning and cost roll‑up reports that map inventory material to the SKU definition used in sales orders and cost accounting.',
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
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Project Material Reservation Report requires tracking inventory reserved for each project to ensure accurate cost allocation.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the stock is physically located. Links to the plant master data.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑owned stock balances (e.g., VMI) need a FK to the customer account for reporting on on‑hand quantities per customer.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Stock balance includes inspection status; linking to the specific inspection lot enables detailed traceability for quality release decisions.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: stock_balance captures on-hand quantities by stock category, and for batch-managed materials the balance is tracked at the batch level. The batch_number STRING column is a denormalized reference to th',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which this stock balance is maintained. Links to the material product in the Product Engineering domain.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location within the plant where the material is stored. Links to storage location master data.',
    `abc_classification` STRING COMMENT 'ABC analysis classification based on material value and consumption. A items are high-value/high-usage requiring tight control; B items are moderate; C items are low-value/low-usage with relaxed control.. Valid values are `A|B|C`',
    `available_quantity` DECIMAL(18,2) COMMENT 'Quantity available for new orders or production, calculated as unrestricted quantity on hand minus reserved quantity. Used for Available-to-Promise (ATP) calculations.',
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
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Manufacturing lot traceability requires knowing which BOM revision was active when a batch was produced — critical for product recall scope determination and engineering change order (ECO) impact anal',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Regulated batch tracking often requires associating a batch with the specific customer that ordered it.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Batch production in regulated industries (pharma, chemicals) is subject to specific regulatory requirements; linking batches to those requirements supports batch release compliance.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Lot_batch records the originating plant; a foreign key enforces referential integrity.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record that this lot or batch belongs to. Links to the material product for which batch management is enabled.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plan. Business justification: Supply chain traceability and production variance reporting: planners compare planned supply quantities (supply_plan) against actual lot quantities produced/received. Links each batch to the supply pl',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order under which this batch was procured from an external supplier. Applicable only to purchased materials and components.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Lot/batch traceability reports, quality recalls, and customer Certificates of Analysis in manufacturing require direct SKU-level identification on batch records. Navigating via material_master adds un',
    `stock_location_id` BIGINT COMMENT 'Reference to the primary storage location or warehouse where this batch is currently stored. Supports location-based inventory tracking and warehouse management.',
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
    `customer_account_id` BIGINT COMMENT 'Foreign key reference to the customer when this movement is a goods issue for sales delivery or a return from customer.',
    `delivery_id` BIGINT COMMENT 'Foreign key reference to the outbound delivery document when this movement is part of a shipment to customer.',
    `field_service_order_id` BIGINT COMMENT 'Foreign key linking to service.field_service_order. Business justification: Goods issues (stock movements) triggered by field service orders must be traceable to the originating FSO for service cost accounting, parts consumption reconciliation, and warranty cost tracking. Man',
    `header_id` BIGINT COMMENT 'Foreign key reference to the sales order when this movement is a goods issue for customer delivery.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Goods movements that trigger inspections must reference the inspection lot to associate movement data with inspection outcomes, used in compliance reporting.',
    `inventory_plant_id` BIGINT COMMENT 'Foreign key linking to inventory.plant. Business justification: Stock movement occurs within a plant; adding plant_id enforces correct plant association.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: stock_movement records inventory movements that are often batch-managed. The batch_number STRING column is a denormalized reference to the lot_batch master. Adding lot_batch_id FK normalizes this rela',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record representing the SKU, raw material, WIP component, or finished good that was moved.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Stock movements for NCR-driven actions (blocking nonconforming stock, scrapping, rework transfer — SAP movement types 344/551/553) must reference the triggering NCR. This link enables NCR-to-inventory',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Goods-issue traceability and revenue recognition: linking the inventory goods-issue movement back to the originating sales booking enables order fulfillment confirmation, revenue recognition triggerin',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: MRP execution tracking: goods receipt stock movements confirm fulfillment of planned orders. Planners use this link to close/reduce planned order quantities upon goods receipt, enabling MRP execution ',
    `production_work_order_id` BIGINT COMMENT 'Foreign key reference to the production order when this movement is a goods issue to manufacturing or a goods receipt from production.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the purchase order when this movement is a goods receipt from procurement.',
    `run_id` BIGINT COMMENT 'Foreign key linking to production.production_run. Business justification: Finished goods receipts and WIP goods movements must reference the production run that generated them. Run-level inventory reconciliation and production cost accounting reports require this link. stoc',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Link stock movement to its source location for traceability; replace free‑text code with FK.',
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
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Link cycle count header to the physical location where the count occurs; replace code with FK.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: cycle_count events are performed within a specific warehouse. The warehouse_number STRING column is a denormalized reference to the warehouse master. Adding warehouse_id FK normalizes this relationshi',
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
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Cycle count event header record capturing scheduled and ad-hoc physical inventory counts for specific materials, storage locations, or zones. Tracks count document number, count date, count type (ABC cycle, annual physical, ad-hoc recount), counter assignment, zone or location scope, planned vs actual count date, overall variance summary, approval status, and posting status. Supports ABC-based cycle count programs, annual physical inventory compliance, and inventory accuracy KPI tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order record. Primary key for this entity.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Replenishment orders generated for project consumption must be linked to the project for cost and schedule tracking.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the material is being replenished.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Vendor‑Managed Inventory (VMI) orders are generated per customer; linking the order to the customer account enables demand‑driven replenishment.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: replenishment_order has a batch_number STRING column indicating that replenishment orders can be tied to specific lot/batch records (e.g., when replenishing a specific batch for quality or traceabilit',
    `material_master_id` BIGINT COMMENT 'Reference to the material or SKU being replenished. Links to the material master record.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: MRP ORDER CONVERSION: replenishment orders are created from MRP planned orders; linking enables traceability.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Replenishment orders in manufacturing are fulfilled by purchase orders — the replenishment-to-PO fulfillment tracking process is essential for inventory planners to confirm stock replenishment status.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Make-to-order and demand-driven replenishment: a customer sales order directly triggers a replenishment order. Linking source_order_header_id enables traceability from replenishment back to the origin',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Procurement compliance audit: replenishment orders are generated based on sourcing rules (make-vs-buy, preferred supplier, MOQ). This link enables auditors and planners to verify each replenishment or',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location or warehouse bin where the replenished material will be stored.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order was approved for execution, marking transition from draft to active status.',
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
    `reference_order_type` STRING COMMENT 'Classification of the reference order type that is consuming or requiring this replenishment.. Valid values are `production_order|sales_order|maintenance_order|project|none`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level threshold that triggers automatic replenishment when stock falls below this point, used in min-max and reorder point planning strategies.',
    `replenishment_type` STRING COMMENT 'Classification of the replenishment trigger mechanism: planning-driven (MRP-based), kanban (pull-based), min-max (reorder point), JIT (Just In Time), manual reservation, or safety stock replenishment.. Valid values are `planning_driven|kanban|min_max|jit|manual_reservation|safety_stock`',
    `requested_delivery_date` DATE COMMENT 'Target date by which the replenished material is required to be available at the storage location to meet production or demand requirements.',
    `required_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material required to meet the replenishment target or reservation commitment, expressed in the base unit of measure.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently reserved or committed against this replenishment order, used for available-to-promise (ATP) calculation.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum buffer stock quantity that should be maintained at the storage location to protect against demand variability and supply disruptions.',
    `serial_number_required` BOOLEAN COMMENT 'Indicates whether individual serial number tracking is required for the replenished material items.',
    `source_type` STRING COMMENT 'Classification of the source from which the material will be replenished: purchase requisition (external procurement), production order (internal manufacturing), stock transfer (inter-plant), external procurement, or internal transfer.. Valid values are `purchase_requisition|production_order|stock_transfer|external_procurement|internal_transfer`',
    `special_procurement_type` STRING COMMENT 'Classification of special procurement arrangements such as consignment stock, subcontracting, pipeline materials, or inter-plant stock transfers.. Valid values are `standard|consignment|subcontracting|pipeline|stock_transfer|none`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the material quantity (e.g., EA for each, KG for kilogram, L for liter, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Planning-driven, kanban-triggered, or manually-created replenishment and reservation record for restocking materials to safety stock or reorder point levels, or committing stock for planned consumption. Captures order number, material, plant, storage location, replenishment type (planning-driven, kanban, min-max, JIT, manual reservation), required quantity, requested delivery date, source (purchase requisition, production order, stock transfer), reference order (production order, sales order, maintenance order), priority, reserved quantity, and fulfillment status. Unifies demand commitment and replenishment execution into a single record for available-to-promise calculation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` (
    `inventory_plant_id` BIGINT COMMENT 'Primary key for plant',
    `address_line1` STRING COMMENT 'Primary street address of the plant.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `annual_carbon_emission_tons` DECIMAL(18,2) COMMENT 'Estimated CO₂ emissions produced by the plant each year.',
    `annual_energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity or fuel consumption per year measured in megawatt‑hours.',
    `area_sq_m` DECIMAL(18,2) COMMENT 'Total built‑up area of the plant in square meters.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the production capacity.',
    `city` STRING COMMENT 'City where the plant is located.',
    `compliance_status` STRING COMMENT 'Current compliance standing with industry regulations.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the plant location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the plant record was first created in the master system.',
    `data_classification` STRING COMMENT 'Classification level for data governance purposes.',
    `energy_source` STRING COMMENT 'Main energy source powering the plant.',
    `environmental_certifications` STRING COMMENT 'Comma‑separated list of environmental certifications (e.g., ISO 14001).',
    `inventory_plant_status` STRING COMMENT 'Current operational status of the plant.',
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
    `plant_type` STRING COMMENT 'Categorizes the plant by its primary manufacturing function.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the plant address.',
    `production_capacity` DECIMAL(18,2) COMMENT 'Maximum production output the plant can achieve per capacity unit.',
    `region` STRING COMMENT 'Broad geographic region (e.g., North America, EMEA).',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the plant must submit periodic regulatory reports.',
    `safety_certifications` STRING COMMENT 'Comma‑separated list of safety standards the plant complies with (e.g., ISO 45001).',
    `shutdown_date` DATE COMMENT 'Date when the plant was permanently closed or decommissioned (nullable).',
    `start_date` DATE COMMENT 'Date when the plant began operations or was commissioned.',
    `state` STRING COMMENT 'State or province of the plant location.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the plant (e.g., America/Chicago).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the plant record.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Total waste material generated annually by the plant.',
    CONSTRAINT pk_inventory_plant PRIMARY KEY(`inventory_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_inventory_plant_id` FOREIGN KEY (`inventory_plant_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`inventory_plant`(`inventory_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` SET TAGS ('dbx_subdomain' = 'storage_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` SET TAGS ('dbx_subdomain' = 'storage_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`warehouse` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` SET TAGS ('dbx_subdomain' = 'material_management');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` SET TAGS ('dbx_subdomain' = 'material_management');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` SET TAGS ('dbx_subdomain' = 'material_management');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Production Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Stock Location Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Source Order Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Source Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'purchase_requisition|production_order|stock_transfer|external_procurement|internal_transfer');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|pipeline|stock_transfer|none');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` SET TAGS ('dbx_subdomain' = 'storage_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `inventory_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `annual_carbon_emission_tons` SET TAGS ('dbx_business_glossary_term' = 'Annual Carbon Emission Tons');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `annual_energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Energy Consumption Mwh');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `area_sq_m` SET TAGS ('dbx_business_glossary_term' = 'Plant Area Sq M');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `inventory_plant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
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
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`inventory_plant` ALTER COLUMN `waste_generated_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated Tons');
