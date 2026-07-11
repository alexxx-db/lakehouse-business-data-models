-- Schema for Domain: inventory | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 13:03:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`inventory` COMMENT 'Owns physical inventory positions across the entire distribution network. Manages stock on hand, in-transit inventory, warehouse locations, FEFO/FIFO rotation rules, DIO metrics, OOS/OSA events, VMI replenishment triggers, lot/batch traceability for recall readiness, safety stock levels, and multi-echelon inventory visibility.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique identifier for the stock position record. Primary key for the stock position entity.',
    `inventory_storage_location_id` BIGINT COMMENT 'Reference to the physical storage location (warehouse, distribution center, store, or specific bin) where the inventory is held.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Batch‑level inventory reconciliation report requires linking each stock position to its lot_batch for traceability of production dates and quality attributes.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or distribution facility that owns this inventory position.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Inventory Balance Report requires linking each stock_position to its brand for marketing planning and stock‑availability forecasts.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: REQUIRED: Links each stock record to its purchase‑order line for cost allocation and replenishment analysis.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: REQUIRED: Traceability of on‑hand stock to the goods receipt that created it for audit and regulatory compliance.',
    `product_lca_id` BIGINT COMMENT 'Foreign key linking to sustainability.product_lca. Business justification: Required for LCA‑based inventory reporting; associates each stock position with its product LCA to calculate carbon footprint per inventory unit.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Material allocation: ties inventory stock positions to the production order that consumes them, enabling allocation reports and MRP planning.',
    `regulatory_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Inventory stock position reports need registration status of each SKU to ensure market compliance and audit readiness.',
    `research_formulation_id` BIGINT COMMENT 'Foreign key linking to research.research_formulation. Business justification: Formulation Traceability Report requires linking each stock position to the formulation that defines its composition for quality investigations.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU for which inventory is held. Links to the product master data.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: REPLENISHMENT PLANNING: stock positions need to reference SKU planning parameters for safety stock and lot sizing decisions.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor who owns consignment stock. Populated only when special_stock_indicator is consignment.',
    `available_to_promise_quantity` DECIMAL(18,2) COMMENT 'Quantity available for new customer orders after accounting for existing commitments and reservations. Calculated as unrestricted quantity minus reserved quantity.',
    `blocked_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock that is blocked from use due to quality issues, regulatory holds, or other restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock position record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the inventory valuation. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CAD|AUD|INR|BRL|MXN — 10 candidates stripped; promote to reference product]',
    `days_inventory_outstanding` STRING COMMENT 'Number of days the current inventory level would last based on average daily demand. Key metric for working capital efficiency and cash flow management.',
    `expiration_date` DATE COMMENT 'Date after which the product should not be sold or used. Essential for FEFO inventory rotation and regulatory compliance.',
    `goods_receipt_date` DATE COMMENT 'Date when the inventory was physically received at this storage location. Used for FIFO rotation and aging analysis.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock currently in transit between locations (plant-to-warehouse, warehouse-to-store, etc.) and not yet received at destination.',
    `last_goods_movement_date` DATE COMMENT 'Date of the most recent inventory transaction (receipt, issue, transfer) for this stock position. Used to identify slow-moving or obsolete inventory.',
    `last_physical_inventory_date` DATE COMMENT 'Date when the last physical count or cycle count was performed for this stock position. Used for inventory accuracy monitoring.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock position record was last modified. Used for data freshness monitoring and change tracking.',
    `manufacturing_date` DATE COMMENT 'Date when the batch or lot was manufactured. Critical for shelf-life management and FEFO rotation.',
    `maximum_stock_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory level allowed at this location to prevent overstocking and optimize working capital.',
    `obsolete_flag` BOOLEAN COMMENT 'Indicates whether the inventory is obsolete (discontinued product, expired, or no longer saleable) and should be written off or disposed.',
    `oos_risk_flag` BOOLEAN COMMENT 'Indicates whether the current stock level is below safety stock and at risk of stockout. Used for proactive replenishment alerts.',
    `quality_inspection_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock currently undergoing quality control inspection and not yet released for use.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current physical inventory quantity available at the storage location. This is the authoritative single source of truth for inventory balance.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the stock is under quarantine pending quality inspection, regulatory review, or investigation.',
    `recall_hold_flag` BOOLEAN COMMENT 'Indicates whether the stock is on hold due to a product recall or safety alert. Prevents further distribution or sale.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level that triggers automatic replenishment. When stock falls to this level, a purchase requisition or transfer order is generated.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock reserved for specific sales orders, production orders, or other commitments and not available for general allocation.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory level maintained as buffer stock to prevent stockouts due to demand variability or supply disruptions.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items requiring individual unit tracking.',
    `shelf_life_remaining_days` STRING COMMENT 'Number of days remaining until expiration. Used for FEFO prioritization and markdown planning.',
    `slow_moving_flag` BOOLEAN COMMENT 'Indicates whether the inventory has had no or minimal movement over a defined period (typically 90+ days), signaling potential obsolescence risk.',
    `special_stock_indicator` STRING COMMENT 'Indicates whether the stock is held under special conditions or ownership arrangements. Standard stock is company-owned and unrestricted; consignment is supplier-owned; project stock is allocated to specific projects; sales order stock is reserved for specific customer orders; subcontracting stock is at vendor location; pipeline stock is in-transit; returnable packaging is reusable containers. [ENUM-REF-CANDIDATE: standard|consignment|project|sales_order|subcontracting|pipeline|returnable_packaging — 7 candidates stripped; promote to reference product]',
    `stock_rotation_rule` STRING COMMENT 'Inventory rotation policy applied at this location. FIFO=First In First Out; FEFO=First Expired First Out (for perishables); LIFO=Last In First Out; Manual=operator-controlled picking.. Valid values are `fifo|fefo|lifo|manual`',
    `stock_status` STRING COMMENT 'Current lifecycle status of the stock position. Active=available for operations; Inactive=temporarily unavailable; Pending Disposal=marked for write-off; Transferred=moved to another location; Consumed=used in production or sold.. Valid values are `active|inactive|pending_disposal|transferred|consumed`',
    `stock_type` STRING COMMENT 'Classification of inventory by availability status. Unrestricted stock is available for sale or use; quality inspection stock is pending QC approval; blocked stock cannot be used; returns stock is customer returns awaiting disposition; restricted use stock has limited applications; consignment stock is owned by supplier; VMI-managed stock is vendor-managed inventory. [ENUM-REF-CANDIDATE: unrestricted|quality_inspection|blocked|returns|restricted_use|consignment|vmi_managed — 7 candidates stripped; promote to reference product]',
    `total_value` DECIMAL(18,2) COMMENT 'Total financial value of the stock position, calculated as quantity on hand multiplied by unit cost. Used for balance sheet reporting and working capital analysis.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of inventory at this location, used for inventory valuation and COGS calculation.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is measured. EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon, M=Meter, FT=Foot. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL|M|FT — 9 candidates stripped; promote to reference product]',
    `unrestricted_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock that is freely available for sale, production, or distribution without any restrictions.',
    `valuation_type` STRING COMMENT 'Method used to value the inventory for financial reporting. Standard uses predetermined costs; moving average recalculates after each receipt; FIFO assumes first-in-first-out; LIFO assumes last-in-first-out; weighted average uses average cost across all receipts.. Valid values are `standard|moving_average|fifo|lifo|weighted_average`',
    `vmi_replenishment_flag` BOOLEAN COMMENT 'Indicates whether this stock position is managed under a VMI agreement where the vendor is responsible for replenishment decisions.',
    CONSTRAINT pk_stock_position PRIMARY KEY(`stock_position_id`)
) COMMENT 'Core master record of physical inventory on-hand quantities for each SKU at each storage location. Captures unrestricted, quality-hold, blocked, consignment, VMI-managed, and in-transit stock quantities by stock type and special stock indicator. Serves as the authoritative real-time inventory balance (single source of truth for quantity on hand). Supports OOS/OSA monitoring, days-inventory-outstanding calculation, available-to-promise derivation, and multi-echelon inventory visibility across the distribution network.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` (
    `lot_batch_id` BIGINT COMMENT 'Unique identifier for the lot or batch record. Primary key for the lot_batch product.',
    `dossier_id` BIGINT COMMENT 'Foreign key linking to regulatory.dossier. Business justification: Batch traceability links each lot/batch to its regulatory dossier for post‑market surveillance and recall investigations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory quality inspection requires recording the employee ID of the inspector for each batch; essential for traceability and compliance audits.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing facility where this lot or batch was produced.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level lot traceability is required for quality compliance and consumer‑facing brand claims; linking lot_batch to brand supports this.',
    `research_formulation_id` BIGINT COMMENT 'Foreign key linking to research.research_formulation. Business justification: Regulatory compliance mandates batch‑to‑formulation mapping to verify that each produced lot follows the approved formulation.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU that this lot or batch represents. Links to the product master.',
    `batch_number` STRING COMMENT 'The externally-known unique batch or lot number assigned during manufacturing. Used for traceability and recall management.',
    `batch_status` STRING COMMENT 'The current lifecycle status of the lot or batch. Indicates whether the batch is active and available, depleted, expired, recalled, destroyed, or transferred to another location.. Valid values are `active|depleted|expired|recalled|destroyed|transferred`',
    `best_before_date` DATE COMMENT 'The date until which the product retains optimal quality. Distinct from expiry_date; product may still be safe but quality may degrade after this date.',
    `certificate_of_analysis_number` STRING COMMENT 'The unique identifier for the Certificate of Analysis document that records the quality test results for this lot or batch.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting regulatory compliance status, exceptions, or special handling requirements for this lot or batch.',
    `country_of_origin` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code representing the country where this lot or batch was manufactured. Required for customs, trade compliance, and labeling.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this lot or batch record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this lot or batch record was first created in the system. Used for audit trail and data lineage.',
    `expiry_date` DATE COMMENT 'The date after which the product should not be used or sold. Used to enforce First Expired First Out (FEFO) inventory rotation and prevent sale of expired goods.',
    `gmp_status` STRING COMMENT 'Indicates whether this lot or batch was produced in compliance with Good Manufacturing Practice standards. Critical for regulatory compliance and quality assurance.. Valid values are `certified|compliant|non_compliant|pending_review|exempt`',
    `hold_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this lot or batch is on hold and cannot be used or shipped. True if on hold, False otherwise.',
    `hold_reason` STRING COMMENT 'The business reason why this lot or batch is on hold, if applicable. Examples: pending quality review, regulatory investigation, customer complaint.',
    `inspection_date` DATE COMMENT 'The date on which quality control inspection was performed on this lot or batch.',
    `lot_number` STRING COMMENT 'Alternative or supplementary lot identifier used in some manufacturing contexts. May be the same as batch_number or represent a sub-batch.',
    `manufacturing_date` DATE COMMENT 'The date on which this lot or batch was manufactured or produced. Critical for shelf-life calculation and First Expired First Out (FEFO) rotation.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this lot or batch record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this lot or batch record was last modified in the system. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about this lot or batch. May include special handling instructions, quality observations, or other relevant information.',
    `production_order_number` STRING COMMENT 'The production order or work order number under which this lot or batch was manufactured. Links to Manufacturing Execution System (MES) records.',
    `quality_grade` STRING COMMENT 'The quality grade or classification assigned to this lot or batch based on quality control inspection results. May affect pricing, distribution channel, or disposal decisions. [ENUM-REF-CANDIDATE: A|B|C|premium|standard|substandard|rejected — 7 candidates stripped; promote to reference product]',
    `quantity_produced` DECIMAL(18,2) COMMENT 'The total quantity of product manufactured in this lot or batch, measured in the base unit of measure.',
    `quarantine_status` STRING COMMENT 'Current quarantine or release status of the lot or batch. Quarantined lots cannot be used or shipped until quality inspection is complete and status is changed to released.. Valid values are `released|quarantined|rejected|pending_inspection|conditionally_released`',
    `receipt_date` DATE COMMENT 'The date on which this lot or batch was received into inventory, applicable for purchased or transferred goods.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this lot or batch meets all applicable regulatory compliance requirements. True if compliant, False otherwise.',
    `remaining_shelf_life_days` STRING COMMENT 'The number of days remaining until expiry_date as of the current date. Used for inventory rotation and markdown decisions.',
    `retest_date` DATE COMMENT 'The date by which the lot or batch must be retested to confirm continued quality and compliance. Common in pharmaceutical and chemical manufacturing.',
    `shelf_life_days` STRING COMMENT 'The number of days from manufacturing_date to expiry_date, representing the total shelf life of this lot or batch. Used for First Expired First Out (FEFO) calculations.',
    `storage_condition_requirement` STRING COMMENT 'The required storage conditions for this lot or batch to maintain product quality and safety. Examples: ambient, refrigerated, frozen, controlled room temperature.. Valid values are `ambient|refrigerated|frozen|controlled_room_temperature|hazmat`',
    `storage_location_code` STRING COMMENT 'The warehouse or storage location code where this lot or batch is currently stored. Used for inventory visibility and warehouse management.',
    `supplier_lot_number` STRING COMMENT 'The lot or batch number assigned by the supplier for received raw materials or finished goods. Used for traceability back to the supplier in case of quality issues or recalls.',
    `traceability_code` STRING COMMENT 'A unique code used for end-to-end supply chain traceability of this lot or batch. May be a GS1 Global Trade Item Number (GTIN) with batch extension or similar standard.',
    `unit_of_measure` STRING COMMENT 'The unit in which quantity_produced is measured. Examples: EA (each), CS (case), KG (kilogram), L (liter). [ENUM-REF-CANDIDATE: EA|CS|KG|LB|L|GAL|M|FT — 8 candidates stripped; promote to reference product]',
    `vendor_name` STRING COMMENT 'The name of the vendor or supplier from whom this lot or batch was received, if applicable for purchased goods.',
    CONSTRAINT pk_lot_batch PRIMARY KEY(`lot_batch_id`)
) COMMENT 'Master record for each manufactured or received lot/batch of a SKU, capturing batch number, manufacturing date, expiry date, best-before date, country of origin, GMP status, and quarantine flags. Supports FEFO/FIFO rotation enforcement, lot-level traceability for recall readiness, and regulatory compliance (FDA 21 CFR Part 11, EU REACH, EU Food Information Regulation). Linked to production batch records in manufacturing execution systems and quality inspection lots.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` (
    `inventory_storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location within the distribution network. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Regulatory reporting requires mapping each storage location to its jurisdiction for local compliance (labeling, safety, reporting).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each storage location has a manager responsible for inventory integrity; used in location performance and accountability reports.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the parent facility (distribution center, warehouse, retail store, or third-party logistics provider) where this storage location resides.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: WAREHOUSE MANAGEMENT: each storage location is physically part of a supply network node; required for location‑level inventory reporting.',
    `third_party_provider_id` BIGINT COMMENT 'Reference to the third-party logistics provider managing this location, if applicable. Null for company-owned facilities.',
    `abc_classification` STRING COMMENT 'ABC analysis classification for the location based on inventory velocity and value. A for high-velocity/high-value, B for medium, C for low-velocity/low-value items. Used for slotting optimization.. Valid values are `A|B|C`',
    `aisle` STRING COMMENT 'Aisle designation within the warehouse layout for physical navigation and location addressing.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bay` STRING COMMENT 'Bay or section identifier within an aisle, representing a vertical or horizontal subdivision of storage space.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bin` STRING COMMENT 'Bin or slot identifier representing the smallest addressable storage unit within a level, used for item-level location precision.. Valid values are `^[A-Z0-9]{1,5}$`',
    `blocked_date` DATE COMMENT 'Date when the location was blocked or made unavailable for inventory placement.',
    `blocked_reason` STRING COMMENT 'Explanation for why the location is blocked or unavailable, used for operational troubleshooting and compliance documentation.',
    `capacity_pallet_positions` STRING COMMENT 'Number of standard pallet positions that can be stored in this location, used for pallet-based inventory planning.',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the storage location in cubic meters, used for space utilization optimization.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in kilograms, used for load planning and safety compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the system for audit trail and data lineage.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this location is designated for cross-docking operations where goods move directly from receiving to shipping without long-term storage.',
    `effective_end_date` DATE COMMENT 'Date when the storage location was decommissioned or removed from active use. Null for currently active locations.',
    `effective_start_date` DATE COMMENT 'Date when the storage location became operational and available for inventory placement.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the storage location is certified and equipped for storing hazardous materials per regulatory requirements.',
    `last_inventory_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count performed at this location, used for inventory accuracy tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was most recently updated for change tracking and audit compliance.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent inventory movement (putaway, pick, transfer) at this location, used for activity analysis and slotting optimization.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the storage location for geospatial analytics, route optimization, and facility mapping.',
    `inventory_storage_location_level` STRING COMMENT 'Vertical level or shelf position within a bay, used for precise location addressing in multi-tier racking systems.. Valid values are `^[A-Z0-9]{1,3}$`',
    `location_code` STRING COMMENT 'Business identifier for the storage location used across warehouse management and inventory systems. Unique alphanumeric code assigned to each physical or logical storage position.. Valid values are `^[A-Z0-9]{4,20}$`',
    `location_name` STRING COMMENT 'Human-readable name or description of the storage location for operational reference and reporting.',
    `location_status` STRING COMMENT 'Current operational status of the storage location. Active for normal operations, blocked for temporary holds, maintenance for repairs, quarantine for quality issues, inactive for unused space, decommissioned for permanently retired locations.. Valid values are `active|inactive|blocked|maintenance|quarantine|decommissioned`',
    `location_type` STRING COMMENT 'Classification of the storage location based on its operational purpose within the warehouse. Bulk storage for palletized goods, pick locations for order fulfillment, reserve for overflow, quarantine for quality hold, returns for reverse logistics, and staging for in-transit goods.. Valid values are `bulk|pick|reserve|quarantine|returns|staging`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the storage location for geospatial analytics, route optimization, and facility mapping.',
    `mixed_sku_allowed_flag` BOOLEAN COMMENT 'Indicates whether the location permits storage of multiple SKUs simultaneously or requires single-SKU dedication for inventory accuracy.',
    `picking_priority` STRING COMMENT 'Numeric priority ranking for order picking optimization. Lower numbers indicate higher priority for fast-moving SKUs and efficient pick path planning.',
    `replenishment_trigger_threshold` DECIMAL(18,2) COMMENT 'Percentage threshold that triggers automatic replenishment from reserve to pick locations. Used in Vendor Managed Inventory (VMI) and automated replenishment processes.',
    `rotation_rule` STRING COMMENT 'Inventory rotation policy applied to this location. FEFO (First Expired First Out) for perishables, FIFO (First In First Out) for standard goods, LIFO (Last In First Out) for specific scenarios, or MANUAL for operator-controlled picking.. Valid values are `FEFO|FIFO|LIFO|MANUAL`',
    `security_level` STRING COMMENT 'Security classification of the storage location based on access controls and monitoring requirements. High-value for premium products, controlled substance for regulated materials, restricted for limited access areas.. Valid values are `standard|restricted|high_value|controlled_substance`',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the storage location. Ambient for room temperature, refrigerated for 2-8°C, frozen for below 0°C, and controlled for specific temperature ranges required by product specifications.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `zone_code` STRING COMMENT 'WMS zone identifier used for warehouse layout management, picking optimization, and labor allocation. Zones group locations by operational characteristics or product categories.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_inventory_storage_location PRIMARY KEY(`inventory_storage_location_id`)
) COMMENT 'Master record for physical and logical storage locations within the distribution network including distribution centers, warehouses, retail back-rooms, 3PL facilities, and in-transit staging areas. Captures location code, location type (bulk, pick, reserve, quarantine, returns), temperature zone, capacity (weight, volume, pallet positions), WMS zone mapping, and geo-coordinates. Serves as the single source of truth for the location hierarchy used across warehouse management and inventory systems.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction. Primary key for the stock movement record.',
    `bom_line_id` BIGINT COMMENT 'Foreign key linking to product.bom_line. Business justification: Manufacturing consumption tracking links inventory movements to specific BOM lines, enabling component usage analysis per product in the Component Consumption Report.',
    `campaign_flight_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_flight. Business justification: Logistics teams track stock movements tied to specific campaign flights to measure promotional material delivery and OTIF performance.',
    `carrier_id` BIGINT COMMENT 'Transportation carrier responsible for moving inventory between locations for inter-node transfers.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting for each inventory movement requires linking to the responsible cost center for internal reporting and allocation.',
    `inventory_storage_location_id` BIGINT COMMENT 'Warehouse, plant, or storage location to which inventory is being moved. Null for goods issues to external destinations.',
    `employee_id` BIGINT COMMENT 'System user ID of the person who posted or recorded this stock movement for audit trail and accountability.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the logistics shipment for inter-plant or inter-warehouse transfers to track in-transit inventory.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Needed to tie inventory movements to the originating sales order for order fulfillment audit and cost of goods sold reconciliation.',
    `primary_stock_inventory_storage_location_id` BIGINT COMMENT 'Warehouse, plant, or storage location from which inventory is being moved. Null for goods receipts from external sources.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis of inventory flows assigns each movement to a profit center, needed for segment reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: PO receipt tracking for OTIF reporting and financial reconciliation links stock movements to the originating purchase order.',
    `reversed_movement_stock_movement_id` BIGINT COMMENT 'Reference to the original stock movement record that this transaction reverses or cancels.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU involved in this stock movement event.',
    `supplier_id` BIGINT COMMENT 'Supplier or vendor from whom goods were received for goods receipt movements.',
    `trade_account_id` BIGINT COMMENT 'Customer to whom goods were issued for sales order fulfillment or Direct to Consumer (DTC) shipments.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number for traceability and recall readiness. Critical for FEFO/FIFO rotation and quality control.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock movement record was first created in the system for audit trail.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the movement value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date on the source document (purchase order, production order, delivery note) that triggered this movement.',
    `expiration_date` DATE COMMENT 'Shelf life expiration date for perishable or time-sensitive products. Critical for First Expired First Out (FEFO) rotation and Out of Stock (OOS) prevention.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock movement record was last updated or modified for change tracking.',
    `manufacturing_date` DATE COMMENT 'Date when the product was manufactured or produced. Used for shelf life calculation and traceability.',
    `material_document_number` STRING COMMENT 'SAP material document number generated for this goods movement. Unique identifier in the source ERP system.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year of the material document for SAP document key uniqueness.',
    `movement_category` STRING COMMENT 'High-level classification of the movement event for reporting and analytics purposes.. Valid values are `goods_receipt|goods_issue|stock_transfer|return|adjustment|write_off`',
    `movement_notes` STRING COMMENT 'Free-text notes or comments providing additional context about the stock movement event.',
    `movement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical inventory movement occurred or was recorded in the system.',
    `movement_type_code` STRING COMMENT 'SAP movement type code identifying the nature of the inventory transaction (e.g., 101=Goods Receipt from PO, 261=Goods Issue to Production, 311=Stock Transfer, 551=Scrapping, 601=Goods Receipt from Delivery).. Valid values are `^[A-Z0-9]{2,4}$`',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code where the movement occurred.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'Date when the stock movement was posted to the inventory ledger for financial and inventory accounting purposes.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether this stock movement requires quality inspection before the inventory can be released for use.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory moved in this transaction. Positive for receipts/increases, negative for issues/decreases.',
    `reason_code` STRING COMMENT 'Code explaining the business reason for the movement (e.g., quality issue, damage, expiration, customer return, production scrap).. Valid values are `^[A-Z0-9]{2,6}$`',
    `reference_document_line` STRING COMMENT 'Line item number within the reference document that corresponds to this stock movement.',
    `reference_document_number` STRING COMMENT 'Document number of the source transaction (PO number, production order number, delivery note number) that triggered this movement.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `reference_document_type` STRING COMMENT 'Type of source document that initiated this stock movement for audit trail and reconciliation. [ENUM-REF-CANDIDATE: purchase_order|production_order|sales_order|delivery_note|transfer_order|return_order|adjustment_document — 7 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this movement is a reversal or cancellation of a previous stock movement transaction.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items requiring individual unit tracking.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `special_stock_indicator` STRING COMMENT 'SAP special stock type indicator (e.g., E=Sales Order Stock, K=Consignment Stock, O=Project Stock, W=Vendor Managed Inventory).. Valid values are `^[A-Z]{1}$`',
    `stock_type` STRING COMMENT 'Classification of inventory status determining availability for use (unrestricted=available for sale/use, quality_inspection=pending QC, blocked=not available).. Valid values are `unrestricted|quality_inspection|blocked|restricted|in_transit`',
    `storage_location` STRING COMMENT 'Specific storage location or bin within the plant or warehouse where inventory is stored.. Valid values are `^[A-Z0-9]{4}$`',
    `total_value` DECIMAL(18,2) COMMENT 'Total financial value of the inventory movement (quantity × unit cost) for financial reporting and inventory accounting.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of inventory at the time of movement for inventory valuation and Cost of Goods Sold (COGS) calculation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the movement quantity (e.g., EA=Each, CS=Case, KG=Kilogram, LT=Liter).. Valid values are `^[A-Z]{2,3}$`',
    `valuation_type` STRING COMMENT 'Sub-classification for split valuation of the same material (e.g., domestic vs imported, new vs refurbished).. Valid values are `^[A-Z0-9]{1,4}$`',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record of every inventory movement event including goods receipts, goods issues, stock transfers, returns, write-offs, and inter-plant transfers. Captures movement type code, quantity, unit of measure, source and destination locations, posting date, reference document (purchase order, production order, delivery note), carrier/shipment reference for inter-node transfers, and posting user. Provides the full audit trail for inventory reconciliation and in-transit tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` (
    `inventory_replenishment_order_id` BIGINT COMMENT 'Unique identifier for the inventory replenishment order record. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional campaigns trigger dedicated replenishment orders; linking enables the Campaign‑Driven Replenishment Report used in trade spend planning.',
    `carrier_id` BIGINT COMMENT 'Reference to the logistics carrier assigned to transport this replenishment shipment from source to destination.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replenishment orders are charged to cost centers for budgeting and cost tracking of inventory replenishment.',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or retail location that will receive the replenished inventory.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that created the replenishment order.',
    `primary_inventory_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or manufacturing facility from which inventory will be shipped to fulfill this replenishment order.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑center allocation of replenishment orders supports segment‑level expense reporting.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: REQUIRED: Internal replenishment orders are driven by purchase requisitions; linking supports demand‑driven planning.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU being replenished. Links to the product master for item details.',
    `actual_delivery_date` DATE COMMENT 'Actual date the shipment was received at the destination location. Used to measure delivery performance and OTIF compliance.',
    `actual_ship_date` DATE COMMENT 'Actual date the shipment departed from the source location. Used to calculate On Time In Full (OTIF) performance.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU approved for fulfillment after review and Available to Promise (ATP) validation. May differ from requested quantity due to supply constraints.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the replenishment order was cancelled, if applicable. Examples include demand change, supply constraint, or duplicate order.',
    `expiration_date` DATE COMMENT 'Date after which the product should not be sold or used. Used to enforce First Expired First Out (FEFO) rotation rules in inventory management.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost incurred for transporting this replenishment order from source to destination location.',
    `freight_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order record was last updated in the system.',
    `lead_time_days` STRING COMMENT 'Expected number of days between order placement and delivery at the destination location, based on historical lane performance.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number assigned to the inventory being replenished. Critical for traceability and recall readiness per Good Manufacturing Practice (GMP) requirements.. Valid values are `^[A-Z0-9]{6,20}$`',
    `oos_prevention_flag` BOOLEAN COMMENT 'Indicates whether this replenishment order was created to prevent an anticipated Out of Stock (OOS) event based on demand forecasting.',
    `order_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was approved for fulfillment by the supply chain planner or automated approval workflow.',
    `order_cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was cancelled, if applicable. Null for active orders.',
    `order_creation_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was first created in the system, either automatically by planning algorithms or manually by a planner.',
    `order_notes` STRING COMMENT 'Free-text field for planners to capture special instructions, handling requirements, or contextual information about the replenishment order.',
    `order_status` STRING COMMENT 'Current lifecycle status of the replenishment order indicating its position in the fulfillment workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|in_transit|received|cancelled — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority assigned to the replenishment order to guide fulfillment sequencing and resource allocation. Critical orders address Out of Stock (OOS) situations.. Valid values are `critical|high|normal|low`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity received and confirmed at the destination location. May differ from shipped quantity due to damage or discrepancies.',
    `replenishment_order_number` STRING COMMENT 'Business-facing unique identifier for the replenishment order, used for tracking and communication across systems and stakeholders.. Valid values are `^[A-Z0-9]{8,20}$`',
    `replenishment_type` STRING COMMENT 'Classification of the replenishment order generation method: Vendor Managed Inventory (VMI) auto-replenishment, Distribution Requirements Planning (DRP) planned order, manual trigger by planner, safety stock replenishment, emergency order, or seasonal build.. Valid values are `vmi_auto|drp_planned|manual_trigger|safety_stock|emergency|seasonal`',
    `requested_delivery_date` DATE COMMENT 'Target date by which the replenishment inventory is needed at the destination location to prevent Out of Stock (OOS) conditions.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU requested for replenishment, as calculated by the demand planning system or entered by the planner.',
    `rotation_rule` STRING COMMENT 'Inventory rotation policy applied to this replenishment: First Expired First Out (FEFO) for perishables, First In First Out (FIFO) for standard goods, Last In First Out (LIFO) for specific scenarios.. Valid values are `fefo|fifo|lifo`',
    `safety_stock_trigger_flag` BOOLEAN COMMENT 'Indicates whether this replenishment order was triggered by inventory falling below the safety stock threshold at the destination location.',
    `scheduled_ship_date` DATE COMMENT 'Planned date for shipment departure from the source location, calculated based on lead time and requested delivery date.',
    `shipment_tracking_number` STRING COMMENT 'Carrier-provided tracking number for the shipment associated with this replenishment order. Used for in-transit visibility.. Valid values are `^[A-Z0-9]{10,30}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity shipped from the source location. Updated when the shipment is dispatched.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the replenishment quantity is expressed: Each (EA), Case (CS), Pallet (PL), Pound (LB), Kilogram (KG), Liter (L), Gallon (GAL). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_inventory_replenishment_order PRIMARY KEY(`inventory_replenishment_order_id`)
) COMMENT 'Transactional record of inventory replenishment requests and orders generated through VMI auto-replenishment, distribution requirements planning (DRP), or manual triggers. Captures replenishment type, requested quantity, approved quantity, source location, destination location, requested delivery date, priority, and fulfillment status. Closes the loop between demand sensing signals and physical stock movement execution.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` (
    `inventory_cycle_count_id` BIGINT COMMENT 'Unique identifier for the inventory cycle count event. Primary key for the cycle count record.',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager who approved the cycle count results and authorized the variance adjustment. Required for SOX (Sarbanes-Oxley Act) compliance and segregation of duties.',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse storage location where the cycle count was performed. Links to the physical bin, aisle, or zone within the facility.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the cycle count was performed. Supports multi-site inventory management.',
    `original_count_inventory_cycle_count_id` BIGINT COMMENT 'If this is a recount, references the inventory_cycle_count_id of the original count that triggered the recount requirement. Null for initial counts.',
    `primary_inventory_counter_employee_id` BIGINT COMMENT 'Identifier of the warehouse associate or employee who performed the physical count. Used for accountability and performance tracking.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU (Stock Keeping Unit) that was counted during this cycle count event.',
    `abc_classification` STRING COMMENT 'The ABC inventory classification of the SKU at the time of count. A = high-value items counted frequently, B = medium-value, C = low-value counted less frequently. Drives cycle count frequency.. Valid values are `A|B|C`',
    `adjustment_document_number` STRING COMMENT 'The ERP (Enterprise Resource Planning) document number or transaction ID generated when the inventory adjustment was posted. Used for financial audit trail and reconciliation.',
    `adjustment_posted_flag` BOOLEAN COMMENT 'Indicates whether the variance has been posted as an inventory adjustment in the ERP (Enterprise Resource Planning) system. True = adjustment posted, False = pending posting.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count was approved by the authorized supervisor. Part of the audit trail for inventory adjustments.',
    `count_date` DATE COMMENT 'The calendar date on which the physical cycle count was performed.',
    `count_method` STRING COMMENT 'The methodology used for the cycle count. Full physical = complete inventory audit, ABC cycle = frequency-based counting by value classification, perpetual = continuous counting, spot check = random verification, blind count = counter does not see system quantity.. Valid values are `full_physical|abc_cycle|perpetual|spot_check|blind_count`',
    `count_status` STRING COMMENT 'Current lifecycle status of the cycle count event. Planned = scheduled but not started, in_progress = counting underway, confirmed = count verified, posted = variance adjusted in system, cancelled = count voided, recount_required = variance exceeds threshold.. Valid values are `planned|in_progress|confirmed|posted|cancelled|recount_required`',
    `count_timestamp` TIMESTAMP COMMENT 'Precise date and time when the cycle count was executed. Used for audit trail and WMS (Warehouse Management System) reconciliation.',
    `count_zone` STRING COMMENT 'The warehouse zone or area designation where the count took place (e.g., receiving, picking, reserve, quarantine). Used for zone-based cycle count scheduling.',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The actual physical quantity counted by the warehouse associate during the cycle count event. Measured in the SKUs unit of measure.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was first created in the system. Part of the audit trail.',
    `expiration_date` DATE COMMENT 'The expiration or best-before date of the lot/batch counted. Critical for FEFO (First Expired First Out) rotation rules and consumer safety in CPG (Consumer Packaged Goods).',
    `inventory_value_at_count` DECIMAL(18,2) COMMENT 'The total monetary value of the counted inventory based on the counted quantity and the unit cost at the time of count. Used for financial reconciliation and shrinkage cost calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was last updated. Tracks changes through the count lifecycle (planned → in_progress → confirmed → posted).',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the inventory counted. Critical for traceability and recall readiness in consumer goods.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the counted inventory is in quarantine status pending quality inspection or regulatory clearance. True = quarantined, False = available.',
    `recount_flag` BOOLEAN COMMENT 'Indicates whether this cycle count is a recount of a previous count that exceeded variance thresholds. True = recount, False = initial count.',
    `system_quantity` DECIMAL(18,2) COMMENT 'The quantity recorded in the WMS (Warehouse Management System) or ERP (Enterprise Resource Planning) system at the time of the count. Used to calculate variance.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the counted inventory is stored in a temperature-controlled environment. True = cold chain storage, False = ambient. Relevant for perishable consumer goods.',
    `unit_of_measure` STRING COMMENT 'The unit in which the inventory was counted. EA = each, CS = case, PL = pallet, KG = kilogram, LB = pound, L = liter, GAL = gallon. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_notes` STRING COMMENT 'Free-text explanation or additional context provided by the counter or approver regarding the variance. Used for investigation and documentation.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the system quantity. Calculated as (variance_quantity / system_quantity) * 100. Used to trigger investigation thresholds.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between counted quantity and system quantity (counted minus system). Positive values indicate overage, negative values indicate shortage.',
    `variance_reason_code` STRING COMMENT 'Categorization of the root cause for the inventory variance. Used for shrinkage analysis, process improvement, and loss prevention. [ENUM-REF-CANDIDATE: shrinkage|damage|misplacement|system_error|receiving_error|picking_error|expiration|theft|administrative_error|vendor_shortage — promote to reference product]. Valid values are `shrinkage|damage|misplacement|system_error|receiving_error|picking_error`',
    `variance_value` DECIMAL(18,2) COMMENT 'The monetary value of the variance (variance_quantity * unit_cost). Represents the financial impact of the inventory discrepancy. Used for shrinkage reporting and P&L (Profit and Loss) impact analysis.',
    CONSTRAINT pk_inventory_cycle_count PRIMARY KEY(`inventory_cycle_count_id`)
) COMMENT 'Transactional record of physical inventory cycle count events conducted at storage locations. Captures count date, count method (full physical, ABC cycle, perpetual), counted quantity, system quantity, variance quantity, variance percentage, count status (planned, in-progress, confirmed, posted), and approver. Supports inventory accuracy KPIs, shrinkage investigation triggers, and WMS reconciliation. Distinct from stock_movement as it represents a formal audit event, not a stock transaction.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` (
    `safety_stock_policy_id` BIGINT COMMENT 'Unique identifier for the safety stock policy record. Primary key.',
    `inventory_storage_location_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, or storage location where this safety stock policy applies.',
    `employee_id` BIGINT COMMENT 'Reference to the supply chain planner or inventory analyst responsible for maintaining and reviewing this safety stock policy.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU governed by this safety stock policy.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and velocity. A items are high-value/high-velocity requiring tight control; B items are moderate; C items are low-value/low-velocity; D items are obsolete or slow-moving.. Valid values are `A|B|C|D`',
    `approval_date` DATE COMMENT 'The date when this safety stock policy was formally approved and authorized for use in planning systems.',
    `average_daily_demand` DECIMAL(18,2) COMMENT 'The mean daily demand quantity for this SKU at this location, calculated from historical sales and forecast data. Used in reorder point and safety stock calculations.',
    `calculation_method` STRING COMMENT 'The methodology used to determine safety stock levels. Statistical methods use demand variability and service level; time-based methods use fixed days of supply; manual methods rely on planner judgment; hybrid methods combine multiple approaches.. Valid values are `statistical|time_based|manual|hybrid`',
    `carrying_cost_rate_percent` DECIMAL(18,2) COMMENT 'The annual percentage cost of holding inventory, including warehousing, insurance, obsolescence, and cost of capital. Used to calculate the financial impact of safety stock levels.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The standard cost per unit of the SKU, used to calculate the financial value of safety stock inventory and carrying costs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock policy record was first created in the system.',
    `criticality_level` STRING COMMENT 'Business importance classification indicating the impact of stockouts. Critical items cause production stops or lost sales; high items significantly impact operations; medium and low items have manageable stockout consequences.. Valid values are `critical|high|medium|low`',
    `demand_standard_deviation` DECIMAL(18,2) COMMENT 'Statistical measure of demand variability around the average daily demand. Used to calculate safety stock levels for a given service level target.',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand volatility, typically the coefficient of variation (standard deviation divided by mean demand). Higher values indicate greater uncertainty and require higher safety stock.',
    `effective_from_date` DATE COMMENT 'The date from which this safety stock policy becomes active and is applied in replenishment planning and inventory optimization runs.',
    `effective_to_date` DATE COMMENT 'The date on which this safety stock policy expires or is superseded by a new policy. Null indicates an open-ended policy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock policy record was last updated.',
    `last_review_date` DATE COMMENT 'The date when this safety stock policy was last reviewed and validated by inventory planning or supply chain teams.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'The upper inventory threshold for this SKU-location combination. Prevents overstocking and excess inventory carrying costs.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The smallest order quantity that can be placed for replenishment, typically driven by supplier constraints or economic order quantity calculations.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'The minimum number of days of remaining shelf life required for a product to be shipped to customers or transferred to retail. Products below this threshold may be blocked from sale.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next policy review. Calculated as last_review_date plus review_frequency_days.',
    `order_multiple` DECIMAL(18,2) COMMENT 'The quantity increment in which orders must be placed (e.g., pallet quantities, case pack sizes). Orders are rounded to the nearest multiple.',
    `planning_group` STRING COMMENT 'Organizational grouping code identifying the supply chain planning team or business unit responsible for managing this safety stock policy.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `policy_code` STRING COMMENT 'Business identifier for the safety stock policy, typically a concatenation of SKU and location codes for external reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `policy_notes` STRING COMMENT 'Free-text field for planners to document special considerations, exceptions, seasonal adjustments, or business context relevant to this safety stock policy.',
    `policy_type` STRING COMMENT 'Classification of the safety stock policy methodology. Fixed policies use static parameters; dynamic policies adjust based on demand variability; seasonal policies account for cyclical patterns; promotional policies support campaign-driven demand; VMI (Vendor Managed Inventory) policies are supplier-controlled; consignment policies apply to stock owned by suppliers.. Valid values are `fixed|dynamic|seasonal|promotional|vmi|consignment`',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level at which a replenishment order should be triggered. Calculated as safety stock plus demand during lead time.',
    `replenishment_lead_time_days` STRING COMMENT 'The number of calendar days required from order placement to inventory availability at the location. Includes procurement, production, and transportation time.',
    `replenishment_strategy` STRING COMMENT 'The inventory replenishment approach applied to this SKU-location. Reorder point triggers orders when stock falls below ROP; periodic review orders at fixed intervals; min-max maintains stock between bounds; kanban uses visual signals; DRP (Distribution Requirements Planning) uses time-phased planning; VMI (Vendor Managed Inventory) is supplier-controlled.. Valid values are `reorder_point|periodic_review|min_max|kanban|drp|vmi`',
    `review_frequency_days` STRING COMMENT 'The number of days between scheduled reviews of this safety stock policy. High-value or high-variability items may be reviewed weekly or monthly; stable items may be reviewed quarterly or annually.',
    `rotation_rule` STRING COMMENT 'The inventory rotation strategy applied to this SKU-location. FIFO (First In First Out) for standard goods; FEFO (First Expired First Out) for perishables and date-sensitive products; LIFO (Last In First Out) for specific accounting scenarios; manual for items requiring human judgment.. Valid values are `fifo|fefo|lifo|manual`',
    `safety_stock_policy_status` STRING COMMENT 'Current lifecycle status of the safety stock policy. Active policies are in effect; inactive policies are not applied; suspended policies are temporarily paused; under_review policies are being evaluated; expired policies have passed their validity period; draft policies are not yet approved.. Valid values are `active|inactive|suspended|under_review|expired|draft`',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The target safety stock quantity to be maintained at the location for this SKU, expressed in the base unit of measure. This buffer inventory protects against demand variability and supply uncertainty.',
    `safety_time_days` STRING COMMENT 'Additional lead time buffer added to the replenishment lead time to account for supply uncertainty. Used in time-based safety stock calculations.',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'The target percentage of demand that should be met from available stock without stockouts. Typically ranges from 90% to 99.9% depending on product criticality and business strategy.',
    `shelf_life_days` STRING COMMENT 'The number of days from production or receipt date until the product expires or becomes unsellable. Critical for FEFO rotation and safety stock sizing for perishable goods.',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated cost per unit of a stockout event, including lost sales, expedited freight, production downtime, and customer dissatisfaction. Used in service level optimization.',
    `system_generated_flag` BOOLEAN COMMENT 'Indicates whether this policy was automatically generated by SAP IBP optimization algorithms (true) or manually created by a planner (false).',
    `unit_of_measure` STRING COMMENT 'The base unit in which safety stock quantities are expressed (e.g., EA for each, CS for case, PL for pallet).. Valid values are `^[A-Z]{2,6}$`',
    `xyz_classification` STRING COMMENT 'Demand variability classification. X items have stable, predictable demand; Y items have moderate variability; Z items have highly erratic or unpredictable demand patterns.. Valid values are `X|Y|Z`',
    CONSTRAINT pk_safety_stock_policy PRIMARY KEY(`safety_stock_policy_id`)
) COMMENT 'Master record defining safety stock parameters and reorder point policies for each SKU-location combination. Captures safety stock quantity, reorder point, maximum stock level, minimum order quantity (MOQ), replenishment lead time, service level target (%), demand variability coefficient, and policy review date. Feeds SAP IBP inventory optimization and DRP planning runs. Distinct from stock_position (actual balance) — this is the policy/rule that governs when replenishment is triggered.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` (
    `intransit_shipment_id` BIGINT COMMENT 'Unique identifier for the in-transit shipment record. Primary key for tracking inventory moving between distribution network nodes.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier or third-party logistics provider (3PL) responsible for transporting the shipment.',
    `network_node_id` BIGINT COMMENT 'Identifier of the target location in the distribution network where the shipment is being delivered (distribution center, warehouse, retail store, or customer location).',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Required for shipment‑to‑order tracking in OTIF logistics reports; sales order is the business driver for each in‑transit shipment.',
    `primary_intransit_network_node_id` BIGINT COMMENT 'Identifier of the source location in the distribution network from which the shipment departed (supplier facility, distribution center, warehouse, or manufacturing plant).',
    `research_formulation_id` BIGINT COMMENT 'Foreign key linking to research.research_formulation. Business justification: Launch logistics report tracks shipments of newly launched formulations, tying in‑transit data to the formulation for rollout monitoring.',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU being shipped. For multi-SKU shipments, this represents the primary or single SKU; detailed line-level tracking may exist in related shipment_item records.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment physically arrived at the destination node. Null until arrival occurs. Used for OTIF performance measurement.',
    `batch_number` STRING COMMENT 'Production batch identifier for granular traceability within a lot. Used for quality assurance and regulatory compliance.. Valid values are `^[A-Z0-9]{6,20}$`',
    `carrier_service_level` STRING COMMENT 'The transportation service level or speed tier selected for this shipment, impacting transit time and cost.. Valid values are `standard|expedited|express|overnight|same_day|economy`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this in-transit shipment record was first created in the system. Used for audit trail and data lineage.',
    `departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment physically departed from the origin node. Used for transit time calculation and OTIF (On Time In Full) measurement.',
    `destination_node_type` STRING COMMENT 'Classification of the destination location type in the supply chain network.. Valid values are `distribution_center|warehouse|store|cross_dock|customer`',
    `exception_description` STRING COMMENT 'Detailed narrative description of the exception event, including root cause and resolution actions taken.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment encountered any exceptions during transit (delays, damage, routing issues, temperature excursions).',
    `exception_type` STRING COMMENT 'Classification of the primary exception encountered during shipment transit. Null if no exception occurred.. Valid values are `delay|damage|shortage|temperature_excursion|routing_error|lost`',
    `expected_arrival_date` DATE COMMENT 'Planned or estimated date when the shipment is expected to arrive at the destination node. Used for inventory planning and ATP (Available to Promise) calculations.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight transportation cost for this shipment in the base currency. Used for logistics cost allocation and freight audit.',
    `freight_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight cost amount.. Valid values are `^[A-Z]{3}$`',
    `hazmat_class` STRING COMMENT 'DOT hazard class code for hazardous materials (e.g., 3 for flammable liquids, 8 for corrosives). Null if not hazmat.. Valid values are `^[1-9](.d)?$`',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment contains hazardous materials requiring special handling, labeling, and regulatory compliance.',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment arrived with the complete expected quantity, regardless of timing.',
    `intransit_quantity` DECIMAL(18,2) COMMENT 'Total quantity of inventory units currently in-transit for this shipment. Represents stock that has left origin but not yet arrived at destination.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this in-transit shipment record was most recently modified. Used for change tracking and data freshness monitoring.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number for traceability and recall readiness. Critical for FEFO (First Expired First Out) rotation and quality control.. Valid values are `^[A-Z0-9]{6,20}$`',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment arrived on or before the expected arrival date, regardless of quantity accuracy.',
    `origin_node_type` STRING COMMENT 'Classification of the origin location type in the supply chain network.. Valid values are `supplier|manufacturing_plant|distribution_center|warehouse|store|cross_dock`',
    `otif_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment met OTIF performance criteria (arrived on time with full quantity). True if both time and quantity targets were met.',
    `pallet_count` STRING COMMENT 'Number of pallets included in this shipment. Used for warehouse receiving planning and dock scheduling.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with this shipment, linking the in-transit inventory to the originating procurement transaction.. Valid values are `^[A-Z0-9]{6,20}$`',
    `quantity_uom` STRING COMMENT 'Unit of measure for the in-transit quantity (each, case, pallet, weight, volume). [ENUM-REF-CANDIDATE: each|case|pallet|kg|lbs|liter|gallon — 7 candidates stripped; promote to reference product]',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was formally receipted into destination inventory through WMS (Warehouse Management System). May differ from arrival timestamp due to inspection and put-away processes.',
    `required_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance monitoring.',
    `required_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance monitoring.',
    `shipment_reference_number` STRING COMMENT 'External business identifier for the shipment, used for tracking and communication with carriers and logistics partners. May be ASN (Advanced Shipping Notice) number or BOL (Bill of Lading) number.. Valid values are `^[A-Z0-9]{8,20}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the in-transit shipment. Tracks progression from departure through arrival and final receipt at destination. [ENUM-REF-CANDIDATE: planned|departed|in_transit|arrived|receipted|exception|cancelled — 7 candidates stripped; promote to reference product]',
    `shipment_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters. Used for transportation capacity planning and dimensional weight calculations.',
    `shipment_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including packaging. Used for freight cost calculation and carrier capacity planning.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this shipment requires temperature-controlled transportation (cold chain logistics) to maintain product quality and safety.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for real-time shipment visibility and proof of delivery. Used for integration with carrier tracking systems.. Valid values are `^[A-Z0-9]{10,30}$`',
    `transit_days` STRING COMMENT 'Number of calendar days the shipment was in transit from departure to arrival. Calculated as the difference between actual arrival and departure timestamps.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for moving the shipment between origin and destination.. Valid values are `truck|rail|air|ocean|intermodal|parcel`',
    CONSTRAINT pk_intransit_shipment PRIMARY KEY(`intransit_shipment_id`)
) COMMENT 'Transactional record tracking inventory that is physically in-transit between nodes in the distribution network (supplier-to-DC, DC-to-DC, DC-to-store). Captures shipment reference, origin node, destination node, carrier, in-transit quantity by SKU/lot, expected arrival date, actual arrival date, in-transit status (departed, in-transit, arrived, exception), and OTIF flag. Provides multi-echelon inventory visibility for in-transit stock that is not yet receipted at destination.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` (
    `oos_event_id` BIGINT COMMENT 'Unique identifier for the out-of-stock event record.',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or retail location where the OOS event occurred.',
    `previous_oos_event_id` BIGINT COMMENT 'Reference to the previous OOS event ID for the same SKU-location if this is a recurrence, enabling trend analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Out‑of‑stock events are owned by a specific employee who drives corrective actions; required for OOS root‑cause analysis and SLA reporting.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU that experienced the out-of-stock condition.',
    `actual_demand_units` DECIMAL(18,2) COMMENT 'Actual observed demand in units during the OOS event period, used to identify demand spikes or forecast misses.',
    `brand_name` STRING COMMENT 'Brand name of the SKU that experienced the OOS event, used for brand-level OOS performance tracking.',
    `channel_type` STRING COMMENT 'Distribution channel type where the OOS event occurred: retail, wholesale, e-commerce, DSD (Direct Store Delivery), or DTC (Direct to Consumer).. Valid values are `retail|wholesale|ecommerce|dsd|dtc`',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective action plan implemented to prevent recurrence of similar OOS events in the future.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OOS event record was first created in the system.',
    `customer_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the OOS event resulted in direct customer impact such as lost sales, customer complaints, or service level breaches.',
    `demand_forecast_units` DECIMAL(18,2) COMMENT 'Forecasted demand in units for the period during which the OOS event occurred, used to compare actual vs. planned demand.',
    `detection_source` STRING COMMENT 'System or channel that detected and reported the out-of-stock event, such as POS system, WMS, demand sensing platform, manual report, retail execution app, or EDI feed.. Valid values are `pos_system|wms|demand_sensing|manual_report|retail_execution_app|edi_feed`',
    `estimated_lost_sales_value` DECIMAL(18,2) COMMENT 'Estimated monetary value of sales lost due to the out-of-stock condition, calculated based on historical demand patterns and average selling price.',
    `estimated_lost_units` DECIMAL(18,2) COMMENT 'Estimated quantity of units that could not be sold due to the out-of-stock condition.',
    `event_status` STRING COMMENT 'Current lifecycle status of the OOS event record: open (active OOS), resolved (inventory restored), under investigation (root cause analysis in progress), or closed (fully resolved and documented).. Valid values are `open|resolved|under_investigation|closed`',
    `forecast_accuracy_percent` DECIMAL(18,2) COMMENT 'Forecast accuracy percentage for the SKU-location during the period of the OOS event, calculated as (1 - |actual - forecast| / actual) * 100.',
    `impact_severity` STRING COMMENT 'Severity classification of the OOS event impact based on lost sales value, SKU importance, and customer impact. Categories: critical, high, medium, low.. Valid values are `critical|high|medium|low`',
    `inventory_on_hand_at_oos` DECIMAL(18,2) COMMENT 'System-recorded inventory quantity on hand at the time the OOS event was detected, used to identify phantom inventory situations.',
    `last_replenishment_date` DATE COMMENT 'Date of the most recent replenishment delivery prior to the OOS event, used to analyze replenishment frequency adequacy.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the OOS event record was most recently updated, reflecting changes to status, resolution actions, or root cause analysis.',
    `next_scheduled_replenishment_date` DATE COMMENT 'Date of the next scheduled replenishment delivery at the time of the OOS event, used to assess replenishment planning gaps.',
    `oos_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the out-of-stock event measured in hours, calculated as the difference between end and start timestamps.',
    `oos_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the out-of-stock condition was resolved and inventory became available again.',
    `oos_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the out-of-stock condition was first detected. Sourced from POS data feeds or demand sensing signals.',
    `oos_type` STRING COMMENT 'Classification of the OOS event type: warehouse stockout (no inventory in facility), shelf stockout (inventory in back room but not on shelf), phantom inventory (system shows stock but physical count is zero), or system mismatch.. Valid values are `warehouse_stockout|shelf_stockout|phantom_inventory|system_mismatch`',
    `osa_actual_percent` DECIMAL(18,2) COMMENT 'Actual on-shelf availability percentage achieved during the period including the OOS event, calculated from POS and inventory data.',
    `osa_target_percent` DECIMAL(18,2) COMMENT 'Target on-shelf availability percentage for the SKU-location at the time of the OOS event, used to measure performance against goals.',
    `product_category` STRING COMMENT 'Product category classification of the SKU that experienced the OOS event, used for category-level OOS analysis and reporting.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this OOS event is a recurrence of a previous OOS event for the same SKU-location combination within a defined time window.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Configured reorder point threshold for the SKU at this location, used to evaluate whether replenishment triggers were properly set.',
    `resolution_action` STRING COMMENT 'Action taken to resolve the out-of-stock event, such as emergency replenishment, transfer from alternate location, expedited shipment, customer backorder, substitution offered, or no action taken.. Valid values are `emergency_replenishment|transfer_from_alternate_location|expedited_shipment|customer_backorder|no_action_taken|substitution_offered`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the resolution action was initiated or completed to address the out-of-stock condition.',
    `root_cause_category` STRING COMMENT 'Primary root cause classification for the OOS event. Categories include demand spike, replenishment failure, forecast miss, upstream stockout, logistics delay, or system error.. Valid values are `demand_spike|replenishment_failure|forecast_miss|upstream_stockout|logistics_delay|system_error`',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause behind the out-of-stock event, providing context beyond the category classification.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Configured safety stock level for the SKU at this location at the time of the OOS event, used to assess whether safety stock was breached.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the OOS event caused a breach of service level agreement commitments to customers or retail partners.',
    CONSTRAINT pk_oos_event PRIMARY KEY(`oos_event_id`)
) COMMENT 'Transactional record capturing Out-of-Stock (OOS) and On-Shelf Availability (OSA) events at the SKU-location level. Captures OOS start timestamp, OOS end timestamp, OOS duration (hours), root cause category (demand spike, replenishment failure, forecast miss, upstream stockout, logistics delay), estimated lost sales value, and resolution action. Sourced from POS data feeds and demand sensing signals. Critical for OSA improvement programs, retail execution accountability, and service level reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` (
    `stock_hold_id` BIGINT COMMENT 'Primary key for stock_hold',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Hold decisions must be approved by a designated employee; the link enables hold audit logs and compliance verification.',
    `inspection_lot_id` BIGINT COMMENT 'Identifier linking this hold to a specific quality control inspection record. Used to trace hold back to QC (Quality Control) test results.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Quality or safety holds are often brand‑specific; the link supports brand‑level hold tracking and impact analysis for marketing decisions.',
    `product_complaint_id` BIGINT COMMENT 'Identifier linking this hold to a customer complaint or quality issue reported from the field. Used for root cause analysis.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to inventory.recall_event. Business justification: Stock holds related to a recall should reference the recall event directly, consolidating recall information and eliminating the free‑text recall number.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier who provided the held inventory. Used for supplier quality management and return processing.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the held inventory is located.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold release or disposition was approved by the authorized authority.',
    `batch_number` STRING COMMENT 'Production batch identifier for the held inventory. Used in conjunction with lot number for granular traceability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was first created in the system. Used for audit trail and data lineage.',
    `disposition_date` DATE COMMENT 'Date when the disposition decision was made and executed. Null if disposition is still pending.',
    `disposition_decision` STRING COMMENT 'Final decision on how to handle the held inventory. Release (approve for use), rework (reprocess), destroy (scrap), return to supplier, downgrade (sell as secondary), or pending (awaiting decision).. Valid values are `release|rework|destroy|return_to_supplier|downgrade|pending`',
    `disposition_notes` STRING COMMENT 'Additional notes or comments regarding the disposition decision, including justification and any special handling instructions.',
    `expected_resolution_date` DATE COMMENT 'Target date by which the hold is expected to be resolved. Used for planning and escalation management.',
    `expiration_date` DATE COMMENT 'Product expiration or best-before date for the held inventory. Critical for FEFO (First Expired First Out) rotation and determining if held product is still usable.',
    `gtin` STRING COMMENT 'Global Trade Item Number for the held product. Standardized identifier used across the supply chain.. Valid values are `^[0-9]{8,14}$`',
    `hold_duration_days` STRING COMMENT 'Number of calendar days the inventory has been on hold. Calculated as the difference between current date (or release date) and hold start date. Used for aging analysis and KPI (Key Performance Indicator) reporting.',
    `hold_number` STRING COMMENT 'Business-facing unique identifier for the hold, used in quality management and warehouse operations. Format: HLD-NNNNNNNN.. Valid values are `^HLD-[0-9]{8}$`',
    `hold_priority` STRING COMMENT 'Priority level for resolving the hold. Critical holds require immediate action (e.g., safety issues); low priority holds can be resolved in normal workflow.. Valid values are `critical|high|medium|low`',
    `hold_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory units placed on hold. Measured in the base unit of measure for the SKU (Stock Keeping Unit).',
    `hold_quantity_uom` STRING COMMENT 'Unit of measure for the hold quantity. EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `hold_reason_code` STRING COMMENT 'Standardized code identifying the specific reason for the hold. Format: AAA-NNN. Examples: QCF-001 (failed inspection), REG-002 (FDA recall), DMG-005 (physical damage).. Valid values are `^[A-Z]{3}-[0-9]{3}$`',
    `hold_reason_description` STRING COMMENT 'Detailed narrative explanation of why the hold was placed, including specific quality defects, regulatory citations, or commercial issues.',
    `hold_release_date` DATE COMMENT 'Date when the hold was released and inventory became available for disposition. Null if hold is still active.',
    `hold_release_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the hold was released, including time zone. Used for calculating hold duration and compliance metrics.',
    `hold_start_date` DATE COMMENT 'Date when the hold was placed on the inventory. This is the business event date when the stock became restricted.',
    `hold_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the hold was initiated, including time zone. Used for audit trail and compliance reporting.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold. Active holds block inventory movement; released holds allow disposition; pending review awaits approval; escalated holds require management intervention.. Valid values are `active|pending_review|released|expired|escalated`',
    `hold_type` STRING COMMENT 'Classification of the hold reason. Quality Control (QC) inspection hold, regulatory recall hold, commercial dispute hold, damage hold, quarantine hold, or investigation hold.. Valid values are `quality_control|regulatory_recall|commercial_dispute|damage|quarantine|investigation`',
    `hold_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the inventory on hold, calculated at standard cost. Used for financial impact analysis and reporting.',
    `hold_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the hold value amount. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `is_recall_related` BOOLEAN COMMENT 'Flag indicating whether this hold is related to a product recall. True if the hold is part of a recall action; false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was last updated. Used for audit trail and change tracking.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the inventory on hold. Critical for traceability and recall management.',
    `manufacturing_date` DATE COMMENT 'Date when the held inventory was manufactured or produced. Used for shelf-life calculations and traceability.',
    `notification_sent_flag` BOOLEAN COMMENT 'Flag indicating whether stakeholders (supply chain, sales, customers) have been notified of this hold. True if notifications sent; false otherwise.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when stakeholder notifications were sent regarding this hold. Used for compliance and audit trail.',
    `regulatory_reference_number` STRING COMMENT 'External reference number from regulatory authority (FDA, EPA, CPSC) if the hold is related to a regulatory action, recall, or investigation.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items on hold. Used for unit-level traceability in high-value or regulated products.',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier for the product on hold. Links to product master data for item details.',
    `warehouse_location` STRING COMMENT 'Specific bin, aisle, or zone location within the warehouse where the held inventory is stored. Format varies by WMS (Warehouse Management System).',
    CONSTRAINT pk_stock_hold PRIMARY KEY(`stock_hold_id`)
) COMMENT 'Transactional record of quality holds, regulatory blocks, and commercial holds placed on inventory lots or stock positions. Captures hold type (QC inspection hold, regulatory recall hold, commercial dispute hold, damage hold), hold reason, hold quantity, hold start date, hold release date, hold status, approving authority, and disposition decision (release, rework, destroy, return to supplier). Integrates with quality management usage decisions and regulatory hold workflows.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` (
    `recall_event_id` BIGINT COMMENT 'Unique identifier for the product recall or withdrawal event. Primary key.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Regulatory recall notifications are issued per brand; linking recall_event to brand enables brand‑level recall management and compliance reporting.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Internal recall events must be tied to the external regulatory product recall record to align actions and reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory recall processes assign a coordinator employee; tracking the employee ID is mandatory for audit trails and communication logs.',
    `research_formulation_id` BIGINT COMMENT 'Foreign key linking to research.research_formulation. Business justification: Recall root‑cause analysis links the recalled SKU to the specific formulation that caused the issue, enabling targeted corrective actions.',
    `affected_gtin_list` STRING COMMENT 'Comma-separated list of GTIN/UPC/EAN codes for recalled products. Enables point-of-sale blocking and supply chain traceability across trading partners using GS1 standards.',
    `affected_lot_batch_range` STRING COMMENT 'Specification of the lot numbers, batch codes, or serial number ranges included in the recall. Critical for traceability and targeted recovery. May be expressed as ranges, lists, or patterns.',
    `affected_product_description` STRING COMMENT 'Comprehensive description of the product(s) subject to recall, including brand names, product names, sizes, formulations, and any distinguishing characteristics. Used for consumer identification.',
    `affected_sku_list` STRING COMMENT 'Comma-separated or structured list of SKU codes for all products included in the recall scope. Links to product master for detailed SKU attributes and enables inventory queries.',
    `closure_date` DATE COMMENT 'Date when the regulatory authority officially closed the recall after reviewing effectiveness checks and final reports. Nullable until regulatory closure is granted.',
    `completion_date` DATE COMMENT 'Date when all recall activities were completed, including product recovery, customer notification, and corrective actions. Nullable until recall is finished.',
    `consumer_contact_method` STRING COMMENT 'Primary method(s) used to notify consumers about the recall. Press Release: public media announcement. Direct Mail: letters to registered consumers. Email: electronic notification. Phone: direct phone contact. Social Media: notification via social platforms. Retail Signage: point-of-sale notices. Multiple Methods: combination approach. [ENUM-REF-CANDIDATE: Press Release|Direct Mail|Email|Phone|Social Media|Retail Signage|Multiple Methods — 7 candidates stripped; promote to reference product]',
    `corrective_action` STRING COMMENT 'Description of corrective and preventive actions (CAPA) implemented to address the root cause and prevent recurrence. Includes process changes, equipment modifications, supplier changes, and quality system improvements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall event record was first created in the system. Audit trail for data lineage and compliance reporting.',
    `depth_of_recall` STRING COMMENT 'Level in the distribution chain to which the recall extends. Consumer Level: recall reaches end consumers. Retail Level: recall stops at retail stores. Wholesale Level: recall stops at wholesalers/distributors. Distribution Center: recall stops at company distribution centers before reaching trade.. Valid values are `Consumer Level|Retail Level|Wholesale Level|Distribution Center`',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the recall including product cost, logistics, customer credits, disposal, regulatory fines, and brand impact. Expressed in reporting currency. Used for financial reserves and management reporting.',
    `expiration_date_range_end` DATE COMMENT 'Latest expiration or best-by date printed on recalled products. Defines the full date range for consumer identification.',
    `expiration_date_range_start` DATE COMMENT 'Earliest expiration or best-by date printed on recalled products. Helps consumers and retailers identify affected units on shelf.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated financial impact amount. Enables multi-currency recall cost tracking and consolidation.. Valid values are `^[A-Z]{3}$`',
    `health_hazard_evaluation` STRING COMMENT 'FDA or internal assessment of the health risk posed by the recalled product. Describes potential adverse health consequences and likelihood of occurrence. Used to determine recall classification.',
    `initiation_date` DATE COMMENT 'Date when the recall was officially initiated by the company. This is the business event date when the decision to recall was made and communicated internally.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall event record was last updated. Tracks data currency and supports change audit requirements.',
    `manufacturing_date_range_end` DATE COMMENT 'Latest manufacturing date of products included in the recall scope. Defines the cutoff for affected production runs.',
    `manufacturing_date_range_start` DATE COMMENT 'Earliest manufacturing date of products included in the recall scope. Used to identify affected inventory based on production timeline.',
    `notification_date` DATE COMMENT 'Date when the regulatory authority (FDA, CPSC, EPA, or other governing body) was formally notified of the recall event. Required for compliance reporting.',
    `public_announcement_date` DATE COMMENT 'Date when the recall was publicly announced through press release, FDA website posting, or other public communication channels.',
    `quantity_distributed` DECIMAL(18,2) COMMENT 'Total quantity of affected product that was distributed into the market prior to recall initiation. Expressed in base unit of measure (units, cases, kilograms). Represents the maximum potential recall scope.',
    `quantity_recalled` DECIMAL(18,2) COMMENT 'Total quantity of product subject to the recall action. May differ from quantity distributed if recall scope is narrowed to specific lots, channels, or geographies.',
    `quantity_recovered` DECIMAL(18,2) COMMENT 'Actual quantity of recalled product recovered from the market through returns, destructions, and corrections. Updated throughout recall lifecycle. Used to calculate recall effectiveness percentage.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this recall record. Ensures consistent interpretation of distributed, recalled, and recovered quantities.. Valid values are `Units|Cases|Pallets|Kilograms|Liters|Pounds`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the specific defect, contamination, safety issue, or regulatory violation that triggered the recall. Includes root cause findings and quality investigation summary.',
    `recall_classification` STRING COMMENT 'FDA or regulatory classification of the recall severity. Class I: dangerous or defective products that could cause serious health problems or death. Class II: products that might cause temporary health problem or pose slight threat of serious nature. Class III: products unlikely to cause adverse health reaction but violate FDA labeling or manufacturing regulations. Voluntary Withdrawal: firm removes product from market not required by FDA. Market Withdrawal: minor violation not subject to legal action. Stock Recovery: correction of product still in distribution chain.. Valid values are `Class I|Class II|Class III|Voluntary Withdrawal|Market Withdrawal|Stock Recovery`',
    `recall_effectiveness_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of recalled product successfully recovered from the market. Formula: (quantity_recovered / quantity_recalled) * 100. FDA expects effectiveness checks at 2, 4, and 8 weeks. High effectiveness (>95%) supports recall closure.',
    `recall_number` STRING COMMENT 'External recall identification number assigned by the company or regulatory authority for tracking and communication purposes.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `recall_scope_channel` STRING COMMENT 'Distribution channel(s) affected by the recall. Retail: products sold through retail stores. Wholesale: products in wholesale/distributor inventory. DTC: direct-to-consumer shipments. Food Service: products sold to restaurants/institutions. Healthcare: products distributed to healthcare facilities. All Channels: recall spans all distribution paths.. Valid values are `Retail|Wholesale|DTC|Food Service|Healthcare|All Channels`',
    `recall_scope_customer_segment` STRING COMMENT 'Specific customer segments, account types, or customer groups affected by the recall. Used for targeted notification and recovery when recall does not affect all customers.',
    `recall_scope_geographic` STRING COMMENT 'Geographic scope of the recall expressed as countries, states, regions, or distribution territories. Examples: USA nationwide, California only, EU markets, specific distribution centers. Supports targeted recovery and regulatory reporting by jurisdiction.',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event. Initiated: recall has been declared and communication started. In Progress: active recovery and customer notification underway. Ongoing: recall activities continuing. Completed: all recall activities finished, awaiting final regulatory closure. Terminated: recall ended by firm decision. Closed: regulatory authority has reviewed and closed the recall.. Valid values are `Initiated|In Progress|Ongoing|Completed|Terminated|Closed`',
    `recall_strategy` STRING COMMENT 'Documented strategy for executing the recall including communication plan, recovery method, depth of recall (consumer level, retail level, wholesale level), and timeline. Required by FDA 21 CFR 7.42.',
    `recall_type` STRING COMMENT 'Primary reason category for the recall event. Safety: product poses health or safety risk. Quality: product fails quality specifications. Regulatory: non-compliance with regulations. Labeling: incorrect or missing label information. Contamination: presence of foreign material or microbial contamination. Allergen: undeclared allergen present.. Valid values are `Safety|Quality|Regulatory|Labeling|Contamination|Allergen`',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority overseeing this recall. FDA: U.S. Food and Drug Administration. CPSC: Consumer Product Safety Commission. EPA: Environmental Protection Agency. EU REACH: European chemicals regulation. Health Canada: Canadian health authority. ANVISA: Brazilian health authority. TGA: Australian Therapeutic Goods Administration. MHRA: UK Medicines and Healthcare products Regulatory Agency. [ENUM-REF-CANDIDATE: FDA|CPSC|EPA|EU REACH|Health Canada|ANVISA|TGA|MHRA|Other — 9 candidates stripped; promote to reference product]',
    `regulatory_case_number` STRING COMMENT 'Official case or reference number assigned by the regulatory authority for tracking this recall in their system. Used for all regulatory correspondence and reporting.',
    `root_cause_analysis_summary` STRING COMMENT 'Summary of the root cause investigation findings including failure mode, contributing factors, and systemic issues identified. Supports CAPA and regulatory reporting.',
    CONSTRAINT pk_recall_event PRIMARY KEY(`recall_event_id`)
) COMMENT 'Master record for product recall and withdrawal events triggered by safety, quality, or regulatory findings. Captures recall classification (Class I/II/III FDA, voluntary withdrawal), affected SKUs, affected lot/batch ranges, recall scope (geographic, channel, customer), recall initiation date, regulatory notification date (FDA/CPSC), quantity recalled, quantity recovered, recall status, and financial impact estimate. Supports lot_batch traceability queries and regulatory reporting obligations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` (
    `inventory_vmi_agreement_id` BIGINT COMMENT 'Unique identifier for the VMI agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the Consumer Goods employee responsible for managing this VMI agreement.',
    `retail_store_id` BIGINT COMMENT 'Identifier of the specific partner warehouse, distribution center, or retail location covered by this VMI agreement.',
    `sku_id` BIGINT COMMENT 'add column sku_id (BIGINT) with FK to product.sku.sku_id - VMI agreements must specify which products are under vendor-managed inventory',
    `supplier_id` BIGINT COMMENT 'add column supplier_id (BIGINT) with FK to procurement.supplier.supplier_id - VMI agreements require a supplier who manages the inventory',
    `tertiary_inventory_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this VMI agreement record.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail or distributor partner participating in the VMI arrangement.',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the VMI agreement for business reference.',
    `agreement_number` STRING COMMENT 'Business-facing unique identifier or contract number for the VMI agreement.',
    `agreement_type` STRING COMMENT 'Classification of the VMI agreement based on scope and strategic importance.. Valid values are `standard|custom|pilot|strategic|promotional|seasonal`',
    `auto_replenishment_enabled` BOOLEAN COMMENT 'Indicates whether automated replenishment orders are triggered based on inventory levels without manual approval.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are generated for inventory replenished under this VMI agreement.. Valid values are `weekly|bi_weekly|monthly|quarterly|on_shipment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VMI agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial transactions under this VMI agreement.. Valid values are `^[A-Z]{3}$`',
    `data_sharing_method` STRING COMMENT 'Technical method or platform used to exchange inventory visibility and replenishment data between Consumer Goods and the VMI partner.. Valid values are `edi|api|portal|tradeedge|manual|sftp`',
    `edi_transaction_set` STRING COMMENT 'Specific EDI transaction set codes used for VMI data exchange (e.g., 846 Inventory Inquiry/Advice, 852 Product Activity Data).',
    `effective_end_date` DATE COMMENT 'Date when the VMI agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the VMI agreement becomes active and binding.',
    `forecast_sharing_enabled` BOOLEAN COMMENT 'Indicates whether demand forecast data is shared between Consumer Goods and the VMI partner for collaborative planning.',
    `inventory_ownership` STRING COMMENT 'Defines who owns the inventory at the partner location until point of sale or consumption.. Valid values are `consignment|owned_by_partner|owned_by_supplier|shared`',
    `inventory_vmi_agreement_status` STRING COMMENT 'Current lifecycle status of the VMI agreement.. Valid values are `draft|active|suspended|terminated|expired|pending_approval`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VMI agreement record was last updated.',
    `lot_traceability_required` BOOLEAN COMMENT 'Indicates whether lot or batch traceability is mandatory for inventory managed under this VMI agreement for recall readiness.',
    `max_stock_level` DECIMAL(18,2) COMMENT 'Maximum inventory quantity threshold at partner location to avoid overstocking.',
    `min_stock_level` DECIMAL(18,2) COMMENT 'Minimum inventory quantity threshold at partner location that triggers replenishment.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to the VMI agreement.',
    `oos_penalty_clause` STRING COMMENT 'Description of financial or operational penalties applied if out-of-stock events occur at partner location.',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for deliveries that meet both on-time and in-full criteria as defined in the VMI agreement.',
    `payment_terms` STRING COMMENT 'Agreed payment terms for invoices related to VMI replenishment (e.g., Net 30, Net 60, 2/10 Net 30).',
    `pos_data_sharing_enabled` BOOLEAN COMMENT 'Indicates whether point-of-sale transaction data is shared by the partner to enable demand sensing and replenishment optimization.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the VMI partner for operational communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact at the VMI partner responsible for this agreement.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact at the VMI partner for urgent escalations.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal notice must be provided to continue the VMI agreement.',
    `replenishment_frequency` STRING COMMENT 'Scheduled frequency at which inventory replenishment occurs under this VMI agreement.. Valid values are `daily|weekly|bi_weekly|monthly|on_demand|continuous`',
    `replenishment_lead_time_days` STRING COMMENT 'Number of days required from replenishment trigger to delivery at partner location.',
    `rotation_rule` STRING COMMENT 'Inventory rotation policy applied at partner location (FEFO = First Expired First Out, FIFO = First In First Out).. Valid values are `fefo|fifo|lifo|expiry_date`',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Buffer inventory quantity maintained to mitigate stockout risk due to demand variability or supply disruption.',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'Committed service level percentage for on-time in-full (OTIF) delivery under this VMI agreement.',
    `stock_level_uom` STRING COMMENT 'Unit of measure for all stock level thresholds (e.g., cases, pallets, eaches, kilograms).',
    `target_stock_level` DECIMAL(18,2) COMMENT 'Optimal inventory quantity to maintain at partner location under normal conditions.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to terminate the VMI agreement by either party.',
    CONSTRAINT pk_inventory_vmi_agreement PRIMARY KEY(`inventory_vmi_agreement_id`)
) COMMENT 'Master record defining Vendor Managed Inventory (VMI) agreements between Consumer Goods and its retail/distributor customers. Captures VMI partner (retailer/distributor), covered SKUs, min/max stock levels at partner location, replenishment frequency, data sharing method (EDI, TradeEdge), service level commitment, VMI start date, VMI end date, and agreement status. Distinct from replenishment_order (the execution) — this is the governing policy for VMI-managed inventory relationships.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` (
    `stock_valuation_id` BIGINT COMMENT 'Unique identifier for the stock valuation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Valuation reports allocate inventory value to cost centers for internal cost control.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Valuation entries are posted to GL accounts; linking enables automated posting and audit.',
    `inventory_storage_location_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, or storage location where the inventory is held.',
    `material_ledger_posting_id` BIGINT COMMENT 'The unique identifier of the corresponding material ledger posting in the financial system (SAP MM-FI integration reference).',
    `product_lca_id` BIGINT COMMENT 'Foreign key linking to sustainability.product_lca. Business justification: Enables sustainability‑aware valuation; incorporates LCA carbon footprint data into stock valuation calculations for ESG reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑center based inventory valuation supports profitability analysis per business unit.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU being valued in this record.',
    `actual_unit_cost` DECIMAL(18,2) COMMENT 'The actual cost per unit used for this valuation snapshot, determined by the selected valuation method.',
    `batch_number` STRING COMMENT 'The production batch number for this inventory, used for quality control and traceability in manufacturing.',
    `cogs_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of inventory value allocated to COGS during the valuation period, representing goods sold or consumed.',
    `company_code` STRING COMMENT 'The legal entity company code that owns this inventory for financial consolidation and statutory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this stock valuation record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the valuation amounts are expressed (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `days_inventory_outstanding` DECIMAL(18,2) COMMENT 'The average number of days inventory is held before being sold, calculated as (inventory value / COGS) × days in period.',
    `expiration_date` DATE COMMENT 'The date after which the product should not be sold or used, critical for FEFO (First Expired First Out) rotation rules.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this valuation record belongs (1-12).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this valuation record belongs, used for financial reporting and period-based analysis.',
    `inventory_turnover_ratio` DECIMAL(18,2) COMMENT 'The number of times inventory is sold and replaced over the period, calculated as COGS divided by average inventory value.',
    `last_goods_issue_date` DATE COMMENT 'The date of the most recent goods issue or consumption transaction for this SKU-location combination.',
    `last_goods_receipt_date` DATE COMMENT 'The date of the most recent goods receipt transaction for this SKU-location combination, used for aging analysis.',
    `lot_number` STRING COMMENT 'The manufacturing lot or batch number associated with this inventory position, critical for traceability and recall readiness.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this stock valuation record was last modified or updated.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'The continuously recalculated average cost per unit based on all goods receipts and invoice receipts, used for moving average valuation method.',
    `net_realizable_value` DECIMAL(18,2) COMMENT 'The estimated selling price in the ordinary course of business less the estimated costs of completion and sale. Used to determine if write-down is required.',
    `obsolete_flag` BOOLEAN COMMENT 'Indicates whether this inventory has been classified as obsolete and should be written down or disposed of.',
    `plant_code` STRING COMMENT 'The manufacturing plant or distribution center code where the inventory is physically located.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The physical quantity of inventory units available at the location on the valuation date. Measured in base unit of measure.',
    `revaluation_amount` DECIMAL(18,2) COMMENT 'The adjustment amount applied to inventory value due to cost changes, currency revaluation, or accounting policy changes.',
    `safety_stock_value` DECIMAL(18,2) COMMENT 'The monetary value of safety stock (buffer inventory) maintained to prevent stockouts, calculated using safety stock quantity and unit cost.',
    `slow_moving_flag` BOOLEAN COMMENT 'Indicates whether this inventory is classified as slow-moving based on turnover thresholds, triggering potential write-down review.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The predetermined cost per unit set by the cost accounting team, used for standard costing valuation method.',
    `total_stock_value` DECIMAL(18,2) COMMENT 'The total monetary value of inventory at this location, calculated as quantity on hand multiplied by actual unit cost.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure for the quantity (e.g., EA for each, KG for kilogram, L for liter).',
    `valuation_class` STRING COMMENT 'The accounting classification code used to group materials for financial reporting and general ledger account determination.',
    `valuation_date` DATE COMMENT 'The date on which this inventory valuation snapshot was taken. Typically aligned with financial period close dates.',
    `valuation_method` STRING COMMENT 'The accounting method used to calculate inventory value: standard cost, moving average price, FIFO (First In First Out), weighted average, or LIFO (Last In First Out).. Valid values are `standard_cost|moving_average|fifo|weighted_average|lifo`',
    `valuation_status` STRING COMMENT 'The current status of this valuation record in the financial close process: preliminary, final, adjusted, or closed.. Valid values are `preliminary|final|adjusted|closed`',
    `valuation_type` STRING COMMENT 'The split valuation type used when a material is valuated separately (e.g., own production vs. external procurement, domestic vs. import).',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between standard cost and actual cost, representing price or quantity variances that impact inventory value.',
    `write_down_amount` DECIMAL(18,2) COMMENT 'The monetary amount by which inventory value has been reduced due to obsolescence, damage, or net realizable value adjustments.',
    `write_down_reason` STRING COMMENT 'The business reason for the inventory write-down: obsolescence, physical damage, expiration, market value decline, quality issue, or other.. Valid values are `obsolescence|damage|expiration|market_decline|quality_issue|other`',
    CONSTRAINT pk_stock_valuation PRIMARY KEY(`stock_valuation_id`)
) COMMENT 'Transactional record of inventory valuation snapshots for each SKU-location combination, capturing standard cost, moving average price, total stock value, COGS allocation, inventory write-down amounts, and valuation method (standard cost, FIFO, weighted average). Aligned with material ledger postings in the financial system. Supports COGS reporting, days-inventory-outstanding calculation, and financial close processes. Distinct from stock_position (quantity) — this captures the monetary value dimension of inventory.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` (
    `stock_adjustment_id` BIGINT COMMENT 'Primary key for stock_adjustment',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Adjustment postings must be charged to the correct cost center for variance analysis and budgeting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each inventory adjustment posts to a GL account; linking ensures accurate journal entry generation.',
    `inventory_storage_location_id` BIGINT COMMENT 'FK to inventory.inventory_storage_location',
    `employee_id` BIGINT COMMENT 'User identifier of the person who initiated or created the adjustment transaction in the system.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Financial adjustments are allocated to profit centers to reflect impact on segment P&L.',
    `reversed_adjustment_stock_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment transaction that this record reverses, establishing the correction chain for audit purposes.',
    `sku_id` BIGINT COMMENT 'Identifier of the product or Stock Keeping Unit (SKU) being adjusted.',
    `tertiary_stock_posted_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who posted the adjustment to the inventory and financial ledgers.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the inventory adjustment occurred.',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'Net quantity change applied to inventory (positive for additions, negative for reductions), measured in the base unit of measure.',
    `adjusted_value` DECIMAL(18,2) COMMENT 'Total financial value of the inventory adjustment calculated as adjusted quantity multiplied by unit cost, impacting Cost of Goods Sold (COGS) and inventory valuation.',
    `adjustment_date` DATE COMMENT 'Business date when the inventory adjustment was physically identified or when the correction event occurred, distinct from system posting date.',
    `adjustment_number` STRING COMMENT 'Business-facing unique adjustment document number used for tracking and reference in operational systems and audit trails.. Valid values are `^ADJ-[0-9]{10}$`',
    `adjustment_reason_code` STRING COMMENT 'Standardized code representing the specific reason for the inventory adjustment (e.g., SHRINK, DAMAGE, SAMPLE, PROMO, RECALL, OBSOLETE, RECOUNT).. Valid values are `^[A-Z0-9]{2,10}$`',
    `adjustment_reason_description` STRING COMMENT 'Detailed textual explanation of why the inventory adjustment was necessary, providing business context beyond the reason code.',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment transaction indicating its approval and posting state in the inventory ledger.. Valid values are `draft|pending_approval|approved|posted|rejected|cancelled`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the adjustment transaction was created or recorded in the system.',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment transaction indicating the nature of the inventory correction (physical count variance, shrinkage, damage, expiry, system reconciliation, theft).. Valid values are `physical_count|shrinkage|damage|expiry|system_reconciliation|theft`',
    `approval_date` DATE COMMENT 'Date when the adjustment was formally approved by authorized personnel, required for audit trail and compliance.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number of the inventory being adjusted, critical for traceability and recall readiness per GMP requirements.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the adjustment record was first created in the database, used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the adjusted value and unit cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Product expiration or best-before date for the adjusted inventory batch, critical for First Expired First Out (FEFO) rotation and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the adjustment record was last updated, tracking the most recent change for audit and version control.',
    `movement_type` STRING COMMENT 'SAP movement type code classifying the inventory transaction for goods movement and financial posting (e.g., 701 for goods issue, 702 for goods receipt).. Valid values are `^[0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or contextual information about the adjustment that may be relevant for audit or operational review.',
    `physical_count_quantity` DECIMAL(18,2) COMMENT 'Actual physical quantity counted during inventory verification, used to calculate the adjustment variance for cycle counts and physical inventories.',
    `plant_code` STRING COMMENT 'SAP plant code representing the manufacturing or distribution facility where the inventory adjustment occurred.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'Financial accounting date when the adjustment was posted to the inventory ledger and general ledger, used for period closing and financial reporting.',
    `reference_document_number` STRING COMMENT 'External reference document number supporting the adjustment (e.g., physical inventory document, cycle count sheet, damage report, quality inspection report).. Valid values are `^[A-Z0-9-]{6,20}$`',
    `reference_document_type` STRING COMMENT 'Type of supporting document referenced for the adjustment, providing audit trail and justification context. [ENUM-REF-CANDIDATE: physical_inventory|cycle_count|damage_report|quality_inspection|sampling_request|promotional_giveaway|recall_notice — 7 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this adjustment is a reversal of a previous adjustment transaction, used for error correction and audit trails.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items requiring individual unit tracking and traceability.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `special_stock_indicator` STRING COMMENT 'Code indicating special stock categories such as consignment, vendor-managed inventory (VMI), or customer-owned stock requiring separate tracking.. Valid values are `^[A-Z]{1,2}$`',
    `stock_type` STRING COMMENT 'Classification of inventory stock status indicating availability for use (unrestricted, quality inspection, blocked, restricted, returns).. Valid values are `unrestricted|quality_inspection|blocked|restricted|returns`',
    `system_quantity_after` DECIMAL(18,2) COMMENT 'Resulting inventory quantity in the system after the adjustment has been posted, representing the corrected stock balance.',
    `system_quantity_before` DECIMAL(18,2) COMMENT 'Inventory quantity recorded in the system before the adjustment was applied, used for variance analysis and audit trails.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard or moving average cost per unit of the inventory item at the time of adjustment, used for inventory valuation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the adjusted quantity (e.g., EA for each, CS for case, KG for kilogram, LT for liter).. Valid values are `^[A-Z]{2,6}$`',
    CONSTRAINT pk_stock_adjustment PRIMARY KEY(`stock_adjustment_id`)
) COMMENT 'Transactional record of manual and system-generated inventory adjustments that correct stock balances outside of normal goods movement flows. Captures adjustment reason (shrinkage, damage, system reconciliation, theft, sampling, promotional giveaway), adjusted quantity, adjusted value, adjustment date, approver, and supporting reference document. Distinct from stock_movement (which covers standard GR/GI flows) — adjustments represent exception corrections to the inventory ledger.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` (
    `reservation_id` BIGINT COMMENT 'Primary key for reservation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Reservation creation is performed by an employee; capturing the employee ID supports auditability and performance metrics.',
    `inventory_storage_location_id` BIGINT COMMENT 'Reference to the warehouse storage location where the reserved inventory is physically held.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the distribution center, warehouse, or manufacturing facility holding the reserved inventory.',
    `order_id` BIGINT COMMENT 'Reference to the sales order document that triggered this reservation. Populated when reservation_type is sales_order.',
    `production_order_id` BIGINT COMMENT 'Reference to the production order consuming this reserved material. Populated when reservation_type is production_order.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the trade promotion or promotional campaign for which inventory is reserved. Populated when reservation_type is promotional.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product or Stock Keeping Unit (SKU) for which inventory is reserved.',
    `trade_account_id` BIGINT COMMENT 'Reference to the customer for whom inventory is reserved, typically linked through the sales order.',
    `allocation_rule` STRING COMMENT 'Inventory allocation rule applied to this reservation: First Expired First Out (FEFO), First In First Out (FIFO), Last In First Out (LIFO), specific lot assignment, or customer priority-based.. Valid values are `fefo|fifo|lifo|specific_lot|customer_priority`',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the reserved inventory for production traceability and quality control.. Valid values are `^BATCH-[A-Z0-9]{8,12}$`',
    `blocked_date` DATE COMMENT 'Date when the reservation was placed on hold or blocked from fulfillment.',
    `blocked_flag` BOOLEAN COMMENT 'Indicates whether the reservation is temporarily blocked from fulfillment due to quality hold, credit hold, or other business constraints.',
    `blocked_reason` STRING COMMENT 'Explanation for why the reservation is blocked, such as quality inspection pending, credit limit exceeded, or regulatory hold.',
    `committed_to_customer_flag` BOOLEAN COMMENT 'Indicates whether this reservation represents a firm commitment to a customer with contractual On Time In Full (OTIF) obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation record was first created in the system.',
    `expiry_date` DATE COMMENT 'Date after which the reservation automatically expires if not fulfilled, releasing the reserved stock back to available inventory.',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'Quantity of the reservation that has been fulfilled through goods issue or consumption. Measured in the products base unit of measure.',
    `fulfillment_method` STRING COMMENT 'Planned method for fulfilling this reservation: warehouse pick and pack, Direct Store Delivery (DSD), cross-dock transfer, or drop-ship from supplier.. Valid values are `warehouse_pick|direct_store_delivery|cross_dock|drop_ship`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user or system process that last updated the reservation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation record was last modified or updated.',
    `lot_number` STRING COMMENT 'Specific lot or batch number reserved for First Expired First Out (FEFO) compliance and traceability. Critical for recall readiness and expiry management.. Valid values are `^LOT-[A-Z0-9]{8,12}$`',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to the reservation, such as handling requirements, customer requests, or allocation exceptions.',
    `priority_level` STRING COMMENT 'Business priority assigned to this reservation for allocation decisions when inventory is constrained. Critical reservations are protected first.. Valid values are `critical|high|medium|low`',
    `required_delivery_date` DATE COMMENT 'Target date by which the reserved inventory must be available for fulfillment or consumption to meet downstream commitments.',
    `reservation_date` DATE COMMENT 'Date when the inventory reservation was created and stock was earmarked for this demand.',
    `reservation_number` STRING COMMENT 'Business-facing unique reservation number used for tracking and reference across systems and documents.. Valid values are `^RES-[0-9]{10}$`',
    `reservation_status` STRING COMMENT 'Current lifecycle status of the reservation indicating whether it is active, partially fulfilled, fully fulfilled, cancelled, or expired.. Valid values are `active|partially_fulfilled|fulfilled|cancelled|expired`',
    `reservation_type` STRING COMMENT 'Classification of the reservation purpose: sales order fulfillment, production consumption, promotional commitment, intercompany transfer, quality hold, or safety stock allocation.. Valid values are `sales_order|production_order|promotional|intercompany_transfer|quality_hold|safety_stock`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory units reserved and earmarked for this specific demand. Measured in the products base unit of measure.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items reserved at the individual unit level.. Valid values are `^SN-[A-Z0-9]{10,15}$`',
    `source_document` STRING COMMENT 'Reference number or identifier of the originating business document that triggered the reservation (order number, forecast ID, promotion code).',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the reserved quantity (e.g., EA for each, CS for case, KG for kilogram).. Valid values are `^[A-Z]{2,3}$`',
    `vmi_replenishment_flag` BOOLEAN COMMENT 'Indicates whether this reservation is part of a Vendor Managed Inventory (VMI) replenishment program where the supplier manages customer inventory levels.',
    CONSTRAINT pk_reservation PRIMARY KEY(`reservation_id`)
) COMMENT 'Transactional record of inventory reservations that earmark specific stock quantities for confirmed sales orders, production orders, promotional commitments, or intercompany transfers. Captures reservation type (sales order, production, promotional, intercompany), reserved quantity, reserved lot/batch (if FEFO-specific), reservation date, expiry date of reservation, fulfillment status, and consuming document reference. Prevents double-allocation of available stock across competing demand streams.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Primary key for warehouse',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_warehouse_id` BIGINT COMMENT 'Self-referencing FK on warehouse (parent_warehouse_id)',
    `address_line1` STRING COMMENT 'Primary street address of the warehouse.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_sqft` DECIMAL(18,2) COMMENT 'Total usable storage capacity measured in square feet.',
    `city` STRING COMMENT 'City where the warehouse is located.',
    `climate_zone` STRING COMMENT 'Designated climate zone for the warehouse.',
    `closing_date` DATE COMMENT 'Date the warehouse ceased operations (null if still active).',
    `warehouse_code` STRING COMMENT 'External business code used to reference the warehouse in operational systems.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of compliance certifications held by the warehouse.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the warehouse location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse record was first created in the system.',
    `dock_count` STRING COMMENT 'Total number of loading docks available.',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this warehouse is the primary distribution hub for the company.',
    `last_inspection_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent safety or compliance inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the warehouse.',
    `loading_bays` STRING COMMENT 'Number of dedicated loading bays for inbound/outbound shipments.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the warehouse.',
    `warehouse_name` STRING COMMENT 'Human‑readable name of the warehouse.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `opening_date` DATE COMMENT 'Date the warehouse began operations.',
    `operational_hours` STRING COMMENT 'Standard operating hours of the warehouse.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the warehouse address.',
    `region` STRING COMMENT 'Broad geographic region (e.g., North America, EMEA) where the warehouse resides.',
    `safety_stock_level` STRING COMMENT 'Target safety stock quantity maintained at the warehouse.',
    `security_level` STRING COMMENT 'Security classification of the warehouse.',
    `state` STRING COMMENT 'State or province of the warehouse location.',
    `warehouse_status` STRING COMMENT 'Current lifecycle status of the warehouse.',
    `temperature_control` BOOLEAN COMMENT 'Indicates whether the warehouse has temperature‑controlled storage.',
    `warehouse_type` STRING COMMENT 'Classification of the warehouse based on its primary function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warehouse record.',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master reference table for warehouse. Referenced by warehouse_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_primary_stock_inventory_storage_location_id` FOREIGN KEY (`primary_stock_inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_reversed_movement_stock_movement_id` FOREIGN KEY (`reversed_movement_stock_movement_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_primary_inventory_storage_location_id` FOREIGN KEY (`primary_inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_original_count_inventory_cycle_count_id` FOREIGN KEY (`original_count_inventory_cycle_count_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count`(`inventory_cycle_count_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ADD CONSTRAINT `fk_inventory_safety_stock_policy_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_previous_oos_event_id` FOREIGN KEY (`previous_oos_event_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`oos_event`(`oos_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`recall_event`(`recall_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_reversed_adjustment_stock_adjustment_id` FOREIGN KEY (`reversed_adjustment_stock_adjustment_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment`(`stock_adjustment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_parent_warehouse_id` FOREIGN KEY (`parent_warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `product_lca_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lca Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Vendor Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `available_to_promise_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `blocked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `days_inventory_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Inventory Outstanding (DIO)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `last_goods_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Movement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `obsolete_flag` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `oos_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Risk Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `quality_inspection_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `recall_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining Days');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `slow_moving_flag` SET TAGS ('dbx_business_glossary_term' = 'Slow Moving Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `stock_rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Stock Rotation Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `stock_rotation_rule` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_disposal|transferred|consumed');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `unrestricted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo|weighted_average');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ALTER COLUMN `vmi_replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Replenishment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Dossier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'active|depleted|expired|recalled|destroyed|transferred');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `gmp_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `gmp_status` SET TAGS ('dbx_value_regex' = 'certified|compliant|non_compliant|pending_review|exempt');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `production_order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `quantity_produced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Produced');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_value_regex' = 'released|quarantined|rejected|pending_inspection|conditionally_released');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `storage_condition_requirement` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Requirement');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `storage_condition_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_room_temperature|hazmat');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Storage Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Location Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `third_party_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bin Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Capacity in Pallet Positions');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume in Cubic Meters (m³)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Capacity Weight in Kilograms (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Location Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `last_inventory_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude Coordinate');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `inventory_storage_location_level` SET TAGS ('dbx_business_glossary_term' = 'Level Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `inventory_storage_location_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Operational Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|quarantine|decommissioned');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bulk|pick|reserve|quarantine|returns|staging');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude Coordinate');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `mixed_sku_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `picking_priority` SET TAGS ('dbx_business_glossary_term' = 'Picking Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `replenishment_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Threshold Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_value_regex' = 'FEFO|FIFO|LIFO|MANUAL');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|restricted|high_value|controlled_substance');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Zone Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `primary_stock_inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `reversed_movement_stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Movement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_category` SET TAGS ('dbx_business_glossary_term' = 'Movement Category');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_category` SET TAGS ('dbx_value_regex' = 'goods_receipt|goods_issue|stock_transfer|return|adjustment|write_off');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_notes` SET TAGS ('dbx_business_glossary_term' = 'Movement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_line` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Line Item');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted|in_transit');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Movement Value');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `inventory_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Replenishment Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `primary_inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `oos_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Prevention Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_value_regex' = 'vmi_auto|drp_planned|manual_trigger|safety_stock|emergency|seasonal');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_value_regex' = 'fefo|fifo|lifo');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `safety_stock_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Trigger Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cycle Count ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `original_count_inventory_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Original Count ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `primary_inventory_counter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `primary_inventory_counter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `primary_inventory_counter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `adjustment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'full_physical|abc_cycle|perpetual|spot_check|blind_count');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|confirmed|posted|cancelled|recount_required');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_zone` SET TAGS ('dbx_business_glossary_term' = 'Count Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_value_at_count` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value at Count');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_value_at_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'shrinkage|damage|misplacement|system_error|receiving_error|picking_error');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Policy ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `average_daily_demand` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'statistical|time_based|manual|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `carrying_cost_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Inventory Carrying Cost Rate (%)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `carrying_cost_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `demand_standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Demand Standard Deviation');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `planning_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Policy Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `policy_notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'fixed|dynamic|seasonal|promotional|vmi|consignment');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `replenishment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `replenishment_strategy` SET TAGS ('dbx_value_regex' = 'reorder_point|periodic_review|min_max|kanban|drp|vmi');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Policy Review Frequency (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|expired|draft');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_time_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target (%)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `system_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'System Generated Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `intransit_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Shipment Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Node Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `primary_intransit_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Node Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|express|overnight|same_day|economy');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `destination_node_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Node Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `destination_node_type` SET TAGS ('dbx_value_regex' = 'distribution_center|warehouse|store|cross_dock|customer');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'delay|damage|shortage|temperature_excursion|routing_error|lost');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = '^[1-9](.d)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `intransit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `origin_node_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Node Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `origin_node_type` SET TAGS ('dbx_value_regex' = 'supplier|manufacturing_plant|distribution_center|warehouse|store|cross_dock');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `required_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Required Maximum Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `required_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Required Minimum Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `shipment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `shipment_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `shipment_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Shipment Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `shipment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `transit_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Days');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal|parcel');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `previous_oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Out-of-Stock (OOS) Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `actual_demand_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Demand Units');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|ecommerce|dsd|dtc');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `demand_forecast_units` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Units');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'pos_system|wms|demand_sensing|manual_report|retail_execution_app|edi_feed');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_sales_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Sales Value');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_sales_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Units');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|resolved|under_investigation|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `forecast_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `inventory_on_hand_at_oos` SET TAGS ('dbx_business_glossary_term' = 'Inventory On Hand at Out-of-Stock (OOS)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `next_scheduled_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Replenishment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `oos_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Duration in Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `oos_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `oos_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `oos_type` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `oos_type` SET TAGS ('dbx_value_regex' = 'warehouse_stockout|shelf_stockout|phantom_inventory|system_mismatch');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `osa_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Shelf Availability (OSA) Actual Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `osa_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Shelf Availability (OSA) Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'emergency_replenishment|transfer_from_alternate_location|expedited_shipment|customer_backorder|no_action_taken|substitution_offered');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'demand_spike|replenishment_failure|forecast_miss|upstream_stockout|logistics_delay|system_error');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `stock_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Hold Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'release|rework|destroy|return_to_supplier|downgrade|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `expected_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Hold Duration Days');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_value_regex' = '^HLD-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Hold Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Hold Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|pending_review|released|expired|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'quality_control|regulatory_recall|commercial_dispute|damage|quarantine|investigation');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Value Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `hold_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `is_recall_related` SET TAGS ('dbx_business_glossary_term' = 'Is Recall Related');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `affected_gtin_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Global Trade Item Number (GTIN) List');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `affected_lot_batch_range` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot/Batch Range');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `affected_product_description` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Description');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `affected_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Stock Keeping Unit (SKU) List');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `consumer_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Consumer Contact Method');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `depth_of_recall` SET TAGS ('dbx_business_glossary_term' = 'Depth of Recall');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `depth_of_recall` SET TAGS ('dbx_value_regex' = 'Consumer Level|Retail Level|Wholesale Level|Distribution Center');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `expiration_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date Range End');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `expiration_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date Range Start');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Evaluation');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `manufacturing_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date Range End');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `manufacturing_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date Range Start');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `public_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Public Announcement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `quantity_distributed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Distributed');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `quantity_recalled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recalled');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `quantity_recovered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recovered');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'Units|Cases|Pallets|Kilograms|Liters|Pounds');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Voluntary Withdrawal|Market Withdrawal|Stock Recovery');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_effectiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recall Effectiveness Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_scope_channel` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_scope_channel` SET TAGS ('dbx_value_regex' = 'Retail|Wholesale|DTC|Food Service|Healthcare|All Channels');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_scope_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope Customer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_scope_geographic` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope Geographic');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'Initiated|In Progress|Ongoing|Completed|Terminated|Closed');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_strategy` SET TAGS ('dbx_business_glossary_term' = 'Recall Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'Safety|Quality|Regulatory|Labeling|Contamination|Allergen');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `root_cause_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `inventory_vmi_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Vendor Managed Inventory (VMI) Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `tertiary_inventory_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `tertiary_inventory_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `tertiary_inventory_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Partner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard|custom|pilot|strategic|promotional|seasonal');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `auto_replenishment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Replenishment Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|monthly|quarterly|on_shipment');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `data_sharing_method` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Method');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `data_sharing_method` SET TAGS ('dbx_value_regex' = 'edi|api|portal|tradeedge|manual|sftp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `forecast_sharing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Forecast Sharing Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `inventory_ownership` SET TAGS ('dbx_business_glossary_term' = 'Inventory Ownership Model');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `inventory_ownership` SET TAGS ('dbx_value_regex' = 'consignment|owned_by_partner|owned_by_supplier|shared');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `inventory_vmi_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `inventory_vmi_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `lot_traceability_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `oos_penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Penalty Clause');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `pos_data_sharing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Data Sharing Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi_weekly|monthly|on_demand|continuous');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_value_regex' = 'fefo|fifo|lifo|expiry_date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `stock_level_uom` SET TAGS ('dbx_business_glossary_term' = 'Stock Level Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `target_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Target Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `stock_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Valuation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `material_ledger_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Material Ledger Posting ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `product_lca_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lca Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `actual_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `cogs_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Allocation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `days_inventory_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Inventory Outstanding (DIO)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_turnover_ratio` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turnover Ratio');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `net_realizable_value` SET TAGS ('dbx_business_glossary_term' = 'Net Realizable Value (NRV)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `obsolete_flag` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity on Hand');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `safety_stock_value` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Value');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `slow_moving_flag` SET TAGS ('dbx_business_glossary_term' = 'Slow Moving Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Value');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'standard_cost|moving_average|fifo|weighted_average|lifo');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|adjusted|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Inventory Write-Down Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `write_down_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Down Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ALTER COLUMN `write_down_reason` SET TAGS ('dbx_value_regex' = 'obsolescence|damage|expiration|market_decline|quality_issue|other');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Adjustment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Storage Location Id');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `reversed_adjustment_stock_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Adjustment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `tertiary_stock_posted_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `tertiary_stock_posted_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `tertiary_stock_posted_by_user_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjusted_value` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Value');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjusted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'physical_count|shrinkage|damage|expiry|system_reconciliation|theft');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `physical_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted|returns');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `system_quantity_after` SET TAGS ('dbx_business_glossary_term' = 'System Quantity After Adjustment');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `system_quantity_before` SET TAGS ('dbx_business_glossary_term' = 'System Quantity Before Adjustment');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `allocation_rule` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `allocation_rule` SET TAGS ('dbx_value_regex' = 'fefo|fifo|lifo|specific_lot|customer_priority');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^BATCH-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Blocked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `blocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `committed_to_customer_flag` SET TAGS ('dbx_business_glossary_term' = 'Committed to Customer Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'warehouse_pick|direct_store_delivery|cross_dock|drop_ship');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^LOT-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reservation Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Reservation Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_value_regex' = '^RES-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'active|partially_fulfilled|fulfilled|cancelled|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_business_glossary_term' = 'Reservation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_value_regex' = 'sales_order|production_order|promotional|intercompany_transfer|quality_hold|safety_stock');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^SN-[A-Z0-9]{10,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `source_document` SET TAGS ('dbx_business_glossary_term' = 'Reservation Source Document');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `vmi_replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Replenishment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `parent_warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Warehouse Id');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `parent_warehouse_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Capacity Sqft');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Climate Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `dock_count` SET TAGS ('dbx_business_glossary_term' = 'Dock Count');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `last_inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `loading_bays` SET TAGS ('dbx_business_glossary_term' = 'Loading Bays');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `temperature_control` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
