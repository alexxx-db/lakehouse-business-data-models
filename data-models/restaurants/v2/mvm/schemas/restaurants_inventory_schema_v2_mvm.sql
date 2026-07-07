-- Schema for Domain: inventory | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-02 04:02:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`inventory` COMMENT 'Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` (
    `stock_item_id` BIGINT COMMENT 'Primary key for the stock item.',
    `ingredient_id` BIGINT COMMENT 'FK to supply ingredient master.',
    `allergen_eggs` BOOLEAN COMMENT 'Whether item contains eggs allergen.',
    `allergen_fish` BOOLEAN COMMENT 'Whether item contains fish allergen.',
    `allergen_milk` BOOLEAN COMMENT 'Whether item contains milk allergen.',
    `allergen_peanuts` BOOLEAN COMMENT 'Whether item contains peanuts allergen.',
    `allergen_shellfish` BOOLEAN COMMENT 'Whether item contains shellfish allergen.',
    `allergen_soybeans` BOOLEAN COMMENT 'Whether item contains soybeans allergen.',
    `allergen_tree_nuts` BOOLEAN COMMENT 'Whether item contains tree nuts allergen.',
    `allergen_wheat` BOOLEAN COMMENT 'Whether item contains wheat allergen.',
    `case_pack_quantity` STRING COMMENT 'Number of units per case pack.',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'Currency code for cost values.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `discontinuation_date` DATE COMMENT 'Date item was discontinued.',
    `gtin` STRING COMMENT 'Global Trade Item Number.',
    `haccp_max_temp_f` DECIMAL(18,2) COMMENT 'Maximum HACCP-compliant storage temperature in Fahrenheit.',
    `haccp_min_temp_f` DECIMAL(18,2) COMMENT 'Minimum HACCP-compliant storage temperature in Fahrenheit.',
    `is_active` BOOLEAN COMMENT 'Whether the stock item is currently active.',
    `is_gluten_free` BOOLEAN COMMENT 'Whether item is gluten free.',
    `is_gmo_free` BOOLEAN COMMENT 'Whether item is GMO free.',
    `is_halal` BOOLEAN COMMENT 'Whether item is halal certified.',
    `is_kosher` BOOLEAN COMMENT 'Whether item is kosher certified.',
    `is_organic` BOOLEAN COMMENT 'Whether item is organic.',
    `is_vegan` BOOLEAN COMMENT 'Whether item is vegan.',
    `is_vegetarian` BOOLEAN COMMENT 'Whether item is vegetarian.',
    `item_category` STRING COMMENT 'Category classification of the stock item.',
    `item_description` STRING COMMENT 'Detailed description of the stock item.',
    `item_name` STRING COMMENT 'Name of the stock item.',
    `item_subcategory` STRING COMMENT 'Subcategory classification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification.',
    `par_level` DECIMAL(18,2) COMMENT 'Target on-hand quantity.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Quantity at which reorder is triggered.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'Standard quantity to reorder.',
    `shelf_life_days` STRING COMMENT 'Number of days item remains usable.',
    `sku_code` STRING COMMENT 'Stock keeping unit code.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit.',
    `storage_class` STRING COMMENT 'Storage classification (dry, refrigerated, frozen).',
    `unit_of_measure` STRING COMMENT 'Default unit of measure.',
    `vendor_item_code` STRING COMMENT 'Vendor-assigned item code.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Expected yield percentage after prep.',
    CONSTRAINT pk_stock_item PRIMARY KEY(`stock_item_id`)
) COMMENT 'Master record for each stockable item tracked in restaurant inventory including allergen flags, storage requirements, and reorder parameters.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` (
    `stock_location_id` BIGINT COMMENT 'Primary key for the stock location.',
    `employee_id` BIGINT COMMENT 'FK to employee managing this location.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: A stock location (line reach-in, prep cooler) physically serves a specific kitchen station. This link enables par level management by station, HACCP zone assignment, and prep workflow optimization — a',
    `access_control_required` BOOLEAN COMMENT 'Whether access control is required.',
    `activation_date` DATE COMMENT 'Date location was activated.',
    `allows_receiving` BOOLEAN COMMENT 'Whether location can receive goods.',
    `allows_transfers` BOOLEAN COMMENT 'Whether location allows stock transfers.',
    `allows_waste_tracking` BOOLEAN COMMENT 'Whether waste tracking is enabled.',
    `bin_count` STRING COMMENT 'Number of bins in this location.',
    `building_section` STRING COMMENT 'Section of building where location resides.',
    `capacity_cubic_feet` DECIMAL(18,2) COMMENT 'Storage capacity in cubic feet.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `cycle_count_frequency_days` STRING COMMENT 'Days between cycle counts.',
    `deactivation_date` DATE COMMENT 'Date location was deactivated.',
    `floor_level` STRING COMMENT 'Floor level of the location.',
    `last_cycle_count_date` DATE COMMENT 'Date of last cycle count.',
    `last_maintenance_date` DATE COMMENT 'Date of last maintenance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification.',
    `location_code` STRING COMMENT 'Unique code for the location.',
    `location_name` STRING COMMENT 'Name of the storage location.',
    `location_type` STRING COMMENT 'Type of location (walk-in, shelf, etc).',
    `next_scheduled_cycle_count_date` DATE COMMENT 'Next scheduled cycle count date.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Next scheduled maintenance date.',
    `notes` STRING COMMENT 'Free-text notes about the location.',
    `par_level_enabled` BOOLEAN COMMENT 'Whether par level management is enabled.',
    `primary_commodity_category` STRING COMMENT 'Primary commodity stored here.',
    `requires_haccp_monitoring` BOOLEAN COMMENT 'Whether HACCP monitoring is required.',
    `security_level` STRING COMMENT 'Security level classification.',
    `shelf_count` STRING COMMENT 'Number of shelves.',
    `stock_location_status` STRING COMMENT 'Current status of the location.',
    `storage_area_type` STRING COMMENT 'Type of storage area.',
    `target_temperature_max_f` DECIMAL(18,2) COMMENT 'Maximum target temperature in Fahrenheit.',
    `target_temperature_min_f` DECIMAL(18,2) COMMENT 'Minimum target temperature in Fahrenheit.',
    `temperature_monitoring_frequency_hours` STRING COMMENT 'Hours between temperature checks.',
    `temperature_zone` STRING COMMENT 'Temperature zone classification.',
    CONSTRAINT pk_stock_location PRIMARY KEY(`stock_location_id`)
) COMMENT 'Physical storage locations within restaurants, distribution centers, or facilities where inventory is held.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` (
    `on_hand_balance_id` BIGINT COMMENT 'Primary key.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Lot-level on-hand balances are required for FIFO/FEFO rotation, expiration date management, and recall impact analysis. Linking on_hand_balance to ingredient_lot enables food safety audits and regulat',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item by SKU.',
    `stock_location_id` BIGINT COMMENT 'FK to stock location.',
    `abc_classification` STRING COMMENT 'ABC inventory classification.',
    `currency_code` STRING COMMENT 'Currency for monetary values.',
    `cycle_count_frequency` STRING COMMENT 'Frequency of cycle counts.',
    `days_until_expiration` DECIMAL(18,2) COMMENT 'Days remaining until expiration.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date value.',
    `extended_value` DECIMAL(18,2) COMMENT 'Total value of on-hand quantity.',
    `inventory_status` STRING COMMENT 'Current inventory status.',
    `is_perishable` BOOLEAN COMMENT 'Whether item is perishable.',
    `last_adjustment_date` DATE COMMENT 'Date of last adjustment.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Timestamp of last inventory movement.',
    `last_physical_count_date` DATE COMMENT 'Date of last physical count.',
    `last_received_date` DATE COMMENT 'Date item was last received.',
    `lot_number` STRING COMMENT 'Lot number of on-hand stock.',
    `par_level` DECIMAL(18,2) COMMENT 'Target par level quantity.',
    `quantity_available` DECIMAL(18,2) COMMENT 'Quantity available for use.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Total quantity on hand.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'Quantity reserved for orders.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when record was last updated.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Quantity triggering reorder.',
    `safety_stock` DECIMAL(18,2) COMMENT 'Safety stock quantity.',
    `sku_code` STRING COMMENT 'A standardized code representing the sku classification for this on hand balance',
    `sku_description` STRING COMMENT 'Description of the SKU.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp of the balance snapshot.',
    `temperature_zone` STRING COMMENT 'Temperature zone.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `valuation_method` STRING COMMENT 'Inventory valuation method (FIFO, LIFO, avg).',
    `variance_from_par` DECIMAL(18,2) COMMENT 'Variance from par level.',
    CONSTRAINT pk_on_hand_balance PRIMARY KEY(`on_hand_balance_id`)
) COMMENT 'Current on-hand inventory balance for each stock item at each location, including valuation and par-level tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` (
    `receiving_order_id` BIGINT COMMENT 'Primary key.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Inventory receiving events must reconcile with supply goods receipts for 3-way match (PO→GR→invoice), inventory posting validation, and HACCP chain-of-custody. goods_receipt_number on receiving_order ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: Receiving against a purchase order is a fundamental restaurant supply chain process — it drives quantity variance tracking, partial delivery management, and AP matching. A restaurant ops expert expect',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `food_cost_period_id` BIGINT COMMENT 'Foreign key linking to inventory.food_cost_period. Business justification: food_cost_period.purchases_value aggregates the total value of goods received during the period. Linking each receiving_order to its accounting period via receiving_food_cost_period_id → food_cost_per',
    `receiving_manager_employee_id` BIGINT COMMENT 'FK to receiving manager.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Receiving is performed during a specific shift; linking enables shift-level labor cost attribution for receiving activities, receiving productivity reports by shift, and replaces the denormalized plai',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: receiving_order.receiving_location is a denormalized STRING field capturing where goods were received. stock_location has an allows_receiving BOOLEAN flag specifically indicating which locations accep',
    `receiving_unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `days_variance` STRING COMMENT 'Days variance from expected delivery.',
    `delivery_date` DATE COMMENT 'Actual delivery date.',
    `delivery_note_number` STRING COMMENT 'Delivery note reference number.',
    `delivery_time` TIMESTAMP COMMENT 'Actual delivery time.',
    `delivery_timeliness` STRING COMMENT 'Timeliness classification (early, on-time, late).',
    `driver_name` STRING COMMENT 'Name of delivery driver.',
    `expected_delivery_date` DATE COMMENT 'Expected delivery date.',
    `invoice_number` STRING COMMENT 'Supplier invoice number.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `posted_to_inventory_flag` BOOLEAN COMMENT 'Whether posted to inventory.',
    `posted_to_inventory_timestamp` TIMESTAMP COMMENT 'Timestamp when posted to inventory.',
    `quality_inspection_result` STRING COMMENT 'Result of quality inspection.',
    `quality_notes` STRING COMMENT 'Notes on quality.',
    `receiving_number` STRING COMMENT 'Receiving order number.',
    `receiving_status` STRING COMMENT 'Status of the receiving order.',
    `rejection_reason` STRING COMMENT 'Reason for rejection if applicable.',
    `seal_integrity_check` STRING COMMENT 'Result of seal integrity check.',
    `supplier_name` STRING COMMENT 'Name of the supplier.',
    `temperature_check_result` STRING COMMENT 'Result of temperature check.',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Temperature recorded at receiving.',
    `total_items_ordered` DECIMAL(18,2) COMMENT 'Total items ordered.',
    `total_items_received` DECIMAL(18,2) COMMENT 'Total items received.',
    `total_received_value` DECIMAL(18,2) COMMENT 'Total monetary value received.',
    `variance_flag` BOOLEAN COMMENT 'Whether variance exists.',
    `variance_reason` STRING COMMENT 'Reason for variance.',
    CONSTRAINT pk_receiving_order PRIMARY KEY(`receiving_order_id`)
) COMMENT 'Records of goods received at a restaurant unit or facility, including quality checks and temperature verification.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` (
    `physical_count_id` BIGINT COMMENT 'Primary key.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Physical inventory counts are conducted during specific shifts; linking enables labor cost attribution for count labor, shift-level count scheduling compliance, and operational reports identifying whi',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: physical_count records a count event scoped to a restaurant unit but has no FK to a specific stock_location. In practice, physical counts are often performed per storage location (walk-in cooler, dry ',
    `employee_id` BIGINT COMMENT 'FK to employee who initiated count.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `recount_of_count_physical_count_id` BIGINT COMMENT 'Self-FK for recount reference.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual end time of count.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start time of count.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp of approval.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Timestamp of cancellation.',
    `count_date` DATE COMMENT 'Date of the physical count.',
    `count_method` STRING COMMENT 'Method used for counting.',
    `count_number` STRING COMMENT 'Count reference number.',
    `count_period` STRING COMMENT 'Period of the count.',
    `count_status` STRING COMMENT 'Status of the count.',
    `count_type` STRING COMMENT 'Type of count (full, cycle, spot).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `is_period_end_count` BOOLEAN COMMENT 'Whether this is a period-end count.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `notes` STRING COMMENT 'Free-text notes.',
    `physical_inventory_value` DECIMAL(18,2) COMMENT 'Value of physical inventory counted.',
    `posted_to_gl_timestamp` TIMESTAMP COMMENT 'Timestamp when posted to GL.',
    `recount_required_flag` BOOLEAN COMMENT 'Whether recount is required.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Scheduled start time.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp of count submission.',
    `system_inventory_value` DECIMAL(18,2) COMMENT 'System-calculated inventory value.',
    `total_sku_counted` DECIMAL(18,2) COMMENT 'Total SKUs counted.',
    `total_sku_with_variance` DECIMAL(18,2) COMMENT 'Total SKUs with variance.',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'Total variance amount.',
    `total_variance_percentage` DECIMAL(18,2) COMMENT 'Total variance as percentage.',
    `variance_reason_code` STRING COMMENT 'Code for variance reason.',
    CONSTRAINT pk_physical_count PRIMARY KEY(`physical_count_id`)
) COMMENT 'Physical inventory count events performed at restaurant units, tracking count results, variances, and GL postings.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` (
    `waste_log_id` BIGINT COMMENT 'Primary key.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: Equipment failures (refrigerator malfunction, fryer breakdown) directly cause inventory waste. Linking waste_log to equipment_asset enables equipment-driven waste analysis, maintenance ROI reporting, ',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Station-level waste analysis is a core operational process: managers track which kitchen station (grill, fryer, prep) generates the most waste for HACCP compliance, labor efficiency, and cost reductio',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: Waste attribution reporting: when a specific order line is remade or rejected (waste_flag=true on order_item), the waste_log entry must trace back to the originating order_item for COGS accuracy, wast',
    `employee_id` BIGINT COMMENT 'FK to employee who recorded waste.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `recipe_id` BIGINT COMMENT 'FK to recipe.',
    `shift_id` BIGINT COMMENT 'FK to shift.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `stock_location_id` BIGINT COMMENT 'FK to stock location.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp of manager approval.',
    `batch_number` STRING COMMENT 'Batch number of wasted item.',
    `corrective_action_taken` STRING COMMENT 'Corrective action taken.',
    `daypart` STRING COMMENT 'Daypart when waste occurred.',
    `disposal_method` STRING COMMENT 'Method of disposal.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of wasted item.',
    `haccp_violation` BOOLEAN COMMENT 'Whether waste was due to HACCP violation.',
    `manager_approved` BOOLEAN COMMENT 'Whether manager approved the waste.',
    `notes` STRING COMMENT 'Free-text notes.',
    `on_hand_quantity_before_waste` DECIMAL(18,2) COMMENT 'Quantity on hand before waste event.',
    `par_level_at_waste` DECIMAL(18,2) COMMENT 'Par level at time of waste.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `temperature_at_waste` DECIMAL(18,2) COMMENT 'Temperature at time of waste.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `waste_category` STRING COMMENT 'Category of waste.',
    `waste_cost` DECIMAL(18,2) COMMENT 'Cost of wasted items.',
    `waste_date` DATE COMMENT 'Date of waste event.',
    `waste_prevention_opportunity` STRING COMMENT 'Identified prevention opportunity.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'Quantity wasted.',
    `waste_reason` STRING COMMENT 'Reason for waste.',
    `waste_timestamp` TIMESTAMP COMMENT 'Timestamp of waste event.',
    CONSTRAINT pk_waste_log PRIMARY KEY(`waste_log_id`)
) COMMENT 'Records of inventory waste events including reason, quantity, cost impact, and HACCP compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` (
    `stock_transfer_id` BIGINT COMMENT 'Primary key.',
    `unit_id` BIGINT COMMENT 'FK to destination unit.',
    `stock_location_id` BIGINT COMMENT 'FK to destination location.',
    `origin_restaurant_unit_id` BIGINT COMMENT 'FK to origin unit.',
    `origin_stock_location_id` BIGINT COMMENT 'FK to origin location.',
    `employee_id` BIGINT COMMENT 'FK to requesting employee.',
    `tertiary_stock_received_by_employee_id` BIGINT COMMENT 'FK to receiving employee.',
    `food_cost_period_id` BIGINT COMMENT 'Foreign key linking to inventory.food_cost_period. Business justification: stock_transfer.fiscal_period is a denormalized STRING field capturing the accounting period for the transfer. food_cost_period tracks transfers_in_value and transfers_out_value as components of the fo',
    `cancellation_date` DATE COMMENT 'Date of cancellation.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation.',
    `carrier_name` STRING COMMENT 'Name of carrier.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `expected_delivery_date` DATE COMMENT 'Expected delivery date.',
    `external_transfer_reference` STRING COMMENT 'External reference number.',
    `gl_posting_date` DATE COMMENT 'Date posted to GL.',
    `haccp_monitoring_required_flag` BOOLEAN COMMENT 'Whether HACCP monitoring is required.',
    `inspection_notes` STRING COMMENT 'Notes from inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `priority_level` STRING COMMENT 'Priority level of transfer.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Whether quality inspection is required.',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection.',
    `shipping_method` STRING COMMENT 'Shipping method used.',
    `source_system_code` STRING COMMENT 'Source system code.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Whether temperature controlled.',
    `temperature_zone_required` BOOLEAN COMMENT 'Whether temperature zone is required.',
    `total_item_count` DECIMAL(18,2) COMMENT 'Total items in transfer.',
    `total_quantity_transferred` DECIMAL(18,2) COMMENT 'Total quantity transferred.',
    `total_transfer_value_usd` DECIMAL(18,2) COMMENT 'Total value of transfer in USD.',
    `tracking_number` STRING COMMENT 'Shipment tracking number.',
    `transfer_approval_date` DATE COMMENT 'Date transfer was approved.',
    `transfer_number` STRING COMMENT 'Transfer reference number.',
    `transfer_reason_code` STRING COMMENT 'Reason code for transfer.',
    `transfer_reason_notes` STRING COMMENT 'Notes on transfer reason.',
    `transfer_received_date` DATE COMMENT 'Date transfer was received.',
    `transfer_request_date` DATE COMMENT 'Date transfer was requested.',
    `transfer_ship_date` DATE COMMENT 'Date transfer was shipped.',
    `transfer_status` STRING COMMENT 'Current status of transfer.',
    `transfer_type` STRING COMMENT 'Type of transfer.',
    `variance_flag` BOOLEAN COMMENT 'Whether variance exists.',
    `variance_reason` STRING COMMENT 'Reason for variance.',
    CONSTRAINT pk_stock_transfer PRIMARY KEY(`stock_transfer_id`)
) COMMENT 'Records of inventory transfers between locations, units, or facilities including shipping and quality inspection details.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `receiving_order_id` BIGINT COMMENT 'FK to related receiving order.',
    `adjustment_inventory_related_receiving_receiving_order_id` BIGINT COMMENT 'FK to related receiving order.',
    `stock_transfer_id` BIGINT COMMENT 'FK to related stock transfer.',
    `adjustment_inventory_related_transfer_stock_transfer_id` BIGINT COMMENT 'FK to related transfer.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Inventory adjustments for spoilage, recall write-offs, and shrinkage must be traceable to specific ingredient lots for HACCP compliance and insurance claims. batch_number on inventory_adjustment is a ',
    `primary_inventory_adjusted_by_employee_id` BIGINT COMMENT 'FK to adjusting employee.',
    `physical_count_id` BIGINT COMMENT 'FK to physical count.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to order.refund. Business justification: Refund-driven inventory correction: when a refund is issued for a food quality or wrong-item complaint, an inventory_adjustment is triggered to correct COGS and on-hand balances. Linking inventory_adj',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `reversal_adjustment_inventory_adjustment_id` BIGINT COMMENT 'Self-FK for reversal.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Inventory adjustments (shrinkage, corrections, HACCP violations) occur during specific shifts; linking enables shift-level shrinkage reporting, loss-prevention analysis by shift/daypart, and supports ',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `stock_location_id` BIGINT COMMENT 'FK to stock location.',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'Quantity adjusted.',
    `adjustment_date` DATE COMMENT 'Date of adjustment.',
    `adjustment_number` STRING COMMENT 'Adjustment reference number.',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Timestamp of adjustment.',
    `adjustment_type` STRING COMMENT 'Type of adjustment.',
    `approval_status` STRING COMMENT 'Approval status.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp of approval.',
    `approved_by_manager_name` STRING COMMENT 'Name of approving manager.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date.',
    `impacts_cogs` BOOLEAN COMMENT 'Whether adjustment impacts COGS.',
    `is_reversed` BOOLEAN COMMENT 'Whether adjustment was reversed.',
    `is_shrinkage` BOOLEAN COMMENT 'Whether adjustment is shrinkage.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `notes` STRING COMMENT 'Free-text notes.',
    `on_hand_quantity_after` DECIMAL(18,2) COMMENT 'Quantity after adjustment.',
    `on_hand_quantity_before` DECIMAL(18,2) COMMENT 'Quantity before adjustment.',
    `reason_code` STRING COMMENT 'Reason code.',
    `reason_description` STRING COMMENT 'Description of reason.',
    `requires_approval` BOOLEAN COMMENT 'Whether approval is required.',
    `supporting_document_reference` STRING COMMENT 'Reference to supporting document.',
    `temperature_at_adjustment_f` DECIMAL(18,2) COMMENT 'Temperature at time of adjustment.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Unit cost at time of adjustment.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `value` DECIMAL(18,2) COMMENT 'Monetary value of adjustment.',
    `waste_category` STRING COMMENT 'Waste category if applicable.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Records of inventory quantity adjustments including reason codes, approval workflow, and financial impact.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` (
    `food_cost_period_id` BIGINT COMMENT 'Primary key.',
    `physical_count_id` BIGINT COMMENT 'Foreign key linking to inventory.physical_count. Business justification: food_cost_period has a physical_count_date DATE field that denormalizes the date of the physical count used to establish closing inventory value. The actual physical_count record (with its full varian',
    `employee_id` BIGINT COMMENT 'FK to primary food employee.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `tertiary_food_employee_id` BIGINT COMMENT 'FK to employee.',
    `actual_food_cost` DECIMAL(18,2) COMMENT 'Actual food cost for the period.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment amount.',
    `adjustment_reason` STRING COMMENT 'Reason for adjustment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp of approval.',
    `beverage_sales_revenue` DECIMAL(18,2) COMMENT 'Beverage sales revenue.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when period was closed.',
    `closing_inventory_value` DECIMAL(18,2) COMMENT 'Closing inventory value.',
    `cogs_percent_actual` DECIMAL(18,2) COMMENT 'Actual COGS percentage.',
    `cogs_percent_theoretical` DECIMAL(18,2) COMMENT 'Theoretical COGS percentage.',
    `count_method` STRING COMMENT 'Count method used.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `food_sales_revenue` DECIMAL(18,2) COMMENT 'Food sales revenue.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `notes` STRING COMMENT 'Free-text notes.',
    `opening_inventory_value` DECIMAL(18,2) COMMENT 'Opening inventory value.',
    `period_end_date` DATE COMMENT 'End date of the period.',
    `period_number` STRING COMMENT 'Period number.',
    `period_start_date` DATE COMMENT 'Start date of the period.',
    `period_status` STRING COMMENT 'Status of the period.',
    `period_type` STRING COMMENT 'Type of period (weekly, monthly).',
    `purchases_value` DECIMAL(18,2) COMMENT 'Value of purchases in period.',
    `theoretical_food_cost` DECIMAL(18,2) COMMENT 'Theoretical food cost.',
    `total_sales_revenue` DECIMAL(18,2) COMMENT 'Total sales revenue.',
    `transfers_in_value` DECIMAL(18,2) COMMENT 'Value of transfers in.',
    `transfers_out_value` DECIMAL(18,2) COMMENT 'Value of transfers out.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Variance amount.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Variance percentage.',
    `waste_percent` DECIMAL(18,2) COMMENT 'Waste percentage.',
    `waste_value` DECIMAL(18,2) COMMENT 'Value of waste.',
    CONSTRAINT pk_food_cost_period PRIMARY KEY(`food_cost_period_id`)
) COMMENT 'Periodic food cost calculations for restaurant units including actual vs theoretical cost, variance analysis, and COGS percentages.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` (
    `vendor_item_id` BIGINT COMMENT 'Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In multi-brand restaurant enterprises, vendor items are brand-specific (proprietary sauces, branded proteins). Linking vendor_item to brand enables brand-level procurement analysis, brand standard com',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `supplier_contract_id` BIGINT COMMENT 'FK to supplier contract.',
    `activation_date` DATE COMMENT 'Date vendor item was activated.',
    `contract_effective_date` DATE COMMENT 'Contract effective date.',
    `contract_expiration_date` DECIMAL(18,2) COMMENT 'Contract expiration date.',
    `contract_number` STRING COMMENT 'Contract number.',
    `contract_price_flag` BOOLEAN COMMENT 'Whether price is contract-based.',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'Currency code for cost.',
    `country_of_origin` STRING COMMENT 'Country of origin.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `deactivation_date` DATE COMMENT 'Date vendor item was deactivated.',
    `deactivation_reason` STRING COMMENT 'Reason for deactivation.',
    `vendor_item_description` STRING COMMENT 'Vendor item description.',
    `gtin` STRING COMMENT 'Global Trade Item Number.',
    `last_cost_update_date` DATE COMMENT 'Date cost was last updated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `last_order_date` DATE COMMENT 'Date of last order.',
    `last_received_date` DATE COMMENT 'Date last received.',
    `lead_time_days` STRING COMMENT 'Lead time in days.',
    `manufacturer_name` STRING COMMENT 'Manufacturer name.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturer part number.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity.',
    `vendor_item_name` STRING COMMENT 'Vendor item name.',
    `next_cost_review_date` DATE COMMENT 'Next cost review date.',
    `notes` STRING COMMENT 'Free-text notes.',
    `on_time_delivery_percent` DECIMAL(18,2) COMMENT 'On-time delivery percentage.',
    `order_increment` DECIMAL(18,2) COMMENT 'Order increment quantity.',
    `order_uom` STRING COMMENT 'Unit of measure for ordering.',
    `pack_quantity` DECIMAL(18,2) COMMENT 'Pack quantity.',
    `pack_size` STRING COMMENT 'Pack size description.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Whether this is the preferred vendor.',
    `quality_rating` DECIMAL(18,2) COMMENT 'Quality rating.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Unit cost.',
    `vendor_item_status` STRING COMMENT 'Status of vendor item.',
    `vendor_priority_rank` STRING COMMENT 'Vendor priority rank.',
    `vendor_product_category` STRING COMMENT 'Vendor product category.',
    `vendor_sku` STRING COMMENT 'Vendor SKU code.',
    CONSTRAINT pk_vendor_item PRIMARY KEY(`vendor_item_id`)
) COMMENT 'Mapping of stock items to vendor/supplier catalog items including pricing, lead times, and ordering parameters.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_food_cost_period_id` FOREIGN KEY (`food_cost_period_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`food_cost_period`(`food_cost_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_recount_of_count_physical_count_id` FOREIGN KEY (`recount_of_count_physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_origin_stock_location_id` FOREIGN KEY (`origin_stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_food_cost_period_id` FOREIGN KEY (`food_cost_period_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`food_cost_period`(`food_cost_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_receiving_order_id` FOREIGN KEY (`receiving_order_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`receiving_order`(`receiving_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_inventory_related_receiving_receiving_order_id` FOREIGN KEY (`adjustment_inventory_related_receiving_receiving_order_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`receiving_order`(`receiving_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_transfer_id` FOREIGN KEY (`stock_transfer_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_inventory_related_transfer_stock_transfer_id` FOREIGN KEY (`adjustment_inventory_related_transfer_stock_transfer_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_reversal_adjustment_inventory_adjustment_id` FOREIGN KEY (`reversal_adjustment_inventory_adjustment_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_eggs` SET TAGS ('dbx_business_glossary_term' = 'Allergen Eggs');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Allergen Fish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Allergen Milk');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_peanuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen Peanuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Allergen Shellfish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_soybeans` SET TAGS ('dbx_business_glossary_term' = 'Allergen Soybeans');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_tree_nuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen Tree Nuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Allergen Wheat');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'GTIN');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `haccp_max_temp_f` SET TAGS ('dbx_business_glossary_term' = 'HACCP Max Temp F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `haccp_min_temp_f` SET TAGS ('dbx_business_glossary_term' = 'HACCP Min Temp F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_gluten_free` SET TAGS ('dbx_business_glossary_term' = 'Is Gluten Free');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_gmo_free` SET TAGS ('dbx_business_glossary_term' = 'Is GMO Free');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Is Halal');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Is Kosher');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Is Organic');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Is Vegan');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_vegetarian` SET TAGS ('dbx_business_glossary_term' = 'Is Vegetarian');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Item Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Item Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'SKU Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `storage_class` SET TAGS ('dbx_business_glossary_term' = 'Storage Class');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `vendor_item_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `access_control_required` SET TAGS ('dbx_business_glossary_term' = 'Access Control Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_receiving` SET TAGS ('dbx_business_glossary_term' = 'Allows Receiving');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_transfers` SET TAGS ('dbx_business_glossary_term' = 'Allows Transfers');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_waste_tracking` SET TAGS ('dbx_business_glossary_term' = 'Allows Waste Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `bin_count` SET TAGS ('dbx_business_glossary_term' = 'Bin Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `building_section` SET TAGS ('dbx_business_glossary_term' = 'Building Section');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `capacity_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Capacity Cubic Feet');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `next_scheduled_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Cycle Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `par_level_enabled` SET TAGS ('dbx_business_glossary_term' = 'Par Level Enabled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `primary_commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `requires_haccp_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Requires HACCP Monitoring');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `shelf_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_status` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Area Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `target_temperature_max_f` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Max F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `target_temperature_min_f` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Min F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_monitoring_frequency_hours` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Frequency Hours');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `on_hand_balance_id` SET TAGS ('dbx_business_glossary_term' = 'On Hand Balance ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `days_until_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days Until Expiration');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `extended_value` SET TAGS ('dbx_business_glossary_term' = 'Extended Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'SKU Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'SKU Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `variance_from_par` SET TAGS ('dbx_business_glossary_term' = 'Variance From Par');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `food_cost_period_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Food Cost Period Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Manager Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `days_variance` SET TAGS ('dbx_business_glossary_term' = 'Days Variance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `delivery_timeliness` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timeliness');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `posted_to_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted To Inventory Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `posted_to_inventory_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted To Inventory Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_number` SET TAGS ('dbx_business_glossary_term' = 'Receiving Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_status` SET TAGS ('dbx_business_glossary_term' = 'Receiving Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `seal_integrity_check` SET TAGS ('dbx_business_glossary_term' = 'Seal Integrity Check');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `supplier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `temperature_check_result` SET TAGS ('dbx_business_glossary_term' = 'Temperature Check Result');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `temperature_recorded` SET TAGS ('dbx_business_glossary_term' = 'Temperature Recorded');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `total_items_ordered` SET TAGS ('dbx_business_glossary_term' = 'Total Items Ordered');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `total_items_received` SET TAGS ('dbx_business_glossary_term' = 'Total Items Received');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `total_received_value` SET TAGS ('dbx_business_glossary_term' = 'Total Received Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Count Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Count Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Recount Of Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_physical_count_id` SET TAGS ('dbx_review_links' = 'reviewed');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Count Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_period` SET TAGS ('dbx_business_glossary_term' = 'Count Period');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `is_period_end_count` SET TAGS ('dbx_business_glossary_term' = 'Is Period End Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `posted_to_gl_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted To GL Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `system_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'System Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_sku_counted` SET TAGS ('dbx_business_glossary_term' = 'Total SKU Counted');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_sku_with_variance` SET TAGS ('dbx_business_glossary_term' = 'Total SKU With Variance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `haccp_violation` SET TAGS ('dbx_business_glossary_term' = 'HACCP Violation');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `manager_approved` SET TAGS ('dbx_business_glossary_term' = 'Manager Approved');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `on_hand_quantity_before_waste` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity Before Waste');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `par_level_at_waste` SET TAGS ('dbx_business_glossary_term' = 'Par Level At Waste');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `temperature_at_waste` SET TAGS ('dbx_business_glossary_term' = 'Temperature At Waste');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_cost` SET TAGS ('dbx_business_glossary_term' = 'Waste Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_prevention_opportunity` SET TAGS ('dbx_business_glossary_term' = 'Waste Prevention Opportunity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waste Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_restaurant_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `food_cost_period_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Food Cost Period Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `external_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'External Transfer Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `haccp_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'HACCP Monitoring Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_quantity_transferred` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Transferred');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_transfer_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Value USD');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_received_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_request_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Request Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Ship Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Receiving Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_inventory_related_receiving_receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Receiving Order ID Alt');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Related Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_inventory_related_transfer_stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transfer Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Order Refund Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `reversal_adjustment_inventory_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `impacts_cogs` SET TAGS ('dbx_business_glossary_term' = 'Impacts COGS');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `is_reversed` SET TAGS ('dbx_business_glossary_term' = 'Is Reversed');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `is_shrinkage` SET TAGS ('dbx_business_glossary_term' = 'Is Shrinkage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `on_hand_quantity_after` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity After');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `on_hand_quantity_before` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity Before');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `temperature_at_adjustment_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature At Adjustment F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_cost_period_id` SET TAGS ('dbx_business_glossary_term' = 'Food Cost Period ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Period End Physical Count Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Food Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `tertiary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `tertiary_food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `tertiary_food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `actual_food_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Food Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `beverage_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Beverage Sales Revenue');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `closing_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Closing Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `cogs_percent_actual` SET TAGS ('dbx_business_glossary_term' = 'COGS Percent Actual');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `cogs_percent_theoretical` SET TAGS ('dbx_business_glossary_term' = 'COGS Percent Theoretical');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Food Sales Revenue');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `opening_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Opening Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `purchases_value` SET TAGS ('dbx_business_glossary_term' = 'Purchases Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `theoretical_food_cost` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Food Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `total_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Revenue');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `transfers_in_value` SET TAGS ('dbx_business_glossary_term' = 'Transfers In Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `transfers_out_value` SET TAGS ('dbx_business_glossary_term' = 'Transfers Out Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `waste_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Percent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `waste_value` SET TAGS ('dbx_business_glossary_term' = 'Waste Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `contract_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'GTIN');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `last_cost_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Update Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `next_cost_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Cost Review Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `on_time_delivery_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Percent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `order_increment` SET TAGS ('dbx_business_glossary_term' = 'Order Increment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `order_uom` SET TAGS ('dbx_business_glossary_term' = 'Order UOM');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pack Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Vendor Priority Rank');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_product_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Product Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_sku` SET TAGS ('dbx_business_glossary_term' = 'Vendor SKU');
