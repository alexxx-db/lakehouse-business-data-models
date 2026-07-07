-- Schema for Domain: supply | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-02 04:02:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`supply` COMMENT 'Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each supplier in restaurant operations is owned by a specific purchasing/account manager employee responsible for performance reviews, escalations, and relationship management. This named business rol',
    `address_line1` STRING COMMENT 'Street address line 1',
    `average_lead_time_days` STRING COMMENT 'Average delivery lead time in days',
    `city` STRING COMMENT 'City of supplier headquarters',
    `supplier_code` STRING COMMENT 'Unique business code for the supplier',
    `contact_email` STRING COMMENT 'Primary contact email address',
    `contact_name` STRING COMMENT 'Primary contact person name',
    `contact_phone` STRING COMMENT 'Primary contact phone number',
    `country_code` STRING COMMENT 'ISO country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Default transaction currency ISO code',
    `food_safety_certified_flag` BOOLEAN COMMENT 'Whether supplier holds food safety certification',
    `is_approved` BOOLEAN COMMENT 'Whether supplier has passed approval process',
    `legal_name` STRING COMMENT 'Registered legal entity name',
    `supplier_name` STRING COMMENT 'Legal or trading name of the supplier',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Historical on-time delivery percentage',
    `onboarded_date` DATE COMMENT 'Date supplier was onboarded',
    `payment_terms` STRING COMMENT 'Default payment terms (Net30, Net60)',
    `postal_code` STRING COMMENT 'Postal/ZIP code',
    `preferred_flag` BOOLEAN COMMENT 'Whether this is a preferred supplier',
    `quality_rating` DECIMAL(18,2) COMMENT 'Composite quality score',
    `region` STRING COMMENT 'Geographic region for sourcing',
    `state_province` STRING COMMENT 'State or province',
    `supplier_status` STRING COMMENT 'Current status (active, suspended, terminated)',
    `supplier_type` STRING COMMENT 'Classification (distributor, manufacturer, broker)',
    `tax_identifier` STRING COMMENT 'Tax ID / EIN of the supplier',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for suppliers providing ingredients and goods to the restaurant supply chain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient` (
    `ingredient_id` BIGINT COMMENT 'Primary key',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Restaurant procurement requires manager approval of POs for authorization control and audit trails. The existing approved_by text column is a denormalized employee reference; replacing it with a pro',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `unit_id` BIGINT COMMENT 'FK to ordering restaurant unit',
    `approval_status` STRING COMMENT 'Approval workflow status',
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
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase orders placed with suppliers for ingredients and supplies.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Primary key',
    `ingredient_id` BIGINT COMMENT 'FK to ingredient being ordered',
    `purchase_order_id` BIGINT COMMENT 'FK to parent purchase order',
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
    `employee_id` BIGINT COMMENT 'FK to employee who received goods',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: goods_receipt currently stores purchase_order_number as a denormalized STRING reference to supply_purchase_order. Adding supply_purchase_order_id as a proper FK normalizes this relationship, enabling ',
    `unit_id` BIGINT COMMENT 'FK to receiving restaurant unit',
    `batch_number` STRING COMMENT 'Batch/lot number from supplier',
    `comments` STRING COMMENT 'Free-text comments',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `goods_receipt_status` STRING COMMENT 'Status (pending, complete, partial)',
    `is_cold_chain_compliant` BOOLEAN COMMENT 'Whether cold chain was maintained',
    `lot_number` STRING COMMENT 'Lot tracking number',
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
    `goods_receipt_id` BIGINT COMMENT 'FK to parent goods receipt',
    `purchase_order_line_id` BIGINT COMMENT 'FK to PO line being received against',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Goods receipt lines must identify the inventory catalog item (stock_item) to post received quantities to on_hand_balance. Without this FK, the inventory posting process cannot determine which stock_it',
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
    `goods_receipt_id` BIGINT COMMENT 'FK to goods receipt for matching',
    `purchase_order_id` BIGINT COMMENT 'FK to related PO',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Restaurant AP and financial close processes allocate invoice costs to specific units. Unit-level food cost reporting, period-end accruals, and cost-center reconciliation require a direct unit_id on in',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In multi-brand restaurant enterprises, supplier contracts are negotiated at brand level (e.g., approved beverage supplier for Brand X). Brand-level procurement reporting, contract compliance, and vend',
    `employee_id` BIGINT COMMENT 'FK to contract owner',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: A supplier contract is fundamentally tied to a specific supplier. supplier_contract currently has no FK to supply_supplier, making it impossible to join contracts to their supplier master record witho',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Supplier contracts are sometimes scoped to specific restaurant units (e.g., local produce agreements). Unit-level contract coverage reporting and compliance audits require this link. No existing colum',
    `compliance_status` STRING COMMENT 'Compliance review status',
    `confidentiality_clause` BOOLEAN COMMENT 'Whether NDA/confidentiality clause exists',
    `contract_description` STRING COMMENT 'Description of contract scope',
    `contract_document_url` STRING COMMENT 'URL to contract document',
    `contract_type` STRING COMMENT 'Type of contract (blanket, spot, framework)',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency ISO code',
    `data_protection_clause` BOOLEAN COMMENT 'Whether data protection clause exists',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` (
    `ingredient_lot_id` BIGINT COMMENT 'Primary key',
    `goods_receipt_line_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt_line. Business justification: An ingredient lot is created when goods are physically received at a restaurant or distribution center. The ingredient_lot record should reference the specific goods_receipt_line from which it was cre',
    `ingredient_id` BIGINT COMMENT 'FK to ingredient master',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: HACCP and cold-chain compliance require tracing which refrigeration or storage equipment holds each ingredient lot. Temperature exceedance alerts, recall traceability, and equipment-level spoilage rep',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: ingredient_lot tracks lot-level traceability and currently stores supplier_code as a denormalized STRING reference. Adding supply_supplier_id FK normalizes the supplier reference on each lot, enabling',
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
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Required storage temperature',
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
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Quality inspections are performed on goods received at a restaurant or DC. Linking quality_inspection to goods_receipt establishes the operational context for each inspection — which delivery event tr',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Quality inspections are performed on specific ingredients. Linking quality_inspection directly to ingredient enables ingredient-level quality analytics (e.g., rejection rates by ingredient, inspection',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Quality inspections are performed on specific ingredient lots for traceability and recall management. Linking quality_inspection to ingredient_lot enables lot-level quality history, supports HACCP cla',
    `employee_id` BIGINT COMMENT 'FK to inspector employee',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Quality inspections of received goods occur at a specific restaurant unit. Unit-level HACCP compliance reporting, health inspection audit trails, and rejection-rate dashboards require direct unit scop',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` (
    `supplier_ingredient_catalog_id` BIGINT COMMENT 'Primary key for the supplier_ingredient_catalog association',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to the ingredient being sourced under this catalog entry',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier providing this ingredient under this catalog entry',
    `effective_from` DATE COMMENT 'The date from which this supplier-ingredient sourcing agreement is valid and the supplier is approved to supply this ingredient.',
    `effective_until` DATE COMMENT 'The date on which this supplier-ingredient sourcing agreement expires or the supplier approval for this ingredient ends. Null if open-ended.',
    `lead_time_days` STRING COMMENT 'The number of days lead time for this supplier to deliver this specific ingredient. Overrides the ingredient-level generic lead_time_days for procurement planning purposes.',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered from this supplier for this ingredient per purchase order. Specific to the supplier-ingredient combination.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the preferred (primary) source for this specific ingredient. Enables procurement systems to default to the preferred supplier during ordering.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit charged by this specific supplier for this specific ingredient. Varies by supplier-ingredient combination and cannot reside on either master record.',
    CONSTRAINT pk_supplier_ingredient_catalog PRIMARY KEY(`supplier_ingredient_catalog_id`)
) COMMENT 'This association product represents the Sourcing Agreement (Contract) between supply_supplier and ingredient. It captures the approved supplier list — the operational record of which suppliers are authorized to provide which ingredients, at what price, lead time, and minimum order quantity. Each record links one supply_supplier to one ingredient with attributes that exist only in the context of this supplier-ingredient sourcing relationship, forming the foundation of procurement, COGS management, and supplier diversification strategy.. Existence Justification: In restaurant supply chain operations, a supplier can provide multiple ingredients (e.g., a produce distributor supplies tomatoes, lettuce, and onions), and a single ingredient can be sourced from multiple suppliers at different prices, lead times, and minimum order quantities. Procurement teams actively manage this supplier-ingredient sourcing catalog — known as an Approved Supplier List or Vendor Item Catalog — as a first-class operational entity with its own pricing, lead time, and approval data. This relationship cannot be collapsed into a 1:N without losing critical per-combination sourcing terms.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` (
    `contract_line_item_id` BIGINT COMMENT 'Primary key for the contract_line_item association',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to the ingredient covered by this contract line item',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to the parent supplier contract that governs this line item',
    `contracted_unit_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit for this specific ingredient under this specific contract. Cannot live on supplier_contract (varies per ingredient) nor on ingredient (varies per contract).',
    `default_price` DECIMAL(18,2) COMMENT 'Default unit price in contract [Moved from supplier_contract: default_price on supplier_contract is ambiguous when a contract covers multiple ingredients — each ingredient has its own contracted price. This attribute is superseded by contracted_unit_price on the contract line item and should be removed from supplier_contract to avoid confusion.]',
    `effective_from` DATE COMMENT 'The date from which this contract line item for the ingredient becomes active. May differ from the parent contract effective_from if ingredients are added mid-contract.',
    `effective_until` DATE COMMENT 'The date on which this contract line item for the ingredient expires. May differ from the parent contract effective_until if individual ingredient terms are renegotiated.',
    `min_order_quantity` BIGINT COMMENT 'The minimum quantity that must be ordered for this ingredient under this contract line. Specific to the contract-ingredient pairing.',
    `volume_discount_percentage` DECIMAL(18,2) COMMENT 'The volume-based discount percentage applicable to this ingredient under this contract. Varies by ingredient and contract combination.',
    CONSTRAINT pk_contract_line_item PRIMARY KEY(`contract_line_item_id`)
) COMMENT 'This association product represents the Contract between supplier_contract and ingredient. It captures the specific terms negotiated for each ingredient covered under a supplier contract, including contracted pricing, minimum order quantities, volume discounts, and validity periods. Each record links one supplier_contract to one ingredient with attributes that exist only in the context of this contract-ingredient pairing and cannot be attributed to either entity alone.. Existence Justification: In restaurant procurement, a single supplier contract routinely covers multiple ingredients (e.g., a produce supplier contract covering tomatoes, lettuce, and onions), and a single ingredient can be covered by multiple contracts over time or simultaneously from different suppliers. The contract-line-item concept — where each ingredient covered by a contract has its own negotiated price, minimum order quantity, and volume discount — is a well-recognized operational entity in procurement systems. This is not an analytical correlation; procurement teams actively create, update, and terminate these contract line items as part of daily supply chain operations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_goods_receipt_line_id` FOREIGN KEY (`goods_receipt_line_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt_line`(`goods_receipt_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ADD CONSTRAINT `fk_supply_supplier_ingredient_catalog_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ADD CONSTRAINT `fk_supply_supplier_ingredient_catalog_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ADD CONSTRAINT `fk_supply_contract_line_item_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ADD CONSTRAINT `fk_supply_contract_line_item_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier_contract`(`supplier_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `ship_to_location` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `goods_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Line Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` SET TAGS ('dbx_association_edges' = 'supply.supply_supplier,supply.ingredient');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `supplier_ingredient_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Ingredient Catalog - Supplier Ingredient Catalog Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Ingredient Catalog - Ingredient Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Ingredient Catalog - Supply Supplier Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Effective From');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier-Specific Lead Time');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier for Ingredient');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_catalog` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Supplier Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` SET TAGS ('dbx_association_edges' = 'supply.supplier_contract,supply.ingredient');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ALTER COLUMN `contract_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item - Contract Line Item Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item - Ingredient Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item - Supplier Contract Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ALTER COLUMN `contracted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Line Item Effective From');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Line Item Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_line_item` ALTER COLUMN `volume_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Percentage');
