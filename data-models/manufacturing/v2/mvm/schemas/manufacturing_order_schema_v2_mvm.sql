-- Schema for Domain: order | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-03 07:50:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`order` COMMENT 'Order management and fulfillment domain governing the end-to-end order lifecycle from customer purchase orders through production scheduling, shipment, and delivery confirmation. Manages order headers, line items, delivery schedules, RMAs, fulfillment SLAs, and customer order lifecycle via SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`header` (
    `header_id` BIGINT COMMENT 'System-generated unique identifier for the sales order header.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Order processing uses a sold‑to contact for invoicing and communication; this contact is stored in customer.contact.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the order.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Revenue attribution: linking orders to the originating sales opportunity enables pipeline‑to‑revenue reporting and commission calculations.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Commission & accountability: each order is credited to the responsible sales rep, supporting commission payout and performance metrics.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Shipping logistics require a reference to the customers shipping address; address data resides in customer.address.',
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
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'Core master record for customer purchase orders representing the full order commitment in the order-to-cash lifecycle. Captures customer reference, order type (standard, rush, blanket, consignment), requested delivery date, incoterms, payment terms, pricing date, total net value, currency, sales organization, distribution channel, division, and overall order status. Serves as the SSOT for all customer order commitments in the industrial manufacturing order lifecycle, driving downstream delivery, billing, and revenue recognition.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`line` (
    `line_id` BIGINT COMMENT 'Unique surrogate key for each order line record.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Enables Production Planning to pull the exact BOM version for the ordered product, essential for material requirement planning (MRP) reports.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Order fulfillment requires linking each order line to the material master for inventory reservation, costing, and MRP planning; this is standard in manufacturing ERP systems.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Audit trail: order line must reference the originating quote line to validate pricing, configuration, and warranty obligations.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Order lines must specify exact engineering revision for configuration control, traceability, and as-built documentation. Regulatory requirement in aerospace/automotive/medical device manufacturing. En',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: Serialized items need direct linkage between order line and specific serialized unit to support warranty, service, and traceability.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for Order Fulfillment & Costing report linking each order line to the master product record for pricing, compliance, and warranty tracking.',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to asset.spare_part. Business justification: Needed for Spare Part Sales process to tie sold line items to the spare‑part master for warranty and inventory tracking.',
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
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: In SAP SD order fulfillment, schedule lines are the confirmed delivery commitments that drive outbound delivery creation. Adding delivery_id to schedule_line establishes the traceability link between ',
    `header_id` BIGINT COMMENT 'Identifier of the parent sales order header to which this schedule line belongs.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: ATP lot confirmation: schedule_line.lot_number/batch_number are denormalized. FK to lot_batch enables ATP (Available-to-Promise) confirmation tracking, showing which specific inventory lot is committe',
    `line_id` BIGINT COMMENT 'Reference to the original schedule line when this line is a split part.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: In make-to-order and drop-ship manufacturing scenarios, sales order schedule lines are directly fulfilled by external procurement purchase orders. This link enables end-to-end traceability from custom',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or material being scheduled for delivery.',
    `source_line_id` BIGINT COMMENT '',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Production scheduling allocates order schedule lines to exact stock locations for material staging; linking supports real-time allocation and capacity planning.',
    `backorder_indicator` BOOLEAN COMMENT 'True if the schedule line is backordered due to insufficient stock.',
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
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who placed the original sales order.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Delivery execution requires tracking the on-site receiving contact for delivery window scheduling, dock coordination, receiving confirmation signature, and immediate issue escalation. Manufacturing lo',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Warehouse fulfillment tracking: delivery.ship_from_location is denormalized. FK to warehouse enables warehouse-level delivery performance reporting, outbound capacity planning, carrier assignment by f',
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
    `delivery_id` BIGINT COMMENT 'Identifier of the parent outbound delivery document to which this line belongs.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Associate each delivery item with the order line it fulfills, providing clear lineage.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Delivery lot traceability: delivery_item.batch_number is denormalized. FK to lot_batch enables forward/backward traceability from customer delivery to production batch — mandatory for quality recalls,',
    `schedule_line_id` BIGINT COMMENT 'Foreign key linking to order.schedule_line. Business justification: In SAP SD, each outbound delivery item is created from a specific sales order schedule line — the schedule line is the granular delivery commitment (confirmed quantity, confirmed date) that the delive',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Enables Delivery Traceability and Warranty Claim process by tying each delivered item to its master product record.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Delivery execution tracks the source stock location of shipped items for traceability and logistics reporting.',
    `actual_goods_issue_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods issue for this line was posted.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`rma` (
    `rma_id` BIGINT COMMENT 'Unique system-generated identifier for the RMA record.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: RMA authorization and return coordination require tracking the specific customer contact who initiated the return request, approved the RMA, and coordinates shipping logistics. Manufacturing RMA workf',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who initiated the return.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: RMAs trigger engineering change orders when returns reveal design defects or field failures. Critical for closed-loop corrective action, root cause analysis linking returns to design changes, and syst',
    `material_master_id` BIGINT COMMENT 'Identifier of the product to be sent as a replacement, if applicable.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Returns receiving location: RMA processing designates a specific stock location (quarantine bin, returns area) for physical receipt of returned goods. Role-prefix return_ distinguishes this from oth',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: Serialized RMA tracking: returned serialized goods must reference their serialized_unit record for warranty validation, repair history, and asset lifecycle management. Enables warranty claim verificat',
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
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'Return Material Authorization record managing the end-to-end return process for defective, damaged, or incorrectly shipped industrial products and automation systems. Captures RMA number, originating sales order reference, return reason code (quality defect, shipping damage, wrong item, warranty claim), authorized return quantity, return plant, credit memo indicator, inspection requirement flag, and RMA status. Integrates with returns processing workflows and quality non-conformance reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`rma_line` (
    `rma_line_id` BIGINT COMMENT 'System-generated unique identifier for the RMA line item.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Links returned items to the original engineered component for warranty claim evaluation and root‑cause analysis.',
    `delivery_id` BIGINT COMMENT 'Identifier of the delivery that originally supplied the returned material.',
    `header_id` BIGINT COMMENT 'Sales order identifier for the replacement item shipped to the customer.',
    `line_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Returned item batch traceability: rma_line.batch_number is denormalized. FK to lot_batch enables quality disposition decisions, product recall management, and inventory reintegration of returned goods',
    `production_work_order_id` BIGINT COMMENT 'Identifier of the work order created for reworking the returned item.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Restock location assignment: rma_line disposition assigns returned goods to a specific stock_location. Role-prefix restock_ distinguishes from other location references. Normalizes restock_location/',
    `rma_id` BIGINT COMMENT 'Identifier of the parent RMA document to which this line belongs.',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: Serialized returns line traceability: rma_line.serial_number is denormalized. FK to serialized_unit enables complete lifecycle tracking of returned serialized items for warranty processing, repair rou',
    `sku_master_id` BIGINT COMMENT '',
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
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity (e.g., EA, KG, L).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the RMA line record.',
    `warranty_claim_flag` BOOLEAN COMMENT 'True if the return is covered under a warranty claim.',
    `warranty_claim_number` STRING COMMENT 'Identifier of the warranty claim associated with this return.',
    CONSTRAINT pk_rma_line PRIMARY KEY(`rma_line_id`)
) COMMENT 'Individual line item within an RMA document specifying the material, quantity, and disposition instructions for each returned product. Captures RMA line number, material number, returned quantity, original delivery reference, serial numbers, batch number, condition code, disposition action (scrap, rework, restock, replace), and credit value. Supports quality inspection routing and inventory reintegration decisions.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` (
    `fulfillment_sla_id` BIGINT COMMENT 'Unique surrogate key for the SLA record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer to which this SLA applies; null if SLA is not customer‑specific.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Tie SLA directly to the order it governs, removing duplicate order number.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: SLA breach detection and penalty calculation require direct reference to contract-level service commitments (sla_response_time_hours, sla_uptime_percentage, penalty_clause). Manufacturing fulfillment ',
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
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Link goods issue to the order header for end‑to‑end tracking, removing redundant sales order number.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Goods issue lot tracking: goods_issue.batch_number is denormalized. FK to lot_batch enables lot-level cost accounting, inventory posting accuracy, and traceability of which production batch was consum',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Goods issue material normalization: goods_issue.material_number is denormalized. FK to material_master enables proper material-level reporting on goods issues, cost center allocations, valuation, and ',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: Serialized goods issue: goods_issue.serial_number is denormalized. FK to serialized_unit enables precise tracking of which serialized unit was issued to a customer, recording warranty start dates and ',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Goods issue transaction records the originating stock location, essential for inventory decrement, audit trails, and compliance reporting.',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: Goods issue to inventory posting reconciliation: a goods issue document triggers a material document (stock_movement) in ERP. This FK enables financial reconciliation, inventory accuracy audits, and g',
    `actual_delivery_date` DATE COMMENT 'Date when the goods were actually delivered to the customer.',
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
    `line_id` BIGINT COMMENT 'Identifier of the sales order line to which this pricing condition applies.',
    `price_book_entry_id` BIGINT COMMENT 'Foreign key linking to sales.price_book_entry. Business justification: Specific pricing conditions (discounts, surcharges, tax rates) must trace to exact price book entry that authorized the rate for audit trail and margin analysis. Manufacturing pricing variance reports',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: Order pricing audit and variance analysis require tracing applied conditions to the authoritative price book that governed discount policies, approval thresholds, and pricing strategy at order creatio',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_source_line_id` FOREIGN KEY (`source_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`schedule_line`(`schedule_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ADD CONSTRAINT `fk_order_fulfillment_sla_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ADD CONSTRAINT `fk_order_pricing_condition_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `billing_block` SET TAGS ('dbx_business_glossary_term' = 'Billing Block');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Split Parent Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ALTER COLUMN `backorder_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Identifier (DDID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` SET TAGS ('dbx_subdomain' = 'return_processing');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_ssot_master' = 'service.service_rma');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Return Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Return Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` SET TAGS ('dbx_subdomain' = 'return_processing');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Original Delivery ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rework Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Restock Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) ID');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `fulfillment_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`fulfillment_sla` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACTUAL_DELIVERY_DATE)');
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
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (OL_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`order`.`pricing_condition` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
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
