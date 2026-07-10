-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`supply` COMMENT 'Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` (
    `supply_supplier_id` BIGINT COMMENT 'Unique identifier for the supply_supplier data product (auto-inserted pre-linking).',
    `legal_entity_id` BIGINT COMMENT 'add column legal_entity_id (BIGINT) with FK to finance.legal_entity.legal_entity_id - suppliers need legal entity linkage for intercompany and tax reporting',
    `supplier_name` STRING COMMENT '',
    `supplier_code` STRING COMMENT '',
    `contact_email` STRING COMMENT '',
    `contact_phone` STRING COMMENT '',
    `address` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_supply_supplier PRIMARY KEY(`supply_supplier_id`)
) COMMENT 'Master record for every supplier and vendor in the foodservice supply chain, including food and non-food suppliers, distributors, co-manufacturers, and their key contacts. Captures supplier identity, classification (broadline, specialty, local), approval status, diversity certification, payment terms, lead times, regulatory compliance status (FDA, USDA, HACCP), and primary/secondary contact information. SSOT for supplier identity and contact details across supply chain operations. Sourced from Coupa Procurement supplier master and SAP S/4HANA vendor master (MM).';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient` (
    `ingredient_id` BIGINT COMMENT 'System-generated surrogate key uniquely identifying each ingredient record.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Required for HACCP compliance: each ingredient must be linked to its HACCP plan for safety documentation and audit reporting.',
    `item_specification_id` BIGINT COMMENT 'Foreign key linking to procurement.item_specification. Business justification: Ensures Ingredient Quality Assurance by tying each ingredient record to its approved item specification, used in purchasing approval and regulatory compliance checks.',
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
    `unit_of_measure` STRING COMMENT 'Default unit used to quantify the ingredient in purchasing and inventory (e.g., kilograms, liters).. Valid values are `kg|g|lb|oz|liter|ml`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the ingredient record.',
    `usda_grade` STRING COMMENT 'USDA quality grade assigned to the ingredient.. Valid values are `A|B|C|U`',
    `vitamin_c_mg_per_unit` DECIMAL(18,2) COMMENT 'Vitamin C content per unit of the ingredient, expressed in milligrams.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Typical percentage of the ingredient that is wasted during preparation or storage.',
    CONSTRAINT pk_ingredient PRIMARY KEY(`ingredient_id`)
) COMMENT 'Master catalog of all food ingredients, raw materials, beverages, and packaging SKUs procured across the foodservice supply chain. Captures SKU code, ingredient name, commodity category, unit of measure, allergen flags (Big 9), USDA grade, country of origin, shelf life days, storage temperature requirements (ambient/refrigerated/frozen), and HACCP critical control classification. Serves as the supply-side item master linking to menu domain BOM for recipe costing. SSOT for ingredient identity across supply, inventory, and menu domains. Sourced from SAP MM material master and MarketMan Inventory Management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` (
    `supply_purchase_order_id` BIGINT COMMENT 'Unique identifier for the supply_purchase_order data product (auto-inserted pre-linking).',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Purchase orders are issued by individual franchisees; linking enables franchise‑level cost allocation and procurement performance reports.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Internal purchase‑order entity must be associated with the restaurant site it serves for accurate inventory and financial reconciliation.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: PURCHASE_ORDER creation is done per restaurant location; linking PO to unit enables inventory budgeting and location‑specific spend reporting.',
    CONSTRAINT pk_supply_purchase_order PRIMARY KEY(`supply_purchase_order_id`)
) COMMENT 'Core transactional record for every purchase order issued to suppliers for food ingredients, beverages, packaging, and non-food supplies. Captures PO number, supplier reference, order date, requested delivery date, ship-to distribution center or restaurant, total PO value, currency, payment terms, approval status, and sourcing event linkage. Represents the contractual commitment to buy. Sourced from Coupa Procurement PO module and SAP S/4HANA MM purchasing.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Primary key for purchase_order_line',
    `ingredient_id` BIGINT COMMENT 'add column ingredient_id (BIGINT) with FK to supply.ingredient.ingredient_id - PO lines need to specify what ingredient/item is being ordered',
    `supply_purchase_order_id` BIGINT COMMENT 'add column supply_purchase_order_id (BIGINT) with FK to supply.supply_purchase_order.supply_purchase_order_id - PO lines must link to their parent purchase order',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Each PO line item is fulfilled for a specific restaurant; the FK supports line‑level receipt, cost allocation, and audit trails.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Line-item detail for each purchase order, capturing individual SKU/ingredient ordered, quantity ordered, unit of measure, agreed unit price, extended line value, COGS allocation, requested delivery date per line, and line status (open, partially received, closed, cancelled). Enables PMIX-level COGS tracking and ingredient-level spend analytics. Sourced from SAP S/4HANA MM (EKPO) and Coupa PO line items.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'System‑generated unique identifier for each goods receipt transaction.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Required for Contract Compliance Report that matches each goods receipt to the governing supplier contract, ensuring receipt quantities and terms align with contract obligations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links receipt of goods to cost center to allocate receiving costs and inventory valuation to the responsible cost center.',
    `distribution_center_id` BIGINT COMMENT 'Identifier of the distribution center or restaurant where goods were received.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `inspector_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `purchase_order_id` BIGINT COMMENT 'System identifier of the purchase order linked to this receipt.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier who shipped the goods.',
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
    `purchase_order_number` STRING COMMENT 'External purchase order number referenced by the receipt.',
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
    `contract_line_id` BIGINT COMMENT 'Foreign key linking to procurement.contract_line. Business justification: Needed for Three‑Way Match process linking receipt line to specific contract line for price verification and audit of contracted terms per SKU.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Associates each receipt line with a GL account for detailed expense posting and audit trail.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the receipt.',
    `goods_receipt_id` BIGINT COMMENT 'Identifier of the parent goods receipt transaction.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the goods.',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order_line. Business justification: Goods receipt lines must reference the originating purchase order line; the existing column name does not match the target PK, so a correctly named FK is added and the old column removed.',
    `receiving_user_employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the receipt.',
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
    `lot_number` STRING COMMENT 'Manufacturer‑assigned lot or batch identifier for traceability.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured at receipt.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing quality assessment of the received items.',
    `recall_status` STRING COMMENT 'Indicates if the item is subject to a product recall.. Valid values are `none|pending|recalled`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item accepted into inventory.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the receipt was logged in the system.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item rejected during receipt inspection.',
    `sku` STRING COMMENT 'Standardized product code for the received item.',
    `supplier_batch_number` STRING COMMENT 'Batch identifier provided by the supplier, may differ from internal lot number.',
    `temperature_control_required` BOOLEAN COMMENT 'True if the item must be stored under temperature‑controlled conditions.',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Temperature measured at receipt for temperature‑controlled items.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total monetary value for the accepted quantity (unit_price * received_quantity).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., kilograms, pounds, each).. Valid values are `kg|lb|each|ltr|gal`',
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
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Unifies contract records across domains, allowing legal and finance teams to reference a single contract entity for both supplier contract details and procurement contract management.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supports Contract Ownership Register, linking each supplier contract to the employee owner for accountability and audit trails.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns contract financial responsibility to a cost center for budgeting, expense tracking, and compliance reporting.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier party associated with this contract.',
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
    `price_uom` STRING COMMENT 'Unit of measure for the default price (e.g., per unit, per case).. Valid values are `per_unit|per_case|per_kg|per_liter`',
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
    `contract_id` BIGINT COMMENT 'Identifier of the supplier contract to which this price belongs.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the ingredient or SKU.',
    `stock_item_id` BIGINT COMMENT 'Identifier of the ingredient or stock keeping unit covered by this price.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` (
    `supplier_performance_id` BIGINT COMMENT 'Unique identifier for each supplier performance scorecard record.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier to which this performance record applies.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - supplier performance should be trackable per delivery location',
    `audit_findings_count` STRING COMMENT 'Number of non‑conformities identified in the latest food safety audit.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'Average number of days between purchase order issuance and receipt of goods.',
    `contract_compliance_flag` BOOLEAN COMMENT 'True if the supplier adheres to contractual terms and conditions.',
    `corrective_action_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required for the supplier (True) or not (False).',
    `fill_rate` DECIMAL(18,2) COMMENT 'Percentage of order line items fully supplied from inventory without backorder.',
    `food_safety_compliance_score` DECIMAL(18,2) COMMENT 'Score reflecting supplier compliance with FDA and HACCP food safety requirements.',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of invoices that match purchase order terms without discrepancies.',
    `last_audit_date` DATE COMMENT 'Date of the most recent food safety audit performed on the supplier.',
    `measurement_period_end` DATE COMMENT 'End date of the reporting period for the performance metrics.',
    `measurement_period_start` DATE COMMENT 'Start date of the reporting period for the performance metrics.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the supplier performance.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of deliveries received on or before the promised delivery date.',
    `order_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of orders delivered without errors in quantity or SKU.',
    `quality_rejection_rate` DECIMAL(18,2) COMMENT 'Percentage of received goods rejected due to quality issues.',
    `rating_tier` STRING COMMENT 'Supplier rating tier based on overall performance (e.g., Preferred, Approved, Conditional, Probationary).. Valid values are `preferred|approved|conditional|probationary`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance record was initially created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance record.',
    `total_invoices_evaluated` BIGINT COMMENT 'Count of supplier invoices reviewed for accuracy during the period.',
    `total_orders_evaluated` BIGINT COMMENT 'Count of purchase orders included in the performance assessment period.',
    CONSTRAINT pk_supplier_performance PRIMARY KEY(`supplier_performance_id`)
) COMMENT 'Periodic scorecard record evaluating supplier performance against foodservice supply chain KPIs: on-time-in-full (OTIF) rate, case fill rate, order accuracy, quality rejection rate, invoice accuracy, food safety audit score, and cold chain compliance. Captures measurement period (weekly/monthly/quarterly), composite scorecard rating (preferred, approved, conditional, probationary, suspended), corrective action plan (CAP) flag, and next review date. Aggregated from goods receipt variances, quality inspections, invoice match exceptions, and food safety audit results. Used for quarterly business reviews (QBRs), contract renewal decisions, and approved vendor list status changes.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` (
    `distribution_center_id` BIGINT COMMENT 'System-generated unique identifier for the distribution center.',
    `legal_entity_id` BIGINT COMMENT 'add column legal_entity_id (BIGINT) with FK to finance.legal_entity.legal_entity_id - distribution centers need legal entity ownership for financial consolidation',
    `address_line1` STRING COMMENT 'Primary street address of the distribution center.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `city` STRING COMMENT 'City where the distribution center is located.',
    `close_time` TIMESTAMP COMMENT 'Time of day the facility closes (HH:mm, 24‑hour).',
    `compliance_documentation_url` STRING COMMENT 'Link to stored compliance certificates and audit documents.',
    `cost_per_square_meter` DECIMAL(18,2) COMMENT 'Operational cost metric expressed in local currency per m².',
    `country` STRING COMMENT 'Three‑letter ISO country code of the distribution center location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution center record was first created in the system.',
    `cross_dock_enabled` BOOLEAN COMMENT 'True if the facility supports cross‑docking operations.',
    `dc_code` STRING COMMENT 'Business‑visible code used to reference the distribution center in external systems.',
    `distribution_center_status` STRING COMMENT 'Current operational status of the distribution center.. Valid values are `active|inactive|closed|maintenance`',
    `emergency_contact_phone` STRING COMMENT 'Phone number for emergency notifications related to the facility.',
    `facility_type` STRING COMMENT 'Classification of the facility based on temperature control capabilities.. Valid values are `ambient|refrigerated|frozen|mixed`',
    `fire_suppression_system` STRING COMMENT 'Type of fire suppression system installed (e.g., sprinkler, FM‑200).',
    `haccp_compliant` BOOLEAN COMMENT 'True if the facility complies with HACCP food‑safety standards.',
    `inspection_score` DECIMAL(18,2) COMMENT 'Numeric score assigned during the last inspection (0‑100).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent health or safety inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the distribution center (decimal degrees).',
    `lease_expiration_date` DATE COMMENT 'Date when the current lease agreement ends (if applicable).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the distribution center (decimal degrees).',
    `distribution_center_name` STRING COMMENT 'Human‑readable name of the distribution center.',
    `number_of_loading_docks` STRING COMMENT 'Count of loading dock bays available for inbound/outbound trucks.',
    `open_time` TIMESTAMP COMMENT 'Time of day the facility opens (HH:mm, 24‑hour).',
    `operating_hours` STRING COMMENT 'Standard daily operating window expressed as text (e.g., 06:00‑22:00).',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the facility.. Valid values are `owned|leased|third_party`',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the distribution center address.',
    `refrigeration_type` STRING COMMENT 'Specific refrigeration technology employed (e.g., cascade, glycol).',
    `region` STRING COMMENT 'Broad region (e.g., North America, EMEA) used for reporting and logistics planning.',
    `security_level` STRING COMMENT 'Physical security classification of the facility.. Valid values are `low|medium|high`',
    `state_province` STRING COMMENT 'State or province of the distribution center location.',
    `storage_capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Total usable storage volume of the center in cubic meters.',
    `supported_restaurant_count` STRING COMMENT 'Number of restaurant locations served by this distribution center.',
    `temperature_control_system` STRING COMMENT 'Description of the system used to maintain required temperatures.',
    `temperature_monitoring_interval_minutes` STRING COMMENT 'Frequency at which temperature readings are recorded.',
    `third_party_logistics_flag` BOOLEAN COMMENT 'Indicates whether a 3PL provider manages the facility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the distribution center record.',
    `waste_management_certified` BOOLEAN COMMENT 'Indicates whether the center holds a certified waste‑management program.',
    CONSTRAINT pk_distribution_center PRIMARY KEY(`distribution_center_id`)
) COMMENT 'Master record for each distribution center (DC), warehouse, and logistics node in the foodservice supply network including company-owned DCs, third-party logistics (3PL) facilities, cross-dock locations, and commissary kitchens. Captures DC code, name, full address, geographic region/market, facility type (ambient, refrigerated, frozen, mixed-temp), total storage capacity (pallet positions), operating hours, supported restaurant count, primary and backup DC assignments, and facility manager. SSOT for DC identity used across inbound logistics, inventory allocation, and restaurant replenishment. Sourced from SAP EWM and network design tools.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` (
    `inbound_shipment_id` BIGINT COMMENT 'System-generated unique identifier for the inbound freight shipment.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Supports Shipment Tracking Dashboard linking inbound shipments to the contract they fulfill, enabling compliance monitoring of delivery schedules and contract performance.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Shipments are delivered to individual restaurant sites; the FK enables logistics dashboards and delivery performance metrics per site.',
    `distribution_center_id` BIGINT COMMENT 'add column distribution_center_id (BIGINT) with FK to supply.distribution_center.distribution_center_id - inbound shipments need destination DC tracking',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order linked to this inbound shipment.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the goods.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Inbound shipments are routed to individual restaurant locations; linking enables shipment tracking, ETA dashboards, and dock scheduling per unit.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Real date and time when the shipment arrived at the destination.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Real date and time when the shipment left the origin.',
    `bill_of_lading_number` STRING COMMENT 'Identifier on the bill of lading document issued by the carrier.. Valid values are `^[A-Z0-9]{1,20}$`',
    `carrier_contact_phone` STRING COMMENT 'Primary phone number for the carriers logistics contact.. Valid values are `^+?[0-9]{7,15}$`',
    `carrier_name` STRING COMMENT 'Name of the transportation provider responsible for moving the shipment.',
    `carrier_scac_code` STRING COMMENT 'Standard Carrier Alpha Code used to uniquely identify the carrier in logistics systems.. Valid values are `^[A-Z0-9]{4}$`',
    `compliance_document_flag` BOOLEAN COMMENT 'Indicates whether all required compliance documents were attached.',
    `container_type` STRING COMMENT 'Physical container classification used for the shipment.. Valid values are `pallet|box|crate|bulk`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the freight cost.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_status` STRING COMMENT 'Current status of customs clearance for the shipment.. Valid values are `pending|cleared|rejected`',
    `delay_minutes` STRING COMMENT 'Total minutes the shipment arrived later than the scheduled arrival.',
    `destination_location_code` STRING COMMENT 'Code identifying the receiving distribution center or restaurant.',
    `exception_reason` STRING COMMENT 'Free‑text description of any exception or issue affecting the shipment.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total cost charged by the carrier for transporting the shipment.',
    `freight_invoice_number` STRING COMMENT 'Invoice number issued by the carrier for freight charges.',
    `freight_terms` STRING COMMENT 'Incoterm defining responsibility for freight costs and risk.. Valid values are `FOB|CIF|EXW|DDP`',
    `hazard_material_flag` BOOLEAN COMMENT 'True if the shipment contains regulated hazardous materials.',
    `is_expedited` BOOLEAN COMMENT 'True if the shipment was processed under an expedited service level.',
    `number_of_items` STRING COMMENT 'Count of individual items or SKUs contained in the shipment.',
    `origin_location_code` STRING COMMENT 'Code identifying the suppliers shipping location.',
    `payment_status` STRING COMMENT 'Current payment status of the freight invoice.. Valid values are `unpaid|paid|partial`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was physically received at the destination.',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time when the shipment is expected to arrive at the destination.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time when the shipment is expected to leave the origin.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the container.',
    `shipment_number` STRING COMMENT 'Business identifier assigned by the carrier or logistics system for tracking the shipment.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment.. Valid values are `in_transit|arrived|delayed|exception|cancelled`',
    `temperature_control_flag` BOOLEAN COMMENT 'Indicates whether the shipment required temperature-controlled transport.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature recorded during transport (°C).',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature recorded during transport (°C).',
    `transport_mode` STRING COMMENT 'Mode of transport used for the shipment.. Valid values are `refrigerated_truck|dry_van|ltl|ftl`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment record.',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the shipment in kilograms.',
    CONSTRAINT pk_inbound_shipment PRIMARY KEY(`inbound_shipment_id`)
) COMMENT 'Transactional record tracking each inbound freight shipment from a supplier to a distribution center or restaurant. Captures shipment ID, carrier name, mode of transport (refrigerated truck, dry van, LTL, FTL), origin supplier location, destination DC or restaurant, scheduled and actual arrival date/time, bill of lading number, freight cost, cold chain temperature log flag, and shipment status (in-transit, arrived, delayed, exception). Supports inbound logistics visibility and carrier performance tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` (
    `ingredient_lot_id` BIGINT COMMENT 'System-generated unique identifier for each ingredient lot record.',
    `haccp_plan_id` BIGINT COMMENT 'Reference to the HACCP plan governing this ingredient lot.',
    `ingredient_id` BIGINT COMMENT 'FK to supply.ingredient',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Allows Lot Responsibility Tracking, assigning the employee accountable for each ingredient lot to meet recall and quality investigation requirements.',
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
    `storage_location` STRING COMMENT 'Designated area within the DC (e.g., "Freezer A3").',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Target storage temperature in degrees Celsius for temperature‑controlled lots.',
    `supplier_code` STRING COMMENT 'Internal code used to identify the supplying vendor.',
    `supplier_lot_reference` STRING COMMENT 'Reference code used by the supplier to identify the lot in their system.',
    `temperature_controlled` BOOLEAN COMMENT 'True if the lot requires temperature‑controlled storage.',
    `total_cost` DECIMAL(18,2) COMMENT 'Aggregate cost for the entire lot (quantity × cost per unit).',
    `traceability_enabled` BOOLEAN COMMENT 'Indicates whether the lot is included in the enterprise traceability program.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity field (e.g., kilograms, liters).. Valid values are `kg|lb|g|oz|L|ml`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lot record.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Percentage of the lot that was discarded during processing.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Usable portion of the lot expressed as a percentage of total quantity.',
    CONSTRAINT pk_ingredient_lot PRIMARY KEY(`ingredient_lot_id`)
) COMMENT 'Lot and batch traceability record for received ingredients, enabling end-to-end traceability from supplier farm/plant through DC to restaurant for HACCP compliance and FDA recall management. Captures lot number, batch number, supplier lot reference, ingredient/SKU, production date, best-by date, country of origin, receiving DC, and lot disposition status (quarantine, released, consumed, recalled). Critical for food safety incident response.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` (
    `quality_inspection_id` BIGINT COMMENT 'Unique identifier for each quality inspection event.',
    `distribution_center_id` BIGINT COMMENT 'add column distribution_center_id (BIGINT) with FK to supply.distribution_center.distribution_center_id - inspections occur at DCs and need location context',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Quality inspections verify adherence to the HACCP plan; linking inspection to the plan supports inspection checklists and compliance dashboards.',
    `ingredient_id` BIGINT COMMENT 'add column ingredient_id (BIGINT) with FK to supply.ingredient.ingredient_id - quality inspections should specify which ingredient was inspected',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who performed the inspection.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier/vendor of the inspected item.',
    `quality_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who performed the inspection.',
    `site_id` BIGINT COMMENT 'Identifier of the site (DC or restaurant) where the inspection took place.',
    `audit_trail_reference` BIGINT COMMENT 'Identifier of the audit‑trail record that captures detailed change history for this inspection.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the inspected item complies with applicable food‑safety regulations.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the required corrective action must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'True when the defect triggers a mandatory corrective‑action workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection record was first created in the system.',
    `defect_category` STRING COMMENT 'Category of defect identified when inspection fails.. Valid values are `contamination|foreign_body|spoilage|label_error|other`',
    `disposition_action` STRING COMMENT 'Action taken with the inspected item after the result (e.g., accept, reject, return to supplier, quarantine).. Valid values are `accept|reject|return_to_supplier|quarantine`',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity measured during the inspection, expressed as a percent.',
    `inspection_method` STRING COMMENT 'Whether the inspection was performed manually by a person or by an automated system.. Valid values are `manual|automated`',
    `inspection_notes` STRING COMMENT 'Additional observations, comments, or remarks recorded by the inspector.',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection – pass or fail.. Valid values are `pass|fail`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was performed.',
    `inspection_type` STRING COMMENT 'Method used for the inspection (e.g., visual, temperature, microbiological, organoleptic).. Valid values are `visual|temperature|microbiological|organoleptic`',
    `lot_number` STRING COMMENT 'Batch or lot identifier associated with the inspected goods.',
    `quality_inspection_status` STRING COMMENT 'Operational status of the inspection record.. Valid values are `pending|completed|closed|cancelled`',
    `regulatory_reference` STRING COMMENT 'Regulatory standard or program governing the inspection (e.g., HACCP, FDA, USDA, ISO 22000).. Valid values are `HACCP|FDA|USDA|ISO22000`',
    `rejection_quantity` DECIMAL(18,2) COMMENT 'Amount of product rejected as a result of the inspection.',
    `sku` STRING COMMENT 'SKU of the product or ingredient inspected.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature measured for the product at inspection, expressed in degrees Celsius.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the rejection quantity.. Valid values are `kg|lb|units|liters`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the inspection record.',
    CONSTRAINT pk_quality_inspection PRIMARY KEY(`quality_inspection_id`)
) COMMENT 'Record of quality inspection events conducted on received goods at a DC or restaurant, capturing inspection date, inspector ID, ingredient/SKU and lot inspected, inspection type (visual, temperature, microbiological, organoleptic), pass/fail result, defect category, rejection quantity, and disposition action (accept, reject, return to supplier, quarantine). Feeds supplier performance scoring and HACCP corrective action workflows. Sourced from Zenput operational compliance and MarketMan receiving.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`recall_event` (
    `recall_event_id` BIGINT COMMENT 'System-generated unique identifier for the recall event record.',
    `ingredient_id` BIGINT COMMENT 'add column ingredient_id (BIGINT) with FK to supply.ingredient.ingredient_id - recall events should specify which ingredient is affected',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier that provided the recalled product.',
    `affected_dc_locations` STRING COMMENT 'List of distribution center locations where the recalled product was stored or shipped from.',
    `affected_ingredient_sku` STRING COMMENT 'Stock Keeping Unit of the ingredient or product affected by the recall.',
    `affected_lot_numbers` STRING COMMENT 'Comma‑separated list of lot or batch numbers impacted by the recall.',
    `affected_restaurant_locations` STRING COMMENT 'List of restaurant sites that received the recalled product.',
    `compliance_fda` BOOLEAN COMMENT 'True if the product complies with FDA regulations.',
    `compliance_haccp` BOOLEAN COMMENT 'True if the product meets HACCP safety standards.',
    `compliance_usda` BOOLEAN COMMENT 'True if the product complies with USDA regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall event record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for total_cost.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `disposal_method` STRING COMMENT 'Method used to dispose of or handle the recalled product.. Valid values are `incineration|landfill|donation|return_to_supplier|other`',
    `is_cold_chain_compliant` BOOLEAN COMMENT 'Indicates whether the recalled product required cold‑chain handling and remained compliant.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the recall.',
    `product_category` STRING COMMENT 'Broad category of the recalled product.. Valid values are `dairy|meat|produce|bakery|beverage|other`',
    `quantity_recalled` DECIMAL(18,2) COMMENT 'Total amount of product recalled, expressed in the unit_of_measure.',
    `recall_class` STRING COMMENT 'Regulatory classification indicating severity and health risk of the recall.. Valid values are `Class I|Class II|Class III`',
    `recall_closure_timestamp` TIMESTAMP COMMENT 'Date and time when the recall was officially closed or resolved.',
    `recall_initiation_timestamp` TIMESTAMP COMMENT 'Date and time when the recall was initiated.',
    `recall_number` STRING COMMENT 'Official recall reference number assigned by regulatory agency or supplier.',
    `recall_reason` STRING COMMENT 'Root cause for the recall (e.g., contamination, allergen mislabeling, foreign material).',
    `recall_severity` STRING COMMENT 'Severity level assigned to the recall based on health risk.. Valid values are `high|medium|low`',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event.. Valid values are `open|closed|in_progress|withdrawn`',
    `recall_type` STRING COMMENT 'Whether the recall was initiated voluntarily by the supplier or mandated by regulators.. Valid values are `voluntary|mandated`',
    `regulatory_notification_status` STRING COMMENT 'Status of notification to regulatory bodies (e.g., FDA, USDA).. Valid values are `notified|pending|completed`',
    `risk_score` STRING COMMENT 'Numeric risk rating (e.g., 1‑5) used for internal prioritization.',
    `temperature_deviation_flag` BOOLEAN COMMENT 'True if temperature excursions were detected for the recalled product.',
    `total_cost` DECIMAL(18,2) COMMENT 'Monetary value of the recalled quantity at the time of recall.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the recalled quantity.. Valid values are `kg|lb|unit|liter|gallon`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recall event record.',
    CONSTRAINT pk_recall_event PRIMARY KEY(`recall_event_id`)
) COMMENT 'Operational record of a food product or ingredient recall event initiated by a supplier, regulatory agency (FDA/USDA), or internal quality team. Captures recall reference number, recall class (Class I, II, III), affected ingredient/SKU, affected lot numbers, recall reason (contamination, allergen mislabeling, foreign material), recall initiation date, affected DC and restaurant locations, quantity recalled, disposal method, and regulatory notification status. Enables rapid traceability response using ingredient_lot linkage.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` (
    `commodity_category_id` BIGINT COMMENT 'Unique surrogate key for the commodity category. [_canonical_skip_reason: inferred role REFERENCE_LOOKUP, no minimum categories required]',
    `parent_commodity_category_id` BIGINT COMMENT 'Self-referencing FK on commodity_category (parent_commodity_category_id)',
    `category_id` BIGINT COMMENT 'add column procurement_category_id (BIGINT) with FK to procurement.category.category_id - commodity categories should align with procurement categories to avoid parallel hierarchies',
    `average_cost_per_unit` DECIMAL(18,2) COMMENT 'Average monetary cost (in base currency) for a single unit of commodity within the category, used for budgeting and spend analysis.',
    `average_lead_time_days` STRING COMMENT 'Typical number of days from order to receipt for items in this category.',
    `category_code` STRING COMMENT 'Alphanumeric code used to uniquely identify the commodity category within procurement systems.',
    `category_name` STRING COMMENT 'Human‑readable name of the commodity category.',
    `category_type` STRING COMMENT 'Broad classification indicating the nature of the commodity (e.g., raw material, packaging, equipment).. Valid values are `raw_material|packaging|equipment|service|other`',
    `commodity_category_code` STRING COMMENT 'Unique alphanumeric code that represents the commodity category across enterprise systems.',
    `commodity_category_status` STRING COMMENT 'Current lifecycle status of the commodity category.. Valid values are `active|inactive|deprecated`',
    `commodity_type` STRING COMMENT 'Broad classification of the commodity (e.g., food, beverage, packaging, non‑food).. Valid values are `food|beverage|packaging|non_food|equipment|services`',
    `compliance_fda` STRING COMMENT 'Indicates whether items in this category meet FDA food safety regulations.. Valid values are `compliant|non_compliant|exempt`',
    `compliance_haccp` STRING COMMENT 'Indicates whether items in this category adhere to HACCP safety standards.. Valid values are `compliant|non_compliant|exempt`',
    `compliance_requirements` STRING COMMENT 'Key regulatory or certification requirements applicable to the commodity (e.g., FDA, USDA, ISO 22000).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the category record was first created in the system.',
    `commodity_category_description` STRING COMMENT 'Detailed textual description providing context, typical items, and usage notes for the category.',
    `effective_from` DATE COMMENT 'Date when the category became effective for procurement.',
    `effective_until` DATE COMMENT 'Date when the category is retired or superseded; null if still active.',
    `hierarchy_level` STRING COMMENT 'Depth of the category in the hierarchy (1 = top level).',
    `is_leaf_category` BOOLEAN COMMENT 'Indicates whether the category has no child categories (true) or has sub‑categories (false).',
    `is_perishable` BOOLEAN COMMENT 'True when the commodity category includes items with limited shelf life requiring special handling.',
    `commodity_category_name` STRING COMMENT 'Descriptive name used by business users to identify the category (e.g., "Fresh Produce", "Dry Goods").',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the commodity category.',
    `primary_buyer_owner` STRING COMMENT 'Name of the internal buyer or department responsible for sourcing this commodity.',
    `risk_level` STRING COMMENT 'Risk classification based on supply chain volatility, regulatory exposure, or quality concerns.. Valid values are `low|medium|high|critical`',
    `risk_score` STRING COMMENT 'Numerical rating (0‑100) reflecting supply‑chain risk factors such as volatility, scarcity, and regulatory exposure.',
    `spend_percentage` DECIMAL(18,2) COMMENT 'Proportion of total spend that this category represents, expressed as a percentage.',
    `strategic_sourcing_tier` STRING COMMENT 'Tier indicating the strategic importance of the commodity for sourcing decisions.. Valid values are `core|strategic|leverage|non_strategic`',
    `typical_cogs_percent` DECIMAL(18,2) COMMENT 'Average Cost of Goods Sold percentage for the commodity category.',
    `unit_of_measure` STRING COMMENT 'Default measurement unit applied to quantities of commodities in this category.. Valid values are `kg|lb|unit|liter|gallon|case`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the category record.',
    CONSTRAINT pk_commodity_category PRIMARY KEY(`commodity_category_id`)
) COMMENT 'Master reference table for commodity_category. ';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` (
    `supply_contract_id` BIGINT COMMENT 'Primary key for the SupplyContract association',
    `procurement_supplier_id` BIGINT COMMENT 'add column procurement_supplier_id (BIGINT) with FK to procurement.procurement_supplier.procurement_supplier_id - supply contracts reference supply_supplier but should also link to the canonical procurement supplier for spend consolidation',
    `site_id` BIGINT COMMENT 'Foreign key linking to the site master',
    `supply_supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier master',
    `contract_number` STRING COMMENT 'Unique identifier for the supplier‑site contract',
    `delivery_terms` STRING COMMENT 'Delivery terms and conditions (e.g., FOB, CIF)',
    `lead_time_days` STRING COMMENT 'Standard lead time in days for deliveries under the contract',
    `price` DECIMAL(18,2) COMMENT 'Agreed unit price for supplied items under this contract',
    CONSTRAINT pk_supply_contract PRIMARY KEY(`supply_contract_id`)
) COMMENT 'This association product represents the contract between a supplier and a restaurant site. It captures the contract identifier, pricing, lead time, and delivery terms for each supplier‑site relationship.. Existence Justification: A supplier can provide ingredients to many restaurant sites, and a site can source from multiple suppliers. The business actively creates and manages a contract for each supplier‑site pair that records pricing, lead time, and delivery terms. These contracts are a distinct operational entity that is created, updated, and terminated by procurement staff.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supply_invoice` (
    `supply_invoice_id` BIGINT COMMENT 'Primary key for invoice',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Connects supplier invoice record in supply to AP invoice in finance for reconciliation and payment processing.',
    CONSTRAINT pk_supply_invoice PRIMARY KEY(`supply_invoice_id`)
) COMMENT 'Accounts payable invoice record from a supplier for goods or services delivered. Captures invoice number, supplier ID, invoice date, due date, payment terms, gross amount, tax amount, net amount, currency, three-way match status (PO–GR–invoice), dispute flag, and payment status. Feeds SAP S/4HANA AP (FI-AP) for payment processing and COGS accrual. Sourced from Coupa invoice management and SAP S/4HANA FI.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_supply_purchase_order_id` FOREIGN KEY (`supply_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_purchase_order`(`supply_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ADD CONSTRAINT `fk_supply_commodity_category_parent_commodity_category_id` FOREIGN KEY (`parent_commodity_category_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ADD CONSTRAINT `fk_supply_supply_contract_supply_supplier_id` FOREIGN KEY (`supply_supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supply_supplier`(`supply_supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_supplier` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for supply_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_subdomain' = 'ingredient_catalog');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `item_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Item Specification Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|oz|liter|ml');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `usda_grade` SET TAGS ('dbx_business_glossary_term' = 'USDA Grade');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `usda_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|U');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `vitamin_c_mg_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Vitamin C (mg) per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ALTER COLUMN `supply_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for supply_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
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
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
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
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `goods_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Line ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Po Line Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot / Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Line Notes');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'none|pending|recalled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `supplier_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `temperature_recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Line Total Cost');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|each|ltr|gal');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (Currency)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Amount Variance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
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
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_unit|per_case|per_kg|per_liter');
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
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`contract_price` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID');
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
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `supplier_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance Record ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `contract_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `corrective_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate (FR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `food_safety_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Compliance Score (FSCS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate (IAR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Food Safety Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Record Notes');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate (OTDR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `order_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Order Accuracy Rate (OAR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `quality_rejection_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejection Rate (QRR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `rating_tier` SET TAGS ('dbx_business_glossary_term' = 'Rating Tier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `rating_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probationary');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `total_invoices_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Invoices Evaluated');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_performance` ALTER COLUMN `total_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Orders Evaluated');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` SET TAGS ('dbx_subdomain' = 'logistics_network');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `close_time` SET TAGS ('dbx_business_glossary_term' = 'Daily Close Time');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `compliance_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation URL');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `cost_per_square_meter` SET TAGS ('dbx_business_glossary_term' = 'Cost per Square Meter');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `cross_dock_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Dock Capability Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|maintenance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type (Ambient/Refrigerated/Frozen/Mixed)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|mixed');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `haccp_compliant` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Name');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `number_of_loading_docks` SET TAGS ('dbx_business_glossary_term' = 'Number of Loading Docks');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `open_time` SET TAGS ('dbx_business_glossary_term' = 'Daily Open Time');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `refrigeration_type` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `storage_capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Cubic Meters)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `supported_restaurant_count` SET TAGS ('dbx_business_glossary_term' = 'Supported Restaurant Count');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `temperature_control_system` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control System');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `temperature_monitoring_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Interval (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `third_party_logistics_flag` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Logistics Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`distribution_center` ALTER COLUMN `waste_management_certified` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Certification');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` SET TAGS ('dbx_subdomain' = 'logistics_network');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID (PO_ID)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SUPPLIER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp (ACT_ARR_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp (ACT_DEP_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number (BOL_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Phone (CARRIER_PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name (CARRIER_NM)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier SCAC Code (CARRIER_SCAC)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `compliance_document_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Flag (COMP_DOC_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type (CONT_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'pallet|box|crate|bulk');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status (CUSTOMS_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|rejected');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Minutes (DELAY_MIN)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code (DEST_LOC)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason (EXCPT_REASON)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost (FREIGHT_COST)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `freight_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Number (FREIGHT_INV_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms (FREIGHT_TERMS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazard_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HAZ_MAT_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Shipment Flag (EXPEDITE_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `number_of_items` SET TAGS ('dbx_business_glossary_term' = 'Number of Items (ITEM_QTY)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code (ORIG_LOC)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp (RECEIPT_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `scheduled_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Timestamp (SCH_ARR_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp (SCH_DEP_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number (SEAL_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number (SHPMT_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status (SHIP_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'in_transit|arrived|delayed|exception|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Flag (TEMP_CTRL_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (TEMP_MAX_C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (TEMP_MIN_C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode (TRANS_MODE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'refrigerated_truck|dry_van|ltl|ftl');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters) (VOL_CU_M)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`inbound_shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (KG) (WEIGHT_KG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_subdomain' = 'ingredient_catalog');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier (HACCP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location (LOC)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C) (STOR_TEMP_C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code (SUPP_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `supplier_lot_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Reference (SLR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (TEMP_CTRL_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost (TOTAL_COST)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `traceability_enabled` SET TAGS ('dbx_business_glossary_term' = 'Traceability Enabled Flag (TRACE_EN_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|g|oz|L|ml');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage (WASTE_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YIELD_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `defect_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Category');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `defect_category` SET TAGS ('dbx_value_regex' = 'contamination|foreign_body|spoilage|label_error|other');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'accept|reject|return_to_supplier|quarantine');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'visual|temperature|microbiological|organoleptic');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot / Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Record Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|completed|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_value_regex' = 'HACCP|FDA|USDA|ISO22000');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `rejection_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejection Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|units|liters');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `affected_dc_locations` SET TAGS ('dbx_business_glossary_term' = 'Affected Distribution Center Locations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `affected_ingredient_sku` SET TAGS ('dbx_business_glossary_term' = 'Affected Ingredient SKU');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `affected_lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Numbers');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `affected_restaurant_locations` SET TAGS ('dbx_business_glossary_term' = 'Affected Restaurant Locations');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `compliance_fda` SET TAGS ('dbx_business_glossary_term' = 'FDA Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `compliance_haccp` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `compliance_usda` SET TAGS ('dbx_business_glossary_term' = 'USDA Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|donation|return_to_supplier|other');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `is_cold_chain_compliant` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Notes');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'dairy|meat|produce|bakery|beverage|other');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `quantity_recalled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recalled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Class (Class I, Class II, Class III)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Closure Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_severity` SET TAGS ('dbx_business_glossary_term' = 'Recall Severity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_severity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|withdrawn');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'voluntary|mandated');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'notified|pending|completed');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Recall Risk Score');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `temperature_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Deviation Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost of Recalled Product');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|unit|liter|gallon');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`recall_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` SET TAGS ('dbx_subdomain' = 'ingredient_catalog');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `parent_commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Commodity Category Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `parent_commodity_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `average_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Name');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging|equipment|service|other');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_category_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'food|beverage|packaging|non_food|equipment|services');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `compliance_fda` SET TAGS ('dbx_business_glossary_term' = 'FDA Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `compliance_fda` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `compliance_haccp` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `compliance_haccp` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_category_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Description');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `is_leaf_category` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Category Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Perishable Indicator');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `commodity_category_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Name');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `primary_buyer_owner` SET TAGS ('dbx_business_glossary_term' = 'Primary Buyer Owner');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Risk Score');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `spend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Spend Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `strategic_sourcing_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Sourcing Tier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `strategic_sourcing_tier` SET TAGS ('dbx_value_regex' = 'core|strategic|leverage|non_strategic');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `typical_cogs_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical COGS Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|unit|liter|gallon|case');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`commodity_category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` SET TAGS ('dbx_association_edges' = 'supply.supply_supplier,realestate.site');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplycontract - Supply Contract Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplycontract - Site Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplycontract - Supply Supplier Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Supplycontract - Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Supplycontract - Delivery Terms');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplycontract - Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_contract` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Supplycontract - Price');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_invoice` SET TAGS ('dbx_subdomain' = 'logistics_network');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_invoice` ALTER COLUMN `supply_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supply_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
