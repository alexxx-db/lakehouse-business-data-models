-- Schema for Domain: logistics | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:59:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`logistics` COMMENT 'Inbound and outbound logistics domain managing shipment planning, carrier selection, LTL/FTL routing, freight cost, customs documentation, TMS execution, delivery tracking, route optimization, and distribution network management. Coordinates material flow from suppliers to plants and finished goods from plants to customers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: Associate each shipment with the carrier contract that governs rates and terms.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Link shipment to carrier for authoritative carrier data; carrier_scac_code and carrier_name become redundant.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shipments incur costs that must be charged to a cost center. Adding cost_center_id (FK → finance.cost_center.cost_center_id) provides the necessary financial linkage.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Shipment Creation Audit requires recording which employee created the shipment record for compliance and traceability.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Required for outbound shipping confirmation and customer billing report linking each shipment to the billed customer.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Shipment execution is driven by a sales order; linking enables order fulfillment tracking and status reporting.',
    `node_id` BIGINT COMMENT 'Foreign key linking to logistics.node. Business justification: Replace raw origin address fields with a foreign key to node, enabling reuse of node master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability reporting per shipment requires linking each shipment to its profit_center for margin analysis.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Project Delivery Tracking report requires each shipment to be assigned to its project for status and cost aggregation.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: INBOUND_SHIPMENT_REPORT requires linking each shipment to its originating supplier for performance tracking and inbound logistics KPI reporting.',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Shipment creation is driven by an approved supply plan; linking enables the Supply Plan to Shipment execution traceability report.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment was delivered to the destination location.',
    `actual_pickup_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier picked up the shipment from the origin location.',
    `bol_number` STRING COMMENT 'Bill of Lading number serving as the legal document and receipt for the shipment. Issued by the carrier.',
    `commercial_invoice_number` STRING COMMENT 'Invoice number associated with the shipment for customs and billing purposes.',
    `consolidation_group_code` STRING COMMENT 'Identifier for the consolidation group used in load planning. Multiple shipments with the same consolidation group may be combined into a single load.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `customs_declaration_number` STRING COMMENT 'Reference number for the customs declaration document required for cross-border shipments. Used for import/export compliance.',
    `destination_address_line1` STRING COMMENT 'First line of the street address for the destination location.',
    `destination_city` STRING COMMENT 'City name of the destination location.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the destination location (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Code identifying the destination location (customer site, distribution center, plant) where the shipment is delivered.. Valid values are `^[A-Z0-9]{3,10}$`',
    `destination_location_name` STRING COMMENT 'Human-readable name of the destination location.',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code of the destination location.',
    `destination_state_province` STRING COMMENT 'State or province of the destination location.',
    `direction` STRING COMMENT 'Indicates whether the shipment is inbound (supplier to plant) or outbound (plant to customer or distribution center).. Valid values are `inbound|outbound`',
    `freight_class` STRING COMMENT 'Freight class assigned to the shipment based on density, stowability, handling, and liability. Used for LTL pricing. Valid classes range from 50 to 500.. Valid values are `^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$`',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost for the shipment in the specified currency. Includes base transportation charges but may exclude accessorial fees.',
    `freight_cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the freight cost amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `hazmat_class` STRING COMMENT 'UN hazard class for hazardous materials in the shipment (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Populated only if hazmat_flag is true.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling, documentation, and compliance with safety regulations.',
    `incoterm_code` STRING COMMENT 'INCOTERMS code defining the responsibilities, costs, and risks between buyer and seller for international shipments (e.g., EXW, FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_value_amount` DECIMAL(18,2) COMMENT 'Declared value of the shipment for insurance purposes. Used to determine coverage limits and premiums.',
    `insurance_value_currency_code` STRING COMMENT 'Three-letter ISO currency code for the insurance value amount.. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` (
    `shipment_leg_id` BIGINT COMMENT 'Unique identifier for the shipment leg. Primary key for this entity representing a single transport segment within a multi-leg shipment journey.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to execute this leg. References the logistics service provider responsible for moving goods.',
    `node_id` BIGINT COMMENT 'Identifier of the arrival location for this leg. May reference a warehouse, plant, distribution center, customer site, cross-dock facility, or transshipment hub.',
    `destination_location_node_id` BIGINT COMMENT 'FK to logistics.logistics_node',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Leg Handling Accountability records the employee operating the vehicle or equipment for each leg, required for safety incident investigations.',
    `origin_location_logistics_node_id` BIGINT COMMENT 'FK to logistics.logistics_node',
    `primary_shipment_node_id` BIGINT COMMENT 'Identifier of the departure location for this leg. May reference a warehouse, plant, distribution center, cross-dock facility, or transshipment hub.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment that this leg belongs to. Links this transport segment to the overall shipment journey.',
    `tertiary_shipment_transfer_point_location_node_id` BIGINT COMMENT 'FK to logistics.logistics_node',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Sum of additional charges beyond base freight cost, such as liftgate service, inside delivery, residential delivery, detention, or special handling fees.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier arrived at the destination location. Captured from TMS or carrier proof-of-delivery systems.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier departed from the origin location. Captured from Transportation Management System (TMS) or carrier tracking systems.',
    `bill_of_lading_number` STRING COMMENT 'Bill of Lading number issued by the carrier for this leg. Legal document serving as receipt of goods and contract of carriage.',
    `carrier_service_level` STRING COMMENT 'Service tier or speed class provided by the carrier for this leg. Defines delivery speed and priority.. Valid values are `standard|express|overnight|same_day|economy`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment leg record was first created in the Transportation Management System (TMS). Used for audit trail and data lineage.',
    `customs_clearance_status` STRING COMMENT 'Current status of customs clearance process for this leg. Tracks progression through import/export documentation and inspection.. Valid values are `not_required|pending|in_progress|cleared|held|rejected`',
    `customs_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this leg crosses international borders and requires customs clearance documentation.',
    `delay_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of delay in hours, calculated as the difference between scheduled and actual arrival timestamps when a delay occurs.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the primary cause of delay if the leg did not meet scheduled arrival time. Supports root cause analysis and carrier performance evaluation. [ENUM-REF-CANDIDATE: weather|traffic|mechanical|customs|loading|driver|accident|other — 8 candidates stripped; promote to reference product]',
    `equipment_number` STRING COMMENT 'Identifier of the specific equipment unit (truck, trailer, container, railcar) used for this leg. Enables asset tracking and utilization analysis.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Additional fuel surcharge applied by the carrier for this leg. Typically calculated as a percentage of base freight cost and varies with fuel prices.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this leg transports hazardous materials requiring special handling, documentation, and regulatory compliance.',
    `is_cross_dock` BOOLEAN COMMENT 'Boolean flag indicating whether this leg involves a cross-docking operation where goods are transferred directly from inbound to outbound transport without warehousing.',
    `is_transshipment` BOOLEAN COMMENT 'Boolean flag indicating whether this leg involves transshipment where goods are transferred between different carriers or transport modes at an intermediate hub.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment leg record was most recently modified. Tracks changes to status, timestamps, or other leg attributes.',
    `leg_distance_km` DECIMAL(18,2) COMMENT 'Total distance traveled for this leg measured in kilometers. Used for route optimization, cost calculation, and carbon footprint analysis.',
    `leg_distance_miles` DECIMAL(18,2) COMMENT 'Total distance traveled for this leg measured in miles. Provided for regions using imperial measurement systems.',
    `leg_freight_cost` DECIMAL(18,2) COMMENT 'Total freight cost charged by the carrier for this specific leg. Supports leg-level cost allocation and profitability analysis.',
    `leg_freight_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the leg freight cost (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `leg_sequence_number` STRING COMMENT 'Sequential order of this leg within the parent shipment journey. Indicates the position in the multi-leg routing plan (1 for first leg, 2 for second, etc.).',
    `leg_status` STRING COMMENT 'Current operational status of this transport leg in its lifecycle. Tracks progression from planning through execution to completion. [ENUM-REF-CANDIDATE: planned|scheduled|in_transit|arrived|completed|cancelled|delayed — 7 candidates stripped; promote to reference product]',
    `load_type` STRING COMMENT 'Classification of shipment load configuration. FTL (Full Truckload) indicates dedicated vehicle, LTL (Less Than Truckload) indicates shared capacity with other shipments.. Valid values are `FTL|LTL|parcel|container|bulk`',
    `notes` STRING COMMENT 'Free-text field for capturing additional operational notes, special instructions, or exceptions related to this leg execution.',
    `pro_number` STRING COMMENT 'Progressive number assigned by Less Than Truckload (LTL) carriers to track shipments. Industry-standard identifier for LTL freight.',
    `route_optimization_score` DECIMAL(18,2) COMMENT 'Calculated score representing the efficiency of this leg routing based on distance, cost, transit time, and service level. Used for continuous improvement analysis.',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time when the carrier is scheduled to arrive at the destination location. Used for receiving planning and SLA commitments.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time when the carrier is scheduled to depart from the origin location. Used for planning and Service Level Agreement (SLA) tracking.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or trailer for this leg. Used for tamper detection and customs compliance.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this leg requires temperature-controlled transport (refrigerated or heated) to maintain product integrity.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments on this leg. Used for cold chain compliance monitoring.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments on this leg. Used for cold chain compliance monitoring.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for real-time shipment visibility and proof-of-delivery. Used for customer self-service tracking portals.',
    `transit_time_hours` DECIMAL(18,2) COMMENT 'Planned or actual duration of this leg measured in hours. Calculated as the difference between departure and arrival timestamps.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for this leg. Supports intermodal routing scenarios where different legs use different transport methods.. Valid values are `road|rail|air|ocean|intermodal|parcel`',
    `vehicle_type` STRING COMMENT 'Type of vehicle or equipment used to transport goods on this leg. Provides granular detail within the transport mode.. Valid values are `truck|container|railcar|aircraft|vessel|van`',
    CONSTRAINT pk_shipment_leg PRIMARY KEY(`shipment_leg_id`)
) COMMENT 'Represents an individual transport leg within a multi-leg shipment, capturing leg sequence, origin and destination nodes, carrier assignment, mode of transport, scheduled and actual departure/arrival timestamps, leg distance (km/miles), leg freight cost, leg status, and intermodal transfer point details. Supports complex routing scenarios including cross-docking, transshipment, and relay trucking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'Unique identifier for the freight order. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or freight forwarder assigned to execute this freight order.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Freight Order Creation Audit records which employee originated the order, supporting cost allocation and compliance reporting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Allows order management to associate each freight order with the originating customer for tracking and cost allocation.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Freight order transports goods for a specific sales order; linking allows freight cost allocation to that order.',
    `node_id` BIGINT COMMENT 'Reference to the facility, warehouse, or site where goods will be picked up by the carrier.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Freight Order Creation process for a manufacturing project needs a FK to the project to allocate freight costs to the project budget.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight order is created to transport goods for a specific PO; needed for cost allocation and PO fulfillment tracking.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Freight order processing must ensure order‑level regulatory reporting (e.g., export controls), so each order references the governing regulatory requirement.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment(s) associated with this freight order. Links the freight order to the physical shipment being transported.',
    `transport_route_id` BIGINT COMMENT 'Reference to the planned transportation route for this freight order. Links to route optimization and network planning data.',
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
    `freight_order_number` STRING COMMENT 'Business-facing unique identifier for the freight order, typically generated by the Transportation Management System (TMS) or SAP TM module. Used for external communication with carriers and internal tracking.',
    `freight_order_status` STRING COMMENT 'Current lifecycle status of the freight order. Draft indicates order is being prepared, Tendered means sent to carrier, Accepted means carrier confirmed, Rejected means carrier declined, In Transit means shipment is moving, Delivered means goods received, Cancelled means order voided, Closed means order completed and invoiced. [ENUM-REF-CANDIDATE: Draft|Tendered|Accepted|Rejected|In Transit|Delivered|Cancelled|Closed — 8 candidates stripped; promote to reference product]',
    `freight_rate_amount` DECIMAL(18,2) COMMENT 'Agreed base freight rate amount for transporting the goods, excluding accessorial charges and taxes. Represents the core transportation cost negotiated with the carrier.',
    `freight_rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight rate amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
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
    `sap_tm_freight_order_reference` STRING COMMENT 'Reference identifier from SAP Transportation Management (TM) module linking this freight order to the source system record. Used for traceability and reconciliation with the operational TMS.',
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
    `carrier_id` BIGINT COMMENT 'Transportation carrier or logistics service provider handling the shipment.',
    `customer_account_id` BIGINT COMMENT 'Ship-to party for outbound deliveries. The customer receiving the goods.',
    `order_header_id` BIGINT COMMENT 'Reference to the originating sales order for outbound deliveries. Links delivery execution to customer order.',
    `address_id` BIGINT COMMENT 'Destination address for outbound deliveries. Links to customer site or delivery location.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order for inbound deliveries. Links goods receipt to procurement.',
    `shipment_id` BIGINT COMMENT 'Reference to the consolidated shipment if this delivery is part of a multi-delivery shipment.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Links delivery note to the delivered SKU for inventory reconciliation, warranty activation, and after‑sales service tracking.',
    `stock_location_id` BIGINT COMMENT 'Specific storage location within the plant for goods receipt or goods issue.',
    `supplier_id` BIGINT COMMENT 'Vendor or supplier for inbound deliveries. The party shipping goods to the organization.',
    `allocation_id` BIGINT COMMENT 'Foreign key linking to supply.allocation. Business justification: Delivery notes are generated from supply allocation records; the link supports the Allocation‑to‑Delivery Note audit.',
    `warehouse_id` BIGINT COMMENT 'Warehouse facility executing the pick, pack, and ship operations for this delivery.',
    `actual_delivery_date` DATE COMMENT 'Actual date when goods were delivered to the destination or received at the plant.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading number issued by the carrier as a receipt and contract for transportation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery note record was first created in the system.',
    `customs_declaration_number` STRING COMMENT 'Customs declaration or entry number for international shipments requiring customs clearance.. Valid values are `^[A-Z0-9]{10,20}$`',
    `delivery_direction` STRING COMMENT 'Discriminator indicating whether this is an inbound delivery (goods receipt from supplier) or outbound delivery (shipment to customer).. Valid values are `inbound|outbound`',
    `delivery_note_number` STRING COMMENT 'Externally-known business identifier for the delivery note. Used for tracking and reference across systems and with external parties.. Valid values are `^[A-Z0-9]{8,20}$`',
    `delivery_priority` STRING COMMENT 'Priority level assigned to the delivery for warehouse and transportation planning.. Valid values are `low|normal|high|urgent|critical`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery note in the warehouse and logistics execution workflow. [ENUM-REF-CANDIDATE: draft|planned|picking|packed|shipped|in_transit|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `export_control_classification` STRING COMMENT 'Export control classification for goods subject to export regulations and licensing requirements.. Valid values are `^[A-Z0-9]{4,10}$`',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight or transportation cost for the delivery.',
    `freight_cost_currency` STRING COMMENT 'Currency code for freight cost amount. ISO 4217 three-letter currency code.. Valid values are `^[A-Z]{3}$`',
    `goods_issue_date` DATE COMMENT 'Date when goods were physically issued from inventory for outbound deliveries. Triggers inventory reduction.',
    `goods_issue_status` STRING COMMENT 'Status of goods issue posting for outbound deliveries. Indicates whether inventory has been reduced.. Valid values are `pending|posted|reversed|blocked`',
    `goods_receipt_date` DATE COMMENT 'Date when goods were physically received into inventory for inbound deliveries. Triggers inventory increase.',
    `goods_receipt_status` STRING COMMENT 'Status of goods receipt posting for inbound deliveries. Indicates whether inventory has been increased.. Valid values are `pending|posted|reversed|blocked`',
    `harmonized_tariff_code` STRING COMMENT 'Harmonized System code for customs classification and duty calculation.. Valid values are `^[0-9]{6,10}$`',
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
    `carrier_id` BIGINT COMMENT 'Reference to the logistics carrier or freight forwarder responsible for transporting the inbound delivery.',
    `employee_id` BIGINT COMMENT 'Reference to the MRP controller responsible for planning and monitoring this inbound delivery.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inbound delivery process creates an inspection lot; linking enables the Inbound Delivery Inspection Summary to pull lot results.',
    `asset_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility receiving the inbound delivery.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that triggered this inbound delivery.',
    `replenishment_proposal_id` BIGINT COMMENT 'Foreign key linking to supply.replenishment_proposal. Business justification: Inbound deliveries are the physical receipt of goods proposed in a replenishment proposal; needed for the Proposal‑to‑Receipt tracking report.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Associates inbound delivery with received SKU; essential for goods receipt, quality inspection, and stock update processes.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location within the plant where materials will be received.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier delivering the materials or components.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the inbound delivery physically arrived at the receiving location.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading document number issued by the carrier, serving as receipt and contract for transportation.',
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
    `freight_cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the freight cost amount.. Valid values are `^[A-Z]{3}$`',
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
    `shipment_number` STRING COMMENT 'Tracking number or shipment identifier provided by the carrier for this inbound delivery.',
    `shipping_point` STRING COMMENT 'Location or facility from which the supplier shipped the materials.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the received quantity may fall short of the ordered quantity without triggering an exception.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantities ordered and received (e.g., EA, KG, M, L).',
    CONSTRAINT pk_inbound_delivery PRIMARY KEY(`inbound_delivery_id`)
) COMMENT 'Inbound delivery document (SAP MM) tracking the expected arrival of purchased materials or components from suppliers. Captures inbound delivery number, purchase order reference, supplier ID, plant and storage location destination, expected delivery date, actual goods receipt date, material document number, quantity ordered vs. received, over/under delivery tolerance, and goods receipt status. Feeds MRP and inventory replenishment processes.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` (
    `bill_of_lading_id` BIGINT COMMENT 'Unique identifier for the bill of lading record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier organization responsible for transporting the cargo.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: B/L issuance audit needs the employee identifier who generated the bill of lading for legal and customs compliance.',
    `customer_account_id` BIGINT COMMENT 'Reference to the party (supplier or internal plant) sending the cargo.',
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
    `declared_value_currency` STRING COMMENT 'Three-letter ISO currency code for the declared value amount.. Valid values are `^[A-Z]{3}$`',
    `expected_delivery_date` DATE COMMENT 'Planned or estimated date when the cargo is expected to be delivered to the consignee.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight transportation charges for this shipment.',
    `freight_charge_currency` STRING COMMENT 'Three-letter ISO currency code for the freight charge amount.. Valid values are `^[A-Z]{3}$`',
    `freight_class` STRING COMMENT 'NMFC freight class code (50-500) used to determine LTL shipping rates based on density, handling, stowability, and liability.. Valid values are `^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$`',
    `freight_terms` STRING COMMENT 'Payment terms indicating who is responsible for freight charges (prepaid by shipper, collect from consignee, or third party).. Valid values are `prepaid|collect|third_party`',
    `handling_unit_count` STRING COMMENT 'Total number of handling units (pallets, crates, boxes, drums) in the shipment.',
    `handling_unit_type` STRING COMMENT 'Type of packaging or handling unit used for the cargo.. Valid values are `pallet|crate|box|drum|container|bundle`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling and documentation.',
    `hazmat_un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous material classification (e.g., UN1203 for gasoline).. Valid values are `^UN[0-9]{4}$`',
    `issue_date` DATE COMMENT 'Date when the bill of lading was issued by the carrier acknowledging receipt of cargo.',
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
    `cost_center_id` BIGINT COMMENT 'add column finance_cost_center_id (BIGINT) with FK to finance.cost_center.cost_center_id - carrier costs must be allocated to cost centers for freight accounting',
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
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the carrier. Defines invoice payment due date relative to shipment delivery or invoice date.. Valid values are `net_30|net_45|net_60|net_90|prepaid|cod`',
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
    `tms_integration_status` STRING COMMENT 'Current status of the carriers integration with the enterprise TMS. Determines availability for automated shipment tendering and tracking.. Valid values are `integrated|pending|not_integrated|failed`',
    `tracking_url_template` STRING COMMENT 'URL template for shipment tracking on the carriers website. Placeholder tokens replaced with tracking number for customer self-service.',
    `vendor_code` STRING COMMENT 'Internal vendor identifier for the carrier in the ERP system. Used for purchase order creation and invoice matching.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for approved transportation carriers (trucking companies, freight forwarders, rail operators, ocean carriers, air cargo carriers, parcel couriers). Captures carrier SCAC code, carrier name, carrier type, DOT/MC number, IATA/ICAO code, insurance certificate expiry, safety rating, contract status, preferred lanes, payment terms, EDI capability flag, and TMS integration status. Serves as the SSOT for carrier identity within the logistics domain.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` (
    `carrier_contract_id` BIGINT COMMENT 'Unique identifier for the carrier contract. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier party with whom this contract is established.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract Ownership Tracking links the employee responsible for negotiating and managing the carrier contract, essential for governance and audit.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Carrier contracts generate revenue/expense tracked against a profit center for performance measurement.',
    `accessorial_charges_included_flag` BOOLEAN COMMENT 'Indicates whether accessorial charges (liftgate, inside delivery, residential) are included in base rates or charged separately.',
    `approval_date` DATE COMMENT 'Date when the contract received internal approval from Manufacturing management.',
    `approved_by_name` STRING COMMENT 'Name of the Manufacturing executive or manager who approved this contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews upon expiry if not terminated.',
    `base_rate_type` STRING COMMENT 'Primary rate basis used in this contract for freight charges. CWT (hundredweight).. Valid values are `per_cwt|per_mile|per_shipment|per_pallet|flat_rate|weight_break`',
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
    `fuel_surcharge_method` STRING COMMENT 'Method by which fuel surcharges are calculated and applied to shipments under this contract.. Valid values are `percentage_of_base|fixed_per_mile|tiered_schedule|index_linked|none`',
    `geographic_coverage` STRING COMMENT 'Geographic scope of the contract, e.g., North America, USA domestic, specific state/province list.',
    `insurance_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether the carrier is required to maintain specific cargo insurance coverage under this contract.',
    `insurance_minimum_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum cargo insurance coverage amount required from the carrier.',
    `last_modified_by_name` STRING COMMENT 'Name of the user who last modified this carrier contract record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier contract record was last updated.',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Minimum shipment volume (in commitment unit) that Manufacturing commits to tender to the carrier during the contract period.',
    `negotiation_date` DATE COMMENT 'Date when the contract terms were finalized and agreed upon by both parties.',
    `notes` STRING COMMENT 'Free-text notes capturing additional contract terms, special conditions, or operational instructions.',
    `on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'Contractual target percentage for on-time delivery performance, used for SLA compliance measurement.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the carrier, e.g., net_30, net_45, net_60.. Valid values are `^(net_[0-9]{1,3}|due_on_receipt|prepaid|cod)$`',
    `penalty_clause_description` STRING COMMENT 'Description of penalties applicable for service failures, late deliveries, or volume shortfalls.',
    `rate_adjustment_trigger` STRING COMMENT 'Conditions or events that trigger a rate adjustment, e.g., fuel price change exceeding 10%, volume variance exceeding 20%.',
    `rate_review_frequency` STRING COMMENT 'Frequency at which contract rates are reviewed and potentially adjusted.. Valid values are `monthly|quarterly|semi_annual|annual|on_demand|none`',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to prevent auto-renewal or to initiate renewal negotiation.',
    `service_level_standard` STRING COMMENT 'Guaranteed service level commitment, e.g., next-day delivery, 2-day delivery, standard ground.',
    `service_mode` STRING COMMENT 'Primary transportation mode covered by this contract. LTL (Less Than Truckload), FTL (Full Truckload).. Valid values are `LTL|FTL|parcel|intermodal|air_freight|ocean_freight`',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the contract.',
    `termination_reason` STRING COMMENT 'Reason for contract termination if status is terminated, e.g., poor performance, cost reduction, carrier exit.',
    `volume_commitment_unit` STRING COMMENT 'Unit of measure for the minimum volume commitment.. Valid values are `shipments|pallets|weight_kg|weight_lbs|revenue_usd`',
    CONSTRAINT pk_carrier_contract PRIMARY KEY(`carrier_contract_id`)
) COMMENT 'Negotiated rate and service agreement between Manufacturing and a carrier, serving as the single source of truth (SSOT) for ALL carrier pricing within the logistics domain — including contract rates, spot rates, and benchmark rates. Captures contract-level terms (effective/expiry dates, volume commitments, service level guarantees, penalty clauses, payment terms) and granular lane-level rate records (per cwt, per mile, per shipment, per pallet by origin-destination zone/postal code range, freight class, weight break, and service level). Includes fuel surcharge schedules, accessorial charge tables, rate basis (weight break/flat/distance), rate currency, rate effective date ranges, rate source classification (contract/spot/benchmark), minimum volume thresholds, and rate validity periods. Used by TMS for automated carrier selection, freight cost calculation, spot rate benchmarking, and freight invoice audit. No other entity in this domain stores rate data.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` (
    `freight_rate_id` BIGINT COMMENT 'Unique identifier for the freight rate record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier offering this rate.',
    `lane_id` BIGINT COMMENT 'Identifier of the transportation lane (origin-destination pair) for which this rate applies.',
    `accessorial_charges_applicable` BOOLEAN COMMENT 'Indicates whether additional accessorial charges (liftgate, inside delivery, residential delivery, etc.) may apply to shipments using this rate.',
    `base_rate` DECIMAL(18,2) COMMENT 'Base freight rate amount per unit as defined by rate_basis, before surcharges and adjustments.',
    `contract_number` STRING COMMENT 'Reference number of the carrier contract under which this rate is negotiated, if applicable.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the rate is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code_range_end` STRING COMMENT 'Ending postal code of the destination range for which this rate applies.',
    `destination_postal_code_range_start` STRING COMMENT 'Starting postal code of the destination range for which this rate applies.',
    `destination_zone_code` STRING COMMENT 'Geographic zone or postal code range identifier for the shipment destination covered by this rate.',
    `distance_max_km` DECIMAL(18,2) COMMENT 'Maximum distance in kilometers for which this rate applies, used in distance-based pricing.',
    `distance_min_km` DECIMAL(18,2) COMMENT 'Minimum distance in kilometers for which this rate applies, used in distance-based pricing.',
    `effective_end_date` DATE COMMENT 'Date on which this freight rate expires and is no longer valid for new shipments. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'Date from which this freight rate becomes effective and can be used for shipment cost calculation.',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this rate (e.g., dry van, refrigerated, flatbed, container size).',
    `freight_class` STRING COMMENT 'National Motor Freight Classification (NMFC) freight class code (e.g., 50, 55, 60, 65, 70, 77.5, 85, 92.5, 100, 110, 125, 150, 175, 200, 250, 300, 400, 500) determining rate based on density, handling, stowability, and liability.',
    `fuel_surcharge_percentage` DECIMAL(18,2) COMMENT 'Fuel surcharge percentage applied to the base rate to account for fuel cost fluctuations.',
    `hazmat_eligible` BOOLEAN COMMENT 'Indicates whether this rate is applicable to shipments containing hazardous materials.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge cap for a shipment under this rate, if applicable.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount for a shipment under this rate, regardless of weight or distance.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding special conditions, restrictions, or clarifications for this freight rate.',
    `origin_postal_code_range_end` STRING COMMENT 'Ending postal code of the origin range for which this rate applies.',
    `origin_postal_code_range_start` STRING COMMENT 'Starting postal code of the origin range for which this rate applies.',
    `origin_zone_code` STRING COMMENT 'Geographic zone or postal code range identifier for the shipment origin covered by this rate.',
    `rate_basis` STRING COMMENT 'Basis on which the rate is calculated: per hundredweight (cwt), per mile, per shipment, per pallet, per unit, or flat rate.. Valid values are `per_cwt|per_mile|per_shipment|per_pallet|per_unit|flat`',
    `rate_code` STRING COMMENT 'Business identifier or code for this freight rate, used for external reference and carrier communication.',
    `rate_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight rate record was first created in the system.',
    `rate_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight rate record was last modified in the system.',
    `rate_published_date` DATE COMMENT 'Date on which this rate was published or made available by the carrier.',
    `rate_source_system` STRING COMMENT 'Name of the source system or Transportation Management System (TMS) from which this rate was loaded or synchronized.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the freight rate record.. Valid values are `active|inactive|pending|expired`',
    `rate_type` STRING COMMENT 'Classification of the rate source: contract (negotiated agreement), spot (market rate), benchmark (industry standard), or tariff (published rate).. Valid values are `contract|spot|benchmark|tariff`',
    `service_level` STRING COMMENT 'Service level or speed tier offered by the carrier for this rate (standard, expedited, express, economy).. Valid values are `standard|expedited|express|economy`',
    `transit_time_days` STRING COMMENT 'Expected transit time in days for shipments using this rate and service level.',
    `transportation_mode` STRING COMMENT 'Mode of transportation for this rate: Less Than Truckload (LTL), Full Truckload (FTL), parcel, air freight, ocean freight, rail, or intermodal. [ENUM-REF-CANDIDATE: LTL|FTL|parcel|air|ocean|rail|intermodal — 7 candidates stripped; promote to reference product]',
    `volume_commitment_required` BOOLEAN COMMENT 'Indicates whether this rate requires a minimum volume commitment from the shipper.',
    `weight_break_max_kg` DECIMAL(18,2) COMMENT 'Maximum weight in kilograms for this rate tier in a weight-break pricing structure.',
    `weight_break_min_kg` DECIMAL(18,2) COMMENT 'Minimum weight in kilograms for this rate tier in a weight-break pricing structure.',
    CONSTRAINT pk_freight_rate PRIMARY KEY(`freight_rate_id`)
) COMMENT 'Granular freight rate record defining the cost per unit (per cwt, per mile, per shipment, per pallet) for a specific lane, carrier, mode, and service level combination. Captures origin and destination zone/postal code ranges, freight class, rate basis (weight break, flat, distance), base rate, fuel surcharge percentage, effective date range, rate source (contract/spot/benchmark), and currency. Used by TMS for automated carrier selection and freight cost calculation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Unique identifier for the freight invoice record. Primary key.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier contract governing rates, terms, and service levels for this shipment.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier who issued this freight invoice and provided the transportation service.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight invoices must be charged to a cost center for internal cost accounting and budgeting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Needed for generating customer‑facing freight invoices and finance reconciliation linking invoice to the customer account.',
    `node_id` BIGINT COMMENT 'Identifier of the shipment destination location (customer site, plant, warehouse, or distribution center).',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that performed the freight audit on this invoice.',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order that authorized this shipment. Used for three-way match validation (freight order vs BOL vs invoice).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Mapping freight expense to a GL account enables proper financial posting and audit trail.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Freight invoice reconciliation with the originating sales order ensures accurate financial matching and audit compliance.',
    `primary_freight_node_id` BIGINT COMMENT 'Identifier of the shipment origin location (supplier site, plant, warehouse, or distribution center).',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Three‑way match and project cost accounting require linking each freight invoice to the originating project.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight invoice must be matched to the PO for three‑way match, financial reconciliation, and variance analysis.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record that this invoice covers. Links invoice to physical goods movement.',
    `accessorial_charges` DECIMAL(18,2) COMMENT 'Additional charges for special services such as liftgate, inside delivery, residential delivery, detention, storage, or redelivery.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Final amount approved for payment after audit and dispute resolution. This is the amount that will be paid to the carrier.',
    `audit_completed_date` DATE COMMENT 'Date the freight audit and payment (FAP) process was completed for this invoice.',
    `audited_amount` DECIMAL(18,2) COMMENT 'Amount determined to be correct after freight audit and payment (FAP) process validation. May differ from invoiced amount due to rate discrepancies or billing errors.',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with this freight invoice. Used for three-way match validation and shipment traceability.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `customs_declaration_number` STRING COMMENT 'Customs declaration or entry number for international shipments. Required for cross-border freight audit and compliance.',
    `customs_duties` DECIMAL(18,2) COMMENT 'Customs duties and import/export fees charged for cross-border shipments. Applicable for international freight.',
    `delivery_date` DATE COMMENT 'Date the carrier delivered the shipment to the destination location.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Amount under dispute due to billing errors, service failures, or contract rate discrepancies. Subject to carrier negotiation and resolution.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance traveled for this shipment in kilometers. Used for mileage-based rate validation and route optimization analysis.',
    `freight_class` STRING COMMENT 'National Motor Freight Classification (NMFC) freight class assigned to the shipment. Determines LTL pricing based on density, handling, stowability, and liability.. Valid values are `^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$`',
    `fuel_surcharge` DECIMAL(18,2) COMMENT 'Variable fuel surcharge applied by carrier based on current fuel prices and agreed fuel surcharge schedule.',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the division of costs and responsibilities between buyer and seller for international shipments. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_date` DATE COMMENT 'Date the freight invoice was issued by the carrier. Principal business event timestamp for this transaction.',
    `invoice_number` STRING COMMENT 'Carrier-issued invoice number. Externally-known unique identifier for this freight invoice used for payment reconciliation and audit.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Total amount invoiced by the carrier, including line haul, fuel surcharge, accessorials, customs duties, and taxes. Gross invoice total.',
    `line_haul_charge` DECIMAL(18,2) COMMENT 'Base transportation charge for moving freight from origin to destination, excluding fuel surcharges and accessorial fees.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this freight invoice, including special handling instructions, dispute details, or audit findings.',
    `payment_date` DATE COMMENT 'Date payment was issued to the carrier. Null if invoice is not yet paid.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due to the carrier per agreed payment terms.',
    `payment_method` STRING COMMENT 'Method used to pay the carrier for this freight invoice (wire transfer, ACH, check, credit card, or prepaid account).. Valid values are `wire_transfer|ach|check|credit_card|prepaid`',
    `payment_reference_number` STRING COMMENT 'Payment transaction reference number or check number used for payment reconciliation and audit trail.',
    `payment_status` STRING COMMENT 'Current payment lifecycle status of the freight invoice. Tracks progression from receipt through approval, dispute, and payment.. Valid values are `pending|approved|paid|disputed|rejected|cancelled`',
    `pickup_date` DATE COMMENT 'Date the carrier picked up the shipment from the origin location.',
    `service_type` STRING COMMENT 'Type of transportation service provided: Less Than Truckload (LTL), Full Truckload (FTL), parcel, intermodal, air freight, ocean freight, or rail. [ENUM-REF-CANDIDATE: LTL|FTL|parcel|intermodal|air|ocean|rail — 7 candidates stripped; promote to reference product]',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the freight invoice (VAT, GST, sales tax) per applicable tax jurisdiction.',
    `three_way_match_status` STRING COMMENT 'Result of three-way match validation comparing freight order, bill of lading (BOL), and freight invoice. Matched indicates all three documents align; variance or failed indicates discrepancies requiring resolution.. Valid values are `matched|variance|failed|pending`',
    `transit_days` STRING COMMENT 'Number of days in transit from pickup to delivery. Used for carrier performance evaluation and SLA compliance tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight invoice record was last modified in the system.',
    `variance_reason` STRING COMMENT 'Explanation of discrepancies identified during three-way match or freight audit process (e.g., rate mismatch, weight discrepancy, unauthorized accessorials).',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters. Used for dimensional weight calculations and capacity planning.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms as recorded on the freight invoice. Used for rate validation and freight class determination.',
    CONSTRAINT pk_freight_invoice PRIMARY KEY(`freight_invoice_id`)
) COMMENT 'Carrier-issued freight invoice submitted for payment of transportation services rendered. Tracks invoice number, carrier ID, invoice date, payment due date, referenced freight orders and BOLs, invoiced charges (line haul, fuel surcharge, accessorials), audited amount, disputed amount, approved amount, payment status, and three-way match result (freight order vs. BOL vs. invoice). Feeds accounts payable in SAP FI and supports freight audit and payment (FAP) processes.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` (
    `transport_route_id` BIGINT COMMENT 'Unique identifier for the transport route. Primary key for the transport route entity.',
    `carrier_id` BIGINT COMMENT 'FK to logistics.carrier',
    `alternate_carrier_codes` STRING COMMENT 'Comma-separated list of alternate carrier codes that can be used for this route if the preferred carrier is unavailable or for load balancing.',
    `carbon_emission_factor_kg_per_km` DECIMAL(18,2) COMMENT 'Average carbon dioxide equivalent emissions per kilometer for this route, used for sustainability reporting and carbon footprint calculation.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard freight cost.. Valid values are `^[A-Z]{3}$`',
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
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a fuel surcharge is applicable to shipments on this route, based on carrier contract terms.',
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
    `secondary_transport_mode` STRING COMMENT 'Secondary or alternate mode of transportation for intermodal routes, if applicable.. Valid values are `road|rail|air|ocean|inland_waterway|pipeline`',
    `service_level` STRING COMMENT 'Service level classification for the route, defining speed and priority: express (fastest), standard (normal), economy (cost-optimized), dedicated (exclusive vehicle), or shared (consolidated shipments).. Valid values are `express|standard|economy|dedicated|shared`',
    `standard_freight_cost` DECIMAL(18,2) COMMENT 'Standard or baseline freight cost for this route in the companys reporting currency, used for budgeting and cost estimation.',
    `standard_transit_time_days` DECIMAL(18,2) COMMENT 'Expected transit time in days for shipments on this route under normal conditions, used for delivery promise calculation and planning.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether this route supports temperature-controlled (refrigerated or heated) transportation for sensitive goods.',
    CONSTRAINT pk_transport_route PRIMARY KEY(`transport_route_id`)
) COMMENT 'Defined transportation route or lane between an origin node (plant, DC, supplier) and a destination node (customer, DC, port), capturing route code, origin and destination location codes, primary transport mode, standard transit time (days), distance (km), preferred carrier, alternate carriers, route type (direct/relay/intermodal), seasonal restrictions, and route optimization parameters. Used by TMS for automated routing and load planning.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`node` (
    `node_id` BIGINT COMMENT 'Unique identifier for the logistics node. Primary key for the logistics node master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Node operating costs are allocated to a cost center; remove denormalized cost_center_code.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Node Management assigns a responsible employee to each logistics node, used in operational dashboards and incident response.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: PROCUREMENT_MASTER_PLAN records a primary supplier per node to drive sourcing decisions and allocation of purchase orders.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_site. Business justification: SUPPLIER_SITE_PLANNING uses logistics nodes to represent supplier locations; linking node to supplier_site enables routing and dock scheduling.',
    `address_line1` STRING COMMENT 'Primary street address line for the logistics node location. Organizational contact data classified as confidential.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential.',
    `carrier_access_restrictions` STRING COMMENT 'Description of any carrier access restrictions or requirements (e.g., pre-registration, security clearance, appointment-only).',
    `city` STRING COMMENT 'City or municipality where the logistics node is located. Organizational contact data classified as confidential.',
    `node_code` STRING COMMENT 'Business identifier code for the logistics node. Externally-known unique code used across TMS and ERP systems for network location identification.. Valid values are `^[A-Z0-9]{4,12}$`',
    `contact_email` STRING COMMENT 'Primary email address for the logistics node contact. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person or site manager for the logistics node.',
    `contact_phone` STRING COMMENT 'Primary phone number for the logistics node contact. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the logistics node location (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the logistics node record was first created in the system.',
    `customs_bonded_flag` BOOLEAN COMMENT 'Indicates whether the logistics node is a customs bonded warehouse authorized to store imported goods before duty payment.',
    `dock_door_count` STRING COMMENT 'Total number of loading/unloading dock doors available at the logistics node for capacity planning.',
    `effective_from_date` DATE COMMENT 'Date when the logistics node became operational and available for network routing.',
    `effective_to_date` DATE COMMENT 'Date when the logistics node was decommissioned or ceased operations. Null for currently active nodes.',
    `erp_location_code` STRING COMMENT 'Location code used in SAP S/4HANA or other ERP systems for material movement and inventory tracking.',
    `free_trade_zone_flag` BOOLEAN COMMENT 'Indicates whether the logistics node is located within a designated free trade zone or foreign trade zone.',
    `handling_equipment_available` STRING COMMENT 'Comma-separated list of material handling equipment types available at the node (e.g., forklift, crane, conveyor, automated_guided_vehicle).',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the node is certified to handle and store hazardous materials per regulatory requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the logistics node record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for GPS-based route optimization and geospatial analytics.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for GPS-based route optimization and geospatial analytics.',
    `max_vehicle_length_m` DECIMAL(18,2) COMMENT 'Maximum vehicle length in meters that can access the logistics node due to physical constraints (e.g., turning radius, gate clearance).',
    `max_vehicle_weight_kg` DECIMAL(18,2) COMMENT 'Maximum gross vehicle weight in kilograms permitted at the logistics node due to road or dock weight limits.',
    `node_name` STRING COMMENT 'Human-readable name of the logistics node (e.g., Chicago Distribution Center, Port of Hamburg Entry Point).',
    `network_tier` STRING COMMENT 'Hierarchical tier classification of the node within the distribution network strategy for routing optimization.. Valid values are `tier_1_hub|tier_2_regional|tier_3_local|tier_4_last_mile`',
    `node_status` STRING COMMENT 'Current operational status of the logistics node in the distribution network lifecycle.. Valid values are `active|inactive|under_construction|decommissioned|seasonal|temporary`',
    `node_type` STRING COMMENT 'Classification of the logistics node indicating its primary function in the distribution network. [ENUM-REF-CANDIDATE: manufacturing_plant|distribution_center|cross_dock|port_of_entry|customs_warehouse|customer_site|supplier_site — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or constraints related to the logistics node.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for weekdays in format HH:MM-HH:MM (e.g., 08:00-17:00) for delivery window planning.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for weekends in format HH:MM-HH:MM. Null if node does not operate on weekends.',
    `ownership_type` STRING COMMENT 'Classification of the logistics node ownership model for cost allocation and network strategy.. Valid values are `owned|leased|third_party_logistics|contract_warehouse`',
    `port_access_flag` BOOLEAN COMMENT 'Indicates whether the logistics node has direct access to maritime port facilities for ocean freight.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the logistics node address. Organizational contact data classified as confidential.',
    `rail_access_flag` BOOLEAN COMMENT 'Indicates whether the logistics node has direct rail siding access for intermodal freight operations.',
    `state_province` STRING COMMENT 'State, province, or regional administrative division for the logistics node location. Organizational contact data classified as confidential.',
    `storage_capacity_sqm` DECIMAL(18,2) COMMENT 'Total indoor storage capacity in square meters for inventory planning and network optimization.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the node has temperature-controlled storage facilities for cold chain logistics.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the logistics node location (e.g., America/Chicago, Europe/Berlin) used for delivery appointment scheduling.',
    `tms_location_code` STRING COMMENT 'External identifier used by the Transportation Management System to reference this logistics node.',
    `yard_capacity_trailers` STRING COMMENT 'Maximum number of trailers that can be staged in the yard simultaneously for yard management and detention planning.',
    CONSTRAINT pk_node PRIMARY KEY(`node_id`)
) COMMENT 'Master record for all physical nodes in the distribution network — manufacturing plants, distribution centers, cross-dock facilities, ports of entry, customs bonded warehouses, customer delivery points, and supplier pickup locations. Captures node code, node type, address, GPS coordinates, operating hours, dock door count, handling equipment available, customs bonded status, free trade zone flag, TMS location ID, and yard capacity. Serves as the SSOT for network location data within the logistics domain and the reference entity for transport route origin/destination definitions and delivery appointment scheduling.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` (
    `shipment_tracking_event_id` BIGINT COMMENT 'Unique identifier for the shipment tracking event record.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier reporting this event.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment being tracked.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment was delivered (populated only for delivered events).',
    `bill_of_lading_number` STRING COMMENT 'Bill of Lading number associated with the shipment.',
    `carrier_status_code` STRING COMMENT 'Carrier-specific status code reported for this event (e.g., X1, D1, AF, etc.).',
    `carrier_status_description` STRING COMMENT 'Human-readable description of the carrier status code.',
    `container_number` STRING COMMENT 'ISO container number for ocean or intermodal shipments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tracking event record was first created in the system.',
    `customs_clearance_flag` BOOLEAN COMMENT 'Indicates whether the event represents a customs clearance checkpoint for international shipments.',
    `customs_entry_number` STRING COMMENT 'Customs entry number assigned by customs authorities for international shipments.',
    `data_received_timestamp` TIMESTAMP COMMENT 'Timestamp when the tracking event data was received by the Transportation Management System (TMS) or data platform.',
    `data_source` STRING COMMENT 'Source system or method from which the tracking event was captured (EDI 214, carrier API, IoT/telematics, manual entry, TMS).. Valid values are `edi_214|carrier_api|iot_telematics|manual_entry|tms`',
    `delay_duration_hours` DECIMAL(18,2) COMMENT 'Duration of delay in hours if the event represents a delay or exception.',
    `estimated_delivery_date` DATE COMMENT 'Updated estimated delivery date if the shipment has been rescheduled due to delay or exception.',
    `estimated_delivery_time` TIMESTAMP COMMENT 'Updated estimated delivery timestamp with time precision if available from carrier.',
    `event_city` STRING COMMENT 'City where the tracking event occurred.',
    `event_country_code` STRING COMMENT 'Three-letter ISO country code where the tracking event occurred.. Valid values are `^[A-Z]{3}$`',
    `event_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the event location.',
    `event_location_name` STRING COMMENT 'Name of the facility, terminal, or location where the event occurred.',
    `event_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the event location.',
    `event_notes` STRING COMMENT 'Free-text notes or comments provided by the carrier or logistics personnel regarding the event.',
    `event_postal_code` STRING COMMENT 'Postal code of the location where the tracking event occurred.',
    `event_sequence_number` STRING COMMENT 'Sequential order of this event within the shipment lifecycle.',
    `event_state_province` STRING COMMENT 'State or province where the tracking event occurred.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the tracking event occurred in the shipment lifecycle.',
    `event_type` STRING COMMENT 'Type of tracking event captured (pickup, in-transit, out-for-delivery, delivered, exception, delay).. Valid values are `pickup|in_transit|out_for_delivery|delivered|exception|delay`',
    `exception_reason_code` STRING COMMENT 'Code indicating the reason for an exception or delay event (e.g., weather, customs hold, address issue).',
    `exception_reason_description` STRING COMMENT 'Detailed description of the exception or delay reason.',
    `humidity_reading` DECIMAL(18,2) COMMENT 'Humidity percentage reading captured at the time of the event for sensitive shipments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tracking event record was last modified.',
    `on_time_flag` BOOLEAN COMMENT 'Indicates whether the event occurred within the expected time window per the Service Level Agreement (SLA).',
    `pro_number` STRING COMMENT 'Progressive number assigned by LTL (Less Than Truckload) carriers for shipment identification.',
    `recipient_name` STRING COMMENT 'Name of the person who received the shipment (for delivered events).',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or trailer.',
    `signature_obtained_flag` BOOLEAN COMMENT 'Indicates whether a signature was obtained at delivery.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether a signature was required for delivery.',
    `temperature_reading` DECIMAL(18,2) COMMENT 'Temperature reading captured at the time of the event for temperature-controlled shipments (in Celsius).',
    `tracking_number` STRING COMMENT 'Carrier-assigned tracking number for the shipment.',
    `trailer_number` STRING COMMENT 'Trailer or truck unit number transporting the shipment.',
    CONSTRAINT pk_shipment_tracking_event PRIMARY KEY(`shipment_tracking_event_id`)
) COMMENT 'Real-time or near-real-time tracking event captured for a shipment in transit, recording event type (pickup, in-transit, out-for-delivery, delivered, exception, delay), event timestamp, event location (city, state, country, GPS coordinates), carrier-reported status code, exception reason (if applicable), estimated new delivery date (if rescheduled), and data source (EDI 214, carrier API, IoT/telematics, manual entry). Enables end-to-end shipment visibility and on-time delivery monitoring.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` (
    `customs_declaration_id` BIGINT COMMENT 'Unique identifier for the customs declaration record. Primary key.',
    `customs_broker_id` BIGINT COMMENT 'Reference to the licensed customs broker handling the declaration and clearance process.',
    `employee_id` BIGINT COMMENT 'Reference to the compliance officer responsible for reviewing and approving this declaration.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment associated with this customs declaration.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Ensures HS code, origin, and compliance data are tied to the exact SKU; required for export/import regulatory reporting.',
    `applicable_regulations` STRING COMMENT 'Comma-separated list of applicable export control and trade compliance regulations (e.g., EAR, ITAR, EU Dual-Use, OFAC).',
    `bond_number` STRING COMMENT 'Customs bond or guarantee number securing payment of duties and compliance with regulations.',
    `clearance_date` DATE COMMENT 'Date when customs authority granted clearance and released the goods.',
    `compliance_review_date` DATE COMMENT 'Date when the compliance officer completed the trade compliance review.',
    `compliance_screening_outcome` STRING COMMENT 'Final outcome of the comprehensive trade compliance screening workflow.. Valid values are `cleared|flagged|blocked|escalated`',
    `consignee_name` STRING COMMENT 'Name of the party receiving the goods at destination.',
    `consignor_name` STRING COMMENT 'Name of the party shipping the goods from origin.',
    `country_of_destination` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the final destination country for the goods.. Valid values are `^[A-Z]{3}$`',
    `country_of_export` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country from which goods are being exported.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the goods were manufactured or produced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the customs declaration record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the declared value.. Valid values are `^[A-Z]{3}$`',
    `declaration_number` STRING COMMENT 'Official customs declaration number issued by customs authority. Externally-known unique identifier for this declaration.',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the customs declaration in the clearance workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|cleared|held|rejected|released — 7 candidates stripped; promote to reference product]',
    `declaration_type` STRING COMMENT 'Type of customs declaration indicating the nature of cross-border movement.. Valid values are `import|export|transit|re-export|temporary_admission|inward_processing`',
    `declared_value` DECIMAL(18,2) COMMENT 'Total declared customs value of the goods in the specified currency.',
    `denied_party_screening_result` STRING COMMENT 'Outcome of screening against denied parties lists, sanctioned entities, and restricted party databases.. Valid values are `cleared|flagged|blocked|pending`',
    `dual_use_classification` STRING COMMENT 'Classification determination for goods that have both civilian and military applications.',
    `duty_amount` DECIMAL(18,2) COMMENT 'Total customs duty assessed and payable on the imported or exported goods.',
    `eccn` STRING COMMENT 'Export Control Classification Number assigned under the Commerce Control List for dual-use items.',
    `embargo_check_result` STRING COMMENT 'Result of screening against embargoed countries and restricted destinations.. Valid values are `cleared|flagged|blocked`',
    `entry_date` DATE COMMENT 'Date when the goods entered the customs territory or when the declaration was lodged with customs authority.',
    `export_license_number` STRING COMMENT 'Government-issued export license number authorizing the export of controlled goods.',
    `exporter_of_record` STRING COMMENT 'Legal entity responsible for ensuring exported goods comply with export regulations and licensing requirements.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment including packaging, measured in kilograms.',
    `hold_reason` STRING COMMENT 'Detailed explanation of why the shipment is under regulatory hold.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the goods. Primary classification for customs duty calculation.',
    `import_license_number` STRING COMMENT 'Government-issued import license number authorizing the import of controlled or restricted goods.',
    `importer_of_record` STRING COMMENT 'Legal entity responsible for ensuring imported goods comply with local laws and for paying duties and taxes.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, risk, and cost. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `license_type` STRING COMMENT 'Type of export or import license required (e.g., individual, blanket, temporary, general).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the customs declaration record was last modified.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the goods excluding packaging, measured in kilograms.',
    `number_of_packages` STRING COMMENT 'Total count of packages, cartons, or containers in the shipment.',
    `package_type` STRING COMMENT 'Type of packaging used for the shipment (e.g., pallet, carton, crate, container).',
    `port_of_entry` STRING COMMENT 'Customs port or border crossing where the goods entered the destination country.',
    `port_of_exit` STRING COMMENT 'Customs port or border crossing where the goods exited the origin country.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether the shipment is under regulatory hold pending additional review or documentation.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution of compliance issues, holds, or flagged items.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total of all taxes, duties, and fees assessed on this customs declaration.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for the cross-border shipment.. Valid values are `air|sea|road|rail|multimodal`',
    `vat_amount` DECIMAL(18,2) COMMENT 'Value Added Tax or Goods and Services Tax assessed on the imported goods.',
    CONSTRAINT pk_customs_declaration PRIMARY KEY(`customs_declaration_id`)
) COMMENT 'Customs and trade compliance master document for cross-border shipments, serving as the SSOT for ALL customs declarations AND trade compliance screening within the logistics domain. Captures declaration number, declaration type (import/export/transit), shipment reference, country of origin, country of destination, HS tariff codes, declared value, currency, incoterms, customs broker ID, entry date, customs clearance status, duty amount, VAT amount, bond number, export license number, regulatory hold flags. Embeds full compliance screening workflow: denied party screening results, export control classification (ECCN), applicable regulations (EAR, ITAR, EU Dual-Use), screening outcome (cleared/flagged/blocked), compliance officer ID, resolution notes, license type and number, embargo check results, and dual-use classification determinations. No other entity in this domain stores trade compliance or export control screening data.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` (
    `load_plan_id` BIGINT COMMENT 'Unique identifier for the load plan record. Primary key for the load plan entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Load planning expenses are charged to a cost center for OPEX tracking.',
    `node_id` BIGINT COMMENT 'Identifier of the warehouse, plant, distribution center, or customer site to which the load is destined.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier or logistics service provider selected to execute this load plan.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created this load plan record, used for audit trail and accountability.',
    `primary_load_node_id` BIGINT COMMENT 'Identifier of the warehouse, plant, or distribution center from which the load originates.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Load Planning for a project’s equipment shipment must reference the project to coordinate schedules and resources.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Tie a load plan to the shipment it is planning, enabling direct navigation from load plan to shipment.',
    `transport_route_id` BIGINT COMMENT 'Identifier of the planned transportation route associated with this load plan, linking to route optimization and network planning.',
    `actual_load_date` DATE COMMENT 'The actual date when the load was physically assembled and loaded, used for performance tracking against planned date.',
    `bill_of_lading_number` STRING COMMENT 'The unique identifier of the bill of lading document issued for this load, serving as the legal contract of carriage and receipt.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `carrier_service_level` STRING COMMENT 'The service level agreement tier selected for this load, determining transit time commitments and handling requirements.. Valid values are `standard|expedited|express|economy|white_glove`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this load plan record was first created in the system, used for audit trail and lifecycle tracking.',
    `customs_required` BOOLEAN COMMENT 'Indicates whether this load requires customs clearance due to cross-border transportation, triggering documentation and compliance workflows.',
    `dock_door_assignment` STRING COMMENT 'The specific dock door or loading bay assigned for loading this shipment at the origin facility, used for warehouse execution coordination.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `estimated_delivery_date` DATE COMMENT 'The estimated date when the load is expected to arrive at the destination facility, calculated from planned departure and transit time.',
    `estimated_freight_cost` DECIMAL(18,2) COMMENT 'The estimated total freight cost for this load plan based on carrier rates, distance, weight, and service level. Used for cost planning and budget tracking.',
    `estimated_transit_time_hours` STRING COMMENT 'The estimated total transit time from origin to destination in hours, used for delivery promise calculation and customer communication.',
    `freight_cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the estimated freight cost, supporting multi-currency logistics operations.. Valid values are `^[A-Z]{3}$`',
    `hazmat_class` STRING COMMENT 'The UN hazard class code for hazardous materials in this load, used for regulatory compliance and carrier certification requirements.. Valid values are `^[1-9](.[1-9])?$`',
    `incoterms_code` STRING COMMENT 'The Incoterms code defining the division of costs and responsibilities between buyer and seller for international shipments in this load. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this load plan record was last modified, used for audit trail and data currency tracking.',
    `load_optimization_method` STRING COMMENT 'The method used to build and optimize this load plan, indicating the level of automation and sophistication in load planning.. Valid values are `manual|rule_based|algorithm|ai_ml`',
    `load_plan_number` STRING COMMENT 'Business identifier for the load plan, externally visible and used for tracking and communication with carriers and warehouse teams.. Valid values are `^LP-[0-9]{8,12}$`',
    `load_plan_status` STRING COMMENT 'Current lifecycle status of the load plan indicating its progression through planning, execution, and completion stages.. Valid values are `draft|confirmed|in_progress|executed|cancelled|closed`',
    `load_sequence_number` STRING COMMENT 'The sequential order in which this load plan is scheduled within a batch of loads for the same route or time window, used for dock scheduling.',
    `loading_end_time` TIMESTAMP COMMENT 'The scheduled or actual timestamp when loading operations were completed for this load plan, used for cycle time analysis and efficiency tracking.',
    `loading_start_time` TIMESTAMP COMMENT 'The scheduled or actual timestamp when loading operations began for this load plan, used for labor tracking and performance measurement.',
    `number_of_handling_units` STRING COMMENT 'The total count of handling units (cartons, crates, drums, etc.) included in this load plan, used for labor planning and tracking.',
    `number_of_pallets` STRING COMMENT 'The total count of pallets included in this load plan, used for loading sequence planning and warehouse space allocation.',
    `number_of_shipments` STRING COMMENT 'The count of individual shipment records consolidated into this load plan, used for LTL consolidation tracking and load complexity assessment.',
    `planned_departure_timestamp` TIMESTAMP COMMENT 'The scheduled date and time when the loaded vehicle or container is planned to depart from the origin facility.',
    `planned_load_date` DATE COMMENT 'The scheduled date when the load is planned to be assembled and loaded onto the transport vehicle or container.',
    `priority_level` STRING COMMENT 'The business priority assigned to this load plan, influencing carrier selection, routing decisions, and resource allocation.. Valid values are `low|normal|high|urgent|critical`',
    `requires_hazmat_handling` BOOLEAN COMMENT 'Indicates whether this load contains hazardous materials requiring special handling, documentation, and certified carriers.',
    `requires_temperature_control` BOOLEAN COMMENT 'Indicates whether this load requires temperature-controlled transportation (refrigerated or heated) to maintain product integrity.',
    `seal_number` STRING COMMENT 'The unique identifier of the security seal applied to the loaded container or trailer, used for tamper detection and chain of custody.. Valid values are `^[A-Z0-9]{6,20}$`',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on load size and carrier service type. LTL indicates consolidated shipments sharing vehicle space; FTL indicates exclusive use of vehicle capacity.. Valid values are `LTL|FTL|parcel|express|dedicated`',
    `special_instructions` STRING COMMENT 'Free-text field capturing any special handling, loading, or delivery instructions that must be communicated to warehouse staff and carriers.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'The maximum acceptable temperature in Celsius for temperature-controlled loads, used for carrier selection and compliance monitoring.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'The minimum acceptable temperature in Celsius for temperature-controlled loads, used for carrier selection and compliance monitoring.',
    `total_planned_volume_m3` DECIMAL(18,2) COMMENT 'The total planned volume of all shipments and materials consolidated into this load, measured in cubic meters, used for cube utilization optimization.',
    `total_planned_weight_kg` DECIMAL(18,2) COMMENT 'The total planned weight of all shipments and materials consolidated into this load, measured in kilograms, used for capacity planning and compliance.',
    `transport_mode` STRING COMMENT 'The primary mode of transportation used for this load plan, determining routing and carrier selection strategies.. Valid values are `road|rail|air|ocean|intermodal|parcel`',
    `vehicle_type` STRING COMMENT 'The type of vehicle or container required for this load, based on cargo characteristics and transportation requirements. [ENUM-REF-CANDIDATE: dry_van|refrigerated|flatbed|tanker|container_20ft|container_40ft|box_truck — 7 candidates stripped; promote to reference product]',
    `volume_utilization_percentage` DECIMAL(18,2) COMMENT 'The percentage of vehicle or container volume capacity utilized by this load plan, calculated as (total planned volume / vehicle volume capacity) * 100. Also known as cube utilization.',
    `weight_utilization_percentage` DECIMAL(18,2) COMMENT 'The percentage of vehicle or container weight capacity utilized by this load plan, calculated as (total planned weight / vehicle weight capacity) * 100.',
    CONSTRAINT pk_load_plan PRIMARY KEY(`load_plan_id`)
) COMMENT 'Load planning record created during shipment consolidation and load building, capturing load plan number, planned load date, origin facility, transport mode, vehicle/container type, planned carrier, total planned weight, total planned volume, utilization percentage, number of shipments consolidated, load sequence, and load plan status (draft/confirmed/executed). Supports LTL consolidation, FTL optimization, and cube utilization management.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` (
    `delivery_appointment_id` BIGINT COMMENT 'Unique identifier for the delivery appointment record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier or logistics service provider responsible for the shipment. Links to carrier master data for performance tracking and contract compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Delivery Appointment Management assigns an internal driver (employee) to each appointment, needed for dispatch planning and labor costing.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Delivery appointments are scheduled based on a sales order; linking supports SLA monitoring and order‑to‑appointment traceability.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Delivery Appointment scheduling reports tie appointments to the project to monitor on‑site delivery performance.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Delivery appointments are scheduled for PO deliveries; linking supports dock scheduling and PO fulfillment status.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this appointment. Links the dock appointment to the broader transportation execution and order fulfillment process.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, or plant facility where the appointment is scheduled. Links to facility master data for location-specific dock scheduling rules.',
    `actual_arrival_time` TIMESTAMP COMMENT 'Actual date and time when the carrier vehicle arrived at the facility gate or dock area. Used to calculate wait time, on-time performance, and dock utilization metrics.',
    `actual_departure_time` TIMESTAMP COMMENT 'Actual date and time when the carrier vehicle departed the facility after completing loading or unloading operations. Used to calculate dwell time and dock turnaround efficiency.',
    `appointment_created_by` STRING COMMENT 'Username or identifier of the person or system that created the appointment record. Used for audit trail and accountability.',
    `appointment_created_timestamp` TIMESTAMP COMMENT 'Date and time when the appointment record was first created in the system. Used for audit trail and appointment lead time analysis.',
    `appointment_modified_by` STRING COMMENT 'Username or identifier of the person or system that last modified the appointment record. Used for audit trail and change tracking.',
    `appointment_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the appointment record was last updated. Used for audit trail and tracking appointment changes or rescheduling.',
    `appointment_number` STRING COMMENT 'Business-facing unique appointment number used for scheduling and tracking. Externally visible identifier for dock scheduling systems and carrier communications.. Valid values are `^[A-Z0-9]{8,20}$`',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the delivery appointment. Scheduled when initially created, confirmed when carrier acknowledges, checked-in when vehicle arrives at gate, in-progress during loading/unloading, completed when finished, missed if carrier no-show, cancelled if appointment voided. [ENUM-REF-CANDIDATE: scheduled|confirmed|checked_in|in_progress|completed|missed|cancelled — 7 candidates stripped; promote to reference product]',
    `appointment_type` STRING COMMENT 'Classification of the appointment direction and purpose. Inbound for receiving materials from suppliers, outbound for shipping finished goods to customers, cross-dock for direct transfer, return for RMA processing, transfer for inter-facility movement, pickup for carrier collection.. Valid values are `inbound|outbound|cross_dock|return|transfer|pickup`',
    `bill_of_lading_number` STRING COMMENT 'Unique identifier of the bill of lading document associated with this appointment. Legal document serving as receipt of goods and contract of carriage.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the appointment was cancelled. Used for root cause analysis of scheduling disruptions and carrier performance issues.',
    `check_in_time` TIMESTAMP COMMENT 'Date and time when the carrier checked in at the facility reception or guard gate. Marks the official start of the appointment process and triggers dock assignment workflow.',
    `customs_entry_number` STRING COMMENT 'Customs entry or declaration number for international shipments. Required for import/export compliance and duty payment tracking.',
    `customs_required_flag` BOOLEAN COMMENT 'Indicates whether the shipment requires customs clearance for international trade. True for cross-border shipments, false for domestic movements.',
    `dock_door_number` STRING COMMENT 'Physical dock door or bay identifier assigned to this appointment. Used by warehouse management systems and yard management systems to direct carriers to the correct loading/unloading location.. Valid values are `^[A-Z0-9-]{1,10}$`',
    `driver_license_number` STRING COMMENT 'Government-issued driver license number of the vehicle operator. Required for facility access control, insurance verification, and regulatory compliance.',
    `driver_name` STRING COMMENT 'Full name of the driver operating the vehicle for this appointment. Captured for security, safety compliance, and delivery verification purposes.',
    `driver_phone_number` STRING COMMENT 'Contact phone number for the driver. Used for real-time communication regarding appointment changes, dock assignments, or delivery issues.',
    `dwell_time_minutes` STRING COMMENT 'Total time in minutes the vehicle spent at the facility from arrival to departure. Used to measure dock turnaround efficiency and identify bottlenecks in loading/unloading operations.',
    `facility_location_code` STRING COMMENT 'Business location code identifying the specific plant, distribution center, or warehouse site. Used for multi-site logistics network management and reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `load_type` STRING COMMENT 'Method of loading or unloading operation. Live load/unload means driver waits while cargo is handled, drop trailer means trailer is left for later processing, drop-and-hook means simultaneous trailer exchange.. Valid values are `live_load|drop_trailer|live_unload|drop_and_hook`',
    `notes` STRING COMMENT 'General free-text field for additional comments, observations, or instructions related to the appointment. Used for operational communication and issue documentation.',
    `priority_level` STRING COMMENT 'Business priority classification for the appointment. Urgent for expedited shipments, high for time-sensitive deliveries, normal for standard operations, low for flexible scheduling.. Valid values are `urgent|high|normal|low`',
    `requires_hazmat_handling_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling, documentation, and safety protocols per DOT and OSHA regulations.',
    `requires_refrigeration_flag` BOOLEAN COMMENT 'Indicates whether the shipment requires temperature-controlled handling. True for cold chain logistics, false for ambient temperature cargo.',
    `sales_order_number` STRING COMMENT 'Sales order number for outbound appointments shipping finished goods to customers. Links the delivery to order management and accounts receivable processes.',
    `scheduled_date` DATE COMMENT 'Calendar date on which the delivery or pickup appointment is scheduled to occur. Used for day-level dock capacity planning and resource allocation.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Precise date and time when the appointment window closes. Defines the latest time by which loading or unloading operations should be completed to maintain dock schedule integrity.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise date and time when the appointment window begins. Defines the earliest time the carrier should arrive at the dock door for loading or unloading operations.',
    `seal_number` STRING COMMENT 'Unique identifier of the security seal applied to the trailer or container. Used for cargo security, customs compliance, and tamper detection.',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special requirements or instructions for the appointment such as hazardous materials handling, temperature control, security protocols, or equipment needs.',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or container being loaded or unloaded. Used for yard spotting, asset tracking, and cross-docking operations.',
    `vehicle_license_plate` STRING COMMENT 'Government-issued license plate number of the vehicle. Used for yard management, security tracking, and facility access control.',
    `vehicle_type` STRING COMMENT 'Classification of the transportation vehicle used for the delivery or pickup. FTL (Full Truckload) for dedicated loads, LTL (Less Than Truckload) for consolidated shipments, specialized types for specific cargo requirements. [ENUM-REF-CANDIDATE: ftl_truck|ltl_truck|box_truck|flatbed|tanker|refrigerated|intermodal_container|van — 8 candidates stripped; promote to reference product]',
    `wait_time_minutes` STRING COMMENT 'Total time in minutes between carrier arrival and start of loading/unloading operations. Key performance indicator for dock efficiency and carrier service level agreements.',
    CONSTRAINT pk_delivery_appointment PRIMARY KEY(`delivery_appointment_id`)
) COMMENT 'Scheduled delivery or pickup appointment at a logistics node (plant dock, DC, customer facility), capturing appointment number, appointment type (inbound/outbound), scheduled date and time window, dock door assignment, carrier and driver details, vehicle type and license plate, appointment status (scheduled/confirmed/checked-in/completed/missed/cancelled), actual arrival and departure times, and wait time. Supports dock scheduling and yard management.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` (
    `dangerous_goods_declaration_id` BIGINT COMMENT 'Unique identifier for the dangerous goods declaration record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DG Declaration Preparation must be signed off by a qualified employee, required for regulatory compliance and audit trails.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment containing the dangerous goods.',
    `applicable_regulation` STRING COMMENT 'Primary regulatory framework governing this dangerous goods shipment (IATA DGR for air, IMDG for ocean, DOT 49 CFR for US road, ADR for European road, RID for rail).. Valid values are `IATA_DGR|IMDG|DOT_49CFR|ADR|RID`',
    `authorization_reference` STRING COMMENT 'Reference number of any special authorization, approval, or exemption granted by the competent authority for this dangerous goods shipment.',
    `cargo_aircraft_only_flag` BOOLEAN COMMENT 'Indicates whether the dangerous goods are restricted to cargo aircraft only and prohibited on passenger aircraft per IATA DGR.',
    `competent_authority` STRING COMMENT 'Name of the regulatory authority that issued any special authorization or approval for this dangerous goods shipment.',
    `consignee_address` STRING COMMENT 'Full address of the consignee receiving the dangerous goods.',
    `consignee_name` STRING COMMENT 'Legal name of the organization or individual receiving the dangerous goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dangerous goods declaration record was first created in the system.',
    `declaration_approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved the dangerous goods declaration for shipment.',
    `declaration_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods declaration was approved.',
    `declaration_number` STRING COMMENT 'Unique externally-known dangerous goods declaration number issued for regulatory tracking and compliance.',
    `declaration_prepared_by` STRING COMMENT 'Name or identifier of the person who prepared the dangerous goods declaration.',
    `declaration_prepared_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods declaration was prepared.',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the dangerous goods declaration.. Valid values are `draft|submitted|approved|rejected|expired|cancelled`',
    `emergency_contact_name` STRING COMMENT 'Name of the person or organization to contact in case of emergency during transport of dangerous goods.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency response telephone number for incidents involving the dangerous goods.',
    `excepted_quantity_flag` BOOLEAN COMMENT 'Indicates whether the dangerous goods qualify for excepted quantity provisions allowing further regulatory relief.',
    `expiry_date` DATE COMMENT 'Date on which the dangerous goods declaration expires and is no longer valid for shipment.',
    `flash_point_celsius` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors of the substance will ignite when exposed to an ignition source, measured in degrees Celsius. Required for flammable liquids.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the dangerous goods including packaging, measured in kilograms.',
    `hazard_class` STRING COMMENT 'Primary hazard classification of the dangerous goods (e.g., explosives, flammable liquids, toxic substances, corrosives). [ENUM-REF-CANDIDATE: 1|1.1|1.2|1.3|1.4|1.5|1.6|2.1|2.2|2.3|3|4.1|4.2|4.3|5.1|5.2|6.1|6.2|7|8|9 — promote to reference product]. Valid values are `1|1.1|1.2|1.3|1.4|1.5|1.6|2.1|2.2|2.3|3|4.1|4.2|4.3|5.1|5.2|6.1|6.2|7|8|9`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this dangerous goods declaration record was last modified.',
    `limited_quantity_flag` BOOLEAN COMMENT 'Indicates whether the dangerous goods qualify for limited quantity exemptions allowing relaxed packaging and labeling requirements.',
    `marine_pollutant_flag` BOOLEAN COMMENT 'Indicates whether the dangerous goods are classified as a marine pollutant per IMDG Code.',
    `net_quantity` DECIMAL(18,2) COMMENT 'Net quantity of the dangerous goods excluding packaging weight.',
    `net_quantity_uom` STRING COMMENT 'Unit of measure for the net quantity (kilograms, liters, grams, etc.).. Valid values are `kg|L|g|mL|lbs|gal`',
    `number_of_packages` STRING COMMENT 'Total count of packages containing the dangerous goods in this declaration.',
    `packaging_instruction` STRING COMMENT 'Specific packaging instruction code from the applicable dangerous goods regulation (e.g., P001, IBC02, LP02).',
    `packaging_type` STRING COMMENT 'Type of packaging used for the dangerous goods (e.g., drum, box, cylinder, IBC).',
    `packing_group` STRING COMMENT 'Degree of danger presented by the substance: I (high danger), II (medium danger), III (low danger).. Valid values are `I|II|III`',
    `proper_shipping_name` STRING COMMENT 'Official technical name of the dangerous goods as specified in regulatory dangerous goods lists (IATA, IMDG, DOT).',
    `remarks` STRING COMMENT 'Additional remarks, handling instructions, or special notes related to the dangerous goods declaration.',
    `shipper_address` STRING COMMENT 'Full address of the shipper of the dangerous goods.',
    `shipper_certification_date` DATE COMMENT 'Date on which the shipper certified the dangerous goods declaration.',
    `shipper_certification_signature` STRING COMMENT 'Digital signature or name of the authorized person who certified the dangerous goods declaration on behalf of the shipper.',
    `shipper_certification_statement` STRING COMMENT 'Regulatory-required certification statement signed by the shipper attesting that the dangerous goods are properly classified, packaged, marked, and labeled.',
    `shipper_name` STRING COMMENT 'Legal name of the organization or individual shipping the dangerous goods.',
    `special_provisions` STRING COMMENT 'Special provision codes or exemptions applicable to this dangerous goods shipment as specified in the regulation.',
    `subsidiary_hazard_class` STRING COMMENT 'Secondary hazard classification if the dangerous goods exhibit multiple hazardous properties.',
    `technical_name` STRING COMMENT 'Chemical or technical name of the dangerous goods constituent, required when the proper shipping name is a generic N.O.S. (not otherwise specified) entry.',
    `transport_mode` STRING COMMENT 'Mode of transportation for which this dangerous goods declaration is prepared (air, ocean, road, rail, multimodal).. Valid values are `air|ocean|road|rail|multimodal`',
    `un_number` STRING COMMENT 'Four-digit UN identification number assigned to the hazardous substance per UN Recommendations on the Transport of Dangerous Goods.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_dangerous_goods_declaration PRIMARY KEY(`dangerous_goods_declaration_id`)
) COMMENT 'Hazardous materials / dangerous goods declaration required for shipments containing regulated substances (chemicals, batteries, compressed gases). Captures DG declaration number, UN number, proper shipping name, hazard class and packing group, net quantity, gross quantity, packaging type, emergency contact information, shipper certification, transport mode-specific compliance (IATA DGR for air, IMDG for ocean, DOT 49 CFR for road), and special provisions. Ensures regulatory compliance for hazmat transport.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` (
    `freight_claim_id` BIGINT COMMENT 'Unique identifier for the freight claim record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Freight Claim processing assigns an adjuster employee, needed for claim tracking, accountability, and cost analysis.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier against whom the claim is filed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight claim settlements need cost center allocation for expense reconciliation.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Enables claim processing to attribute liability and settlements to the correct customer account.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Freight claim processing references the original sales order to determine liability, compensation, and financial impact.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Freight Claim settlement process allocates claim amounts to the responsible project for financial reconciliation.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight claim is filed against a shipment generated for a PO; linking enables claim processing and PO cost variance reporting.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this freight claim.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Connects freight damage claims to the affected SKU; enables claim analysis, warranty cost tracking, and root‑cause reporting.',
    `assigned_adjuster_email` STRING COMMENT 'Email address of the carrier claims adjuster handling this claim.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assigned_adjuster_name` STRING COMMENT 'Name of the claims adjuster or handler assigned by the carrier to review and process this claim.',
    `bol_number` STRING COMMENT 'Bill of Lading number that serves as the contract of carriage and receipt for the goods. Critical document reference for claim substantiation.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `carrier_response_date` DATE COMMENT 'Date when the carrier formally acknowledged or responded to the freight claim. Used to track carrier compliance with response time requirements.',
    `claim_number` STRING COMMENT 'Externally-known unique claim reference number assigned by the claimant or carrier for tracking and correspondence.. Valid values are `^CLM-[0-9]{8,12}$`',
    `claim_status` STRING COMMENT 'Current lifecycle state of the freight claim in the resolution workflow. [ENUM-REF-CANDIDATE: filed|acknowledged|under_review|pending_documentation|settled|denied|escalated|withdrawn — 8 candidates stripped; promote to reference product]',
    `claim_type` STRING COMMENT 'Classification of the freight claim based on the nature of the incident: loss (goods missing), damage (goods harmed), shortage (quantity discrepancy), delay (late delivery), concealed damage (damage discovered after delivery), or refused shipment.. Valid values are `loss|damage|shortage|delay|concealed_damage|refused_shipment`',
    `claimant_contact_name` STRING COMMENT 'Name of the individual contact person representing the claimant organization for this claim.',
    `claimant_email` STRING COMMENT 'Email address of the claimant contact for claim correspondence and updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `claimant_name` STRING COMMENT 'Name of the party filing the freight claim, typically the shipper, consignee, or beneficial owner of the goods.',
    `claimant_phone` STRING COMMENT 'Primary phone number of the claimant contact for claim follow-up.',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Total monetary value claimed by the shipper for loss, damage, shortage, or delay, including product value, freight charges, and consequential damages where applicable.',
    `claimed_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the claimed amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight claim record was first created in the system.',
    `declared_value` DECIMAL(18,2) COMMENT 'Value of the goods declared on the Bill of Lading (BOL) at the time of shipment. Establishes the maximum carrier liability under Carmack Amendment.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason for claim denial (e.g., insufficient documentation, pre-existing damage, act of God, shipper packaging fault).. Valid values are `^[A-Z0-9]{2,6}$`',
    `denial_reason_description` STRING COMMENT 'Detailed explanation provided by the carrier for denying the freight claim.',
    `discovery_date` DATE COMMENT 'Date when the claimant first discovered the loss, damage, or shortage. May differ from incident date for concealed damage claims.',
    `escalation_level` STRING COMMENT 'Current escalation tier of the claim if it has moved beyond standard resolution process.. Valid values are `none|supervisor|manager|legal|arbitration`',
    `filing_date` DATE COMMENT 'Date when the freight claim was formally filed with the carrier. Critical for statute of limitations tracking (typically 9 months under Carmack Amendment).',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise date and time when the freight claim was submitted, used for audit trail and SLA (Service Level Agreement) tracking.',
    `freight_class` STRING COMMENT 'National Motor Freight Classification (NMFC) class of the goods, used to determine liability limits and freight rates.. Valid values are `^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$`',
    `incident_date` DATE COMMENT 'Date when the loss, damage, shortage, or delay incident occurred or was discovered.',
    `inspection_report_number` STRING COMMENT 'Reference number of the third-party or carrier inspection report documenting the damage or loss.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `insurance_company_name` STRING COMMENT 'Name of the insurance company involved in subrogation or cargo insurance coverage for this claim.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the cargo insurance covering the shipment, relevant for subrogation claims.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight claim record was last modified, used for audit trail and change tracking.',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount the carrier is liable for under the terms of the Bill of Lading (BOL) and applicable regulations. May be based on declared value, weight, or tariff provisions.',
    `notes` STRING COMMENT 'Free-text field for additional comments, correspondence summary, or internal notes related to the claim lifecycle and resolution.',
    `payment_date` DATE COMMENT 'Date when the settlement payment was received by the claimant.',
    `pro_number` STRING COMMENT 'Carrier-assigned progressive or tracking number for the shipment, used for tracing and claim correlation.. Valid values are `^[A-Z0-9-]{6,15}$`',
    `product_description` STRING COMMENT 'Description of the goods that were lost, damaged, or delayed, including material type, SKU (Stock Keeping Unit), and quantity.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final agreed-upon monetary amount paid to resolve the claim. Populated when claim status reaches settled.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the settlement amount.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date when the claim was officially settled and payment terms agreed upon.',
    `settlement_offer_amount` DECIMAL(18,2) COMMENT 'Monetary amount offered by the carrier to settle the claim. May be less than, equal to, or (rarely) greater than the claimed amount.',
    `subrogation_flag` BOOLEAN COMMENT 'Indicates whether the claim involves subrogation rights, where an insurance company has paid the claimant and is pursuing recovery from the carrier.',
    `supporting_documentation_list` STRING COMMENT 'Comma-separated list or structured reference to supporting documents submitted with the claim (e.g., delivery receipt, inspection report, photos, invoice, packing list, weight certificate). Critical for claim substantiation.',
    CONSTRAINT pk_freight_claim PRIMARY KEY(`freight_claim_id`)
) COMMENT 'Formal claim filed against a carrier for loss, damage, shortage, or delay of goods in transit. Captures claim number, claim type (loss/damage/shortage/delay), filing date, carrier ID, shipment and BOL reference, claimed amount, supporting documentation list, carrier response date, settlement offer, settlement amount, claim status (filed/acknowledged/under-review/settled/denied/escalated), and subrogation flag. Manages the full freight claims lifecycle.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` (
    `trade_compliance_record_id` BIGINT COMMENT 'Unique identifier for the trade compliance record. Primary key for this entity.',
    `customs_broker_id` BIGINT COMMENT 'Identifier of the customs broker or freight forwarder involved in the compliance process. Links to partner or vendor master data.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer or trade compliance specialist who performed or reviewed the screening. Links to employee or user master data.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment or delivery that underwent compliance screening. Links this compliance record to the specific shipment being evaluated.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Links trade compliance checks to specific SKUs for embargo, dual‑use, and licensing decisions; supports compliance audit reports.',
    `applicable_regulations` STRING COMMENT 'Comma-separated list of applicable export control regulations governing this shipment. May include EAR, ITAR, EU Dual-Use Regulation, OFAC sanctions, or other jurisdiction-specific rules.',
    `audit_trail` STRING COMMENT 'Comprehensive audit trail capturing all actions, decisions, and system interactions related to this compliance check. Supports regulatory audit and internal compliance reviews.',
    `check_date` DATE COMMENT 'Date when the trade compliance check was performed. Principal business event timestamp for the screening activity.',
    `check_status` STRING COMMENT 'Current lifecycle status of the compliance check. Indicates the state of the screening process and whether the shipment can proceed. [ENUM-REF-CANDIDATE: pending|in_progress|cleared|flagged|blocked|escalated|resolved — 7 candidates stripped; promote to reference product]',
    `check_timestamp` TIMESTAMP COMMENT 'Precise date and time when the compliance screening was initiated. Provides exact timing for audit trail and regulatory reporting.',
    `check_type` STRING COMMENT 'Type of trade compliance check performed. Categorizes the nature of the screening activity conducted on the shipment.. Valid values are `export_license|denied_party_screening|embargo_check|dual_use_classification|sanctions_screening|restricted_entity_list`',
    `compliance_check_number` STRING COMMENT 'Business identifier for the trade compliance check. Externally-known reference number used for tracking and audit purposes.. Valid values are `^TCC-[0-9]{8,12}$`',
    `compliance_officer_name` STRING COMMENT 'Name of the compliance officer responsible for this trade compliance check. Provides accountability and audit trail.',
    `denied_party_list_name` STRING COMMENT 'Name of the denied party or restricted entity list where a match was found. Examples include OFAC SDN, BIS Entity List, EU Consolidated List.',
    `denied_party_match_flag` BOOLEAN COMMENT 'Indicates whether the end user, consignee, or any party in the transaction matched a denied party list or restricted entity list.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 code for the destination country of the shipment. Critical for determining applicable export control restrictions and embargo status.. Valid values are `^[A-Z]{3}$`',
    `documentation_complete_flag` BOOLEAN COMMENT 'Indicates whether all required export control documentation, licenses, and certificates have been obtained and are complete.',
    `dual_use_flag` BOOLEAN COMMENT 'Indicates whether the goods are classified as dual-use items that have both civilian and military applications, requiring special export controls.',
    `eccn` STRING COMMENT 'Export Control Classification Number assigned to the goods. Alphanumeric code used to classify items for export control purposes under EAR.. Valid values are `^[0-9][A-Z][0-9]{3}(.[a-z])?$`',
    `embargo_flag` BOOLEAN COMMENT 'Indicates whether the destination country or end user is subject to a trade embargo or comprehensive sanctions program.',
    `end_user_name` STRING COMMENT 'Name of the ultimate end user or consignee of the goods. Subject to denied party screening and restricted entity checks.',
    `end_user_type` STRING COMMENT 'Classification of the end user entity type. Certain user types may trigger additional scrutiny or licensing requirements.. Valid values are `government|military|commercial|academic|individual|ngo`',
    `escalation_date` DATE COMMENT 'Date when the compliance issue was escalated for higher-level review or decision-making.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the compliance issue requires escalation to senior management, legal counsel, or external trade compliance advisors.',
    `license_expiration_date` DATE COMMENT 'Date when the export license expires. Shipments must be completed before this date to remain compliant.',
    `license_number` STRING COMMENT 'Official license number issued by the export control authority. Unique identifier for the export authorization granted.',
    `license_required_flag` BOOLEAN COMMENT 'Indicates whether an export license is required for this shipment based on the compliance screening results.',
    `license_type` STRING COMMENT 'Type of export license applicable to this shipment. Examples include individual license, general license, license exception, or specific authorization type.',
    `military_end_use_flag` BOOLEAN COMMENT 'Indicates whether the goods are intended for military end use, which may trigger additional licensing requirements or restrictions.',
    `record_created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this compliance record. Provides accountability for data entry.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade compliance record was first created in the system. Audit field for data lineage and compliance tracking.',
    `record_updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this compliance record. Tracks modification responsibility.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade compliance record was last modified. Tracks changes for audit and compliance purposes.',
    `resolution_date` DATE COMMENT 'Date when the compliance check was resolved and a final clearance or blocking decision was made.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution of flagged issues, manual review findings, or justification for clearance decisions. Critical for audit trail and regulatory compliance.',
    `risk_level` STRING COMMENT 'Categorical risk level classification based on the screening results. Used to prioritize manual review and escalation.. Valid values are `low|medium|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score assigned by the screening system indicating the level of compliance risk. Higher scores indicate greater risk requiring manual review.',
    `schedule_b_number` STRING COMMENT '10-digit Schedule B classification number for export statistics. Used by U.S. Census Bureau for tracking exports.. Valid values are `^[0-9]{10}$`',
    `screening_result` STRING COMMENT 'Outcome of the compliance screening process. Indicates whether the shipment passed, failed, or requires additional review or licensing.. Valid values are `cleared|flagged|blocked|requires_license|manual_review_required`',
    `screening_system` STRING COMMENT 'Name or identifier of the automated screening system or tool used to perform the compliance check. Examples include TMS, customs broker system, or dedicated trade compliance software.',
    CONSTRAINT pk_trade_compliance_record PRIMARY KEY(`trade_compliance_record_id`)
) COMMENT 'Record of trade compliance checks and export control screening performed on a shipment or delivery, capturing compliance check type (export license, denied party screening, embargo check, dual-use classification), check date, screening result (cleared/flagged/blocked), export control classification number (ECCN), applicable regulations (EAR, ITAR, EU Dual-Use), license type and number, compliance officer ID, and resolution notes. Supports regulatory compliance with export control authorities.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` (
    `carrier_certification_id` BIGINT COMMENT 'Primary key for the carrier_certification association',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to carrier',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to regulatory requirement',
    `certification_status` STRING COMMENT 'Current status of the carriers certification for the regulatory requirement (e.g., compliant, pending, expired)',
    `effective_date` DATE COMMENT 'Date when the certification became effective for the carrier',
    CONSTRAINT pk_carrier_certification PRIMARY KEY(`carrier_certification_id`)
) COMMENT 'Association representing the certification compliance of a transportation carrier to a specific regulatory requirement. Captures the carriers certification status and effective date for each requirement.. Existence Justification: Each transportation carrier must maintain compliance with multiple regulatory requirements (e.g., safety, emissions, insurance). Conversely, each regulatory requirement applies to many carriers. The business records the certification status and effective date for every carrier‑requirement pair, creating a managed many‑to‑many relationship.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` (
    `customs_broker_id` BIGINT COMMENT 'Primary key for customs_broker',
    `parent_customs_broker_id` BIGINT COMMENT 'Self-referencing FK on customs_broker (parent_customs_broker_id)',
    `address_line1` STRING COMMENT 'First line of the brokers street address.',
    `address_line2` STRING COMMENT 'Second line of the brokers street address, if applicable.',
    `average_clearance_time_days` STRING COMMENT 'Average number of days the broker takes to clear shipments.',
    `broker_type` STRING COMMENT 'Classification of the brokers service offering.',
    `city` STRING COMMENT 'City of the brokers primary location.',
    `classification` STRING COMMENT 'Business classification based on operational scope.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of compliance certifications held by the broker (e.g., AEO, ISO 28000).',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the brokers primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the broker record was first created.',
    `default_currency` STRING COMMENT 'Primary currency used for billing the broker.',
    `effective_from` DATE COMMENT 'Date when the brokers agreement or registration becomes effective.',
    `effective_until` DATE COMMENT 'Date when the brokers agreement or registration expires, if applicable.',
    `is_preferred` BOOLEAN COMMENT 'Indicates whether the broker is a preferred partner for the company.',
    `license_expiry_date` DATE COMMENT 'Expiration date of the customs brokerage license.',
    `license_number` STRING COMMENT 'Regulatory license number authorizing customs brokerage activities.',
    `customs_broker_name` STRING COMMENT 'Legal name of the customs broker organization.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the broker.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the brokers primary location.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the broker.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `rating_date` DATE COMMENT 'Date when the most recent rating was recorded.',
    `rating_score` DECIMAL(18,2) COMMENT 'Average performance rating (0.00‑5.00) assigned by internal quality team.',
    `service_modes` STRING COMMENT 'Transportation modes the broker supports.',
    `service_regions` STRING COMMENT 'Geographic regions where the broker provides services.',
    `state_province` STRING COMMENT 'State or province of the brokers primary location.',
    `customs_broker_status` STRING COMMENT 'Current lifecycle status of the broker record.',
    `tax_id_number` STRING COMMENT 'Government‑issued tax identifier for the broker.',
    `trading_name` STRING COMMENT 'Doing‑business‑as name used by the customs broker.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the broker record.',
    CONSTRAINT pk_customs_broker PRIMARY KEY(`customs_broker_id`)
) COMMENT 'Master reference table for customs_broker. Referenced by customs_broker_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`logistics`.`lane` (
    `lane_id` BIGINT COMMENT 'Primary key for lane',
    `node_id` BIGINT COMMENT 'Identifier of the destination location.',
    `destination_node_id` BIGINT COMMENT 'FK to logistics.node',
    `lane_node_id` BIGINT COMMENT 'Identifier of the origin location (plant, warehouse, or port).',
    `origin_location_node_id` BIGINT COMMENT 'FK to logistics.node',
    `return_lane_id` BIGINT COMMENT 'Self-referencing FK on lane (return_lane_id)',
    `average_load_factor_percent` DECIMAL(18,2) COMMENT 'Average load factor as a percentage of capacity.',
    `average_transit_time_hours` DECIMAL(18,2) COMMENT 'Typical transit time for the lane in hours.',
    `capacity_tons` DECIMAL(18,2) COMMENT 'Maximum weight capacity that can be moved on the lane per shipment.',
    `carrier_type` STRING COMMENT 'Type of carrier used on the lane.',
    `lane_code` STRING COMMENT 'Standard code used to identify the lane across systems.',
    `compliance_hazardous_allowed` BOOLEAN COMMENT 'Indicates if hazardous materials are permitted on the lane.',
    `cost_per_mile` DECIMAL(18,2) COMMENT 'Standard cost per mile (or kilometre) for the lane, before any discounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lane record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for cost fields.',
    `customs_documentation_required` BOOLEAN COMMENT 'Indicates whether customs documentation is required for the lane.',
    `lane_description` STRING COMMENT 'Free‑form description of the lane, including any special notes.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance of the lane in kilometres.',
    `effective_from` DATE COMMENT 'Date from which the lane definition becomes effective.',
    `effective_until` DATE COMMENT 'Date after which the lane definition is no longer valid (null if open‑ended).',
    `lane_group` STRING COMMENT 'Logical grouping of lanes for reporting (e.g., EastCoastGroup).',
    `lane_status` STRING COMMENT 'Current operational status of the lane.',
    `lane_type` STRING COMMENT 'Whether the lane is domestic or crosses international borders.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent shipment that used this lane.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum individual load weight allowed on the lane.',
    `mode_of_transport` STRING COMMENT 'Primary mode of transport for the lane.',
    `lane_name` STRING COMMENT 'Human‑readable name of the lane (e.g., Chicago → Dallas).',
    `priority` STRING COMMENT 'Priority ranking used for routing optimization (higher = more preferred).',
    `region` STRING COMMENT 'Geographic region grouping for the lane (e.g., Midwest).',
    `updated_by` STRING COMMENT 'User identifier who last updated the lane record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lane record.',
    `usage_count` BIGINT COMMENT 'Cumulative count of shipments that have traversed this lane.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Maximum volume per shipment that the lane can accommodate.',
    `created_by` STRING COMMENT 'User identifier who created the lane record.',
    CONSTRAINT pk_lane PRIMARY KEY(`lane_id`)
) COMMENT 'Master reference table for lane. Referenced by lane_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_destination_location_node_id` FOREIGN KEY (`destination_location_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_origin_location_logistics_node_id` FOREIGN KEY (`origin_location_logistics_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_primary_shipment_node_id` FOREIGN KEY (`primary_shipment_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_tertiary_shipment_transfer_point_location_node_id` FOREIGN KEY (`tertiary_shipment_transfer_point_location_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`transport_route`(`transport_route_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_primary_freight_node_id` FOREIGN KEY (`primary_freight_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ADD CONSTRAINT `fk_logistics_transport_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ADD CONSTRAINT `fk_logistics_shipment_tracking_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ADD CONSTRAINT `fk_logistics_shipment_tracking_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_primary_load_node_id` FOREIGN KEY (`primary_load_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`transport_route`(`transport_route_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ADD CONSTRAINT `fk_logistics_delivery_appointment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ADD CONSTRAINT `fk_logistics_delivery_appointment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_logistics_dangerous_goods_declaration_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ADD CONSTRAINT `fk_logistics_trade_compliance_record_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ADD CONSTRAINT `fk_logistics_trade_compliance_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` ADD CONSTRAINT `fk_logistics_carrier_certification_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ADD CONSTRAINT `fk_logistics_customs_broker_parent_customs_broker_id` FOREIGN KEY (`parent_customs_broker_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_node_id` FOREIGN KEY (`node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_destination_node_id` FOREIGN KEY (`destination_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_lane_node_id` FOREIGN KEY (`lane_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_origin_location_node_id` FOREIGN KEY (`origin_location_node_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`node`(`node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_return_lane_id` FOREIGN KEY (`return_lane_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`lane`(`lane_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_location_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Shipment Direction');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'National Motor Freight Classification (NMFC) Freight Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_class` SET TAGS ('dbx_value_regex' = '^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS) Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `insurance_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ALTER COLUMN `insurance_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `destination_location_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Node Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `destination_location_node_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `origin_location_logistics_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Logistics Node Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `origin_location_logistics_node_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `primary_shipment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `tertiary_shipment_transfer_point_location_node_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Shipment Transfer Point Location Node Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `tertiary_shipment_transfer_point_location_node_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'standard|express|overnight|same_day|economy');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|cleared|held|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `customs_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `equipment_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `is_cross_dock` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Dock Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `is_transshipment` SET TAGS ('dbx_business_glossary_term' = 'Is Transshipment Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Leg Distance in Kilometers (km)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Leg Distance in Miles');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Leg Freight Cost');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Leg Freight Cost Currency');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_freight_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_business_glossary_term' = 'Leg Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type (Full Truckload / Less Than Truckload)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'FTL|LTL|parcel|container|bulk');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Leg Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `route_optimization_score` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Score');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `scheduled_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Transit Time in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|air|ocean|intermodal|parcel');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_leg` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_value_regex' = 'truck|container|railcar|aircraft|vessel|van');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ALTER COLUMN `freight_rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_note_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_direction` SET TAGS ('dbx_business_glossary_term' = 'Delivery Direction');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue (GI) Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue (GI) Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `replenishment_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Proposal Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_city` SET TAGS ('dbx_business_glossary_term' = 'Consignee City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_country_code` SET TAGS ('dbx_business_glossary_term' = 'Consignee Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Consignee Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_state_province` SET TAGS ('dbx_business_glossary_term' = 'Consignee State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_charge_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'National Motor Freight Classification (NMFC) Freight Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_class` SET TAGS ('dbx_value_regex' = '^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_city` SET TAGS ('dbx_business_glossary_term' = 'Shipper City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipper Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_network');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `on_time_delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|net_90|prepaid|cod');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `preferred_lanes` SET TAGS ('dbx_business_glossary_term' = 'Preferred Lanes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `tms_integration_status` SET TAGS ('dbx_value_regex' = 'integrated|pending|not_integrated|failed');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_business_glossary_term' = 'Tracking URL Template');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_subdomain' = 'carrier_network');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `accessorial_charges_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `base_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `base_rate_type` SET TAGS ('dbx_value_regex' = 'per_cwt|per_mile|per_shipment|per_pallet|flat_rate|weight_break');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_method` SET TAGS ('dbx_value_regex' = 'percentage_of_base|fixed_per_mile|tiered_schedule|index_linked|none');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `insurance_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `insurance_minimum_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Minimum Coverage Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `negotiation_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Target Percentage (Pct)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^(net_[0-9]{1,3}|due_on_receipt|prepaid|cod)$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `penalty_clause_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Description');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `rate_adjustment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Trigger');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `rate_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rate Review Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `rate_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand|none');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_level_standard` SET TAGS ('dbx_business_glossary_term' = 'Service Level Standard');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'LTL|FTL|parcel|intermodal|air_freight|ocean_freight');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_value_regex' = 'shipments|pallets|weight_kg|weight_lbs|revenue_usd');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `accessorial_charges_applicable` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Applicable');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_range_end` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code Range End');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_range_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_range_end` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_range_start` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code Range Start');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_range_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_range_start` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `destination_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Zone Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `distance_max_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Maximum (km)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `distance_min_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Minimum (km)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'Freight Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `hazmat_eligible` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_range_end` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code Range End');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_range_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_range_end` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_range_start` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code Range Start');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_range_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_range_start` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `origin_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Zone Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'per_cwt|per_mile|per_shipment|per_pallet|per_unit|flat');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rate Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rate Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_published_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Published Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_source_system` SET TAGS ('dbx_business_glossary_term' = 'Rate Source System');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'contract|spot|benchmark|tariff');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|express|economy');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `volume_commitment_required` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Required');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `weight_break_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_rate` ALTER COLUMN `weight_break_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `primary_freight_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `accessorial_charges` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `audit_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Completed Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `audited_amount` SET TAGS ('dbx_business_glossary_term' = 'Audited Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `customs_duties` SET TAGS ('dbx_business_glossary_term' = 'Customs Duties');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance (Kilometers)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'Freight Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `freight_class` SET TAGS ('dbx_value_regex' = '^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `fuel_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `line_haul_charge` SET TAGS ('dbx_business_glossary_term' = 'Line Haul Charge');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|prepaid');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|disputed|rejected|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Pickup Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Transportation Service Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance|failed|pending');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `transit_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Days');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Shipment Volume (Cubic Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_invoice` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` SET TAGS ('dbx_subdomain' = 'carrier_network');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Route ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `alternate_carrier_codes` SET TAGS ('dbx_business_glossary_term' = 'Alternate Carrier Codes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `carbon_emission_factor_kg_per_km` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Factor (Kilograms per Kilometer)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `cost_per_km` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Kilometer');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `cost_per_km` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `customs_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `destination_location_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Name');
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
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `primary_transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Primary Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `primary_transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|air|ocean|inland_waterway|pipeline');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_capacity_constraint` SET TAGS ('dbx_business_glossary_term' = 'Route Capacity Constraint');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|seasonal|under_review|deprecated');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'direct|relay|intermodal|milk_run|cross_dock|backhaul');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `seasonal_restriction_details` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Restriction Details');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `seasonal_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Restriction Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `secondary_transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Secondary Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `secondary_transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|air|ocean|inland_waterway|pipeline');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'express|standard|economy|dedicated|shared');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `standard_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Freight Cost');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `standard_freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `standard_transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Transit Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` SET TAGS ('dbx_subdomain' = 'carrier_network');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Node ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `carrier_access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Carrier Access Restrictions');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `customs_bonded_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Bonded Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Count');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `erp_location_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `free_trade_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `handling_equipment_available` SET TAGS ('dbx_business_glossary_term' = 'Handling Equipment Available');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `max_vehicle_length_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Vehicle Length in Meters');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `max_vehicle_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Vehicle Weight in Kilograms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1_hub|tier_2_regional|tier_3_local|tier_4_last_mile');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Node Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|temporary');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party_logistics|contract_warehouse');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `port_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Port Access Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `rail_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Rail Access Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `storage_capacity_sqm` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity in Square Meters');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `tms_location_code` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`node` ALTER COLUMN `yard_capacity_trailers` SET TAGS ('dbx_business_glossary_term' = 'Yard Capacity in Trailers');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `shipment_tracking_event_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `carrier_status_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `carrier_status_description` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status Description');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `customs_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `data_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Received Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'edi_214|carrier_api|iot_telematics|manual_entry|tms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration Hours');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `estimated_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Time');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_city` SET TAGS ('dbx_business_glossary_term' = 'Event City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_country_code` SET TAGS ('dbx_business_glossary_term' = 'Event Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_latitude` SET TAGS ('dbx_business_glossary_term' = 'Event Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_location_name` SET TAGS ('dbx_business_glossary_term' = 'Event Location Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_longitude` SET TAGS ('dbx_business_glossary_term' = 'Event Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Event Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_state_province` SET TAGS ('dbx_business_glossary_term' = 'Event State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'pickup|in_transit|out_for_delivery|delivered|exception|delay');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `exception_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `humidity_reading` SET TAGS ('dbx_business_glossary_term' = 'Humidity Reading');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `signature_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Obtained Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `temperature_reading` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `bond_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Bond Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `compliance_screening_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Screening Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `compliance_screening_outcome` SET TAGS ('dbx_value_regex' = 'cleared|flagged|blocked|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `consignor_name` SET TAGS ('dbx_business_glossary_term' = 'Consignor Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `consignor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_business_glossary_term' = 'Country of Destination');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_export` SET TAGS ('dbx_business_glossary_term' = 'Country of Export');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_export` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'import|export|transit|re-export|temporary_admission|inward_processing');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `denied_party_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Result');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `denied_party_screening_result` SET TAGS ('dbx_value_regex' = 'cleared|flagged|blocked|pending');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `dual_use_classification` SET TAGS ('dbx_business_glossary_term' = 'Dual-Use Classification');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `eccn` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `embargo_check_result` SET TAGS ('dbx_business_glossary_term' = 'Embargo Check Result');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `embargo_check_result` SET TAGS ('dbx_value_regex' = 'cleared|flagged|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `export_license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `exporter_of_record` SET TAGS ('dbx_business_glossary_term' = 'Exporter of Record');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `exporter_of_record` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `import_license_number` SET TAGS ('dbx_business_glossary_term' = 'Import License Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `importer_of_record` SET TAGS ('dbx_business_glossary_term' = 'Importer of Record');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `importer_of_record` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `port_of_entry` SET TAGS ('dbx_business_glossary_term' = 'Port of Entry');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `port_of_exit` SET TAGS ('dbx_business_glossary_term' = 'Port of Exit');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|sea|road|rail|multimodal');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_declaration` ALTER COLUMN `vat_amount` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Carrier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `primary_load_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `actual_load_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Load Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|express|economy|white_glove');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `customs_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `dock_door_assignment` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Assignment');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `dock_door_assignment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `estimated_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Freight Cost');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `estimated_freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `estimated_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Time in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-9])?$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `load_optimization_method` SET TAGS ('dbx_business_glossary_term' = 'Load Optimization Method');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `load_optimization_method` SET TAGS ('dbx_value_regex' = 'manual|rule_based|algorithm|ai_ml');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `load_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `load_plan_number` SET TAGS ('dbx_value_regex' = '^LP-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `load_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `load_plan_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|in_progress|executed|cancelled|closed');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `load_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Load Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `loading_end_time` SET TAGS ('dbx_business_glossary_term' = 'Loading End Time');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `loading_start_time` SET TAGS ('dbx_business_glossary_term' = 'Loading Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `number_of_handling_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Handling Units');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `number_of_pallets` SET TAGS ('dbx_business_glossary_term' = 'Number of Pallets');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `number_of_shipments` SET TAGS ('dbx_business_glossary_term' = 'Number of Shipments Consolidated');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `planned_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `planned_load_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Load Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `requires_hazmat_handling` SET TAGS ('dbx_business_glossary_term' = 'Requires Hazardous Materials (HAZMAT) Handling Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `requires_temperature_control` SET TAGS ('dbx_business_glossary_term' = 'Requires Temperature Control Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type (Less Than Truckload (LTL) / Full Truckload (FTL))');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'LTL|FTL|parcel|express|dedicated');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum in Celsius (°C)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum in Celsius (°C)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `total_planned_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Volume in Cubic Meters (m³)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `total_planned_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Weight in Kilograms (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|air|ocean|intermodal|parcel');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `volume_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volume Utilization Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`load_plan` ALTER COLUMN `weight_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Weight Utilization Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `delivery_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Appointment Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `actual_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Time');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_created_by` SET TAGS ('dbx_business_glossary_term' = 'Appointment Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Appointment Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|cross_dock|return|transfer|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `check_in_time` SET TAGS ('dbx_business_glossary_term' = 'Check-In Time');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `customs_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_business_glossary_term' = 'Driver License Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `driver_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Driver Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `driver_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `driver_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time in Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `facility_location_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `facility_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'live_load|drop_trailer|live_unload|drop_and_hook');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `requires_hazmat_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Hazardous Materials (HAZMAT) Handling Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `requires_refrigeration_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Refrigeration Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Appointment Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `vehicle_license_plate` SET TAGS ('dbx_business_glossary_term' = 'Vehicle License Plate Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `vehicle_license_plate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_appointment` ALTER COLUMN `wait_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Wait Time in Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `dangerous_goods_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Declaration ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_value_regex' = 'IATA_DGR|IMDG|DOT_49CFR|ADR|RID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `cargo_aircraft_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Cargo Aircraft Only (CAO) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `competent_authority` SET TAGS ('dbx_business_glossary_term' = 'Competent Authority');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Declaration Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Declaration Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Declaration Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Declaration Prepared By');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_prepared_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_prepared_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_prepared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Declaration Prepared Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|expired|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `excepted_quantity_flag` SET TAGS ('dbx_business_glossary_term' = 'Excepted Quantity Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `flash_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = '1|1.1|1.2|1.3|1.4|1.5|1.6|2.1|2.2|2.3|3|4.1|4.2|4.3|5.1|5.2|6.1|6.2|7|8|9');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `limited_quantity_flag` SET TAGS ('dbx_business_glossary_term' = 'Limited Quantity Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `marine_pollutant_flag` SET TAGS ('dbx_business_glossary_term' = 'Marine Pollutant Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `net_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `net_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Net Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `net_quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|L|g|mL|lbs|gal');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `packaging_instruction` SET TAGS ('dbx_business_glossary_term' = 'Packaging Instruction');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_address` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Shipper Certification Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_certification_signature` SET TAGS ('dbx_business_glossary_term' = 'Shipper Certification Signature');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_certification_signature` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_certification_signature` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Shipper Certification Statement');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `special_provisions` SET TAGS ('dbx_business_glossary_term' = 'Special Provisions');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `subsidiary_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Subsidiary Hazard Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `technical_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`dangerous_goods_declaration` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `freight_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Claim ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `assigned_adjuster_email` SET TAGS ('dbx_business_glossary_term' = 'Assigned Adjuster Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `assigned_adjuster_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `assigned_adjuster_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `assigned_adjuster_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `assigned_adjuster_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Adjuster Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `carrier_response_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Response Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^CLM-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'loss|damage|shortage|delay|concealed_damage|refused_shipment');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_email` SET TAGS ('dbx_business_glossary_term' = 'Claimant Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_phone` SET TAGS ('dbx_business_glossary_term' = 'Claimant Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimed_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Claimed Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `claimed_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|legal|arbitration');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'Freight Class');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `freight_class` SET TAGS ('dbx_value_regex' = '^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `insurance_company_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Company Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `pro_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `settlement_offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Offer Amount');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_claim` ALTER COLUMN `supporting_documentation_list` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation List');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = 'export_license|denied_party_screening|embargo_check|dual_use_classification|sanctions_screening|restricted_entity_list');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `compliance_check_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `compliance_check_number` SET TAGS ('dbx_value_regex' = '^TCC-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `compliance_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `denied_party_list_name` SET TAGS ('dbx_business_glossary_term' = 'Denied Party List Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `denied_party_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Match Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `documentation_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Complete Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `dual_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual-Use Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `eccn` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `eccn` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}(.[a-z])?$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `embargo_flag` SET TAGS ('dbx_business_glossary_term' = 'Embargo Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `end_user_name` SET TAGS ('dbx_business_glossary_term' = 'End User Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `end_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `end_user_type` SET TAGS ('dbx_business_glossary_term' = 'End User Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `end_user_type` SET TAGS ('dbx_value_regex' = 'government|military|commercial|academic|individual|ngo');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'License Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'Export License Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `military_end_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Military End-Use Flag');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `schedule_b_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule B Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `schedule_b_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `screening_result` SET TAGS ('dbx_value_regex' = 'cleared|flagged|blocked|requires_license|manual_review_required');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`trade_compliance_record` ALTER COLUMN `screening_system` SET TAGS ('dbx_business_glossary_term' = 'Screening System');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` SET TAGS ('dbx_subdomain' = 'carrier_network');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` SET TAGS ('dbx_association_edges' = 'logistics.carrier,compliance.regulatory_requirement');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` ALTER COLUMN `carrier_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Certification - Carrier Certification Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Certification - Carrier Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Certification - Regulatory Requirement Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `parent_customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Customs Broker Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `parent_customs_broker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `average_clearance_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Clearance Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `default_currency` SET TAGS ('dbx_business_glossary_term' = 'Default Currency');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `is_preferred` SET TAGS ('dbx_business_glossary_term' = 'Is Preferred');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `customs_broker_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Rating Score');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `service_modes` SET TAGS ('dbx_business_glossary_term' = 'Service Modes');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `service_regions` SET TAGS ('dbx_business_glossary_term' = 'Service Regions');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `customs_broker_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Id Number');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`customs_broker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` SET TAGS ('dbx_subdomain' = 'carrier_network');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Node Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `destination_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `destination_node_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `lane_node_id` SET TAGS ('dbx_business_glossary_term' = 'Node Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `origin_location_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Node Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `origin_location_node_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `return_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Return Lane Id');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `return_lane_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `average_load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Load Factor Percent');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `average_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Average Transit Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Capacity Tons');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_business_glossary_term' = 'Lane Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `compliance_hazardous_allowed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hazardous Allowed');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `cost_per_mile` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mile');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `customs_documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Documentation Required');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `lane_description` SET TAGS ('dbx_business_glossary_term' = 'Lane Description');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Km');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `lane_group` SET TAGS ('dbx_business_glossary_term' = 'Lane Group');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `lane_status` SET TAGS ('dbx_business_glossary_term' = 'Lane Status');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Max Weight Kg');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `lane_name` SET TAGS ('dbx_business_glossary_term' = 'Lane Name');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Lane Priority');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume Cubic Meters');
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`lane` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
