-- Schema for Domain: order | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`order` COMMENT 'Order management and fulfillment domain governing the end-to-end order lifecycle from customer purchase orders through production scheduling, shipment, and delivery confirmation. Manages order headers, line items, delivery schedules, RMAs, fulfillment SLAs, and customer order lifecycle via SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`header` (
    `header_id` BIGINT COMMENT 'System-generated unique identifier for the sales order header.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Industrial equipment orders need an installation site for field service planning; site details are in customer.account_site.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Order processing uses a sold‑to contact for invoicing and communication; this contact is stored in customer.contact.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the order.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: In engineer-to-order and NPI manufacturing, customer orders are executed against a specific engineering project. Program managers use this link for project-to-revenue tracking, PPAP milestone reportin',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Commission & accountability: each order is credited to the responsible sales rep, supporting commission payout and performance metrics.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Shipping logistics require a reference to the customers shipping address; address data resides in customer.address.',
    `billing_block` BOOLEAN COMMENT 'Flag indicating whether billing of the order is blocked.',
    `credit_status` STRING COMMENT 'Credit check result for the customer at order time.. Valid values are `unblocked|blocked|on_hold`',
    `currency_rate` DECIMAL(18,2) COMMENT 'Exchange rate from order currency to company code currency at pricing time.',
    `customer_account_group` STRING COMMENT 'SAP account group categorizing the customer.',
    `customer_purchase_order_date` DATE COMMENT 'Date on the customers purchase order.',
    `delivery_block` BOOLEAN COMMENT 'Flag indicating whether delivery of the order is blocked.',
    `distribution_channel` STRING COMMENT 'Channel through which the order is distributed (e.g., wholesale, retail).',
    `division` STRING COMMENT 'Business division handling the order.',
    `freight_terms` STRING COMMENT 'Terms governing freight cost responsibility (e.g., prepaid, collect).',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the order including packaging, measured in kilograms.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — promote to reference product]',
    `internal_comments` STRING COMMENT 'Internal notes visible only to company personnel.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Total net weight of all items in the order, measured in kilograms.',
    `order_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the order amounts.',
    `order_number` STRING COMMENT 'External business identifier for the order as used in customer communications.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer placed the order.',
    `order_priority` STRING COMMENT 'Priority level assigned to the order for processing.. Valid values are `low|medium|high|urgent`',
    `order_reason` STRING COMMENT 'Free‑text description of why the order was created (e.g., new project, replacement).',
    `order_status` STRING COMMENT 'Current lifecycle state of the order. [ENUM-REF-CANDIDATE: created|released|partially_delivered|completed|cancelled|closed|on_hold — promote to reference product]',
    `order_text` STRING COMMENT 'Long free‑text field for additional order instructions or remarks.',
    `order_type` STRING COMMENT 'Classification of the order based on fulfillment rules.. Valid values are `standard|rush|blanket|consignment`',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due (e.g., NET30).',
    `price_group` STRING COMMENT 'Group determining price level for the customer.',
    `price_list` STRING COMMENT 'Price list identifier used for pricing the order.',
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
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'Core master record for customer purchase orders representing the full order commitment in the order-to-cash lifecycle. Captures customer reference, order type (standard, rush, blanket, consignment), requested delivery date, incoterms, payment terms, pricing date, total net value, currency, sales organization, distribution channel, division, and overall order status. Serves as the SSOT for all customer order commitments in the industrial manufacturing order lifecycle, driving downstream delivery, billing, and revenue recognition.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique surrogate key for each order line record.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Make-to-order and configure-to-order manufacturing requires linking the sales order line to the product BOM header to trigger MRP explosion, production order creation, and cost estimation. Manufacturi',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Enables Production Planning to pull the exact BOM version for the ordered product, essential for material requirement planning (MRP) reports.',
    `capacity_plan_id` BIGINT COMMENT 'Foreign key linking to supply.capacity_plan. Business justification: Cost allocation report maps each order line to a WBS element of the project for budgeting and earned‑value analysis.',
    `catalog_entry_id` BIGINT COMMENT 'Foreign key linking to product.catalog_entry. Business justification: Manufacturing order lines are placed against catalog entries that define orderable status, list price, lead time, and configurability. Linking order line to catalog_entry supports catalog-based order ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Order fulfillment requires linking each order line to the material master for inventory reservation, costing, and MRP planning; this is standard in manufacturing ERP systems.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Order lines in configure-to-order and engineer-to-order manufacturing must specify the engineering revision being ordered. This drives correct BOM explosion, production routing selection, and customer',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for Order Fulfillment & Costing report linking each order line to the master product record for pricing, compliance, and warranty tracking.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Picking process assigns a specific storage location to each order line to locate inventory in the warehouse; the link enables pick list generation and inventory accuracy.',
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
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit before taxes and discounts.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the product itself without packaging (kilograms).',
    `plant` STRING COMMENT 'SAP plant code where the product is stocked or produced for this order line.',
    `pricing_condition` STRING COMMENT 'Pricing condition type governing the price calculation.. Valid values are `standard|discount|rebate|surcharge`',
    `product_description` STRING COMMENT 'Human‑readable description of the product or service on the line.',
    `promised_date` DATE COMMENT 'Date promised to the customer for delivery.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing quality assessment (0‑100).',
    `quality_status` STRING COMMENT 'Result of quality inspection for the line item.. Valid values are `passed|failed|pending`',
    `rejection_reason` STRING COMMENT 'Reason provided when the line is rejected or cancelled.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the order line record.',
    `volume` DECIMAL(18,2) COMMENT 'Physical volume of the line item (cubic meters).',
    `volume_uom` STRING COMMENT 'Unit of measure for volume.. Valid values are `M3|L|FT3`',
    `weight_uom` STRING COMMENT 'Unit of measure for weight fields.. Valid values are `KG|LB|TON`',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual line item within a customer sales order representing a discrete product, automation system, or service being ordered. Captures material number, ordered and confirmed quantities, unit of measure, schedule line dates, net price, pricing conditions, plant assignment, storage location, delivery status, rejection reason, and blanket order release reference. Serves as the demand signal for MRP and production scheduling. May reference a parent blanket order for scheduling agreement releases.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` (
    `schedule_line_id` BIGINT COMMENT 'System-generated unique identifier for the schedule line record.',
    `order_line_id` BIGINT COMMENT 'Reference to the original schedule line when this line is a split part.',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or material being scheduled for delivery.',
    `backorder_indicator` BOOLEAN COMMENT 'True if the schedule line is backordered due to insufficient stock.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the produced material.',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the system for delivery after scheduling.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the system after ATP check and production planning.',
    `confirmed_quantity_uom` STRING COMMENT 'Unit of measure for the confirmed quantity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the line amount.',
    `goods_issue_date` DATE COMMENT 'Date on which the goods were posted to inventory for shipment.',
    `handling_unit` STRING COMMENT 'Identifier of the handling unit (e.g., pallet, container) used for the shipment.',
    `incoterms` STRING COMMENT 'International commercial terms governing delivery responsibilities.. Valid values are `EXW|FCA|FOB|CFR|CIF|DDP`',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of the confirmed quantity before taxes.',
    `mrp_confirmed_availability_date` DATE COMMENT 'Date when material availability was confirmed by MRP.',
    `plant` STRING COMMENT 'Manufacturing plant responsible for producing the scheduled quantity.',
    `priority_code` STRING COMMENT 'Priority of the schedule line for production and delivery planning.. Valid values are `high|medium|low`',
    `requested_delivery_date` DATE COMMENT 'Date the customer originally requested for delivery.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity originally requested by the customer for this schedule line.',
    `requested_quantity_uom` STRING COMMENT 'Unit of measure for the requested quantity (e.g., PCS, KG, M3).',
    `route` STRING COMMENT 'Planned transportation route for the delivery.',
    `schedule_line_number` STRING COMMENT 'Sequential number of the schedule line within the order line item.',
    `schedule_line_status` STRING COMMENT 'Current processing status of the schedule line.. Valid values are `confirmed|released|blocked|canceled|pending`',
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
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Delivery-to-address confirmation, proof-of-delivery reporting, and logistics compliance in manufacturing require a formal FK to the validated customer address record. Denormalized address columns on d',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Link delivery to its originating order header; enables traceability and removes redundant order number fields.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who placed the original sales order.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Outbound deliveries are fulfilled from a specific warehouse. Linking delivery.warehouse_id → inventory.warehouse supports warehouse throughput reporting, outbound capacity planning, and shipping SLA a',
    `actual_delivery_date` DATE COMMENT 'Date the delivery was actually received by the customer.',
    `actual_goods_issue_timestamp` TIMESTAMP COMMENT 'Timestamp when goods were actually issued from the warehouse.',
    `carrier_code` STRING COMMENT 'Code of the logistics carrier responsible for transportation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
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
    `priority` STRING COMMENT 'Priority level assigned to the delivery for scheduling purposes.. Valid values are `low|medium|high`',
    `shipping_condition` STRING COMMENT 'Incoterm defining responsibility and cost allocation between seller and buyer.. Valid values are `EXW|FOB|CIF|DDP`',
    `shipping_point` STRING COMMENT 'Plant or warehouse location code where the delivery originates.',
    `special_equipment_required` BOOLEAN COMMENT 'Indicates if special equipment (e.g., liftgate) is needed for delivery.',
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
    `delivery_id` BIGINT COMMENT 'Identifier of the parent outbound delivery document to which this line belongs.',
    `inspection_result_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_result. Business justification: delivery_item carries quality_inspection_status and inspection_result as plain denormalized columns sourced from quality.inspection_result. Direct FK enables item-level quality traceability for custom',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Product traceability and recall management require knowing exactly which lot/batch was shipped on each delivery item. delivery_item.batch_number is the denormalized signal. Manufacturing compliance (I',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Associate each delivery item with the order line it fulfills, providing clear lineage.',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: Service parts fulfillment at item level: individual delivery items can fulfill spare parts ordered in response to a service request. Linking delivery_item to the originating service request enables it',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Each delivered item must be traceable to the engineering revision manufactured and shipped — mandatory for CE marking, RoHS/REACH compliance, warranty claims, and field service. Regulatory audits in a',
    `schedule_line_id` BIGINT COMMENT 'Foreign key linking to order.schedule_line. Business justification: In SAP SD, outbound delivery items are created directly from sales order schedule lines — the schedule line is the confirmed delivery commitment that drives delivery creation. delivery_item already ha',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Enables Delivery Traceability and Warranty Claim process by tying each delivered item to its master product record.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Delivery execution tracks the source stock location of shipped items for traceability and logistics reporting.',
    `actual_goods_issue_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods issue for this line was posted.',
    `carrier_code` STRING COMMENT 'Identifier of the carrier responsible for transportation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery line record was first created in the system.',
    `delivery_date` DATE COMMENT 'Planned date for the delivery of this line item.',
    `goods_movement_status` STRING COMMENT 'Status of the goods issue transaction for this line.. Valid values are `not_issued|issued|reversed`',
    `handling_unit_number` STRING COMMENT 'Identifier of the handling unit (pallet, crate) containing the material.',
    `inventory_management_indicator` STRING COMMENT 'Flag indicating whether the line is subject to inventory management.. Valid values are `X|`',
    `item_category` STRING COMMENT 'Category defining the business purpose of the line (e.g., standard sale, return, consignment).. Valid values are `standard|return|consignment`',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `movement_reason` STRING COMMENT 'Reason code for the goods movement, if applicable.',
    `movement_type` STRING COMMENT 'SAP movement type code that defines the kind of goods movement.',
    `pallet_number` STRING COMMENT 'Identifier of the pallet on which the line item is loaded.',
    `picking_status` STRING COMMENT 'Current status of the picking process for this line.. Valid values are `not_picked|partially_picked|picked|blocked`',
    `plant` STRING COMMENT 'Plant where the material is stocked for this delivery.',
    `promised_delivery_date` DATE COMMENT 'Customer‑promised delivery date agreed in the sales order.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`rma` (
    `rma_id` BIGINT COMMENT 'Unique system-generated identifier for the RMA record.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: RMA authorization, inspection scheduling, and credit memo communication in manufacturing require a named customer contact. Role-prefix rma_ distinguishes from the order-level contact. No customer_co',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who initiated the return.',
    `customer_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.customer_complaint. Business justification: RMAs are created as resolution actions for customer complaints in manufacturing. Direct FK enables complaint-to-RMA resolution tracking, complaint closure verification, and customer satisfaction repor',
    `field_service_order_id` BIGINT COMMENT 'Foreign key linking to service.field_service_order. Business justification: Field service-driven parts return: when a field engineer determines a part must be returned during a service visit, the RMA is initiated from the field service order. Linking order_rma to field_servic',
    `header_id` BIGINT COMMENT 'Identifier of the original sales order linked to this RMA.',
    `material_master_id` BIGINT COMMENT 'Identifier of the product to be sent as a replacement, if applicable.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: RMAs are created as direct resolution actions for NCRs in manufacturing quality-return processes. Linking order_rma to the triggering NCR enables complaint-to-return traceability, disposition tracking',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: A Return Material Authorization in manufacturing is raised against a specific order line item (the particular product/SKU being returned), not just the order header. order_rma already has order_header',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: RMA processing in manufacturing requires a validated return-shipment address for routing replacement goods and scheduling return pickups. Role-prefix return_ distinguishes this from the original shi',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: RMA processing requires identifying the engineering revision of the returned product to determine warranty applicability, root cause analysis scope, and whether a design change caused the field failur',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: RMA processing, warranty claim validation, credit memo generation, and replacement fulfillment all require the exact SKU being returned. Without this FK, RMA inspection, restocking decisions, and warr',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Returned goods must be directed to a specific stock location (quarantine, returns, or serviceable stock). Linking order_rma.stock_location_id → inventory.stock_location enables returns putaway process',
    `warranty_id` BIGINT COMMENT 'Foreign key linking to service.service_warranty. Business justification: Warranty entitlement validation for returns: order_rma has is_warranty_claim flag. Linking to the specific service_warranty record enables warranty coverage verification during RMA approval, credit am',
    `actual_return_date` DATE COMMENT 'Date the returned items were actually received.',
    `approval_status` STRING COMMENT 'Current approval state of the RMA.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the RMA was approved.',
    `authorized_quantity` STRING COMMENT 'Quantity of items the system authorizes for return based on the original order.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier handling the return shipment.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Total credit to be applied to the customers account.',
    `credit_memo_indicator` BOOLEAN COMMENT 'Flag indicating whether a credit memo will be issued for this RMA.',
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
    `return_plant` STRING COMMENT 'Plant or warehouse code where the returned items are to be received.',
    `return_reason_code` STRING COMMENT 'Standardized code representing why the product is being returned.. Valid values are `defect|damage|wrong_item|warranty|other`',
    `return_reason_description` STRING COMMENT 'Free-text description providing details about the return reason.',
    `returned_quantity` STRING COMMENT 'Actual number of units received back from the customer.',
    `rma_number` STRING COMMENT 'Business-visible RMA number assigned by the order management system.',
    `rma_type` STRING COMMENT 'Classification of the RMA (e.g., warranty, non‑warranty, repair, replacement).. Valid values are `warranty|non_warranty|repair|replace`',
    `shipping_method` STRING COMMENT 'Method used to ship the returned product back to the plant.. Valid values are `ground|air|sea|pickup`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the refund or credit.',
    `tracking_number` STRING COMMENT 'Tracking identifier provided by the carrier for the return shipment.',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'Return Material Authorization record managing the end-to-end return process for defective, damaged, or incorrectly shipped industrial products and automation systems. Captures RMA number, originating sales order reference, return reason code (quality defect, shipping damage, wrong item, warranty claim), authorized return quantity, return plant, credit memo indicator, inspection requirement flag, and RMA status. Integrates with returns processing workflows and quality non-conformance reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` (
    `goods_issue_id` BIGINT COMMENT 'Primary key for goods_issue',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer receiving the goods.',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: In SAP SD manufacturing, a goods issue posting is always triggered by an outbound delivery document. goods_issue.delivery_doc_number is a denormalized STRING reference to the delivery header. Adding d',
    `field_service_order_id` BIGINT COMMENT 'Foreign key linking to service.field_service_order. Business justification: Service order inventory cost posting: in manufacturing ERP, goods issues are posted when parts are issued for field service orders. Linking goods_issue to field_service_order enables inventory cost al',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Link goods issue to the order header for end‑to‑end tracking, removing redundant sales order number.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Goods issue posting in manufacturing is gated by inspection lot disposition (usage decision). goods_issue.quality_status is denormalized from inspection_lot disposition. Direct FK enables automated qu',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Every goods issue must reference the material master for inventory valuation, movement type determination, and GL account posting. goods_issue.material_number is the denormalized signal; a proper FK e',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Goods issue records the physical inventory movement for shipment. In regulated manufacturing (medical devices, aerospace, automotive), the goods issue must reference the engineering revision of the is',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Earned‑value reporting requires linking material issues to WBS elements to calculate actual cost versus planned value.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Goods issue transaction records the originating stock location, essential for inventory decrement, audit trails, and compliance reporting.',
    `actual_delivery_date` DATE COMMENT 'Date when the goods were actually delivered to the customer.',
    `cost_center` STRING COMMENT 'Cost center responsible for the goods issue cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `delivery_date` DATE COMMENT 'Planned date for delivery to the customer.',
    `expected_delivery_date` DATE COMMENT 'System‑calculated expected delivery date based on lead times.',
    `external_reference` STRING COMMENT 'Reference to external system such as carrier tracking number.',
    `goods_issue_status` STRING COMMENT 'Current lifecycle status of the goods issue.. Valid values are `posted|reversed|pending|cancelled`',
    `handling_unit` STRING COMMENT 'Identifier of the handling unit (e.g., pallet) used for the issue.',
    `incoterms` STRING COMMENT 'International commercial terms governing delivery responsibilities.. Valid values are `EXW|FCA|CPT|CIP|DAP|DDP`',
    `inventory_account` STRING COMMENT 'General ledger account for inventory posting.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the goods issue was generated automatically by a system.',
    `issue_number` STRING COMMENT 'External document number assigned to the goods issue.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the goods issue.. Valid values are `101|102|201|202`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary amount after tax.',
    `plant` STRING COMMENT 'Plant where the goods issue originated.',
    `posting_reason` STRING COMMENT 'Reason for the goods issue posting.. Valid values are `normal|return|scrap|transfer`',
    `posting_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods issue was posted in the source system.',
    `profit_center` STRING COMMENT 'Profit center associated with the revenue from this issue.',
    `purchase_order_number` STRING COMMENT 'Purchase order associated with the material movement, if applicable.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` (
    `pricing_condition_id` BIGINT COMMENT 'System-generated unique identifier for the pricing condition record.',
    `order_line_id` BIGINT COMMENT 'Identifier of the sales order line to which this pricing condition applies.',
    `price_book_entry_id` BIGINT COMMENT 'Foreign key linking to sales.price_book_entry. Business justification: Pricing audit trails and margin analysis require tracing each order pricing condition back to its originating price book entry (list price, discount tier, minimum price). Manufacturing finance teams v',
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
    `condition_rate_unit` STRING COMMENT 'Unit for the condition rate, such as "%" or "per_unit".',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`schedule_line`(`schedule_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`order_line`(`order_line_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `billing_block` SET TAGS ('dbx_business_glossary_term' = 'Billing Block');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'unblocked|blocked|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `currency_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `customer_account_group` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Group');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `customer_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `delivery_block` SET TAGS ('dbx_business_glossary_term' = 'Delivery Block');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `internal_comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_currency` SET TAGS ('dbx_business_glossary_term' = 'Order Currency');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Reason');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_text` SET TAGS ('dbx_business_glossary_term' = 'Order Text');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|blanket|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `price_group` SET TAGS ('dbx_business_glossary_term' = 'Price Group');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `price_list` SET TAGS ('dbx_business_glossary_term' = 'Price List');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `sales_document_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `sales_group` SET TAGS ('dbx_business_glossary_term' = 'Sales Group');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'standard|express|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `transportation_group` SET TAGS ('dbx_business_glossary_term' = 'Transportation Group');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `backorder_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `blanket_release_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Release Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|shipped|delivered|cancelled|backordered');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `gross_price` SET TAGS ('dbx_business_glossary_term' = 'Gross Price');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_value_regex' = 'standard|discount|rebate|surcharge');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `promised_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `rma_reference` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization Reference');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `sales_org` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `sales_price` SET TAGS ('dbx_business_glossary_term' = 'Sales Price');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `sales_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sales Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `schedule_line_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PCS|TON');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'M3|L|FT3');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`order_line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'KG|LB|TON');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Schedule Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Split Parent Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ADD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `actual_goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Goods Issue Timestamp (AGIT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code (CC)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority (DP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition (SC)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point (SP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `special_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Required Flag (SERF)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Identifier (DDID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `actual_goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Goods Issue Timestamp (ACT_GI_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code (CARR)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TSTMP)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (PLND_DEL)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Status (GM_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_value_regex' = 'not_issued|issued|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `handling_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Number (HU)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Return Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Return Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `credit_memo_indicator` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `handling_fee` SET TAGS ('dbx_business_glossary_term' = 'Handling Fee Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `is_damaged` SET TAGS ('dbx_business_glossary_term' = 'Damaged Item Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `is_repairable` SET TAGS ('dbx_business_glossary_term' = 'Repairable Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `is_warranty_claim` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `is_wrong_item` SET TAGS ('dbx_business_glossary_term' = 'Wrong Item Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RMA Notes');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `order_rma_status` SET TAGS ('dbx_business_glossary_term' = 'RMA Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `order_rma_status` SET TAGS ('dbx_value_regex' = 'open|approved|rejected|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `replacement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replacement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RMA Request Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `return_plant` SET TAGS ('dbx_business_glossary_term' = 'Return Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defect|damage|wrong_item|warranty|other');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `rma_type` SET TAGS ('dbx_business_glossary_term' = 'RMA Type');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `rma_type` SET TAGS ('dbx_value_regex' = 'warranty|non_warranty|repair|replace');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|sea|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACTUAL_DELIVERY_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (DELIVERY_DATE)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type (MOV_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '101|102|201|202');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount After Tax (NET_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `posting_reason` SET TAGS ('dbx_business_glossary_term' = 'Posting Reason (POST_REASON)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `posting_reason` SET TAGS ('dbx_value_regex' = 'normal|return|scrap|transfer');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Posting Timestamp (GI_POST_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code (PROFIT_CENTER)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NO)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `pricing_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Order Pricing Condition Identifier (OPC_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (OL_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Id (Foreign Key)');
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
