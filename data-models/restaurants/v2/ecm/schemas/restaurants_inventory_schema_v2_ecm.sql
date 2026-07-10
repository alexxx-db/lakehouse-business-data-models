-- Schema for Domain: inventory | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`inventory` COMMENT 'Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` (
    `stock_item_id` BIGINT COMMENT 'Unique identifier for the stock item. Primary key for the stock_item product.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Aligns each inventory item with its procurement category for spend analysis and budgeting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allows allocation of inventory holding costs to specific cost centers for budgeting and variance analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for financial reporting of inventory valuation and COGS per item, enabling accurate GL posting of stock costs.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: REQUIRED: Ingredient Inventory Valuation Report needs each stock item linked to its ingredient master for nutrition, allergen, and compliance tracking.',
    `item_specification_id` BIGINT COMMENT 'Foreign key linking to procurement.item_specification. Business justification: Required for Item Specification compliance reports linking each stock item to its defined specification for FDA/USDA audits.',
    `supplier_id` BIGINT COMMENT 'Identifier of the preferred supplier for this stock item. Links to vendor master data in procurement system.',
    `stock_procurement_supplier_id` BIGINT COMMENT 'Identifier of the preferred supplier for this stock item. Links to vendor master data in procurement system.',
    `allergen_eggs` BOOLEAN COMMENT 'Indicates whether the item contains or may contain eggs. Required for menu labeling and allergen disclosure.',
    `allergen_fish` BOOLEAN COMMENT 'Indicates whether the item contains or may contain fish. Required for menu labeling and allergen disclosure.',
    `allergen_milk` BOOLEAN COMMENT 'Indicates whether the item contains or may contain milk or dairy derivatives. Required for menu labeling and allergen disclosure.',
    `allergen_peanuts` BOOLEAN COMMENT 'Indicates whether the item contains or may contain peanuts. Required for menu labeling and allergen disclosure.',
    `allergen_shellfish` BOOLEAN COMMENT 'Indicates whether the item contains or may contain crustacean shellfish. Required for menu labeling and allergen disclosure.',
    `allergen_soybeans` BOOLEAN COMMENT 'Indicates whether the item contains or may contain soybeans. Required for menu labeling and allergen disclosure.',
    `allergen_tree_nuts` BOOLEAN COMMENT 'Indicates whether the item contains or may contain tree nuts. Required for menu labeling and allergen disclosure.',
    `allergen_wheat` BOOLEAN COMMENT 'Indicates whether the item contains or may contain wheat. Required for menu labeling and allergen disclosure.',
    `case_pack_quantity` STRING COMMENT 'Number of individual units contained in one case. Used for ordering and receiving conversions.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the standard cost (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the stock item record was first created in the inventory management system.',
    `discontinuation_date` DATE COMMENT 'Date when the item was or will be discontinued from inventory. Used for phase-out planning and historical analysis.',
    `gtin` STRING COMMENT 'International product identifier used for supply chain tracking and barcode scanning. May be UPC, EAN, or other GS1 format.. Valid values are `^[0-9]{8,14}$`',
    `haccp_max_temp_f` DECIMAL(18,2) COMMENT 'Maximum safe storage temperature in Fahrenheit to maintain product quality and food safety standards.',
    `haccp_min_temp_f` DECIMAL(18,2) COMMENT 'Minimum safe storage temperature in Fahrenheit required to prevent bacterial growth and ensure food safety compliance.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the stock item is currently available for ordering and use. Inactive items are retained for historical reporting but not available for new transactions.',
    `is_gluten_free` BOOLEAN COMMENT 'Indicates whether the item is certified gluten-free or naturally contains no gluten. Critical for dietary accommodation and menu labeling.',
    `is_gmo_free` BOOLEAN COMMENT 'Indicates whether the item is certified non-GMO. Used for menu transparency and consumer preference alignment.',
    `is_halal` BOOLEAN COMMENT 'Indicates whether the item meets Islamic dietary law requirements. Used for menu segmentation and cultural accommodation.',
    `is_kosher` BOOLEAN COMMENT 'Indicates whether the item meets Jewish dietary law requirements. Used for menu segmentation and cultural accommodation.',
    `is_organic` BOOLEAN COMMENT 'Indicates whether the item is certified organic according to USDA standards. Used for menu marketing and premium pricing.',
    `is_vegan` BOOLEAN COMMENT 'Indicates whether the item contains no animal products or by-products. Used for menu filtering and dietary preference alignment.',
    `is_vegetarian` BOOLEAN COMMENT 'Indicates whether the item contains no meat, poultry, or seafood. Used for menu filtering and dietary preference alignment.',
    `item_category` STRING COMMENT 'Primary classification of the stock item by food service category. Used for inventory organization, COGS analysis, and procurement planning. [ENUM-REF-CANDIDATE: protein|produce|dairy|dry_goods|beverage|paper_goods|cleaning|packaging — 8 candidates stripped; promote to reference product]',
    `item_description` STRING COMMENT 'Detailed description of the stock item including brand, size, packaging, and other distinguishing characteristics.',
    `item_name` STRING COMMENT 'Human-readable name of the stock item as it appears in inventory management and ordering systems.',
    `item_subcategory` STRING COMMENT 'Secondary classification providing finer granularity within the item category (e.g., beef, chicken, lettuce, tomato).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the stock item record was last updated. Used for change tracking and audit trails.',
    `par_level` DECIMAL(18,2) COMMENT 'Target inventory quantity that should be maintained at all times to support operational needs without overstocking. Used for automated reorder triggers.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory threshold quantity that triggers a replenishment order. Set below PAR level to account for lead time.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'Standard quantity to order when inventory falls below reorder point. Calculated to restore inventory to PAR level.',
    `shelf_life_days` STRING COMMENT 'Number of days the item remains usable after receipt. Critical for waste management, FIFO rotation, and food safety compliance.',
    `sku_code` STRING COMMENT 'Unique alphanumeric code identifying the stock item across all restaurant units and inventory systems. This is the business identifier used in MarketMan and POS systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Expected unit cost of the item used for COGS calculations and variance analysis. Updated periodically based on procurement contracts.',
    `storage_class` STRING COMMENT 'Required storage temperature zone for the item. Determines BOH storage location and HACCP compliance requirements.. Valid values are `ambient|refrigerated|frozen`',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the stock item is tracked, ordered, and received. Critical for accurate inventory counts and cost calculations. [ENUM-REF-CANDIDATE: each|case|pound|kilogram|ounce|liter|gallon|box|bag|dozen — 10 candidates stripped; promote to reference product]',
    `vendor_item_code` STRING COMMENT 'Suppliers unique identifier for this item. Used for purchase order matching and invoice reconciliation.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of usable product after preparation and trimming. Critical for recipe costing and waste tracking.',
    CONSTRAINT pk_stock_item PRIMARY KEY(`stock_item_id`)
) COMMENT 'Master record for every SKU tracked in restaurant inventory — food, beverage, packaging, and non-food supplies. Captures SKU code, item name, unit of measure (UOM), item category (protein, produce, dry goods, beverage, paper goods, cleaning), storage class (ambient, refrigerated, frozen), reorder point, reorder quantity, standard cost, vendor item code, shelf life days, HACCP temperature range, allergen flags, daypart applicability, seasonal adjustment flags, and active status. Also owns PAR-level configuration per unit-location: PAR quantity, minimum quantity (reorder point), maximum quantity (shelf capacity), day-of-week overrides, seasonal adjustment flags, and effective date range. This is the SSOT for all stockable items and their replenishment parameters managed through MarketMan.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` (
    `stock_location_id` BIGINT COMMENT 'Unique identifier for the stock location. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Stores overhead allocation of each storage location to cost centers for accurate expense tracking.',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_center. Business justification: REQUIRED: DC‑wise stock location reporting and temperature compliance audits require linking each location to its distribution center.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Facility‑level inventory mapping needed for inventory valuation and rent‑cost allocation reports per physical restaurant property.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for HACCP temperature monitoring accountability; each storage location has an assigned manager employee who signs compliance reports.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this stock location is physically situated.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier for the refrigeration or climate control equipment serving this location, used for maintenance tracking and temperature monitoring integration.',
    `stock_equipment_equipment_asset_id` BIGINT COMMENT 'Identifier for the refrigeration or climate control equipment serving this location, used for maintenance tracking and temperature monitoring integration.',
    `access_control_required` BOOLEAN COMMENT 'Indicates whether electronic or physical access control (keycard, PIN, lock) is required to enter this location.',
    `activation_date` DATE COMMENT 'Date when the stock location was first activated and made available for inventory storage.',
    `allows_receiving` BOOLEAN COMMENT 'Indicates whether this location is designated as a receiving point for incoming inventory deliveries.',
    `allows_transfers` BOOLEAN COMMENT 'Indicates whether inventory can be transferred into or out of this location to other stock locations within the restaurant or across units.',
    `allows_waste_tracking` BOOLEAN COMMENT 'Indicates whether waste events (spoilage, damage, expiration) can be recorded against inventory in this location for Waste% calculation.',
    `bin_count` STRING COMMENT 'Number of individual storage bins or compartments within this location for granular SKU organization.',
    `building_section` STRING COMMENT 'Specific section or wing of the building where the location is situated (e.g., Kitchen, Bar, Prep Area, Receiving Dock).',
    `capacity_cubic_feet` DECIMAL(18,2) COMMENT 'Total storage capacity of the location measured in cubic feet.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock location record was first created in the system.',
    `cycle_count_frequency_days` STRING COMMENT 'Number of days between scheduled physical inventory cycle counts for this location to maintain stock accuracy.',
    `deactivation_date` DATE COMMENT 'Date when the stock location was deactivated or decommissioned and is no longer available for inventory storage.',
    `floor_level` STRING COMMENT 'Physical floor level where the storage location is situated (e.g., 1 for ground floor, -1 for basement, 2 for second floor).',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent physical inventory cycle count was completed for this location.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance or inspection was performed on the storage location or its equipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock location record was most recently updated.',
    `location_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the storage location within the restaurant unit (e.g., WIC01 for walk-in cooler 1, DRY02 for dry storage room 2).. Valid values are `^[A-Z0-9]{2,10}$`',
    `location_name` STRING COMMENT 'Human-readable name of the stock location (e.g., Walk-In Cooler, Dry Storage Room, Bar Storage, Prep Area Shelf).',
    `location_type` STRING COMMENT 'Classification of the storage location based on its primary function and environmental control (refrigerated, frozen, ambient, bar, prep_area, service_station).. Valid values are `refrigerated|frozen|ambient|bar|prep_area|service_station`',
    `next_scheduled_cycle_count_date` DATE COMMENT 'Date when the next physical inventory cycle count is scheduled for this location.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date when the next scheduled maintenance or inspection is planned for the storage location or its equipment.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special handling instructions, or operational notes about the stock location.',
    `par_level_enabled` BOOLEAN COMMENT 'Indicates whether PAR level inventory management is enabled for this location to trigger automatic replenishment orders.',
    `primary_commodity_category` STRING COMMENT 'Primary category of inventory items typically stored in this location (e.g., Proteins, Dairy, Produce, Dry Goods, Beverages, Alcohol).',
    `requires_haccp_monitoring` BOOLEAN COMMENT 'Indicates whether this location requires HACCP monitoring and documentation for food safety compliance.',
    `security_level` STRING COMMENT 'Security classification for the location indicating access control requirements (open: unrestricted, restricted: authorized staff only, locked: key/code required, high_value: premium items with enhanced security).. Valid values are `open|restricted|locked|high_value`',
    `shelf_count` STRING COMMENT 'Number of shelves or storage levels available in this location for organizing inventory.',
    `stock_location_status` STRING COMMENT 'Current operational status of the stock location (active: in use, inactive: temporarily not in use, maintenance: under repair, decommissioned: permanently retired).. Valid values are `active|inactive|maintenance|decommissioned`',
    `storage_area_type` STRING COMMENT 'Indicates whether the location is in Back of House (BOH) or Front of House (FOH) area of the restaurant.. Valid values are `boh|foh`',
    `target_temperature_max_f` DECIMAL(18,2) COMMENT 'Maximum target temperature in Fahrenheit for this storage location to maintain food safety and quality standards.',
    `target_temperature_min_f` DECIMAL(18,2) COMMENT 'Minimum target temperature in Fahrenheit for this storage location to maintain food safety and quality standards.',
    `temperature_monitoring_frequency_hours` STRING COMMENT 'Required frequency in hours for temperature checks and logging at this location to ensure food safety compliance.',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the location (freezer: below 0°F, cooler: 32-40°F, ambient: room temperature, controlled: climate-controlled but not refrigerated).. Valid values are `freezer|cooler|ambient|controlled`',
    CONSTRAINT pk_stock_location PRIMARY KEY(`stock_location_id`)
) COMMENT 'Master record for every physical storage location within a restaurant unit where inventory is held — walk-in cooler, walk-in freezer, dry storage room, BOH prep area, FOH service station, bar storage. Captures location code, location name, location type (refrigerated, frozen, ambient, bar), temperature zone, capacity (cubic feet or shelf count), restaurant unit reference, and active status. Enables granular stock-on-hand tracking by storage zone.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` (
    `on_hand_balance_id` BIGINT COMMENT 'Unique identifier for the on-hand balance record. Primary key for the inventory position snapshot.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links on‑hand quantities to cost centers to reflect inventory value in financial statements per cost center.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: FRANCHISEE‑LEVEL INVENTORY DASHBOARD aggregates on‑hand balances per franchisee for performance and royalty calculations.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this inventory is held. Links to the restaurant operations master.',
    `stock_item_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this balance is recorded. Links to the inventory item master.',
    `on_stock_item_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this balance is recorded. Links to the inventory item master.',
    `on_unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this inventory is held. Links to the restaurant operations master.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location within the restaurant (walk-in cooler, dry storage, freezer, prep area). Links to storage location master.',
    `abc_classification` STRING COMMENT 'The ABC inventory classification based on value and usage velocity. A items are high-value/high-velocity requiring tight control, C items are low-value/low-velocity.. Valid values are `A|B|C`',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which unit_cost and extended_value are denominated.. Valid values are `USD|CAD|EUR|GBP|MXN|AUD`',
    `cycle_count_frequency` STRING COMMENT 'The frequency at which this SKU should be physically counted as part of the cycle count program. Typically aligned with ABC classification.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `days_until_expiration` STRING COMMENT 'The number of days remaining until the expiration date. Used to prioritize usage and identify items at risk of waste.',
    `expiration_date` DATE COMMENT 'The date by which this inventory must be used or discarded. Critical for food safety, waste management, and FIFO (First In First Out) rotation.',
    `extended_value` DECIMAL(18,2) COMMENT 'The total dollar value of the on-hand inventory, calculated as quantity_on_hand multiplied by unit_cost. Used for financial reporting and COGS% analysis.',
    `inventory_status` STRING COMMENT 'The current lifecycle status of this inventory position. Determines whether the inventory is available for use, held for quality review, or flagged for disposal.. Valid values are `available|reserved|quarantined|expired|damaged|in_transit`',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether this SKU is a perishable item requiring temperature control and expiration tracking. True for fresh produce, dairy, meat; false for dry goods.',
    `last_adjustment_date` DATE COMMENT 'The date when the last inventory adjustment (waste, transfer, or correction) was recorded for this SKU at this location.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'The date and time of the last inventory transaction (receipt, transfer, issue, or adjustment) that affected this balance. Used to identify stagnant inventory.',
    `last_physical_count_date` DATE COMMENT 'The date when the last physical inventory count was performed for this SKU at this location. Used to track audit compliance and inventory accuracy.',
    `last_received_date` DATE COMMENT 'The date when this SKU was last received into inventory at this location. Used to track inventory freshness and identify slow-moving items.',
    `lot_number` STRING COMMENT 'The supplier or manufacturer lot number for traceability and recall management. Critical for food safety compliance under HACCP (Hazard Analysis Critical Control Points).',
    `par_level` DECIMAL(18,2) COMMENT 'The target inventory level for this SKU at this location, used for automatic replenishment decisions. Represents the optimal stock level to maintain service without excess waste.',
    `quantity_available` DECIMAL(18,2) COMMENT 'The net quantity available for use or sale, calculated as quantity_on_hand minus quantity_reserved. Represents the true available-to-promise inventory.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The total physical quantity of the SKU currently in stock at this location. Represents the gross inventory position before reservations.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'The quantity of the SKU that is committed to prep, production, or pending orders and not available for new allocation. Used in BOH (Back of House) prep planning.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this on-hand balance record was first created in the data platform. Audit trail for data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this on-hand balance record was last updated in the data platform. Audit trail for change tracking.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level at which a replenishment order should be triggered. When quantity_available falls below this threshold, the system generates a purchase order.',
    `safety_stock` DECIMAL(18,2) COMMENT 'The minimum buffer stock maintained to protect against stockouts due to demand variability or supply delays. Part of the PAR level calculation.',
    `sku_code` STRING COMMENT 'The business identifier code for the SKU. Denormalized from SKU master for reporting convenience.',
    `sku_description` STRING COMMENT 'Human-readable description of the SKU. Denormalized from SKU master for reporting convenience.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The date and time when this on-hand balance snapshot was captured. Represents the point-in-time inventory position for reporting and reconciliation.',
    `temperature_zone` STRING COMMENT 'The required storage temperature zone for this SKU (ambient/dry, refrigerated, or frozen). Critical for food safety compliance and storage location assignment.. Valid values are `ambient|refrigerated|frozen`',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of measure for this SKU at this location. Used to calculate extended inventory value and COGS (Cost of Goods Sold).',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the quantity is expressed (each, pound, kilogram, ounce, gallon, liter, case, box, pack, dozen). [ENUM-REF-CANDIDATE: EA|LB|KG|OZ|GAL|L|CS|BX|PK|DZ — 10 candidates stripped; promote to reference product]',
    `valuation_method` STRING COMMENT 'The accounting method used to value this inventory (FIFO - First In First Out, LIFO - Last In First Out, weighted average, or standard cost). Determines COGS calculation.. Valid values are `FIFO|LIFO|weighted_average|standard_cost`',
    `variance_from_par` DECIMAL(18,2) COMMENT 'The difference between quantity_on_hand and par_level. Positive values indicate overstocking, negative values indicate understocking and trigger replenishment.',
    CONSTRAINT pk_on_hand_balance PRIMARY KEY(`on_hand_balance_id`)
) COMMENT 'Current stock-on-hand snapshot for each SKU at each storage location within a restaurant unit. Captures quantity on hand, quantity reserved (committed to prep), quantity available, last physical count date, last adjustment date, last received date, unit cost, extended value, and variance from PAR level. Updated by receiving, transfers, waste events, and physical counts. The authoritative real-time inventory position record used for replenishment decisions and food cost reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` (
    `receiving_order_id` BIGINT COMMENT 'Unique identifier for the receiving order record. Primary key for inbound inventory transactions at restaurant unit level.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Receiving dock assignment per facility supports labor‑cost tracking and health‑inspection compliance at each restaurant location.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee receiving reports track supplier deliveries per franchisee to reconcile costs against royalty fees.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order in MarketMan that authorized this delivery. Links receiving to procurement.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier or distribution center that delivered the goods. Links to vendor master in Coupa or MarketMan.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the restaurant manager or BOH staff member who inspected and accepted the delivery. Links to Workday HCM employee master.',
    `receiving_manager_employee_id` BIGINT COMMENT 'Employee identifier of the restaurant manager or BOH staff member who inspected and accepted the delivery. Links to Workday HCM employee master.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit receiving the goods. Links to restaurant operations master data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the receiving order record was first created in MarketMan or source system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the received value (e.g., USD, CAD, EUR). Supports multi-currency operations for international franchise units.. Valid values are `^[A-Z]{3}$`',
    `days_variance` STRING COMMENT 'Calculated difference in days between expected and actual delivery date. Positive values indicate late delivery; negative values indicate early delivery. Used for supplier scorecard.',
    `delivery_date` DATE COMMENT 'Calendar date when the goods were delivered to the restaurant unit. Used for inventory aging and FIFO tracking.',
    `delivery_note_number` STRING COMMENT 'Packing slip or delivery note number provided by the supplier. Cross-reference document for reconciliation and dispute resolution.',
    `delivery_time` TIMESTAMP COMMENT 'Precise timestamp when the delivery was received at the restaurant Back of House (BOH). Critical for temperature control compliance and HACCP documentation.',
    `delivery_timeliness` STRING COMMENT 'Classification of delivery punctuality relative to expected delivery date. On Time: within agreed window; Early: before window; Late: after window. Key supplier performance indicator.. Valid values are `on_time|early|late`',
    `driver_name` STRING COMMENT 'Name of the driver who delivered the goods. Captured for traceability and food safety audit trail per HACCP requirements.',
    `expected_delivery_date` DATE COMMENT 'Scheduled delivery date from the original purchase order. Used to calculate delivery timeliness and supplier on-time performance metrics.',
    `goods_receipt_number` STRING COMMENT 'SAP S/4HANA Material Management (MM) goods receipt document number generated when receiving is posted to inventory. Used for three-way match and financial posting.',
    `invoice_number` STRING COMMENT 'Invoice number provided by the supplier on the delivery documentation. Used for three-way match with PO and goods receipt in SAP S/4HANA AP.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the receiving order record was last updated. Tracks changes to status, variance resolution, or quality inspection updates.',
    `posted_to_inventory_flag` BOOLEAN COMMENT 'Boolean indicator that received goods have been posted to restaurant unit inventory in MarketMan and SAP S/4HANA. True when goods receipt is complete and stock levels updated.',
    `posted_to_inventory_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving transaction was posted to inventory system. Used for inventory valuation date and FIFO/LIFO costing.',
    `quality_inspection_result` STRING COMMENT 'Overall quality assessment result for the received goods. Approved: meets standards; Rejected: fails quality criteria; Conditional: accepted with notes; Not Inspected: visual check only. Aligns with Good Manufacturing Practice (GMP) standards.. Valid values are `approved|rejected|conditional|not_inspected`',
    `quality_notes` STRING COMMENT 'Free-text notes captured by receiving manager regarding product quality, packaging condition, or other observations. Used for supplier feedback and continuous improvement.',
    `receiving_location` STRING COMMENT 'Physical location at the restaurant unit where goods were received. Typically Back of House (BOH) loading area. Used for operational logistics and security tracking.. Valid values are `back_door|loading_dock|front_entrance|side_entrance`',
    `receiving_number` STRING COMMENT 'Business-facing unique receiving document number generated by MarketMan or restaurant POS system. Format: RCV-YYYYMMDD-NNNN.. Valid values are `^RCV-[0-9]{8}-[0-9]{4}$`',
    `receiving_shift` STRING COMMENT 'Operational shift during which the delivery was received. Used for labor planning and to ensure adequate BOH staffing for receiving activities.. Valid values are `morning|afternoon|evening|overnight`',
    `receiving_status` STRING COMMENT 'Current lifecycle status of the receiving transaction. Pending: awaiting inspection; Partial: some items received; Complete: fully received and accepted; Rejected: delivery refused; Disputed: discrepancy under review.. Valid values are `pending|partial|complete|rejected|disputed`',
    `rejection_reason` STRING COMMENT 'Detailed explanation if receiving status is rejected. Captures specific food safety, quality, or compliance failure that led to refusal of delivery. Required for FDA and HACCP audit trail.',
    `seal_integrity_check` STRING COMMENT 'Verification that tamper-evident seals on delivery containers were intact upon arrival. Intact: seal unbroken; Broken: potential contamination risk; Not Applicable: no seal required. Part of food safety protocol.. Valid values are `intact|broken|not_applicable`',
    `supplier_name` STRING COMMENT 'Legal or trade name of the supplier or distributor. Denormalized for reporting convenience; authoritative source is supplier master.',
    `temperature_check_result` STRING COMMENT 'Result of temperature verification for refrigerated and frozen goods upon delivery. Pass: within safe range; Fail: out of range, reject or quarantine; Not Applicable: ambient goods. Critical for HACCP and FDA compliance.. Valid values are `pass|fail|not_applicable`',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Actual temperature reading in Fahrenheit recorded during delivery inspection for refrigerated or frozen items. Null for ambient goods. Used for food safety audit trail.',
    `total_items_ordered` STRING COMMENT 'Total count of distinct Stock Keeping Units (SKUs) listed on the originating purchase order. Used for completeness verification.',
    `total_items_received` STRING COMMENT 'Total count of distinct SKUs actually received and accepted in this transaction. Variance from total_items_ordered triggers partial or disputed status.',
    `total_received_value` DECIMAL(18,2) COMMENT 'Total monetary value of all goods received in this transaction, in local currency. Used for Cost of Goods Sold (COGS) calculation and variance analysis against PO.',
    `variance_flag` BOOLEAN COMMENT 'Boolean indicator that quantity or value variance exists between PO and received goods. True triggers exception workflow for manager review and supplier follow-up.',
    `variance_reason` STRING COMMENT 'Categorized reason for any discrepancy between ordered and received goods. Used for supplier performance tracking and root cause analysis.. Valid values are `short_shipment|damaged_goods|wrong_item|quality_issue|overage|none`',
    CONSTRAINT pk_receiving_order PRIMARY KEY(`receiving_order_id`)
) COMMENT 'Records the receipt of goods delivered to a restaurant unit from a supplier or distribution center, capturing both delivery-level header information and line-level SKU detail in a single consolidated entity. Header attributes: purchase order reference, delivery date/time, supplier reference, driver name, invoice number, total received value, receiving status (pending/partial/complete/rejected), temperature check result, seal integrity check, and receiving manager reference. Line attributes (one per SKU received): stock item reference, ordered vs received vs rejected quantities, unit of measure, unit cost, extended cost, lot number, expiration date, temperature at receipt (°F/°C), condition code (acceptable/damaged/short-dated/rejected), and variance reason code. Links to MarketMan purchase order and SAP S/4HANA goods receipt. Drives on-hand balance updates, COGS% tracking, and supplier performance measurement.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` (
    `physical_count_id` BIGINT COMMENT 'Unique identifier for the physical inventory count event. Primary key.',
    `financial_period_id` BIGINT COMMENT 'Reference to the fiscal period (month/quarter) for which this count is being performed, used for period-end food cost reconciliation and P&L (Profit and Loss) reporting.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee audit of physical inventory counts is required for compliance and variance analysis.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the General Ledger journal entry created to record the inventory variance from this physical count.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the physical count was performed.',
    `physical_unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the physical count was performed.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who initiated or started the physical count event.',
    `recount_of_count_id` BIGINT COMMENT '',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the physical count was completed and submitted.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the physical count was started by the counting team.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the physical count was approved by the manager or supervisor.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the physical count was cancelled or voided.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the physical count was cancelled or voided, if applicable.',
    `count_date` DATE COMMENT 'The calendar date on which the physical inventory count was conducted.',
    `count_method` STRING COMMENT 'The method used to perform the physical count: manual (paper-based or manual entry), barcode-scan (handheld scanner), rfid (radio-frequency identification), or hybrid (combination of methods).. Valid values are `manual|barcode-scan|rfid|hybrid`',
    `count_number` STRING COMMENT 'Business identifier for the physical count event, formatted as PC-YYYYMMDD-NNNN for external reference and audit trail.. Valid values are `^PC-[0-9]{8}-[0-9]{4}$`',
    `count_period` STRING COMMENT 'The daypart or shift during which the count was performed, aligned with restaurant operating periods.. Valid values are `breakfast|lunch|dinner|late-night|overnight|full-day`',
    `count_status` STRING COMMENT 'Current lifecycle status of the count event: scheduled (planned but not started), in-progress (counting underway), submitted (completed awaiting approval), approved (validated by manager), posted (applied to inventory system), or cancelled (voided).. Valid values are `scheduled|in-progress|submitted|approved|posted|cancelled`',
    `count_type` STRING COMMENT 'Classification of the count event: full (complete inventory), spot-check (random sample), cycle-count (scheduled rotation), pre-close (before period end), post-close (after period end), or opening (new restaurant opening).. Valid values are `full|spot-check|cycle-count|pre-close|post-close|opening`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this physical count record was first created in the system.',
    `is_period_end_count` BOOLEAN COMMENT 'Boolean flag indicating whether this count is a mandatory period-end count for financial close and COGS% (Cost of Goods Sold Percentage) calculation. True if period-end count, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this physical count record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about the count event, including explanations for significant variances, operational issues during count, or special circumstances.',
    `physical_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory based on the physical count results, calculated by multiplying counted quantities by unit costs.',
    `posted_to_gl_timestamp` TIMESTAMP COMMENT 'The date and time when the count variance was posted to the General Ledger (GL) for financial reporting, typically after approval.',
    `recount_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a recount is required due to excessive variance or data quality issues. True if recount needed, False otherwise.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The planned date and time when the physical count was scheduled to begin.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the physical count was submitted for approval after completion.',
    `system_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory according to the system (MarketMan) at the time of count, used as the baseline for variance calculation.',
    `total_sku_counted` STRING COMMENT 'The total number of unique SKUs (Stock Keeping Units) that were physically counted during this count event.',
    `total_sku_with_variance` STRING COMMENT 'The number of SKUs that showed a variance (difference) between system inventory and physical count.',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'The total dollar value variance between system inventory and physical count results, calculated as (physical count value - system inventory value). Positive indicates overage, negative indicates shortage.',
    `total_variance_percentage` DECIMAL(18,2) COMMENT 'The total variance expressed as a percentage of system inventory value, calculated as (variance amount / system inventory value) * 100. Key metric for COGS% (Cost of Goods Sold Percentage) analysis and food cost control.',
    `variance_reason_code` STRING COMMENT 'Primary reason code for inventory variance: theft (shrinkage), spoilage (expired/damaged), waste (prep waste), receiving-error (incorrect receipt), transfer-error (incorrect transfer), system-error (data entry mistake), or unknown. [ENUM-REF-CANDIDATE: theft|spoilage|waste|receiving-error|transfer-error|system-error|unknown — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_physical_count PRIMARY KEY(`physical_count_id`)
) COMMENT 'Records scheduled or ad-hoc physical inventory count events at a restaurant unit, capturing both count-level header metadata and line-level SKU counts in a single consolidated entity. Header attributes: count date, count type (full/spot-check/cycle-count/pre-close/post-close), count status, count period, initiated-by/approved-by employees, total variance value and percentage. Line attributes (one per SKU-location counted): stock item reference, storage location, system quantity (book inventory), counted quantity, variance quantity and value ($), unit of measure, unit cost, count method (manual/scan), counted-by employee reference, and recount flag. Variance lines trigger investigation workflows and feed period-end food cost reconciliation and COGS% reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` (
    `waste_log_id` BIGINT COMMENT 'Unique identifier for the waste log entry. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing ROI analysis needs to attribute waste spikes to specific campaigns; this FK supports that report.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Waste tracking per facility enables waste‑cost attribution to each property for sustainability and expense reporting.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee waste reporting feeds sustainability metrics and waste‑related royalty adjustments.',
    `menu_item_id` BIGINT COMMENT 'Identifier of the finished menu item that was wasted, if the waste occurred at the prepared food stage.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the waste event in the system.',
    `recipe_id` BIGINT COMMENT 'Identifier of the recipe or Bill of Materials (BOM) associated with the wasted prepared item, if applicable.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the waste event occurred, used for labor and operational analysis.',
    `stock_item_id` BIGINT COMMENT 'Identifier of the Stock Keeping Unit (SKU) that was wasted.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Waste is recorded per storage location; replacing the denormalized storage_location field with a FK enables location‑level waste analytics.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Posts waste expense to a designated GL account for waste cost reporting and profitability analysis.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier who provided the wasted item, used for vendor quality analysis.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the waste event occurred.',
    `waste_vendor_procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier who provided the wasted item, used for vendor quality analysis.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the waste log entry was approved by a manager.',
    `batch_number` STRING COMMENT 'The production or receiving batch identifier for the wasted item, used for traceability and food safety compliance.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action implemented to prevent recurrence of this type of waste.',
    `daypart` STRING COMMENT 'The operational time segment during which the waste event occurred (breakfast, lunch, dinner, late-night).. Valid values are `breakfast|lunch|dinner|late-night`',
    `disposal_method` STRING COMMENT 'The method used to dispose of the wasted item: trash (landfill), compost, donation (food rescue), rendering (animal feed/byproduct), or other.. Valid values are `trash|compost|donation|rendering|other`',
    `expiration_date` DATE COMMENT 'The use-by or best-before date of the wasted item, critical for expiration-related waste tracking.',
    `haccp_violation` BOOLEAN COMMENT 'Indicates whether the waste event was associated with a HACCP critical control point violation.',
    `manager_approved` BOOLEAN COMMENT 'Indicates whether a manager has reviewed and approved this waste log entry.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about the waste event for operational context.',
    `on_hand_quantity_before_waste` DECIMAL(18,2) COMMENT 'The inventory quantity on hand immediately before the waste event was recorded.',
    `par_level_at_waste` DECIMAL(18,2) COMMENT 'The PAR level setting for this item at the time of waste, used to analyze whether overstocking contributed to waste.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this waste log record was first created in the database.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The system timestamp when this waste log record was last modified.',
    `responsible_station` STRING COMMENT 'The operational area where the waste occurred: BOH (Back of House - kitchen/prep areas) or FOH (Front of House - service/dining areas).. Valid values are `BOH|FOH`',
    `temperature_at_waste` DECIMAL(18,2) COMMENT 'The temperature in Fahrenheit of the item or storage area at the time of waste, relevant for food safety and spoilage analysis.',
    `unit_of_measure` STRING COMMENT 'The unit in which the waste quantity is measured (e.g., kilograms, pounds, each, gallons). [ENUM-REF-CANDIDATE: kg|lb|oz|g|ea|case|box|gal|ltr|ml — 10 candidates stripped; promote to reference product]',
    `waste_category` STRING COMMENT 'The classification of the waste event: spoilage (deterioration), overproduction (excess prepared food), prep-loss (trimming/cooking loss), expiration (past use-by date), quality-reject (failed quality standards), theft-unknown (unexplained loss).. Valid values are `spoilage|overproduction|prep-loss|expiration|quality-reject|theft-unknown`',
    `waste_cost` DECIMAL(18,2) COMMENT 'The monetary cost of the wasted item in the restaurants operating currency, calculated as quantity times unit cost.',
    `waste_date` DATE COMMENT 'The calendar date on which the waste event occurred.',
    `waste_prevention_opportunity` STRING COMMENT 'Notes on potential process improvements or training opportunities identified from this waste event.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of the item wasted, measured in the unit of measure specified.',
    `waste_reason` STRING COMMENT 'Free-text description providing additional context and specific reason for the waste event.',
    `waste_timestamp` TIMESTAMP COMMENT 'The precise date and time when the waste event was recorded.',
    CONSTRAINT pk_waste_log PRIMARY KEY(`waste_log_id`)
) COMMENT 'Records every food waste event at a restaurant unit — spoilage, overproduction, prep waste, expiration, and quality rejection. Captures waste date, waste time, stock item reference, waste quantity, unit of measure, waste cost ($), waste category (spoilage, overproduction, prep loss, expiration, quality-reject, theft/unknown), waste reason description, responsible station (BOH/FOH), recorded-by employee reference, and manager approval flag. Drives Waste% KPI calculation and supports yield management and COGS% optimization.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` (
    `stock_transfer_id` BIGINT COMMENT 'Unique identifier for the stock transfer transaction. Primary key for the stock transfer record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Captures internal transfer cost allocation to cost centers for inter‑unit inventory movement accounting.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit or distribution center receiving the transferred inventory. For intra-unit transfers, this is the same as origin unit.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in cooler, dry storage, freezer) within the destination unit where items will be received. Critical for BOH (Back of House) inventory accuracy.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Inter‑facility stock transfers require facility context to allocate transfer costs and maintain accurate on‑hand balances per property.',
    `origin_restaurant_unit_id` BIGINT COMMENT 'Reference to the restaurant unit or distribution center from which inventory is being transferred. For intra-unit transfers, this is the same as destination unit.',
    `origin_stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in cooler, dry storage, freezer) within the origin unit from which items are being transferred. Critical for BOH (Back of House) inventory accuracy.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically kitchen manager or shift supervisor) who initiated the stock transfer request. Used for accountability and audit trail.',
    `tertiary_stock_received_by_employee_id` BIGINT COMMENT 'Reference to the employee at the destination unit who physically received and confirmed the transferred inventory. Null until transfer is received.',
    `cancellation_date` DATE COMMENT 'Date when the stock transfer was cancelled. Null if transfer was not cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the transfer was cancelled. Used for operational analysis and process improvement.',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier or delivery service used for inter-unit transfers. Null for intra-unit transfers or self-pickup.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock transfer record was first created in the system. Used for audit trail and data lineage tracking.',
    `expected_delivery_date` DATE COMMENT 'Planned or estimated date when the transferred inventory is expected to arrive at the destination. Used for receiving planning and PAR (Periodic Automatic Replenishment) level management.',
    `external_transfer_reference` STRING COMMENT 'Unique identifier from the source operational system (MarketMan, SAP MM). Used for data lineage, reconciliation, and cross-system traceability.',
    `fiscal_period` STRING COMMENT 'Fiscal period (year and period number) to which this transfer is assigned for financial reporting. Format: YYYY-PNN (e.g., 2024-P03 for period 3 of fiscal year 2024).. Valid values are `^[0-9]{4}-P(0[1-9]|1[0-3])$`',
    `gl_posting_date` DATE COMMENT 'Date when the inventory transfer transaction was posted to the general ledger for financial reporting. May differ from physical transfer date due to period-end cutoffs.',
    `haccp_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether this transfer requires continuous temperature monitoring and documentation per HACCP critical control point protocols. True for high-risk perishable items.',
    `inspection_notes` STRING COMMENT 'Free-text notes from quality inspection documenting any issues, observations, or conditions. Used for quality tracking and supplier performance evaluation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock transfer record was most recently updated. Used for change tracking and data synchronization.',
    `priority_level` STRING COMMENT 'Urgency classification for the transfer: routine (standard replenishment), high (needed within 24 hours), urgent (needed same day), emergency (critical stockout situation requiring immediate action).. Valid values are `routine|high|urgent|emergency`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether items in this transfer require formal quality inspection upon receipt per GMP (Good Manufacturing Practice) or food safety protocols. True for high-value or high-risk items.',
    `quality_inspection_status` STRING COMMENT 'Result of quality inspection at receiving: not-required (no inspection needed), pending (awaiting inspection), passed (accepted), failed (rejected), conditional-accept (accepted with notes or partial rejection).. Valid values are `not-required|pending|passed|failed|conditional-accept`',
    `shipping_method` STRING COMMENT 'Method used to transport inventory between locations: internal-delivery (company fleet), courier (contracted delivery service), third-party (3PD logistics provider), self-pickup (destination unit retrieves), direct-transfer (hand-carried for intra-unit).. Valid values are `internal-delivery|courier|third-party|self-pickup|direct-transfer`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this stock transfer record: MARKETMAN (MarketMan Inventory Management), SAP-MM (SAP Materials Management), MANUAL (manually entered), LEGACY (migrated from prior system).. Valid values are `MARKETMAN|SAP-MM|MANUAL|LEGACY`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this transfer requires temperature-controlled transportation to maintain food safety and quality. True for perishable items requiring refrigeration or freezing per HACCP (Hazard Analysis Critical Control Points) standards.',
    `temperature_zone_required` STRING COMMENT 'Required temperature zone for transport: ambient (room temperature), refrigerated (33-40°F), frozen (0°F or below), multi-temp (mixed temperature requirements). Critical for HACCP compliance and food safety.. Valid values are `ambient|refrigerated|frozen|multi-temp`',
    `total_item_count` STRING COMMENT 'Total number of distinct SKU (Stock Keeping Unit) line items included in this transfer. Used for transfer complexity assessment and receiving workload planning.',
    `total_quantity_transferred` DECIMAL(18,2) COMMENT 'Aggregate quantity of all items transferred, summed across all line items. Unit of measure varies by item (cases, pounds, gallons, each). Used for high-level transfer volume tracking.',
    `total_transfer_value_usd` DECIMAL(18,2) COMMENT 'Total dollar value of all items included in this stock transfer, calculated at standard cost. Critical for COGS% (Cost of Goods Sold Percentage) tracking and inventory valuation across units.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by carrier for monitoring in-transit status. Null for internal transfers without formal tracking.',
    `transfer_approval_date` DATE COMMENT 'Date when the stock transfer was approved by authorized manager. Null if not yet approved or if auto-approved (same as request date).',
    `transfer_number` STRING COMMENT 'Business-facing unique transfer document number used for tracking and reference in operational systems and communications. Format: STR-YYYYMMDD-NNNN.. Valid values are `^STR-[0-9]{8}-[0-9]{4}$`',
    `transfer_reason_code` STRING COMMENT 'Business reason for initiating the stock transfer: par-replenishment (restore PAR levels), excess-stock (reduce overstock), expiring-soon (move near-expiry items), quality-issue (return defective goods), menu-change (redistribute due to menu update), seasonal-adjustment (rebalance for seasonal demand).. Valid values are `par-replenishment|excess-stock|expiring-soon|quality-issue|menu-change|seasonal-adjustment`',
    `transfer_reason_notes` STRING COMMENT 'Free-text explanation providing additional context for the transfer. Used for operational communication and audit documentation.',
    `transfer_received_date` DATE COMMENT 'Date when the inventory was physically received and confirmed at the destination location. Null until transfer is fully or partially received.',
    `transfer_request_date` DATE COMMENT 'Date when the stock transfer was initially requested. Used for tracking lead times and transfer cycle analytics.',
    `transfer_ship_date` DATE COMMENT 'Date when the inventory physically left the origin location. Used for in-transit tracking and speed of service metrics.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the stock transfer: requested (initiated but pending approval), approved (authorized for execution), rejected (denied by approver), in-transit (shipped but not yet received), received (fully received and confirmed), cancelled (voided before completion), partially-received (some items received, others pending). [ENUM-REF-CANDIDATE: requested|approved|rejected|in-transit|received|cancelled|partially-received — 7 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the transfer based on origin and destination: inter-unit (between restaurant units), intra-unit (between storage locations within same unit), return-to-dc (from unit back to distribution center), return-to-vendor (from unit back to supplier), emergency (urgent replenishment), rebalance (inventory optimization transfer).. Valid values are `inter-unit|intra-unit|return-to-dc|return-to-vendor|emergency|rebalance`',
    `variance_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified between shipped quantities and received quantities. True if any line item shows variance requiring investigation.',
    `variance_reason` STRING COMMENT 'Root cause classification for any quantity variance: damage-in-transit (items damaged during shipment), short-shipment (fewer items sent than documented), overage (more items received than expected), quality-rejection (items rejected at receiving), counting-error (human error in count), none (no variance).. Valid values are `damage-in-transit|short-shipment|overage|quality-rejection|counting-error|none`',
    CONSTRAINT pk_stock_transfer PRIMARY KEY(`stock_transfer_id`)
) COMMENT 'Records the movement of inventory between restaurant units, between storage locations within a unit, or from a unit back to a distribution center — capturing both transfer header and line-level SKU detail in a single consolidated entity. Header attributes: transfer date, transfer type (inter-unit/intra-unit/return-to-vendor/return-to-DC), origin and destination units/locations, transfer status, requested-by/approved-by employees, and total transfer value. Line attributes (one per SKU transferred): stock item reference, transferred quantity, unit of measure, unit cost, extended cost, lot number, expiration date, and condition code. Maintains inventory accuracy across the restaurant network and supports inter-unit food cost allocation.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order. Primary key for the replenishment order entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Associates purchase orders with cost centers to allocate procurement spend in financial reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the user (manager or approver) who approved the replenishment order. Null if approval not required or still pending.',
    `procurement_supplier_id` BIGINT COMMENT 'Reference to the supplier fulfilling the replenishment order. Links to supplier master data in procurement system.',
    `receiving_employee_id` BIGINT COMMENT 'Reference to the user (typically BOH manager or receiving clerk) who received and verified the replenishment order delivery at the restaurant unit.',
    `receiving_user_employee_id` BIGINT COMMENT 'Reference to the user (typically BOH manager or receiving clerk) who received and verified the replenishment order delivery at the restaurant unit.',
    `replenishment_cancelled_by_user_employee_id` BIGINT COMMENT 'Reference to the user who cancelled the replenishment order. Used for audit trail and accountability.',
    `replenishment_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created the replenishment order. For auto-PAR orders, may reference system user account.',
    `replenishment_employee_id` BIGINT COMMENT 'Reference to the user (manager or approver) who approved the replenishment order. Null if approval not required or still pending.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit placing the replenishment order. Links to the restaurant operations master data.',
    `tertiary_replenishment_cancelled_by_user_employee_id` BIGINT COMMENT 'Reference to the user who cancelled the replenishment order. Used for audit trail and accountability.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the replenishment order was received at the restaurant unit. Used for supplier performance tracking and variance analysis.',
    `approval_status` STRING COMMENT 'Approval workflow status for the replenishment order. Orders above threshold or emergency orders may require manager or regional approval before submission.. Valid values are `pending|approved|rejected|not_required`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was approved. Used for audit trail and approval turnaround time analysis.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the replenishment order was cancelled. Captures business reason such as supplier unavailability, budget constraints, duplicate order, or inventory correction.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was cancelled. Used for order lifecycle tracking and supplier performance analysis.',
    `carrier_name` STRING COMMENT 'Name of the shipping carrier or logistics provider delivering the replenishment order. May be supplier-managed or third-party carrier.',
    `confirmed_delivery_date` DATE COMMENT 'Supplier-confirmed date for delivery of the replenishment order. May differ from requested date based on supplier availability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order record was first created in the system. Used for audit trail and order lifecycle analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the replenishment order. Typically USD for US operations, but supports multi-currency for international units.. Valid values are `^[A-Z]{3}$`',
    `delivery_instructions` STRING COMMENT 'Special instructions for delivery of the replenishment order. May include receiving hours, loading dock location, contact person, or handling requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order record was last updated. Tracks any changes to order details, status, or metadata.',
    `notes` STRING COMMENT 'General free-text notes or comments about the replenishment order. May include special requests, context, or internal communication.',
    `order_date` DATE COMMENT 'Date when the replenishment order was created or initiated. Business event date for order placement.',
    `order_number` STRING COMMENT 'Business-facing unique order number for tracking and reference. Format: RO-YYYYMMDD-XXXXXX where YYYYMMDD is order date and XXXXXX is sequence.. Valid values are `^RO-[0-9]{8}-[A-Z0-9]{6}$`',
    `order_source` STRING COMMENT 'System or channel that originated the replenishment order. Identifies whether order was auto-generated by MarketMan, manually created by manager, or triggered by integrated system.. Valid values are `marketman_auto|manager_manual|pos_integration|erp_mrp|mobile_app|third_party_api`',
    `order_status` STRING COMMENT 'Current lifecycle status of the replenishment order. Tracks progression from creation through fulfillment or cancellation. [ENUM-REF-CANDIDATE: draft|submitted|confirmed|in_transit|delivered|partially_delivered|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the replenishment order trigger mechanism. Auto-PAR: triggered automatically when stock falls below PAR level; Manual: manager-initiated; Emergency: urgent out-of-stock order; Scheduled: routine periodic order; Spot: one-time special order.. Valid values are `auto_par|manual|emergency|scheduled|spot`',
    `payment_terms` STRING COMMENT 'Payment terms agreed with supplier for this replenishment order. Examples: Net 30, Net 60, COD, 2/10 Net 30. Inherited from supplier master agreement or negotiated per order.',
    `priority_level` STRING COMMENT 'Business priority classification for the replenishment order. Urgent priority for emergency out-of-stock situations; high for items approaching stockout; normal for routine PAR replenishment.. Valid values are `low|normal|high|urgent`',
    `purchase_order_number` STRING COMMENT 'Reference to the formal purchase order number generated in Coupa or SAP MM when the replenishment order is converted to a PO. Links inventory replenishment to procurement system.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was physically received and logged into inventory at the restaurant unit. Triggers inventory update and AP invoice matching.',
    `requested_delivery_date` DATE COMMENT 'Target date by which the restaurant unit requests delivery of the replenishment order. Used for planning and scheduling.',
    `shipping_fee` DECIMAL(18,2) COMMENT 'Delivery or freight charge for the replenishment order in USD. May be waived based on minimum order value or supplier agreement.',
    `shipping_method` STRING COMMENT 'Delivery method for the replenishment order. Determines delivery speed and cost. Will-call indicates restaurant will pick up from supplier.. Valid values are `standard|expedited|overnight|supplier_truck|third_party_carrier|will_call`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was submitted to the supplier. Marks transition from draft to active order.',
    `supplier_order_reference` STRING COMMENT 'Supplier-provided order confirmation number or reference. Used for cross-referencing with supplier systems and delivery documentation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the replenishment order in USD. Includes sales tax, VAT, or other applicable taxes based on jurisdiction.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Final total amount payable for the replenishment order in USD, including order value, tax, and shipping fees. Used for AP invoice reconciliation.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the replenishment order in USD, including all line items before tax and fees. Used for budget tracking and COGS calculation.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by carrier for the replenishment order. Enables real-time delivery status monitoring.',
    `variance_flag` BOOLEAN COMMENT 'Indicates whether the received replenishment order had discrepancies (quantity, quality, or item substitutions) compared to the original order. True if variance detected.',
    `variance_notes` STRING COMMENT 'Detailed notes describing any discrepancies found during receiving. Includes short shipments, damaged goods, wrong items, or quality issues. Used for supplier dispute resolution.',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Automated or manually triggered replenishment order generated when stock falls below PAR level or reorder point, capturing both order header and line-level SKU detail in a single consolidated entity. Header attributes: order date, order type (auto-PAR/manual/emergency), restaurant unit reference, supplier reference, requested delivery date, order status, total order value, order source (MarketMan auto-replenishment/manager-initiated), and approval status. Line attributes (one per SKU ordered): stock item reference, ordered quantity, unit of measure, unit cost, extended cost, PAR quantity at time of order, on-hand quantity at time of order, variance-to-PAR quantity, and confirmed delivery quantity. Bridges inventory management and procurement; links to purchase orders in Coupa and SAP MM. Enables food cost forecasting and supplier fill-rate tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'Unique identifier for the yield record. Primary key.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Yield analysis is reported to franchisees to drive operational efficiency and cost control.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the yield measurement.',
    `recipe_id` BIGINT COMMENT 'Identifier of the recipe or BOM (Bill of Materials) associated with this prep task, if applicable.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the yield measurement was recorded.',
    `stock_item_id` BIGINT COMMENT 'Identifier of the raw ingredient or stock item that was processed.',
    `actual_yield_percentage` DECIMAL(18,2) COMMENT 'Actual yield percentage calculated as (usable_yield_quantity_out / raw_quantity_in) * 100. Represents the efficiency of the prep process.',
    `batch_number` STRING COMMENT 'Batch or lot number of the raw ingredient used, for traceability and HACCP (Hazard Analysis Critical Control Points) compliance.',
    `cost_per_raw_unit` DECIMAL(18,2) COMMENT 'Cost per unit of the raw ingredient at the time of preparation. Used to calculate actual prep cost and COGS% impact.',
    `cost_per_yield_unit` DECIMAL(18,2) COMMENT 'Calculated cost per unit of usable yield output, accounting for waste. Used for accurate BOM costing and menu pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the yield record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `haccp_compliant` BOOLEAN COMMENT 'Indicates whether the preparation activity met HACCP critical control point requirements (temperature, time, sanitation).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the yield record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes or comments about the yield measurement, prep conditions, or any anomalies observed.',
    `prep_date` DATE COMMENT 'Date when the food preparation activity and yield measurement occurred.',
    `prep_station_code` STRING COMMENT 'Code identifying the BOH (Back of House) prep station or work area where the preparation occurred.',
    `prep_station_name` STRING COMMENT 'Name of the BOH prep station or work area (e.g., Butcher Station, Salad Prep, Grill Station).',
    `prep_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the food preparation activity was completed and yield was recorded.',
    `prep_type` STRING COMMENT 'Type of food preparation activity performed (e.g., butchering, portioning, cooking, trimming, peeling, deboning).. Valid values are `butchering|portioning|cooking|trimming|peeling|deboning`',
    `quality_grade` STRING COMMENT 'Quality grade assigned to the usable yield output (e.g., A for premium, B for standard, C for acceptable, reject for unusable).. Valid values are `A|B|C|reject`',
    `raw_quantity_in` DECIMAL(18,2) COMMENT 'Quantity of raw ingredient input into the preparation process.',
    `raw_unit_of_measure` STRING COMMENT 'Unit of measure for the raw ingredient quantity (e.g., lb, kg, oz, each, case).',
    `recipe_component_name` STRING COMMENT 'Name of the specific recipe component or prep task within the BOM (e.g., Trimmed Chicken Breast, Diced Onions).',
    `standard_yield_percentage` DECIMAL(18,2) COMMENT 'Standard or expected yield percentage defined in the recipe or BOM (Bill of Materials) for this prep task.',
    `temperature_at_prep_f` DECIMAL(18,2) COMMENT 'Temperature of the ingredient or environment at the time of preparation, in Fahrenheit. Relevant for HACCP monitoring.',
    `total_raw_cost` DECIMAL(18,2) COMMENT 'Total cost of the raw ingredient used in this prep activity (raw_quantity_in * cost_per_raw_unit).',
    `usable_yield_quantity_out` DECIMAL(18,2) COMMENT 'Quantity of usable output produced from the preparation process after waste removal.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Waste percentage calculated as (waste_quantity / raw_quantity_in) * 100. Key metric for COGS% (Cost of Goods Sold Percentage) optimization.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'Quantity of waste generated during the preparation process (trim, bones, spoilage, etc.).',
    `waste_reason_code` STRING COMMENT 'Code indicating the primary reason for waste (e.g., trim, spoilage, overcooking, contamination, quality issue).. Valid values are `trim|spoilage|overcooking|contamination|quality|other`',
    `waste_reason_description` STRING COMMENT 'Detailed description of the waste reason or circumstances.',
    `waste_unit_of_measure` STRING COMMENT 'Unit of measure for the waste quantity (e.g., lb, kg, oz).',
    `yield_record_status` STRING COMMENT 'Current status of the yield record in the review workflow (draft, verified, approved, rejected).. Valid values are `draft|verified|approved|rejected`',
    `yield_unit_of_measure` STRING COMMENT 'Unit of measure for the usable yield quantity (e.g., lb, kg, oz, portion, each).',
    `yield_variance_percentage` DECIMAL(18,2) COMMENT 'Variance between actual and standard yield percentage (actual_yield_percentage - standard_yield_percentage). Positive indicates better-than-expected yield; negative indicates yield loss.',
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Captures actual yield measurements from food preparation activities — the ratio of usable output to raw input for a given recipe component or prep task. Captures prep date, stock item (raw ingredient), prep type (butchering, portioning, cooking, trimming), raw quantity in, usable yield quantity out, waste quantity, yield percentage (actual vs. standard), prep station, and recorded-by employee. Supports yield management, BOM accuracy validation, and COGS% optimization by identifying yield gaps versus recipe standards.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` (
    `inventory_adjustment_id` BIGINT COMMENT 'Unique identifier for the inventory adjustment record. Primary key.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Adjustment entries need facility reference for GL posting and COGS allocation to the correct restaurant building.',
    `foodsafety_corrective_action_id` BIGINT COMMENT 'Foreign key linking to foodsafety.corrective_action. Business justification: Inventory adjustments may result from corrective actions issued after audits; the FK records the originating action.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Adjustments affect COGS and royalty calculations; franchisee‑level tracking is required for financial reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Ensures inventory adjustments affect the correct GL account for accurate COGS and inventory valuation.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or supervisor who reviewed and approved the inventory adjustment.',
    `receiving_order_id` BIGINT COMMENT 'Reference to the receiving transaction that this adjustment corrects, if the adjustment is a receiving correction.',
    `inventory_related_receiving_receiving_order_id` BIGINT COMMENT 'Reference to the receiving transaction that this adjustment corrects, if the adjustment is a receiving correction.',
    `stock_transfer_id` BIGINT COMMENT 'Reference to the inventory transfer transaction that this adjustment corrects, if the adjustment is a transfer correction.',
    `inventory_related_transfer_stock_transfer_id` BIGINT COMMENT 'Reference to the inventory transfer transaction that this adjustment corrects, if the adjustment is a transfer correction.',
    `primary_inventory_adjusted_by_employee_id` BIGINT COMMENT 'Reference to the employee who initiated and recorded the inventory adjustment transaction.',
    `physical_count_id` BIGINT COMMENT 'Reference to the physical inventory count record that triggered this adjustment, if the adjustment resulted from a count reconciliation.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the inventory adjustment occurred.',
    `reversal_adjustment_inventory_adjustment_id` BIGINT COMMENT 'Reference to the adjustment record that reversed this adjustment, if applicable.',
    `stock_item_id` BIGINT COMMENT 'Reference to the stock keeping unit (SKU) being adjusted.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in, dry storage, freezer) where the adjusted inventory is held.',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory adjusted, expressed in the stock items unit of measure. Positive values indicate increases to on-hand inventory; negative values indicate decreases.',
    `adjustment_date` DATE COMMENT 'The business date on which the inventory adjustment was recorded and applied to on-hand balances.',
    `adjustment_number` STRING COMMENT 'Externally-visible unique business identifier for the inventory adjustment transaction. Format: ADJ-YYYYMMDD-NNNNNN.. Valid values are `^ADJ-[0-9]{8}-[0-9]{6}$`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the inventory adjustment transaction was recorded in the system.',
    `adjustment_type` STRING COMMENT 'Classification of the inventory adjustment indicating the nature of the non-standard inventory movement (positive adjustment, negative adjustment, write-off, theft, breakage, spoilage, system correction, transfer correction, count reconciliation, damaged goods, expired product, vendor credit). [ENUM-REF-CANDIDATE: positive adjustment|negative adjustment|write-off|theft|breakage|spoilage|system correction|transfer correction|count reconciliation|damaged goods|expired product|vendor credit — 12 candidates stripped; promote to reference product]',
    `adjustment_value` DECIMAL(18,2) COMMENT 'The total monetary value of the inventory adjustment, calculated as adjusted quantity multiplied by unit cost. Positive values increase inventory asset value; negative values decrease it.',
    `approval_status` STRING COMMENT 'Current approval status of the inventory adjustment (pending, approved, rejected, auto-approved).. Valid values are `pending|approved|rejected|auto-approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the manager approved the inventory adjustment.',
    `approved_by_manager_name` STRING COMMENT 'Full name of the manager who approved the inventory adjustment, captured for audit trail purposes.',
    `batch_number` STRING COMMENT 'The batch or lot number of the stock item being adjusted, used for traceability and food safety compliance under Hazard Analysis Critical Control Points (HACCP).',
    `cost_center_code` STRING COMMENT 'The cost center code associated with the restaurant unit or department responsible for the inventory adjustment, used for Profit and Loss (P&L) allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjustment value (e.g., USD, CAD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'The expiration or best-by date of the stock item being adjusted, relevant for adjustments due to expired product removal.',
    `impacts_cogs` BOOLEAN COMMENT 'Indicates whether this inventory adjustment impacts the restaurant units Cost of Goods Sold (COGS) percentage calculation.',
    `is_reversed` BOOLEAN COMMENT 'Indicates whether this inventory adjustment has been reversed by a subsequent correcting adjustment.',
    `is_shrinkage` BOOLEAN COMMENT 'Indicates whether this adjustment represents inventory shrinkage (unexplained loss, theft, or discrepancy between physical count and system records).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory adjustment record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments providing context, details, or special instructions related to the inventory adjustment.',
    `on_hand_quantity_after` DECIMAL(18,2) COMMENT 'The on-hand inventory quantity for this stock item at this location immediately after the adjustment was applied.',
    `on_hand_quantity_before` DECIMAL(18,2) COMMENT 'The on-hand inventory quantity for this stock item at this location immediately before the adjustment was applied.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific business reason for the adjustment. [ENUM-REF-CANDIDATE: THEFT|DAMAGE|SPOIL|EXPIRE|RECOUNT|SYSCORR|XFERERR|VNDCRED|BREAK|SPILL|MISREC|OVERPOUR|PORTIONERR|TEMPFAIL|RECALL — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative providing detailed explanation of why the inventory adjustment was necessary.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether this adjustment type or value threshold requires manager approval before being applied to inventory balances.',
    `supporting_document_reference` STRING COMMENT 'Reference number or identifier for supporting documentation (e.g., incident report number, physical count sheet ID, vendor credit memo number, manager approval form) that justifies the adjustment.',
    `temperature_at_adjustment_f` DECIMAL(18,2) COMMENT 'The recorded storage temperature in Fahrenheit at the time of adjustment, relevant for temperature-related spoilage or HACCP compliance documentation.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the stock item at the time of adjustment, used to calculate the total adjustment value.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the adjusted quantity is expressed (each, case, pound, kilogram, ounce, liter, gallon, box, bag, pallet). [ENUM-REF-CANDIDATE: each|case|pound|kilogram|ounce|liter|gallon|box|bag|pallet — 10 candidates stripped; promote to reference product]',
    `waste_category` STRING COMMENT 'Classification of waste type for adjustments related to inventory loss, used for waste percentage (Waste%) tracking and analysis (operational waste, spoilage, theft, damage, other).. Valid values are `operational waste|spoilage|theft|damage|other`',
    CONSTRAINT pk_inventory_adjustment PRIMARY KEY(`inventory_adjustment_id`)
) COMMENT 'Records manual adjustments to on-hand inventory balances outside of standard receiving, waste, or count workflows. Captures adjustment date, adjustment type (positive adjustment, negative adjustment, write-off, theft, breakage, system correction), stock item reference, storage location, adjusted quantity, adjustment value ($), reason code, supporting document reference, adjusted-by employee, and manager approval. Provides a complete audit trail for all non-standard inventory movements and supports shrinkage analysis.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` (
    `food_cost_period_id` BIGINT COMMENT 'Unique identifier for the food cost period record. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Food‑cost period calculations consider campaign impact on COGS; linking provides the necessary data for cost‑impact reports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links periodic food‑cost calculations to cost centers for departmental profitability reporting.',
    `financial_period_id` BIGINT COMMENT 'add column financial_period_id (BIGINT) with FK to finance.financial_period.financial_period_id - food cost periods should align with financial periods for P&L reconciliation',
    `employee_id` BIGINT COMMENT 'Identifier of the user who reviewed and approved this food cost period record. Typically a district manager, area director, or finance controller.',
    `food_employee_id` BIGINT COMMENT 'Identifier of the user who closed and finalized this food cost period. Typically a restaurant manager or accounting staff member.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Food‑cost period statements are aggregated per franchisee for royalty and performance scorecards.',
    `primary_food_employee_id` BIGINT COMMENT 'Identifier of the user who closed and finalized this food cost period. Typically a restaurant manager or accounting staff member.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit for which this food cost period is calculated. Links to the specific restaurant location.',
    `actual_food_cost` DECIMAL(18,2) COMMENT 'The actual Cost of Goods Sold (COGS) for the period, calculated as: Opening Inventory + Purchases + Transfers In - Transfers Out - Closing Inventory. The real food cost incurred.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any manual adjustments applied to the food cost calculation for the period, such as corrections for inventory errors, vendor credits, or accounting reclassifications. Positive or negative value.',
    `adjustment_reason` STRING COMMENT 'Explanation for any manual adjustment applied to the food cost calculation. Provides audit trail and justification for period adjustments.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this food cost period was reviewed and approved by management. Indicates final sign-off on the period results.',
    `beverage_sales_revenue` DECIMAL(18,2) COMMENT 'The total beverage sales revenue for the period. Tracked separately from food sales for category-specific cost analysis.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this food cost period was officially closed and calculations were finalized. Marks the completion of the period-close process.',
    `closing_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of food inventory on hand at the end of the period, determined by physical count or perpetual inventory system. Represents the ending stock value for COGS calculation.',
    `cogs_percent_actual` DECIMAL(18,2) COMMENT 'The actual food cost as a percentage of food sales revenue for the period. Key performance metric for restaurant profitability and cost control. Calculated as (Actual Food Cost / Food Sales Revenue) * 100.',
    `cogs_percent_theoretical` DECIMAL(18,2) COMMENT 'The theoretical food cost as a percentage of food sales revenue for the period. Represents the ideal COGS% if all operational standards were met. Calculated as (Theoretical Food Cost / Food Sales Revenue) * 100.',
    `count_method` STRING COMMENT 'The method used to determine closing inventory value: physical (manual count), perpetual (system-tracked), or hybrid (system with periodic physical verification).. Valid values are `physical|perpetual|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this food cost period record was first created in the system. Marks the initiation of the period tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this record (e.g., USD, EUR, GBP). Supports multi-currency operations for international restaurant chains.. Valid values are `^[A-Z]{3}$`',
    `food_sales_revenue` DECIMAL(18,2) COMMENT 'The total food sales revenue (excluding beverage) for the period. Used as the denominator in COGS% calculations. Sourced from Point of Sale (POS) system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this food cost period record was last updated. Tracks the most recent change to any field in the record.',
    `notes` STRING COMMENT 'Free-text notes or comments about this food cost period, such as unusual events, operational issues, inventory discrepancies, or explanations for variance. Used for management review and audit purposes.',
    `opening_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of food inventory on hand at the beginning of the period. Represents the starting stock value for Cost of Goods Sold (COGS) calculation.',
    `period_end_date` DATE COMMENT 'The last date of the accounting period for which food costs are being calculated. Marks the close of the cost accumulation window.',
    `period_number` STRING COMMENT 'The accounting period identifier in format YYYY-PNN (e.g., 2024-P01 for period 1 of 2024). Used for financial reporting alignment.. Valid values are `^[0-9]{4}-P[0-9]{2}$`',
    `period_start_date` DATE COMMENT 'The first date of the accounting period for which food costs are being calculated. Marks the beginning of the cost accumulation window.',
    `period_status` STRING COMMENT 'The current status of the food cost period: open (still accepting transactions), closed (period ended, calculations complete), locked (finalized, no further changes allowed), or under_review (being audited or reviewed).. Valid values are `open|closed|locked|under_review`',
    `period_type` STRING COMMENT 'The frequency type of the accounting period for food cost calculation (weekly, bi-weekly, monthly, or quarterly).. Valid values are `weekly|bi-weekly|monthly|quarterly`',
    `physical_count_date` DATE COMMENT 'The date on which the physical inventory count was performed to determine closing inventory value. Typically the last day of the period or the first day of the next period.',
    `purchases_value` DECIMAL(18,2) COMMENT 'The total dollar value of all food and beverage purchases received during the period. Includes all vendor invoices posted to inventory during the period.',
    `theoretical_food_cost` DECIMAL(18,2) COMMENT 'The calculated ideal food cost based on recipe costing and actual sales mix (PMIX). Represents what food cost should have been if all recipes were followed perfectly with no waste or theft.',
    `total_sales_revenue` DECIMAL(18,2) COMMENT 'The combined food and beverage sales revenue for the period. Represents total top-line revenue for the restaurant unit during the period.',
    `transfers_in_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory transferred into this restaurant unit from other locations during the period. Increases available inventory.',
    `transfers_out_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory transferred out of this restaurant unit to other locations during the period. Decreases available inventory.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The dollar difference between actual food cost and theoretical food cost (Actual - Theoretical). Positive variance indicates higher-than-expected costs due to waste, theft, portioning errors, or recipe non-compliance.',
    `variance_percent` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of theoretical food cost. Calculated as (Variance Amount / Theoretical Food Cost) * 100. Used to assess the magnitude of cost control issues.',
    `waste_percent` DECIMAL(18,2) COMMENT 'The waste value as a percentage of total food usage (Waste Value / (Actual Food Cost + Waste Value)) * 100. Key metric for food quality control and operational efficiency.',
    `waste_value` DECIMAL(18,2) COMMENT 'The total dollar value of food waste recorded during the period, including spoilage, expiration, preparation errors, and quality control discards. Tracked for Waste% calculation and food cost control.',
    CONSTRAINT pk_food_cost_period PRIMARY KEY(`food_cost_period_id`)
) COMMENT 'Period-level food cost summary record for each restaurant unit, capturing the calculated COGS% for a defined accounting period (weekly, bi-weekly, monthly). Captures period start date, period end date, opening inventory value ($), purchases value ($), transfers-in value ($), transfers-out value ($), waste value ($), closing inventory value ($), theoretical food cost ($), actual food cost ($), COGS% actual, COGS% theoretical, variance ($), and variance percentage. The operational food cost control record — NOT an analytics aggregate but the posted period-close record used by restaurant managers and finance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`uom` (
    `uom_id` BIGINT COMMENT 'Unique identifier for the unit of measure. Primary key.',
    `base_uom_id` BIGINT COMMENT 'Reference to the base UOM for this measurement type. Used to establish conversion chains. Null if this UOM is itself the base unit.',
    `abbreviation` STRING COMMENT 'Short form or symbol for the UOM (e.g., lb, oz, gal, kg, g, ml). Used in compact displays, labels, and Kitchen Display System (KDS) screens.',
    `allows_fractional_quantities` BOOLEAN COMMENT 'Indicates whether fractional quantities are permitted for this UOM (e.g., 2.5 pounds allowed, but 2.5 cases may not be). Enforces business rules in inventory transactions and recipe scaling.',
    `allows_temperature_tracking` BOOLEAN COMMENT 'Indicates whether items measured in this UOM require Hazard Analysis Critical Control Points (HACCP) temperature monitoring during storage and transfer. Supports food safety compliance per Food and Drug Administration (FDA) regulations.',
    `applicable_item_categories` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) categories or commodity types where this UOM is applicable (e.g., dry goods, produce, dairy, beverages, proteins). Supports context-aware UOM selection in ordering and recipe management.',
    `uom_category` STRING COMMENT 'Measurement system category (metric, imperial, count-based, or custom). Supports multi-region operations with different measurement standards.. Valid values are `metric|imperial|count|custom`',
    `uom_code` STRING COMMENT 'Short alphanumeric code representing the unit of measure (e.g., EA, CS, LB, OZ, GAL, KG, G, ML, L). Used as the business identifier in inventory transactions and recipe management.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `conversion_factor_to_base` DECIMAL(18,2) COMMENT 'Multiplier to convert this UOM to the base UOM (e.g., 1 pound = 453.592 grams, so conversion_factor_to_base = 453.592). Critical for accurate Cost of Goods Sold (COGS%) calculation and yield management across ordering, storage, and recipe contexts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this UOM record was first created in the system. Supports audit trails and data lineage tracking per Generally Accepted Accounting Principles (GAAP) requirements.',
    `default_shelf_life_days` STRING COMMENT 'Default shelf life in days for items measured in this UOM. Used as a fallback when Stock Keeping Unit (SKU)-specific shelf life is not defined. Supports waste tracking (Waste%) and First In First Out (FIFO) rotation.',
    `display_sequence` STRING COMMENT 'Sort order for displaying UOMs in user interfaces and dropdown lists. Lower numbers appear first. Supports user experience optimization in Point of Sale (POS) and inventory management systems.',
    `effective_end_date` DATE COMMENT 'Date when this UOM was retired or deprecated. Null for currently active UOMs. Supports historical reporting and audit trails for Cost of Goods Sold (COGS%) analysis.',
    `effective_start_date` DATE COMMENT 'Date when this UOM became available for use in inventory transactions. Supports temporal validity and historical analysis of UOM changes.',
    `is_base_uom` BOOLEAN COMMENT 'Indicates whether this UOM is the base unit for its type (e.g., gram for weight, milliliter for volume). Base UOMs have a conversion factor of 1.0 and serve as the reference for all conversions within their type.',
    `is_system_standard` BOOLEAN COMMENT 'Indicates whether this UOM is a system-defined standard (e.g., gram, liter, each) that cannot be modified or deleted by users. Protects core reference data integrity.',
    `iso_code` STRING COMMENT 'ISO 80000 standard code for the unit of measure. Supports international operations and regulatory compliance across multiple jurisdictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this UOM record was last updated. Supports change tracking and data governance for Cost of Goods Sold (COGS%) accuracy and regulatory compliance.',
    `uom_name` STRING COMMENT 'Full descriptive name of the unit of measure (e.g., Each, Case, Pound, Ounce, Gallon, Kilogram, Gram, Milliliter, Liter). Human-readable label for reporting and user interfaces.',
    `notes` STRING COMMENT 'Free-text field for additional context, usage guidelines, or special handling instructions for this UOM. Supports operational documentation and training materials.',
    `ordering_uom_flag` BOOLEAN COMMENT 'Indicates whether this UOM is used in purchase orders and vendor ordering (e.g., case, pallet). Supports procurement workflows and vendor catalog integration.',
    `plural_name` STRING COMMENT 'Plural form of the UOM name (e.g., Pounds, Ounces, Cases). Supports grammatically correct reporting and user interface text generation.',
    `precision_decimal_places` STRING COMMENT 'Number of decimal places to use when displaying or calculating quantities in this UOM. Ensures consistent rounding and precision across inventory transactions.',
    `recipe_uom_flag` BOOLEAN COMMENT 'Indicates whether this UOM is used in recipe Bill of Materials (BOM) and menu item costing (e.g., ounce, gram, tablespoon). Critical for accurate recipe yield management and menu engineering.',
    `requires_lot_tracking` BOOLEAN COMMENT 'Indicates whether items measured in this UOM require lot number and expiration date tracking for traceability. Supports food safety recalls and Good Manufacturing Practice (GMP) compliance.',
    `storage_uom_flag` BOOLEAN COMMENT 'Indicates whether this UOM is used for Back of House (BOH) inventory storage and stock tracking (e.g., each, bag, box). Supports Periodic Automatic Replenishment (PAR) level management and cycle counts.',
    `symbol` STRING COMMENT 'Standard international symbol for the UOM (e.g., °F, °C, %, #). Used in scientific and regulatory contexts, particularly for Hazard Analysis Critical Control Points (HACCP) temperature monitoring.',
    `un_cefact_code` STRING COMMENT 'Standardized UN/CEFACT Recommendation 20 code for the unit of measure. Supports Electronic Data Interchange (EDI) integration with suppliers and third-party logistics providers.. Valid values are `^[A-Z0-9]{2,3}$`',
    `uom_status` STRING COMMENT 'Current lifecycle status of the UOM. Active UOMs are available for use in transactions; deprecated UOMs are retained for historical data but not available for new transactions.. Valid values are `active|inactive|deprecated|pending`',
    `uom_type` STRING COMMENT 'Classification of the unit of measure by dimension type. Determines conversion logic and applicability to different inventory contexts (receiving, storage, recipe). [ENUM-REF-CANDIDATE: weight|volume|count|length|area|temperature|time — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_uom PRIMARY KEY(`uom_id`)
) COMMENT 'Reference master for all units of measure used in inventory transactions — ordering UOM, storage UOM, and recipe UOM — plus their conversion factors. Captures UOM code, UOM name, UOM type (weight/volume/count/length), base UOM flag, and applicable item categories. Conversion detail: from-UOM, to-UOM, stock-item-specific overrides (item-specific conversions override global defaults), conversion factor, effective date, and source (vendor spec/lab measurement/standard). Supports accurate translation between ordering (case of 6), storage (each), and recipe (ounce/gram) contexts — critical for inventory valuation and COGS% calculation across all restaurant units.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` (
    `vendor_item_id` BIGINT COMMENT 'Unique identifier for the vendor item mapping record. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maps vendor items to expense GL accounts for automated AP posting and cost tracking.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier that provides this stock item. Links to the procurement domains supplier master.',
    `procurement_supplier_id` BIGINT COMMENT 'Reference to the supplier that provides this stock item. Links to the procurement domains supplier master.',
    `stock_item_id` BIGINT COMMENT 'Reference to the stock item (SKU) in the inventory master that this vendor supplies.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: REQUIRED: Procurement audit needs to know which supplier contract governs each vendor‑supplied item for pricing and compliance.',
    `activation_date` DATE COMMENT 'The date when this vendor item mapping became active and available for ordering.',
    `contract_effective_date` DATE COMMENT 'The date when the contract pricing becomes effective for this vendor item.',
    `contract_expiration_date` DATE COMMENT 'The date when the contract pricing expires for this vendor item.',
    `contract_number` STRING COMMENT 'Reference number of the procurement contract governing this vendor item pricing, if applicable.',
    `contract_price_flag` BOOLEAN COMMENT 'Indicates whether the unit cost is based on a negotiated contract (True) or spot pricing (False).',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. [ENUM-REF-CANDIDATE: USD|CAD|EUR|GBP|MXN|AUD|JPY|CNY — 8 candidates stripped; promote to reference product]',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where this item is produced or sourced by the vendor. [ENUM-REF-CANDIDATE: USA|CAN|MEX|CHN|BRA|ARG|AUS|NZL|GBR|FRA|DEU|ITA|ESP|JPN|KOR|THA|VNM|IND — 18 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor item mapping record was first created in the system.',
    `deactivation_date` DATE COMMENT 'The date when this vendor item mapping was deactivated or discontinued, if applicable.',
    `deactivation_reason` STRING COMMENT 'Business reason for deactivating this vendor item mapping (e.g., vendor discontinued, better pricing found, quality issues).',
    `vendor_item_description` STRING COMMENT 'Detailed description of the item from the vendors catalog, including specifications, grade, or quality attributes.',
    `gtin` STRING COMMENT 'The vendors GTIN/UPC/EAN barcode for this item, used for receiving and inventory tracking.',
    `last_cost_update_date` DATE COMMENT 'The date when the unit cost for this vendor item was last updated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor item mapping record was most recently updated.',
    `last_order_date` DATE COMMENT 'The most recent date when this item was ordered from this vendor.',
    `last_received_date` DATE COMMENT 'The most recent date when this item was received from this vendor.',
    `lead_time_days` STRING COMMENT 'The number of days between order placement and expected delivery from this vendor for this item.',
    `manufacturer_name` STRING COMMENT 'The name of the actual manufacturer of this item, which may differ from the vendor/distributor.',
    `manufacturer_part_number` STRING COMMENT 'The manufacturers unique part or item number for this product.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity (in order UOM) that must be ordered from this vendor for this item.',
    `vendor_item_name` STRING COMMENT 'The suppliers product name or description for this item as it appears in their catalog.',
    `next_cost_review_date` DATE COMMENT 'The scheduled date for the next cost review or renegotiation with this vendor for this item.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special handling instructions, or vendor-specific requirements for this item.',
    `on_time_delivery_percent` DECIMAL(18,2) COMMENT 'Percentage of orders for this vendor item that were delivered within the promised lead time window.',
    `order_increment` DECIMAL(18,2) COMMENT 'The quantity increment (in order UOM) in which this item must be ordered (e.g., must order in multiples of 5).',
    `order_uom` STRING COMMENT 'The unit of measure used when ordering this item from the vendor (e.g., case, pound, gallon). [ENUM-REF-CANDIDATE: EA|CS|LB|KG|GAL|LTR|OZ|BOX|BAG|CASE|PALLET|EACH — 12 candidates stripped; promote to reference product]',
    `pack_quantity` DECIMAL(18,2) COMMENT 'The number of individual packs or units contained in one order UOM (e.g., 12 cans per case, 4 bags per box).',
    `pack_size` STRING COMMENT 'The size or weight of each individual pack or unit within the order UOM (e.g., 5 LB, 12 OZ, 1 GAL).',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred supplier for this stock item (True) or an alternate source (False).',
    `quality_rating` DECIMAL(18,2) COMMENT 'Quality score for this vendors supply of this item, typically on a scale of 0.00 to 5.00, based on receiving inspections and quality audits.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The current cost per order UOM from this vendor. Used for purchase order generation and COGS calculation.',
    `vendor_brand_name` STRING COMMENT 'The brand name under which the vendor supplies this item, if applicable.',
    `vendor_item_status` STRING COMMENT 'Current status of this vendor item mapping in the system lifecycle.. Valid values are `active|inactive|discontinued|pending|suspended`',
    `vendor_priority_rank` STRING COMMENT 'Numeric ranking of this vendor for this item when multiple vendors supply the same SKU (1=first choice, 2=second choice, etc.).',
    `vendor_product_category` STRING COMMENT 'The vendors classification or category for this item in their catalog structure.',
    `vendor_sku` STRING COMMENT 'The suppliers unique item code or SKU for this product. Used in purchase orders and receiving documents.',
    CONSTRAINT pk_vendor_item PRIMARY KEY(`vendor_item_id`)
) COMMENT 'Maps each stock item to the supplier(s) that provide it, capturing the supplier-specific item details used in ordering and receiving. Captures supplier reference, stock item reference, supplier item code (vendor SKU), supplier item description, order UOM, pack size, pack quantity, current unit cost, contract price flag, lead time days, minimum order quantity, preferred vendor flag, and active status. Enables multi-vendor sourcing for critical items and supports cost comparison and replenishment order generation. Distinct from the procurement domains supplier master — this is the inventory-domain view of what each vendor supplies.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` (
    `lot_tracking_id` BIGINT COMMENT 'Unique identifier for the lot tracking record. Primary key for traceability of inventory items requiring lot-level tracking per HACCP and FDA requirements.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Lot traceability per facility is required for recall management and compliance with local health regulations.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: REQUIRED: Full traceability for recalls and HACCP requires linking lot tracking records to the master ingredient lot entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who physically received and logged this lot into inventory. Establishes accountability for receiving procedures.',
    `procurement_supplier_id` BIGINT COMMENT 'Reference to the supplier who provided this lot. Critical for recall response and supplier quality tracking.',
    `receiving_order_id` BIGINT COMMENT 'Reference to the receiving order through which this lot was received into inventory. Establishes chain of custody for traceability.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this lot is stored. Enables location-specific recall response and FIFO/FEFO rotation management.',
    `stock_item_id` BIGINT COMMENT 'Reference to the stock item (SKU) being tracked. Links to the master inventory item requiring lot-level traceability.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (cooler, freezer, dry storage) where this lot is currently stored. Enables temperature zone compliance and physical inventory management.',
    `allergen_eggs` BOOLEAN COMMENT 'Indicates whether this lot contains eggs or egg derivatives. Required for allergen traceability and customer safety.',
    `allergen_fish` BOOLEAN COMMENT 'Indicates whether this lot contains fish or fish derivatives. Required for allergen traceability and customer safety.',
    `allergen_milk` BOOLEAN COMMENT 'Indicates whether this lot contains milk or milk derivatives. Required for allergen traceability and customer safety.',
    `allergen_peanuts` BOOLEAN COMMENT 'Indicates whether this lot contains peanuts or peanut derivatives. Required for allergen traceability and customer safety.',
    `allergen_shellfish` BOOLEAN COMMENT 'Indicates whether this lot contains shellfish or shellfish derivatives. Required for allergen traceability and customer safety.',
    `allergen_soybeans` BOOLEAN COMMENT 'Indicates whether this lot contains soybeans or soy derivatives. Required for allergen traceability and customer safety.',
    `allergen_tree_nuts` BOOLEAN COMMENT 'Indicates whether this lot contains tree nuts or tree nut derivatives. Required for allergen traceability and customer safety.',
    `allergen_wheat` BOOLEAN COMMENT 'Indicates whether this lot contains wheat or wheat derivatives. Required for allergen traceability and customer safety.',
    `best_by_date` DATE COMMENT 'Date by which product quality is optimal. Distinct from expiration date; used for quality management and customer satisfaction.',
    `condition_at_receiving` STRING COMMENT 'Assessment of lot condition when received. Documents any quality issues or deviations requiring corrective action.. Valid values are `acceptable|damaged|short_dated|temperature_deviation|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot tracking record was first created in the system. Audit trail for data lineage and compliance reporting.',
    `expiration_date` DATE COMMENT 'Date after which this lot should not be used or sold. Drives FEFO (First Expired First Out) rotation and waste prevention.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot tracking record was last updated. Tracks changes to quantity remaining, status, or other attributes for audit purposes.',
    `lot_code` STRING COMMENT 'Alternative or supplementary lot code used by supplier or manufacturer. May include production facility codes or batch identifiers.',
    `lot_number` STRING COMMENT 'Manufacturer or supplier assigned lot number for this batch of product. Primary traceability identifier required by FDA for recall response and HACCP compliance.',
    `lot_status` STRING COMMENT 'Current lifecycle status of this lot. Controls whether lot can be used in production and triggers workflow actions for recalls or quality holds.. Valid values are `available|quarantined|recalled|expired|depleted|rejected`',
    `manufacture_date` DATE COMMENT 'Date when this lot was manufactured or produced by the supplier. Critical for shelf life calculation and quality assurance.',
    `notes` STRING COMMENT 'Free-form notes capturing additional lot information, quality observations, or special handling instructions. Supports audit trail and operational communication.',
    `quality_grade` STRING COMMENT 'Quality grade assigned to this lot at receiving. Used for yield management and menu item assignment decisions.. Valid values are `A|B|C|premium|standard|economy`',
    `quantity_received` DECIMAL(18,2) COMMENT 'Original quantity of this lot received into inventory. Baseline for tracking consumption and remaining quantity.',
    `quantity_remaining` DECIMAL(18,2) COMMENT 'Current quantity of this lot still in inventory. Updated as lot is consumed through production or transferred. Enables real-time lot depletion tracking.',
    `quarantine_date` DATE COMMENT 'Date when lot was placed on quarantine hold. Starts clock for resolution and disposition decision.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether this lot is quarantined pending quality review or investigation. Prevents use in production until released.',
    `quarantine_reason` STRING COMMENT 'Reason for quarantine hold (e.g., temperature deviation, quality defect, documentation issue). Drives corrective action workflow.',
    `recall_date` DATE COMMENT 'Date when recall was initiated for this lot. Triggers immediate quarantine and customer notification procedures.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this lot is subject to an active recall. When true, lot must be quarantined and reported per FDA recall procedures.',
    `recall_reason` STRING COMMENT 'Description of the reason for recall (e.g., allergen contamination, pathogen detection, foreign material). Critical for risk assessment and customer communication.',
    `received_date` DATE COMMENT 'Date when this lot was physically received into the restaurant unit. Used for FIFO/FEFO rotation and shelf life calculations.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this lot was received and logged into inventory. Provides audit trail for time-sensitive traceability requirements.',
    `temperature_at_receiving_f` DECIMAL(18,2) COMMENT 'Product temperature measured at time of receiving. HACCP critical control point for verifying cold chain integrity.',
    `temperature_zone` STRING COMMENT 'Temperature control zone where this lot must be stored. Critical for food safety compliance and HACCP monitoring.. Valid values are `frozen|refrigerated|ambient|hot_hold`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities in this lot record. Standardized across receiving and inventory tracking. [ENUM-REF-CANDIDATE: EA|LB|KG|OZ|GAL|L|CS|BX|PK|DZ — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_lot_tracking PRIMARY KEY(`lot_tracking_id`)
) COMMENT 'Tracks lot numbers and expiration dates for received inventory items requiring traceability — particularly proteins, produce, dairy, and allergen-containing items. Captures lot number, stock item reference, supplier reference, receiving order reference, received date, manufacture date, expiration date, quantity received, quantity remaining, storage location, recall flag, and quarantine status. Supports HACCP traceability requirements, FDA recall response, and FIFO/FEFO rotation compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` (
    `prep_usage_id` BIGINT COMMENT 'Unique identifier for the prep usage record. Primary key for the prep usage transaction.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Prep usage data is allocated to franchisees for labor and ingredient cost attribution.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the prep usage transaction. Supports accountability and audit trails.',
    `recipe_id` BIGINT COMMENT 'Identifier of the recipe or BOM (Bill of Materials) that defines the theoretical ingredient usage. Links to the menu domain recipe master.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the prep activity occurred. Links to the restaurant operations domain.',
    `stock_item_id` BIGINT COMMENT 'Identifier of the raw ingredient or stock item consumed during prep. Links to the inventory stock item master.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The total dollar cost of the actual quantity used (actual_quantity_used multiplied by unit_cost). Contributes to actual COGS% (Cost of Goods Sold Percentage).',
    `actual_quantity_used` DECIMAL(18,2) COMMENT 'The actual quantity of the ingredient consumed during prep, as recorded by the BOH (Back of House) team. This is the real-world usage that depletes inventory.',
    `batch_number` STRING COMMENT 'The internal batch or production run number assigned to the prep output. Links multiple ingredient pulls to a single production batch.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this prep usage record was first created in the system. Supports audit trails and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this record. Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'The expiration or best-by date of the ingredient lot consumed. Ensures FIFO (First In First Out) compliance and food safety.',
    `haccp_compliant` BOOLEAN COMMENT 'Indicates whether the prep activity met HACCP (Hazard Analysis Critical Control Points) temperature and handling requirements. True if compliant, False if not.',
    `item_description` STRING COMMENT 'The description of the stock item consumed. Denormalized to preserve historical context even if the item master changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this prep usage record was last updated. Supports change tracking and audit compliance.',
    `lot_number` STRING COMMENT 'The lot or batch number of the ingredient consumed. Critical for traceability and food safety compliance under HACCP (Hazard Analysis Critical Control Points).',
    `notes` STRING COMMENT 'Free-text notes or comments about the prep usage transaction. Captures contextual information for variance investigation or operational insights.',
    `prep_date` DATE COMMENT 'The calendar date on which the prep activity occurred. Used for daily food cost tracking and COGS% (Cost of Goods Sold Percentage) analysis.',
    `prep_station_code` STRING COMMENT 'The code identifying the BOH (Back of House) prep station where the ingredient was consumed. Examples include grill, fry, salad, bakery, or assembly.',
    `prep_station_name` STRING COMMENT 'The human-readable name of the prep station. Provides context for operational reporting and training.',
    `prep_task_reference` STRING COMMENT 'Reference code or identifier for the specific prep task or production batch. Used to group related ingredient pulls for a single prep activity.',
    `prep_timestamp` TIMESTAMP COMMENT 'The precise date and time when the prep activity was performed. Enables shift-level and intra-day analysis of BOH (Back of House) production.',
    `prep_type` STRING COMMENT 'The type or purpose of the prep activity. Distinguishes between batch production, made-to-order, PAR (Periodic Automatic Replenishment) level restocking, and other prep scenarios.. Valid values are `batch|made_to_order|par_replenishment|catering|special_event|waste_recovery`',
    `prep_usage_status` STRING COMMENT 'The current lifecycle status of the prep usage record. Supports workflow management and data quality controls.. Valid values are `draft|recorded|verified|posted|voided`',
    `quality_grade` STRING COMMENT 'The quality grade assigned to the prep output. Used to track prep quality and identify training or process improvement needs.. Valid values are `A|B|C|reject`',
    `shift_code` STRING COMMENT 'The operational shift during which the prep activity occurred. Supports labor and production efficiency analysis by daypart. [ENUM-REF-CANDIDATE: opening|morning|lunch|afternoon|dinner|closing|overnight — 7 candidates stripped; promote to reference product]',
    `sku_code` STRING COMMENT 'The SKU (Stock Keeping Unit) code of the ingredient consumed. Denormalized for reporting convenience and historical accuracy.',
    `temperature_at_prep_f` DECIMAL(18,2) COMMENT 'The temperature in Fahrenheit at which the ingredient was stored or handled during prep. Critical for HACCP (Hazard Analysis Critical Control Points) compliance.',
    `theoretical_cost` DECIMAL(18,2) COMMENT 'The total dollar cost of the theoretical quantity (theoretical_quantity multiplied by unit_cost). Used for theoretical COGS% calculation.',
    `theoretical_quantity` DECIMAL(18,2) COMMENT 'The theoretical quantity of the ingredient that should have been used according to the recipe or BOM (Bill of Materials). Used for variance analysis.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of measure for the ingredient at the time of prep. Used to calculate the dollar value of usage and variance.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity used. Examples include lb, kg, oz, gal, L, ea (each), case, or portion.',
    `variance_cost` DECIMAL(18,2) COMMENT 'The dollar value of the variance (actual_cost minus theoretical_cost). Quantifies the financial impact of over- or under-usage.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance quantity expressed as a percentage of the theoretical quantity. Enables standardized comparison across different ingredients and recipes.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between actual and theoretical quantity used (actual minus theoretical). Positive values indicate over-usage; negative values indicate under-usage.',
    `waste_reason_code` STRING COMMENT 'Code indicating the reason for any waste or over-usage. Used to categorize and analyze sources of food waste and variance. [ENUM-REF-CANDIDATE: none|spillage|over_prep|quality_issue|expiration|contamination|equipment_failure|training_error — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_prep_usage PRIMARY KEY(`prep_usage_id`)
) COMMENT 'Records the consumption of raw ingredients during BOH food preparation activities — the actual ingredient usage pulled from inventory to fulfill prep tasks and production schedules. Captures prep date, shift, station, stock item consumed, quantity used, unit of measure, theoretical usage (from BOM/recipe), actual usage, variance quantity, variance value ($), prep task reference, and recorded-by employee. Bridges inventory depletion with recipe/BOM standards from the menu domain, enabling theoretical vs. actual COGS% comparison.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`item_category` (
    `item_category_id` BIGINT COMMENT 'Unique identifier for the item category. Primary key for the item category reference taxonomy.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the last review.',
    `category_id` BIGINT COMMENT 'Reference to the parent category in the hierarchical taxonomy. Null for top-level categories. Enables drill-down reporting from major groups to item classes.',
    `parent_item_category_id` BIGINT COMMENT 'Self-referencing FK on item_category (parent_item_category_id)',
    `primary_item_employee_id` BIGINT COMMENT 'Identifier of the user who created this category record. Used for audit trail and data governance.',
    `activation_date` DATE COMMENT 'Date when this category was activated and became available for use. Used for historical analysis and category lifecycle tracking.',
    `allergen_category` BOOLEAN COMMENT 'Indicates whether this category contains items that are major food allergens or allergen-containing ingredients per FDA regulations. Used for allergen management and menu labeling compliance.',
    `category_description` STRING COMMENT 'Detailed description of the category scope, including what types of items are classified under this category and any special handling or procurement considerations.',
    `category_level` STRING COMMENT 'Hierarchical level of the category within the taxonomy. 1=major group (e.g., Food, Beverage, Non-Food), 2=sub-group (e.g., Protein, Produce), 3=item class (e.g., Beef, Fresh Vegetables).',
    `category_type` STRING COMMENT 'High‑level classification of the category for analytics and cost allocation.. Valid values are `food|beverage|non_food|supply|equipment`',
    `cogs_budget_target_pct` DECIMAL(18,2) COMMENT 'Target COGS percentage for this category as a percentage of revenue. Used for food cost control, variance analysis, and P&L forecasting. Example: 28.50 represents 28.50% target COGS.',
    `commodity_type` STRING COMMENT 'Storage and handling classification for items in this category. Drives warehouse zoning, PAR level calculations, and waste tracking strategies.. Valid values are `perishable|non-perishable|frozen|refrigerated|dry|ambient`',
    `cost_center_code` STRING COMMENT 'Default cost center code for expense allocation for items in this category. Used for departmental cost tracking and variance analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this category record was first created in the system. Used for audit trail and data lineage tracking.',
    `cycle_count_frequency_days` STRING COMMENT 'Standard frequency in days for cycle counting items in this category. High-value or high-risk categories have shorter frequencies. Used for inventory accuracy programs.',
    `deactivation_date` DATE COMMENT 'Date when this category was deactivated and removed from active use. Null for active categories. Used for historical reporting and compliance.',
    `deactivation_reason` STRING COMMENT 'Business reason for deactivating this category. Examples: consolidated into another category, no longer used, taxonomy restructure. Null for active categories.',
    `default_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage applied to items in this category.',
    `default_par_level_days` STRING COMMENT 'Standard PAR level in days of inventory for items in this category. Used to calculate reorder points and optimize stock levels. Varies by commodity type and lead time.',
    `default_par_quantity` DECIMAL(18,2) COMMENT 'Typical periodic automatic replenishment quantity for the category.',
    `default_shelf_life_days` STRING COMMENT 'Standard shelf life in days for items in this category. Used as default for new item setup and for automated expiration date calculations. Null for non-perishable categories.',
    `default_tax_rate_percent` DECIMAL(18,2) COMMENT 'Standard sales tax rate applicable to the category.',
    `default_unit_of_measure` STRING COMMENT 'Standard unit of measure for items in this category. Examples: LB (pounds), EA (each), CS (case), GAL (gallon), KG (kilogram). Used as default for new item setup.. Valid values are `^[A-Z]{2,4}$`',
    `default_waste_percent` DECIMAL(18,2) COMMENT 'Expected waste percentage for the category used in cost modeling.',
    `item_category_description` STRING COMMENT 'Detailed textual description of the category purpose and scope.',
    `division` STRING COMMENT 'Top-level division to which this category belongs. Used for high-level financial reporting and procurement segmentation.. Valid values are `food|beverage|packaging|non-food|supplies|equipment`',
    `effective_from` DATE COMMENT 'Date when the category becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the category is retired; null if still active.',
    `gl_account_code` STRING COMMENT 'Default GL account code for COGS postings for items in this category. Used for automated financial posting and P&L reporting integration with SAP S/4HANA.. Valid values are `^[0-9]{4,10}$`',
    `haccp_required` BOOLEAN COMMENT 'Indicates whether HACCP monitoring is mandatory for items in this category.',
    `hierarchy_level` STRING COMMENT 'Depth of the category in the hierarchy (root = 0).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this category is currently active and available for use. Inactive categories are retained for historical reporting but cannot be assigned to new items.',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether items in this category are perishable and require temperature control.',
    `item_category_status` STRING COMMENT 'Current lifecycle status of the category.. Valid values are `active|inactive|deprecated|pending`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this category record was last modified. Used for audit trail, change tracking, and incremental data processing.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent governance review of the category definition.',
    `multi_sourcing_allowed` BOOLEAN COMMENT 'Indicates whether items in this category can be sourced from multiple vendors. False for categories requiring single-source consistency (e.g., branded ingredients, proprietary items).',
    `notes` STRING COMMENT 'Free-form notes and comments about this category. Used for special instructions, procurement guidelines, or category-specific business rules.',
    `primary_vendor_required` BOOLEAN COMMENT 'Indicates whether items in this category must have a designated primary vendor. True for strategic categories with negotiated contracts or quality requirements.',
    `procurement_lead_time_days` STRING COMMENT 'Standard procurement lead time in days for items in this category. Used for reorder point calculations and supply chain planning.',
    `requires_expiration_tracking` BOOLEAN COMMENT 'Indicates whether items in this category require expiration date tracking for food safety and waste management. True for perishable and time-sensitive items.',
    `requires_lot_tracking` BOOLEAN COMMENT 'Indicates whether items in this category require lot number tracking for traceability and recall management. Typically true for food and beverage categories.',
    `requires_temperature_control` BOOLEAN COMMENT 'Indicates whether items in this category require temperature-controlled storage and handling per HACCP guidelines. True for perishable, refrigerated, and frozen categories.',
    `shelf_life_days` STRING COMMENT 'Typical number of days items in this category remain usable after receipt.',
    `sort_order` STRING COMMENT 'Display sequence number for this category within its parent level. Used for consistent ordering in reports, menus, and user interfaces.',
    `tax_category_code` STRING COMMENT 'Tax classification code for items in this category. Used for sales tax calculation and compliance reporting. Examples: FOOD (tax-exempt food), TAXABLE (standard rate), BEVERAGE (special rate).. Valid values are `^[A-Z0-9]{1,6}$`',
    `temperature_zone` STRING COMMENT 'Designated temperature control zone for storage of this category.. Valid values are `cold|frozen|ambient|hot`',
    `typical_waste_category` STRING COMMENT 'Most common waste reason for this category.. Valid values are `spoilage|overproduction|trim|other`',
    `typical_yield_percentage` DECIMAL(18,2) COMMENT 'Average usable yield percentage for the category during preparation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the category record.',
    `waste_tracking_enabled` BOOLEAN COMMENT 'Indicates whether waste tracking is enabled for items in this category. True for perishable food categories to support Waste% KPI reporting and food cost optimization.',
    `yield_management_enabled` BOOLEAN COMMENT 'Indicates whether yield management is enabled for items in this category. True for categories where as-purchased quantity differs from usable quantity (e.g., whole proteins, produce with trim loss).',
    CONSTRAINT pk_item_category PRIMARY KEY(`item_category_id`)
) COMMENT 'Master reference table for item_category. ';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` (
    `inventory_ingredient_usage_id` BIGINT COMMENT 'Primary key for the IngredientUsage association',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to the franchisee master',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to the ingredient master',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - ingredient usage must be tracked per unit for food cost analysis',
    `stock_item_id` BIGINT COMMENT 'add column stock_item_id (BIGINT) with FK to inventory.stock_item.stock_item_id - usage records need to reference the physical stock item consumed',
    `average_monthly_usage` DECIMAL(18,2) COMMENT 'Average quantity of the ingredient used per month by the franchisee',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Negotiated cost per unit of the ingredient for the franchisee',
    CONSTRAINT pk_inventory_ingredient_usage PRIMARY KEY(`inventory_ingredient_usage_id`)
) COMMENT 'Represents the operational relationship between an ingredient and a franchisee, capturing how much of the ingredient each franchisee consumes on average each month and the cost per unit negotiated for that franchisee.. Existence Justification: Each franchisee uses many different ingredients in its menus, and each ingredient is used across many franchisee locations. The business tracks the average monthly usage and the cost per unit for each ingredient‑franchisee pair to support inventory forecasting and supplier negotiations. This relationship is actively managed and updated on a regular basis.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_on_stock_item_id` FOREIGN KEY (`on_stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_recount_of_count_id` FOREIGN KEY (`recount_of_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_origin_stock_location_id` FOREIGN KEY (`origin_stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ADD CONSTRAINT `fk_inventory_yield_record_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_receiving_order_id` FOREIGN KEY (`receiving_order_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`receiving_order`(`receiving_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_inventory_related_receiving_receiving_order_id` FOREIGN KEY (`inventory_related_receiving_receiving_order_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`receiving_order`(`receiving_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_stock_transfer_id` FOREIGN KEY (`stock_transfer_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_inventory_related_transfer_stock_transfer_id` FOREIGN KEY (`inventory_related_transfer_stock_transfer_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_reversal_adjustment_inventory_adjustment_id` FOREIGN KEY (`reversal_adjustment_inventory_adjustment_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`inventory_adjustment`(`inventory_adjustment_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ADD CONSTRAINT `fk_inventory_uom_base_uom_id` FOREIGN KEY (`base_uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_receiving_order_id` FOREIGN KEY (`receiving_order_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`receiving_order`(`receiving_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ADD CONSTRAINT `fk_inventory_lot_tracking_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ADD CONSTRAINT `fk_inventory_prep_usage_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ADD CONSTRAINT `fk_inventory_item_category_parent_item_category_id` FOREIGN KEY (`parent_item_category_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`item_category`(`item_category_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ADD CONSTRAINT `fk_inventory_inventory_ingredient_usage_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Item Specification Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `stock_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_eggs` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Eggs');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Fish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Milk');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_peanuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Peanuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Shellfish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_soybeans` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Soybeans');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_tree_nuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Tree Nuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Wheat');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `haccp_max_temp_f` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Maximum Temperature Fahrenheit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `haccp_min_temp_f` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Minimum Temperature Fahrenheit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_gluten_free` SET TAGS ('dbx_business_glossary_term' = 'Is Gluten Free');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_gmo_free` SET TAGS ('dbx_business_glossary_term' = 'Is Genetically Modified Organism (GMO) Free');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Is Halal');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Is Kosher');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Is Organic');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Is Vegan');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_vegetarian` SET TAGS ('dbx_business_glossary_term' = 'Is Vegetarian');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Item Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Item Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `storage_class` SET TAGS ('dbx_business_glossary_term' = 'Storage Class');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `storage_class` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `vendor_item_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_equipment_equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `access_control_required` SET TAGS ('dbx_business_glossary_term' = 'Access Control Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_receiving` SET TAGS ('dbx_business_glossary_term' = 'Allows Receiving');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_transfers` SET TAGS ('dbx_business_glossary_term' = 'Allows Transfers');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_waste_tracking` SET TAGS ('dbx_business_glossary_term' = 'Allows Waste Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `bin_count` SET TAGS ('dbx_business_glossary_term' = 'Bin Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `building_section` SET TAGS ('dbx_business_glossary_term' = 'Building Section');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `capacity_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Capacity (Cubic Feet)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency (Days)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'refrigerated|frozen|ambient|bar|prep_area|service_station');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `next_scheduled_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Cycle Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `par_level_enabled` SET TAGS ('dbx_business_glossary_term' = 'PAR (Periodic Automatic Replenishment) Level Enabled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `primary_commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `requires_haccp_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Requires HACCP (Hazard Analysis Critical Control Points) Monitoring');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'open|restricted|locked|high_value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `shelf_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Area Type (Back of House / Front of House)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_value_regex' = 'boh|foh');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `target_temperature_max_f` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Maximum (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `target_temperature_min_f` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Minimum (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_monitoring_frequency_hours` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Frequency (Hours)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'freezer|cooler|ambient|controlled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `on_hand_balance_id` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Balance Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `on_stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `on_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN|AUD');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `days_until_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days Until Expiration');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `extended_value` SET TAGS ('dbx_business_glossary_term' = 'Extended Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `extended_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|reserved|quarantined|expired|damaged|in_transit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|weighted_average|standard_cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `variance_from_par` SET TAGS ('dbx_business_glossary_term' = 'Variance from Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` SET TAGS ('dbx_subdomain' = 'receiving_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Manager Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Manager Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `days_variance` SET TAGS ('dbx_business_glossary_term' = 'Delivery Days Variance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_timeliness` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timeliness');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_timeliness` SET TAGS ('dbx_value_regex' = 'on_time|early|late');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `posted_to_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to Inventory Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `posted_to_inventory_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted to Inventory Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional|not_inspected');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_location` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_location` SET TAGS ('dbx_value_regex' = 'back_door|loading_dock|front_entrance|side_entrance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_number` SET TAGS ('dbx_business_glossary_term' = 'Receiving Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_number` SET TAGS ('dbx_value_regex' = '^RCV-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_shift` SET TAGS ('dbx_business_glossary_term' = 'Receiving Shift');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_shift` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|overnight');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_status` SET TAGS ('dbx_business_glossary_term' = 'Receiving Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_status` SET TAGS ('dbx_value_regex' = 'pending|partial|complete|rejected|disputed');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `seal_integrity_check` SET TAGS ('dbx_business_glossary_term' = 'Seal Integrity Check');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `seal_integrity_check` SET TAGS ('dbx_value_regex' = 'intact|broken|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `temperature_check_result` SET TAGS ('dbx_business_glossary_term' = 'Temperature Check Result');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `temperature_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `temperature_recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `total_items_ordered` SET TAGS ('dbx_business_glossary_term' = 'Total Items Ordered');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `total_items_received` SET TAGS ('dbx_business_glossary_term' = 'Total Items Received');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `total_received_value` SET TAGS ('dbx_business_glossary_term' = 'Total Received Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `total_received_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `variance_reason` SET TAGS ('dbx_value_regex' = 'short_shipment|damaged_goods|wrong_item|quality_issue|overage|none');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_subdomain' = 'cost_tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'GL (General Ledger) Journal Entry ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_id` SET TAGS ('dbx_relationship_label' = 'recount_of_count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_id` SET TAGS ('dbx_remediation' = 'review_links');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|barcode-scan|rfid|hybrid');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^PC-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_period` SET TAGS ('dbx_business_glossary_term' = 'Count Period (Daypart)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_period` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late-night|overnight|full-day');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|submitted|approved|posted|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full|spot-check|cycle-count|pre-close|post-close|opening');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `is_period_end_count` SET TAGS ('dbx_business_glossary_term' = 'Is Period End Count Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `posted_to_gl_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted to GL (General Ledger) Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `system_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'System Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `system_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_sku_counted` SET TAGS ('dbx_business_glossary_term' = 'Total SKU (Stock Keeping Unit) Counted');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_sku_with_variance` SET TAGS ('dbx_business_glossary_term' = 'Total SKU (Stock Keeping Unit) With Variance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Percentage (Waste%)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_subdomain' = 'cost_tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late-night');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'trash|compost|donation|rendering|other');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `haccp_violation` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Violation Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `manager_approved` SET TAGS ('dbx_business_glossary_term' = 'Manager Approved Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `on_hand_quantity_before_waste` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity Before Waste');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `par_level_at_waste` SET TAGS ('dbx_business_glossary_term' = 'PAR (Periodic Automatic Replenishment) Level at Waste');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `responsible_station` SET TAGS ('dbx_business_glossary_term' = 'Responsible Station');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `responsible_station` SET TAGS ('dbx_value_regex' = 'BOH|FOH');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `temperature_at_waste` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Waste (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'spoilage|overproduction|prep-loss|expiration|quality-reject|theft-unknown');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_cost` SET TAGS ('dbx_business_glossary_term' = 'Waste Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_prevention_opportunity` SET TAGS ('dbx_business_glossary_term' = 'Waste Prevention Opportunity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waste Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'receiving_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_restaurant_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `external_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'External Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-P(0[1-9]|1[0-3])$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `haccp_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Monitoring Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|high|urgent|emergency');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|passed|failed|conditional-accept');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'internal-delivery|courier|third-party|self-pickup|direct-transfer');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'MARKETMAN|SAP-MM|MANUAL|LEGACY');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi-temp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_quantity_transferred` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Transferred');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_transfer_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Value (USD)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^STR-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_value_regex' = 'par-replenishment|excess-stock|expiring-soon|quality-issue|menu-change|seasonal-adjustment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_received_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_request_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Request Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Ship Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'inter-unit|intra-unit|return-to-dc|return-to-vendor|emergency|rebalance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `variance_reason` SET TAGS ('dbx_value_regex' = 'damage-in-transit|short-shipment|overage|quality-rejection|counting-error|none');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'receiving_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^RO-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'marketman_auto|manager_manual|pos_integration|erp_mrp|mobile_app|third_party_api');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'auto_par|manual|emergency|scheduled|spot');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_fee` SET TAGS ('dbx_business_glossary_term' = 'Shipping Fee');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|supplier_truck|third_party_carrier|will_call');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `supplier_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` SET TAGS ('dbx_subdomain' = 'cost_tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `actual_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage (Yield%)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `cost_per_raw_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Raw Unit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `cost_per_raw_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `cost_per_yield_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Yield Unit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `cost_per_yield_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `haccp_compliant` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Compliant');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_station_code` SET TAGS ('dbx_business_glossary_term' = 'Preparation Station Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_station_name` SET TAGS ('dbx_business_glossary_term' = 'Preparation Station Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preparation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_type` SET TAGS ('dbx_business_glossary_term' = 'Preparation Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_type` SET TAGS ('dbx_value_regex' = 'butchering|portioning|cooking|trimming|peeling|deboning');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|reject');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `raw_quantity_in` SET TAGS ('dbx_business_glossary_term' = 'Raw Quantity In');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `raw_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Raw Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `recipe_component_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Component Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `standard_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Standard Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `temperature_at_prep_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Preparation (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `total_raw_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Raw Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `total_raw_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `usable_yield_quantity_out` SET TAGS ('dbx_business_glossary_term' = 'Usable Yield Quantity Out');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage (Waste%)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_value_regex' = 'trim|spoilage|overcooking|contamination|quality|other');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Waste Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_value_regex' = 'draft|verified|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Yield Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` SET TAGS ('dbx_subdomain' = 'cost_tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `inventory_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `foodsafety_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Receiving ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `inventory_related_receiving_receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Receiving ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `inventory_related_transfer_stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Related Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `reversal_adjustment_inventory_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto-approved');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `impacts_cogs` SET TAGS ('dbx_business_glossary_term' = 'Impacts Cost of Goods Sold (COGS) Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `is_reversed` SET TAGS ('dbx_business_glossary_term' = 'Is Reversed Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `is_shrinkage` SET TAGS ('dbx_business_glossary_term' = 'Is Shrinkage Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `on_hand_quantity_after` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity After Adjustment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `on_hand_quantity_before` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity Before Adjustment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `temperature_at_adjustment_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Adjustment (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'operational waste|spoilage|theft|damage|other');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` SET TAGS ('dbx_subdomain' = 'cost_tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_cost_period_id` SET TAGS ('dbx_business_glossary_term' = 'Food Cost Period ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `actual_food_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Food Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `beverage_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Beverage Sales Revenue');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Closed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `closing_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Closing Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `cogs_percent_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Percentage Actual');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `cogs_percent_theoretical` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Percentage Theoretical');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Count Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'physical|perpetual|hybrid');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Food Sales Revenue');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Period Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `opening_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Opening Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-P[0-9]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked|under_review');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|monthly|quarterly');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `purchases_value` SET TAGS ('dbx_business_glossary_term' = 'Purchases Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `theoretical_food_cost` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Food Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `total_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Revenue');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `transfers_in_value` SET TAGS ('dbx_business_glossary_term' = 'Transfers In Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `transfers_out_value` SET TAGS ('dbx_business_glossary_term' = 'Transfers Out Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `waste_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage (Waste%)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `waste_value` SET TAGS ('dbx_business_glossary_term' = 'Waste Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `base_uom_id` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM) ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `abbreviation` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Abbreviation');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `allows_fractional_quantities` SET TAGS ('dbx_business_glossary_term' = 'Allows Fractional Quantities Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `allows_temperature_tracking` SET TAGS ('dbx_business_glossary_term' = 'Allows Temperature Tracking Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `applicable_item_categories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Item Categories');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_category` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_category` SET TAGS ('dbx_value_regex' = 'metric|imperial|count|custom');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_code` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `conversion_factor_to_base` SET TAGS ('dbx_business_glossary_term' = 'Conversion Factor to Base Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `default_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Default Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `is_base_uom` SET TAGS ('dbx_business_glossary_term' = 'Is Base Unit of Measure (UOM) Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `is_system_standard` SET TAGS ('dbx_business_glossary_term' = 'Is System Standard Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `iso_code` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_name` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `ordering_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Ordering Unit of Measure (UOM) Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `plural_name` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Plural Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `precision_decimal_places` SET TAGS ('dbx_business_glossary_term' = 'Precision Decimal Places');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `recipe_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Recipe Unit of Measure (UOM) Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `requires_lot_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Lot Tracking Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `storage_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit of Measure (UOM) Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `symbol` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Symbol');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `un_cefact_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Centre for Trade Facilitation and Electronic Business (UN/CEFACT) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `un_cefact_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_status` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_type` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Expense Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_renamed_from' = 'procurement_supplier_id');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `contract_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `last_cost_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Update Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `next_cost_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Cost Review Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `on_time_delivery_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `order_increment` SET TAGS ('dbx_business_glossary_term' = 'Order Increment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `order_uom` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pack Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Brand Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending|suspended');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Vendor Priority Rank');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_product_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Product Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_sku` SET TAGS ('dbx_business_glossary_term' = 'Vendor Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_eggs` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Eggs');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Fish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Milk');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_peanuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Peanuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Shellfish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_soybeans` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Soybeans');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_tree_nuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Tree Nuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Wheat');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `best_by_date` SET TAGS ('dbx_business_glossary_term' = 'Best By Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `condition_at_receiving` SET TAGS ('dbx_business_glossary_term' = 'Condition at Receiving');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `condition_at_receiving` SET TAGS ('dbx_value_regex' = 'acceptable|damaged|short_dated|temperature_deviation|rejected');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_code` SET TAGS ('dbx_business_glossary_term' = 'Lot Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'available|quarantined|recalled|expired|depleted|rejected');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|premium|standard|economy');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `quantity_remaining` SET TAGS ('dbx_business_glossary_term' = 'Quantity Remaining');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `quarantine_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `temperature_at_receiving_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receiving (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'frozen|refrigerated|ambient|hot_hold');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` SET TAGS ('dbx_subdomain' = 'cost_tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Prep Usage ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `actual_quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity Used');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `haccp_compliant` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Compliant');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_date` SET TAGS ('dbx_business_glossary_term' = 'Prep Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_station_code` SET TAGS ('dbx_business_glossary_term' = 'Prep Station Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_station_name` SET TAGS ('dbx_business_glossary_term' = 'Prep Station Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_task_reference` SET TAGS ('dbx_business_glossary_term' = 'Prep Task Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prep Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_type` SET TAGS ('dbx_business_glossary_term' = 'Prep Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_type` SET TAGS ('dbx_value_regex' = 'batch|made_to_order|par_replenishment|catering|special_event|waste_recovery');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_usage_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_usage_status` SET TAGS ('dbx_value_regex' = 'draft|recorded|verified|posted|voided');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|reject');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `temperature_at_prep_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Prep (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `theoretical_cost` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `theoretical_quantity` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_cost` SET TAGS ('dbx_business_glossary_term' = 'Variance Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `item_category_id` SET TAGS ('dbx_business_glossary_term' = 'Item Category ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User Identifier');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `parent_item_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Item Category Id');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `parent_item_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `primary_item_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `primary_item_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `primary_item_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `allergen_category` SET TAGS ('dbx_business_glossary_term' = 'Allergen Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Item Category Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'food|beverage|non_food|supply|equipment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `cogs_budget_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Budget Target Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `cogs_budget_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'perishable|non-perishable|frozen|refrigerated|dry|ambient');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Margin Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_par_level_days` SET TAGS ('dbx_business_glossary_term' = 'Default Periodic Automatic Replenishment (PAR) Level Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_par_quantity` SET TAGS ('dbx_business_glossary_term' = 'Default PAR Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Default Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Tax Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Default Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_waste_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `item_category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `division` SET TAGS ('dbx_value_regex' = 'food|beverage|packaging|non-food|supplies|equipment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `haccp_required` SET TAGS ('dbx_business_glossary_term' = 'HACCP Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `item_category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `item_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `multi_sourcing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Multi-Sourcing Allowed');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `primary_vendor_required` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `requires_expiration_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Expiration Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `requires_lot_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Lot Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `requires_temperature_control` SET TAGS ('dbx_business_glossary_term' = 'Requires Temperature Control');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'cold|frozen|ambient|hot');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `typical_waste_category` SET TAGS ('dbx_business_glossary_term' = 'Typical Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `typical_waste_category` SET TAGS ('dbx_value_regex' = 'spoilage|overproduction|trim|other');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `typical_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Typical Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `waste_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Waste Tracking Enabled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `yield_management_enabled` SET TAGS ('dbx_business_glossary_term' = 'Yield Management Enabled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_subdomain' = 'cost_tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_association_edges' = 'supply.ingredient,franchise.franchisee');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `inventory_ingredient_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredientusage - Ingredient Usage Id');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredientusage - Franchisee Id');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredientusage - Ingredient Id');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `average_monthly_usage` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Usage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
