-- Schema for Domain: inventory | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-10 20:02:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`inventory` COMMENT 'Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` (
    `stock_item_id` BIGINT COMMENT 'Unique identifier for the stock item. Primary key for the stock_item product.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Each stock item (ingredient) is governed by a HACCP plan defining safe handling temperatures, critical limits, and storage requirements. Food safety compliance audits and HACCP traceability reports re',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: REQUIRED: Ingredient Inventory Valuation Report needs each stock item linked to its ingredient master for nutrition, allergen, and compliance tracking.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: stock_item.unit_of_measure is a denormalized STRING that should reference the uom master table. The uom product is the authoritative reference for all units of measure used in inventory transactions (',
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
    `vendor_item_code` STRING COMMENT 'Suppliers unique identifier for this item. Used for purchase order matching and invoice reconciliation.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of usable product after preparation and trimming. Critical for recipe costing and waste tracking.',
    CONSTRAINT pk_stock_item PRIMARY KEY(`stock_item_id`)
) COMMENT 'Master record for every SKU tracked in restaurant inventory — food, beverage, packaging, and non-food supplies. Captures SKU code, item name, unit of measure (UOM), item category (protein, produce, dry goods, beverage, paper goods, cleaning), storage class (ambient, refrigerated, frozen), reorder point, reorder quantity, standard cost, vendor item code, shelf life days, HACCP temperature range, allergen flags, daypart applicability, seasonal adjustment flags, and active status. Also owns PAR-level configuration per unit-location: PAR quantity, minimum quantity (reorder point), maximum quantity (shelf capacity), day-of-week overrides, seasonal adjustment flags, and effective date range. This is the SSOT for all stockable items and their replenishment parameters managed through MarketMan.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` (
    `stock_location_id` BIGINT COMMENT 'Unique identifier for the stock location. Primary key.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: stock_location has requires_haccp_monitoring boolean. Food safety operations require assigning the specific HACCP plan governing each monitored storage location — enabling automated monitoring sched',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for HACCP temperature monitoring accountability; each storage location has an assigned manager employee who signs compliance reports.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier for the refrigeration or climate control equipment serving this location, used for maintenance tracking and temperature monitoring integration.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this stock location is physically situated.',
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
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: on_hand_balance.unit_of_measure is a denormalized STRING that should reference the uom master table. The on-hand quantity snapshot must be expressed in a validated, system-standard UOM to support accu',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: FIFO/FEFO inventory rotation and recall isolation require each on-hand balance record to reference the specific ingredient lot it represents. The plain-text lot_number is a denormalization of ingred',
    `physical_count_id` BIGINT COMMENT 'Foreign key linking to inventory.physical_count. Business justification: on_hand_balance.last_physical_count_date is a denormalized DATE that captures when the balance was last validated by a physical count. Replacing this with last_physical_count_id as a FK to inventory.p',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this inventory is held. Links to the restaurant operations master.',
    `stock_item_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this balance is recorded. Links to the inventory item master.',
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
    `last_received_date` DATE COMMENT 'The date when this SKU was last received into inventory at this location. Used to track inventory freshness and identify slow-moving items.',
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
    `valuation_method` STRING COMMENT 'The accounting method used to value this inventory (FIFO - First In First Out, LIFO - Last In First Out, weighted average, or standard cost). Determines COGS calculation.. Valid values are `FIFO|LIFO|weighted_average|standard_cost`',
    `variance_from_par` DECIMAL(18,2) COMMENT 'The difference between quantity_on_hand and par_level. Positive values indicate overstocking, negative values indicate understocking and trigger replenishment.',
    CONSTRAINT pk_on_hand_balance PRIMARY KEY(`on_hand_balance_id`)
) COMMENT 'Current stock-on-hand snapshot for each SKU at each storage location within a restaurant unit. Captures quantity on hand, quantity reserved (committed to prep), quantity available, last physical count date, last adjustment date, last received date, unit cost, extended value, and variance from PAR level. Updated by receiving, transfers, waste events, and physical counts. The authoritative real-time inventory position record used for replenishment decisions and food cost reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` (
    `receiving_order_id` BIGINT COMMENT 'Unique identifier for the receiving order record. Primary key for inbound inventory transactions at restaurant unit level.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Receiving reconciliation between the inventory-side receiving_order and the supply-side goods_receipt is a core AP/receiving process. The plain-text goods_receipt_number is a denormalization of good',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Receiving is a HACCP critical control point; receiving_order tracks temperature_check_result, seal_integrity_check, and quality_inspection_result — all governed by a specific HACCP plan. Regulatory tr',
    `employee_id` BIGINT COMMENT 'Employee identifier of the restaurant manager or BOH staff member who inspected and accepted the delivery. Links to Workday HCM employee master.',
    `receiving_manager_employee_id` BIGINT COMMENT 'Employee identifier of the restaurant manager or BOH staff member who inspected and accepted the delivery. Links to Workday HCM employee master.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit receiving the goods. Links to restaurant operations master data.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Receiving occurs during a specific shift; shift-level receiving productivity, labor cost attribution, and HACCP temperature log correlation all require this link. The existing plain-text receiving_sh',
    `stock_location_id` BIGINT COMMENT 'Reference to the originating purchase order in MarketMan that authorized this delivery. Links receiving to procurement.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the receiving order record was first created in MarketMan or source system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the received value (e.g., USD, CAD, EUR). Supports multi-currency operations for international franchise units.. Valid values are `^[A-Z]{3}$`',
    `days_variance` STRING COMMENT 'Calculated difference in days between expected and actual delivery date. Positive values indicate late delivery; negative values indicate early delivery. Used for supplier scorecard.',
    `delivery_date` DATE COMMENT 'Calendar date when the goods were delivered to the restaurant unit. Used for inventory aging and FIFO tracking.',
    `delivery_note_number` STRING COMMENT 'Packing slip or delivery note number provided by the supplier. Cross-reference document for reconciliation and dispute resolution.',
    `delivery_time` TIMESTAMP COMMENT 'Precise timestamp when the delivery was received at the restaurant Back of House (BOH). Critical for temperature control compliance and HACCP documentation.',
    `delivery_timeliness` STRING COMMENT 'Classification of delivery punctuality relative to expected delivery date. On Time: within agreed window; Early: before window; Late: after window. Key supplier performance indicator.. Valid values are `on_time|early|late`',
    `driver_name` STRING COMMENT 'Name of the driver who delivered the goods. Captured for traceability and food safety audit trail per HACCP requirements.',
    `expected_delivery_date` DATE COMMENT 'Scheduled delivery date from the original purchase order. Used to calculate delivery timeliness and supplier on-time performance metrics.',
    `invoice_number` STRING COMMENT 'Invoice number provided by the supplier on the delivery documentation. Used for three-way match with PO and goods receipt in SAP S/4HANA AP.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the receiving order record was last updated. Tracks changes to status, variance resolution, or quality inspection updates.',
    `posted_to_inventory_flag` BOOLEAN COMMENT 'Boolean indicator that received goods have been posted to restaurant unit inventory in MarketMan and SAP S/4HANA. True when goods receipt is complete and stock levels updated.',
    `posted_to_inventory_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving transaction was posted to inventory system. Used for inventory valuation date and FIFO/LIFO costing.',
    `quality_inspection_result` STRING COMMENT 'Overall quality assessment result for the received goods. Approved: meets standards; Rejected: fails quality criteria; Conditional: accepted with notes; Not Inspected: visual check only. Aligns with Good Manufacturing Practice (GMP) standards.. Valid values are `approved|rejected|conditional|not_inspected`',
    `quality_notes` STRING COMMENT 'Free-text notes captured by receiving manager regarding product quality, packaging condition, or other observations. Used for supplier feedback and continuous improvement.',
    `receiving_location` STRING COMMENT 'Physical location at the restaurant unit where goods were received. Typically Back of House (BOH) loading area. Used for operational logistics and security tracking.. Valid values are `back_door|loading_dock|front_entrance|side_entrance`',
    `receiving_number` STRING COMMENT 'Business-facing unique receiving document number generated by MarketMan or restaurant POS system. Format: RCV-YYYYMMDD-NNNN.. Valid values are `^RCV-[0-9]{8}-[0-9]{4}$`',
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
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: A physical inventory count event is scoped to a specific storage location within a restaurant unit (e.g., walk-in cooler, dry storage, bar). physical_count currently links to restaurant.unit but has n',
    `employee_id` BIGINT COMMENT 'Reference to the employee who initiated or started the physical count event.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the physical count was performed.',
    `recount_of_count_physical_count_id` BIGINT COMMENT '',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Physical counts are scheduled during specific shifts (opening, closing). Linking to shift enables labor cost attribution for count labor and shift-level productivity reporting — a standard restaurant ',
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
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: Equipment failures (refrigeration breakdown, fryer malfunction) directly cause inventory spoilage/waste. Linking waste_log to equipment_asset enables HACCP equipment-failure-to-waste traceability, mai',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: waste_log has a haccp_violation flag — when triggered, food safety managers must trace the violation to the governing HACCP plan for corrective action reporting and regulatory compliance. No existin',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Marketing ROI analysis needs to attribute waste spikes to specific campaigns; this FK supports that report.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Food safety audits and recall impact analysis require lot-level waste tracking. Linking waste_log to ingredient_lot identifies which specific lot was wasted, supporting HACCP corrective action documen',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Station-level waste reporting and HACCP compliance require tracing waste to the specific kitchen station (grill, fryer, prep) that generated it. responsible_station is a denormalized text field; rep',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: When an order_item is voided, returned, or over-prepared, a waste_log entry is created. Linking waste_log to the originating order_item enables food safety traceability, void-driven waste reporting, a',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the waste event in the system.',
    `recipe_id` BIGINT COMMENT 'Identifier of the recipe or Bill of Materials (BOM) associated with the wasted prepared item, if applicable.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to order.refund. Business justification: Refund-triggered waste (returned food that cannot be resold) must be traceable from waste_log back to the originating refund for food safety accountability, COGS impact analysis, and fraud detection. ',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the waste event occurred, used for labor and operational analysis.',
    `stock_item_id` BIGINT COMMENT 'Identifier of the Stock Keeping Unit (SKU) that was wasted.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Waste is recorded per storage location; replacing the denormalized storage_location field with a FK enables location‑level waste analytics.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the waste event occurred.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: waste_log.unit_of_measure is a denormalized STRING that should reference the uom master table. Waste tracking requires precise UOM alignment to calculate waste_cost accurately and to compare waste_qua',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the waste log entry was approved by a manager.',
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
    `temperature_at_waste` DECIMAL(18,2) COMMENT 'The temperature in Fahrenheit of the item or storage area at the time of waste, relevant for food safety and spoilage analysis.',
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
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit or distribution center receiving the transferred inventory. For intra-unit transfers, this is the same as origin unit.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in cooler, dry storage, freezer) within the destination unit where items will be received. Critical for BOH (Back of House) inventory accuracy.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: stock_transfer has explicit haccp_monitoring_required_flag and temperature_controlled_flag fields. When HACCP monitoring is required during inter-unit transfers, the governing HACCP plan must be r',
    `origin_restaurant_unit_id` BIGINT COMMENT 'Reference to the restaurant unit or distribution center from which inventory is being transferred. For intra-unit transfers, this is the same as destination unit.',
    `origin_stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in cooler, dry storage, freezer) within the origin unit from which items are being transferred. Critical for BOH (Back of House) inventory accuracy.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically kitchen manager or shift supervisor) who initiated the stock transfer request. Used for accountability and audit trail.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Inter-location stock transfers occur during specific shifts. Shift-level labor attribution for transfer activities and shift productivity reports are standard in multi-unit restaurant operations. No e',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_recount_of_count_physical_count_id` FOREIGN KEY (`recount_of_count_physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_origin_stock_location_id` FOREIGN KEY (`origin_stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ADD CONSTRAINT `fk_inventory_uom_base_uom_id` FOREIGN KEY (`base_uom_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`uom`(`uom_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Uom Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `vendor_item_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Balance Uom Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|weighted_average|standard_cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `variance_from_par` SET TAGS ('dbx_business_glossary_term' = 'Variance from Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Manager Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Manager Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_physical_count_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_physical_count_id` SET TAGS ('dbx_relationship_label' = 'recount_of_count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_physical_count_id` SET TAGS ('dbx_remediation' = 'review_links');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Uom Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `temperature_at_waste` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Waste (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'spoilage|overproduction|prep-loss|expiration|quality-reject|theft-unknown');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_cost` SET TAGS ('dbx_business_glossary_term' = 'Waste Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_prevention_opportunity` SET TAGS ('dbx_business_glossary_term' = 'Waste Prevention Opportunity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waste Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_restaurant_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
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
