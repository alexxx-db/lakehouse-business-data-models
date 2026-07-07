-- Schema for Domain: inventory | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`inventory` COMMENT 'Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` (
    `stock_item_id` BIGINT COMMENT 'Primary key for the stock item.',
    `category_id` BIGINT COMMENT 'FK to procurement category.',
    `cost_center_id` BIGINT COMMENT 'FK to finance cost center.',
    `gl_account_id` BIGINT COMMENT 'FK to GL account for inventory valuation.',
    `ingredient_id` BIGINT COMMENT 'FK to supply ingredient master.',
    `item_specification_id` BIGINT COMMENT 'FK to procurement item specification.',
    `procurement_supplier_id` BIGINT COMMENT 'FK to primary vendor supplier.',
    `stock_procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier.',
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
    `cost_center_id` BIGINT COMMENT 'FK to finance cost center.',
    `distribution_center_id` BIGINT COMMENT 'FK to supply distribution center.',
    `facility_id` BIGINT COMMENT 'FK to real estate facility.',
    `employee_id` BIGINT COMMENT 'FK to employee managing this location.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `equipment_asset_id` BIGINT COMMENT 'FK to restaurant equipment asset.',
    `stock_equipment_equipment_asset_id` BIGINT COMMENT 'Alternate FK to equipment asset.',
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
    `cost_center_id` BIGINT COMMENT 'FK to cost center.',
    `facility_id` BIGINT COMMENT 'FK to facility.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item by SKU.',
    `on_stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `on_unit_id` BIGINT COMMENT 'FK to restaurant unit.',
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
    `facility_id` BIGINT COMMENT 'FK to facility.',
    `procurement_purchase_order_id` BIGINT COMMENT 'FK to procurement purchase order.',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `receiving_manager_employee_id` BIGINT COMMENT 'FK to receiving manager.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
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
    `goods_receipt_number` STRING COMMENT 'Goods receipt reference number.',
    `invoice_number` STRING COMMENT 'Supplier invoice number.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `posted_to_inventory_flag` BOOLEAN COMMENT 'Whether posted to inventory.',
    `posted_to_inventory_timestamp` TIMESTAMP COMMENT 'Timestamp when posted to inventory.',
    `quality_inspection_result` STRING COMMENT 'Result of quality inspection.',
    `quality_notes` STRING COMMENT 'Notes on quality.',
    `receiving_location` STRING COMMENT 'Location where goods were received.',
    `receiving_number` STRING COMMENT 'Receiving order number.',
    `receiving_shift` STRING COMMENT 'Shift during which goods were received.',
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
    `financial_period_id` BIGINT COMMENT 'FK to financial period.',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee.',
    `journal_entry_id` BIGINT COMMENT 'FK to journal entry for GL posting.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `physical_unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `employee_id` BIGINT COMMENT 'FK to employee who initiated count.',
    `recount_of_count_id` BIGINT COMMENT 'Self-FK for recount reference.',
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
    `campaign_id` BIGINT COMMENT 'FK to marketing campaign.',
    `facility_id` BIGINT COMMENT 'FK to facility.',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee.',
    `menu_item_id` BIGINT COMMENT 'FK to menu item.',
    `employee_id` BIGINT COMMENT 'FK to employee who recorded waste.',
    `recipe_id` BIGINT COMMENT 'FK to recipe.',
    `shift_id` BIGINT COMMENT 'FK to shift.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `stock_location_id` BIGINT COMMENT 'FK to stock location.',
    `gl_account_id` BIGINT COMMENT 'FK to GL account for waste.',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `waste_unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `waste_vendor_procurement_supplier_id` BIGINT COMMENT 'FK to vendor supplier.',
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
    `responsible_station` STRING COMMENT 'Kitchen station responsible.',
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
    `cost_center_id` BIGINT COMMENT 'FK to cost center.',
    `unit_id` BIGINT COMMENT 'FK to destination unit.',
    `stock_location_id` BIGINT COMMENT 'FK to destination location.',
    `facility_id` BIGINT COMMENT 'FK to facility.',
    `origin_restaurant_unit_id` BIGINT COMMENT 'FK to origin unit.',
    `origin_stock_location_id` BIGINT COMMENT 'FK to origin location.',
    `employee_id` BIGINT COMMENT 'FK to requesting employee.',
    `tertiary_stock_received_by_employee_id` BIGINT COMMENT 'FK to receiving employee.',
    `cancellation_date` DATE COMMENT 'Date of cancellation.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation.',
    `carrier_name` STRING COMMENT 'Name of carrier.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `expected_delivery_date` DATE COMMENT 'Expected delivery date.',
    `external_transfer_reference` STRING COMMENT 'External reference number.',
    `fiscal_period` STRING COMMENT 'Fiscal period.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Primary key.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center.',
    `employee_id` BIGINT COMMENT 'FK to primary replenishment employee.',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier.',
    `receiving_employee_id` BIGINT COMMENT 'FK to receiving user.',
    `receiving_user_employee_id` BIGINT COMMENT 'FK to receiving employee.',
    `replenishment_cancelled_by_user_employee_id` BIGINT COMMENT 'FK to cancelling employee.',
    `replenishment_created_by_user_employee_id` BIGINT COMMENT 'FK to creating employee.',
    `replenishment_employee_id` BIGINT COMMENT 'FK to employee.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `tertiary_replenishment_cancelled_by_user_employee_id` BIGINT COMMENT 'FK to tertiary cancelling employee.',
    `actual_delivery_date` DATE COMMENT 'Actual delivery date.',
    `approval_status` STRING COMMENT 'Approval status.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp of approval.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp of cancellation.',
    `carrier_name` STRING COMMENT 'Carrier name.',
    `confirmed_delivery_date` DATE COMMENT 'Confirmed delivery date.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `delivery_instructions` STRING COMMENT 'Delivery instructions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `notes` STRING COMMENT 'Free-text notes.',
    `order_date` DATE COMMENT 'Date order was placed.',
    `order_number` STRING COMMENT 'Order reference number.',
    `order_source` STRING COMMENT 'Source of the order.',
    `order_status` STRING COMMENT 'Current order status.',
    `order_type` STRING COMMENT 'Type of order.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms.',
    `priority_level` STRING COMMENT 'Priority level.',
    `purchase_order_number` STRING COMMENT 'Associated PO number.',
    `received_timestamp` TIMESTAMP COMMENT 'Timestamp when received.',
    `requested_delivery_date` DATE COMMENT 'Requested delivery date.',
    `shipping_fee` DECIMAL(18,2) COMMENT 'Shipping fee amount.',
    `shipping_method` STRING COMMENT 'Shipping method.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when submitted.',
    `supplier_order_reference` STRING COMMENT 'Supplier order reference.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Total amount due.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total order value.',
    `tracking_number` STRING COMMENT 'Shipment tracking number.',
    `variance_flag` BOOLEAN COMMENT 'Whether variance exists.',
    `variance_notes` STRING COMMENT 'Notes on variance.',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Orders placed to replenish inventory at restaurant units, including approval workflow and delivery tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` (
    `yield_record_id` DECIMAL(18,2) COMMENT 'Primary key.',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee.',
    `employee_id` BIGINT COMMENT 'FK to recording employee.',
    `recipe_id` BIGINT COMMENT 'FK to recipe.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `actual_yield_percentage` DECIMAL(18,2) COMMENT 'Actual yield percentage achieved.',
    `batch_number` STRING COMMENT 'Batch number.',
    `cost_per_raw_unit` DECIMAL(18,2) COMMENT 'Cost per raw unit.',
    `cost_per_yield_unit` DECIMAL(18,2) COMMENT 'Cost per yield unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `haccp_compliant` BOOLEAN COMMENT 'Whether prep was HACCP compliant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `notes` STRING COMMENT 'Free-text notes.',
    `prep_date` DATE COMMENT 'Date of prep.',
    `prep_station_code` STRING COMMENT 'Prep station code.',
    `prep_station_name` STRING COMMENT 'Prep station name.',
    `prep_timestamp` TIMESTAMP COMMENT 'Timestamp of prep.',
    `prep_type` STRING COMMENT 'Type of prep.',
    `quality_grade` STRING COMMENT 'Quality grade of yield.',
    `raw_quantity_in` DECIMAL(18,2) COMMENT 'Raw quantity input.',
    `raw_unit_of_measure` STRING COMMENT 'Unit of measure for raw input.',
    `recipe_component_name` STRING COMMENT 'Name of recipe component.',
    `standard_yield_percentage` DECIMAL(18,2) COMMENT 'Standard expected yield percentage.',
    `temperature_at_prep_f` DECIMAL(18,2) COMMENT 'Temperature at prep in Fahrenheit.',
    `total_raw_cost` DECIMAL(18,2) COMMENT 'Total cost of raw materials.',
    `usable_yield_quantity_out` DECIMAL(18,2) COMMENT 'Usable yield quantity output.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Waste percentage.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'Waste quantity.',
    `waste_reason_code` STRING COMMENT 'Waste reason code.',
    `waste_reason_description` STRING COMMENT 'Description of waste reason.',
    `waste_unit_of_measure` STRING COMMENT 'Unit of measure for waste.',
    `yield_record_status` DECIMAL(18,2) COMMENT 'Status of yield record.',
    `yield_unit_of_measure` DECIMAL(18,2) COMMENT 'Unit of measure for yield.',
    `yield_variance_percentage` DECIMAL(18,2) COMMENT 'Variance from standard yield.',
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Records of ingredient yield from prep activities, tracking actual vs standard yield and associated costs.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` (
    `inventory_adjustment_id` BIGINT COMMENT 'Primary key.',
    `facility_id` BIGINT COMMENT 'FK to facility.',
    `foodsafety_corrective_action_id` BIGINT COMMENT 'FK to food safety corrective action.',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee.',
    `gl_account_id` BIGINT COMMENT 'FK to GL account.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `receiving_order_id` BIGINT COMMENT 'FK to related receiving order.',
    `inventory_related_receiving_receiving_order_id` BIGINT COMMENT 'FK to related receiving order.',
    `stock_transfer_id` BIGINT COMMENT 'FK to related stock transfer.',
    `inventory_related_transfer_stock_transfer_id` BIGINT COMMENT 'FK to related transfer.',
    `primary_inventory_adjusted_by_employee_id` BIGINT COMMENT 'FK to adjusting employee.',
    `physical_count_id` BIGINT COMMENT 'FK to physical count.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `reversal_adjustment_inventory_adjustment_id` BIGINT COMMENT 'Self-FK for reversal.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `stock_location_id` BIGINT COMMENT 'FK to stock location.',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'Quantity adjusted.',
    `adjustment_date` DATE COMMENT 'Date of adjustment.',
    `adjustment_number` STRING COMMENT 'Adjustment reference number.',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Timestamp of adjustment.',
    `adjustment_type` STRING COMMENT 'Type of adjustment.',
    `adjustment_value` DECIMAL(18,2) COMMENT 'Monetary value of adjustment.',
    `approval_status` STRING COMMENT 'Approval status.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp of approval.',
    `approved_by_manager_name` STRING COMMENT 'Name of approving manager.',
    `batch_number` STRING COMMENT 'Batch number.',
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
    `waste_category` STRING COMMENT 'Waste category if applicable.',
    CONSTRAINT pk_inventory_adjustment PRIMARY KEY(`inventory_adjustment_id`)
) COMMENT 'Records of inventory quantity adjustments including reason codes, approval workflow, and financial impact.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` (
    `food_cost_period_id` BIGINT COMMENT 'Primary key.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center.',
    `employee_id` BIGINT COMMENT 'FK to approving employee.',
    `food_employee_id` BIGINT COMMENT 'FK to employee.',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee.',
    `primary_food_employee_id` BIGINT COMMENT 'FK to primary food employee.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
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
    `physical_count_date` DATE COMMENT 'Date of physical count.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`uom` (
    `uom_id` BIGINT COMMENT 'Primary key.',
    `base_uom_id` BIGINT COMMENT 'Self-FK to base UOM.',
    `abbreviation` STRING COMMENT 'UOM abbreviation.',
    `allows_fractional_quantities` BOOLEAN COMMENT 'Whether fractional quantities are allowed.',
    `allows_temperature_tracking` BOOLEAN COMMENT 'Whether temperature tracking applies.',
    `applicable_item_categories` STRING COMMENT 'Item categories this UOM applies to.',
    `uom_category` STRING COMMENT 'Category of UOM (weight, volume, count).',
    `uom_code` STRING COMMENT 'A standardized code representing the uom classification for this uom',
    `conversion_factor_to_base` DECIMAL(18,2) COMMENT 'Conversion factor to base UOM.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `default_shelf_life_days` STRING COMMENT 'Default shelf life in days.',
    `display_sequence` STRING COMMENT 'Display order sequence.',
    `effective_end_date` DATE COMMENT 'End date of effectiveness.',
    `effective_start_date` DATE COMMENT 'Start date of effectiveness.',
    `is_base_uom` BOOLEAN COMMENT 'Whether this is a base UOM.',
    `is_system_standard` BOOLEAN COMMENT 'Whether this is a system standard UOM.',
    `iso_code` STRING COMMENT 'ISO standard code.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `uom_name` STRING COMMENT 'Name of the UOM.',
    `notes` STRING COMMENT 'Free-text notes.',
    `ordering_uom_flag` BOOLEAN COMMENT 'Whether used for ordering.',
    `plural_name` STRING COMMENT 'Plural form of UOM name.',
    `precision_decimal_places` STRING COMMENT 'Number of decimal places.',
    `recipe_uom_flag` BOOLEAN COMMENT 'Whether used in recipes.',
    `requires_lot_tracking` BOOLEAN COMMENT 'Whether lot tracking is required.',
    `storage_uom_flag` BOOLEAN COMMENT 'Whether used for storage.',
    `symbol` STRING COMMENT 'UOM symbol.',
    `un_cefact_code` STRING COMMENT 'UN/CEFACT code.',
    `uom_status` STRING COMMENT 'Status of the UOM.',
    `uom_type` STRING COMMENT 'Type of UOM.',
    CONSTRAINT pk_uom PRIMARY KEY(`uom_id`)
) COMMENT 'Unit of measure reference table with conversion factors, categorization, and applicability flags.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` (
    `vendor_item_id` BIGINT COMMENT 'Primary key.',
    `gl_account_id` BIGINT COMMENT 'FK to expense GL account.',
    `primary_vendor_procurement_supplier_id` BIGINT COMMENT 'FK to vendor supplier.',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier.',
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
    `vendor_brand_name` STRING COMMENT 'Vendor brand name.',
    `vendor_item_status` STRING COMMENT 'Status of vendor item.',
    `vendor_priority_rank` STRING COMMENT 'Vendor priority rank.',
    `vendor_product_category` STRING COMMENT 'Vendor product category.',
    `vendor_sku` STRING COMMENT 'Vendor SKU code.',
    CONSTRAINT pk_vendor_item PRIMARY KEY(`vendor_item_id`)
) COMMENT 'Mapping of stock items to vendor/supplier catalog items including pricing, lead times, and ordering parameters.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` (
    `lot_tracking_id` BIGINT COMMENT 'Primary key.',
    `facility_id` BIGINT COMMENT 'FK to facility.',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee.',
    `ingredient_lot_id` BIGINT COMMENT 'FK to ingredient lot.',
    `employee_id` BIGINT COMMENT 'FK to receiving employee.',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier.',
    `receiving_order_id` BIGINT COMMENT 'FK to receiving order.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `stock_location_id` BIGINT COMMENT 'FK to stock location.',
    `allergen_eggs` BOOLEAN COMMENT 'Whether lot contains eggs.',
    `allergen_fish` BOOLEAN COMMENT 'Whether lot contains fish.',
    `allergen_milk` BOOLEAN COMMENT 'Whether lot contains milk.',
    `allergen_peanuts` BOOLEAN COMMENT 'Whether lot contains peanuts.',
    `allergen_shellfish` BOOLEAN COMMENT 'Whether lot contains shellfish.',
    `allergen_soybeans` BOOLEAN COMMENT 'Whether lot contains soybeans.',
    `allergen_tree_nuts` BOOLEAN COMMENT 'Whether lot contains tree nuts.',
    `allergen_wheat` BOOLEAN COMMENT 'Whether lot contains wheat.',
    `best_by_date` DATE COMMENT 'Best by date.',
    `condition_at_receiving` STRING COMMENT 'Condition at receiving.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `lot_code` STRING COMMENT 'A standardized code representing the lot classification for this lot tracking',
    `lot_number` STRING COMMENT 'Lot number.',
    `lot_status` STRING COMMENT 'Status of the lot.',
    `manufacture_date` DATE COMMENT 'Date of manufacture.',
    `notes` STRING COMMENT 'Free-text notes.',
    `quality_grade` STRING COMMENT 'Quality grade.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Quantity received.',
    `quantity_remaining` DECIMAL(18,2) COMMENT 'Quantity remaining.',
    `quarantine_date` DATE COMMENT 'Date quarantined.',
    `quarantine_flag` BOOLEAN COMMENT 'Whether lot is quarantined.',
    `quarantine_reason` STRING COMMENT 'Reason for quarantine.',
    `recall_date` DATE COMMENT 'Date of recall.',
    `recall_flag` BOOLEAN COMMENT 'Whether lot is under recall.',
    `recall_reason` STRING COMMENT 'Reason for recall.',
    `received_date` DATE COMMENT 'Date received.',
    `received_timestamp` TIMESTAMP COMMENT 'Timestamp when received.',
    `temperature_at_receiving_f` DECIMAL(18,2) COMMENT 'Temperature at receiving in Fahrenheit.',
    `temperature_zone` STRING COMMENT 'Temperature zone.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    CONSTRAINT pk_lot_tracking PRIMARY KEY(`lot_tracking_id`)
) COMMENT 'Lot-level tracking of inventory for traceability, recall management, and HACCP compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` (
    `prep_usage_id` BIGINT COMMENT 'Primary key.',
    `facility_id` BIGINT COMMENT 'FK to facility.',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee.',
    `employee_id` BIGINT COMMENT 'FK to recording employee.',
    `recipe_id` BIGINT COMMENT 'FK to recipe.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost of usage.',
    `actual_quantity_used` DECIMAL(18,2) COMMENT 'Actual quantity used.',
    `batch_number` STRING COMMENT 'Batch number.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date.',
    `haccp_compliant` BOOLEAN COMMENT 'Whether prep was HACCP compliant.',
    `item_description` STRING COMMENT 'Item description.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `lot_number` STRING COMMENT 'Lot number used.',
    `notes` STRING COMMENT 'Free-text notes.',
    `prep_date` DATE COMMENT 'Date of prep.',
    `prep_station_code` STRING COMMENT 'Prep station code.',
    `prep_station_name` STRING COMMENT 'Prep station name.',
    `prep_task_reference` STRING COMMENT 'Reference to prep task.',
    `prep_timestamp` TIMESTAMP COMMENT 'Timestamp of prep.',
    `prep_type` STRING COMMENT 'Type of prep.',
    `prep_usage_status` STRING COMMENT 'Status of prep usage record.',
    `quality_grade` STRING COMMENT 'Quality grade.',
    `shift_code` STRING COMMENT 'Shift code.',
    `sku_code` STRING COMMENT 'A standardized code representing the sku classification for this prep usage',
    `temperature_at_prep_f` DECIMAL(18,2) COMMENT 'Temperature at prep in Fahrenheit.',
    `theoretical_cost` DECIMAL(18,2) COMMENT 'Theoretical cost.',
    `theoretical_quantity` DECIMAL(18,2) COMMENT 'Theoretical quantity.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Unit cost.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `variance_cost` DECIMAL(18,2) COMMENT 'Cost variance.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance percentage.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Variance quantity.',
    `waste_reason_code` STRING COMMENT 'Waste reason code.',
    CONSTRAINT pk_prep_usage PRIMARY KEY(`prep_usage_id`)
) COMMENT 'Records of ingredient usage during food preparation, tracking actual vs theoretical consumption and variances.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`item_category` (
    `item_category_id` BIGINT COMMENT 'Primary key.',
    `parent_item_category_id` BIGINT COMMENT 'Self-FK to parent item category.',
    `activation_date` DATE COMMENT 'Date category was activated.',
    `allergen_category` BOOLEAN COMMENT 'Whether this is an allergen category.',
    `category_description` STRING COMMENT 'Description of the category.',
    `category_level` STRING COMMENT 'Level in hierarchy.',
    `category_type` STRING COMMENT 'Type of category.',
    `cogs_budget_target_pct` DECIMAL(18,2) COMMENT 'COGS budget target percentage.',
    `commodity_type` STRING COMMENT 'Commodity type.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `cycle_count_frequency_days` STRING COMMENT 'Days between cycle counts.',
    `deactivation_date` DATE COMMENT 'Date category was deactivated.',
    `deactivation_reason` STRING COMMENT 'Reason for deactivation.',
    `default_margin_percent` DECIMAL(18,2) COMMENT 'Default margin percentage.',
    `default_par_level_days` STRING COMMENT 'Default par level in days.',
    `default_par_quantity` DECIMAL(18,2) COMMENT 'Default par quantity.',
    `default_shelf_life_days` STRING COMMENT 'Default shelf life in days.',
    `default_tax_rate_percent` DECIMAL(18,2) COMMENT 'Default tax rate percentage.',
    `default_unit_of_measure` STRING COMMENT 'Default unit of measure.',
    `default_waste_percent` DECIMAL(18,2) COMMENT 'Default waste percentage.',
    `item_category_description` STRING COMMENT 'Item category description.',
    `division` STRING COMMENT 'The division attribute value for this item category record in the inventory domain',
    `effective_from` DATE COMMENT 'Effective from date.',
    `effective_until` DATE COMMENT 'Effective until date.',
    `gl_account_code` STRING COMMENT 'GL account code.',
    `haccp_required` BOOLEAN COMMENT 'Whether HACCP is required.',
    `hierarchy_level` STRING COMMENT 'Hierarchy level.',
    `is_active` BOOLEAN COMMENT 'Whether category is active.',
    `is_perishable` BOOLEAN COMMENT 'Whether items are perishable.',
    `item_category_status` STRING COMMENT 'Status of item category.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Last reviewed timestamp.',
    `multi_sourcing_allowed` BOOLEAN COMMENT 'Whether multi-sourcing is allowed.',
    `notes` STRING COMMENT 'Free-text notes.',
    `primary_vendor_required` BOOLEAN COMMENT 'Whether primary vendor is required.',
    `procurement_lead_time_days` STRING COMMENT 'Procurement lead time in days.',
    `requires_expiration_tracking` DECIMAL(18,2) COMMENT 'Whether expiration tracking is required.',
    `requires_lot_tracking` BOOLEAN COMMENT 'Whether lot tracking is required.',
    `requires_temperature_control` BOOLEAN COMMENT 'Whether temperature control is required.',
    `shelf_life_days` STRING COMMENT 'Shelf life in days.',
    `sort_order` STRING COMMENT 'Sort order.',
    `tax_category_code` DECIMAL(18,2) COMMENT 'Tax category code.',
    `temperature_zone` STRING COMMENT 'Temperature zone.',
    `typical_waste_category` STRING COMMENT 'Typical waste category.',
    `typical_yield_percentage` DECIMAL(18,2) COMMENT 'Typical yield percentage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp.',
    `waste_tracking_enabled` BOOLEAN COMMENT 'Whether waste tracking is enabled.',
    `yield_management_enabled` DECIMAL(18,2) COMMENT 'Whether yield management is enabled.',
    CONSTRAINT pk_item_category PRIMARY KEY(`item_category_id`)
) COMMENT 'Hierarchical categorization of inventory items with associated management parameters and compliance requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` (
    `inventory_ingredient_usage_id` BIGINT COMMENT 'Primary key.',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee.',
    `ingredient_id` BIGINT COMMENT 'FK to ingredient.',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit.',
    `stock_item_id` BIGINT COMMENT 'FK to stock item.',
    `order_ingredient_usage_id` BIGINT COMMENT 'FK to order ingredient usage.',
    `actual_usage` DECIMAL(18,2) COMMENT 'Actual usage quantity.',
    `average_monthly_usage` DECIMAL(18,2) COMMENT 'Average monthly usage quantity.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Cost per unit.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `quantity_used` STRING COMMENT 'Quantity used.',
    `theoretical_quantity` DECIMAL(18,2) COMMENT 'Theoretical quantity.',
    `theoretical_usage` DECIMAL(18,2) COMMENT 'Theoretical usage quantity.',
    `total_usage_cost` DECIMAL(18,2) COMMENT 'Total cost of usage.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `uom` STRING COMMENT 'Unit of measure.',
    `usage_date` DATE COMMENT 'Date of usage.',
    `usage_period` STRING COMMENT 'Usage period identifier.',
    `usage_period_end` DATE COMMENT 'End of usage period.',
    `usage_period_start` DATE COMMENT 'Start of usage period.',
    `usage_type` STRING COMMENT 'Type of usage.',
    `variance` DECIMAL(18,2) COMMENT 'Variance between actual and theoretical.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Variance quantity.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'Waste quantity.',
    CONSTRAINT pk_inventory_ingredient_usage PRIMARY KEY(`inventory_ingredient_usage_id`)
) COMMENT 'Aggregated ingredient usage records linking inventory consumption to orders, tracking actual vs theoretical usage and variances.';

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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_subdomain' = 'item_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Item Specification ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `stock_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Supplier ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_subdomain' = 'item_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_equipment_equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID Alt');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` SET TAGS ('dbx_subdomain' = 'item_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `on_hand_balance_id` SET TAGS ('dbx_business_glossary_term' = 'On Hand Balance ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `on_stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `on_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` SET TAGS ('dbx_subdomain' = 'stock_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement PO ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Manager Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `posted_to_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted To Inventory Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `posted_to_inventory_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted To Inventory Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_location` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_location` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_number` SET TAGS ('dbx_business_glossary_term' = 'Receiving Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`receiving_order` ALTER COLUMN `receiving_shift` SET TAGS ('dbx_business_glossary_term' = 'Receiving Shift');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_subdomain' = 'stock_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'GL Journal Entry ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_id` SET TAGS ('dbx_business_glossary_term' = 'Recount Of Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_id` SET TAGS ('dbx_review_links' = 'reviewed');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_subdomain' = 'stock_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Waste GL Account ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Procurement Supplier ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `responsible_station` SET TAGS ('dbx_business_glossary_term' = 'Responsible Station');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'stock_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_restaurant_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `external_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'External Transfer Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'stock_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Replenishment Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Cancelled By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_fee` SET TAGS ('dbx_business_glossary_term' = 'Shipping Fee');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `supplier_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` SET TAGS ('dbx_subdomain' = 'cost_analysis');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `actual_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `cost_per_raw_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Raw Unit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `cost_per_yield_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Yield Unit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `haccp_compliant` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliant');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_date` SET TAGS ('dbx_business_glossary_term' = 'Prep Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_station_code` SET TAGS ('dbx_business_glossary_term' = 'Prep Station Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_station_name` SET TAGS ('dbx_business_glossary_term' = 'Prep Station Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_station_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prep Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `prep_type` SET TAGS ('dbx_business_glossary_term' = 'Prep Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `raw_quantity_in` SET TAGS ('dbx_business_glossary_term' = 'Raw Quantity In');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `raw_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Raw Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `recipe_component_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Component Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `recipe_component_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `standard_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Standard Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `temperature_at_prep_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature At Prep F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `total_raw_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Raw Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `usable_yield_quantity_out` SET TAGS ('dbx_business_glossary_term' = 'Usable Yield Quantity Out');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `waste_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Waste Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Yield Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`yield_record` ALTER COLUMN `yield_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` SET TAGS ('dbx_subdomain' = 'stock_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` SET TAGS ('dbx_ssot_canonical' = 'loyalty.loyalty_adjustment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `inventory_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `foodsafety_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Corrective Action ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Receiving Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `inventory_related_receiving_receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Receiving Order ID Alt');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Related Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `inventory_related_transfer_stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transfer Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `reversal_adjustment_inventory_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `impacts_cogs` SET TAGS ('dbx_business_glossary_term' = 'Impacts COGS');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `is_reversed` SET TAGS ('dbx_business_glossary_term' = 'Is Reversed');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `is_shrinkage` SET TAGS ('dbx_business_glossary_term' = 'Is Shrinkage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `on_hand_quantity_after` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity After');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `on_hand_quantity_before` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity Before');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `temperature_at_adjustment_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature At Adjustment F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_adjustment` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` SET TAGS ('dbx_subdomain' = 'cost_analysis');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_cost_period_id` SET TAGS ('dbx_business_glossary_term' = 'Food Cost Period ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Food Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `purchases_value` SET TAGS ('dbx_business_glossary_term' = 'Purchases Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `theoretical_food_cost` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Food Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `total_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Revenue');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `transfers_in_value` SET TAGS ('dbx_business_glossary_term' = 'Transfers In Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `transfers_out_value` SET TAGS ('dbx_business_glossary_term' = 'Transfers Out Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `waste_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Percent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`food_cost_period` ALTER COLUMN `waste_value` SET TAGS ('dbx_business_glossary_term' = 'Waste Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` SET TAGS ('dbx_subdomain' = 'item_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'UOM ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `base_uom_id` SET TAGS ('dbx_business_glossary_term' = 'Base UOM ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `abbreviation` SET TAGS ('dbx_business_glossary_term' = 'Abbreviation');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `allows_fractional_quantities` SET TAGS ('dbx_business_glossary_term' = 'Allows Fractional Quantities');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `allows_temperature_tracking` SET TAGS ('dbx_business_glossary_term' = 'Allows Temperature Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `applicable_item_categories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Item Categories');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_category` SET TAGS ('dbx_business_glossary_term' = 'UOM Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_code` SET TAGS ('dbx_business_glossary_term' = 'UOM Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `conversion_factor_to_base` SET TAGS ('dbx_business_glossary_term' = 'Conversion Factor To Base');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `default_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Default Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `is_base_uom` SET TAGS ('dbx_business_glossary_term' = 'Is Base UOM');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `is_system_standard` SET TAGS ('dbx_business_glossary_term' = 'Is System Standard');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `iso_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_name` SET TAGS ('dbx_business_glossary_term' = 'UOM Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `ordering_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Ordering UOM Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `plural_name` SET TAGS ('dbx_business_glossary_term' = 'Plural Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `plural_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `precision_decimal_places` SET TAGS ('dbx_business_glossary_term' = 'Precision Decimal Places');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `recipe_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Recipe UOM Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `requires_lot_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Lot Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `storage_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Storage UOM Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `symbol` SET TAGS ('dbx_business_glossary_term' = 'Symbol');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `un_cefact_code` SET TAGS ('dbx_business_glossary_term' = 'UN CEFACT Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_status` SET TAGS ('dbx_business_glossary_term' = 'UOM Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`uom` ALTER COLUMN `uom_type` SET TAGS ('dbx_business_glossary_term' = 'UOM Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` SET TAGS ('dbx_subdomain' = 'item_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Expense GL Account ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `primary_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Procurement Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Supplier ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Brand Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_brand_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Vendor Priority Rank');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_product_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Product Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`vendor_item` ALTER COLUMN `vendor_sku` SET TAGS ('dbx_business_glossary_term' = 'Vendor SKU');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` SET TAGS ('dbx_subdomain' = 'item_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_eggs` SET TAGS ('dbx_business_glossary_term' = 'Allergen Eggs');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Allergen Fish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Allergen Milk');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_peanuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen Peanuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Allergen Shellfish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_soybeans` SET TAGS ('dbx_business_glossary_term' = 'Allergen Soybeans');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_tree_nuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen Tree Nuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Allergen Wheat');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `best_by_date` SET TAGS ('dbx_business_glossary_term' = 'Best By Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `condition_at_receiving` SET TAGS ('dbx_business_glossary_term' = 'Condition At Receiving');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_code` SET TAGS ('dbx_business_glossary_term' = 'Lot Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `temperature_at_receiving_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature At Receiving F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`lot_tracking` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` SET TAGS ('dbx_subdomain' = 'cost_analysis');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Prep Usage ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
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
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `haccp_compliant` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliant');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_date` SET TAGS ('dbx_business_glossary_term' = 'Prep Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_station_code` SET TAGS ('dbx_business_glossary_term' = 'Prep Station Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_station_name` SET TAGS ('dbx_business_glossary_term' = 'Prep Station Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_station_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_task_reference` SET TAGS ('dbx_business_glossary_term' = 'Prep Task Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prep Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_type` SET TAGS ('dbx_business_glossary_term' = 'Prep Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_usage_status` SET TAGS ('dbx_business_glossary_term' = 'Prep Usage Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'SKU Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `temperature_at_prep_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature At Prep F');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `theoretical_cost` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `theoretical_quantity` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_cost` SET TAGS ('dbx_business_glossary_term' = 'Variance Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` SET TAGS ('dbx_subdomain' = 'item_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `item_category_id` SET TAGS ('dbx_business_glossary_term' = 'Item Category ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `parent_item_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Item Category ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `allergen_category` SET TAGS ('dbx_business_glossary_term' = 'Allergen Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `cogs_budget_target_pct` SET TAGS ('dbx_business_glossary_term' = 'COGS Budget Target Pct');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Margin Percent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_par_level_days` SET TAGS ('dbx_business_glossary_term' = 'Default Par Level Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_par_quantity` SET TAGS ('dbx_business_glossary_term' = 'Default Par Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Default Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Tax Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Default Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `default_waste_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Waste Percent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `item_category_description` SET TAGS ('dbx_business_glossary_term' = 'Item Category Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `haccp_required` SET TAGS ('dbx_business_glossary_term' = 'HACCP Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `item_category_status` SET TAGS ('dbx_business_glossary_term' = 'Item Category Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `multi_sourcing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Multi Sourcing Allowed');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `primary_vendor_required` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `requires_expiration_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Expiration Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `requires_lot_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Lot Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `requires_temperature_control` SET TAGS ('dbx_business_glossary_term' = 'Requires Temperature Control');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `typical_waste_category` SET TAGS ('dbx_business_glossary_term' = 'Typical Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `typical_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Typical Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `waste_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Waste Tracking Enabled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`item_category` ALTER COLUMN `yield_management_enabled` SET TAGS ('dbx_business_glossary_term' = 'Yield Management Enabled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_subdomain' = 'cost_analysis');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_association_edges' = 'supply.ingredient,franchise.franchisee');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` SET TAGS ('dbx_ssot_canonical' = 'order.order_ingredient_usage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `inventory_ingredient_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Ingredient Usage ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `order_ingredient_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Order Ingredient Usage ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `actual_usage` SET TAGS ('dbx_business_glossary_term' = 'Actual Usage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `average_monthly_usage` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Usage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Quantity Used');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `theoretical_quantity` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `theoretical_usage` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Usage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `total_usage_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Usage Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'UOM');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `usage_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `usage_period` SET TAGS ('dbx_business_glossary_term' = 'Usage Period');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `usage_period_end` SET TAGS ('dbx_business_glossary_term' = 'Usage Period End');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `usage_period_start` SET TAGS ('dbx_business_glossary_term' = 'Usage Period Start');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
