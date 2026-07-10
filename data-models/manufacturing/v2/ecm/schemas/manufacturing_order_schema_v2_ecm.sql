-- Schema for Domain: order | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`order` COMMENT 'Order management and fulfillment domain governing the end-to-end order lifecycle from customer purchase orders through production scheduling, shipment, and delivery confirmation. Manages order headers, line items, delivery schedules, RMAs, fulfillment SLAs, and customer order lifecycle via SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`order_header` (
    `order_header_id` BIGINT COMMENT 'System-generated unique identifier for the sales order header.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Industrial equipment orders need an installation site for field service planning; site details are in customer.account_site.',
    `automation_project_id` BIGINT COMMENT 'Foreign key linking to automation.automation_project. Business justification: Order‑Project Tracking links a sales order to the automation engineering project delivering the solution, needed for project budgeting and status reporting.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Links sales orders to the Contractual Compliance Obligation record that defines mandatory regulatory actions the order must satisfy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Overall order budgeting: assigning a sales order to a cost center supports order‑level expense allocation and budgeting reports.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the order.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Order processing uses a sold‑to contact for invoicing and communication; this contact is stored in customer.contact.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Project linkage: whole sales orders are tied to internal orders for project cost settlement and tracking.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Revenue attribution: linking orders to the originating sales opportunity enables pipeline‑to‑revenue reporting and commission calculations.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Order Management traceability: each order must reference the intake record that created it for audit and fulfillment reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue attribution: linking the order to a profit center enables consolidated profit‑and‑loss reporting per sales order.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Project Management Report requires linking each sales order to its implementation project for schedule and cost tracking.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Contract compliance: orders are executed under a sales contract; linking ensures legal and pricing terms are enforced per order.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Commission & performance reports require each sales order to be linked to the responsible sales rep employee.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Commission & accountability: each order is credited to the responsible sales rep, supporting commission payout and performance metrics.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Territory reporting: orders must be assigned to a sales territory for quota tracking, regional performance dashboards, and incentive calculations.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Shipping logistics require a reference to the customers shipping address; address data resides in customer.address.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Single‑source orders may designate a preferred supplier at the header level; used in order approval and compliance reporting.',
    `billing_block` BOOLEAN COMMENT 'Flag indicating whether billing of the order is blocked.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `credit_status` DECIMAL(18,2) COMMENT 'Credit check result for the customer at order time.',
    `currency_code` STRING COMMENT '',
    `currency_rate` DECIMAL(18,2) COMMENT 'Exchange rate from order currency to company code currency at pricing time.',
    `customer_account_group` STRING COMMENT 'SAP account group categorizing the customer.',
    `customer_purchase_order_date` DATE COMMENT 'Date on the customers purchase order.',
    `delivery_block` BOOLEAN COMMENT 'Flag indicating whether delivery of the order is blocked.',
    `distribution_channel` STRING COMMENT 'Channel through which the order is distributed (e.g., wholesale, retail).',
    `division` STRING COMMENT 'Business division handling the order.',
    `freight_terms` DECIMAL(18,2) COMMENT 'Terms governing freight cost responsibility (e.g., prepaid, collect).',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the order including packaging, measured in kilograms.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — promote to reference product]',
    `internal_comments` STRING COMMENT 'Internal notes visible only to company personnel.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Total net weight of all items in the order, measured in kilograms.',
    `order_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the order amounts.',
    `order_date` TIMESTAMP COMMENT '',
    `order_number` STRING COMMENT 'External business identifier for the order as used in customer communications.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer placed the order.',
    `order_priority` STRING COMMENT 'Priority level assigned to the order for processing.. Valid values are `low|medium|high|urgent`',
    `order_reason` STRING COMMENT 'Free‑text description of why the order was created (e.g., new project, replacement).',
    `order_status` STRING COMMENT 'Current lifecycle state of the order. [ENUM-REF-CANDIDATE: created|released|partially_delivered|completed|cancelled|closed|on_hold — promote to reference product]',
    `order_text` STRING COMMENT 'Long free‑text field for additional order instructions or remarks.',
    `order_type` STRING COMMENT 'Classification of the order based on fulfillment rules.. Valid values are `standard|rush|blanket|consignment`',
    `payment_terms` DECIMAL(18,2) COMMENT 'Contractual terms defining when payment is due (e.g., NET30).',
    `price_group` DECIMAL(18,2) COMMENT 'Group determining price level for the customer.',
    `price_list` DECIMAL(18,2) COMMENT 'Price list identifier used for pricing the order.',
    `pricing_date` DATE COMMENT 'Date on which the pricing conditions were determined.',
    `purchase_order_number` STRING COMMENT 'Reference number supplied by the customer for their internal tracking.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the order record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the order record.',
    `requested_delivery_date` DATE COMMENT 'Date requested by the customer for order delivery.',
    `route` STRING COMMENT 'Planned transportation route for delivering the order.',
    `sales_document_type` STRING COMMENT 'SAP SD document type code (e.g., OR for standard order).',
    `sales_group` STRING COMMENT 'Group of sales representatives responsible for the order.',
    `sales_office` STRING COMMENT 'Geographic sales office handling the order.',
    `sales_organization` STRING COMMENT 'Code of the sales organization responsible for the order.',
    `shipping_condition` STRING COMMENT 'Condition governing the shipping method for the order.. Valid values are `standard|express|pickup`',
    `shipping_point` STRING COMMENT 'Logistics location from which the order will be shipped.',
    `tax_code` STRING COMMENT 'Tax code applied to the order for tax calculation.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of line item amounts before taxes, discounts, and surcharges.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes, discounts, and surcharges.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the order.',
    `transportation_group` STRING COMMENT 'Classification of transportation mode and carrier.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the order in cubic meters.',
    CONSTRAINT pk_order_header PRIMARY KEY(`order_header_id`)
) COMMENT 'Core master record for customer purchase orders representing the full order commitment in the order-to-cash lifecycle. Captures customer reference, order type (standard, rush, blanket, consignment), requested delivery date, incoterms, payment terms, pricing date, total net value, currency, sales organization, distribution channel, division, and overall order status. Serves as the SSOT for all customer order commitments in the industrial manufacturing order lifecycle, driving downstream delivery, billing, and revenue recognition.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`line` (
    `line_id` BIGINT COMMENT 'Unique surrogate key for each order line record.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Enables Production Planning to pull the exact BOM version for the ordered product, essential for material requirement planning (MRP) reports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting: each sales order line must be charged to a cost center for internal cost reporting and profitability analysis.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Regulated products require batch traceability from order line to lot batch for quality, recall, and compliance management.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Order fulfillment requires linking each order line to the material master for inventory reservation, costing, and MRP planning; this is standard in manufacturing ERP systems.',
    `order_header_id` BIGINT COMMENT 'Identifier of the parent sales order (transaction header) to which this line belongs.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability tracking: linking order line revenue to a profit center enables margin reporting per product line.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Audit trail: order line must reference the originating quote line to validate pricing, configuration, and warranty obligations.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to automation.recipe. Business justification: Production Recipe Assignment Report requires linking each order line to the recipe used for manufacturing, ensuring traceability and compliance.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Required for the Regulatory Compliance Check process that validates each ordered material against applicable regulations before shipment, ensuring legal compliance and accurate reporting.',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: Serialized items need direct linkage between order line and specific serialized unit to support warranty, service, and traceability.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for Order Fulfillment & Costing report linking each order line to the master product record for pricing, compliance, and warranty tracking.',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to asset.spare_part. Business justification: Needed for Spare Part Sales process to tie sold line items to the spare‑part master for warranty and inventory tracking.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Picking process assigns a specific storage location to each order line to locate inventory in the warehouse; the link enables pick list generation and inventory accuracy.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Procurement assigns a supplier to each order line for purchasing; needed for supplier performance, cost analysis, and PO generation.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Cost allocation report maps each order line to a WBS element of the project for budgeting and earned‑value analysis.',
    `actual_delivery_date` DATE COMMENT 'Date the goods were actually received by the customer.',
    `backorder_indicator` BOOLEAN COMMENT 'True if the line is on backorder, otherwise false.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the material.',
    `blanket_release_number` STRING COMMENT 'Identifier of the blanket order release that generated this line.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the system after availability check.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order line record was created in the source system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values on this line.',
    `delivery_date` DATE COMMENT 'Actual date the line was delivered to the customer.',
    `delivery_status` STRING COMMENT 'Current status of the lines delivery.. Valid values are `pending|shipped|delivered|cancelled|backordered`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to this line.',
    `distribution_channel` STRING COMMENT 'Channel through which the product is sold (e.g., online, direct).',
    `division` STRING COMMENT 'Business division responsible for the product.',
    `gross_price` DECIMAL(18,2) COMMENT 'Total price after taxes and before discounts.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the line item including packaging (kilograms).',
    `inspection_status` STRING COMMENT 'Current status of the quality inspection process.. Valid values are `not_started|in_progress|completed`',
    `lead_time_days` STRING COMMENT 'Planned lead time in days from order to delivery.',
    `line_number` STRING COMMENT 'Sequential number of the line within the order, used for ordering and reference.',
    `line_status` STRING COMMENT '',
    `net_amount` DECIMAL(18,2) COMMENT '',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit before taxes and discounts.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the product itself without packaging (kilograms).',
    `plant` STRING COMMENT 'SAP plant code where the product is stocked or produced for this order line.',
    `pricing_condition` STRING COMMENT 'Pricing condition type governing the price calculation.. Valid values are `standard|discount|rebate|surcharge`',
    `product_description` STRING COMMENT 'Human‑readable description of the product or service on the line.',
    `promised_date` DATE COMMENT 'Date promised to the customer for delivery.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing quality assessment (0‑100).',
    `quality_status` STRING COMMENT 'Result of quality inspection for the line item.. Valid values are `passed|failed|pending`',
    `quantity` DECIMAL(18,2) COMMENT '',
    `rejection_reason` STRING COMMENT 'Reason provided when the line is rejected or cancelled.',
    `requested_delivery_date` TIMESTAMP COMMENT '',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity originally requested by the customer.',
    `rma_reference` STRING COMMENT 'Reference to an RMA record if the line is a return.',
    `sales_org` STRING COMMENT 'Organizational unit responsible for the sale.',
    `sales_price` DECIMAL(18,2) COMMENT 'Price per unit used for revenue recognition.',
    `sales_quantity` DECIMAL(18,2) COMMENT 'Quantity used for sales reporting, may differ from requested/confirmed units.',
    `schedule_line_date` DATE COMMENT 'Planned date for delivery or production of this line item.',
    `serial_number` STRING COMMENT 'Serial number for serialized items.',
    `storage_location` STRING COMMENT 'Warehouse or bin location from which the material will be shipped.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applicable to this line item.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., each, kilogram).. Valid values are `EA|KG|L|M|PCS|TON`',
    `unit_price` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the order line record.',
    `volume` DECIMAL(18,2) COMMENT 'Physical volume of the line item (cubic meters).',
    `volume_uom` STRING COMMENT 'Unit of measure for volume.. Valid values are `M3|L|FT3`',
    `weight_uom` STRING COMMENT 'Unit of measure for weight fields.. Valid values are `KG|LB|TON`',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Individual line item within a customer sales order representing a discrete product, automation system, or service being ordered. Captures material number, ordered and confirmed quantities, unit of measure, schedule line dates, net price, pricing conditions, plant assignment, storage location, delivery status, rejection reason, and blanket order release reference. Serves as the demand signal for MRP and production scheduling. May reference a parent blanket order for scheduling agreement releases.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` (
    `schedule_line_id` BIGINT COMMENT 'System-generated unique identifier for the schedule line record.',
    `line_id` BIGINT COMMENT '',
    `order_header_id` BIGINT COMMENT 'Identifier of the parent sales order header to which this schedule line belongs.',
    `schedule_split_parent_line_id` BIGINT COMMENT 'Reference to the original schedule line when this line is a split part.',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or material being scheduled for delivery.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Production scheduling allocates order schedule lines to exact stock locations for material staging; linking supports real-time allocation and capacity planning.',
    `backorder_indicator` BOOLEAN COMMENT 'True if the schedule line is backordered due to insufficient stock.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the produced material.',
    `committed_quantity` DECIMAL(18,2) COMMENT '',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the system for delivery after scheduling.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the system after ATP check and production planning.',
    `confirmed_quantity_uom` STRING COMMENT 'Unit of measure for the confirmed quantity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the line amount.',
    `delivery_date` TIMESTAMP COMMENT '',
    `goods_issue_date` DATE COMMENT 'Date on which the goods were posted to inventory for shipment.',
    `handling_unit` STRING COMMENT 'Identifier of the handling unit (e.g., pallet, container) used for the shipment.',
    `incoterms` STRING COMMENT 'International commercial terms governing delivery responsibilities.. Valid values are `EXW|FCA|FOB|CFR|CIF|DDP`',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of the confirmed quantity before taxes.',
    `lot_number` STRING COMMENT 'Lot identifier for quality and compliance tracking.',
    `mrp_confirmed_availability_date` DATE COMMENT 'Date when material availability was confirmed by MRP.',
    `plant` STRING COMMENT 'Manufacturing plant responsible for producing the scheduled quantity.',
    `priority_code` STRING COMMENT 'Priority of the schedule line for production and delivery planning.. Valid values are `high|medium|low`',
    `requested_delivery_date` DATE COMMENT 'Date the customer originally requested for delivery.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity originally requested by the customer for this schedule line.',
    `requested_quantity_uom` STRING COMMENT 'Unit of measure for the requested quantity (e.g., PCS, KG, M3).',
    `route` STRING COMMENT 'Planned transportation route for the delivery.',
    `schedule_line_number` STRING COMMENT 'Sequential number of the schedule line within the order line item.',
    `schedule_line_status` STRING COMMENT 'Current processing status of the schedule line.. Valid values are `confirmed|released|blocked|canceled|pending`',
    `schedule_status` STRING COMMENT '',
    `serial_number` STRING COMMENT 'Serial number for serialized items in the schedule line.',
    `shipping_point` STRING COMMENT 'Logistics location from which the goods will be shipped.',
    `split_indicator` BOOLEAN COMMENT 'True if the original order line has been split into multiple schedule lines.',
    `storage_location` STRING COMMENT 'Warehouse location where the goods will be staged before shipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule line record.',
    CONSTRAINT pk_schedule_line PRIMARY KEY(`schedule_line_id`)
) COMMENT 'Delivery schedule line within a sales order line item defining confirmed delivery quantities and dates for industrial manufacturing fulfillment. Captures schedule line number, confirmed quantity, delivery date, goods issue date, route, shipping point, and MRP-confirmed availability date. Critical for Available-to-Promise (ATP) checks and production scheduling alignment in the order fulfillment process.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`delivery` (
    `delivery_id` BIGINT COMMENT 'Primary key for delivery',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Delivery execution tracks the specific plant/site where goods are delivered; site info lives in customer.account_site.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Logistics expense accounting: delivery freight and handling costs are charged to a cost center for logistics cost analysis.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Link delivery to its originating order header; enables traceability and removes redundant order number fields.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who placed the original sales order.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created the delivery record.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Logistics KPI links each delivery to the project it serves, enabling on‑time delivery monitoring per project.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Needed for the Export/Import Compliance Verification report linking each delivery to the governing regulatory requirement for customs and hazardous material handling.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Inbound delivery records the supplying vendor; required for logistics tracking, on‑time delivery KPI, and supplier scorecards.',
    `actual_delivery_date` DATE COMMENT 'Date the delivery was actually received by the customer.',
    `actual_goods_issue_timestamp` TIMESTAMP COMMENT 'Timestamp when goods were actually issued from the warehouse.',
    `address_line1` STRING COMMENT 'First line of the street address for the delivery destination.',
    `carrier_code` STRING COMMENT 'Code of the logistics carrier responsible for transportation.',
    `carrier_name` STRING COMMENT '',
    `city` STRING COMMENT 'City component of the delivery destination address.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the delivery destination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` TIMESTAMP COMMENT '',
    `delivery_number` STRING COMMENT 'External delivery document number assigned by SAP for tracking and communication.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery.. Valid values are `planned|released|picked|shipped|delivered|cancelled`',
    `delivery_type` STRING COMMENT 'Classification of the delivery, e.g., stock shipment, return, consignment.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Base freight charge before taxes and surcharges.',
    `freight_tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the freight cost.',
    `freight_total_amount` DECIMAL(18,2) COMMENT 'Total freight charge including taxes and surcharges.',
    `handling_instructions` STRING COMMENT 'Special handling notes for the carrier (e.g., fragile, keep upright).',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the delivery contains hazardous or regulated materials.',
    `is_backorder` BOOLEAN COMMENT 'True when the delivery contains items that were previously on backorder.',
    `is_partial_delivery` BOOLEAN COMMENT 'Indicates whether the delivery fulfills only part of the sales order quantity.',
    `number_of_items` STRING COMMENT 'Count of individual line items included in the delivery.',
    `planned_delivery_date` DATE COMMENT 'Date the delivery is scheduled to arrive at the customer location.',
    `planned_goods_issue_date` DATE COMMENT 'Planned date on which goods are to be issued from inventory.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the delivery destination.. Valid values are `^[A-Z0-9]{3,10}$`',
    `priority` STRING COMMENT 'Priority level assigned to the delivery for scheduling purposes.. Valid values are `low|medium|high`',
    `ship_from_location` STRING COMMENT '',
    `shipping_condition` STRING COMMENT 'Incoterm defining responsibility and cost allocation between seller and buyer.. Valid values are `EXW|FOB|CIF|DDP`',
    `shipping_point` STRING COMMENT 'Plant or warehouse location code where the delivery originates.',
    `special_equipment_required` BOOLEAN COMMENT 'Indicates if special equipment (e.g., liftgate) is needed for delivery.',
    `state` STRING COMMENT 'State or province component of the delivery destination address.',
    `temperature_control_required` BOOLEAN COMMENT 'True when the shipment must be kept within a temperature range.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Combined gross weight of all items in the delivery, expressed in kilograms.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Combined volume of the delivery items, expressed in cubic meters.',
    `tracking_number` STRING COMMENT 'Unique identifier provided by the carrier to track the shipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the delivery record.',
    `window_end` TIMESTAMP COMMENT 'End timestamp of the agreed delivery time window.',
    `window_start` TIMESTAMP COMMENT 'Start timestamp of the agreed delivery time window.',
    CONSTRAINT pk_delivery PRIMARY KEY(`delivery_id`)
) COMMENT 'Outbound delivery document created from a sales order authorizing the physical shipment of finished goods or automation systems from a plant or warehouse. Captures delivery number, delivery type, shipping point, planned goods issue date, actual goods issue date, total weight, volume, carrier, tracking number, and delivery status. Links order fulfillment to warehouse execution and logistics operations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` (
    `delivery_item_id` BIGINT COMMENT 'System-generated unique identifier for the delivery line item.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Provides shipment traceability to the specific engineered component, required for compliance and after‑sales service analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Item‑level shipping cost allocation: each delivery item’s handling cost is assigned to a cost center for detailed expense tracking.',
    `delivery_id` BIGINT COMMENT 'Identifier of the parent outbound delivery document to which this line belongs.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Associate each delivery item with the order line it fulfills, providing clear lineage.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Enables Delivery Traceability and Warranty Claim process by tying each delivered item to its master product record.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Delivery execution tracks the source stock location of shipped items for traceability and logistics reporting.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Delivery‑to‑WBS tracking assigns each delivered item to a specific WBS element for cost roll‑up and variance analysis.',
    `actual_goods_issue_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods issue for this line was posted.',
    `batch_number` STRING COMMENT 'Batch identifier for the material, if batch‑managed.',
    `carrier_code` STRING COMMENT 'Identifier of the carrier responsible for transportation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery line record was first created in the system.',
    `delivered_quantity` DECIMAL(18,2) COMMENT '',
    `delivery_date` DATE COMMENT 'Planned date for the delivery of this line item.',
    `goods_movement_status` STRING COMMENT 'Status of the goods issue transaction for this line.. Valid values are `not_issued|issued|reversed`',
    `handling_unit_number` STRING COMMENT 'Identifier of the handling unit (pallet, crate) containing the material.',
    `inspection_result` STRING COMMENT 'Result of the quality inspection (e.g., pass, fail, rework).',
    `inventory_management_indicator` STRING COMMENT 'Flag indicating whether the line is subject to inventory management.. Valid values are `X|`',
    `item_category` STRING COMMENT 'Category defining the business purpose of the line (e.g., standard sale, return, consignment).. Valid values are `standard|return|consignment`',
    `item_number` STRING COMMENT '',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `movement_reason` STRING COMMENT 'Reason code for the goods movement, if applicable.',
    `movement_type` STRING COMMENT 'SAP movement type code that defines the kind of goods movement.',
    `pallet_number` STRING COMMENT 'Identifier of the pallet on which the line item is loaded.',
    `picking_status` STRING COMMENT 'Current status of the picking process for this line.. Valid values are `not_picked|partially_picked|picked|blocked`',
    `plant` STRING COMMENT 'Plant where the material is stocked for this delivery.',
    `promised_delivery_date` DATE COMMENT 'Customer‑promised delivery date agreed in the sales order.',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection for the delivered material.. Valid values are `not_required|required|passed|failed`',
    `quantity_delivered` DECIMAL(18,2) COMMENT 'Actual quantity of material that has been delivered (goods issue).',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity of material ordered for this delivery line.',
    `quantity_picked` DECIMAL(18,2) COMMENT 'Quantity of material that has been physically picked from inventory.',
    `route` STRING COMMENT 'Defined transportation route for the delivery.',
    `serial_number_end` STRING COMMENT 'Ending serial number of the range allocated to this line.',
    `serial_number_start` STRING COMMENT 'Starting serial number of the range allocated to this line, when serial‑managed.',
    `shipping_condition` STRING COMMENT 'Condition under which the goods are shipped (e.g., standard, express).',
    `shipping_point` STRING COMMENT 'Logistics point from which the goods are shipped.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types such as project stock, vendor consignment, etc.. Valid values are `E|K|L|M|N`',
    `storage_location` STRING COMMENT 'Warehouse storage location from which the material is picked.',
    `unit_of_measure` STRING COMMENT 'Measurement unit in which quantities are expressed.. Valid values are `EA|KG|L|M|PC|SET`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the delivery line record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Physical volume of the line item in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the line item in kilograms.',
    CONSTRAINT pk_delivery_item PRIMARY KEY(`delivery_item_id`)
) COMMENT 'Individual line item within an outbound delivery document specifying the material, quantity, batch, storage location, and picking status for each product being shipped. Captures delivery item number, material number, delivery quantity, picked quantity, batch number, serial number range, storage location, and goods movement status. Supports warehouse picking, packing, and goods issue execution.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` (
    `order_status_event_id` BIGINT COMMENT 'System‑generated unique identifier for each immutable status event record.',
    `order_header_id` BIGINT COMMENT 'Identifier of the sales order to which this status event belongs.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory audit of order status changes mandates recording the employee who triggered each event.',
    `business_reason_code` STRING COMMENT 'Higher‑level business driver for the event (e.g., demand_spike, inventory_shortage).',
    `change_reason_code` STRING COMMENT 'Standardized code describing why the status transition occurred (e.g., customer_request, production_complete).',
    `changed_by_user` STRING COMMENT '',
    `comments` STRING COMMENT 'Free‑form text for additional context or notes about the status change.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `document_reference` STRING COMMENT 'Reference to the source document (e.g., sales order number, delivery note) that triggered the event.',
    `event_sequence` STRING COMMENT 'Sequential number of the event for the given order, starting at 1.',
    `event_source` STRING COMMENT 'Originating system or application that generated the event (e.g., SAP SD, Opcenter MES).. Valid values are `SAP_SD|MES|CRM|ERP|Custom|Other`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the status change or milestone occurred in the order lifecycle.',
    `event_type` STRING COMMENT 'Category of the event – status transition, SLA breach detection, manual override, or system‑driven update.. Valid values are `status_change|sla_breach|manual_override|system_update`',
    `new_status` STRING COMMENT 'Order status after the event was applied. [ENUM-REF-CANDIDATE: created|confirmed|released|scheduled|shipped|delivered|cancelled|on_hold|closed — 9 candidates stripped; promote to reference product]',
    `previous_status` STRING COMMENT 'Order status before the event was applied. [ENUM-REF-CANDIDATE: created|confirmed|released|scheduled|shipped|delivered|cancelled|on_hold|closed — 9 candidates stripped; promote to reference product]',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this immutable event record was first written to the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the event record (should remain unchanged for immutable logs).',
    `sla_actual_minutes` STRING COMMENT 'Actual time taken to reach the milestone, in minutes, used to evaluate SLA compliance.',
    `sla_breach_flag` BOOLEAN COMMENT 'True when the event indicates a breach of the order Service‑Level Agreement.',
    `sla_target_minutes` STRING COMMENT 'Contracted SLA time target for the milestone, expressed in minutes.',
    `status_change_reason` STRING COMMENT '',
    `triggered_by` STRING COMMENT 'Entity that caused the status change – a human user, an automated system, or a scheduled batch.. Valid values are `user|system|batch_process`',
    CONSTRAINT pk_order_status_event PRIMARY KEY(`order_status_event_id`)
) COMMENT 'Immutable event log capturing every status transition and milestone in the order lifecycle including creation, confirmation, delivery, goods issue, POD, and SLA breach detection. Records event timestamp, previous and new status, triggering user or system, document change reference, business reason code, and breach indicator flag. Enables full order traceability, SLA compliance monitoring, and fulfillment performance analytics.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`order_rma` (
    `order_rma_id` BIGINT COMMENT 'Unique system-generated identifier for the RMA record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Return processing expense: RMA costs (inspection, restocking) are charged to a cost center for warranty expense reporting.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who initiated the return.',
    `material_master_id` BIGINT COMMENT 'Identifier of the product to be sent as a replacement, if applicable.',
    `order_header_id` BIGINT COMMENT 'Identifier of the original sales order linked to this RMA.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who approved the RMA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Supports the Return Compliance Assessment workflow, tracking regulatory obligations for returned items such as hazardous waste handling and reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: RMA returns are sent back to the original supplier; essential for warranty claim processing and supplier return metrics.',
    `actual_return_date` DATE COMMENT 'Date the returned items were actually received.',
    `approval_status` STRING COMMENT 'Current approval state of the RMA.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the RMA was approved.',
    `authorized_date` TIMESTAMP COMMENT '',
    `authorized_quantity` STRING COMMENT 'Quantity of items the system authorizes for return based on the original order.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier handling the return shipment.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `credit_amount` DECIMAL(18,2) COMMENT 'Total credit to be applied to the customers account.',
    `credit_memo_indicator` DECIMAL(18,2) COMMENT 'Flag indicating whether a credit memo will be issued for this RMA.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `expected_return_date` DATE COMMENT 'Planned date by which the returned items should arrive at the plant.',
    `handling_fee` DECIMAL(18,2) COMMENT 'Fee charged for processing the return.',
    `inspection_required` BOOLEAN COMMENT 'Indicates if the returned items must undergo quality inspection.',
    `is_damaged` BOOLEAN COMMENT 'True if the returned item was received with damage.',
    `is_repairable` BOOLEAN COMMENT 'True if the returned item can be repaired rather than replaced.',
    `is_warranty_claim` BOOLEAN COMMENT 'True if the return is processed under a warranty agreement.',
    `is_wrong_item` BOOLEAN COMMENT 'True if the returned item does not match the original order.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary amount after tax and fees.',
    `notes` STRING COMMENT 'Free‑form notes entered by service or sales staff.',
    `order_rma_status` STRING COMMENT 'Current lifecycle state of the RMA.. Valid values are `open|approved|rejected|closed|cancelled`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the RMA record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the RMA record.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount to be refunded to the customer before taxes and fees.',
    `rejection_reason` STRING COMMENT 'Explanation provided when an RMA is rejected.',
    `replacement_quantity` STRING COMMENT 'Quantity of replacement units to be shipped.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the RMA was initially requested by the customer or service team.',
    `requested_date` TIMESTAMP COMMENT '',
    `return_plant` STRING COMMENT 'Plant or warehouse code where the returned items are to be received.',
    `return_reason` STRING COMMENT '',
    `return_reason_code` STRING COMMENT 'Standardized code representing why the product is being returned.. Valid values are `defect|damage|wrong_item|warranty|other`',
    `return_reason_description` STRING COMMENT 'Free-text description providing details about the return reason.',
    `returned_quantity` STRING COMMENT 'Actual number of units received back from the customer.',
    `rma_number` STRING COMMENT 'Business-visible RMA number assigned by the order management system.',
    `rma_status` STRING COMMENT '',
    `rma_type` STRING COMMENT 'Classification of the RMA (e.g., warranty, non‑warranty, repair, replacement).. Valid values are `warranty|non_warranty|repair|replace`',
    `shipping_method` STRING COMMENT 'Method used to ship the returned product back to the plant.. Valid values are `ground|air|sea|pickup`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the refund or credit.',
    `tracking_number` STRING COMMENT 'Tracking identifier provided by the carrier for the return shipment.',
    CONSTRAINT pk_order_rma PRIMARY KEY(`order_rma_id`)
) COMMENT 'Return Material Authorization record managing the end-to-end return process for defective, damaged, or incorrectly shipped industrial products and automation systems. Captures RMA number, originating sales order reference, return reason code (quality defect, shipping damage, wrong item, warranty claim), authorized return quantity, return plant, credit memo indicator, inspection requirement flag, and RMA status. Integrates with returns processing workflows and quality non-conformance reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`rma_line` (
    `rma_line_id` BIGINT COMMENT 'System-generated unique identifier for the RMA line item.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Links returned items to the original engineered component for warranty claim evaluation and root‑cause analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line‑level return cost allocation: each returned item’s cost is tracked against a cost center for detailed RMA cost analysis.',
    `delivery_id` BIGINT COMMENT 'Identifier of the delivery that originally supplied the returned material.',
    `line_id` BIGINT COMMENT '',
    `order_header_id` BIGINT COMMENT 'Sales order identifier for the replacement item shipped to the customer.',
    `order_rma_id` BIGINT COMMENT 'Identifier of the parent RMA document to which this line belongs.',
    `production_work_order_id` BIGINT COMMENT 'Identifier of the work order created for reworking the returned item.',
    `sku_master_id` BIGINT COMMENT '',
    `batch_number` STRING COMMENT 'Batch or lot identifier for the returned material.',
    `condition_code` STRING COMMENT 'Code indicating the physical condition of the returned item (e.g., new, damaged, used).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the RMA line record was created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary credit to be issued to the customer for this line.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the credit amount (e.g., USD, EUR).',
    `disposition` STRING COMMENT '',
    `disposition_action` STRING COMMENT 'Business decision for the returned item: scrap, rework, restock, or replace.. Valid values are `scrap|rework|restock|replace`',
    `disposition_reason` STRING COMMENT 'Narrative explanation for the chosen disposition action.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the returned item must undergo quality inspection.',
    `inspection_status` STRING COMMENT 'Current status of the quality inspection for the returned item.. Valid values are `pending|passed|failed`',
    `material_description` STRING COMMENT 'Human‑readable description of the returned material.',
    `notes` STRING COMMENT 'Free‑form text field for additional comments or special handling instructions.',
    `original_delivery_date` DATE COMMENT 'Date on which the original delivery was posted.',
    `received_date` DATE COMMENT 'Date the returned material was received at the warehouse.',
    `refund_amount` DECIMAL(18,2) COMMENT '',
    `replace_flag` BOOLEAN COMMENT 'True if the returned item will be replaced with a new unit.',
    `replacement_part_number` STRING COMMENT 'Material number of the replacement part, if a replace action is selected.',
    `restock_bin` STRING COMMENT 'Specific bin or storage location within the warehouse.',
    `restock_location` STRING COMMENT 'Logical location where the item will be restocked (e.g., plant, zone).',
    `restock_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item to be returned to inventory after disposition.',
    `restock_status` STRING COMMENT 'Current processing status of the restocking operation.. Valid values are `pending|completed|error`',
    `restock_warehouse` STRING COMMENT 'Warehouse identifier for the restocked inventory.',
    `return_date` DATE COMMENT 'Date the customer initiated the return request.',
    `return_quantity` DECIMAL(18,2) COMMENT '',
    `return_reason_code` STRING COMMENT 'Standardized code describing why the material is being returned.',
    `return_reason_description` STRING COMMENT 'Detailed description of the return reason.',
    `returned_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material being returned on this line.',
    `rework_flag` BOOLEAN COMMENT 'True if the item requires rework before it can be restocked.',
    `scrap_flag` BOOLEAN COMMENT 'True if the returned item is to be scrapped.',
    `scrap_reason` STRING COMMENT 'Explanation for why the item is being scrapped.',
    `serial_number` STRING COMMENT 'Serial number of the returned unit, if applicable.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity (e.g., EA, KG, L).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the RMA line record.',
    `warranty_claim_flag` BOOLEAN COMMENT 'True if the return is covered under a warranty claim.',
    `warranty_claim_number` STRING COMMENT 'Identifier of the warranty claim associated with this return.',
    CONSTRAINT pk_rma_line PRIMARY KEY(`rma_line_id`)
) COMMENT 'Individual line item within an RMA document specifying the material, quantity, and disposition instructions for each returned product. Captures RMA line number, material number, returned quantity, original delivery reference, serial numbers, batch number, condition code, disposition action (scrap, rework, restock, replace), and credit value. Supports quality inspection routing and inventory reintegration decisions.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` (
    `fulfillment_sla_id` BIGINT COMMENT 'Unique surrogate key for the SLA record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer to which this SLA applies; null if SLA is not customer‑specific.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Tie SLA directly to the order it governs, removing duplicate order number.',
    `actual_days` STRING COMMENT '',
    `applicable_product_category_code` STRING COMMENT 'Code of the product category that the SLA governs; null if not product‑category specific.',
    `breach_action` STRING COMMENT 'Action taken when the SLA is breached.. Valid values are `discount|escalation|none`',
    `breach_reason` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA record was first created in the system.',
    `fulfillment_sla_description` STRING COMMENT 'Free‑form description of the SLA purpose, scope, and any special conditions.',
    `effective_end_date` DATE COMMENT 'Date on which the SLA expires or is superseded; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date on which the SLA becomes binding.',
    `expedite_eligible` BOOLEAN COMMENT 'Indicates whether the SLA permits expedited processing for the associated orders.',
    `fulfillment_sla_status` STRING COMMENT 'Current lifecycle status of the SLA.. Valid values are `active|inactive|draft|expired|pending`',
    `last_review_date` DATE COMMENT 'Date when the SLA was last reviewed for relevance and compliance.',
    `max_order_quantity` STRING COMMENT 'Maximum quantity of items allowed per order under this SLA.',
    `measurement_window_days` STRING COMMENT 'Rolling period in days over which SLA performance is measured.',
    `min_order_quantity` STRING COMMENT 'Minimum quantity of items required per order to qualify for this SLA.',
    `on_time_delivery_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of orders that must be delivered on or before the target lead time to meet the SLA.',
    `order_confirmation_turnaround_hours` STRING COMMENT 'Maximum allowed time in hours between order receipt and order confirmation.',
    `penalty_terms` STRING COMMENT 'Textual description of financial or service penalties applied when the SLA is breached.',
    `sla_code` STRING COMMENT 'Business identifier code for the SLA, used in contracts and reporting.',
    `sla_met_flag` BOOLEAN COMMENT '',
    `sla_name` STRING COMMENT 'Human‑readable name of the SLA.',
    `sla_type` STRING COMMENT 'Classification of the SLA based on the entity it applies to (e.g., customer‑specific, order‑type, product‑category, geographic region).. Valid values are `customer|order_type|product_category|region`',
    `sla_version` STRING COMMENT 'Version identifier for the SLA, incremented on each change.',
    `target_days` STRING COMMENT '',
    `target_lead_time_days` STRING COMMENT 'Promised number of calendar days from order receipt to delivery.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SLA record.',
    CONSTRAINT pk_fulfillment_sla PRIMARY KEY(`fulfillment_sla_id`)
) COMMENT 'Service Level Agreement master record defining order fulfillment performance targets for customer accounts, order types, or product categories. Captures SLA code, target lead time days, on-time delivery threshold percentage, order confirmation turnaround hours, expedite eligibility, penalty terms, measurement window, and validity period. Used for automated breach detection against order_status_event timestamps and fulfillment KPI dashboards.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` (
    `goods_issue_id` BIGINT COMMENT 'Primary key for goods_issue',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer receiving the goods.',
    `delivery_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'System user who performed the goods issue posting.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Link goods issue to the order header for end‑to‑end tracking, removing redundant sales order number.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Goods issue transaction records the originating stock location, essential for inventory decrement, audit trails, and compliance reporting.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Earned‑value reporting requires linking material issues to WBS elements to calculate actual cost versus planned value.',
    `actual_delivery_date` DATE COMMENT 'Date when the goods were actually delivered to the customer.',
    `batch_number` STRING COMMENT 'Batch identifier for the material, if batch‑managed.',
    `cost_center` DECIMAL(18,2) COMMENT 'Cost center responsible for the goods issue cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `delivery_date` DATE COMMENT 'Planned date for delivery to the customer.',
    `delivery_doc_number` STRING COMMENT 'Outbound delivery document linked to the goods issue.',
    `expected_delivery_date` DATE COMMENT 'System‑calculated expected delivery date based on lead times.',
    `external_reference` STRING COMMENT 'Reference to external system such as carrier tracking number.',
    `goods_issue_status` STRING COMMENT 'Current lifecycle status of the goods issue.. Valid values are `posted|reversed|pending|cancelled`',
    `handling_unit` STRING COMMENT 'Identifier of the handling unit (e.g., pallet) used for the issue.',
    `incoterms` STRING COMMENT 'International commercial terms governing delivery responsibilities.. Valid values are `EXW|FCA|CPT|CIP|DAP|DDP`',
    `inventory_account` STRING COMMENT 'General ledger account for inventory posting.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the goods issue was generated automatically by a system.',
    `issue_number` BOOLEAN COMMENT 'External document number assigned to the goods issue.',
    `issued_by_user` STRING COMMENT '',
    `issued_quantity` DECIMAL(18,2) COMMENT '',
    `material_document_number` STRING COMMENT '',
    `material_number` STRING COMMENT 'Master data identifier of the material issued.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the goods issue.. Valid values are `101|102|201|202`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary amount after tax.',
    `plant` STRING COMMENT 'Plant where the goods issue originated.',
    `posting_date` TIMESTAMP COMMENT '',
    `posting_reason` STRING COMMENT 'Reason for the goods issue posting.. Valid values are `normal|return|scrap|transfer`',
    `posting_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods issue was posted in the source system.',
    `profit_center` STRING COMMENT 'Profit center associated with the revenue from this issue.',
    `purchase_order_number` STRING COMMENT 'Purchase order associated with the material movement, if applicable.',
    `quality_status` STRING COMMENT 'Quality inspection result for the issued material.. Valid values are `accepted|rejected|pending`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material issued.',
    `remarks` STRING COMMENT 'Additional free‑text notes about the goods issue.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this record is a reversal of a previous goods issue.',
    `route` STRING COMMENT 'Planned transportation route for the shipment.',
    `serial_number` STRING COMMENT 'Serial number of the issued item, if serialized.',
    `shipping_point` STRING COMMENT 'Logistics shipping point from which the goods are dispatched.',
    `storage_location` STRING COMMENT 'Storage location from which the goods were issued.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applicable to the goods issue, if any.',
    `total_value_cost` DECIMAL(18,2) COMMENT 'Total monetary value of the issued goods at standard cost.',
    `uom` STRING COMMENT 'Unit of measure for the issued quantity.. Valid values are `EA|KG|L|M|PCS|SET`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `valuation_area` STRING COMMENT 'Organizational area for inventory valuation.',
    `valuation_type` STRING COMMENT 'Method used for inventory valuation of the issued material.. Valid values are `standard|moving|periodic`',
    CONSTRAINT pk_goods_issue PRIMARY KEY(`goods_issue_id`)
) COMMENT 'Goods issue posting event recording the physical departure of finished goods, automation systems, or components from a plant or warehouse against an outbound delivery document. Captures goods issue document number, posting date, movement type (standard issue, reversal), plant, storage location, material document number, total value at cost, and goods issue status. Triggers inventory reduction, revenue recognition eligibility, COGS posting, and billing due list creation. Represents the legal transfer of custody from manufacturer to carrier.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` (
    `proof_of_delivery_id` BIGINT COMMENT 'System-generated unique identifier for the proof of delivery record.',
    `customer_contact_id` BIGINT COMMENT 'Identifier of the customer or party that received the shipment.',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: Connect POD to its delivery, consolidating address info in delivery.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Monetary amount invoiced to the customer as a result of the delivery.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier that performed the shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the proof of delivery record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the billed amount.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `delivered_timestamp` TIMESTAMP COMMENT '',
    `delivery_condition` STRING COMMENT 'Condition of the goods as reported by the recipient at receipt.. Valid values are `accepted|accepted_with_damage|rejected`',
    `discrepancy_notes` STRING COMMENT 'Free‑text notes describing any differences between ordered and received quantities or condition.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the delivery location captured at proof of delivery.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the delivery location captured at proof of delivery.',
    `invoice_number` STRING COMMENT 'Identifier of the invoice generated from this proof of delivery.',
    `pod_document_url` STRING COMMENT 'Link to the stored electronic proof of delivery document (PDF, image, etc.).',
    `pod_number` STRING COMMENT 'External business identifier assigned to the proof of delivery, often used in customer communications.',
    `pod_source` STRING COMMENT 'Origin of the POD record (e.g., captured electronically on device, paper form, or carrier EDI).. Valid values are `electronic|paper|carrier_edi`',
    `pod_status` STRING COMMENT '',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time when the proof of delivery was recorded at the delivery site.',
    `proof_of_delivery_status` STRING COMMENT 'Current lifecycle status of the proof of delivery record.. Valid values are `pending|completed|rejected|partial`',
    `quantity_received` DECIMAL(18,2) COMMENT 'Number of units received by the customer.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the received quantity.. Valid values are `EA|KG|L|M|M2|M3`',
    `recipient_name` STRING COMMENT 'Legal name of the individual or entity that accepted the delivery.',
    `recipient_signature` STRING COMMENT 'Reference (e.g., URL or hash) to the captured signature of the recipient.',
    `signature_image_url` STRING COMMENT '',
    `signed_by_name` STRING COMMENT '',
    `tracking_number` STRING COMMENT 'Tracking identifier provided by the carrier for the shipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the proof of delivery record.',
    CONSTRAINT pk_proof_of_delivery PRIMARY KEY(`proof_of_delivery_id`)
) COMMENT 'Record confirming the physical receipt and acceptance of shipped industrial goods by the customer at the delivery destination. Captures POD date, recipient name, signature reference, delivery condition (accepted, accepted with damage, rejected), quantity received, discrepancy notes, GPS coordinates of delivery, and POD source (electronic, paper, carrier EDI). Triggers final billing eligibility and transfer of risk confirmation in the order-to-cash process.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`amendment` (
    `amendment_id` BIGINT COMMENT 'System‑generated unique identifier for the order amendment record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the original order.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the approval action.',
    `line_id` BIGINT COMMENT 'Identifier of the specific order line that the amendment affects, if applicable.',
    `order_header_id` BIGINT COMMENT 'Identifier of the original sales order that is being amended.',
    `amendment_number` STRING COMMENT 'Human‑readable sequential number assigned to the amendment for external reference.',
    `amendment_status` STRING COMMENT 'Current processing status of the amendment.. Valid values are `draft|submitted|processed|closed`',
    `amendment_timestamp` TIMESTAMP COMMENT 'Exact time when the amendment became effective in the system.',
    `amendment_type` STRING COMMENT 'Category of change requested in the amendment.. Valid values are `quantity_change|delivery_date_change|address_change|price_change|line_addition|line_deletion`',
    `approval_date` DATE COMMENT 'Date on which the amendment was approved or rejected.',
    `approval_status` STRING COMMENT 'Current approval state of the amendment.. Valid values are `pending|approved|rejected|escalated`',
    `change_document_reference` STRING COMMENT 'Reference to supporting documentation (e.g., PDF, SAP change order).',
    `change_request_date` DATE COMMENT 'Date on which the amendment request was submitted.',
    `comments` STRING COMMENT 'Free‑form notes entered by the requester or approver.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `effective_date` TIMESTAMP COMMENT '',
    `effective_from` DATE COMMENT 'Start date when the amendment terms become valid.',
    `effective_until` DATE COMMENT 'End date for the amendment validity, if applicable.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the amendment is considered critical for the customer or production schedule.',
    `original_address` STRING COMMENT 'Shipping address recorded on the order before amendment.',
    `original_amount` DECIMAL(18,2) COMMENT 'Total monetary amount before amendment (gross).',
    `original_delivery_date` DATE COMMENT 'Planned delivery date before the amendment.',
    `original_price` DECIMAL(18,2) COMMENT 'Unit price of the line item before amendment.',
    `original_quantity` DECIMAL(18,2) COMMENT 'Quantity value before the amendment.',
    `priority_code` STRING COMMENT 'Priority level assigned to the amendment for processing.. Valid values are `low|medium|high|critical`',
    `reason` STRING COMMENT '',
    `reason_code` STRING COMMENT 'Standardized code describing the business reason for the amendment.',
    `requested_by` STRING COMMENT 'Indicates whether the amendment was initiated by the customer or an internal user.. Valid values are `customer|internal`',
    `revised_address` STRING COMMENT 'Updated shipping address after amendment.',
    `revised_amount` DECIMAL(18,2) COMMENT 'Total monetary amount after amendment (gross).',
    `revised_delivery_date` DATE COMMENT 'Updated delivery date after the amendment.',
    `revised_price` DECIMAL(18,2) COMMENT 'Unit price of the line item after amendment.',
    `revised_quantity` DECIMAL(18,2) COMMENT 'Quantity value after the amendment.',
    `sla_actual_minutes` STRING COMMENT 'Actual time (in minutes) taken to process the amendment.',
    `sla_target_minutes` STRING COMMENT 'Target service‑level agreement time (in minutes) for processing the amendment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Record capturing a customer-requested or internally-initiated change to an existing sales order, including quantity changes, delivery date revisions, address updates, pricing adjustments, or line item additions and deletions. Captures amendment number, amendment type, change request date, requested by (customer or internal), original value, revised value, approval status, approval date, and change document reference. Supports order change management, customer communication workflows, and audit trail requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` (
    `blanket_order_id` BIGINT COMMENT 'System-generated unique identifier for the blanket order.',
    `customer_account_id` BIGINT COMMENT 'Internal identifier of the customer that owns the blanket agreement.',
    `agreement_description` STRING COMMENT 'Free‑text description providing context or special notes about the blanket order.',
    `agreement_number` STRING COMMENT 'External business number assigned to the blanket agreement.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the blanket order received formal approval.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the blanket order.',
    `blanket_order_number` STRING COMMENT '',
    `blanket_order_status` STRING COMMENT 'Current lifecycle state of the blanket order.. Valid values are `active|inactive|suspended|closed|draft`',
    `contract_status_reason` STRING COMMENT 'Free‑text explanation for the current status of the agreement.',
    `contract_type` STRING COMMENT 'Category of the agreement defining its purpose and governing rules.. Valid values are `scheduling|framework|blanket|service`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the blanket order record was first created in the system.',
    `cumulative_released_quantity` DECIMAL(18,2) COMMENT 'Total quantity that has been released to the customer to date.',
    `cumulative_released_value` DECIMAL(18,2) COMMENT 'Monetary value of all released quantities to date.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the agreement.. Valid values are `^[A-Z]{3}$`',
    `distribution_channel` STRING COMMENT 'Channel through which the products will be delivered (e.g., wholesale, direct).',
    `effective_from` DATE COMMENT 'Date on which the blanket agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the blanket agreement expires or is terminated (null for open‑ended).',
    `is_jit_enabled` BOOLEAN COMMENT 'Indicates whether the agreement supports JIT delivery scheduling.',
    `last_release_date` DATE COMMENT 'Date of the most recent call‑off release.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity the customer may release in a single call‑off.',
    `minimum_order_uom` STRING COMMENT 'Unit of measure for the minimum order quantity.. Valid values are `EA|KG|L|M|M2|M3`',
    `next_release_due_date` DATE COMMENT 'Planned date for the next scheduled release based on the release frequency.',
    `plant` STRING COMMENT 'Manufacturing plant responsible for fulfilling releases under the agreement.',
    `pricing_conditions` STRING COMMENT 'Textual description of pricing terms, discounts, and rebates applicable to the agreement.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the committed quantity (e.g., each, kilogram).. Valid values are `EA|KG|L|M|M2|M3`',
    `region` STRING COMMENT 'Geographic region (e.g., NA, EU) applicable to the agreement.',
    `release_frequency` STRING COMMENT 'Scheduled interval at which the customer may release call‑offs against the blanket order.. Valid values are `monthly|quarterly|weekly|on_demand`',
    `sales_organization` STRING COMMENT 'Organizational unit responsible for the sales side of the agreement.',
    `total_committed_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of product(s) the customer has committed to purchase over the agreement period.',
    `total_committed_value` DECIMAL(18,2) COMMENT 'Monetary value of the total committed quantity at the agreed pricing.',
    `total_contract_quantity` DECIMAL(18,2) COMMENT '',
    `total_contract_value` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the blanket order record.',
    `validity_end_date` TIMESTAMP COMMENT '',
    `validity_start_date` TIMESTAMP COMMENT '',
    CONSTRAINT pk_blanket_order PRIMARY KEY(`blanket_order_id`)
) COMMENT 'Long-term supply agreement or scheduling agreement from an industrial customer committing to purchase a defined quantity of products over a specified period at agreed pricing. Captures blanket order number, customer account, validity start and end dates, total committed quantity, total committed value, release frequency, minimum order quantity (MOQ), pricing conditions, and cumulative released quantity to date. Contains individual release call-offs as line-level records with release number, release date, quantity, requested delivery date, cumulative released quantity, and release status. Supports demand planning, JIT delivery scheduling, and production scheduling for high-volume OEM customers.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` (
    `blanket_order_release_id` BIGINT COMMENT 'System-generated unique identifier for the blanket order release record.',
    `blanket_order_id` BIGINT COMMENT 'Identifier of the parent blanket order (scheduling agreement) to which this release belongs.',
    `order_header_id` BIGINT COMMENT '',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product/material being released for delivery.',
    `blanket_order_release_status` STRING COMMENT 'Current lifecycle status of the release.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `cumulative_released_quantity` STRING COMMENT '',
    `currency_code` STRING COMMENT '',
    `delivery_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `release_amount` DECIMAL(18,2) COMMENT 'release amount',
    `release_date` DATE COMMENT 'Date on which the blanket order release was created or issued.',
    `release_notes` STRING COMMENT '',
    `release_number` STRING COMMENT 'Sequential number of the release within the blanket order, used for ordering and tracking.',
    `release_quantity` DECIMAL(18,2) COMMENT '',
    `release_status` STRING COMMENT '',
    `release_value` DECIMAL(18,2) COMMENT '',
    `release_value_amount` DECIMAL(18,2) COMMENT '',
    `released_amount` DECIMAL(18,2) COMMENT '',
    `released_quantity` DECIMAL(18,2) COMMENT 'released quantity',
    `remaining_quantity` DECIMAL(18,2) COMMENT '',
    `requested_delivery_date` DATE COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_blanket_order_release PRIMARY KEY(`blanket_order_release_id`)
) COMMENT 'Individual release call-off against a blanket order or scheduling agreement, specifying the quantity and delivery date for a specific shipment within the long-term supply commitment. Captures release number, blanket order reference, release date, release quantity, requested delivery date, cumulative released quantity, and release status. Enables JIT delivery scheduling and production demand triggering for OEM and high-volume industrial customers.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` (
    `pricing_condition_id` BIGINT COMMENT 'System-generated unique identifier for the pricing condition record.',
    `condition_type_id` BIGINT COMMENT 'Technical identifier linking to the master list of condition types.',
    `line_id` BIGINT COMMENT 'Identifier of the sales order line to which this pricing condition applies.',
    `sales_contract_id` BIGINT COMMENT 'Reference to the contract or agreement that defines this pricing condition.',
    `calculation_base` STRING COMMENT 'Reference base used for the condition calculation (e.g., net price, gross price, quantity).',
    `condition_description` STRING COMMENT 'Free‑text description of the pricing condition purpose or notes.',
    `condition_effective_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the condition became effective for the order line.',
    `condition_expiration_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the condition expired or was superseded.',
    `condition_group` STRING COMMENT 'Logical grouping identifier for related conditions (e.g., volume rebate group).',
    `condition_note` STRING COMMENT 'Additional free‑form notes or comments entered by users regarding the condition.',
    `condition_origin` STRING COMMENT 'Source of the condition – manually entered, system generated, or derived from a contract.. Valid values are `manual|system|agreement`',
    `condition_priority` STRING COMMENT 'Priority order used when multiple conditions could apply; lower numbers indicate higher priority.',
    `condition_rate` DECIMAL(18,2) COMMENT 'Percentage or rate applied by the condition (e.g., 5% discount).',
    `condition_rate_percent` DECIMAL(18,2) COMMENT '',
    `condition_rate_unit` DECIMAL(18,2) COMMENT 'Unit for the condition rate, such as "%" or "per_unit".',
    `condition_sequence` STRING COMMENT 'Sequential number indicating the order of this condition within the pricing procedure for the line.',
    `condition_status` STRING COMMENT 'Current lifecycle status of the condition.. Valid values are `active|inactive|expired`',
    `condition_type` STRING COMMENT 'Category of the pricing condition, such as base price, discount, surcharge, tax, or rebate.. Valid values are `base_price|material_discount|freight_surcharge|tax|rebate`',
    `condition_value` DECIMAL(18,2) COMMENT 'Monetary value associated with the condition (e.g., discount amount, surcharge amount).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing condition record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the condition value is expressed.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount amount granted by the condition.',
    `external_condition_reference` STRING COMMENT 'Identifier of the condition in an external system or contract (e.g., supplier agreement reference).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the condition is currently active (true) or has been deactivated (false).',
    `is_expedited` BOOLEAN COMMENT 'Indicates whether the condition relates to an expedited delivery surcharge.',
    `net_amount` DECIMAL(18,2) COMMENT 'Resulting net monetary impact of the condition after applying value, rate, and taxes.',
    `pricing_procedure_step` STRING COMMENT 'Step number within the pricing procedure where this condition is applied.',
    `scale_quantity` DECIMAL(18,2) COMMENT 'Quantity threshold at which a scale‑based price or discount becomes applicable.',
    `scale_quantity_uom` STRING COMMENT 'Unit of measure for the scale quantity break (e.g., EA, KG).',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Monetary surcharge amount added by the condition.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for the condition.',
    `tax_code` STRING COMMENT 'Tax classification code used to determine applicable tax rates.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Percentage tax rate applied by the tax condition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pricing condition record.',
    `validity_end_date` DATE COMMENT 'Date after which the pricing condition is no longer valid.',
    `validity_start_date` DATE COMMENT 'Date from which the pricing condition becomes valid.',
    CONSTRAINT pk_pricing_condition PRIMARY KEY(`pricing_condition_id`)
) COMMENT 'Pricing condition record applied to a sales order line capturing individual pricing elements that compose the final net price per the pricing procedure. Captures condition type (base price, material discount, freight surcharge, tax), condition value, currency, calculation base, scale quantity breaks, validity period, and pricing procedure step sequence. Supports complex industrial pricing scenarios including volume rebates, customer-specific discounts, surcharges for expedited delivery, and raw material price escalation clauses. Maintained independently when pricing agreements change mid-order or when retroactive price adjustments are applied.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`hold` (
    `hold_id` BIGINT COMMENT 'System-generated unique identifier for the order hold record.',
    `order_header_id` BIGINT COMMENT 'Identifier of the sales order to which this hold applies.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or system that created the hold.',
    `superseding_hold_id` BIGINT COMMENT 'Self-referencing FK on hold (superseding_hold_id)',
    `amount` DECIMAL(18,2) COMMENT 'Financial amount associated with the hold (e.g., credit limit amount).',
    `applied_by_user` STRING COMMENT '',
    `applied_timestamp` TIMESTAMP COMMENT '',
    `hold_category` STRING COMMENT 'High‑level grouping of the hold type for reporting.. Valid values are `financial|operational|quality|customer|regulatory|other`',
    `comments` STRING COMMENT 'Optional free‑form notes added by users.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the hold is required for regulatory compliance (e.g., export control).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the hold amount.. Valid values are `^[A-Z]{3}$`',
    `hold_number` STRING COMMENT 'Human‑readable identifier for the hold, used in communications and reporting.',
    `hold_reason` STRING COMMENT '',
    `hold_status` STRING COMMENT 'Current lifecycle state of the hold.. Valid values are `active|released|cancelled|escalated`',
    `hold_type` STRING COMMENT 'Category of the hold condition that blocks order fulfillment.. Valid values are `credit_limit|export_compliance|quality_quarantine|customer_dispute|pricing_approval|other`',
    `is_system_generated` BOOLEAN COMMENT 'True if the hold was automatically created by a system rule; false if manually entered.',
    `outcome` STRING COMMENT 'Result of the hold after processing.. Valid values are `resolved|unresolved|escalated|cancelled`',
    `placed_timestamp` TIMESTAMP COMMENT 'Date‑time when the hold became effective.',
    `priority` STRING COMMENT 'Business priority assigned to the hold for escalation handling.. Valid values are `low|medium|high|critical`',
    `reason` STRING COMMENT 'Free‑text description explaining why the hold was placed.',
    `release_conditions` STRING COMMENT 'Conditions that must be satisfied for the hold to be released.',
    `release_timestamp` TIMESTAMP COMMENT 'Date‑time when the hold was released or cancelled.',
    `released_timestamp` TIMESTAMP COMMENT '',
    `source` STRING COMMENT 'Origin of the hold – whether it was triggered by an automated system rule or a manual user action.. Valid values are `system|user`',
    `target_resolution_date` DATE COMMENT 'Planned date by which the hold should be resolved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record.',
    CONSTRAINT pk_hold PRIMARY KEY(`hold_id`)
) COMMENT 'Record of a hold or block placed on a sales order or order line that prevents fulfillment progression until the hold condition is resolved. Captures hold type (credit limit exceeded, export compliance review, quality quarantine, customer dispute, pricing approval pending), hold reason text, placed-by user or system trigger, hold start timestamp, target resolution date, release conditions, releasing authority, release timestamp, and hold outcome. Supports multiple concurrent holds per order. Enables operations teams to track blocked orders, measure hold duration KPIs, and ensure regulatory compliance gates are enforced before shipment.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`condition_type` (
    `condition_type_id` BIGINT COMMENT 'Primary key for condition_type',
    `parent_condition_type_id` BIGINT COMMENT 'Self-referencing FK on condition_type (parent_condition_type_id)',
    `amount` DECIMAL(18,2) COMMENT 'Default monetary or percentage amount associated with the condition type, if applicable.',
    `applicable_to` STRING COMMENT 'Business object to which the condition type can be applied.',
    `calculation_method` STRING COMMENT 'Indicates whether the condition value is entered manually, derived by the system, or calculated via a formula.',
    `calculation_type` STRING COMMENT '',
    `condition_type_category` STRING COMMENT 'High‑level classification of the condition type (e.g., pricing, tax, discount).',
    `condition_type_code` STRING COMMENT 'Short alphanumeric code used to reference the condition type in transactional systems.',
    `condition_class` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the condition type record was first created.',
    `condition_type_description` STRING COMMENT 'Detailed description of the purpose and usage of the condition type.',
    `discount_indicator` BOOLEAN COMMENT 'True if the condition type represents a discount.',
    `effective_from` DATE COMMENT 'Date from which the condition type becomes valid.',
    `effective_until` DATE COMMENT 'Date after which the condition type is no longer valid (null if open‑ended).',
    `is_active_flag` BOOLEAN COMMENT '',
    `is_default` BOOLEAN COMMENT 'Indicates whether this condition type is the default for its category.',
    `condition_type_name` STRING COMMENT 'Human‑readable name describing the condition type.',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple conditions apply (lower number = higher priority).',
    `condition_type_status` STRING COMMENT 'Current lifecycle status of the condition type.',
    `surcharge_indicator` DECIMAL(18,2) COMMENT 'True if the condition type represents a surcharge.',
    `tax_indicator` BOOLEAN COMMENT 'True if the condition type represents a tax.',
    `condition_type_type` STRING COMMENT 'Method used to calculate the condition value.',
    `unit_of_measure` STRING COMMENT 'Unit used for the condition value (e.g., percent, USD, units).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the condition type record.',
    CONSTRAINT pk_condition_type PRIMARY KEY(`condition_type_id`)
) COMMENT 'Master reference table for condition_type. Referenced by condition_type_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_schedule_split_parent_line_id` FOREIGN KEY (`schedule_split_parent_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ADD CONSTRAINT `fk_order_order_status_event_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ADD CONSTRAINT `fk_order_order_rma_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_order_rma_id` FOREIGN KEY (`order_rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_rma`(`order_rma_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ADD CONSTRAINT `fk_order_fulfillment_sla_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ADD CONSTRAINT `fk_order_proof_of_delivery_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ADD CONSTRAINT `fk_order_blanket_order_release_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ADD CONSTRAINT `fk_order_blanket_order_release_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_condition_type_id` FOREIGN KEY (`condition_type_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`condition_type`(`condition_type_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ADD CONSTRAINT `fk_order_hold_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_header`(`order_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ADD CONSTRAINT `fk_order_hold_superseding_hold_id` FOREIGN KEY (`superseding_hold_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`hold`(`hold_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ADD CONSTRAINT `fk_order_condition_type_parent_condition_type_id` FOREIGN KEY (`parent_condition_type_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`condition_type`(`condition_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `automation_project_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `address_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `billing_block` SET TAGS ('dbx_business_glossary_term' = 'Billing Block');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `currency_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `customer_account_group` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Group');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `customer_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `delivery_block` SET TAGS ('dbx_business_glossary_term' = 'Delivery Block');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `internal_comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_currency` SET TAGS ('dbx_business_glossary_term' = 'Order Currency');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Reason');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_text` SET TAGS ('dbx_business_glossary_term' = 'Order Text');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|blanket|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `price_group` SET TAGS ('dbx_business_glossary_term' = 'Price Group');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `price_list` SET TAGS ('dbx_business_glossary_term' = 'Price List');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `sales_document_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `sales_group` SET TAGS ('dbx_business_glossary_term' = 'Sales Group');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'standard|express|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `transportation_group` SET TAGS ('dbx_business_glossary_term' = 'Transportation Group');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_header` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `backorder_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `blanket_release_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Release Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|shipped|delivered|cancelled|backordered');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `gross_price` SET TAGS ('dbx_business_glossary_term' = 'Gross Price');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_value_regex' = 'standard|discount|rebate|surcharge');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `promised_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `rma_reference` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization Reference');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `sales_org` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `sales_price` SET TAGS ('dbx_business_glossary_term' = 'Sales Price');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `sales_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sales Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `schedule_line_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PCS|TON');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'M3|L|FT3');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'KG|LB|TON');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Schedule Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `schedule_split_parent_line_id` SET TAGS ('dbx_business_glossary_term' = 'Split Parent Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `backorder_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `confirmed_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `handling_unit` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DDP');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `mrp_confirmed_availability_date` SET TAGS ('dbx_business_glossary_term' = 'MRP Confirmed Availability Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `requested_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_value_regex' = 'confirmed|released|blocked|canceled|pending');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `split_indicator` SET TAGS ('dbx_business_glossary_term' = 'Split Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID (CBUID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ADD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `actual_goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Goods Issue Timestamp (AGIT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1 (DAL1)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code (CC)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City (DC)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country (DC)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number (DN)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status (DS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'planned|released|picked|shipped|delivered|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Type (DT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount (FCA)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `freight_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Tax Amount (FTA)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `freight_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Total Amount (FTA)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions (HI)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HMF)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `is_backorder` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag (BOF)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `is_partial_delivery` SET TAGS ('dbx_business_glossary_term' = 'Partial Delivery Flag (PDF)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `number_of_items` SET TAGS ('dbx_business_glossary_term' = 'Number of Items (NI)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (PDD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `planned_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Goods Issue Date (PGID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code (DPC)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority (DP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition (SC)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point (SP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `special_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Required Flag (SERF)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Delivery State/Province (DS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required Flag (TCRF)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight (KG)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (M3)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number (TN)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End (DWE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start (DWS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `delivery_item_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Item Identifier (DIID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Identifier (DDID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `actual_goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Goods Issue Timestamp (ACT_GI_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (CHARG)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code (CARR)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TSTMP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (PLND_DEL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Status (GM_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_value_regex' = 'not_issued|issued|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `handling_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Number (HU)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result (QI_RESULT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `inventory_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Inventory Management Indicator (IM_IND)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `inventory_management_indicator` SET TAGS ('dbx_value_regex' = 'X|');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category (ITM_CAT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|return|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description (MATDESC)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `movement_reason` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason (GRUND)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type (BWTAR)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `pallet_number` SET TAGS ('dbx_business_glossary_term' = 'Pallet Number (PAL_NUM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `picking_status` SET TAGS ('dbx_business_glossary_term' = 'Picking Status (PKG_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `picking_status` SET TAGS ('dbx_value_regex' = 'not_picked|partially_picked|picked|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (WERKS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date (PROM_DEL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status (QI_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|required|passed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `quantity_delivered` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity (DLV_QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity (ORD_QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `quantity_picked` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity (PCK_QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route (ROUTE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `serial_number_end` SET TAGS ('dbx_business_glossary_term' = 'Serial Number End (SERIAL_TO)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `serial_number_start` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Start (SERIAL_FROM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition (SHIP_COND)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point (VSTEL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator (SOBK)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'E|K|L|M|N');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location (LGORT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PC|SET');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TSTMP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (M3)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (KG)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `order_status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `business_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Business Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Event Comments');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `event_sequence` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `event_source` SET TAGS ('dbx_value_regex' = 'SAP_SD|MES|CRM|ERP|Custom|Other');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'status_change|sla_breach|manual_override|system_update');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `triggered_by` SET TAGS ('dbx_business_glossary_term' = 'Triggered By');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_status_event` ALTER COLUMN `triggered_by` SET TAGS ('dbx_value_regex' = 'user|system|batch_process');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` SET TAGS ('dbx_subdomain' = 'returns_processing');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `order_rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `order_rma_id` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `order_rma_id` SET TAGS ('dbx_ssot_master' = 'service.service_rma');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Return Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `credit_memo_indicator` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `handling_fee` SET TAGS ('dbx_business_glossary_term' = 'Handling Fee Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `is_damaged` SET TAGS ('dbx_business_glossary_term' = 'Damaged Item Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `is_repairable` SET TAGS ('dbx_business_glossary_term' = 'Repairable Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `is_warranty_claim` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `is_wrong_item` SET TAGS ('dbx_business_glossary_term' = 'Wrong Item Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RMA Notes');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `order_rma_status` SET TAGS ('dbx_business_glossary_term' = 'RMA Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `order_rma_status` SET TAGS ('dbx_value_regex' = 'open|approved|rejected|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `replacement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replacement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RMA Request Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `return_plant` SET TAGS ('dbx_business_glossary_term' = 'Return Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defect|damage|wrong_item|warranty|other');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `rma_type` SET TAGS ('dbx_business_glossary_term' = 'RMA Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `rma_type` SET TAGS ('dbx_value_regex' = 'warranty|non_warranty|repair|replace');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|sea|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_rma` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` SET TAGS ('dbx_subdomain' = 'returns_processing');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Original Delivery ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `order_rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rework Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'scrap|rework|restock|replace');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RMA Line Notes');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `original_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Original Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `replace_flag` SET TAGS ('dbx_business_glossary_term' = 'Replace Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `replacement_part_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Part Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `restock_bin` SET TAGS ('dbx_business_glossary_term' = 'Restock Bin');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `restock_location` SET TAGS ('dbx_business_glossary_term' = 'Restock Location');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `restock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Restock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `restock_status` SET TAGS ('dbx_business_glossary_term' = 'Restock Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `restock_status` SET TAGS ('dbx_value_regex' = 'pending|completed|error');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `restock_warehouse` SET TAGS ('dbx_business_glossary_term' = 'Restock Warehouse');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `scrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Scrap Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `scrap_reason` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `fulfillment_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `applicable_product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `breach_action` SET TAGS ('dbx_business_glossary_term' = 'Breach Action Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `breach_action` SET TAGS ('dbx_value_regex' = 'discount|escalation|none');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `fulfillment_sla_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `expedite_eligible` SET TAGS ('dbx_business_glossary_term' = 'Expedite Eligibility Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `fulfillment_sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `fulfillment_sla_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|expired|pending');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `on_time_delivery_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'On‑Time Delivery Threshold (Percentage)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `order_confirmation_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation Turnaround (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `penalty_terms` SET TAGS ('dbx_business_glossary_term' = 'Penalty Terms Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'customer|order_type|product_category|region');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `sla_version` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Version');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `target_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Target Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'User Identifier Who Posted the Goods Issue (POSTED_BY_USER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACTUAL_DELIVERY_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (DELIVERY_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `delivery_doc_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number (DLV_DOC_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date (EXPECTED_DELIVERY_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference (e.g., Carrier Tracking Number) (EXT_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Status (GI_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `handling_unit` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Identifier (HU_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (INCOTERMS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|CPT|CIP|DAP|DDP');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `inventory_account` SET TAGS ('dbx_business_glossary_term' = 'Inventory Account (INV_ACCT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Issue Indicator (IS_AUTOMATED)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Document Number (GI_DOC_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MATNR)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type (MOV_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '101|102|201|202');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount After Tax (NET_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `posting_reason` SET TAGS ('dbx_business_glossary_term' = 'Posting Reason (POST_REASON)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `posting_reason` SET TAGS ('dbx_value_regex' = 'normal|return|scrap|transfer');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Posting Timestamp (GI_POST_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code (PROFIT_CENTER)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status of Issued Goods (QUALITY_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Issued Quantity (ISSUED_QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks / Free Text (REMARKS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator (IS_REVERSAL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route (ROUTE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SERIAL_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point Code (SHIP_POINT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code (STGE_LOC_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `total_value_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Value at Cost (TOTAL_COST_VAL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PCS|SET');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `valuation_area` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area (VAL_AREA)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type (VAL_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving|periodic');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `carrier_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_business_glossary_term' = 'Delivery Condition');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_value_regex' = 'accepted|accepted_with_damage|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `pod_document_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Document URL');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `pod_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Source');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_value_regex' = 'electronic|paper|carrier_edi');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rejected|partial');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|M2|M3');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Full Name');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `recipient_signature` SET TAGS ('dbx_business_glossary_term' = 'Recipient Signature Reference');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`proof_of_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Amendment Identifier (OAID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (APP_USER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order Line Identifier (LINE_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (SO_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number (AMEND_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status (AMEND_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|processed|closed');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `amendment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Event Timestamp (AMEND_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type (AMEND_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'quantity_change|delivery_date_change|address_change|price_change|line_addition|line_deletion');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APP_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APP_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `change_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Document Reference (DOC_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `change_request_date` SET TAGS ('dbx_business_glossary_term' = 'Change Request Date (REQ_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Amendment Comments (COMMENTS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Amendment Indicator (IS_CRITICAL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_address` SET TAGS ('dbx_business_glossary_term' = 'Original Shipping Address (ORIG_ADDR)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Monetary Amount (ORIG_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Original Delivery Date (ORIG_DEL_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Unit Price (ORIG_PRICE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `original_quantity` SET TAGS ('dbx_business_glossary_term' = 'Original Quantity (ORIG_QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Priority (PRIORITY_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Code (REASON_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By (REQ_BY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `requested_by` SET TAGS ('dbx_value_regex' = 'customer|internal');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_address` SET TAGS ('dbx_business_glossary_term' = 'Revised Shipping Address (REV_ADDR)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Monetary Amount (REV_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Delivery Date (REV_DEL_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_price` SET TAGS ('dbx_business_glossary_term' = 'Revised Unit Price (REV_PRICE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `revised_quantity` SET TAGS ('dbx_business_glossary_term' = 'Revised Quantity (REV_QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Minutes (SLA_ACT_MIN)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Minutes (SLA_TGT_MIN)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|draft');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `contract_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Reason');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'scheduling|framework|blanket|service');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `cumulative_released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Released Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `cumulative_released_value` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Released Value');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `is_jit_enabled` SET TAGS ('dbx_business_glossary_term' = 'Just‑In‑Time Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `last_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `minimum_order_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `minimum_order_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|M2|M3');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `next_release_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Release Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `pricing_conditions` SET TAGS ('dbx_business_glossary_term' = 'Pricing Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|M2|M3');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `release_frequency` SET TAGS ('dbx_business_glossary_term' = 'Release Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `release_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|weekly|on_demand');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `total_committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `total_committed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Value');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Release ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_active' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_planned' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_released' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_cancelled' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_completed' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `pricing_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Order Pricing Condition Identifier (OPC_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_type_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type Identifier (COND_TYPE_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (OL_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `calculation_base` SET TAGS ('dbx_business_glossary_term' = 'Calculation Base (CALC_BASE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description (COND_DESC)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Condition Effective Timestamp (EFFECTIVE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Condition Expiration Timestamp (EXPIRATION_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_group` SET TAGS ('dbx_business_glossary_term' = 'Condition Group (COND_GROUP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_note` SET TAGS ('dbx_business_glossary_term' = 'Condition Note (COND_NOTE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_origin` SET TAGS ('dbx_business_glossary_term' = 'Condition Origin (COND_ORIGIN)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_origin` SET TAGS ('dbx_value_regex' = 'manual|system|agreement');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_priority` SET TAGS ('dbx_business_glossary_term' = 'Condition Priority (COND_PRIORITY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_rate` SET TAGS ('dbx_business_glossary_term' = 'Condition Rate (COND_RATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Condition Rate Unit (COND_RATE_UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_sequence` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Sequence (COND_SEQ)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status (COND_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type (COND_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'base_price|material_discount|freight_surcharge|tax|rebate');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_value` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Value (COND_VAL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `condition_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Condition Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `external_condition_reference` SET TAGS ('dbx_business_glossary_term' = 'External Condition Identifier (EXT_COND_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag (ACTIVE_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Delivery Flag (EXPEDITED_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount After Condition (NET_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `pricing_procedure_step` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Step (PROC_STEP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `scale_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity Break (SCALE_QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `scale_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity Unit of Measure (SCALE_UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount (SURCHARGE_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `tax_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `tax_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Condition Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Validity End Date (VALID_TO)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Validity Start Date (VALID_FROM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Order Hold ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placed By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `superseding_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Superseding Hold Id');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `superseding_hold_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_business_glossary_term' = 'Hold Category');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `hold_category` SET TAGS ('dbx_value_regex' = 'financial|operational|quality|customer|regulatory|other');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Hold Comments');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|cancelled|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'credit_limit|export_compliance|quality_quarantine|customer_dispute|pricing_approval|other');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `is_system_generated` SET TAGS ('dbx_business_glossary_term' = 'System Generated Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Hold Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|escalated|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placement Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Hold Source');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'system|user');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Type Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `parent_condition_type_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Condition Type Id');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `parent_condition_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `applicable_to` SET TAGS ('dbx_business_glossary_term' = 'Applicable To');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `discount_indicator` SET TAGS ('dbx_business_glossary_term' = 'Discount Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `surcharge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `condition_type_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`condition_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
