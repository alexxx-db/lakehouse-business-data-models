-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`supply` COMMENT 'Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` (
    `supply_supplier_id` BIGINT COMMENT 'Primary key',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier master for SSOT linkage',
    `address_line1` STRING COMMENT 'Street address line 1',
    `average_lead_time_days` STRING COMMENT 'Average delivery lead time in days',
    `city` STRING COMMENT 'City of supplier headquarters',
    `contact_email` STRING COMMENT 'Primary contact email address',
    `contact_name` STRING COMMENT 'Primary contact person name',
    `contact_phone` STRING COMMENT 'Primary contact phone number',
    `country_code` STRING COMMENT 'ISO country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Default transaction currency ISO code',
    `food_safety_certified_flag` BOOLEAN COMMENT 'Whether supplier holds food safety certification',
    `is_approved` BOOLEAN COMMENT 'Whether supplier has passed approval process',
    `legal_name` STRING COMMENT 'Registered legal entity name',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Historical on-time delivery percentage',
    `onboarded_date` DATE COMMENT 'Date supplier was onboarded',
    `payment_terms` STRING COMMENT 'Default payment terms (Net30, Net60)',
    `postal_code` STRING COMMENT 'Postal/ZIP code',
    `preferred_flag` BOOLEAN COMMENT 'Whether this is a preferred supplier',
    `quality_rating` DECIMAL(18,2) COMMENT 'Composite quality score',
    `region` STRING COMMENT 'Geographic region for sourcing',
    `state_province` STRING COMMENT 'State or province',
    `supplier_code` STRING COMMENT 'Unique business code for the supplier',
    `supplier_name` STRING COMMENT 'Legal or trading name of the supplier',
    `supplier_status` STRING COMMENT 'Current status (active, suspended, terminated)',
    `supplier_type` STRING COMMENT 'Classification (distributor, manufacturer, broker)',
    `tax_identifier` STRING COMMENT 'Tax ID / EIN of the supplier',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_supply_supplier PRIMARY KEY(`supply_supplier_id`)
) COMMENT 'Master record for suppliers providing ingredients and goods to the restaurant supply chain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient` (
    `ingredient_id` BIGINT COMMENT 'Primary key',
    `haccp_plan_id` BIGINT COMMENT 'FK to HACCP plan governing this ingredient',
    `item_specification_id` BIGINT COMMENT 'FK to procurement item specification',
    `allergen_flags` STRING COMMENT 'Comma-separated allergen indicators',
    `carbohydrate_content_percent` DECIMAL(18,2) COMMENT 'Carbohydrate content as percentage',
    `ingredient_category` STRING COMMENT 'High-level category (protein, dairy, produce)',
    `ingredient_code` STRING COMMENT 'Unique business code',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost per unit',
    `country_of_origin` STRING COMMENT 'Primary sourcing country',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency for cost',
    `effective_from` DATE COMMENT 'Date ingredient became active',
    `effective_until` DATE COMMENT 'Date ingredient was discontinued',
    `fat_content_percent` DECIMAL(18,2) COMMENT 'Fat content as percentage',
    `haccp_classification` STRING COMMENT 'HACCP risk classification level',
    `halal_flag` BOOLEAN COMMENT 'Whether ingredient is halal certified',
    `ingredient_status` STRING COMMENT 'Lifecycle status (active, discontinued)',
    `inspection_status` STRING COMMENT 'Last inspection result status',
    `kosher_flag` BOOLEAN COMMENT 'Whether ingredient is kosher certified',
    `last_inspection_date` DATE COMMENT 'Date of last quality inspection',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time',
    `ingredient_name` STRING COMMENT 'Display name of the ingredient',
    `non_gmo_flag` BOOLEAN COMMENT 'Whether ingredient is non-GMO verified',
    `nutritional_calories_per_unit` DECIMAL(18,2) COMMENT 'Calories per standard unit',
    `organic_flag` BOOLEAN COMMENT 'Whether ingredient is certified organic',
    `packaging_type` STRING COMMENT 'Type of packaging (case, bag, pail)',
    `par_level` STRING COMMENT 'Minimum stock level before reorder',
    `protein_content_percent` DECIMAL(18,2) COMMENT 'Protein content as percentage',
    `shelf_life_days` STRING COMMENT 'Expected shelf life in days',
    `sodium_mg_per_unit` DECIMAL(18,2) COMMENT 'Sodium in mg per unit',
    `standard_weight_per_unit` DECIMAL(18,2) COMMENT 'Standard weight per unit in grams',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Required storage temperature in Celsius',
    `sub_category` STRING COMMENT 'Sub-category within the main category',
    `traceability_batch_number` STRING COMMENT 'Current traceability batch reference',
    `unit_of_measure` STRING COMMENT 'Standard UOM for ordering/usage',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `usda_grade` STRING COMMENT 'USDA quality grade if applicable',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Expected waste/trim percentage',
    CONSTRAINT pk_ingredient PRIMARY KEY(`ingredient_id`)
) COMMENT 'Master catalog of ingredients used in restaurant recipes and menu items.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` (
    `supply_purchase_order_id` BIGINT COMMENT 'Primary key',
    `distribution_center_id` BIGINT COMMENT 'FK to distribution center if DC-level order',
    `franchisee_id` BIGINT COMMENT 'FK to franchisee placing order',
    `procurement_purchase_order_id` BIGINT COMMENT 'FK to procurement PO for SSOT linkage',
    `site_id` BIGINT COMMENT 'FK to delivery site',
    `supply_supplier_id` BIGINT COMMENT 'FK to supplier',
    `unit_id` BIGINT COMMENT 'FK to ordering restaurant unit',
    `approval_status` STRING COMMENT 'Approval workflow status',
    `approved_by` STRING COMMENT 'Name/ID of approver',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `expected_delivery_date` DATE COMMENT 'Supplier-confirmed expected delivery date',
    `is_approved` BOOLEAN COMMENT 'Whether PO has been approved',
    `line_item_count` STRING COMMENT 'Number of line items on the PO',
    `notes` STRING COMMENT 'Free-text notes',
    `order_date` DATE COMMENT 'Date the PO was placed',
    `payment_terms` STRING COMMENT 'Payment terms on this PO',
    `purchase_order_number` STRING COMMENT 'Human-readable PO number',
    `purchase_order_status` STRING COMMENT 'Current PO status (draft, submitted, approved, received, closed)',
    `requested_delivery_date` DATE COMMENT 'The date and time when the requested delivery event occurred for this supply purchase order',
    `ship_to_location` STRING COMMENT 'Delivery address or location code',
    `shipping_method` STRING COMMENT 'Shipping/delivery method',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the PO',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_supply_purchase_order PRIMARY KEY(`supply_purchase_order_id`)
) COMMENT 'Purchase orders placed with suppliers for ingredients and supplies.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Primary key',
    `ingredient_id` BIGINT COMMENT 'FK to ingredient being ordered',
    `supply_purchase_order_id` BIGINT COMMENT 'FK to parent purchase order',
    `unit_id` BIGINT COMMENT 'FK to receiving restaurant unit',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to the line',
    `expected_delivery_date` DATE COMMENT 'Expected delivery date for this line',
    `extended_amount` DECIMAL(18,2) COMMENT 'Total line amount (qty x price)',
    `item_description` STRING COMMENT 'Description of the line item',
    `line_sequence` STRING COMMENT 'Line number sequence on the PO',
    `line_status` STRING COMMENT 'Status of this line (open, partial, received, cancelled)',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity ordered',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity actually received',
    `sku` STRING COMMENT 'Supplier SKU code',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount on the line',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the line',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Individual line items on a supply purchase order specifying ingredient, quantity, and price.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key',
    `contract_id` BIGINT COMMENT 'FK to governing contract',
    `cost_center_id` BIGINT COMMENT 'FK to cost center for accounting',
    `distribution_center_id` BIGINT COMMENT 'FK to distribution center if DC receipt',
    `employee_id` BIGINT COMMENT 'FK to employee who received goods',
    `procurement_purchase_order_id` BIGINT COMMENT 'FK to procurement PO',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `unit_id` BIGINT COMMENT 'FK to receiving restaurant unit',
    `batch_number` STRING COMMENT 'Batch/lot number from supplier',
    `comments` STRING COMMENT 'Free-text comments',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `goods_receipt_status` STRING COMMENT 'Status (pending, complete, partial)',
    `is_cold_chain_compliant` BOOLEAN COMMENT 'Whether cold chain was maintained',
    `lot_number` STRING COMMENT 'Lot tracking number',
    `purchase_order_number` STRING COMMENT 'Reference PO number',
    `receipt_number` STRING COMMENT 'Unique receipt document number',
    `receipt_timestamp` TIMESTAMP COMMENT 'Timestamp goods were received',
    `receiving_method` STRING COMMENT 'Method of receiving (dock, curbside)',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature at time of receipt',
    `temperature_deviation_flag` BOOLEAN COMMENT 'Whether temperature was out of spec',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of received goods',
    `total_quantity` DECIMAL(18,2) COMMENT 'Total quantity received',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Header record for receiving goods against a purchase order at a restaurant or distribution center.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` (
    `goods_receipt_line_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to receiving employee',
    `gl_account_id` BIGINT COMMENT 'FK to GL account for posting',
    `goods_receipt_id` BIGINT COMMENT 'FK to parent goods receipt',
    `purchase_order_line_id` BIGINT COMMENT 'FK to PO line being received against',
    `stock_location_id` BIGINT COMMENT 'FK to storage location',
    `compliance_flag` BOOLEAN COMMENT 'Whether line meets compliance requirements',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `inspection_status` STRING COMMENT 'Quality inspection result',
    `is_perishable` BOOLEAN COMMENT 'Whether item is perishable',
    `is_returned` BOOLEAN COMMENT 'Whether item was returned to supplier',
    `item_description` STRING COMMENT 'Description of received item',
    `line_sequence` STRING COMMENT 'Line sequence number',
    `lot_number` STRING COMMENT 'Lot/batch number',
    `notes` STRING COMMENT 'Free-text notes',
    `quality_score` DECIMAL(18,2) COMMENT 'Quality score assigned',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity received',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity rejected on inspection',
    `sku` STRING COMMENT 'SKU of received item',
    `supplier_batch_number` STRING COMMENT 'Supplier batch reference',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Temperature at receipt',
    `total_cost` DECIMAL(18,2) COMMENT 'Total line cost',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute value for this goods receipt line record in the supply domain',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price attribute value for this goods receipt line record in the supply domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary variance',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Variance between ordered and received',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight in kilograms',
    CONSTRAINT pk_goods_receipt_line PRIMARY KEY(`goods_receipt_line_id`)
) COMMENT 'Line-level detail for goods received, including quantity, quality, and cost information.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key',
    `ap_invoice_id` BIGINT COMMENT 'FK to finance AP invoice',
    `goods_receipt_id` BIGINT COMMENT 'FK to goods receipt for matching',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `supply_purchase_order_id` BIGINT COMMENT 'FK to related PO',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `due_date` DATE COMMENT 'Payment due date',
    `invoice_date` DATE COMMENT 'Date on the invoice',
    `invoice_number` STRING COMMENT 'Supplier invoice number',
    `invoice_status` STRING COMMENT 'Status (received, matched, approved, paid, disputed)',
    `match_status` STRING COMMENT 'Three-way match status (matched, exception)',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount before tax',
    `notes` STRING COMMENT 'Free-text notes',
    `paid_date` DATE COMMENT 'Date payment was made',
    `payment_status` STRING COMMENT 'Payment status (unpaid, partial, paid)',
    `payment_terms` STRING COMMENT 'Payment terms on invoice',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax portion of invoice',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross invoice amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Supplier invoices received for goods and services, linked to POs and goods receipts for three-way matching.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'Primary key',
    `contract_id` BIGINT COMMENT 'FK to procurement contract for SSOT linkage',
    `employee_id` BIGINT COMMENT 'FK to contract owner',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `compliance_status` STRING COMMENT 'Compliance review status',
    `confidentiality_clause` BOOLEAN COMMENT 'Whether NDA/confidentiality clause exists',
    `contract_description` STRING COMMENT 'Description of contract scope',
    `contract_document_url` STRING COMMENT 'URL to contract document',
    `contract_type` STRING COMMENT 'Type of contract (blanket, spot, framework)',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `data_protection_clause` BOOLEAN COMMENT 'Whether data protection clause exists',
    `default_price` DECIMAL(18,2) COMMENT 'Default unit price in contract',
    `delivery_terms` STRING COMMENT 'Delivery/shipping terms',
    `effective_from` DATE COMMENT 'Contract effective start date',
    `effective_until` DATE COMMENT 'Contract effective end date',
    `exclusivity_flag` BOOLEAN COMMENT 'Whether contract grants exclusivity',
    `exclusivity_region` STRING COMMENT 'Region of exclusivity if applicable',
    `executed_date` DATE COMMENT 'Date contract was executed',
    `governing_law` STRING COMMENT 'Governing law jurisdiction',
    `liability_limit` DECIMAL(18,2) COMMENT 'Maximum liability amount',
    `payment_terms` STRING COMMENT 'The payment terms attribute value for this supplier contract record in the supply domain',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Volume rebate percentage',
    `rebate_threshold_amount` DECIMAL(18,2) COMMENT 'Spend threshold to trigger rebate',
    `renewal_notice_period_days` STRING COMMENT 'Days notice required for renewal',
    `renewal_type` STRING COMMENT 'Renewal type (auto, manual, none)',
    `shipping_method` STRING COMMENT 'Default shipping method',
    `signed_date` DATE COMMENT 'Date contract was signed',
    `supplier_contract_status` STRING COMMENT 'Status (draft, active, expired, terminated)',
    `termination_notice_period_days` STRING COMMENT 'Days notice required for termination',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `volume_tier_1_min` STRING COMMENT 'Minimum quantity for tier 1 pricing',
    `volume_tier_1_price` DECIMAL(18,2) COMMENT 'Price at tier 1 volume',
    `volume_tier_2_min` STRING COMMENT 'Minimum quantity for tier 2 pricing',
    `volume_tier_2_price` DECIMAL(18,2) COMMENT 'Price at tier 2 volume',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Detailed contract records with suppliers including pricing, terms, compliance, and renewal information.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`contract_price` (
    `contract_price_id` BIGINT COMMENT 'Primary key',
    `contract_id` BIGINT COMMENT 'FK to procurement contract',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `stock_item_id` BIGINT COMMENT 'FK to stock item',
    `contract_price_status` STRING COMMENT 'Status (active, superseded, expired)',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `effective_from` DATE COMMENT 'Price effective start date',
    `effective_until` DATE COMMENT 'Price effective end date',
    `is_current` BOOLEAN COMMENT 'Whether this is the current active price',
    `price_amount` DECIMAL(18,2) COMMENT 'Contracted price amount',
    `price_change_reason` STRING COMMENT 'Reason for price change',
    `price_index_reference` STRING COMMENT 'Reference index for indexed pricing',
    `price_tier_max_qty` DECIMAL(18,2) COMMENT 'Maximum quantity for this price tier',
    `price_tier_min_qty` DECIMAL(18,2) COMMENT 'Minimum quantity for this price tier',
    `price_type` STRING COMMENT 'Type (fixed, indexed, formula)',
    `unit_of_measure` STRING COMMENT 'UOM for the price',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_contract_price PRIMARY KEY(`contract_price_id`)
) COMMENT 'Price schedules within supplier contracts, supporting tiered and time-bound pricing.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` (
    `supplier_performance_id` BIGINT COMMENT 'Primary key',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `audit_findings_count` STRING COMMENT 'Number of audit findings',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'Average lead time in days',
    `contract_compliance_flag` BOOLEAN COMMENT 'Whether supplier is contract-compliant',
    `corrective_action_flag` BOOLEAN COMMENT 'Whether corrective action is pending',
    `fill_rate` DECIMAL(18,2) COMMENT 'Order fill rate percentage',
    `food_safety_compliance_score` DECIMAL(18,2) COMMENT 'The food safety compliance score attribute value for this supplier performance record in the supply domain',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of accurate invoices',
    `last_audit_date` DATE COMMENT 'Date of last supplier audit',
    `measurement_period_end` DATE COMMENT 'End of measurement period',
    `measurement_period_start` DATE COMMENT 'Start of measurement period',
    `notes` STRING COMMENT 'Performance notes',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of on-time deliveries',
    `order_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of accurate orders',
    `quality_rejection_rate` DECIMAL(18,2) COMMENT 'Percentage of items rejected for quality',
    `rating_tier` STRING COMMENT 'Overall rating tier (gold, silver, bronze)',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `total_invoices_evaluated` STRING COMMENT 'Number of invoices in evaluation period',
    `total_orders_evaluated` STRING COMMENT 'Number of orders in evaluation period',
    CONSTRAINT pk_supplier_performance PRIMARY KEY(`supplier_performance_id`)
) COMMENT 'Periodic performance measurements for suppliers covering delivery, quality, and compliance metrics.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` (
    `distribution_center_id` BIGINT COMMENT 'Primary key',
    `legal_entity_id` BIGINT COMMENT 'FK to owning legal entity',
    `address_line1` STRING COMMENT 'Street address',
    `city` STRING COMMENT 'The city attribute value for this distribution center record in the supply domain',
    `country` STRING COMMENT 'The country attribute value for this distribution center record in the supply domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cross_dock_enabled` BOOLEAN COMMENT 'Whether cross-docking is supported',
    `dc_code` STRING COMMENT 'Unique DC code',
    `distribution_center_status` STRING COMMENT 'Operational status (active, closed, under_construction)',
    `emergency_contact_phone` STRING COMMENT 'Emergency contact phone number',
    `facility_type` STRING COMMENT 'Type (warehouse, cold_storage, cross_dock)',
    `haccp_compliant` BOOLEAN COMMENT 'Whether HACCP compliant',
    `inspection_score` DECIMAL(18,2) COMMENT 'Last inspection score',
    `last_inspection_date` DATE COMMENT 'Date of last inspection',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude',
    `distribution_center_name` STRING COMMENT 'Name of the distribution center',
    `number_of_loading_docks` STRING COMMENT 'The number of loading docks attribute value for this distribution center record in the supply domain',
    `operating_hours` STRING COMMENT 'Operating hours description',
    `ownership_type` STRING COMMENT 'Ownership (owned, leased, 3PL)',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification for this distribution center',
    `region` STRING COMMENT 'Operating region',
    `security_level` STRING COMMENT 'Security classification',
    `state_province` STRING COMMENT 'State or province',
    `storage_capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Total storage capacity',
    `supported_restaurant_count` STRING COMMENT 'Number of restaurants served',
    `temperature_control_system` STRING COMMENT 'Type of temperature control',
    `temperature_monitoring_interval_minutes` STRING COMMENT 'Monitoring frequency in minutes',
    `third_party_logistics_flag` BOOLEAN COMMENT 'Whether operated by 3PL',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `waste_management_certified` BOOLEAN COMMENT 'Whether waste management certified',
    CONSTRAINT pk_distribution_center PRIMARY KEY(`distribution_center_id`)
) COMMENT 'Physical distribution centers and warehouses that store and ship ingredients to restaurant units.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` (
    `inbound_shipment_id` BIGINT COMMENT 'Primary key',
    `contract_id` BIGINT COMMENT 'FK to governing contract',
    `site_id` BIGINT COMMENT 'FK to destination site',
    `procurement_purchase_order_id` BIGINT COMMENT 'FK to procurement PO',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `unit_id` BIGINT COMMENT 'FK to destination restaurant unit',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual arrival time',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual departure time',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading reference',
    `carrier_name` STRING COMMENT 'Carrier company name',
    `carrier_scac_code` STRING COMMENT 'Standard carrier alpha code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `delay_minutes` STRING COMMENT 'Delay in minutes if late',
    `destination_location_code` STRING COMMENT 'A standardized code representing the destination location classification for this inbound shipment',
    `exception_reason` STRING COMMENT 'Reason for any exception',
    `freight_cost` DECIMAL(18,2) COMMENT 'The freight cost attribute value for this inbound shipment record in the supply domain',
    `freight_terms` STRING COMMENT 'Freight terms (FOB, CIF)',
    `hazard_material_flag` BOOLEAN COMMENT 'Whether contains hazardous materials',
    `is_expedited` BOOLEAN COMMENT 'Whether shipment is expedited',
    `number_of_items` STRING COMMENT 'Number of items in shipment',
    `origin_location_code` STRING COMMENT 'A standardized code representing the origin location classification for this inbound shipment',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Scheduled arrival time',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Scheduled departure time',
    `seal_number` STRING COMMENT 'Container seal number',
    `shipment_number` STRING COMMENT 'Unique shipment tracking number',
    `shipment_status` STRING COMMENT 'Status (in_transit, delivered, delayed)',
    `temperature_control_flag` BOOLEAN COMMENT 'Whether temperature controlled',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature requirement',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature requirement',
    `transport_mode` STRING COMMENT 'Mode of transport (truck, rail, air)',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Total volume in cubic meters',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kg',
    CONSTRAINT pk_inbound_shipment PRIMARY KEY(`inbound_shipment_id`)
) COMMENT 'Tracking of inbound shipments from suppliers to distribution centers or restaurant units.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` (
    `ingredient_lot_id` BIGINT COMMENT 'Primary key',
    `haccp_plan_id` BIGINT COMMENT 'FK to HACCP plan',
    `ingredient_id` BIGINT COMMENT 'FK to ingredient master',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit holding the lot',
    `batch_number` STRING COMMENT 'Supplier batch number',
    `best_by_date` DATE COMMENT 'Best-by/use-by date',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Cost per unit for this lot',
    `country_of_origin` STRING COMMENT 'The country of origin attribute value for this ingredient lot record in the supply domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this ingredient lot',
    `external_traceability_code` STRING COMMENT 'External traceability reference',
    `inspection_status` STRING COMMENT 'Quality inspection status',
    `lot_number` STRING COMMENT 'Unique lot number',
    `lot_status` STRING COMMENT 'Status (available, quarantined, recalled, consumed)',
    `lot_type` STRING COMMENT 'Type of lot (raw, processed)',
    `organic_certified` BOOLEAN COMMENT 'Whether organic certified',
    `production_date` DATE COMMENT 'Date of production',
    `quality_score` DECIMAL(18,2) COMMENT 'The quality score attribute value for this ingredient lot record in the supply domain',
    `quantity` DECIMAL(18,2) COMMENT 'Current quantity on hand',
    `recall_flag` BOOLEAN COMMENT 'Whether lot is under recall',
    `recall_reason` STRING COMMENT 'Reason for recall if applicable',
    `received_date` DATE COMMENT 'Date received at location',
    `storage_location` STRING COMMENT 'Physical storage location',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Required storage temperature',
    `supplier_code` STRING COMMENT 'Supplier code reference',
    `supplier_lot_reference` STRING COMMENT 'Supplier lot reference number',
    `temperature_controlled` BOOLEAN COMMENT 'Whether temperature controlled',
    `total_cost` DECIMAL(18,2) COMMENT 'Total lot cost',
    `traceability_enabled` BOOLEAN COMMENT 'Whether full traceability is enabled',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute value for this ingredient lot record in the supply domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Waste percentage for this lot',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Yield percentage for this lot',
    CONSTRAINT pk_ingredient_lot PRIMARY KEY(`ingredient_lot_id`)
) COMMENT 'Lot-level tracking of ingredients for traceability, quality, and recall management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` (
    `quality_inspection_id` BIGINT COMMENT 'Primary key',
    `haccp_plan_id` BIGINT COMMENT 'FK to HACCP plan',
    `employee_id` BIGINT COMMENT 'FK to inspector employee',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `site_id` BIGINT COMMENT 'FK to inspection site',
    `compliance_flag` BOOLEAN COMMENT 'Whether item is compliant',
    `corrective_action_due_date` DATE COMMENT 'Due date for corrective action',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action needed',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `defect_category` STRING COMMENT 'Category of defect if found',
    `disposition_action` STRING COMMENT 'Disposition (accept, reject, return, destroy)',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Humidity reading during inspection',
    `inspection_method` STRING COMMENT 'Method used (visual, lab, instrument)',
    `inspection_notes` STRING COMMENT 'Inspector notes',
    `inspection_result` STRING COMMENT 'Result (pass, fail, conditional)',
    `inspection_timestamp` TIMESTAMP COMMENT 'When inspection was performed',
    `inspection_type` STRING COMMENT 'Type of inspection (receiving, periodic, random)',
    `lot_number` STRING COMMENT 'Lot number inspected',
    `quality_inspection_status` STRING COMMENT 'Status (pending, complete, cancelled)',
    `regulatory_reference` STRING COMMENT 'Regulatory standard reference',
    `rejection_quantity` DECIMAL(18,2) COMMENT 'Quantity rejected',
    `sku` STRING COMMENT 'SKU inspected',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature reading during inspection',
    `unit_of_measure` STRING COMMENT 'UOM for rejection quantity',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_quality_inspection PRIMARY KEY(`quality_inspection_id`)
) COMMENT 'Quality inspections performed on received ingredients and supplies.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`recall_event` (
    `recall_event_id` BIGINT COMMENT 'Primary key',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier involved in recall',
    `affected_dc_locations` STRING COMMENT 'Affected distribution centers',
    `affected_ingredient_sku` STRING COMMENT 'SKU of affected ingredient',
    `affected_lot_numbers` STRING COMMENT 'Affected lot numbers (comma-separated)',
    `affected_restaurant_locations` STRING COMMENT 'The affected restaurant locations attribute value for this recall event record in the supply domain',
    `compliance_fda` BOOLEAN COMMENT 'Whether FDA notified',
    `compliance_haccp` BOOLEAN COMMENT 'Whether HACCP protocols followed',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `disposal_method` STRING COMMENT 'Method of disposal',
    `notes` STRING COMMENT 'Additional notes',
    `product_category` STRING COMMENT 'Category of recalled product',
    `quantity_recalled` DECIMAL(18,2) COMMENT 'Total quantity recalled',
    `recall_class` STRING COMMENT 'FDA recall class (I, II, III)',
    `recall_closure_timestamp` TIMESTAMP COMMENT 'When recall was closed',
    `recall_initiation_timestamp` TIMESTAMP COMMENT 'When recall was initiated',
    `recall_number` STRING COMMENT 'Unique recall reference number',
    `recall_reason` STRING COMMENT 'Reason for the recall',
    `recall_severity` STRING COMMENT 'Severity level',
    `recall_status` STRING COMMENT 'Status (initiated, in_progress, closed)',
    `recall_type` STRING COMMENT 'Type (voluntary, mandatory, market_withdrawal)',
    `regulatory_notification_status` STRING COMMENT 'Status of regulatory notifications',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score',
    `temperature_deviation_flag` BOOLEAN COMMENT 'Whether temperature deviation was involved',
    `total_cost` DECIMAL(18,2) COMMENT 'Total financial impact',
    `unit_of_measure` STRING COMMENT 'UOM for recalled quantity',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_recall_event PRIMARY KEY(`recall_event_id`)
) COMMENT 'Product and ingredient recall events tracking affected items, severity, and resolution.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` (
    `commodity_category_id` BIGINT COMMENT 'Primary key',
    `parent_commodity_category_id` BIGINT COMMENT 'FK to parent category for hierarchy',
    `average_cost_per_unit` DECIMAL(18,2) COMMENT 'Average cost per unit in category',
    `average_lead_time_days` STRING COMMENT 'Average lead time for category',
    `commodity_category_code` STRING COMMENT 'Unique category code',
    `commodity_category_status` STRING COMMENT 'Status (active, inactive)',
    `commodity_type` STRING COMMENT 'Type (food, packaging, chemicals, equipment)',
    `compliance_requirements` STRING COMMENT 'Compliance requirements description',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `commodity_category_description` STRING COMMENT 'Description of the category',
    `effective_from` DATE COMMENT 'Effective start date',
    `effective_until` DATE COMMENT 'Effective end date',
    `hierarchy_level` STRING COMMENT 'Level in the hierarchy (1=top)',
    `is_leaf_category` BOOLEAN COMMENT 'Whether this is a leaf node',
    `is_perishable` BOOLEAN COMMENT 'Whether items in category are perishable',
    `commodity_category_name` STRING COMMENT 'Category name',
    `notes` STRING COMMENT 'Additional notes',
    `primary_buyer_owner` STRING COMMENT 'Primary buyer/category manager',
    `risk_level` STRING COMMENT 'Supply risk level (low, medium, high)',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score',
    `spend_percentage` DECIMAL(18,2) COMMENT 'Percentage of total spend',
    `strategic_sourcing_tier` DECIMAL(18,2) COMMENT 'Strategic sourcing tier classification',
    `typical_cogs_percent` DECIMAL(18,2) COMMENT 'Typical COGS percentage',
    `unit_of_measure` STRING COMMENT 'Default UOM for category',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_commodity_category PRIMARY KEY(`commodity_category_id`)
) COMMENT 'Hierarchical classification of commodities for spend analysis, sourcing strategy, and supplier categorization.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` (
    `supply_contract_id` BIGINT COMMENT 'Primary key',
    `commodity_category_id` BIGINT COMMENT 'FK to commodity category',
    `contract_id` BIGINT COMMENT 'FK to procurement contract for SSOT linkage',
    `site_id` BIGINT COMMENT 'FK to site',
    `supply_supplier_id` BIGINT COMMENT 'FK to supplier',
    `auto_renew_flag` BOOLEAN COMMENT 'Whether contract auto-renews',
    `contract_status` STRING COMMENT 'Status (active, expired, terminated)',
    `contract_type` STRING COMMENT 'Type (fixed_price, cost_plus, volume_based)',
    `contract_value` DECIMAL(18,2) COMMENT 'Total contract value',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `delivery_terms` STRING COMMENT 'The delivery terms attribute value for this supply contract record in the supply domain',
    `effective_from` DATE COMMENT 'Contract start date',
    `effective_until` DATE COMMENT 'Contract end date',
    `lead_time_days` STRING COMMENT 'Contracted lead time in days',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The count or quantity of minimum order items in this supply contract',
    `payment_terms` STRING COMMENT 'The payment terms attribute value for this supply contract record in the supply domain',
    `price` DECIMAL(18,2) COMMENT 'Contracted unit price',
    `renewal_terms` STRING COMMENT 'Terms for renewal',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_supply_contract PRIMARY KEY(`supply_contract_id`)
) COMMENT 'Supply-specific contracts linking suppliers to sites/categories with pricing and delivery terms.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ADD CONSTRAINT `fk_supply_supply_purchase_order_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ADD CONSTRAINT `fk_supply_supply_purchase_order_supply_supplier_id` FOREIGN KEY (`supply_supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_supplier`(`supply_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_supply_purchase_order_id` FOREIGN KEY (`supply_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_purchase_order`(`supply_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_supply_purchase_order_id` FOREIGN KEY (`supply_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_purchase_order`(`supply_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ADD CONSTRAINT `fk_supply_commodity_category_parent_commodity_category_id` FOREIGN KEY (`parent_commodity_category_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ADD CONSTRAINT `fk_supply_supply_contract_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ADD CONSTRAINT `fk_supply_supply_contract_supply_supplier_id` FOREIGN KEY (`supply_supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_supplier`(`supply_supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` SET TAGS ('dbx_ssot_deprecated_duplicate' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_subdomain' = 'ingredient_catalog');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` SET TAGS ('dbx_ssot_deprecated_duplicate' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ALTER COLUMN `ship_to_location` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` SET TAGS ('dbx_subdomain' = 'logistics_network');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `country` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` SET TAGS ('dbx_subdomain' = 'logistics_network');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_subdomain' = 'ingredient_catalog');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` SET TAGS ('dbx_subdomain' = 'ingredient_catalog');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` SET TAGS ('dbx_subdomain' = 'ingredient_catalog');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_category_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` SET TAGS ('dbx_association_edges' = 'supply.supply_supplier,realestate.site');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` SET TAGS ('dbx_ssot_deprecated_duplicate' = 'procurement.contract');
