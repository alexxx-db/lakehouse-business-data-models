-- Schema for Domain: supply | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-10 20:02:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`supply` COMMENT 'Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supply_supplier data product (auto-inserted pre-linking).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supplier relationship management: restaurants assign a specific employee (purchasing manager) as the internal owner/contact for each supplier, driving vendor performance reviews, escalation handling, ',
    `address` STRING COMMENT '',
    `supplier_code` STRING COMMENT '',
    `contact_email` STRING COMMENT '',
    `contact_phone` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `supplier_name` STRING COMMENT '',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for every supplier and vendor in the foodservice supply chain, including food and non-food suppliers, distributors, co-manufacturers, and their key contacts. Captures supplier identity, classification (broadline, specialty, local), approval status, diversity certification, payment terms, lead times, regulatory compliance status (FDA, USDA, HACCP), and primary/secondary contact information. SSOT for supplier identity and contact details across supply chain operations. Sourced from Coupa Procurement supplier master and SAP S/4HANA vendor master (MM).';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient` (
    `ingredient_id` BIGINT COMMENT 'System-generated surrogate key uniquely identifying each ingredient record.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Required for HACCP compliance: each ingredient must be linked to its HACCP plan for safety documentation and audit reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: The ingredient master catalog should identify the preferred or primary supplier for each ingredient to support procurement planning, par-level replenishment, and sourcing decisions. ingredient current',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ingredient specification ownership: in restaurant operations, a specific employee (culinary director or purchasing manager) is accountable for maintaining allergen flags, nutritional data, and HACCP c',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: Accurate cost-per-unit calculations and recipe costing require ingredient UOM to align with the inventory UOM catalog. The plain-text unit_of_measure on ingredient is a denormalization; a FK to inve',
    `allergen_flags` STRING COMMENT 'Pipe‑separated list of allergens present in the ingredient.. Valid values are `peanut|tree_nut|dairy|egg|gluten|soy`',
    `carbohydrate_content_percent` DECIMAL(18,2) COMMENT 'Percentage of carbohydrates by weight in the ingredient.',
    `ingredient_category` STRING COMMENT 'Broad classification of the ingredient for sourcing, menu engineering, and cost analysis.. Valid values are `protein|produce|dairy|dry_goods|packaging|beverage`',
    `ingredient_code` STRING COMMENT 'Business code or SKU assigned to the ingredient for ordering and inventory tracking.. Valid values are `^[A-Z0-9]{3,10}$`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard purchase cost for one unit of the ingredient in the specified currency.',
    `country_of_origin` STRING COMMENT 'Three‑letter country code indicating where the ingredient was produced or sourced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the ingredient record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost_per_unit (e.g., USD, EUR).',
    `effective_from` DATE COMMENT 'Date when the ingredient becomes available for ordering.',
    `effective_until` DATE COMMENT 'Date after which the ingredient is no longer available (null if indefinite).',
    `fat_content_percent` DECIMAL(18,2) COMMENT 'Percentage of total fat by weight in the ingredient.',
    `haccp_classification` STRING COMMENT 'Risk level of the ingredient according to HACCP guidelines.. Valid values are `critical|high|medium|low`',
    `halal_flag` BOOLEAN COMMENT 'Indicates whether the ingredient meets halal certification requirements.',
    `ingredient_status` STRING COMMENT 'Current operational status of the ingredient in the catalog.. Valid values are `active|inactive|discontinued|pending`',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.. Valid values are `passed|failed|pending`',
    `kosher_flag` BOOLEAN COMMENT 'Indicates whether the ingredient meets kosher certification requirements.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent food safety inspection for this ingredient.',
    `lead_time_days` STRING COMMENT 'Typical number of days from order placement to receipt of the ingredient.',
    `ingredient_name` STRING COMMENT 'Descriptive name of the ingredient as used in menus, procurement, and reporting.',
    `non_gmo_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is verified as non‑genetically modified.',
    `nutritional_calories_per_unit` DECIMAL(18,2) COMMENT 'Energy content per unit of the ingredient, expressed in kilocalories.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is certified organic.',
    `packaging_type` STRING COMMENT 'Standard packaging format for the ingredient.. Valid values are `box|bag|bottle|can|bulk|pallet`',
    `par_level` STRING COMMENT 'Periodic Automatic Replenishment Level – minimum inventory quantity to trigger re‑order.',
    `protein_content_percent` DECIMAL(18,2) COMMENT 'Percentage of protein by weight in the ingredient.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the ingredient can be stored before it is considered expired.',
    `sodium_mg_per_unit` DECIMAL(18,2) COMMENT 'Sodium content per unit of the ingredient, expressed in milligrams.',
    `standard_weight_per_unit` DECIMAL(18,2) COMMENT 'Typical weight of one unit of the ingredient in the specified unit_of_measure.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature range for the ingredient, expressed in degrees Celsius.',
    `sub_category` STRING COMMENT 'More granular classification within the main category (e.g., "leafy_green", "citrus_fruit").',
    `traceability_batch_number` STRING COMMENT 'Batch or lot number used for ingredient traceability throughout the supply chain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the ingredient record.',
    `usda_grade` STRING COMMENT 'USDA quality grade assigned to the ingredient.. Valid values are `A|B|C|U`',
    `vitamin_c_mg_per_unit` DECIMAL(18,2) COMMENT 'Vitamin C content per unit of the ingredient, expressed in milligrams.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Typical percentage of the ingredient that is wasted during preparation or storage.',
    CONSTRAINT pk_ingredient PRIMARY KEY(`ingredient_id`)
) COMMENT 'Master catalog of all food ingredients, raw materials, beverages, and packaging SKUs procured across the foodservice supply chain. Captures SKU code, ingredient name, commodity category, unit of measure, allergen flags (Big 9), USDA grade, country of origin, shelf life days, storage temperature requirements (ambient/refrigerated/frozen), and HACCP critical control classification. Serves as the supply-side item master linking to menu domain BOM for recipe costing. SSOT for ingredient identity across supply, inventory, and menu domains. Sourced from SAP MM material master and MarketMan Inventory Management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the supply_purchase_order data product (auto-inserted pre-linking).',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level purchase order reporting and budget allocation: multi-brand restaurant groups issue POs per brand for procurement budgeting, brand-specific ingredient sourcing compliance, and spend analyt',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PO approval and spend authorization workflow: restaurants require audit trails of which employee (purchasing manager, kitchen manager) created/approved each purchase order. Supports spend controls, AP',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: Purchase orders in foodservice procurement are frequently issued against a negotiated supplier contract to ensure contracted pricing and terms are applied. Linking supply_purchase_order to supplier_co',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Every purchase order is issued to a specific supplier. This is the foundational business relationship in procurement: a PO belongs to one supplier. supply_purchase_order currently has no FK to supply_',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: PURCHASE_ORDER creation is done per restaurant location; linking PO to unit enables inventory budgeting and location‑specific spend reporting.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core transactional record for every purchase order issued to suppliers for food ingredients, beverages, packaging, and non-food supplies. Captures PO number, supplier reference, order date, requested delivery date, ship-to distribution center or restaurant, total PO value, currency, payment terms, approval status, and sourcing event linkage. Represents the contractual commitment to buy. Sourced from Coupa Procurement PO module and SAP S/4HANA MM purchasing.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Primary key for purchase_order_line',
    `ingredient_id` BIGINT COMMENT 'add column ingredient_id (BIGINT) with FK to supply.ingredient.ingredient_id - PO lines need to specify what ingredient/item is being ordered',
    `purchase_order_id` BIGINT COMMENT 'add column supply_purchase_order_id (BIGINT) with FK to supply.supply_purchase_order.supply_purchase_order_id - PO lines must link to their parent purchase order',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Procurement-to-inventory reconciliation requires linking each PO line to the inventory stock_item it replenishes, enabling reorder point management, cost variance analysis, and automated receiving mat',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Each PO line item is fulfilled for a specific restaurant; the FK supports line‑level receipt, cost allocation, and audit trails.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Line-item detail for each purchase order, capturing individual SKU/ingredient ordered, quantity ordered, unit of measure, agreed unit price, extended line value, COGS allocation, requested delivery date per line, and line status (open, partially received, closed, cancelled). Enables PMIX-level COGS tracking and ingredient-level spend analytics. Sourced from SAP S/4HANA MM (EKPO) and Coupa PO line items.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'System‑generated unique identifier for each goods receipt transaction.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: During goods receiving, inspectors must verify compliance with the applicable HACCP plan (temperature controls, CCP checks, handling procedures). Linking goods_receipt to haccp_plan enables receiving-',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `primary_goods_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: goods_receipt currently stores purchase_order_number as a denormalized STRING, which is a fragile text reference to the originating PO. Replacing this with a proper supply_purchase_order_id FK establi',
    `stock_location_id` BIGINT COMMENT 'System identifier of the purchase order linked to this receipt.',
    `unit_id` BIGINT COMMENT 'Identifier of the distribution center or restaurant where goods were received.',
    `batch_number` STRING COMMENT 'Internal batch identifier assigned during receiving for inventory control.',
    `comments` STRING COMMENT 'Optional textual remarks entered by the inspector during receipt.',
    `condition` STRING COMMENT 'Overall condition of the received shipment (accepted, rejected, or partially accepted).. Valid values are `accepted|rejected|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the goods receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the total_cost field.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `expiration_date` DATE COMMENT 'Date after which the received goods should not be used or sold.',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the receipt (e.g., open, partial, closed, cancelled).. Valid values are `open|partial|closed|cancelled`',
    `is_cold_chain_compliant` BOOLEAN COMMENT 'True if temperature remained within required range during transport and receipt.',
    `lot_number` STRING COMMENT 'Supplier‑provided lot or batch number for traceability.',
    `receipt_number` STRING COMMENT 'Human‑readable receipt number assigned by the receiving system (e.g., MIGO document number).',
    `receipt_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the goods were recorded as received.',
    `receiving_method` STRING COMMENT 'How the goods arrived at the receiving location (e.g., dock, delivery, third‑party carrier, internal transfer).. Valid values are `dock|delivery|third_party|internal`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Measured temperature (in Celsius) of the goods at the moment of receipt.',
    `temperature_deviation_flag` BOOLEAN COMMENT 'True if measured temperature fell outside the acceptable range.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total monetary value of the goods received, before any discounts or taxes.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Sum of all item quantities received in this receipt (units may be pieces, kg, liters, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the goods receipt record.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional record of inbound goods received at a distribution center or restaurant, including both header-level receipt information and line-level detail per SKU. Header captures receipt date/time, receiving location, PO reference, receiving condition, and inspector ID. Lines capture specific ingredient/SKU received, quantity accepted/rejected, lot number, expiration date, temperature at receipt (cold chain compliance), storage location assigned, and variance from PO quantity. Critical for three-way match (PO-receipt-invoice), HACCP traceability, and ingredient-level lot tracking. Sourced from SAP S/4HANA MM (MIGO) and MarketMan receiving module.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` (
    `goods_receipt_line_id` BIGINT COMMENT 'Unique identifier for the goods receipt line record.',
    `goods_receipt_id` BIGINT COMMENT 'Identifier of the parent goods receipt transaction.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: goods_receipt_line currently stores lot_number and supplier_batch_number as denormalized STRINGs. ingredient_lot is the authoritative lot traceability record. Linking goods_receipt_line to ingredient_',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: Receiving variance calculations and inventory posting require goods receipt line quantities to use catalog-validated UOMs. The plain-text unit_of_measure on goods_receipt_line is a denormalization o',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the receipt.',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order_line. Business justification: Goods receipt lines must reference the originating purchase order line; the existing column name does not match the target PK, so a correctly named FK is added and the old column removed.',
    `receiving_user_employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the receipt.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Needed for Three‑Way Match process linking receipt line to specific contract line for price verification and audit of contracted terms per SKU.',
    `stock_location_id` BIGINT COMMENT 'Identifier of the warehouse or store location where the item is stored.',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Cost of goods sold value attributed to this receipt line for financial reporting.',
    `compliance_flag` BOOLEAN COMMENT 'True if the receipt meets HACCP and other regulatory compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods receipt line record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `expiration_date` DATE COMMENT 'Date after which the product is no longer safe to use.',
    `inspected_timestamp` TIMESTAMP COMMENT 'Date and time when the received items were inspected for quality and compliance.',
    `inspection_status` STRING COMMENT 'Result of the quality inspection for the received items.. Valid values are `passed|failed|pending`',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether the received item is perishable and requires special handling.',
    `is_returned` BOOLEAN COMMENT 'Indicates whether the line was later returned to the supplier.',
    `item_description` STRING COMMENT 'Free‑text description of the received product.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the goods receipt.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured at receipt.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing quality assessment of the received items.',
    `recall_status` STRING COMMENT 'Indicates if the item is subject to a product recall.. Valid values are `none|pending|recalled`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item accepted into inventory.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the receipt was logged in the system.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item rejected during receipt inspection.',
    `sku` STRING COMMENT 'Standardized product code for the received item.',
    `temperature_control_required` BOOLEAN COMMENT 'True if the item must be stored under temperature‑controlled conditions.',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Temperature measured at receipt for temperature‑controlled items.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total monetary value for the accepted quantity (unit_price * received_quantity).',
    `unit_price` DECIMAL(18,2) COMMENT 'Cost per unit of the received item, in the transaction currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goods receipt line record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between expected cost and actual cost for the line.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between ordered quantity and received quantity (received_quantity - ordered_quantity).',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Physical volume of the received items, useful for storage planning.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the received quantity, expressed in kilograms.',
    CONSTRAINT pk_goods_receipt_line PRIMARY KEY(`goods_receipt_line_id`)
) COMMENT 'Line-level detail for each goods receipt event, capturing the specific ingredient/SKU received, quantity accepted, quantity rejected, unit of measure, lot number, expiration date, storage location assigned, and variance from PO quantity. Enables ingredient-level traceability from supplier to restaurant for HACCP and FDA recall compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'System-generated unique identifier for the supplier contract record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level supply contract management: in multi-brand restaurant enterprises, supplier contracts are negotiated per brand (e.g., approved beverage supplier for Brand X). Procurement teams report cont',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supports Contract Ownership Register, linking each supplier contract to the employee owner for accountability and audit trails.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Supplier contracts in food service specify which HACCP plan the supplier must comply with as a contractual food safety obligation. Approved Supplier Management programs require this link to enforce an',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: Contract price validation and purchase order cost calculations require the contract pricing UOM to reference the inventory UOM catalog. The plain-text price_uom on supplier_contract is a denormaliza',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: A supplier contract is negotiated with and belongs to a specific supplier. supplier_contract currently has no FK to supply_supplier, making it impossible to join contracts to the supplier master recor',
    `audit_status` STRING COMMENT 'Result of the most recent contract audit.. Valid values are `passed|failed|pending`',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the contract against internal and regulatory standards.. Valid values are `compliant|non_compliant|under_review`',
    `confidentiality_clause` BOOLEAN COMMENT 'Indicates whether a confidentiality provision is included.',
    `contract_description` STRING COMMENT 'Free‑text description providing additional context about the contract.',
    `contract_document_url` STRING COMMENT 'Link to the stored electronic copy of the signed contract document.',
    `contract_type` STRING COMMENT 'Category of the contract indicating its business purpose.. Valid values are `purchase|distribution|exclusive|service|maintenance`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for contract pricing.. Valid values are `^[A-Z]{3}$`',
    `data_protection_clause` BOOLEAN COMMENT 'Indicates inclusion of data protection requirements (e.g., GDPR, CCPA).',
    `default_price` DECIMAL(18,2) COMMENT 'Baseline price per unit (SKU) when no volume tier applies.',
    `delivery_terms` STRING COMMENT 'Incoterms defining responsibility for delivery and risk.. Valid values are `FOB|CIF|EXW|DDP`',
    `dispute_resolution` STRING COMMENT 'Mechanism for resolving disputes (e.g., arbitration, litigation).',
    `effective_from` DATE COMMENT 'Date when the contract becomes legally binding.',
    `effective_until` DATE COMMENT 'Date when the contract expires or ends, if applicable.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the supplier has exclusive rights for the contracted items.',
    `exclusivity_region` STRING COMMENT 'Geographic region where exclusivity applies, if any.',
    `executed_date` DATE COMMENT 'Date the contract was executed and entered into the system.',
    `governing_law` STRING COMMENT 'Specific legal framework applied to interpret the contract.',
    `insurance_requirements` STRING COMMENT 'Minimum insurance coverage the supplier must maintain.',
    `legal_jurisdiction` STRING COMMENT 'State, province, or country whose laws govern the contract.',
    `liability_limit` DECIMAL(18,2) COMMENT 'Maximum monetary liability the supplier assumes under the contract.',
    `payment_method` STRING COMMENT 'Preferred method of payment for invoicing under the contract.. Valid values are `ACH|Check|Wire|CreditCard`',
    `payment_terms` STRING COMMENT 'Standard payment terms defined in the contract.. Valid values are `net30|net45|net60|upon_receipt`',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage rebate applied once the threshold amount is reached.',
    `rebate_threshold_amount` DECIMAL(18,2) COMMENT 'Cumulative spend amount that triggers a rebate.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiration required to issue a renewal notice.',
    `renewal_type` STRING COMMENT 'Indicates whether the contract renews automatically, manually, or not at all.. Valid values are `auto|manual|none`',
    `shipping_method` STRING COMMENT 'Primary mode of transportation for goods covered by the contract.. Valid values are `Truck|Rail|Air|Sea`',
    `signed_date` DATE COMMENT 'Date the contract was signed by all parties.',
    `supplier_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `draft|active|suspended|terminated|expired|pending`',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to give notice before terminating the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the contract record.',
    `volume_tier_1_min` STRING COMMENT 'Minimum quantity required to qualify for the first volume discount tier.',
    `volume_tier_1_price` DECIMAL(18,2) COMMENT 'Unit price applied when the purchase quantity meets tier 1 minimum.',
    `volume_tier_2_min` STRING COMMENT 'Minimum quantity required to qualify for the second volume discount tier.',
    `volume_tier_2_price` DECIMAL(18,2) COMMENT 'Unit price applied when the purchase quantity meets tier 2 minimum.',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Master record for negotiated supply agreements and their associated price schedules. Captures contract number, effective and expiration dates, volume commitments, rebate agreements, exclusivity terms, renewal type, and compliance status. Includes contracted unit prices per ingredient/SKU with validity periods, volume tiers, and price types (fixed, indexed, market-based). Used by supply chain for price validation during goods receipt and invoice matching, and for COGS variance analysis. Sourced from Coupa contract management module.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`contract_price` (
    `contract_price_id` BIGINT COMMENT 'System-generated unique identifier for the contract price record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level contract pricing: restaurant chains negotiate brand-specific ingredient prices with suppliers (Brand A vs Brand B may have different negotiated rates). Procurement and finance teams track ',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: A contract price record specifies the negotiated unit price for a specific ingredient or SKU. contract_price already has stock_item_id pointing to the inventory domain, but the supply-domain ingredien',
    `stock_item_id` BIGINT COMMENT 'Identifier of the ingredient or stock keeping unit covered by this price.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: contract_price is the line-item detail record for a supplier_contract (header-line pattern). A contracted unit price only has meaning in the context of its parent contract — it inherits payment terms,',
    `contract_price_code` STRING COMMENT 'Business identifier or code assigned to the contract price (e.g., CP-2024-001).',
    `contract_price_status` STRING COMMENT 'Current lifecycle status of the price record.. Valid values are `active|expired|pending|draft`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the price record was initially created in the source system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price (e.g., USD, EUR).',
    `effective_from` DATE COMMENT 'Date when the contracted price becomes binding.',
    `effective_until` DATE COMMENT 'Date when the contracted price expires (null if open‑ended).',
    `is_current` BOOLEAN COMMENT 'Indicates whether this price record is the currently active price for the SKU.',
    `price_amount` DECIMAL(18,2) COMMENT 'Numeric value of the contracted unit price.',
    `price_change_reason` STRING COMMENT 'Free‑text explanation for why the price was changed or created.',
    `price_index_reference` STRING COMMENT 'External index or commodity reference used for indexed pricing (e.g., USDA Corn Index).',
    `price_tier_max_qty` DECIMAL(18,2) COMMENT 'Upper bound quantity for this price tier (null if no upper limit).',
    `price_tier_min_qty` DECIMAL(18,2) COMMENT 'Lower bound quantity for this price tier (volume break).',
    `price_type` STRING COMMENT 'Classification of the price calculation method.. Valid values are `fixed|indexed|market_based`',
    `record_audit_created` TIMESTAMP COMMENT 'Audit timestamp capturing when the record was first loaded into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit timestamp capturing the last load or refresh time for the record.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the price (e.g., kilogram, pound, each).. Valid values are `kg|lb|unit|liter|gallon|piece`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the price record.',
    CONSTRAINT pk_contract_price PRIMARY KEY(`contract_price_id`)
) COMMENT 'Contracted unit price records tied to a supplier contract for specific ingredients or SKUs over a defined validity period. Captures ingredient/SKU reference, contracted unit price, currency, price validity start and end dates, price tier (volume break), and price type (fixed, indexed, market-based). Enables COGS% variance analysis against actual invoice prices and supports menu costing in the menu domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` (
    `ingredient_lot_id` BIGINT COMMENT 'System-generated unique identifier for each ingredient lot record.',
    `haccp_plan_id` BIGINT COMMENT 'Reference to the HACCP plan governing this ingredient lot.',
    `ingredient_id` BIGINT COMMENT 'FK to supply.ingredient',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Allows Lot Responsibility Tracking, assigning the employee accountable for each ingredient lot to meet recall and quality investigation requirements.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: Lot quantity tracking and FIFO depletion calculations require lot UOM to reference the inventory UOM catalog. The plain-text unit_of_measure on ingredient_lot is a denormalization; a FK ensures lot ',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Lot-level traceability, FIFO/FEFO rotation, and recall management require linking each ingredient lot to its inventory catalog entry (stock_item). A food safety auditor or inventory manager would expe',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: HACCP temperature monitoring and cycle count reconciliation require knowing which physical stock_location holds each ingredient lot. The plain-text storage_location column is a denormalization of st',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: ingredient_lot currently stores supplier_code as a denormalized STRING, which is a fragile reference to the supplier master. Replacing this with a proper supply_supplier_id FK normalizes the lot-to-su',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Ingredient lots are stored at specific restaurant units for traceability; the FK supports lot‑by‑unit inventory, recall mapping, and waste analysis.',
    `batch_number` STRING COMMENT 'Batch identifier that groups multiple lots produced under the same conditions.',
    `best_by_date` DATE COMMENT 'Date by which the ingredient should be used for optimal quality.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of certifications applicable to the lot (e.g., "USDA Organic, Non‑GMO").',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Purchase cost for a single unit of the ingredient in the specified currency.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO country code where the ingredient originated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for cost fields.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `disposition_date` DATE COMMENT 'Date the lot status last changed (e.g., when recalled or released).',
    `expiration_date` DATE COMMENT 'Date after which the ingredient must not be used.',
    `external_traceability_code` STRING COMMENT 'Identifier used by external regulators (e.g., FDA) for lot tracking.',
    `ingredient_category` STRING COMMENT 'High‑level classification of the ingredient for reporting and analytics.. Valid values are `Meat|Produce|Dairy|Dry_Goods|Spice|Beverage`',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.. Valid values are `passed|failed|pending`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent food‑safety inspection for this lot.',
    `lot_comments` STRING COMMENT 'Free‑form notes captured by quality or operations staff.',
    `lot_number` STRING COMMENT 'External lot number assigned by the supplier or manufacturer for traceability.',
    `lot_source_type` STRING COMMENT 'Origin of the lot in the supply chain.. Valid values are `farm|plant|manufacturer|importer`',
    `lot_status` STRING COMMENT 'Current lifecycle status of the lot for traceability and compliance.. Valid values are `quarantine|released|consumed|recalled|expired|in_transit`',
    `lot_type` STRING COMMENT 'Classification of the lot based on processing level.. Valid values are `raw|processed|prepped|finished`',
    `organic_certified` BOOLEAN COMMENT 'True if the ingredient lot is certified organic.',
    `production_date` DATE COMMENT 'Date the ingredient was produced or packaged by the supplier.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) from quality inspection results.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of ingredient received in the specified unit of measure.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether the lot has been subject to a recall (true) or not (false).',
    `recall_reason` STRING COMMENT 'Free‑text description of why the lot was recalled.',
    `received_date` DATE COMMENT 'Date the lot was received at the distribution center.',
    `receiving_dc_code` STRING COMMENT 'Code identifying the distribution center that received the lot.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Target storage temperature in degrees Celsius for temperature‑controlled lots.',
    `supplier_lot_reference` STRING COMMENT 'Reference code used by the supplier to identify the lot in their system.',
    `temperature_controlled` BOOLEAN COMMENT 'True if the lot requires temperature‑controlled storage.',
    `total_cost` DECIMAL(18,2) COMMENT 'Aggregate cost for the entire lot (quantity × cost per unit).',
    `traceability_enabled` BOOLEAN COMMENT 'Indicates whether the lot is included in the enterprise traceability program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lot record.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Percentage of the lot that was discarded during processing.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Usable portion of the lot expressed as a percentage of total quantity.',
    CONSTRAINT pk_ingredient_lot PRIMARY KEY(`ingredient_lot_id`)
) COMMENT 'Lot and batch traceability record for received ingredients, enabling end-to-end traceability from supplier farm/plant through DC to restaurant for HACCP compliance and FDA recall management. Captures lot number, batch number, supplier lot reference, ingredient/SKU, production date, best-by date, country of origin, receiving DC, and lot disposition status (quarantine, released, consumed, recalled). Critical for food safety incident response.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ADD CONSTRAINT `fk_supply_ingredient_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for supply_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Uom Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `allergen_flags` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flags');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `allergen_flags` SET TAGS ('dbx_value_regex' = 'peanut|tree_nut|dairy|egg|gluten|soy');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `carbohydrate_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbohydrate Content (%)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Category');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_value_regex' = 'protein|produce|dairy|dry_goods|packaging|beverage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_code` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Code (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO‑3)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO‑4217)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `fat_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Fat Content (%)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_business_glossary_term' = 'HACCP Classification');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `halal_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `kosher_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Name');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `non_gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Non‑GMO Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `nutritional_calories_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Calories per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'box|bag|bottle|can|bulk|pallet');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'PAR Level');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `protein_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Protein Content (%)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `sodium_mg_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Sodium (mg) per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `standard_weight_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Weight per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `sub_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Sub‑Category');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `traceability_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Traceability Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `usda_grade` SET TAGS ('dbx_business_glossary_term' = 'USDA Grade');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `usda_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|U');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `vitamin_c_mg_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Vitamin C (mg) per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for supply_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Receipt Comments');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Receipt Condition');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partial');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'open|partial|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `is_cold_chain_compliant` SET TAGS ('dbx_business_glossary_term' = 'Cold‑Chain Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_method` SET TAGS ('dbx_business_glossary_term' = 'Receiving Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_method` SET TAGS ('dbx_value_regex' = 'dock|delivery|third_party|internal');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Receipt Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `temperature_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Deviation Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Received Cost');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Received Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `goods_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Line ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Line Uom Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Po Line Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold Amount');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `inspected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `is_returned` SET TAGS ('dbx_business_glossary_term' = 'Is Returned');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Line Notes');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'none|pending|recalled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `temperature_recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Line Total Cost');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (Currency)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Amount Variance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Price Uom Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'purchase|distribution|exclusive|service|maintenance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `data_protection_clause` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Clause');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `default_price` SET TAGS ('dbx_business_glossary_term' = 'Default Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `dispute_resolution` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Clause');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `exclusivity_region` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Region');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Executed Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `legal_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Legal Jurisdiction');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `liability_limit` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Check|Wire|CreditCard');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|upon_receipt');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `rebate_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Threshold Amount');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'Truck|Rail|Air|Sea');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_1_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Minimum Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_1_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_2_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Minimum Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_2_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `contract_price_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Price ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `contract_price_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `contract_price_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `contract_price_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|draft');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Unit Price Amount');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `price_tier_max_qty` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Maximum Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `price_tier_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Minimum Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type (FIXED|INDEXED|MARKET_BASED)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'fixed|indexed|market_based');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|unit|liter|gallon|piece');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier (HACCP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Uom Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `best_by_date` SET TAGS ('dbx_business_glossary_term' = 'Best‑By Date (BEST_BY)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications (CERTS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit (COST_U)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date (DISP_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `external_traceability_code` SET TAGS ('dbx_business_glossary_term' = 'External Traceability Identifier (EXT_TRACE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Category (CAT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_value_regex' = 'Meat|Produce|Dairy|Dry_Goods|Spice|Beverage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (INSP_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (INSP_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_comments` SET TAGS ('dbx_business_glossary_term' = 'Lot Comments (COMMENTS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_source_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Source Type (SRC_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_source_type` SET TAGS ('dbx_value_regex' = 'farm|plant|manufacturer|importer');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'quarantine|released|consumed|recalled|expired|in_transit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type (TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'raw|processed|prepped|finished');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag (ORG_CERT_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date (PROD_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score (QUAL_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received (QTY)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag (RECALL_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason (RECALL_RSN)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date (RCV_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `receiving_dc_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Distribution Center Code (DC_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C) (STOR_TEMP_C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `supplier_lot_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Reference (SLR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (TEMP_CTRL_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost (TOTAL_COST)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `traceability_enabled` SET TAGS ('dbx_business_glossary_term' = 'Traceability Enabled Flag (TRACE_EN_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage (WASTE_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YIELD_PCT)');
