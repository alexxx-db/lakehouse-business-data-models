-- Schema for Domain: logistics | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-03 07:50:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`logistics` COMMENT 'Inbound and outbound logistics domain managing shipment planning, carrier selection, LTL/FTL routing, freight cost, customs documentation, TMS execution, delivery tracking, route optimization, and distribution network management. Coordinates material flow from suppliers to plants and finished goods from plants to customers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: Associate each shipment with the carrier contract that governs rates and terms.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Link shipment to carrier for authoritative carrier data; carrier_scac_code and carrier_name become redundant.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Required for outbound shipping confirmation and customer billing report linking each shipment to the billed customer.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Shipment execution is driven by a sales order; linking enables order fulfillment tracking and status reporting.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: On-time delivery KPI reporting and customer commitment fulfillment tracking require linking each shipment to the originating sales order intake. Manufacturing operations teams monitor delivery perform',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Outbound shipment origin tracking: shipments originate from a specific warehouse/plant. Required for dock scheduling, warehouse outbound capacity planning, freight cost allocation by warehouse, and ca',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Supply execution tracking: planners must confirm which shipments fulfill which MRP planned orders to close the loop on supply plan execution, manage exceptions, and report on planned-vs-actual fulfill',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for shipment manifest and product traceability; enables recall, compliance, and cost allocation reports linking each shipment to the shipped SKU.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Shipment creation is driven by an approved supply plan; linking enables the Supply Plan to Shipment execution traceability report.',
    `transport_route_id` BIGINT COMMENT 'Foreign key linking to logistics.transport_route. Business justification: A shipment travels on a defined transport route (lane). freight_order already has transport_route_id → transport_route, but shipment itself lacks this direct link. Adding transport_route_id to shipmen',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment was delivered to the destination location.',
    `actual_pickup_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier picked up the shipment from the origin location.',
    `bol_number` STRING COMMENT 'Bill of Lading number serving as the legal document and receipt for the shipment. Issued by the carrier.',
    `commercial_invoice_number` STRING COMMENT 'Invoice number associated with the shipment for customs and billing purposes.',
    `consolidation_group_code` STRING COMMENT 'Identifier for the consolidation group used in load planning. Multiple shipments with the same consolidation group may be combined into a single load.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `customs_declaration_number` DECIMAL(18,2) COMMENT 'Reference number for the customs declaration document required for cross-border shipments. Used for import/export compliance.',
    `destination_address_line1` STRING COMMENT 'First line of the street address for the destination location.',
    `destination_city` STRING COMMENT 'City name of the destination location.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the destination location (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code of the destination location.',
    `destination_state_province` STRING COMMENT 'State or province of the destination location.',
    `direction` STRING COMMENT 'Indicates whether the shipment is inbound (supplier to plant) or outbound (plant to customer or distribution center).. Valid values are `inbound|outbound`',
    `freight_class` DECIMAL(18,2) COMMENT 'Freight class assigned to the shipment based on density, stowability, handling, and liability. Used for LTL pricing. Valid classes range from 50 to 500.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost for the shipment in the specified currency. Includes base transportation charges but may exclude accessorial fees.',
    `freight_cost_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the freight cost amount (e.g., USD, EUR, CNY).',
    `hazmat_class` STRING COMMENT 'UN hazard class for hazardous materials in the shipment (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Populated only if hazmat_flag is true.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling, documentation, and compliance with safety regulations.',
    `incoterm_code` STRING COMMENT 'INCOTERMS code defining the responsibilities, costs, and risks between buyer and seller for international shipments (e.g., EXW, FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_value_amount` DECIMAL(18,2) COMMENT 'Declared value of the shipment for insurance purposes. Used to determine coverage limits and premiums.',
    `insurance_value_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the insurance value amount.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was last updated in the system.',
    `pro_number` STRING COMMENT 'Progressive number assigned by the carrier to track the shipment. Used for LTL and FTL shipments.',
    `scheduled_delivery_date` DATE COMMENT 'Planned date when the shipment is scheduled to be delivered to the destination location.',
    `scheduled_pickup_date` DATE COMMENT 'Planned date when the carrier is scheduled to pick up the shipment from the origin location.',
    `service_level` STRING COMMENT 'Contracted service level for the shipment indicating speed and priority: standard, expedited, priority, or same-day delivery.. Valid values are `standard|expedited|priority|same_day`',
    `shipment_number` STRING COMMENT 'Externally-known business identifier for the shipment, used across systems and by carriers. Typically follows format SHP followed by 10 digits.. Valid values are `^SHP[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment: planned (not yet tendered), tendered (assigned to carrier), in-transit (en route), delivered (completed), exception (issue occurred), cancelled (voided).. Valid values are `planned|tendered|in_transit|delivered|exception|cancelled`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the shipment requires temperature-controlled transportation (refrigerated or heated).',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in Celsius for temperature-controlled shipments. Populated only if temperature_controlled_flag is true.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in Celsius for temperature-controlled shipments. Populated only if temperature_controlled_flag is true.',
    `tms_reference_number` STRING COMMENT 'Reference number assigned by the Transportation Management System for internal tracking and integration.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters, used for capacity planning and freight calculation.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including packaging and pallets.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for the shipment: LTL (Less Than Truckload), FTL (Full Truckload), parcel, rail, air, or ocean.. Valid values are `LTL|FTL|parcel|rail|air|ocean`',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous substance in the shipment. Populated only if hazmat_flag is true.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Core transactional entity representing an individual shipment of goods — inbound (supplier to plant) or outbound (plant to customer/DC). Tracks shipment number, direction (inbound/outbound), mode (LTL/FTL/parcel/rail/air/ocean), origin and destination locations, scheduled and actual departure/arrival dates, total weight, total volume, freight class, hazmat flag, shipment status (planned/tendered/in-transit/delivered/exception), TMS reference number, carrier SCAC code, PRO number, BOL number, service level (standard/expedited/priority), and consolidation group for load planning. Includes embedded multi-leg routing structure: leg sequence, leg origin/destination nodes, per-leg carrier assignment, per-leg transport mode, intermodal transfer points, leg distances (km/miles), per-leg scheduled/actual timestamps, leg status, per-leg freight costs, and cross-dock/transshipment/relay indicators. Serves as the central transactional entity and SSOT for all transport execution within the logistics domain, linking freight orders, tracking events, delivery documents, customs declarations, and carrier contracts.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'Unique identifier for the freight order. Primary key.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: A freight order is executed under a specific carrier contract that governs the applicable rates, service levels, and terms. While shipment already has carrier_contract_id → carrier_contract, the freig',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or freight forwarder assigned to execute this freight order.',
    `contract_release_order_id` BIGINT COMMENT 'Foreign key linking to procurement.contract_release_order. Business justification: In manufacturing, scheduling agreement releases (contract release orders) directly trigger freight orders for inbound material transport. This link enables freight cost allocation to specific release ',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Allows order management to associate each freight order with the originating customer for tracking and cost allocation.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight order is created to transport goods for a specific PO; needed for cost allocation and PO fulfillment tracking.',
    `transport_route_id` BIGINT COMMENT 'Reference to the planned transportation route for this freight order. Links to route optimization and network planning data.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Freight order pickup location: freight orders are executed from a specific warehouse (pickup point). Enables dock appointment scheduling, warehouse freight cost reporting, carrier performance by facil',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Total amount of accessorial charges applied to this freight order. Accessorials include additional services such as liftgate, inside delivery, residential delivery, detention, fuel surcharge, and other non-standard services.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier delivered the goods to the destination. Null until delivery is completed. Used for on-time performance measurement and SLA compliance tracking.',
    `actual_pickup_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier picked up the goods. Null until pickup is completed. Used for on-time performance measurement and SLA compliance tracking.',
    `bill_of_lading_number` STRING COMMENT 'Unique identifier for the Bill of Lading document associated with this freight order. The BOL serves as a receipt, contract of carriage, and document of title for the goods being transported.',
    `carrier_acceptance_status` STRING COMMENT 'Status of the carriers response to the freight order tender. Pending indicates awaiting response, Accepted means carrier confirmed, Rejected means carrier declined, Expired means tender window closed without response.. Valid values are `Pending|Accepted|Rejected|Expired`',
    `carrier_acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier accepted or rejected the freight order tender.',
    `created_by_user` STRING COMMENT 'User ID or name of the person or system that created this freight order record. Audit field for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this freight order record was first created in the system. Audit field for data lineage and compliance tracking.',
    `customs_required_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this freight order requires customs clearance documentation for cross-border shipment.',
    `delivery_window_end` TIMESTAMP COMMENT 'Latest date and time when the carrier must deliver the goods. Defines the end of the acceptable delivery time window and may be tied to Service Level Agreement (SLA) commitments.',
    `delivery_window_start` TIMESTAMP COMMENT 'Earliest date and time when the carrier may deliver the goods. Defines the beginning of the acceptable delivery time window.',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this freight order. Dry Van for standard enclosed trailer, Refrigerated for temperature-controlled, Flatbed for oversized or open cargo, Tanker for liquid bulk, Container for intermodal shipping, Box Truck for local delivery.. Valid values are `Dry Van|Refrigerated|Flatbed|Tanker|Container|Box Truck`',
    `freight_order_number` DECIMAL(18,2) COMMENT 'Business-facing unique identifier for the freight order, typically generated by the Transportation Management System (TMS) or SAP TM module. Used for external communication with carriers and internal tracking.',
    `freight_order_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the freight order. Draft indicates order is being prepared, Tendered means sent to carrier, Accepted means carrier confirmed, Rejected means carrier declined, In Transit means shipment is moving, Delivered means goods received, Cancelled means order voided, Closed means order completed and invoiced. [ENUM-REF-CANDIDATE: Draft|Tendered|Accepted|Rejected|In Transit|Delivered|Cancelled|Closed — 8 candidates stripped; promote to reference product]',
    `freight_rate_amount` DECIMAL(18,2) COMMENT 'Agreed base freight rate amount for transporting the goods, excluding accessorial charges and taxes. Represents the core transportation cost negotiated with the carrier.',
    `freight_rate_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the freight rate amount (e.g., USD, EUR, CNY).',
    `hazmat_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this freight order contains hazardous materials requiring special handling, documentation, and compliance with transportation safety regulations.',
    `incoterm_code` STRING COMMENT 'Three-letter Incoterms code defining the responsibilities, costs, and risks between buyer and seller for international shipments. Examples: EXW (Ex Works), FOB (Free On Board), CIF (Cost Insurance and Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `modified_by_user` STRING COMMENT 'User ID or name of the person or system that last modified this freight order record. Audit field for change accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this freight order record was last modified. Audit field for change tracking and data quality monitoring.',
    `package_count` STRING COMMENT 'Total number of individual packages or handling units included in this freight order.',
    `pallet_count` STRING COMMENT 'Number of pallets included in this freight order. Used for handling unit tracking and warehouse space planning.',
    `pickup_window_end` TIMESTAMP COMMENT 'Latest date and time when the carrier must pick up the goods. Defines the end of the acceptable pickup time window.',
    `pickup_window_start` TIMESTAMP COMMENT 'Earliest date and time when the carrier may pick up the goods. Defines the beginning of the acceptable pickup time window.',
    `priority_level` STRING COMMENT 'Priority classification for this freight order. Standard for normal service, Expedited for faster-than-normal, Rush for urgent same-day or next-day, Critical for emergency shipments requiring immediate attention.. Valid values are `Standard|Expedited|Rush|Critical`',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive Rotating Order number used to track the shipment through the carriers network. Commonly used in LTL freight for tracking and proof of delivery.',
    `sap_tm_freight_order_reference` DECIMAL(18,2) COMMENT 'Reference identifier from SAP Transportation Management (TM) module linking this freight order to the source system record. Used for traceability and reconciliation with the operational TMS.',
    `service_type` STRING COMMENT 'Type of freight service contracted for this order. LTL (Less Than Truckload) for partial loads, FTL (Full Truckload) for dedicated truck capacity, Intermodal for multi-mode transport, Parcel for small package, Air Freight for expedited air transport, Ocean Freight for maritime shipping.. Valid values are `LTL|FTL|Intermodal|Parcel|Air Freight|Ocean Freight`',
    `special_instructions` STRING COMMENT 'Free-text field containing special handling instructions, delivery requirements, or other important notes for the carrier. May include temperature requirements, fragile handling, appointment requirements, or site-specific access instructions.',
    `temperature_controlled_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this freight order requires temperature-controlled transportation (refrigerated or heated).',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments. Null if temperature control is not required.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments. Null if temperature control is not required.',
    `tender_method` STRING COMMENT 'Method by which the freight order was tendered to the carrier. Spot indicates one-time market rate, Contract indicates pre-negotiated agreement rate, Auction indicates competitive bidding process, Direct Award indicates sole-source assignment.. Valid values are `Spot|Contract|Auction|Direct Award`',
    `tender_timestamp` TIMESTAMP COMMENT 'Date and time when the freight order was tendered to the carrier. Represents the business event when the carrier was formally requested to provide transportation service.',
    `total_freight_cost` DECIMAL(18,2) COMMENT 'Total cost of the freight order including base freight rate, accessorial charges, and any applicable surcharges. Represents the complete contracted cost for this transportation service.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the freight shipment in cubic meters. Used for dimensional weight calculation and capacity planning.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the freight shipment in kilograms. Used for rate calculation, capacity planning, and compliance with weight restrictions.',
    CONSTRAINT pk_freight_order PRIMARY KEY(`freight_order_id`)
) COMMENT 'Operational freight order issued to a carrier or freight forwarder, representing the contractual instruction to move goods. Captures freight order number, linked shipment(s), carrier SCAC, service type (LTL/FTL/intermodal), pickup and delivery windows, agreed freight rate, accessorial charges, special instructions, tender method (spot/contract/auction), tender timestamp, carrier acceptance status, and SAP TM freight order reference.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` (
    `delivery_note_id` BIGINT COMMENT 'Unique identifier for the delivery note. Primary key for this entity.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: delivery_note.bill_of_lading_number is a denormalized STRING reference to the BOL document accompanying the delivery. Normalizing this to bill_of_lading_id → bill_of_lading.bill_of_lading_id enforces ',
    `carrier_id` BIGINT COMMENT 'Transportation carrier or logistics service provider handling the shipment.',
    `catalog_entry_id` BIGINT COMMENT 'Foreign key linking to product.catalog_entry. Business justification: Outbound delivery export compliance and customs documentation (harmonized_tariff_code, export_control_classification) are sourced from catalog_entry. Customs and trade compliance teams require this li',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Delivery Note must record the specific component being issued/received to reconcile inventory and support quality traceability.',
    `customer_account_id` BIGINT COMMENT 'Ship-to party for outbound deliveries. The customer receiving the goods.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to product.order_line. Business justification: Pick-pack-ship fulfillment process tracks which specific order lines are fulfilled by each delivery note. Order line delivery status updates (delivery_status, shipped_quantity) depend on this link. Cu',
    `plant_data_id` BIGINT COMMENT 'Manufacturing plant or distribution center handling the delivery. For inbound: receiving plant. For outbound: shipping plant.',
    `address_id` BIGINT COMMENT 'Destination address for outbound deliveries. Links to customer site or delivery location.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order for inbound deliveries. Links goods receipt to procurement.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Links delivery note to the delivered SKU for inventory reconciliation, warranty activation, and after‑sales service tracking.',
    `stock_location_id` BIGINT COMMENT 'Specific storage location within the plant for goods receipt or goods issue.',
    `warehouse_id` BIGINT COMMENT 'Warehouse facility executing the pick, pack, and ship operations for this delivery.',
    `actual_delivery_date` DATE COMMENT 'Actual date when goods were delivered to the destination or received at the plant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery note record was first created in the system.',
    `customs_declaration_number` DECIMAL(18,2) COMMENT 'Customs declaration or entry number for international shipments requiring customs clearance.',
    `delivery_direction` STRING COMMENT 'Discriminator indicating whether this is an inbound delivery (goods receipt from supplier) or outbound delivery (shipment to customer).. Valid values are `inbound|outbound`',
    `delivery_note_number` STRING COMMENT 'Externally-known business identifier for the delivery note. Used for tracking and reference across systems and with external parties.. Valid values are `^[A-Z0-9]{8,20}$`',
    `delivery_priority` STRING COMMENT 'Priority level assigned to the delivery for warehouse and transportation planning.. Valid values are `low|normal|high|urgent|critical`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery note in the warehouse and logistics execution workflow. [ENUM-REF-CANDIDATE: draft|planned|picking|packed|shipped|in_transit|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight or transportation cost for the delivery.',
    `freight_cost_currency` DECIMAL(18,2) COMMENT 'Currency code for freight cost amount. ISO 4217 three-letter currency code.',
    `goods_issue_date` DATE COMMENT 'Date when goods were physically issued from inventory for outbound deliveries. Triggers inventory reduction.',
    `goods_issue_status` STRING COMMENT 'Status of goods issue posting for outbound deliveries. Indicates whether inventory has been reduced.. Valid values are `pending|posted|reversed|blocked`',
    `goods_receipt_date` DATE COMMENT 'Date when goods were physically received into inventory for inbound deliveries. Triggers inventory increase.',
    `goods_receipt_status` STRING COMMENT 'Status of goods receipt posting for inbound deliveries. Indicates whether inventory has been increased.. Valid values are `pending|posted|reversed|blocked`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms code defining the responsibilities and risks between buyer and seller for transportation and delivery. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms agreement where risk transfers between parties.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery note record was last updated.',
    `loading_date` DATE COMMENT 'Date when goods were loaded onto the carrier vehicle for transportation.',
    `material_document_number` STRING COMMENT 'SAP material document number generated upon goods issue or goods receipt posting. Links delivery to inventory transaction.. Valid values are `^[0-9]{10}$`',
    `number_of_packages` STRING COMMENT 'Total count of packages, cartons, or handling units in the delivery.',
    `packing_date` DATE COMMENT 'Date when goods were packed and prepared for shipment.',
    `packing_status` STRING COMMENT 'Status of packing operations indicating readiness for shipment.. Valid values are `not_started|in_progress|completed|partially_packed`',
    `picking_date` DATE COMMENT 'Date when warehouse picking operations were completed for outbound deliveries.',
    `picking_status` STRING COMMENT 'Status of warehouse picking operations for outbound deliveries.. Valid values are `not_started|in_progress|completed|partially_picked`',
    `planned_delivery_date` DATE COMMENT 'Scheduled or promised delivery date communicated to the customer or expected from the supplier.',
    `proof_of_delivery_received` BOOLEAN COMMENT 'Indicates whether proof of delivery documentation has been received and confirmed.',
    `route_code` STRING COMMENT 'Predefined route identifier used for transportation planning and optimization.. Valid values are `^[A-Z0-9]{4,10}$`',
    `shipping_method` STRING COMMENT 'Mode of transportation used for the delivery.. Valid values are `air|ocean|rail|truck|courier|parcel`',
    `shipping_service_level` STRING COMMENT 'Service level or speed of delivery selected for the shipment.. Valid values are `standard|express|overnight|economy|premium`',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements such as fragile, hazardous, temperature-controlled, or security requirements.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of all goods including packaging, measured in kilograms.',
    `total_net_weight_kg` DECIMAL(18,2) COMMENT 'Total net weight of all goods in the delivery, measured in kilograms. Excludes packaging weight.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of all goods in the delivery, measured in cubic meters.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility and proof of delivery.. Valid values are `^[A-Z0-9]{10,30}$`',
    CONSTRAINT pk_delivery_note PRIMARY KEY(`delivery_note_id`)
) COMMENT 'Delivery document serving as the SSOT for all inbound and outbound physical goods movement authorization and tracking within the logistics domain. For outbound: delivery note number, sales order reference, ship-to party, delivery date, picking status, goods issue status, packing list details, incoterms, and export control classification. For inbound: inbound delivery number, purchase order reference, supplier ID, plant/storage location destination, expected and actual goods receipt dates, quantity ordered vs. received, over/under delivery tolerance, GR status, and material document number. Captures direction discriminator (inbound/outbound), total net/gross weight, packing contents, and MRP integration for inventory replenishment. Serves as the primary document for warehouse pick/pack/ship execution (outbound) and goods receipt processing (inbound). No other entity in this domain models delivery documents.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` (
    `inbound_delivery_id` BIGINT COMMENT 'Unique identifier for the inbound delivery document. Primary key for this entity.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: inbound_delivery.bill_of_lading_number is a denormalized STRING reference to the carriers BOL for the inbound shipment. Normalizing this to bill_of_lading_id → bill_of_lading.bill_of_lading_id enforc',
    `carrier_id` BIGINT COMMENT 'Reference to the logistics carrier or freight forwarder responsible for transporting the inbound delivery.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inbound delivery process creates an inspection lot; linking enables the Inbound Delivery Inspection Summary to pull lot results.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: GR processing rules: inbound delivery processing depends on material master attributes (GR processing time, inspection setup, storage conditions, hazmat class). Manufacturing receiving teams use mater',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Goods receipt confirmation against MRP plan: inbound deliveries must reference the originating planned order to confirm supply plan execution, trigger MRP rescheduling exceptions, and support goods re',
    `plant_data_id` BIGINT COMMENT 'Foreign key linking to product.plant_data. Business justification: Goods receipt processing for inbound deliveries is governed by plant_data parameters (gr_processing_time_days, inspection_setup_required, batch_management_required, quality_inspection_type). MRP contr',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Three-way match (PO line → inbound delivery → invoice) is a mandatory AP control in manufacturing. Linking inbound_delivery to po_line_item enables line-level quantity variance reporting, partial deli',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that triggered this inbound delivery.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: inbound_delivery.shipment_number is a denormalized STRING reference to the shipment that transported the inbound goods. Normalizing this to a proper FK (shipment_id → shipment.shipment_id) enforces re',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Associates inbound delivery with received SKU; essential for goods receipt, quality inspection, and stock update processes.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location within the plant where materials will be received.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the inbound delivery physically arrived at the receiving location.',
    `blocked_stock_flag` BOOLEAN COMMENT 'Indicates whether the received goods are placed in blocked stock pending quality inspection or other clearance.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating where the materials were manufactured or produced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inbound delivery document was first created in the system.',
    `customs_clearance_status` STRING COMMENT 'Status of customs clearance for international inbound deliveries.. Valid values are `not_required|pending|cleared|held`',
    `customs_entry_number` STRING COMMENT 'Customs entry or declaration number for imported materials, required for regulatory compliance.',
    `delivery_complete_flag` BOOLEAN COMMENT 'Indicates whether the inbound delivery is considered complete and no further receipts are expected for this document.',
    `delivery_note_text` STRING COMMENT 'Free-text notes or comments related to this inbound delivery, capturing special instructions or observations.',
    `delivery_priority` STRING COMMENT 'Priority level assigned to this inbound delivery for scheduling and resource allocation.. Valid values are `low|normal|high|urgent`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the inbound delivery document in the procurement and receiving workflow.. Valid values are `planned|in_transit|arrived|goods_receipt_posted|completed|cancelled`',
    `delivery_variance_quantity` DECIMAL(18,2) COMMENT 'Difference between quantity ordered and quantity received (positive for over-delivery, negative for under-delivery).',
    `expected_delivery_date` DATE COMMENT 'Planned date when the inbound delivery is expected to arrive at the receiving plant.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight or transportation cost associated with this inbound delivery.',
    `freight_cost_currency` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the freight cost amount.',
    `goods_receipt_date` DATE COMMENT 'Date when the goods receipt transaction was posted in the system, confirming inventory receipt.',
    `goods_receipt_posted_by` STRING COMMENT 'User ID or name of the warehouse operator who posted the goods receipt transaction.',
    `goods_receipt_status` STRING COMMENT 'Status indicating whether goods have been physically received and posted to inventory.. Valid values are `not_received|partial|complete|over_delivery`',
    `inbound_delivery_number` STRING COMMENT 'Business document number for the inbound delivery as generated by SAP MM. Externally visible identifier used for tracking and reference.. Valid values are `^[A-Z0-9]{10}$`',
    `incoterm_code` STRING COMMENT 'International commercial term defining the responsibilities of buyer and seller for delivery, risk, and cost (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether quality inspection is required before the goods can be posted to unrestricted inventory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inbound delivery document was last updated or modified.',
    `material_document_number` STRING COMMENT 'SAP material document number generated upon goods receipt posting, linking the physical receipt to inventory movement.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the received quantity may exceed the ordered quantity without triggering an exception.',
    `packing_slip_number` STRING COMMENT 'Packing slip or delivery note number provided by the supplier, listing the contents of the shipment.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Total quantity of material or components ordered as per the purchase order.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Actual quantity of material or components received and posted to inventory via goods receipt.',
    `receiving_dock` STRING COMMENT 'Specific dock or receiving bay at the plant where the inbound delivery was unloaded.',
    `shipping_point` STRING COMMENT 'Location or facility from which the supplier shipped the materials.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the received quantity may fall short of the ordered quantity without triggering an exception.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantities ordered and received (e.g., EA, KG, M, L).',
    CONSTRAINT pk_inbound_delivery PRIMARY KEY(`inbound_delivery_id`)
) COMMENT 'Inbound delivery document (SAP MM) tracking the expected arrival of purchased materials or components from suppliers. Captures inbound delivery number, purchase order reference, supplier ID, plant and storage location destination, expected delivery date, actual goods receipt date, material document number, quantity ordered vs. received, over/under delivery tolerance, and goods receipt status. Feeds MRP and inventory replenishment processes.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` (
    `bill_of_lading_id` BIGINT COMMENT 'Unique identifier for the bill of lading record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier organization responsible for transporting the cargo.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: A Bill of Lading is issued by a carrier as a legal receipt for cargo tendered under a freight order. The BOL is a child document of the freight order (freight_order is the parent that generates the BO',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment record that this BOL documents.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the cargo was delivered to the consignee and signed for.',
    `bill_of_lading_status` STRING COMMENT 'Current lifecycle status of the BOL document and associated shipment.. Valid values are `draft|issued|in_transit|delivered|cancelled|amended`',
    `bol_number` STRING COMMENT 'Externally-known unique document number issued by the carrier for this shipment. Required for customs and proof of delivery.. Valid values are `^[A-Z0-9]{8,20}$`',
    `bol_type` STRING COMMENT 'Classification of the BOL document type indicating transferability and ownership terms.. Valid values are `straight|order|negotiable|non_negotiable|master|house`',
    `commodity_description` STRING COMMENT 'Detailed description of the goods being shipped, including product names, materials, and characteristics.',
    `consignee_address_line1` STRING COMMENT 'Primary street address of the consignee destination location.',
    `consignee_city` STRING COMMENT 'City where the consignee destination is located.',
    `consignee_country_code` STRING COMMENT 'Three-letter ISO country code for the consignee destination.. Valid values are `^[A-Z]{3}$`',
    `consignee_name` STRING COMMENT 'Legal name of the consignee party receiving the cargo.',
    `consignee_postal_code` STRING COMMENT 'Postal or ZIP code for the consignee destination.',
    `consignee_state_province` STRING COMMENT 'State or province code for the consignee destination.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BOL record was first created in the system.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the cargo declared by the shipper for liability and insurance purposes.',
    `declared_value_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the declared value amount.',
    `expected_delivery_date` DATE COMMENT 'Planned or estimated date when the cargo is expected to be delivered to the consignee.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight transportation charges for this shipment.',
    `freight_charge_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the freight charge amount.',
    `freight_class` DECIMAL(18,2) COMMENT 'NMFC freight class code (50-500) used to determine LTL shipping rates based on density, handling, stowability, and liability.',
    `freight_terms` DECIMAL(18,2) COMMENT 'Payment terms indicating who is responsible for freight charges (prepaid by shipper, collect from consignee, or third party).',
    `handling_unit_count` STRING COMMENT 'Total number of handling units (pallets, crates, boxes, drums) in the shipment.',
    `handling_unit_type` STRING COMMENT 'Type of packaging or handling unit used for the cargo.. Valid values are `pallet|crate|box|drum|container|bundle`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling and documentation.',
    `hazmat_un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous material classification (e.g., UN1203 for gasoline).. Valid values are `^UN[0-9]{4}$`',
    `issue_date` TIMESTAMP COMMENT 'Date when the bill of lading was issued by the carrier acknowledging receipt of cargo.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise date and time when the BOL was issued by the carrier. Principal business event timestamp.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BOL record was last modified in the system.',
    `pickup_date` DATE COMMENT 'Scheduled or actual date when the carrier picked up the cargo from the shipper.',
    `proof_of_delivery_signature` STRING COMMENT 'Name of the person who signed for receipt of the cargo at the destination.',
    `shipper_address_line1` STRING COMMENT 'Primary street address of the shipper location.',
    `shipper_city` STRING COMMENT 'City where the shipper location is situated.',
    `shipper_country_code` STRING COMMENT 'Three-letter ISO country code for the shipper location.. Valid values are `^[A-Z]{3}$`',
    `shipper_name` STRING COMMENT 'Legal name of the shipper party originating the cargo.',
    `shipper_postal_code` STRING COMMENT 'Postal or ZIP code for the shipper location.',
    `shipper_state_province` STRING COMMENT 'State or province code for the shipper location.',
    `special_instructions` STRING COMMENT 'Free-text field for special handling, loading, or delivery instructions for the carrier.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the shipment requires temperature-controlled transportation (refrigerated or heated).',
    `total_weight` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment including packaging.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for this shipment (Less Than Truckload, Full Truckload, etc.).. Valid values are `LTL|FTL|parcel|intermodal|rail|air`',
    `weight_unit` STRING COMMENT 'Unit of measure for the total weight (pounds, kilograms, tons, metric tons).. Valid values are `LBS|KG|TON|MT`',
    CONSTRAINT pk_bill_of_lading PRIMARY KEY(`bill_of_lading_id`)
) COMMENT 'Legal transport document (BOL) issued by a carrier acknowledging receipt of cargo for shipment. Stores BOL number, issue date, shipper and consignee details, carrier name and SCAC, origin and destination addresses, commodity description, freight class, declared value, number of handling units, total weight, special handling instructions (hazmat UN number, temperature requirements), terms of carriage, and signature/seal information. Required for customs and proof of delivery.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique identifier for the transportation carrier. Primary key for the carrier master record.',
    `api_endpoint_url` STRING COMMENT 'Base URL for the carriers API integration for real-time rate quotes, shipment booking, and tracking. Used for TMS connectivity.',
    `carrier_status` STRING COMMENT 'Current operational status of the carrier in the approved carrier network. Controls whether carrier can be selected for new shipments.. Valid values are `active|inactive|suspended|pending_approval|terminated|blacklisted`',
    `carrier_type` STRING COMMENT 'Classification of the carrier based on primary mode of transportation. Determines applicable regulations and service capabilities.. Valid values are `trucking|rail|ocean|air|parcel|freight_forwarder`',
    `claims_ratio` DECIMAL(18,2) COMMENT 'Ratio of cargo claims to total shipments handled by the carrier. Used for carrier quality assessment and risk evaluation.',
    `contract_effective_date` DATE COMMENT 'Date when the current carrier contract becomes effective. Used for rate validation and contract compliance tracking.',
    `contract_expiry_date` DATE COMMENT 'Date when the current carrier contract expires. Triggers contract renewal workflow and rate renegotiation.',
    `contract_status` STRING COMMENT 'Contractual relationship status with the carrier. Determines pricing structure and service level commitments.. Valid values are `contracted|spot|preferred|trial|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for carrier invoicing and payment. Determines currency for freight charges and accessorial fees.. Valid values are `^[A-Z]{3}$`',
    `customs_broker_flag` BOOLEAN COMMENT 'Indicates whether the carrier provides customs brokerage services for international shipments. True if customs brokerage available.',
    `dot_number` STRING COMMENT 'US Department of Transportation identification number assigned to commercial motor carriers. Required for interstate commerce in the United States.. Valid values are `^[0-9]{7,8}$`',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier for the carrier business entity assigned by Dun & Bradstreet. Used for credit assessment and supplier management.. Valid values are `^[0-9]{9}$`',
    `edi_capability_flag` BOOLEAN COMMENT 'Indicates whether the carrier supports EDI transactions for shipment tendering, status updates, and invoicing. True if EDI-enabled.',
    `edi_version` STRING COMMENT 'EDI standard version supported by the carrier (e.g., ANSI X12 4010, EDIFACT D96A). Required for EDI integration setup.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the carrier is certified to transport hazardous materials per DOT regulations. True if HAZMAT-certified.',
    `headquarters_address` STRING COMMENT 'Physical street address of the carriers corporate headquarters. Used for legal correspondence and contract administration.',
    `headquarters_city` STRING COMMENT 'City where the carriers corporate headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the carriers headquarters location. Used for regulatory compliance and tax jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the carriers headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State or province where the carriers corporate headquarters is located. Two-letter code preferred.',
    `iata_code` STRING COMMENT 'IATA numeric airline code for air cargo carriers. Used for air waybill processing and cargo tracking.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `icao_code` STRING COMMENT 'Three-letter airline designator assigned by ICAO for air carriers. Used in flight operations and air traffic control.. Valid values are `^[A-Z]{3}$`',
    `insurance_certificate_number` STRING COMMENT 'Reference number for the carriers liability insurance certificate. Required for carrier qualification and risk management.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total liability coverage amount in USD provided by the carriers insurance policy. Must meet minimum requirements for cargo value.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the carriers current liability insurance coverage. Carrier cannot be used for shipments after this date without updated certificate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier record was last updated. Used for change tracking and data synchronization.',
    `mc_number` STRING COMMENT 'Motor Carrier operating authority number issued by FMCSA for carriers transporting regulated commodities for hire in interstate commerce.. Valid values are `^MC-[0-9]{6,7}$`',
    `carrier_name` STRING COMMENT 'The full legal name of the transportation carrier or freight forwarder as registered with regulatory authorities.',
    `on_time_delivery_percentage` DECIMAL(18,2) COMMENT 'Percentage of shipments delivered within the committed delivery window. Key performance indicator for carrier performance management.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard payment terms negotiated with the carrier. Defines invoice payment due date relative to shipment delivery or invoice date.',
    `preferred_lanes` STRING COMMENT 'Geographic lanes or routes where the carrier has preferred capacity, competitive rates, or specialized expertise. Comma-separated origin-destination pairs.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary carrier contact for shipment coordination, claims, and operational communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the carrier for operational coordination and issue resolution.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary carrier contact for urgent shipment issues and operational escalation.',
    `safety_rating` STRING COMMENT 'FMCSA safety fitness rating based on compliance review and safety performance history. Impacts carrier selection and risk assessment.. Valid values are `satisfactory|conditional|unsatisfactory|not_rated`',
    `safety_score` DECIMAL(18,2) COMMENT 'Composite safety performance score based on accident history, violations, and compliance metrics. Scale 0-100, higher is better.',
    `scac_code` STRING COMMENT 'Unique two-to-four letter code used to identify transportation companies. Required for EDI transactions and customs documentation in North America.. Valid values are `^[A-Z]{2,4}$`',
    `service_coverage_area` STRING COMMENT 'Geographic regions or countries where the carrier provides service. Used for carrier selection based on shipment origin and destination.',
    `service_mode` STRING COMMENT 'Primary service mode offered by the carrier. LTL (Less Than Truckload), FTL (Full Truckload), or other specialized services.. Valid values are `ltl|ftl|parcel|intermodal|expedited|bulk`',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the carrier. Used for tax reporting and compliance. Format varies by jurisdiction.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the carrier provides temperature-controlled (refrigerated or heated) transportation services. True if capable.',
    `tms_integration_status` DECIMAL(18,2) COMMENT 'Current status of the carriers integration with the enterprise TMS. Determines availability for automated shipment tendering and tracking.',
    `tracking_url_template` STRING COMMENT 'URL template for shipment tracking on the carriers website. Placeholder tokens replaced with tracking number for customer self-service.',
    `vendor_code` STRING COMMENT 'Internal vendor identifier for the carrier in the ERP system. Used for purchase order creation and invoice matching.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for approved transportation carriers (trucking companies, freight forwarders, rail operators, ocean carriers, air cargo carriers, parcel couriers). Captures carrier SCAC code, carrier name, carrier type, DOT/MC number, IATA/ICAO code, insurance certificate expiry, safety rating, contract status, preferred lanes, payment terms, EDI capability flag, and TMS integration status. Serves as the SSOT for carrier identity within the logistics domain.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` (
    `carrier_contract_id` BIGINT COMMENT 'Unique identifier for the carrier contract. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier party with whom this contract is established.',
    `accessorial_charges_included_flag` BOOLEAN COMMENT 'Indicates whether accessorial charges (liftgate, inside delivery, residential) are included in base rates or charged separately.',
    `approval_date` DATE COMMENT 'Date when the contract received internal approval from Manufacturing management.',
    `approved_by_name` STRING COMMENT 'Name of the Manufacturing executive or manager who approved this contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews upon expiry if not terminated.',
    `base_rate_type` DECIMAL(18,2) COMMENT 'Primary rate basis used in this contract for freight charges. CWT (hundredweight).',
    `carrier_contact_email` STRING COMMENT 'Primary email address for the carrier contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `carrier_contact_name` STRING COMMENT 'Primary contact name at the carrier organization for this contract.',
    `carrier_contact_phone` STRING COMMENT 'Primary phone number for the carrier contact.. Valid values are `^+?[0-9]{10,15}$`',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed contract document stored in the document management system.. Valid values are `^https?://.*$`',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the carrier contract, used in communications with carriers and internal references.. Valid values are `^[A-Z0-9]{6,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the carrier contract. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the carrier contract based on its structure and commitment level.. Valid values are `master_agreement|spot_rate|dedicated_lane|volume_commitment|blanket_contract|project_specific`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier contract record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this contract.. Valid values are `^[A-Z]{3}$`',
    `damage_claim_liability_limit` DECIMAL(18,2) COMMENT 'Maximum liability amount per shipment that the carrier accepts for damage or loss claims.',
    `detention_charge_per_hour` DECIMAL(18,2) COMMENT 'Hourly detention charge applied after free time expires.',
    `detention_free_time_minutes` STRING COMMENT 'Number of minutes allowed for loading/unloading before detention charges apply.',
    `effective_date` DATE COMMENT 'Date when the contract terms become binding and rates become applicable.',
    `expiry_date` DATE COMMENT 'Date when the contract terms cease to be binding. Nullable for open-ended contracts.',
    `fuel_index_source` STRING COMMENT 'External fuel price index used as the basis for fuel surcharge calculation, e.g., DOE National Diesel Average.',
    `fuel_surcharge_method` DECIMAL(18,2) COMMENT 'Method by which fuel surcharges are calculated and applied to shipments under this contract.',
    `geographic_coverage` STRING COMMENT 'Geographic scope of the contract, e.g., North America, USA domestic, specific state/province list.',
    `insurance_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether the carrier is required to maintain specific cargo insurance coverage under this contract.',
    `insurance_minimum_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum cargo insurance coverage amount required from the carrier.',
    `last_modified_by_name` STRING COMMENT 'Name of the user who last modified this carrier contract record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier contract record was last updated.',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Minimum shipment volume (in commitment unit) that Manufacturing commits to tender to the carrier during the contract period.',
    `negotiation_date` DATE COMMENT 'Date when the contract terms were finalized and agreed upon by both parties.',
    `notes` STRING COMMENT 'Free-text notes capturing additional contract terms, special conditions, or operational instructions.',
    `on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'Contractual target percentage for on-time delivery performance, used for SLA compliance measurement.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms agreed with the carrier, e.g., net_30, net_45, net_60.',
    `penalty_clause_description` STRING COMMENT 'Description of penalties applicable for service failures, late deliveries, or volume shortfalls.',
    `rate_adjustment_trigger` DECIMAL(18,2) COMMENT 'Conditions or events that trigger a rate adjustment, e.g., fuel price change exceeding 10%, volume variance exceeding 20%.',
    `rate_review_frequency` DECIMAL(18,2) COMMENT 'Frequency at which contract rates are reviewed and potentially adjusted.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to prevent auto-renewal or to initiate renewal negotiation.',
    `service_level_standard` STRING COMMENT 'Guaranteed service level commitment, e.g., next-day delivery, 2-day delivery, standard ground.',
    `service_mode` STRING COMMENT 'Primary transportation mode covered by this contract. LTL (Less Than Truckload), FTL (Full Truckload).. Valid values are `LTL|FTL|parcel|intermodal|air_freight|ocean_freight`',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the contract.',
    `termination_reason` STRING COMMENT 'Reason for contract termination if status is terminated, e.g., poor performance, cost reduction, carrier exit.',
    `volume_commitment_unit` STRING COMMENT 'Unit of measure for the minimum volume commitment.. Valid values are `shipments|pallets|weight_kg|weight_lbs|revenue_usd`',
    CONSTRAINT pk_carrier_contract PRIMARY KEY(`carrier_contract_id`)
) COMMENT 'Negotiated rate and service agreement between Manufacturing and a carrier, serving as the single source of truth (SSOT) for ALL carrier pricing within the logistics domain — including contract rates, spot rates, and benchmark rates. Captures contract-level terms (effective/expiry dates, volume commitments, service level guarantees, penalty clauses, payment terms) and granular lane-level rate records (per cwt, per mile, per shipment, per pallet by origin-destination zone/postal code range, freight class, weight break, and service level). Includes fuel surcharge schedules, accessorial charge tables, rate basis (weight break/flat/distance), rate currency, rate effective date ranges, rate source classification (contract/spot/benchmark), minimum volume thresholds, and rate validity periods. Used by TMS for automated carrier selection, freight cost calculation, spot rate benchmarking, and freight invoice audit. No other entity in this domain stores rate data.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` (
    `transport_route_id` BIGINT COMMENT 'Unique identifier for the transport route. Primary key for the transport route entity.',
    `carrier_id` BIGINT COMMENT 'FK to logistics.carrier',
    `alternate_carrier_codes` STRING COMMENT 'Comma-separated list of alternate carrier codes that can be used for this route if the preferred carrier is unavailable or for load balancing.',
    `carbon_emission_factor_kg_per_km` DECIMAL(18,2) COMMENT 'Average carbon dioxide equivalent emissions per kilometer for this route, used for sustainability reporting and carbon footprint calculation.',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the standard freight cost.',
    `cost_per_km` DECIMAL(18,2) COMMENT 'Average freight cost per kilometer for this route, used for variable cost modeling and route comparison.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transport route record was first created in the system.',
    `customs_clearance_required` BOOLEAN COMMENT 'Indicates whether customs clearance is required for this route (typically true for cross-border international routes).',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination location, used for customs and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Code identifying the destination node (customer site, distribution center, plant, or port) where the shipment ends. Aligns with internal location master or UN/LOCODE for ports.. Valid values are `^[A-Z0-9]{3,10}$`',
    `destination_location_name` STRING COMMENT 'Human-readable name of the destination location for reporting and operational visibility.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance of the route in kilometers, used for cost calculation, transit time estimation, and route optimization.',
    `effective_from_date` DATE COMMENT 'Date from which this route configuration becomes effective, used for contract lifecycle management and rate validity.',
    `effective_to_date` DATE COMMENT 'Date until which this route configuration is valid. Null indicates an open-ended route with no expiration.',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this route (e.g., dry van, refrigerated, flatbed, tanker, 20ft container, 40ft container).',
    `fuel_surcharge_applicable` DECIMAL(18,2) COMMENT 'Indicates whether a fuel surcharge is applicable to shipments on this route, based on carrier contract terms.',
    `hazmat_approved` BOOLEAN COMMENT 'Indicates whether this route is approved for transporting hazardous materials, based on carrier certification and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transport route record was last updated, used for change tracking and audit trail.',
    `last_review_date` DATE COMMENT 'Date when this route was last reviewed for performance, cost, and optimization opportunities.',
    `load_type` STRING COMMENT 'Classification of shipment load type for this route: FTL (Full Truckload), LTL (Less Than Truckload), parcel (small package), container (ocean/rail), or bulk (loose cargo).. Valid values are `FTL|LTL|parcel|container|bulk`',
    `maximum_transit_time_days` DECIMAL(18,2) COMMENT 'Maximum expected transit time in days, accounting for delays and worst-case scenarios, used for safety stock and buffer planning.',
    `minimum_transit_time_days` DECIMAL(18,2) COMMENT 'Minimum achievable transit time in days for expedited or express service on this route.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next route performance review and optimization assessment.',
    `optimization_priority` STRING COMMENT 'Primary optimization objective for route selection: cost (lowest freight cost), speed (fastest transit), reliability (on-time performance), sustainability (lowest carbon footprint), or balanced (multi-objective).. Valid values are `cost|speed|reliability|sustainability|balanced`',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the origin location, used for customs and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `origin_location_code` STRING COMMENT 'Code identifying the origin node (plant, distribution center, supplier facility, or port) where the shipment begins. Aligns with internal location master or UN/LOCODE for ports.. Valid values are `^[A-Z0-9]{3,10}$`',
    `origin_location_name` STRING COMMENT 'Human-readable name of the origin location for reporting and operational visibility.',
    `primary_transport_mode` STRING COMMENT 'Primary mode of transportation used for this route: road (truck), rail, air (cargo flight), ocean (container ship), inland waterway (barge), or pipeline.. Valid values are `road|rail|air|ocean|inland_waterway|pipeline`',
    `route_capacity_constraint` STRING COMMENT 'Description of any capacity constraints on this route (e.g., weight limits, volume limits, frequency limits, carrier capacity).',
    `route_code` STRING COMMENT 'Business identifier for the transport route or lane, used for operational reference and TMS (Transportation Management System) routing logic.. Valid values are `^[A-Z0-9]{6,20}$`',
    `route_name` STRING COMMENT 'Descriptive name of the transport route, typically including origin and destination for human readability.',
    `route_notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or considerations for this route.',
    `route_status` STRING COMMENT 'Current operational status of the transport route in the network.. Valid values are `active|inactive|suspended|seasonal|under_review|deprecated`',
    `route_type` STRING COMMENT 'Classification of the route based on transportation strategy: direct (point-to-point), relay (driver handoff), intermodal (multiple transport modes), milk run (multi-stop collection/delivery), cross-dock (consolidation hub), or backhaul (return leg optimization).. Valid values are `direct|relay|intermodal|milk_run|cross_dock|backhaul`',
    `seasonal_restriction_details` STRING COMMENT 'Detailed description of seasonal restrictions, including affected months, reasons, and alternative routing recommendations.',
    `seasonal_restriction_flag` BOOLEAN COMMENT 'Indicates whether this route has seasonal restrictions (e.g., winter road closures, monsoon disruptions, peak season capacity limits).',
    `service_level` STRING COMMENT 'Service level classification for the route, defining speed and priority: express (fastest), standard (normal), economy (cost-optimized), dedicated (exclusive vehicle), or shared (consolidated shipments).. Valid values are `express|standard|economy|dedicated|shared`',
    `standard_freight_cost` DECIMAL(18,2) COMMENT 'Standard or baseline freight cost for this route in the companys reporting currency, used for budgeting and cost estimation.',
    `standard_transit_time_days` DECIMAL(18,2) COMMENT 'Expected transit time in days for shipments on this route under normal conditions, used for delivery promise calculation and planning.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether this route supports temperature-controlled (refrigerated or heated) transportation for sensitive goods.',
    CONSTRAINT pk_transport_route PRIMARY KEY(`transport_route_id`)
) COMMENT 'Defined transportation route or lane between an origin node (plant, DC, supplier) and a destination node (customer, DC, port), capturing route code, origin and destination location codes, primary transport mode, standard transit time (days), distance (km), preferred carrier, alternate carriers, route type (direct/relay/intermodal), seasonal restrictions, and route optimization parameters. Used by TMS for automated routing and load planning.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`transport_route`(`transport_route_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`transport_route`(`transport_route_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ADD CONSTRAINT `fk_logistics_transport_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Route Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `actual_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Pickup Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `commercial_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Shipment Direction');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'National Motor Freight Classification (NMFC) Freight Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS) Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `insurance_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `scheduled_pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Pickup Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|priority|same_day');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'planned|tendered|in_transit|delivered|exception|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `tms_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'LTL|FTL|parcel|rail|air|ocean');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `contract_release_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Release Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `actual_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Pickup Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Acceptance Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_acceptance_status` SET TAGS ('dbx_value_regex' = 'Pending|Accepted|Rejected|Expired');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Acceptance Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `customs_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Customs Required Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'Dry Van|Refrigerated|Flatbed|Tanker|Container|Box Truck');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `pickup_window_end` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window End');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `pickup_window_start` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window Start');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Standard|Expedited|Rush|Critical');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `sap_tm_freight_order_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Transportation Management (TM) Freight Order Reference');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Service Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'LTL|FTL|Intermodal|Parcel|Air Freight|Ocean Freight');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `temperature_controlled_indicator` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `tender_method` SET TAGS ('dbx_business_glossary_term' = 'Tender Method');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `tender_method` SET TAGS ('dbx_value_regex' = 'Spot|Contract|Auction|Direct Award');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `tender_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tender Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `total_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Cost');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_note_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `address_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_direction` SET TAGS ('dbx_business_glossary_term' = 'Delivery Direction');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue (GI) Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue (GI) Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `loading_date` SET TAGS ('dbx_business_glossary_term' = 'Loading Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `packing_date` SET TAGS ('dbx_business_glossary_term' = 'Packing Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `packing_status` SET TAGS ('dbx_business_glossary_term' = 'Packing Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `packing_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|partially_packed');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `picking_date` SET TAGS ('dbx_business_glossary_term' = 'Picking Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `picking_status` SET TAGS ('dbx_business_glossary_term' = 'Picking Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `picking_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|partially_picked');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `proof_of_delivery_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air|ocean|rail|truck|courier|parcel');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `shipping_service_level` SET TAGS ('dbx_business_glossary_term' = 'Shipping Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `shipping_service_level` SET TAGS ('dbx_value_regex' = 'standard|express|overnight|economy|premium');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `total_net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Data Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `blocked_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|held');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `delivery_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Complete Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `delivery_note_text` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Text');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'planned|in_transit|arrived|goods_receipt_posted|completed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `delivery_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivery Variance Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `goods_receipt_posted_by` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Posted By');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partial|complete|over_delivery');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `inbound_delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `inbound_delivery_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over Delivery Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `packing_slip_number` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `receiving_dock` SET TAGS ('dbx_business_glossary_term' = 'Receiving Dock');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_status` SET TAGS ('dbx_value_regex' = 'draft|issued|in_transit|delivered|cancelled|amended');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_type` SET TAGS ('dbx_value_regex' = 'straight|order|negotiable|non_negotiable|master|house');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_city` SET TAGS ('dbx_business_glossary_term' = 'Consignee City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_country_code` SET TAGS ('dbx_business_glossary_term' = 'Consignee Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Consignee Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_state_province` SET TAGS ('dbx_business_glossary_term' = 'Consignee State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'National Motor Freight Classification (NMFC) Freight Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `handling_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Count');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `handling_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `handling_unit_type` SET TAGS ('dbx_value_regex' = 'pallet|crate|box|drum|container|bundle');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Hazmat Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Pickup Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `proof_of_delivery_signature` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_city` SET TAGS ('dbx_business_glossary_term' = 'Shipper City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipper Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipper Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_state_province` SET TAGS ('dbx_business_glossary_term' = 'Shipper State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `total_weight` SET TAGS ('dbx_business_glossary_term' = 'Total Weight');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'LTL|FTL|parcel|intermodal|rail|air');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'LBS|KG|TON|MT');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint URL');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|blacklisted');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'trucking|rail|ocean|air|parcel|freight_forwarder');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `claims_ratio` SET TAGS ('dbx_business_glossary_term' = 'Claims Ratio');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'contracted|spot|preferred|trial|expired');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `customs_broker_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Service Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `edi_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capability Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `edi_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Version');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `icao_code` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `icao_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_business_glossary_term' = 'Motor Carrier (MC) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_value_regex' = '^MC-[0-9]{6,7}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Legal Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `on_time_delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `preferred_lanes` SET TAGS ('dbx_business_glossary_term' = 'Preferred Lanes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|conditional|unsatisfactory|not_rated');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `safety_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Score');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `service_coverage_area` SET TAGS ('dbx_business_glossary_term' = 'Service Coverage Area');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'ltl|ftl|parcel|intermodal|expedited|bulk');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Capability Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `tms_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Integration Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_business_glossary_term' = 'Tracking URL Template');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `accessorial_charges_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `base_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master_agreement|spot_rate|dedicated_lane|volume_commitment|blanket_contract|project_specific');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `damage_claim_liability_limit` SET TAGS ('dbx_business_glossary_term' = 'Damage Claim Liability Limit');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `detention_charge_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Detention Charge Per Hour');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `detention_free_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Detention Free Time Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_index_source` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Source');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_method` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Method');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `insurance_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `insurance_minimum_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Minimum Coverage Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_mask_in_non_prod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `negotiation_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Target Percentage (Pct)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `penalty_clause_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Description');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `rate_adjustment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Trigger');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `rate_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rate Review Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_level_standard` SET TAGS ('dbx_business_glossary_term' = 'Service Level Standard');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'LTL|FTL|parcel|intermodal|air_freight|ocean_freight');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_value_regex' = 'shipments|pallets|weight_kg|weight_lbs|revenue_usd');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Route ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `alternate_carrier_codes` SET TAGS ('dbx_business_glossary_term' = 'Alternate Carrier Codes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `carbon_emission_factor_kg_per_km` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Factor (Kilograms per Kilometer)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `cost_per_km` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Kilometer');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `cost_per_km` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `customs_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_location_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_location_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance (Kilometers)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `hazmat_approved` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Approved');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'FTL|LTL|parcel|container|bulk');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `maximum_transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transit Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `minimum_transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transit Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `optimization_priority` SET TAGS ('dbx_business_glossary_term' = 'Optimization Priority');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `optimization_priority` SET TAGS ('dbx_value_regex' = 'cost|speed|reliability|sustainability|balanced');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `origin_location_name` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `origin_location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `origin_location_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `primary_transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Primary Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `primary_transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|air|ocean|inland_waterway|pipeline');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_capacity_constraint` SET TAGS ('dbx_business_glossary_term' = 'Route Capacity Constraint');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|seasonal|under_review|deprecated');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'direct|relay|intermodal|milk_run|cross_dock|backhaul');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `seasonal_restriction_details` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Restriction Details');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `seasonal_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Restriction Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'express|standard|economy|dedicated|shared');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `standard_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Freight Cost');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `standard_freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `standard_transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Transit Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
