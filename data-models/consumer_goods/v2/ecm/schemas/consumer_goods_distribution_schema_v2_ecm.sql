-- Schema for Domain: distribution | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 13:03:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`distribution` COMMENT 'Owns warehouse operations, inventory management, and order fulfillment across distribution centers. Manages inbound/outbound logistics within DCs, put-away/picking/packing processes, cycle counting, FEFO/FIFO inventory rotation, WMS integration (Blue Yonder), OTIF performance, OSA metrics, and DSD execution for direct store delivery channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` (
    `distribution_facility_id` BIGINT COMMENT 'Primary key for facility',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Facilities have specific ESG commitments (energy, waste, emissions) that are tracked for performance dashboards and compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks the facility manager employee for each distribution center, required for operational performance metrics and compliance reporting.',
    `address_line_1` STRING COMMENT 'Primary street address line for the distribution center facility. Organizational contact data classified as confidential business information.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential business information.',
    `city` STRING COMMENT 'City or municipality where the distribution center is located. Organizational contact data classified as confidential business information.',
    `closed_date` DATE COMMENT 'Date when the distribution center ceased operations. Null for active facilities. Used for historical analysis and network optimization studies.',
    `contact_email` STRING COMMENT 'Primary contact email address for the distribution center. Organizational contact data classified as confidential business information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the distribution center. Organizational contact data classified as confidential business information.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the distribution center is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution center record was first created in the system. Audit trail for data lineage and compliance.',
    `cross_dock_enabled_flag` BOOLEAN COMMENT 'Indicates whether the facility supports cross-docking operations where inbound goods are directly transferred to outbound shipments with minimal storage time.',
    `cycle_count_frequency_days` STRING COMMENT 'Standard frequency in days for cycle counting inventory at this facility. Used for inventory accuracy management and audit compliance.',
    `dc_code` STRING COMMENT 'Business identifier code for the distribution center used across operational systems. Externally-known unique code for the facility.. Valid values are `^[A-Z0-9]{4,12}$`',
    `dc_name` STRING COMMENT 'Official business name of the distribution center or warehouse facility.',
    `dock_doors_inbound` STRING COMMENT 'Number of dock doors designated for inbound receiving operations. Impacts receiving throughput capacity and scheduling.',
    `dock_doors_outbound` STRING COMMENT 'Number of dock doors designated for outbound shipping operations. Impacts shipping throughput capacity and carrier scheduling.',
    `dsd_hub_flag` BOOLEAN COMMENT 'Indicates whether this facility serves as a DSD hub for direct-to-retail delivery operations. DSD hubs bypass traditional distribution channels for faster store replenishment.',
    `facility_type` STRING COMMENT 'Classification of the distribution center based on temperature control and operational model. Ambient for room temperature, chilled for refrigerated, frozen for sub-zero, multi-temperature for mixed zones, DSD hub for Direct Store Delivery operations, cross-dock for flow-through distribution.. Valid values are `ambient|chilled|frozen|multi_temperature|dsd_hub|cross_dock`',
    `fsc_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified under FSC chain of custody standards for sustainable sourcing. Required for handling FSC-certified paper and wood-based products.',
    `gmp_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified under Good Manufacturing Practice standards. Required for handling cosmetics, personal care, and certain consumer goods products.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified to handle and store hazardous materials. Required for distribution of products with EPA or OSHA regulated substances.',
    `inventory_rotation_method` STRING COMMENT 'Primary inventory rotation method used at this facility. FIFO (First In First Out) for standard goods, FEFO (First Expired First Out) for perishables and date-sensitive products, LIFO (Last In First Out) for specific use cases.. Valid values are `fifo|fefo|lifo`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the distribution center in decimal degrees. Used for geospatial analytics, route optimization, and logistics planning.',
    `lease_expiration_date` DATE COMMENT 'Expiration date of the facility lease agreement. Null for owned facilities. Used for lease renewal planning and facility strategy.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the distribution center in decimal degrees. Used for geospatial analytics, route optimization, and logistics planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution center record was last modified. Audit trail for change tracking and data quality monitoring.',
    `opened_date` DATE COMMENT 'Date when the distribution center commenced operations. Used for facility age analysis and depreciation calculations.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for weekdays in format HH:MM-HH:MM. Used for scheduling inbound deliveries, outbound shipments, and workforce planning.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for weekends in format HH:MM-HH:MM. Used for scheduling weekend operations and carrier coordination.',
    `operational_status` STRING COMMENT 'Current operational state of the distribution center in its lifecycle. Active indicates full operations, inactive for temporarily closed, under construction for new facilities being built, decommissioned for permanently closed, seasonal for facilities operating only during peak periods, maintenance for temporary closure due to upgrades or repairs.. Valid values are `active|inactive|under_construction|decommissioned|seasonal|maintenance`',
    `osa_target_percentage` DECIMAL(18,2) COMMENT 'Target OSA performance percentage for stores served by this distribution center. OSA measures product availability at retail shelf level.',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'Target OTIF performance percentage for this distribution center. OTIF measures the percentage of orders delivered on time and in full, a key supply chain KPI.',
    `ownership_type` STRING COMMENT 'Classification of facility ownership model. Owned for company-owned facilities, leased for long-term leased properties, third-party logistics for 3PL-operated warehouses.. Valid values are `owned|leased|third_party_logistics`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the distribution center address. Organizational contact data classified as confidential business information.',
    `sap_plant_code` STRING COMMENT 'SAP S/4HANA plant code representing this distribution center in the ERP system. Maps to the SAP MM and WM modules for material management and warehouse management.. Valid values are `^[A-Z0-9]{4}$`',
    `sap_storage_location` STRING COMMENT 'SAP S/4HANA storage location code within the plant. Represents the primary storage location identifier for inventory transactions in SAP WM module.. Valid values are `^[A-Z0-9]{4}$`',
    `shifts_per_day` STRING COMMENT 'Number of operational shifts per day at the facility. Used for labor planning, throughput capacity modeling, and operational cost analysis.',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the facility is located. Organizational contact data classified as confidential business information.',
    `storage_capacity_pallet_positions` STRING COMMENT 'Maximum number of pallet positions available for storage. Key metric for inventory capacity planning and space utilization analysis.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the facility has temperature-controlled storage zones. True for facilities with chilled or frozen capabilities, false for ambient-only.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the distribution center location. Used for scheduling, shift planning, and cross-facility coordination.',
    `total_capacity_sqft` DECIMAL(18,2) COMMENT 'Total warehouse floor space capacity in square feet. Includes all storage, staging, and operational areas within the facility.',
    `wms_site_code` STRING COMMENT 'Unique site identifier in the Blue Yonder WMS system. Used for integration and synchronization between the lakehouse and the operational WMS platform.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    CONSTRAINT pk_distribution_facility PRIMARY KEY(`distribution_facility_id`)
) COMMENT 'Master record for each physical distribution center (DC) or warehouse facility in the CPG network. Captures DC identity, location, type (ambient, chilled, frozen, DSD hub), capacity metrics, WMS integration identifiers (Blue Yonder site codes), SAP plant/storage location mappings, operating hours, and operational status. SSOT for DC facility master data across the distribution domain.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` (
    `distribution_storage_location_id` BIGINT COMMENT 'Primary key for storage_location',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the parent distribution center facility where this storage location resides.',
    `abc_classification` STRING COMMENT 'Velocity-based classification of the location for slotting optimization: A (high-velocity/fast-moving), B (medium-velocity), C (low-velocity/slow-moving).. Valid values are `A|B|C`',
    `aisle` STRING COMMENT 'Aisle designation within the warehouse layout for physical navigation and picking route optimization.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bay` STRING COMMENT 'Bay or column position within the aisle for precise horizontal location reference.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bin_position` STRING COMMENT 'Specific bin or slot position within the level for granular inventory placement and retrieval.. Valid values are `^[A-Z0-9]{1,5}$`',
    `blocked_date` DATE COMMENT 'Date when the storage location was blocked or made unavailable for operations.',
    `blocked_reason` STRING COMMENT 'Explanation for why the location is blocked or unavailable, such as maintenance, damage, safety hold, or quality quarantine.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the storage location record was first created in the WMS system.',
    `cycle_count_frequency` STRING COMMENT 'Scheduled frequency for cycle counting inventory at this location to maintain inventory accuracy and compliance.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether the location is designated for DSD operations where products bypass the DC and are delivered directly to retail stores.',
    `effective_date` DATE COMMENT 'Date when the storage location became active and available for warehouse operations.',
    `equipment_type_required` STRING COMMENT 'Type of material handling equipment required to access this storage location for put-away and picking operations.. Valid values are `forklift|reach_truck|order_picker|pallet_jack|manual|automated`',
    `expiration_date` DATE COMMENT 'Date when the storage location is scheduled to be decommissioned or removed from active use. Null for indefinite locations.',
    `fefo_eligible_flag` BOOLEAN COMMENT 'Indicates whether the location supports FEFO inventory rotation logic for expiry-sensitive products (pharmaceuticals, food, cosmetics).',
    `fifo_eligible_flag` BOOLEAN COMMENT 'Indicates whether the location supports FIFO inventory rotation logic for age-based stock management.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the location is certified and equipped for storing hazardous materials per OSHA and EPA regulations.',
    `height_cm` DECIMAL(18,2) COMMENT 'Physical height dimension of the storage location in centimeters for vertical clearance and equipment reach validation.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent cycle count was performed at this storage location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the storage location record was most recently updated in the WMS system.',
    `length_cm` DECIMAL(18,2) COMMENT 'Physical length dimension of the storage location in centimeters for dimensional slotting and equipment compatibility.',
    `distribution_storage_location_level` STRING COMMENT 'Vertical level or shelf position within the bay for height-based slotting and equipment compatibility.. Valid values are `^[A-Z0-9]{1,3}$`',
    `location_code` STRING COMMENT 'Business identifier for the storage location as defined in Blue Yonder WMS. Typically formatted as aisle-bay-level-bin (e.g., A01-B05-L03-P12).. Valid values are `^[A-Z0-9]{2,20}$`',
    `location_name` STRING COMMENT 'Human-readable name or description of the storage location for operational reference.',
    `location_status` STRING COMMENT 'Current operational status of the storage location indicating availability for inventory placement and retrieval.. Valid values are `active|inactive|blocked|maintenance|quarantine|damaged`',
    `location_type` STRING COMMENT 'Classification of the storage location by operational function: bulk storage, active pick face, reserve inventory, staging area, dock door, or cross-dock zone.. Valid values are `bulk|pick|reserve|staging|dock|cross_dock`',
    `mixed_lot_allowed_flag` BOOLEAN COMMENT 'Indicates whether the location permits storage of multiple lot or batch numbers for the same SKU or requires lot segregation.',
    `mixed_sku_allowed_flag` BOOLEAN COMMENT 'Indicates whether the location permits storage of multiple SKUs simultaneously or requires single-SKU dedication.',
    `pick_face_flag` BOOLEAN COMMENT 'Indicates whether this location is designated as an active pick face for order fulfillment operations.',
    `picking_strategy` STRING COMMENT 'Order fulfillment picking method supported by this location: batch picking, wave picking, zone picking, discrete (single-order), or cluster picking.. Valid values are `batch|wave|zone|discrete|cluster`',
    `putaway_strategy` STRING COMMENT 'Algorithm used to assign incoming inventory to this location: directed (system-assigned), random, fixed (dedicated SKU), or dynamic (velocity-based).. Valid values are `directed|random|fixed|dynamic`',
    `replenishment_priority` STRING COMMENT 'Priority ranking for automated replenishment from reserve to pick locations, with lower numbers indicating higher priority.',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the storage location to ensure product integrity and regulatory compliance (ambient, refrigerated 2-8°C, frozen <-18°C, controlled room temperature).. Valid values are `ambient|refrigerated|frozen|controlled`',
    `volume_capacity_m3` DECIMAL(18,2) COMMENT 'Maximum volume capacity of the storage location in cubic meters for space utilization and slotting algorithms.',
    `weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in kilograms for safe load management and slotting optimization.',
    `width_cm` DECIMAL(18,2) COMMENT 'Physical width dimension of the storage location in centimeters for dimensional slotting and equipment compatibility.',
    `zone_code` STRING COMMENT 'Logical zone classification within the distribution center for grouping locations by product category, velocity, or operational workflow (e.g., FAST-PICK, SLOW-MOVE, HAZMAT).. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_distribution_storage_location PRIMARY KEY(`distribution_storage_location_id`)
) COMMENT 'Granular storage location master within a distribution center — aisles, bays, levels, bin positions, and pick faces as defined in Blue Yonder WMS. Tracks location type (bulk, pick, reserve, staging, dock), zone classification, temperature zone, weight/volume capacity, and FEFO/FIFO eligibility flags. Enables put-away and picking optimization at the slot level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` (
    `inbound_receipt_id` BIGINT COMMENT 'Unique identifier for the inbound receipt transaction. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier that delivered the shipment to the distribution center.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receiving operations incur expenses (labor, equipment) that are allocated to a cost center for expense tracking and budgeting.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center facility where the goods were received.',
    `inbound_warehouse_distribution_facility_id` BIGINT COMMENT 'Identifier of the specific warehouse or storage facility within the distribution center where goods were received.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Internal transfer receipt: inbound receipts from own plants need the source manufacturing facility to track internal logistics and cost allocation.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality control personnel who performed the inspection, used for accountability and audit trail.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Required for R&D material receipt tracking; links each inbound receipt to the RD project that requested the raw material for formulation trials.',
    `receiving_clerk_employee_id` BIGINT COMMENT 'Identifier of the warehouse employee who processed the inbound receipt, used for labor tracking and accountability.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor who shipped the goods, representing the counterparty in this receipt transaction.',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods accepted into inventory after quality inspection, excluding rejected or damaged items.',
    `actual_receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical goods arrived and were checked in at the receiving dock, representing the principal business event for this transaction.',
    `asn_number` STRING COMMENT 'Reference to the Advanced Shipping Notice document sent by the supplier prior to shipment arrival, enabling pre-receipt planning and dock scheduling.. Valid values are `^[A-Z0-9]{8,30}$`',
    `case_count` STRING COMMENT 'Number of cases or cartons received in this inbound shipment.',
    `container_number` STRING COMMENT 'ISO standard container identifier for ocean freight shipments, following the BIC (Bureau International des Containers) format.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt record was first created in the system, representing the audit trail start point.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicator of whether any discrepancies (quantity, quality, or documentation) were identified during the receiving process.',
    `discrepancy_notes` STRING COMMENT 'Free-text description providing additional details about any discrepancies identified during the receiving process.',
    `discrepancy_reason` STRING COMMENT 'Classification of the type of discrepancy identified during receiving, used for root cause analysis and supplier performance management.. Valid values are `overage|shortage|damage|wrong_product|quality_issue|documentation_error`',
    `dock_door_number` STRING COMMENT 'Physical dock door location where the inbound shipment was unloaded, used for labor planning and dock utilization tracking.. Valid values are `^[A-Z0-9]{1,10}$`',
    `expected_quantity` DECIMAL(18,2) COMMENT 'Total quantity of goods expected to be received based on the ASN or purchase order, used for discrepancy detection.',
    `goods_receipt_document_number` STRING COMMENT 'SAP Material Management (MM) goods receipt document number generated upon posting the receipt to inventory, linking WMS to ERP.. Valid values are `^[A-Z0-9]{8,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt record was last updated, supporting audit trail and data lineage requirements.',
    `otif_compliant_flag` BOOLEAN COMMENT 'Indicator of whether this receipt met both on-time delivery and complete quantity requirements, key supplier performance metric.',
    `pallet_count` STRING COMMENT 'Number of pallets received in this inbound shipment, used for dock capacity planning and labor allocation.',
    `purchase_order_number` STRING COMMENT 'Reference to the originating purchase order that authorized this inbound shipment.. Valid values are `^[A-Z0-9]{8,20}$`',
    `putaway_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all received goods were moved from the receiving dock to their designated storage locations, completing the inbound process.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicator of whether formal quality inspection was required for this receipt based on product category, supplier risk profile, or regulatory requirements.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection process for this receipt, tracking progression through quality control workflow.. Valid values are `not_required|pending|in_progress|passed|failed`',
    `receipt_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all receiving activities (unloading, inspection, put-away) were completed and the receipt was closed in the WMS.',
    `receipt_number` STRING COMMENT 'Externally-known business identifier for the inbound receipt, used for tracking and reference across systems and with suppliers.. Valid values are `^[A-Z0-9]{8,20}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the inbound receipt transaction, tracking progression from scheduling through completion or exception handling.. Valid values are `scheduled|in_progress|completed|discrepancy|cancelled`',
    `receipt_type` STRING COMMENT 'Classification of the inbound receipt based on the source and nature of the goods being received.. Valid values are `supplier_delivery|plant_transfer|inter_dc_transfer|return_from_customer|production_output`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual total quantity of goods physically received and counted during the receiving process.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods rejected during receiving due to quality issues, damage, or non-conformance to specifications.',
    `scheduled_receipt_date` DATE COMMENT 'Planned date for the inbound shipment to arrive at the distribution center, based on ASN or supplier commitment.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicator of whether the security seal was found intact upon arrival, critical for quality control and loss prevention.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the trailer or container, verified upon receipt to ensure shipment integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,20}$`',
    `temperature_check_required_flag` BOOLEAN COMMENT 'Indicator of whether temperature verification was required for this receipt due to cold chain or temperature-sensitive product requirements.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicator of whether the recorded temperature was within acceptable range per product specifications and cold chain requirements.',
    `temperature_reading_celsius` DECIMAL(18,2) COMMENT 'Actual temperature reading in Celsius recorded during receipt inspection for temperature-sensitive products, critical for cold chain compliance.',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or truck that delivered the shipment, used for tracking and carrier performance analysis.. Valid values are `^[A-Z0-9]{4,20}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the quantities recorded in this receipt (Each, Case, Pallet, Kilogram, Pound, Liter, Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|EA|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_inbound_receipt PRIMARY KEY(`inbound_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of goods at a DC from suppliers, manufacturing plants, or inter-DC transfers. Records ASN reference, carrier, trailer/container ID, dock door, receipt date/time, received quantity by SKU/lot, temperature check results, and discrepancy flags. Integrates with SAP WM goods receipt and Blue Yonder WMS inbound processing. Drives inventory on-hand updates and FEFO/FIFO lot registration.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` (
    `inbound_receipt_line_id` BIGINT COMMENT 'Unique identifier for the inbound receipt line. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'User ID of the warehouse associate who physically received and recorded this line. Used for accountability and performance tracking.',
    `inbound_receipt_id` BIGINT COMMENT 'Reference to the parent inbound receipt header transaction. Links this line to the overall receipt event.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Needed to associate each receipt line (specific SKU/lot) with the RD project using it, enabling traceability of trial material consumption.',
    `regulatory_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Regulatory registration verification during inbound receipt ensures each received SKU is registered in the jurisdiction, a standard compliance step.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Link receipt line to SKU master for traceability and quality inspection; required by receipt processing and compliance audit reports.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: RECEIVING: When a receipt line is processed, a Stock Position record is created/updated to reflect on‑hand quantity at the DC.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who shipped the goods. Used for supplier performance tracking and procurement analytics.',
    `asn_line_number` STRING COMMENT 'Line number within the ASN document corresponding to this receipt line. Enables automated matching between ASN and physical receipt.',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice document number sent by the supplier prior to shipment arrival. Used for pre-receipt planning and variance detection.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `condition_code` STRING COMMENT 'Quality condition assessment of the received goods. Determines whether product can be put away into available inventory or requires special handling.. Valid values are `good|damaged|expired|quarantine|rejected|hold`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was first created in the warehouse management system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost and extended cost. Supports multi-currency procurement operations.. Valid values are `^[A-Z]{3}$`',
    `damage_description` STRING COMMENT 'Free-text description of any damage, defects, or quality issues observed during receipt inspection. Used for claims and supplier performance tracking.',
    `expected_quantity_cases` DECIMAL(18,2) COMMENT 'Expected quantity in cases as specified in the Advanced Shipping Notice (ASN) or purchase order. Used for variance detection.',
    `expected_quantity_eaches` DECIMAL(18,2) COMMENT 'Expected quantity in eaches as specified in the Advanced Shipping Notice (ASN) or purchase order. Used for variance detection.',
    `expiry_date` DATE COMMENT 'Date when the product expires and can no longer be sold or used. Critical for FEFO rotation and inventory management in consumer goods.',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total cost for this receipt line calculated as unit cost multiplied by received quantity. Used for inventory valuation and financial reconciliation.',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying the product in the supply chain. May be GTIN-8, GTIN-12, GTIN-13, or GTIN-14 format.. Valid values are `^[0-9]{8,14}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was last updated. Audit trail for tracking changes to receipt data.',
    `line_number` STRING COMMENT 'Sequential line number within the inbound receipt. Used for ordering and referencing specific lines in the receipt document.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number assigned by the supplier. Critical for traceability, quality control, and recall management in consumer goods.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `manufacture_date` DATE COMMENT 'Date when the product was manufactured by the supplier. Used for shelf-life calculations and FEFO inventory rotation.',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet or handling unit containing this receipt line. Used for put-away and storage location assignment.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `purchase_order_line_number` STRING COMMENT 'Line number on the purchase order corresponding to this receipt line. Enables three-way matching between PO, receipt, and invoice.',
    `purchase_order_number` STRING COMMENT 'Purchase order number authorizing the receipt of these goods. Links the receipt to the original procurement transaction.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `put_away_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were put away into their assigned storage location. Used for warehouse productivity and cycle time measurement.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this receipt line requires quality inspection before being released to available inventory. True for regulated or high-risk products.',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection for this receipt line. Determines whether goods can be released to available inventory or must remain in quarantine.. Valid values are `not_required|pending|in_progress|passed|failed|conditional`',
    `receipt_status` STRING COMMENT 'Current processing status of this receipt line within the warehouse workflow. Tracks progression from initial receipt through put-away completion.. Valid values are `pending|received|inspected|put_away|discrepancy|rejected`',
    `received_quantity_cases` DECIMAL(18,2) COMMENT 'Quantity of product received measured in cases. Represents the outer packaging unit typically used for warehouse handling.',
    `received_quantity_eaches` DECIMAL(18,2) COMMENT 'Quantity of product received measured in individual units (eaches). Represents the consumer-facing unit count.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were physically received at the warehouse dock. Critical for OTIF performance measurement and cycle time analytics.',
    `sscc` STRING COMMENT '18-digit Serial Shipping Container Code identifying the logistics unit. Global standard for tracking pallets and containers in the supply chain.. Valid values are `^[0-9]{18}$`',
    `storage_location_code` STRING COMMENT 'Warehouse storage location code where the received goods were put away. Identifies the bin, rack, or zone within the distribution center.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `temperature_at_receipt_celsius` DECIMAL(18,2) COMMENT 'Temperature measurement in Celsius recorded at the time of receipt. Critical for cold chain compliance and product quality verification.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for the received goods as specified in the purchase order. Used for inventory valuation and COGS calculation.',
    `unit_of_measure` STRING COMMENT 'Primary unit of measure for the received quantity. Defines the counting and handling unit for warehouse operations.. Valid values are `case|each|pallet|layer|inner_pack|display_unit`',
    `upc` STRING COMMENT 'Universal Product Code barcode identifier for the received item. Standard 12-digit UPC-A format used in North American retail.. Valid values are `^[0-9]{12}$`',
    `variance_quantity_cases` DECIMAL(18,2) COMMENT 'Difference between expected and received quantity in cases. Positive values indicate overages, negative values indicate shortages.',
    `variance_quantity_eaches` DECIMAL(18,2) COMMENT 'Difference between expected and received quantity in eaches. Positive values indicate overages, negative values indicate shortages.',
    `warehouse_code` STRING COMMENT 'Code identifying the distribution center or warehouse facility where the receipt occurred. Used for multi-site inventory management.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_inbound_receipt_line PRIMARY KEY(`inbound_receipt_line_id`)
) COMMENT 'Line-level detail for each SKU/lot received within an inbound receipt transaction. Captures SKU code, GTIN, lot number, manufacture date, expiry date, received quantity (cases and eaches), unit of measure, pallet ID, temperature at receipt, and variance from expected ASN quantity. Supports FEFO/FIFO lot registration and discrepancy resolution workflows.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` (
    `putaway_task_id` BIGINT COMMENT 'Unique identifier for the putaway task record generated by the WMS. Primary key for the putaway task entity.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse where the putaway task is executed.',
    `distribution_shipment_id` BIGINT COMMENT 'Identifier of the inbound shipment or receipt that triggered this putaway task, linking the task back to the receiving process for traceability.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse associate or operator assigned to execute this putaway task, used for labor tracking and productivity measurement.',
    `inventory_replenishment_order_id` BIGINT COMMENT 'Identifier of the replenishment order that generated this putaway task, applicable when the task type is replenishment from reserve to pick face.',
    `lot_batch_id` BIGINT COMMENT 'Identifier of the specific lot or batch being moved, critical for traceability, expiration management, and recall readiness.',
    `distribution_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse location from which the goods are being moved (e.g., receiving dock, staging area, reserve storage).',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU being moved in this putaway task.',
    `target_location_distribution_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse location to which the goods are being moved (e.g., reserve storage bin, pick face slot, cross-dock staging).',
    `confirmation_method` STRING COMMENT 'The method used by the warehouse operator to confirm task completion: barcode scan, RFID tag read, manual entry, voice-directed picking system, or vision-based verification.. Valid values are `barcode_scan|RFID|manual_entry|voice_pick|vision_system`',
    `cube_cubic_feet` DECIMAL(18,2) COMMENT 'The total volume in cubic feet of the goods being moved, used for space utilization analysis and slotting optimization.',
    `cycle_time_minutes` DECIMAL(18,2) COMMENT 'The elapsed time in minutes from task start to task completion, a key labor productivity KPI used to measure warehouse associate efficiency and identify process bottlenecks.',
    `equipment_code` BIGINT COMMENT 'Identifier of the material handling equipment (forklift, pallet jack, reach truck) used to execute the putaway task, tracked for equipment utilization and maintenance scheduling.',
    `exception_code` STRING COMMENT 'Code indicating any exception or issue encountered during putaway execution (e.g., damaged goods, location full, quantity mismatch, system error), used for root cause analysis and process improvement.. Valid values are `^[A-Z0-9_]{0,20}$`',
    `exception_description` STRING COMMENT 'Free-text description of the exception or issue encountered during putaway execution, providing additional context for operational review and corrective action.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the SKU being moved is classified as hazardous material, requiring special handling, storage segregation, and regulatory compliance per OSHA and EPA standards.',
    `movement_strategy` STRING COMMENT 'The inventory rotation or replenishment strategy applied to this putaway task: FEFO (First Expired First Out), FIFO (First In First Out), min/max threshold-based, kanban pull signal, wave-driven batch, zone-based slotting, or ABC classification velocity-based. [ENUM-REF-CANDIDATE: FEFO|FIFO|min_max|kanban|wave_driven|zone_based|ABC_classification — 7 candidates stripped; promote to reference product]',
    `pallet_code` STRING COMMENT 'Unique identifier of the pallet or handling unit being moved, typically a license plate number (LPN) or SSCC (Serial Shipping Container Code) scanned during putaway execution.. Valid values are `^[A-Z0-9]{10,25}$`',
    `priority_level` STRING COMMENT 'Numeric priority ranking assigned to the putaway task (typically 1-10, with 1 being highest priority) used by WMS to sequence work assignments and optimize labor allocation.',
    `quality_check_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the required quality inspection has been completed and passed, enabling downstream processes to proceed.',
    `quality_check_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a quality inspection is required before or after putaway completion, typically for high-value items, temperature-sensitive goods, or regulatory compliance.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU being moved in this putaway task, expressed in the unit of measure specified.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this putaway task record was first created in the source system, used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this putaway task record was last updated in the source system, used for change tracking and data freshness monitoring.',
    `source_location_code` STRING COMMENT 'Human-readable code of the source location (e.g., DOCK-A-01, STAGE-B-05) used by warehouse operators for navigation and scanning.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `system_source` STRING COMMENT 'The source system or module that generated this putaway task record (e.g., BLUE_YONDER_WMS, SAP_EWM, MANHATTAN_WMS), used for data lineage and integration troubleshooting.. Valid values are `^[A-Z0-9_]{2,50}$`',
    `target_location_code` STRING COMMENT 'Human-readable code of the target location (e.g., A-12-03-B, PICK-C-22) used by warehouse operators for navigation and scanning.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `task_assigned_timestamp` TIMESTAMP COMMENT 'The date and time when the putaway task was assigned to a warehouse operator, used to measure assignment latency and labor allocation efficiency.',
    `task_cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when the putaway task was cancelled, applicable when the task is aborted due to inventory discrepancies, system errors, or operational changes.',
    `task_completed_timestamp` TIMESTAMP COMMENT 'The date and time when the putaway task was completed (e.g., goods confirmed in target location), marking the end of the task lifecycle and enabling cycle time KPI calculation.',
    `task_created_timestamp` TIMESTAMP COMMENT 'The date and time when the putaway task was created by the WMS, marking the start of the task lifecycle and used for cycle time calculation.',
    `task_number` STRING COMMENT 'Human-readable business identifier for the putaway task, typically generated by Blue Yonder WMS for tracking and operator reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `task_started_timestamp` TIMESTAMP COMMENT 'The date and time when the warehouse operator began executing the putaway task (e.g., scanned the source location or pallet), used for labor productivity tracking.',
    `task_status` STRING COMMENT 'Current lifecycle status of the putaway task indicating its execution state within the warehouse workflow.. Valid values are `pending|assigned|in_progress|completed|cancelled|on_hold`',
    `task_type` STRING COMMENT 'Classification of the putaway task based on the movement purpose: inbound putaway (receiving dock to storage), replenishment (reserve to pick face), cross-dock (dock to dock), returns putaway (returns area to storage), or internal transfer.. Valid values are `inbound_putaway|replenishment|cross_dock|returns_putaway|transfer`',
    `temperature_zone` STRING COMMENT 'The temperature control zone classification for the target storage location: ambient (room temperature), refrigerated (2-8°C), frozen (<0°C), or controlled (specific temperature range), critical for cold chain compliance.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `travel_distance_feet` DECIMAL(18,2) COMMENT 'The physical distance in feet traveled by the warehouse operator from source to target location, used for slotting optimization and labor efficiency analysis.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the putaway quantity: EA (each), CS (case), PL (pallet), LB (pound), KG (kilogram), L (liter), GAL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    `wave_code` BIGINT COMMENT 'Identifier of the wave or batch of tasks to which this putaway task belongs, used for wave-driven replenishment and coordinated task execution.',
    `weight_lbs` DECIMAL(18,2) COMMENT 'The total weight in pounds of the goods being moved in this putaway task, used for equipment selection, labor safety, and capacity planning.',
    `zone_code` BIGINT COMMENT 'Identifier of the warehouse zone where the target location resides, used for labor assignment and zone-based picking strategies.',
    CONSTRAINT pk_putaway_task PRIMARY KEY(`putaway_task_id`)
) COMMENT 'Operational task record generated by Blue Yonder WMS directing warehouse associates to move goods within the DC — covering both inbound putaway (staging/dock to storage) and internal replenishment (reserve to pick face). Captures source location, target location, SKU, lot, pallet ID, assigned operator, task creation and completion timestamps, task type (inbound putaway, replenishment, cross-dock), movement strategy (FEFO, min/max, kanban, wave-driven), and priority. Tracks DC labor productivity, putaway cycle time, and pick face availability KPIs.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` (
    `outbound_order_id` BIGINT COMMENT 'Unique identifier for the outbound fulfillment order. Primary key for the outbound order entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional campaign fulfillment requires outbound orders to be tied to a specific campaign for inventory allocation and performance tracking.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to deliver the outbound order. Used for freight planning, carrier performance tracking, and proof of delivery.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Order Entry Accountability report tracking which sales employee created each outbound order for performance and audit.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: Freight order creation for every outbound order manages carrier tendering, freight cost tracking, and audit.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level financial and sales reporting aggregates order data by brand, so each outbound order must reference its primary brand.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order document in the ERP system. Links outbound fulfillment to revenue recognition and customer order management.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center fulfilling the outbound order. Determines inventory source and warehouse operations responsible for order execution.',
    `outbound_ship_to_location_distribution_facility_id` BIGINT COMMENT 'Identifier of the destination location where the order will be delivered. May reference retail store, warehouse, or customer facility.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Regulatory traceability: outbound orders must reference the production order that generated the shipped product for recall and compliance reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed for revenue recognition and profit‑center reporting; each outbound orders sales revenue is attributed to a profit center.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Supports pilot order execution; outbound orders for prototype SKUs are linked to the RD project that owns the launch trial.',
    `route_id` BIGINT COMMENT 'Identifier of the delivery route assigned to the outbound order. Used for DSD (Direct Store Delivery) route optimization and multi-stop delivery planning.',
    `sku_id` BIGINT COMMENT 'FK to product.sku.sku_id — Links distribution outbound orders to product master. Required for product-level fulfillment analytics, category-level DC throughput reporting.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the customer or retail account placing the outbound order. Links to trade account master for customer details, pricing agreements, and delivery preferences.',
    `actual_delivery_date` DATE COMMENT 'Date when the order was actually delivered to the customer destination. Used to calculate OTIF performance and delivery lead time.',
    `actual_ship_date` DATE COMMENT 'Date when the order was actually shipped from the distribution center. Used to measure warehouse execution performance against requested ship date.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether any line items on the order are backordered due to insufficient inventory. True when ordered quantity exceeds available stock.',
    `bill_of_lading_number` STRING COMMENT 'Carrier-issued document number serving as receipt of goods and contract of carriage. Required for freight claims and proof of delivery.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the order was cancelled. Examples include customer request, inventory shortage, credit hold, or duplicate order. Used for root cause analysis.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the order was cancelled. Null for active orders. Used for cancellation rate analysis and order lifecycle reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order record was first created in the system. Audit field for data lineage and order lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order value. Typically USD for domestic US operations, but may vary for export orders.. Valid values are `^[A-Z]{3}$`',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of ordered quantity that was fulfilled from available inventory. Calculated as (shipped quantity / ordered quantity) * 100. Key metric for inventory availability and customer service.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the order contains hazardous materials requiring special handling, labeling, and transportation compliance. True for products regulated under DOT hazmat rules.',
    `incoterm` STRING COMMENT 'International Commercial Terms defining the division of costs and risks between buyer and seller. Critical for export orders and freight responsibility determination. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order record was last updated. Audit field for change tracking and data quality monitoring.',
    `order_date` DATE COMMENT 'Date when the outbound order was created or received from the customer. Principal business event timestamp for order lifecycle tracking.',
    `order_status` STRING COMMENT 'Current lifecycle status of the outbound order. Draft indicates order creation, released means ready for fulfillment, picking/packing/staged represent warehouse execution phases, shipped indicates in-transit, delivered confirms receipt, cancelled indicates order termination. [ENUM-REF-CANDIDATE: draft|released|picking|packing|staged|shipped|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the outbound order based on fulfillment channel and destination. Retail replenishment serves store orders, DSD (Direct Store Delivery) bypasses DC, ecommerce serves online consumers, inter-DC transfer moves inventory between distribution centers, wholesale serves B2B customers, export serves international markets.. Valid values are `retail_replenishment|dsd|ecommerce|inter_dc_transfer|wholesale|export`',
    `otif_commitment_flag` BOOLEAN COMMENT 'Indicates whether this order is subject to formal OTIF performance measurement and customer scorecard reporting. True for orders with contractual delivery commitments.',
    `packing_slip_number` STRING COMMENT 'Document number for the packing slip accompanying the shipment. Used for customer receiving and invoice reconciliation.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the customer for this order. Examples include Net 30, Net 60, COD (Cash on Delivery), or prepaid. Impacts accounts receivable and cash flow management.',
    `pick_ticket_number` STRING COMMENT 'Warehouse document number used to direct picking operations for this order. Generated by WMS when order is released to the warehouse floor.',
    `priority_code` STRING COMMENT 'Priority level assigned to the outbound order for warehouse sequencing and resource allocation. Critical orders receive highest priority, rush orders are expedited, expedited orders have faster processing, standard orders follow normal flow.. Valid values are `standard|expedited|rush|critical`',
    `proof_of_delivery_timestamp` TIMESTAMP COMMENT 'Date and time when delivery was confirmed by the recipient. Captured from carrier POD or customer signature. Used for OTIF measurement and freight audit.',
    `purchase_order_number` STRING COMMENT 'Customers purchase order number provided for order tracking and invoice reconciliation. Required for EDI (Electronic Data Interchange) transactions with retail customers.',
    `requested_ship_date` DATE COMMENT 'Date when the customer or system requests the order to be shipped from the distribution center. Used for warehouse planning and scheduling.',
    `required_delivery_date` DATE COMMENT 'Date by which the order must be delivered to the customer destination. Critical for OTIF (On Time In Full) performance measurement and SLA compliance.',
    `service_level` STRING COMMENT 'Delivery speed commitment for the outbound order. Determines carrier selection, freight cost, and OTIF measurement criteria.. Valid values are `standard|next_day|two_day|same_day|scheduled`',
    `shipping_method` STRING COMMENT 'Transportation mode used for order delivery. Ground for truck, air for expedited freight, ocean for international, rail for bulk, parcel for small packages, LTL (Less Than Truckload) for partial loads, FTL (Full Truckload) for full loads. [ENUM-REF-CANDIDATE: ground|air|ocean|rail|parcel|ltl|ftl — 7 candidates stripped; promote to reference product]',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for warehouse and logistics teams regarding special handling requirements. May include temperature control, fragile handling, hazmat procedures, or customer-specific delivery instructions.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the order requires temperature-controlled storage and transportation. True for cold chain products requiring refrigeration or freezing.',
    `total_order_quantity` DECIMAL(18,2) COMMENT 'Total quantity of units across all line items in the outbound order. Used for warehouse capacity planning and OTIF fill rate calculation.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the outbound order before taxes and freight charges. Used for order prioritization, credit limit checks, and revenue forecasting.',
    `total_order_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the outbound order in cubic meters. Used for warehouse space planning, truck cube utilization, and pallet configuration.',
    `total_order_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the outbound order in kilograms. Used for freight cost calculation, carrier capacity planning, and vehicle loading optimization.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility and customer self-service tracking. Used for parcel and LTL shipments.',
    `wave_code` BIGINT COMMENT 'Identifier of the warehouse wave that includes this order. Wave picking groups orders for efficient batch picking and resource optimization.',
    CONSTRAINT pk_outbound_order PRIMARY KEY(`outbound_order_id`)
) COMMENT 'Master outbound fulfillment order record representing a customer or retailer replenishment request to be fulfilled from a DC. Captures order number, order type (retail replenishment, DSD, e-commerce, inter-DC transfer), customer/account reference, requested ship date, required delivery date, priority, OTIF commitment, and order status lifecycle. Sourced from SAP SD and Salesforce Consumer Goods Cloud order management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` (
    `outbound_order_line_id` BIGINT COMMENT 'Unique identifier for the outbound order line item.',
    `distribution_storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Outbound order line items are stored in a DC location before picking. Adding a FK to distribution_storage_location enables location lookup and normalizes location data.',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Label version compliance check before order fulfillment guarantees the label used for the SKU is approved for the destination market.',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound fulfillment order header.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotion Attribution Report requires linking each order line to the promotion event that drove the sale; experts expect this FK to attribute revenue to promotions.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: PICKING: Outbound order line pick reduces the corresponding Stock Position quantity, linking order fulfillment to inventory balances.',
    `actual_ship_date` DATE COMMENT 'Actual date the line was shipped from the distribution center.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity allocated from warehouse inventory to this order line.',
    `base_unit_quantity` DECIMAL(18,2) COMMENT 'Quantity converted to base unit of measure for standardized reporting and inventory tracking.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed available for fulfillment after ATP (Available to Promise) check.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order line record was first created in the system.',
    `customer_po_line_number` STRING COMMENT 'Customers purchase order line number for cross-reference and reconciliation.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this line is part of a direct store delivery order bypassing retailer distribution centers.',
    `edi_line_reference` STRING COMMENT 'EDI transaction line reference number for electronic order processing and ASN generation.',
    `expiry_date` DATE COMMENT 'Product expiration date for FEFO inventory rotation and shelf-life management.',
    `gtin` STRING COMMENT 'Global trade item number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) for the product being shipped.. Valid values are `^[0-9]{8,14}$`',
    `handling_unit_code` STRING COMMENT 'Serial shipping container code (SSCC) or handling unit identifier for the container holding this line item.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this line contains hazardous materials requiring special handling and documentation.',
    `line_number` STRING COMMENT 'Sequential line number within the outbound order for ordering and identification.',
    `line_status` STRING COMMENT 'Current fulfillment status of the order line in the warehouse execution lifecycle. [ENUM-REF-CANDIDATE: open|allocated|picked|packed|shipped|cancelled|short_shipped — 7 candidates stripped; promote to reference product]',
    `line_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the shipped quantity for this line in cubic meters.',
    `line_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipped quantity for this line in kilograms.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number for traceability and quality control.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU originally requested by the customer in the order.',
    `otif_status` STRING COMMENT 'Line-level OTIF performance status indicating whether the line was delivered on time and in full quantity.. Valid values are `on_time_in_full|late_in_full|on_time_partial|late_partial`',
    `pack_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was packed into shipping containers.',
    `packed_quantity` DECIMAL(18,2) COMMENT 'Quantity packed into shipping containers and ready for dispatch.',
    `pallet_code` STRING COMMENT 'Pallet identifier if the line item was shipped on a palletized load.',
    `pick_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was picked from warehouse inventory.',
    `pick_zone` STRING COMMENT 'Warehouse pick zone designation for labor management and routing optimization.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'Quantity physically picked from warehouse storage locations during fulfillment.',
    `requested_ship_date` DATE COMMENT 'Customer-requested or system-calculated target ship date for this line.',
    `serial_numbers` STRING COMMENT 'Comma-separated list of serial numbers for serialized inventory items shipped on this line.',
    `ship_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was shipped from the distribution center.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Quantity actually shipped to the customer, may differ from ordered due to short-ship scenarios.',
    `short_ship_flag` BOOLEAN COMMENT 'Indicates whether this line was short-shipped (shipped quantity less than ordered quantity).',
    `short_ship_reason_code` STRING COMMENT 'Reason code for short shipment (OOS=Out of Stock, DAMAGE=Damaged Inventory, RECALL=Product Recall, EXPIRED=Expired Product, ALLOCATION=Allocation Constraint).. Valid values are `OOS|DAMAGE|RECALL|EXPIRED|ALLOCATION`',
    `sku_code` STRING COMMENT 'Internal stock keeping unit code identifying the specific product variant being shipped.. Valid values are `^[A-Z0-9]{6,20}$`',
    `storage_location_code` STRING COMMENT 'Specific storage location or bin within the warehouse where the product was picked from.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this line requires temperature-controlled storage and transportation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities (EA=Each, CS=Case, PL=Pallet, BX=Box, KG=Kilogram, LB=Pound, LT=Liter, GL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|BX|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    `unit_volume_m3` DECIMAL(18,2) COMMENT 'Volume per unit of the SKU in cubic meters for space utilization and load planning.',
    `unit_weight_kg` DECIMAL(18,2) COMMENT 'Weight per unit of the SKU in kilograms for freight calculation and capacity planning.',
    `upc` STRING COMMENT 'Universal product code (UPC-A) for retail scanning and point-of-sale identification.. Valid values are `^[0-9]{12}$`',
    `warehouse_location_code` STRING COMMENT 'Distribution center or warehouse location code from which this line was fulfilled.',
    CONSTRAINT pk_outbound_order_line PRIMARY KEY(`outbound_order_line_id`)
) COMMENT 'Line-level detail for each SKU within an outbound fulfillment order. Records SKU code, GTIN, ordered quantity, confirmed quantity, allocated quantity, picked quantity, shipped quantity, unit of measure, lot number, expiry date, and line-level OTIF status. Enables order fill rate tracking, short-ship identification, and OSA impact analysis at the SKU-customer level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` (
    `pick_task_id` BIGINT COMMENT 'Unique identifier for the pick task record. Primary key for the pick_task data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pick task labor costs are charged to a cost center; required for labor cost analysis and OTIF performance metrics.',
    `distribution_storage_location_id` BIGINT COMMENT 'Reference to the target location where picked items are staged or packed (e.g., pack station, staging lane, loading dock).',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse where the pick task is executed.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific lot or batch of inventory being picked. Critical for FEFO (First Expired First Out) and FIFO (First In First Out) rotation compliance.',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound order or shipment order that generated this pick task.',
    `primary_pick_distribution_storage_location_id` BIGINT COMMENT 'Reference to the warehouse storage location (bin, shelf, pallet position) from which inventory is picked.',
    `employee_id` BIGINT COMMENT 'Reference to the warehouse operator or picker assigned to execute this task.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU being picked or packed in this task.',
    `carton_code` STRING COMMENT 'Unique identifier for the carton or shipping container into which items are packed. May be a license plate number (LPN) or SSCC (Serial Shipping Container Code).. Valid values are `^CTN[0-9A-Z]{8,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task record was first created in the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dsd_flag` BOOLEAN COMMENT 'Boolean indicator of whether this pick task is part of a Direct Store Delivery (DSD) execution workflow (true = DSD, false = standard distribution).',
    `exception_code` STRING COMMENT 'Code identifying any exception or issue encountered during task execution (e.g., short pick, damaged goods, location discrepancy). Null if no exception.. Valid values are `^[A-Z0-9]{2,6}$`',
    `exception_notes` STRING COMMENT 'Free-text notes entered by the operator or supervisor describing the exception or issue encountered during task execution.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the packed carton or pallet including product and packaging materials, measured in kilograms.',
    `gs1_128_label` STRING COMMENT 'The GS1-128 barcode label data applied to the carton or pallet, encoding SSCC, GTIN, lot, expiry, and other supply chain attributes.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the packed carton or pallet, measured in centimeters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task record was last updated in the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the packed carton or pallet, measured in centimeters.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product content only (excluding packaging), measured in kilograms.',
    `otif_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this pick task is subject to OTIF (On Time In Full) performance measurement (true = OTIF tracked, false = not tracked).',
    `pack_station_code` BIGINT COMMENT 'Reference to the packing station where the packing operation is performed. Applicable when task_type includes packing.',
    `packaging_material_code` STRING COMMENT 'Code identifying the type of packaging material used (e.g., corrugated box, poly bag, shrink wrap). Used for cartonization and sustainability tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet onto which cartons or items are loaded. Typically an SSCC or internal LPN.. Valid values are `^PLT[0-9A-Z]{8,15}$`',
    `pick_accuracy_flag` BOOLEAN COMMENT 'Boolean indicator of whether the pick was accurate (true = picked quantity matches requested quantity and correct SKU/lot; false = discrepancy detected).',
    `pick_list_number` STRING COMMENT 'Human-readable pick list reference number assigned by the WMS for operator identification and tracking.. Valid values are `^PL[0-9]{8,12}$`',
    `pick_quantity` DECIMAL(18,2) COMMENT 'The quantity of SKU units to be picked for this task, measured in the SKUs base unit of measure.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of SKU units picked by the operator. May differ from pick_quantity due to short picks or overages.',
    `picking_strategy` STRING COMMENT 'The picking methodology applied: discrete (single order), batch (multiple orders), zone (by warehouse zone), wave (grouped by wave), cluster (multi-order cart picking).. Valid values are `discrete|batch|zone|wave|cluster`',
    `priority_level` STRING COMMENT 'Priority classification of the pick task for sequencing and resource allocation: urgent (immediate), high (expedited), normal (standard), low (backlog).. Valid values are `urgent|high|normal|low`',
    `sscc` STRING COMMENT '18-digit GS1 Serial Shipping Container Code uniquely identifying the logistics unit (carton or pallet) for tracking through the supply chain.. Valid values are `^[0-9]{18}$`',
    `task_assigned_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task was assigned to an operator by the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task was completed and confirmed by the operator or WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from task start to completion. Used for labor productivity analysis and standard time calculation.',
    `task_started_timestamp` TIMESTAMP COMMENT 'Timestamp when the operator began executing the pick task (scanned start or confirmed task initiation). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_status` STRING COMMENT 'Current lifecycle status of the pick task: pending (awaiting assignment), assigned (allocated to operator), in_progress (actively being executed), completed (finished successfully), cancelled (voided), on_hold (temporarily suspended).. Valid values are `pending|assigned|in_progress|completed|cancelled|on_hold`',
    `task_type` STRING COMMENT 'Discriminator indicating the type of fulfillment task: pick (picking only), pack (packing only), pick_and_pack (combined operation), or replenishment_pick (internal stock movement).. Valid values are `pick|pack|pick_and_pack|replenishment_pick`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for pick and picked quantities (e.g., EA for each, CS for case, PL for pallet).. Valid values are `^[A-Z]{2,3}$`',
    `wave_code` BIGINT COMMENT 'Reference to the wave batch that groups multiple pick tasks for optimized execution. Supports wave picking strategy.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the packed carton or pallet, measured in centimeters.',
    CONSTRAINT pk_pick_task PRIMARY KEY(`pick_task_id`)
) COMMENT 'Fulfillment task record covering both picking and packing operations within DC outbound execution. For picking: captures pick list reference, source location, SKU, lot, pick quantity, assigned operator, wave/batch reference, pick accuracy flag, and task timestamps. For packing: captures pack station, carton/pallet ID, packed SKUs and quantities, packaging material, gross weight, dimensions, GS1-128/SSCC label, and packer operator. Supports wave picking, batch picking, zone picking, and cartonization strategies in Blue Yonder WMS. Task_type discriminator distinguishes pick vs pack execution steps.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` (
    `pack_task_id` BIGINT COMMENT 'Unique identifier for the packing task record. Primary key.',
    `outbound_order_id` BIGINT COMMENT 'Reference to the outbound order being packed for dispatch.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse operator who performed the packing task.',
    `sku_id` BIGINT COMMENT 'add column sku_id (BIGINT) with FK to product.sku.sku_id - pack tasks must identify which product is being packed',
    `carrier_code` STRING COMMENT 'Code identifying the logistics carrier assigned to transport the packed container.',
    `carton_code` STRING COMMENT 'Unique identifier for the shipping carton or container used for packing.',
    `cartonization_rule_code` BIGINT COMMENT 'Reference to the cartonization algorithm or business rule used to determine optimal packing configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task record was first created in the system.',
    `destination_facility_code` STRING COMMENT 'Code identifying the destination distribution center, retail store, or customer facility for the packed shipment.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this pack task is for Direct Store Delivery channel bypassing distribution center.',
    `exception_code` STRING COMMENT 'Code identifying any exception or issue encountered during the packing process.',
    `exception_notes` STRING COMMENT 'Free-text notes describing any exceptions, issues, or special handling instructions for the pack task.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the packed container including product and packaging materials, measured in kilograms.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the packed container contains hazardous materials requiring special handling and labeling.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the packed container in centimeters.',
    `label_printed_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipping label was printed for the packed container.',
    `label_type` STRING COMMENT 'Type of shipping label applied to the packed container.. Valid values are `gs1_128|sscc|shipping_label|hazmat|custom`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task record was last updated in the system.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the packed container in centimeters.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product contents excluding packaging materials, measured in kilograms.',
    `otif_target_ship_date` DATE COMMENT 'Target ship date for OTIF performance measurement and customer service level compliance.',
    `pack_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the packing task was completed and sealed for dispatch.',
    `pack_duration_minutes` DECIMAL(18,2) COMMENT 'Total time in minutes taken to complete the packing task, used for labor productivity analysis.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the packing task was initiated by the operator.',
    `pack_station_code` STRING COMMENT 'Identifier of the physical pack station or workstation where packing occurred.',
    `pack_status` STRING COMMENT 'Current lifecycle status of the packing task.. Valid values are `pending|in_progress|completed|verified|exception|cancelled`',
    `pack_type` STRING COMMENT 'Type of packing configuration used for the task.. Valid values are `carton|pallet|mixed_pallet|overpack|bulk`',
    `packaging_material_code` STRING COMMENT 'Code identifying the type of packaging material used for the carton or pallet.',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet if items were packed onto a pallet for shipment.',
    `quality_check_status` STRING COMMENT 'Status of quality verification performed on the packed container before dispatch.. Valid values are `not_required|pending|passed|failed`',
    `sscc` STRING COMMENT 'GS1-128 compliant 18-digit Serial Shipping Container Code applied to the packed unit for supply chain traceability.. Valid values are `^d{18}$`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the packed container requires temperature-controlled transportation and storage.',
    `total_sku_count` STRING COMMENT 'Total number of distinct SKUs packed into the container.',
    `total_unit_quantity` DECIMAL(18,2) COMMENT 'Total quantity of units packed across all SKUs in the container.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility and proof of delivery.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volumetric capacity of the packed container in cubic meters, used for transportation planning.',
    `wave_code` BIGINT COMMENT 'Reference to the wave or batch grouping of orders for coordinated picking and packing.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the packed container in centimeters.',
    CONSTRAINT pk_pack_task PRIMARY KEY(`pack_task_id`)
) COMMENT 'Packing task record capturing the consolidation and packaging of picked items into shipping cartons or pallets for outbound dispatch. Records pack station ID, outbound order reference, carton/pallet ID, packed SKUs and quantities, packaging material used, gross weight, dimensions, label applied (GS1-128 / SSCC), pack completion timestamp, and packer operator ID. Drives cartonization and pallet build compliance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` (
    `distribution_shipment_id` BIGINT COMMENT 'Unique identifier for the distribution shipment record. Primary key for the distribution shipment entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: OTIF and delivery KPI dashboards measure shipment performance per marketing campaign, requiring a direct shipment‑to‑campaign link.',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset. Business justification: Required for carbon‑offset tracking per shipment to meet ESG reporting and carbon‑neutral logistics commitments.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for shipment cost allocation report; logistics expenses are charged to a cost center, a standard practice in consumer‑goods distribution.',
    `intransit_shipment_id` BIGINT COMMENT 'Foreign key linking to inventory.intransit_shipment. Business justification: SHIPMENT HAND‑OFF: Distribution shipment creates an In‑Transit Shipment record to track movement from DC to destination.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: Costing and transit planning use lane definitions; linking shipment to lane provides distance, rate, and compliance data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Load Execution Log to record which warehouse employee performed the loading of each shipment, supporting OTIF compliance and labor costing.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Shipment origin tracking: linking shipments to the originating manufacturing facility enables performance dashboards and OTIF analysis.',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order. Business justification: Shipment is a child of an outbound order; each shipment fulfills an order. Adding outbound_order_id to distribution_shipment creates the necessary parent link without creating a bidirectional relation',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Shipment Manifest for Promotional Campaigns tracks which shipment fulfills which promotion event, used for logistics planning and compliance reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: OTIF reporting requires tying each shipment to its originating purchase order to measure delivery performance against contractual commitments.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Enables shipment‑level reporting for R&D pilot shipments, required for OTIF and regulatory compliance of trial product deliveries.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment was delivered and received at the destination. Used for final OTIF calculation.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment departed the DC. Critical for OTIF calculation and carrier performance tracking.',
    `bill_of_lading_number` STRING COMMENT 'Unique identifier of the bill of lading document issued by the carrier. Legal document for freight movement and proof of shipment.',
    `carrier_code` STRING COMMENT 'Identifier of the transportation carrier responsible for moving the shipment from DC to destination.',
    `carrier_name` STRING COMMENT 'Business name of the transportation carrier for display and reporting purposes.',
    `carrier_service_level` STRING COMMENT 'Service tier selected for this shipment defining speed and handling requirements.. Valid values are `ground|express|overnight|two_day|economy|premium`',
    `carton_count` STRING COMMENT 'Total number of cartons or cases included in the shipment. Used for piece-level tracking and receiving verification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment record was first created in the WMS. Audit trail for shipment lifecycle tracking.',
    `destination_address_line1` STRING COMMENT 'Primary street address line of the shipment destination. Organizational contact data classified as confidential.',
    `destination_city` STRING COMMENT 'City name of the shipment destination address.',
    `destination_code` STRING COMMENT 'Business identifier of the destination location (store number, DC code, customer account number) where goods are being delivered.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the shipment destination for customs and routing purposes.. Valid values are `^[A-Z]{3}$`',
    `destination_name` STRING COMMENT 'Human-readable name of the destination location for display and confirmation purposes.',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code of the shipment destination. Organizational contact data classified as confidential.',
    `destination_state_province` STRING COMMENT 'State or province code of the shipment destination address.',
    `destination_type` STRING COMMENT 'Classification of the shipment destination entity type for routing and handling purposes.. Valid values are `retail_store|distribution_center|customer|warehouse|third_party`',
    `dock_door_number` STRING COMMENT 'Identifier of the loading dock door at the source DC where the shipment was staged and loaded.',
    `estimated_delivery_timestamp` TIMESTAMP COMMENT 'Current estimated delivery date and time based on real-time tracking and carrier updates. Updated dynamically during transit.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight cost charged for this shipment in the transaction currency. Used for logistics cost analysis and freight audit.',
    `freight_currency_code` STRING COMMENT 'Three-letter ISO currency code for the freight charge amount.. Valid values are `^[A-Z]{3}$`',
    `freight_terms` STRING COMMENT 'Terms defining which party is responsible for freight payment and at what point ownership transfers. Critical for cost allocation.. Valid values are `prepaid|collect|third_party|fob_origin|fob_destination`',
    `goods_issue_document_number` STRING COMMENT 'SAP SD goods issue document number linking the physical shipment to the ERP inventory transaction. Critical for inventory accuracy.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator of whether this shipment contains hazardous materials requiring special handling and documentation per DOT regulations.',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment was delivered complete with all ordered quantities. Component of OTIF calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment record was last updated. Audit trail for change tracking and data freshness verification.',
    `line_item_count` STRING COMMENT 'Total number of distinct SKU line items included in the shipment. Used for picking complexity and receiving planning.',
    `load_number` STRING COMMENT 'Identifier of the load plan that consolidated multiple orders or shipments into this trailer. Used for load optimization tracking.',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment was delivered within the committed delivery window. Component of OTIF calculation.',
    `otif_status` STRING COMMENT 'Calculated OTIF performance status indicating whether the shipment was delivered on time and complete per customer commitment. Key supply chain KPI.. Valid values are `on_time_in_full|late|incomplete|damaged|not_applicable`',
    `pallet_count` STRING COMMENT 'Total number of pallets included in the shipment. Used for handling unit tracking and dock labor planning.',
    `pro_number` STRING COMMENT 'Carrier-assigned progressive number used for tracking and tracing the shipment in the carriers system.',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for the shipment to arrive at the destination. Used for customer commitment and OTIF measurement.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time for the shipment to arrive at the destination. Precision timestamp for delivery window commitments.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time for the shipment to depart from the DC dock. Precision timestamp for appointment scheduling and carrier coordination.',
    `scheduled_ship_date` DATE COMMENT 'Planned date for the shipment to depart from the distribution center. Used for OTIF performance measurement baseline.',
    `seal_number` STRING COMMENT 'Unique identifier of the security seal applied to the trailer or container to ensure shipment integrity and prevent tampering.',
    `shipment_number` STRING COMMENT 'Externally-known unique business identifier for the shipment assigned by the WMS. Used for tracking and reference across systems and with carriers.. Valid values are `^SHP[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment in the outbound fulfillment workflow. Tracks progression from planning through final delivery. [ENUM-REF-CANDIDATE: planned|staged|loading|loaded|departed|in_transit|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on delivery method and business purpose. DSD indicates Direct Store Delivery channel.. Valid values are `standard|expedited|dsd|cross_dock|transfer|return`',
    `source_dc_code` STRING COMMENT 'Code identifying the originating distribution center from which goods are being shipped.. Valid values are `^DC[0-9]{4}$`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this shipment requires temperature-controlled transportation for product integrity.',
    `total_units` STRING COMMENT 'Total quantity of individual sellable units (eaches) included in the shipment across all SKUs.',
    `total_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total cube or volume of the shipment in cubic meters. Critical for trailer utilization and dimensional weight calculations.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms including product and packaging. Used for freight rating and load planning.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for real-time shipment visibility and customer self-service tracking.',
    `trailer_number` STRING COMMENT 'Identifier of the trailer or container unit used to transport the shipment. Critical for load tracking and yard management.',
    `wave_number` STRING COMMENT 'Identifier of the warehouse picking wave that generated the orders included in this shipment. Links shipment to WMS wave planning.',
    CONSTRAINT pk_distribution_shipment PRIMARY KEY(`distribution_shipment_id`)
) COMMENT 'Outbound shipment record representing the physical dispatch of goods from a DC to a customer, retailer, or downstream DC. Captures shipment number, carrier, trailer/container ID, seal number, dock door, scheduled and actual departure datetime, destination, total weight, total cube, pallet count, carton count, and OTIF status. Integrates with Blue Yonder WMS load planning and SAP SD goods issue. SSOT for DC-level outbound shipment execution distinct from the logistics domains carrier-level shipment tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` (
    `inventory_position_id` BIGINT COMMENT 'Primary key for inventory_position',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Inventory compliance reporting links each inventory position to its applicable regulatory obligation to track deadlines and status.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center where the inventory is physically located.',
    `distribution_storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Inventory position records on‑hand quantities at a specific DC location. Linking to distribution_storage_location provides the authoritative location details and removes the generic storage_location_i',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supports Inventory Ownership Dashboard, assigning a responsible employee for each DC inventory position for accountability and cycle‑count oversight.',
    `lot_batch_id` BIGINT COMMENT 'Identifier of the specific lot or batch of the SKU. Critical for traceability, quality control, and FEFO inventory rotation.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Provides real‑time visibility of prototype SKU inventory tied to the RD project, essential for launch readiness dashboards.',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU for which inventory position is tracked.',
    `actual_weight` DECIMAL(18,2) COMMENT 'The actual measured weight of the inventory for catch weight items. Used for billing and compliance when item weight varies.',
    `catch_weight_flag` BOOLEAN COMMENT 'Indicates whether the SKU is a catch weight item requiring actual weight capture at transaction time (true) or standard weight (false).',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The unit cost of the inventory lot. Used for inventory valuation and cost of goods sold calculations. Business confidential financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for inventory valuation (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `days_on_hand` STRING COMMENT 'The number of days the inventory has been on hand since receipt. Calculated as current date minus receipt date. Used for aging analysis.',
    `days_to_expiry` STRING COMMENT 'The number of days remaining until the inventory lot expires. Calculated as expiry date minus current date. Critical for FEFO rotation and markdown decisions.',
    `expiry_date` DATE COMMENT 'The date on which the product lot expires and can no longer be sold or distributed. Critical for FEFO inventory management and regulatory compliance.',
    `inventory_condition` STRING COMMENT 'The physical condition classification of the inventory. Used for disposition decisions and channel restrictions.. Valid values are `new|refurbished|returned|damaged|expired|recalled`',
    `inventory_status` STRING COMMENT 'The current operational status of the inventory position. Determines availability for picking and order fulfillment.. Valid values are `available|allocated|quarantine|hold|damaged|expired`',
    `last_cycle_count_date` DATE COMMENT 'The date when this inventory position was last physically counted during a cycle count operation. Used to schedule next count and assess inventory accuracy.',
    `last_movement_date` DATE COMMENT 'The date when inventory was last moved into or out of this storage location. Used for slow-moving inventory identification.',
    `last_movement_type` STRING COMMENT 'The type of the last inventory movement transaction that affected this position (receipt, putaway, pick, replenishment, transfer, adjustment, return). [ENUM-REF-CANDIDATE: receipt|putaway|pick|replenishment|transfer|adjustment|return — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position record was last modified. Used for change tracking and data freshness assessment.',
    `license_plate_number` STRING COMMENT 'The warehouse management system license plate number assigned to the handling unit. Used for tracking and automated material handling.',
    `lot_number` STRING COMMENT 'The alphanumeric lot or batch number assigned during manufacturing. Used for traceability and recall management.',
    `manufacture_date` DATE COMMENT 'The date on which the product lot was manufactured. Used for shelf-life calculations and FEFO rotation.',
    `owner_type` STRING COMMENT 'Indicates the ownership model of the inventory (owned by company, consignment from supplier, customer-owned for returns, vendor-managed inventory).. Valid values are `owned|consignment|customer_owned|vendor_managed`',
    `pallet_code` STRING COMMENT 'The unique identifier of the pallet or handling unit on which the inventory is stored. Used for warehouse automation and tracking.',
    `pick_face_flag` BOOLEAN COMMENT 'Indicates whether this inventory position is in a primary pick face location (true) or reserve storage (false). Pick face locations are optimized for order picking efficiency.',
    `putaway_date` DATE COMMENT 'The date when the inventory was put away into this storage location after receiving. Used for aging analysis and FEFO compliance.',
    `quantity_allocated` DECIMAL(18,2) COMMENT 'The quantity of on-hand inventory that has been allocated to outbound orders or reservations but not yet picked. Reduces available-to-pick quantity.',
    `quantity_available` DECIMAL(18,2) COMMENT 'The quantity available for new order allocation and picking. Calculated as quantity_on_hand minus quantity_allocated minus quantity_quarantine minus quantity_hold.',
    `quantity_damaged` DECIMAL(18,2) COMMENT 'The quantity of inventory identified as damaged and not suitable for sale or distribution. Typically awaiting disposal or return to supplier.',
    `quantity_hold` DECIMAL(18,2) COMMENT 'The quantity of inventory placed on hold due to quality issues, customer complaints, or pending investigation. Not available for picking.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The total physical quantity of the SKU-lot currently present in the storage location. Measured in the SKUs base unit of measure.',
    `quantity_quarantine` DECIMAL(18,2) COMMENT 'The quantity of inventory placed in quarantine status pending quality inspection or regulatory clearance. Not available for picking.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'The quantity of inventory reserved for specific customers, channels, or promotional programs. Subset of allocated quantity with additional business constraints.',
    `receipt_date` DATE COMMENT 'The date when the inventory lot was received into the distribution center. Used for inventory aging and supplier performance tracking.',
    `replenishment_flag` BOOLEAN COMMENT 'Indicates whether this inventory position requires replenishment from reserve to pick face (true) or not (false). Triggers automated replenishment tasks.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position snapshot was captured. Used for point-in-time inventory reporting and trend analysis.',
    `storage_zone` STRING COMMENT 'The logical zone within the distribution center where the inventory is stored (e.g., ambient, refrigerated, frozen, hazmat, high-velocity, reserve).',
    `temperature_zone` STRING COMMENT 'The temperature control zone classification for the storage location. Critical for cold chain compliance and product quality.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'The total financial value of the inventory position calculated as quantity_on_hand multiplied by cost_per_unit. Used for balance sheet reporting. Business confidential financial data.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure in which inventory quantities are tracked (Each, Case, Pallet, Pound, Kilogram, Liter, Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    `weight_unit_of_measure` STRING COMMENT 'The unit of measure for actual weight (Pound, Kilogram, Ounce, Gram). Applicable for catch weight items.. Valid values are `LB|KG|OZ|G`',
    CONSTRAINT pk_inventory_position PRIMARY KEY(`inventory_position_id`)
) COMMENT 'Current on-hand inventory position at the DC-location-SKU-lot level within distribution center walls. Captures storage location, SKU, lot number, manufacture and expiry dates, quantity on hand, allocated quantity, available-to-pick (ATP) quantity, quarantine quantity, inventory status (available, hold, damaged, expired), and last cycle count date. This is the operational working inventory view for DC execution — distinct from the inventory domains network-wide planning position which aggregates across all nodes.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` (
    `distribution_cycle_count_id` BIGINT COMMENT 'Unique identifier for the cycle count event record. Primary key for the distribution cycle count entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager who approved the cycle count adjustment.',
    `distribution_facility_id` BIGINT COMMENT 'add column distribution_facility_id (BIGINT) with FK to distribution.distribution_facility.distribution_facility_id - cycle counts occur at a specific distribution facility',
    `distribution_storage_location_id` BIGINT COMMENT 'Identifier of the distribution center where the cycle count was performed.',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the specific storage location (bin, rack, aisle) within the DC where the count was performed.',
    `lot_batch_id` BIGINT COMMENT 'Identifier of the specific lot or batch being counted, critical for FEFO/FIFO inventory rotation and traceability.',
    `primary_distribution_counter_employee_id` BIGINT COMMENT 'Identifier of the warehouse associate who performed the physical count.',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU being counted in this cycle count line.',
    `abc_classification` STRING COMMENT 'ABC inventory classification of the SKU at the time of count: A (high value/velocity), B (medium), C (low), D (obsolete/slow-moving).. Valid values are `A|B|C|D`',
    `adjustment_approved_flag` BOOLEAN COMMENT 'Indicates whether the inventory adjustment has been approved by a supervisor or manager.',
    `adjustment_required_flag` BOOLEAN COMMENT 'Indicates whether an inventory adjustment is required based on the variance exceeding tolerance thresholds.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the cycle count adjustment was approved by a supervisor or manager.',
    `count_end_timestamp` TIMESTAMP COMMENT 'The date and time when the physical counting activity was completed.',
    `count_method` STRING COMMENT 'The method used to perform the physical count: manual (paper-based), RF scanner (handheld device), voice picking (voice-directed), or automated (RFID/sensor).. Valid values are `manual|rf_scanner|voice_picking|automated`',
    `count_number` STRING COMMENT 'Business identifier for the cycle count event, typically generated by the WMS. Format: CC-YYYYMMDD-NNNN.. Valid values are `^CC-[0-9]{8}-[0-9]{4}$`',
    `count_reason_code` STRING COMMENT 'The business reason triggering this cycle count: routine (scheduled ABC cycle), discrepancy (prior variance), audit (compliance), quality (QC hold), recall (product recall), transfer (location move).. Valid values are `routine|discrepancy|audit|quality|recall|transfer`',
    `count_start_timestamp` TIMESTAMP COMMENT 'The date and time when the physical counting activity began.',
    `count_status` STRING COMMENT 'Current lifecycle status of the cycle count event.. Valid values are `planned|in_progress|completed|cancelled|under_review`',
    `count_type` STRING COMMENT 'Classification of the cycle count event: scheduled (routine ABC cycle), ad-hoc (unplanned), exception (triggered by discrepancy), blind (counter does not see system quantity), or targeted (specific SKU/lot focus).. Valid values are `scheduled|ad_hoc|exception|blind|targeted`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The actual physical quantity counted by the warehouse associate during the cycle count event.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cycle count record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the inventory value variance amount.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'The expiration or best-before date of the lot/batch being counted, critical for FEFO inventory rotation.',
    `inventory_value_variance_amount` DECIMAL(18,2) COMMENT 'The financial impact of the variance, calculated as variance_quantity multiplied by the standard cost of the SKU. Expressed in the DCs functional currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cycle count record was last updated in the system.',
    `recount_number` STRING COMMENT 'Sequential number indicating which recount iteration this represents (1 for first recount, 2 for second, etc.). Null if no recount performed.',
    `recount_required_flag` BOOLEAN COMMENT 'Indicates whether a recount is required due to significant variance or quality control procedures.',
    `scheduled_date` DATE COMMENT 'The date on which the cycle count was scheduled to be performed.',
    `stock_status` STRING COMMENT 'The inventory status of the counted stock: available (unrestricted), hold (QC hold), quarantine (quality review), damaged, expired, or reserved (allocated to orders).. Valid values are `available|hold|quarantine|damaged|expired|reserved`',
    `system_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU/lot recorded in the WMS at the time of the cycle count.',
    `tolerance_threshold_percentage` DECIMAL(18,2) COMMENT 'The acceptable variance percentage threshold. Variances within this percentage may not require adjustment.',
    `tolerance_threshold_quantity` DECIMAL(18,2) COMMENT 'The acceptable variance quantity threshold defined for this SKU/location combination. Variances within this threshold may not require adjustment.',
    `unit_of_measure` STRING COMMENT 'The unit in which quantities are expressed: EA (each), CS (case), PL (pallet), LB (pound), KG (kilogram), L (liter), GAL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_notes` STRING COMMENT 'Free-text notes providing additional context or explanation for the variance observed during the cycle count.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the system quantity, calculated as (variance_quantity / system_quantity) * 100.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between counted quantity and system quantity (counted minus system). Positive indicates overage, negative indicates shortage.',
    `variance_reason_code` STRING COMMENT 'Root cause classification for the variance: picking error, receiving error, damage, theft, system error, location error, expiry, or other. [ENUM-REF-CANDIDATE: picking_error|receiving_error|damage|theft|system_error|location_error|expiry|other — 8 candidates stripped; promote to reference product]',
    `wms_transaction_code` STRING COMMENT 'The unique transaction identifier generated by the WMS for this cycle count event, used for audit trail and system reconciliation.',
    CONSTRAINT pk_distribution_cycle_count PRIMARY KEY(`distribution_cycle_count_id`)
) COMMENT 'Cycle count event record capturing scheduled or ad-hoc physical inventory counts at DC locations, including line-level detail for each SKU/lot counted with system vs. actual quantities and variance calculations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` (
    `distribution_dsd_route_id` BIGINT COMMENT 'Unique identifier for the DSD route record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: DSD route planning assigns a carrier to each route; the carrier_id FK enables carrier performance and cost analysis.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center or depot from which this DSD route originates. Links to the facility master.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: DSD route aligns with a transport lane to calculate distance, fuel surcharge, and service level expectations.',
    `employee_id` BIGINT COMMENT 'Identifier of the driver or sales representative permanently or primarily assigned to this route. May be null for unassigned or pool routes.',
    `territory_id` BIGINT COMMENT 'Identifier of the sales or service territory to which this route is assigned. Used for sales force alignment and performance tracking.',
    `average_order_value` DECIMAL(18,2) COMMENT 'Historical average order value per stop on this route in local currency. Used for revenue forecasting and route profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary values associated with this route (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this route configuration was discontinued or superseded. Null for currently active routes. Used for historical route analysis.',
    `effective_start_date` DATE COMMENT 'Date when this route configuration became active and operational. Used for historical route analysis and change tracking.',
    `estimated_drive_time_minutes` STRING COMMENT 'Estimated total driving time for the route in minutes, excluding stop service time. Used for driver shift planning and OTIF performance targets.',
    `estimated_service_time_minutes` STRING COMMENT 'Estimated total time spent at customer stops for unloading, merchandising, and order processing in minutes. Combined with drive time for total route duration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was last updated. Used for change tracking and audit trail.',
    `last_optimization_date` DATE COMMENT 'Date when this route was last reviewed and optimized for efficiency. Used to identify routes due for re-evaluation.',
    `merchandising_required` BOOLEAN COMMENT 'Boolean flag indicating whether this route includes merchandising activities (shelf stocking, display setup, POG compliance) in addition to delivery. True if merchandising is part of the service.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or route-specific considerations (e.g., Avoid highway during rush hour, Customer prefers morning delivery).',
    `number_of_stops` STRING COMMENT 'Total count of retail store or customer locations included in this route. Used for route capacity planning and driver workload estimation.',
    `osa_target_percentage` DECIMAL(18,2) COMMENT 'Target OSA percentage for stores on this route, representing the expected in-stock rate at point of sale. Used for DSD execution quality and replenishment effectiveness tracking.',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'Target OTIF performance percentage for this route, representing the expected rate of deliveries completed on time and in full. Used for SLA management and driver performance evaluation.',
    `planned_departure_time` TIMESTAMP COMMENT 'Standard departure time from the DC for this route in HH:MM format (24-hour clock). Used for driver scheduling and DC loading dock coordination.',
    `planned_return_time` TIMESTAMP COMMENT 'Expected return time to the DC for this route in HH:MM format (24-hour clock). Used for driver shift planning and vehicle turnaround scheduling.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking of this route relative to other routes in the territory or DC, with lower numbers indicating higher priority. Used for resource allocation during capacity constraints.',
    `requires_cold_chain` BOOLEAN COMMENT 'Boolean flag indicating whether this route requires temperature-controlled (refrigerated or frozen) transportation for product integrity. True if cold chain is required.',
    `requires_hazmat_certification` BOOLEAN COMMENT 'Boolean flag indicating whether the driver assigned to this route must hold hazmat certification due to regulated products (e.g., aerosols, flammables). True if certification is required.',
    `route_code` STRING COMMENT 'Business identifier for the DSD route, used for operational reference and scheduling. Typically alphanumeric code assigned by logistics planning.. Valid values are `^[A-Z0-9]{4,12}$`',
    `route_name` STRING COMMENT 'Human-readable name or description of the DSD route, often including geographic or customer identifiers (e.g., Downtown Metro Route A, North Region Convenience Stores).',
    `route_optimization_score` DECIMAL(18,2) COMMENT 'Calculated efficiency score for this route based on distance, time, stops, and revenue, typically ranging from 0-100. Higher scores indicate more optimized routes. Used for continuous improvement initiatives.',
    `route_status` STRING COMMENT 'Current operational status of the DSD route. Active routes are in regular service; inactive routes are permanently discontinued; suspended routes are temporarily paused; under_review routes are being optimized; seasonal_closed routes are off-season.. Valid values are `active|inactive|suspended|under_review|seasonal_closed`',
    `route_type` STRING COMMENT 'Classification of the DSD route based on service model: standard (regular scheduled delivery), express (same-day or expedited), bulk (high-volume customers), emergency (unplanned replenishment), seasonal (temporary routes for peak demand).. Valid values are `standard|express|bulk|emergency|seasonal`',
    `service_day_pattern` STRING COMMENT 'Comma-separated list of days of the week this route is scheduled to run (e.g., Mon,Wed,Fri for a three-day-per-week route). Supports recurring schedule planning.. Valid values are `^(Mon|Tue|Wed|Thu|Fri|Sat|Sun)(,(Mon|Tue|Wed|Thu|Fri|Sat|Sun))*$`',
    `start_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the route start point (typically the DC or depot). Used for route optimization and GPS tracking.',
    `start_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the route start point (typically the DC or depot). Used for route optimization and GPS tracking.',
    `total_distance_km` DECIMAL(18,2) COMMENT 'Total driving distance for the complete route in kilometers, from DC departure through all stops and return. Used for fuel cost estimation and vehicle range planning.',
    `vehicle_capacity_required_units` STRING COMMENT 'Minimum vehicle cargo capacity required in standard units (cases, pallets, or cubic meters) to fulfill typical route demand. Used for vehicle assignment.',
    `vehicle_type_required` STRING COMMENT 'Type of vehicle required to service this route based on cargo volume, weight, and product requirements (e.g., refrigerated for cold chain products).. Valid values are `small_van|medium_truck|large_truck|refrigerated_truck|flatbed`',
    CONSTRAINT pk_distribution_dsd_route PRIMARY KEY(`distribution_dsd_route_id`)
) COMMENT 'Master record for Direct Store Delivery (DSD) routes defining the sequence of retail store stops served by a DSD driver/vehicle from a DC or satellite depot. Captures route code, route name, assigned DC, territory, day-of-week schedule, number of stops, total route distance, estimated drive time, vehicle type requirement, and active status. Supports DSD execution planning and OSA performance tracking by route.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` (
    `distribution_dsd_delivery_id` BIGINT COMMENT 'Unique identifier for the DSD delivery transaction. Primary key for the distribution_dsd_delivery product.',
    `employee_id` BIGINT COMMENT 'Reference to the DSD driver who executed this delivery. Links to workforce employee master data.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store account where this delivery was executed. Links to the customer.retail_store master data.',
    `route_id` BIGINT COMMENT 'Reference to the DSD route this delivery is part of. Links to the route master data defining the planned sequence of store visits.',
    `actual_arrival_time` TIMESTAMP COMMENT 'The actual timestamp when the driver arrived at the retail store location. Used for On Time In Full (OTIF) performance measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this delivery record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this delivery transaction.. Valid values are `^[A-Z]{3}$`',
    `delivery_exception_code` STRING COMMENT 'Code indicating any exception or issue encountered during the delivery attempt. Used for root cause analysis of delivery failures. [ENUM-REF-CANDIDATE: store_closed|access_denied|incomplete_order|damaged_product|wrong_address|weather_delay|traffic_delay|vehicle_breakdown|none — 9 candidates stripped; promote to reference product]',
    `delivery_notes` STRING COMMENT 'Free-text notes captured by the driver regarding delivery conditions, store feedback, or special circumstances encountered during the visit.',
    `delivery_number` STRING COMMENT 'Business identifier for the DSD delivery transaction. Externally visible delivery document number used for tracking and proof of delivery reference.. Valid values are `^DSD-[0-9]{10}$`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the DSD delivery transaction. Tracks progression from scheduled visit through completion or failure. [ENUM-REF-CANDIDATE: scheduled|in_transit|arrived|in_progress|completed|failed|cancelled — 7 candidates stripped; promote to reference product]',
    `delivery_value_amount` DECIMAL(18,2) COMMENT 'The total monetary value of products delivered during this visit, calculated at invoice price. Represents gross delivery value before returns and credits.',
    `delivery_window_end` TIMESTAMP COMMENT 'The end of the agreed delivery time window with the retail store. Part of Service Level Agreement (SLA) for OTIF measurement.',
    `delivery_window_start` TIMESTAMP COMMENT 'The beginning of the agreed delivery time window with the retail store. Part of Service Level Agreement (SLA) for OTIF measurement.',
    `departure_time` TIMESTAMP COMMENT 'The timestamp when the driver departed from the retail store after completing delivery and merchandising activities.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate captured at delivery location for route verification and geospatial analytics.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate captured at delivery location for route verification and geospatial analytics.',
    `in_full_flag` BOOLEAN COMMENT 'Indicates whether the complete ordered quantity was delivered without shortages. Component of OTIF performance measurement.',
    `invoice_number` STRING COMMENT 'Reference to the sales invoice document generated for this DSD delivery. Links to financial billing and accounts receivable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this delivery record was last updated in the system. Audit trail for data lineage and change tracking.',
    `merchandising_activity_type` STRING COMMENT 'The type of in-store merchandising activity performed during the delivery visit. Supports retail execution and On Shelf Availability (OSA) objectives.. Valid values are `shelf_stocking|rotation|display_setup|planogram_compliance|price_check|promotional_setup`',
    `merchandising_duration_minutes` STRING COMMENT 'The total time in minutes spent on merchandising activities during the store visit. Used for labor productivity analysis.',
    `merchandising_performed_flag` BOOLEAN COMMENT 'Indicates whether in-store merchandising activities (shelf stocking, rotation, display setup) were performed during this delivery visit.',
    `net_delivery_amount` DECIMAL(18,2) COMMENT 'The net monetary value of the delivery after subtracting return credits from gross delivery value. Represents actual secondary sales value.',
    `on_time_flag` BOOLEAN COMMENT 'Indicates whether the delivery arrived within the agreed delivery time window. Component of OTIF performance measurement.',
    `otif_compliance_flag` BOOLEAN COMMENT 'Indicates whether this delivery met On Time In Full (OTIF) performance criteria: arrived within delivery window and delivered complete order quantity.',
    `pod_capture_method` STRING COMMENT 'The method used to capture proof of delivery from the store recipient. Electronic signature and photo are preferred for audit trail.. Valid values are `electronic_signature|photo|barcode_scan|manual_entry|none`',
    `pod_photo_url` STRING COMMENT 'URL reference to the photo evidence of delivery captured at the store. Links to document management system for audit purposes.',
    `pod_signature_image_url` STRING COMMENT 'URL reference to the stored electronic signature image captured as proof of delivery. Links to document management system.',
    `recipient_name` STRING COMMENT 'The name of the store employee who received and acknowledged the delivery. Captured for proof of delivery and accountability.',
    `return_credit_amount` DECIMAL(18,2) COMMENT 'The total monetary value of product returns credited to the store during this visit. Reduces net delivery value.',
    `scheduled_arrival_time` TIMESTAMP COMMENT 'The planned arrival timestamp at the retail store based on route optimization and store delivery window requirements.',
    `source_system_code` STRING COMMENT 'The unique identifier of this delivery record in the source operational system. Used for data lineage and reconciliation.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicates whether temperature-sensitive products were maintained within required cold chain temperature ranges during delivery. Critical for food safety and quality compliance.',
    `total_cases_delivered` DECIMAL(18,2) COMMENT 'The total quantity of product cases delivered to the store during this visit. Aggregate measure across all SKUs (Stock Keeping Units) delivered.',
    `total_cases_returned` DECIMAL(18,2) COMMENT 'The total quantity of product cases returned from the store during this visit due to damage, expiration, or other quality issues.',
    `total_units_delivered` DECIMAL(18,2) COMMENT 'The total quantity of individual product units delivered to the store during this visit. Aggregate measure across all SKUs delivered.',
    `total_units_returned` DECIMAL(18,2) COMMENT 'The total quantity of individual product units returned from the store during this visit due to damage, expiration, or other quality issues.',
    `vehicle_code` BIGINT COMMENT 'Reference to the delivery vehicle used for this DSD delivery. Links to fleet asset master data.',
    `visit_date` DATE COMMENT 'The calendar date on which the DSD delivery visit to the retail store occurred. Business event date for reporting and analytics.',
    CONSTRAINT pk_distribution_dsd_delivery PRIMARY KEY(`distribution_dsd_delivery_id`)
) COMMENT 'Transactional record of a DSD drivers delivery execution to a specific retail store on a given route visit. Captures route reference, store/account reference, driver ID, vehicle ID, visit date, arrival and departure timestamps, products delivered by SKU and quantity, products returned/credited, in-store merchandising activities performed, POD (proof of delivery) capture method, and delivery status. Integrates with Salesforce Consumer Goods Cloud retail execution and TradeEdge secondary sales visibility.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` (
    `dsd_delivery_line_id` BIGINT COMMENT 'Unique identifier for the DSD delivery line item. Primary key for this product.',
    `distribution_dsd_delivery_id` BIGINT COMMENT 'Reference to the parent DSD delivery header record. Links this line item to the overall store visit and delivery transaction.',
    `distribution_storage_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center location from which this product was sourced for delivery.',
    `employee_id` BIGINT COMMENT 'Reference to the DSD driver who delivered this line item. Used for driver performance tracking and accountability.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the trade promotion or promotional campaign associated with this delivery line, if applicable.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Tracks DSD pilot deliveries of new formulations, required for consumer test logistics and performance reporting.',
    `route_id` BIGINT COMMENT 'Reference to the delivery route on which this line was delivered. Used for route optimization and logistics analysis.',
    `sku_id` BIGINT COMMENT 'Reference to the product master record for the SKU delivered or returned on this line.',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether cold chain temperature requirements were maintained throughout delivery. True if compliant, False if temperature excursion occurred.',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Standard cost of goods sold for the delivered quantity. Used for margin analysis and profitability reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery line record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts on this line (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU delivered to the store during this visit. Used for secondary sales capture and inventory replenishment tracking.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when this specific line item was delivered or processed at the store. Used for OTIF performance tracking and delivery window compliance.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount or promotional allowance applied to this line. Used for trade promotion settlement and margin analysis.',
    `expiry_date` DATE COMMENT 'Product expiration or best-before date. Used for FEFO inventory rotation and shelf-life management in stores.',
    `gtin` STRING COMMENT 'Global Trade Item Number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) for the product. Enables cross-system product identification and retail scanning.. Valid values are `^d{8}$|^d{12}$|^d{13}$|^d{14}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery line record was last updated. Used for change tracking and audit purposes.',
    `line_number` STRING COMMENT 'Sequential line number within the delivery document. Used for ordering and referencing specific line items within the delivery.',
    `line_status` STRING COMMENT 'Current status of this delivery line. Values: DELIVERED (fully delivered), PARTIAL (partially delivered), REJECTED (rejected by store), RETURNED (returned to warehouse), CANCELLED (cancelled before delivery).. Valid values are `DELIVERED|PARTIAL|REJECTED|RETURNED|CANCELLED`',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this delivery line (delivered quantity × unit selling price). Represents secondary sales revenue at store level.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number for the delivered product. Critical for traceability, quality control, and recall management.',
    `manufacture_date` DATE COMMENT 'Date the product was manufactured. Used for shelf-life calculation and quality tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value for this line after discounts and taxes (line_total_amount - discount_amount + tax_amount). Represents final revenue for this line.',
    `notes` STRING COMMENT 'Free-text notes or comments about this delivery line. May include special handling instructions, store feedback, or exception details.',
    `oos_flag` BOOLEAN COMMENT 'Indicates whether the store was out of stock for this SKU at the time of delivery. True if OOS condition detected, False otherwise. Critical for OSA metrics.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU originally ordered by the store or planned for delivery. Used for fill-rate and OTIF analysis.',
    `planogram_compliance_flag` BOOLEAN COMMENT 'Indicates whether the product was placed according to the store planogram. True if compliant, False if deviation occurred.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why the delivery line was rejected by the store. Values: DAMAGED, WRONG_PRODUCT, QUALITY, UNAUTHORIZED, EXPIRED, OTHER.. Valid values are `DAMAGED|WRONG_PRODUCT|QUALITY|UNAUTHORIZED|EXPIRED|OTHER`',
    `return_reason_code` STRING COMMENT 'Standardized code indicating why product was returned from the store. Values: DAMAGED (damaged goods), EXPIRED (past expiry date), OVERSTOCKED (excess inventory), QUALITY (quality issue), RECALL (product recall), UNSOLD (slow-moving), OTHER (other reason). [ENUM-REF-CANDIDATE: DAMAGED|EXPIRED|OVERSTOCKED|QUALITY|RECALL|UNSOLD|OTHER — 7 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Detailed free-text description of the return reason. Provides additional context beyond the standardized return reason code.',
    `returned_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU returned from the store during this visit. Includes damaged goods, expired products, and unsold inventory.',
    `shelf_placement_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the DSD driver confirmed proper shelf placement and merchandising of the delivered product. True if confirmed, False otherwise.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this delivery line. Calculated based on jurisdiction-specific tax rules.',
    `temperature_zone` STRING COMMENT 'Temperature control zone required for this product during storage and delivery. Values: AMBIENT (room temperature), CHILLED (refrigerated), FROZEN (frozen storage).. Valid values are `AMBIENT|CHILLED|FROZEN`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities on this line. Common values: EA (each), CS (case), PK (pack), BX (box), PL (pallet), DZ (dozen), KG (kilogram), LB (pound), LT (liter), GL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PK|BX|PL|DZ|KG|LB|LT|GL — 10 candidates stripped; promote to reference product]',
    `unit_selling_price` DECIMAL(18,2) COMMENT 'Selling price per unit for this SKU at the time of delivery. Used for revenue calculation and pricing analysis.',
    `upc` STRING COMMENT '12-digit Universal Product Code for the product. Standard barcode identifier used in North American retail.. Valid values are `^d{12}$`',
    `vehicle_code` BIGINT COMMENT 'Reference to the delivery vehicle used to transport this line item. Used for fleet management and cold chain tracking.',
    CONSTRAINT pk_dsd_delivery_line PRIMARY KEY(`dsd_delivery_line_id`)
) COMMENT 'Line-level SKU detail for each product delivered or returned during a DSD store visit. Records SKU code, GTIN, lot number, expiry date, ordered quantity, delivered quantity, returned quantity, return reason code, unit selling price, line total value, and shelf placement confirmation. Enables secondary sales capture, OOS identification, and FEFO compliance tracking at the store-SKU level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` (
    `otif_event_id` BIGINT COMMENT 'Unique identifier for the OTIF performance measurement event. Primary key for the OTIF event record.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier responsible for delivery. Used for carrier performance scorecarding and accountability analysis.',
    `delivery_id` BIGINT COMMENT 'Reference to the delivery execution record for Direct Store Delivery (DSD) or carrier delivery. Links to the actual delivery event.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the distribution center that originated the shipment. Used for DC-level OTIF performance accountability and scorecard reporting.',
    `distribution_shipment_id` BIGINT COMMENT 'Reference to the outbound shipment being measured for OTIF performance. Links to the shipment transaction that this OTIF event evaluates.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Enables OTIF Incident Management report to identify the employee responsible for resolving each OTIF event, meeting internal SLA tracking.',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store location receiving the delivery. Applicable for Direct Store Delivery (DSD) and store-level OTIF tracking.',
    `trade_account_id` BIGINT COMMENT 'Reference to the customer trade account receiving the shipment. Used for customer-specific OTIF scorecard and retailer compliance reporting.',
    `actual_delivery_date` DATE COMMENT 'The actual date the shipment was delivered to the customer location. Used to calculate on-time performance variance.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The precise timestamp when delivery was completed and proof of delivery was captured. Used for time-window OTIF compliance.',
    `committed_delivery_date` DATE COMMENT 'The delivery date committed to the customer per the Service Level Agreement (SLA) or purchase order terms. Baseline for on-time performance measurement.',
    `committed_delivery_timestamp` TIMESTAMP COMMENT 'The precise delivery date and time committed to the customer, including time window for time-sensitive deliveries. Used for precise OTIF measurement when time windows apply.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The total quantity committed to the customer per the sales order or purchase order. Baseline for in-full performance measurement. Measured in order unit of measure.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTIF event record was first created in the system. Audit trail for data lineage and record creation tracking.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The actual quantity delivered to the customer. Used to calculate in-full performance and quantity variance. Measured in order unit of measure.',
    `delivery_channel` STRING COMMENT 'The logistics channel used for delivery execution. Values include Direct Store Delivery (DSD), Less Than Truckload (LTL) carrier, Full Truckload (FTL) carrier, parcel, customer pickup, or third-party logistics (3PL).. Valid values are `dsd|ltl_carrier|ftl_carrier|parcel|customer_pickup|third_party_logistics`',
    `delivery_variance_days` STRING COMMENT 'The number of days variance between committed and actual delivery date. Negative values indicate early delivery, positive values indicate late delivery, zero indicates on-time.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the OTIF measurement is under dispute by the customer or internal stakeholders. True indicates active dispute, False indicates accepted measurement.',
    `dispute_reason` STRING COMMENT 'Explanation of why the OTIF measurement is disputed. Captures customer or internal objections to the performance assessment.',
    `event_status` STRING COMMENT 'The current lifecycle status of the OTIF event record. Tracks progression from initial measurement through dispute resolution and final closure.. Valid values are `pending|confirmed|disputed|resolved|closed`',
    `failure_category` STRING COMMENT 'The primary root cause category for OTIF failures. Used for operational improvement analysis and accountability assignment. Values include DC pick error, inventory shortage, dock delay, carrier issue, customer refused, weather delay, system error, quality hold, damaged product, address issue, or no failure for successful deliveries. [ENUM-REF-CANDIDATE: dc_pick_error|inventory_shortage|dock_delay|carrier_issue|customer_refused|weather_delay|system_error|quality_hold|damaged_product|address_issue|no_failure — 11 candidates stripped; promote to reference product]',
    `failure_reason_detail` STRING COMMENT 'Detailed explanation of the root cause for OTIF failure. Free-text field capturing specific circumstances, corrective actions, and accountability notes.',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the full committed quantity was delivered. True indicates complete delivery, False indicates short shipment or over shipment outside tolerance.',
    `in_full_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable variance percentage per customer SLA or business policy. Deliveries within this tolerance are considered in-full compliant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTIF event record was last updated. Audit trail for change tracking and data quality monitoring.',
    `measurement_date` DATE COMMENT 'The date when the OTIF performance was measured and recorded. Used for reporting period assignment and trend analysis.',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment was delivered on or before the committed delivery date. True indicates on-time delivery, False indicates late delivery.',
    `order_number` STRING COMMENT 'The customer purchase order or sales order number associated with this shipment. Business identifier for traceability to the originating order.',
    `otif_score` BOOLEAN COMMENT 'Composite OTIF performance indicator. True only when both on_time_flag and in_full_flag are True. Primary KPI for DC operations accountability and retailer scorecard compliance.',
    `penalty_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the retailer penalty amount. Standard currency codes such as USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `pod_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether an electronic or physical signature was captured at delivery. True indicates signature obtained, False indicates delivery without signature capture.',
    `proof_of_delivery_timestamp` TIMESTAMP COMMENT 'The timestamp when proof of delivery was captured, typically via electronic signature, barcode scan, or delivery confirmation. Source of truth for actual delivery time.',
    `quantity_uom` STRING COMMENT 'The unit of measure for committed and delivered quantities. Common values include cases, pallets, eaches, or other standard units.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between delivered quantity and committed quantity. Negative values indicate short shipment, positive values indicate over shipment.',
    `quantity_variance_percent` DECIMAL(18,2) COMMENT 'The percentage variance between delivered and committed quantity, calculated as (delivered - committed) / committed * 100. Used to assess severity of in-full failures.',
    `responsible_party` STRING COMMENT 'The organizational function or external party accountable for the OTIF failure. Used for performance accountability and continuous improvement initiatives.. Valid values are `dc_operations|inventory_planning|transportation|carrier|customer|external_factor`',
    `retailer_penalty_amount` DECIMAL(18,2) COMMENT 'The financial penalty or chargeback amount assessed by the retailer for OTIF non-compliance per the customer contract or retailer compliance program. Zero for compliant deliveries.',
    `shipment_number` STRING COMMENT 'The warehouse management system shipment number or bill of lading number. External business identifier for the shipment.',
    `sla_tier` STRING COMMENT 'The service level tier committed to the customer. Defines the delivery speed and OTIF performance expectations per the customer agreement.. Valid values are `standard|expedited|premium|next_day|same_day`',
    CONSTRAINT pk_otif_event PRIMARY KEY(`otif_event_id`)
) COMMENT 'OTIF (On Time In Full) performance measurement record for each outbound shipment or DSD delivery against committed service levels. Captures shipment/delivery reference, customer/account, committed vs actual delivery date, on-time flag, committed vs delivered quantity, in-full flag, composite OTIF score, root cause category for failures (DC pick error, inventory shortage, dock delay, carrier issue), and retailer penalty exposure amount. Primary KPI entity for DC operations accountability and retailer scorecard compliance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` (
    `dock_appointment_id` BIGINT COMMENT 'Unique identifier for the dock appointment record. Primary key for the dock appointment entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier responsible for this appointment. Links to carrier master data for performance tracking and compliance monitoring.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Allows Dock Scheduling System to capture which employee scheduled the appointment, enabling workload planning and audit of appointment creation.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the distribution center where this dock appointment is scheduled. Links to the facility managing the dock operations.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Receiving appointments are scheduled per purchase order, enabling the dock team to allocate doors and resources for each inbound PO.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the carrier truck checked in at the distribution center gate. Used to calculate on-time arrival performance and carrier compliance.',
    `actual_case_count` STRING COMMENT 'Actual number of cases handled during the appointment. Used for variance analysis and operational performance tracking.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual timestamp when loading or unloading operations were completed and the truck departed. Used to calculate dock turnaround time and throughput metrics.',
    `actual_pallet_count` STRING COMMENT 'Actual number of pallets loaded or unloaded during the appointment. Compared against expected count to identify discrepancies.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when loading or unloading operations began at the dock door. Marks the beginning of active dock utilization.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Actual total weight of goods handled in kilograms. Verified through weigh station or scale integration.',
    `appointment_number` STRING COMMENT 'Business-facing unique appointment reference number used for scheduling and tracking. Externally visible identifier shared with carriers and suppliers.. Valid values are `^[A-Z0-9]{8,20}$`',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the dock appointment: scheduled (initial booking), confirmed (carrier acknowledged), checked_in (truck arrived at gate), in_progress (loading/unloading active), completed (finished), cancelled (appointment voided), no_show (carrier missed appointment). [ENUM-REF-CANDIDATE: scheduled|confirmed|checked_in|in_progress|completed|cancelled|no_show — 7 candidates stripped; promote to reference product]',
    `appointment_type` STRING COMMENT 'Classification of the dock appointment purpose: inbound receipt (supplier delivery), outbound load (customer shipment), inter-DC transfer (internal movement), cross-dock (direct transfer), returns processing, or emergency delivery.. Valid values are `inbound_receipt|outbound_load|inter_dc_transfer|cross_dock|returns_processing|emergency_delivery`',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice identifier sent by supplier prior to shipment arrival. Used to pre-plan receiving operations and validate expected contents.. Valid values are `^[A-Z0-9-]{8,25}$`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the appointment was cancelled. Captures business context for cancelled or no-show appointments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dock appointment record was first created in the system. Audit trail for appointment booking lifecycle.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this is a cross-dock appointment where goods are transferred directly from inbound to outbound without storage. True for cross-dock operations.',
    `detention_minutes` STRING COMMENT 'Total time in minutes that the carrier was detained beyond the scheduled appointment window. Used to calculate detention charges and identify operational bottlenecks.',
    `dock_door_number` STRING COMMENT 'Physical dock door identifier assigned to this appointment (e.g., D-101, DOOR-A5). Indicates the specific loading/unloading bay at the distribution center.. Valid values are `^[A-Z0-9-]{1,10}$`',
    `driver_name` STRING COMMENT 'Name of the driver assigned to this appointment. Used for gate check-in verification and security purposes.',
    `driver_phone` STRING COMMENT 'Contact phone number for the driver. Used for real-time communication regarding delays, gate instructions, or operational issues.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this appointment is part of a Direct Store Delivery operation where goods bypass the DC and go directly to retail stores. True for DSD shipments.',
    `expected_case_count` STRING COMMENT 'Anticipated number of cases to be handled during this appointment. Supports detailed capacity and labor planning for case-level operations.',
    `expected_pallet_count` STRING COMMENT 'Anticipated number of pallets to be loaded or unloaded during this appointment. Used for dock capacity planning and labor scheduling.',
    `expected_weight_kg` DECIMAL(18,2) COMMENT 'Total expected weight of goods in kilograms for this appointment. Used for equipment planning and safety compliance.',
    `hazmat_class` STRING COMMENT 'UN hazard classification code for hazardous materials (e.g., 3 for flammable liquids, 8 for corrosives). Required for HAZMAT compliance and safety protocols.. Valid values are `^[1-9](.[1-6])?$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this appointment involves hazardous materials requiring special handling, documentation, and certified dock doors. True for HAZMAT shipments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this dock appointment record was last updated. Tracks the most recent change to appointment details or status.',
    `notes` STRING COMMENT 'Free-text notes and special instructions for this appointment. May include gate directions, special handling requirements, or operational alerts.',
    `otif_compliant_flag` BOOLEAN COMMENT 'Indicates whether the appointment met On Time In Full performance criteria: arrived within scheduled window and delivered expected quantities. True if OTIF compliant.',
    `priority_level` STRING COMMENT 'Business priority classification for this appointment: standard (routine), high (expedited), urgent (same-day), or emergency (critical). Influences dock door assignment and resource allocation.. Valid values are `standard|high|urgent|emergency`',
    `sales_order_number` STRING COMMENT 'Sales order number associated with outbound load appointments. Links the dock appointment to customer orders being shipped.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `scheduled_arrival_date` DATE COMMENT 'Planned date for the carrier to arrive at the dock door. Used for day-level appointment planning and capacity management.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Precise timestamp when the appointment window closes. Carrier should complete loading/unloading by this time to maintain schedule compliance.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise timestamp when the appointment window begins. Carrier is expected to arrive at or after this time.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the security seal was intact upon arrival. True if seal is unbroken, false if compromised. Critical for security and quality control.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the trailer. Verified at check-in to ensure cargo integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,20}$`',
    `shipment_number` STRING COMMENT 'Outbound shipment identifier for load appointments. References the shipment being loaded onto the carrier truck.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this appointment involves temperature-sensitive goods requiring cold chain management. True for refrigerated or frozen shipments.',
    `temperature_zone` STRING COMMENT 'Required temperature zone for goods in this appointment: ambient (room temperature), refrigerated (2-8°C), frozen (-18°C), or deep frozen (below -25°C).. Valid values are `ambient|refrigerated|frozen|deep_frozen`',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or container arriving for this appointment. Used for yard management and asset tracking.. Valid values are `^[A-Z0-9]{4,15}$`',
    CONSTRAINT pk_dock_appointment PRIMARY KEY(`dock_appointment_id`)
) COMMENT 'Scheduled dock door appointment record for inbound or outbound truck arrivals at a DC. Captures appointment date/time window, dock door assignment, appointment type (inbound receipt, outbound load, inter-DC transfer), carrier, trailer number, expected SKUs and quantities, appointment status (scheduled, confirmed, arrived, completed, no-show), and actual arrival/departure timestamps. Supports dock scheduling optimization and carrier compliance tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` (
    `load_plan_id` BIGINT COMMENT 'Unique identifier for the outbound load plan record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier responsible for transporting this load.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center from which this load is being dispatched.',
    `outbound_order_id` BIGINT COMMENT 'add column outbound_order_id (BIGINT) with FK to distribution.outbound_order.outbound_order_id - load plans fulfill outbound orders and need that reference',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse supervisor who verified and approved the completed load before dispatch.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Load planning uses purchase order details to allocate trailer space, ensure correct items are loaded, and meet OTIF targets.',
    `wave_id` BIGINT COMMENT 'Identifier of the picking wave that generated the orders included in this load plan. Links load planning to upstream warehouse execution.',
    `actual_departure_datetime` TIMESTAMP COMMENT 'Actual date and time when the loaded trailer departed the distribution center, used for OTIF performance measurement.',
    `carrier_service_level` STRING COMMENT 'Service level agreement tier for this shipment, determining transit time and handling requirements.. Valid values are `standard|expedited|next_day|two_day|economy|white_glove`',
    `case_count` STRING COMMENT 'Total number of cases or cartons included in this load plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this load plan record was first created in the WMS.',
    `dock_door_number` STRING COMMENT 'Dock door location at the distribution center where this load is staged and loaded.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this load is part of a Direct Store Delivery route, bypassing retailer distribution centers.',
    `estimated_freight_cost` DECIMAL(18,2) COMMENT 'Estimated transportation cost for this load based on carrier rates, distance, and service level.',
    `exception_code` STRING COMMENT 'Code identifying any exception or deviation from standard load planning process (e.g., overweight, incomplete orders, equipment failure).',
    `exception_notes` STRING COMMENT 'Free-text notes describing any exceptions, special handling instructions, or deviations from the standard load plan.',
    `freight_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated freight cost.. Valid values are `^[A-Z]{3}$`',
    `hazmat_class` STRING COMMENT 'DOT hazard class for hazardous materials in this load (e.g., Class 3 Flammable Liquids, Class 8 Corrosives).',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this load contains hazardous materials requiring special handling and DOT placarding.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this load plan record was last updated, tracking changes through the planning and execution lifecycle.',
    `load_plan_number` STRING COMMENT 'Business-facing unique identifier for the load plan, typically generated by the WMS. Used for operational tracking and communication with carriers and warehouse staff.',
    `load_plan_status` STRING COMMENT 'Current lifecycle status of the load plan, tracking progression from planning through dispatch. [ENUM-REF-CANDIDATE: draft|confirmed|in_progress|loaded|sealed|dispatched|cancelled — 7 candidates stripped; promote to reference product]',
    `load_sequence_strategy` STRING COMMENT 'Strategy used to determine the order in which pallets are loaded into the trailer, typically aligned with delivery stop sequence.. Valid values are `fifo|lifo|stop_sequence|priority`',
    `load_type` STRING COMMENT 'Classification of the load based on shipment mode and delivery strategy. DSD indicates Direct Store Delivery.. Valid values are `full_truckload|less_than_truckload|parcel|intermodal|dsd|pool_distribution`',
    `loading_completion_datetime` TIMESTAMP COMMENT 'Date and time when physical loading of the trailer was completed and verified.',
    `loading_start_datetime` TIMESTAMP COMMENT 'Date and time when physical loading of the trailer began at the dock door.',
    `order_count` STRING COMMENT 'Total number of distinct outbound orders consolidated into this load plan.',
    `otif_target_delivery_datetime` TIMESTAMP COMMENT 'Target delivery date and time committed to the customer, used for OTIF performance measurement.',
    `pallet_configuration` STRING COMMENT 'Description of how pallets are arranged and stacked within the trailer, supporting optimal space utilization and load stability.',
    `pallet_count` STRING COMMENT 'Total number of pallets included in this load plan.',
    `planned_departure_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the loaded trailer is planned to depart the distribution center.',
    `seal_number` STRING COMMENT 'Security seal number applied to the trailer after loading to ensure tamper-evidence during transit.',
    `stop_count` STRING COMMENT 'Total number of delivery stops planned for this load, used for multi-stop route optimization.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this load requires temperature-controlled transportation (refrigerated or frozen).',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled loads during transit.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled loads during transit.',
    `total_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total cubic volume of the load in cubic meters, used for trailer utilization analysis and capacity planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the load in kilograms, including product, packaging, and pallets. Used for carrier billing and DOT compliance.',
    `trailer_code` STRING COMMENT 'Unique identifier of the trailer or vehicle assigned to this load. May be a license plate, fleet number, or container number.',
    `trailer_type` STRING COMMENT 'Type of trailer or vehicle used for this load, determining capacity and product compatibility.. Valid values are `dry_van|refrigerated|flatbed|tanker|intermodal|box_truck`',
    `trailer_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of trailer capacity utilized by this load, calculated based on weight, volume, or pallet positions.',
    CONSTRAINT pk_load_plan PRIMARY KEY(`load_plan_id`)
) COMMENT 'Outbound load plan record defining the assignment of outbound orders and shipments to a specific trailer/vehicle for dispatch from a DC. Captures load plan number, DC, carrier, trailer ID, planned departure datetime, total weight, total cube, pallet configuration, stop sequence, and load plan status (draft, confirmed, loaded, dispatched). Integrates with Blue Yonder WMS load planning and transportation management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` (
    `returns_receipt_id` BIGINT COMMENT 'Unique identifier for the returns receipt record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier that transported the returned goods to the distribution center.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center receiving the returned goods.',
    `lot_batch_id` BIGINT COMMENT 'Identifier of the lot or batch number of the returned goods, critical for traceability and recall management.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality assurance employee who performed the condition inspection of the returned goods.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Return processing for recalled items requires linking the return receipt to the product recall record for quarantine and reporting.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotion Return Analysis links returned items to the originating promotion event to evaluate promotion effectiveness and refund liability.',
    `recall_event_id` BIGINT COMMENT 'Identifier of the recall event if this return is recall-driven, linking to the recall management record.',
    `receiving_clerk_employee_id` BIGINT COMMENT 'Identifier of the warehouse employee who received and logged the returned goods at the distribution center.',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store location from which the goods were returned, if applicable.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU (Stock Keeping Unit) being returned.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the customer account or retail account that initiated the return (retailer, DSD customer, or consumer account).',
    `case_count` STRING COMMENT 'Number of cases included in the return receipt.',
    `condition_assessment` STRING COMMENT 'Quality inspection result indicating the physical and salability condition of the returned goods: resalable, damaged, expired, defective, or contaminated.. Valid values are `resalable|damaged|expired|defective|contaminated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this return receipt record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Total monetary credit amount issued to the customer for the returned goods.',
    `credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued to the customer account for the returned goods.. Valid values are `^CM[0-9]{8,12}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destroy_quantity` DECIMAL(18,2) COMMENT 'Quantity of returned units that must be destroyed due to damage, contamination, or recall requirements.',
    `disposition_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the final disposition decision was executed (resale, destroy, rework, etc.).',
    `disposition_decision` STRING COMMENT 'Final decision on how the returned goods will be handled: resale to inventory, destroy, rework/repackage, donate, or return to vendor.. Valid values are `resale|destroy|rework|donate|return_to_vendor`',
    `expiry_date` DATE COMMENT 'Expiration date of the returned product lot, critical for FEFO (First Expired First Out) inventory rotation and recall management.',
    `gtin` STRING COMMENT 'Global Trade Item Number (GTIN) or UPC (Universal Product Code) of the returned product, used for global product identification.. Valid values are `^[0-9]{8,14}$`',
    `inspection_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the quality and condition inspection of returned goods was completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this return receipt record was last updated.',
    `notes` STRING COMMENT 'Free-text notes capturing additional details, exceptions, or special handling instructions for the return receipt.',
    `pallet_count` STRING COMMENT 'Number of pallets included in the return receipt.',
    `quantity_returned` DECIMAL(18,2) COMMENT 'Total quantity of units returned in this receipt.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether the return is part of a product recall event (True) or not (False).',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the returned goods were physically received at the distribution center. Principal business event timestamp.',
    `resalable_quantity` DECIMAL(18,2) COMMENT 'Quantity of returned units deemed resalable and eligible to be returned to inventory.',
    `return_authorization_number` STRING COMMENT 'Externally-known return authorization number issued to approve the return. Also known as RA# or RMA number.. Valid values are `^RA[0-9]{8,12}$`',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for the return: damaged goods, expired product, overstock, product recall, defective item, or wrong item shipped.. Valid values are `damaged|expired|overstock|recall|defective|wrong_item`',
    `return_reason_description` STRING COMMENT 'Detailed free-text explanation of the return reason, providing additional context beyond the reason code.',
    `return_status` STRING COMMENT 'Current lifecycle status of the return receipt: pending arrival, received at DC, inspected, processed for disposition, closed, or cancelled.. Valid values are `pending|received|inspected|processed|closed|cancelled`',
    `return_type` STRING COMMENT 'Classification of the return source: retailer return, DSD (Direct Store Delivery) customer return, consumer return, recall-driven return, or internal transfer.. Valid values are `retailer|dsd_customer|consumer|recall|internal_transfer`',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of returned units that will be reworked, repackaged, or refurbished for resale.',
    `scheduled_receipt_date` DATE COMMENT 'Planned date for the return to arrive at the distribution center, as communicated in the return authorization.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicates whether the returned goods were within acceptable temperature range during transit (True) or not (False).',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the returned goods require temperature-controlled handling (True) or not (False).',
    `temperature_reading_celsius` DECIMAL(18,2) COMMENT 'Temperature reading in Celsius recorded upon receipt of temperature-sensitive returned goods.',
    `tracking_number` STRING COMMENT 'Carrier tracking number for the return shipment, used to trace the inbound return delivery.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity: EA (each), CS (case), PL (pallet), KG (kilogram), LB (pound), L (liter), GAL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `wms_transaction_code` STRING COMMENT 'Transaction identifier from the Blue Yonder WMS system that processed this return receipt.',
    CONSTRAINT pk_returns_receipt PRIMARY KEY(`returns_receipt_id`)
) COMMENT 'Inbound returns processing record capturing goods returned from retailers, DSD customers, or consumers to a DC. Records return authorization number (RA#), originating customer/account, return reason code (damaged, expired, overstock, recall, consumer return), SKU, lot, quantity returned, condition assessment (resalable, destroy, rework), disposition decision, and credit memo reference. Supports reverse logistics, FEFO expiry management, and product recall execution.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` (
    `distribution_offset_allocation_id` BIGINT COMMENT 'Primary key for the offset_allocation association',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to carbon_offset',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution_facility',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Quantity of carbon offset (tCO2e) allocated to the facility',
    `allocation_date` DATE COMMENT 'Date the offset amount was allocated to the facility',
    CONSTRAINT pk_distribution_offset_allocation PRIMARY KEY(`distribution_offset_allocation_id`)
) COMMENT 'This association captures the allocation of purchased carbon offset credits to distribution facilities. Each record links one distribution_facility to one carbon_offset and records the amount of credit allocated and the allocation date.. Existence Justification: Carbon offsets are purchased centrally and then allocated to individual distribution facilities for ESG reporting. Each offset credit can be split among multiple facilities, and each facility can receive allocations from multiple offset credits over time, requiring a many-to-many association with allocation amount and date.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` (
    `wave_id` BIGINT COMMENT 'Primary key for wave',
    `distribution_facility_id` BIGINT COMMENT 'add column distribution_facility_id (BIGINT) with FK to distribution.distribution_facility.distribution_facility_id - waves are executed at a specific DC and need facility context beyond just warehouse',
    `previous_wave_id` BIGINT COMMENT 'Self-referencing FK on wave (previous_wave_id)',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse where the wave is executed.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Real completion time when the wave finished.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Real start time when picking began.',
    `comments` STRING COMMENT 'Free‑form notes entered by planners about the wave.',
    `distribution_center_code` STRING COMMENT 'Code representing the distribution center associated with the wave.',
    `equipment_type` STRING COMMENT 'Primary equipment used for the wave (e.g., conveyor, robotic).',
    `is_critical` BOOLEAN COMMENT 'True if the wave is marked as critical for service level commitments.',
    `wave_name` STRING COMMENT 'Descriptive name of the wave used by warehouse staff.',
    `on_time_pct` DECIMAL(18,2) COMMENT 'Percentage of the wave completed within the scheduled window.',
    `picker_count` STRING COMMENT 'Number of warehouse staff assigned to execute the wave.',
    `priority` STRING COMMENT 'Numeric priority of the wave; lower numbers indicate higher priority.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the wave record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the wave record.',
    `release_timestamp` TIMESTAMP COMMENT 'Timestamp when the wave was released to the floor for execution.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned completion time for the wave.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start time for wave execution.',
    `wave_status` STRING COMMENT 'Current lifecycle state of the wave.',
    `strategy` STRING COMMENT 'Strategic approach applied to the wave (e.g., zone picking).',
    `total_items` STRING COMMENT 'Sum of all line‑item quantities across orders in the wave.',
    `total_orders` STRING COMMENT 'Count of distinct orders included in the wave.',
    `total_quantity` STRING COMMENT 'Aggregate quantity of units to be picked in the wave.',
    `wave_number` STRING COMMENT 'Human‑readable code assigned to the wave for operational tracking.',
    `wave_type` STRING COMMENT 'Category of the wave indicating the operational purpose (e.g., pick, replenish).',
    CONSTRAINT pk_wave PRIMARY KEY(`wave_id`)
) COMMENT 'Master reference table for wave. Referenced by wave_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ADD CONSTRAINT `fk_distribution_distribution_storage_location_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_inbound_warehouse_distribution_facility_id` FOREIGN KEY (`inbound_warehouse_distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_target_location_distribution_storage_location_id` FOREIGN KEY (`target_location_distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_outbound_ship_to_location_distribution_facility_id` FOREIGN KEY (`outbound_ship_to_location_distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_primary_pick_distribution_storage_location_id` FOREIGN KEY (`primary_pick_distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_distribution_dsd_delivery_id` FOREIGN KEY (`distribution_dsd_delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery`(`distribution_dsd_delivery_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ADD CONSTRAINT `fk_distribution_dock_appointment_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`wave`(`wave_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ADD CONSTRAINT `fk_distribution_distribution_offset_allocation_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ADD CONSTRAINT `fk_distribution_wave_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ADD CONSTRAINT `fk_distribution_wave_previous_wave_id` FOREIGN KEY (`previous_wave_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`wave`(`wave_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dock_doors_inbound` SET TAGS ('dbx_business_glossary_term' = 'Dock Doors (Inbound)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dock_doors_outbound` SET TAGS ('dbx_business_glossary_term' = 'Dock Doors (Outbound)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dsd_hub_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Hub Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|multi_temperature|dsd_hub|cross_dock');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `fsc_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `inventory_rotation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `inventory_rotation_method` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (Weekday)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (Weekend)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|maintenance');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `osa_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party_logistics');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_storage_location` SET TAGS ('dbx_business_glossary_term' = 'SAP Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `shifts_per_day` SET TAGS ('dbx_business_glossary_term' = 'Shifts Per Day');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Pallet Positions)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Square Feet)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `wms_site_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `wms_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Velocity Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_business_glossary_term' = 'Bin Position Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Location Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_business_glossary_term' = 'Material Handling Equipment Type Required');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_value_regex' = 'forklift|reach_truck|order_picker|pallet_jack|manual|automated');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Location Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `fefo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `fifo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Height (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Length (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_business_glossary_term' = 'Rack Level Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|quarantine|damaged');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bulk|pick|reserve|staging|dock|cross_dock');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `mixed_lot_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Lot/Batch Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `mixed_sku_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'batch|wave|zone|discrete|cluster');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_business_glossary_term' = 'Put-Away Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_value_regex' = 'directed|random|fixed|dynamic');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `replenishment_priority` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `volume_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume Capacity (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Width (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_warehouse_distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspector ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receiving_clerk_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Clerk ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receiving_clerk_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receiving_clerk_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `actual_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `case_count` SET TAGS ('dbx_business_glossary_term' = 'Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_value_regex' = 'overage|shortage|damage|wrong_product|quality_issue|documentation_error');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `goods_receipt_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `goods_receipt_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `putaway_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Put-Away Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|discrepancy|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'supplier_delivery|plant_transfer|inter_dc_transfer|return_from_customer|production_output');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `scheduled_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Check Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_reading_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_line_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'good|damaged|expired|quarantine|rejected|hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expected_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expected_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `purchase_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `put_away_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Put Away Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'pending|received|inspected|put_away|discrepancy|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `temperature_at_receipt_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receipt Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'case|each|pallet|layer|inner_pack|display_unit');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `variance_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `variance_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `putaway_task_id` SET TAGS ('dbx_business_glossary_term' = 'Putaway Task Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Operator Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `inventory_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `target_location_distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Target Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_value_regex' = 'barcode_scan|RFID|manual_entry|voice_pick|vision_system');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `cube_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Cube (Cubic Feet)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Putaway Cycle Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Material Handling Equipment Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{0,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `movement_strategy` SET TAGS ('dbx_business_glossary_term' = 'Movement Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,25}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Task Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `quality_check_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Completed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `quality_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Putaway Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `source_location_code` SET TAGS ('dbx_business_glossary_term' = 'Source Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `source_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `system_source` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,50}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `target_location_code` SET TAGS ('dbx_business_glossary_term' = 'Target Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `target_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Cancelled Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Putaway Task Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Started Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Putaway Task Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|assigned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Putaway Task Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'inbound_putaway|replenishment|cross_dock|returns_putaway|transfer');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `travel_distance_feet` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance (Feet)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight (Pounds)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_ship_to_location_distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'retail_replenishment|dsd|ecommerce|inter_dc_transfer|wholesale|export');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `otif_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Commitment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `packing_slip_number` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `pick_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Pick Ticket Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'standard|expedited|rush|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|next_day|two_day|same_day|scheduled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Order Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Order Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `base_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `customer_po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `edi_line_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Line Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `handling_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `line_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Line Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `line_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Line Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late_in_full|on_time_partial|late_partial');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `packed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pick_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pick_zone` SET TAGS ('dbx_business_glossary_term' = 'Pick Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `serial_numbers` SET TAGS ('dbx_business_glossary_term' = 'Serial Numbers');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_flag` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_reason_code` SET TAGS ('dbx_value_regex' = 'OOS|DAMAGE|RECALL|EXPIRED|ALLOCATION');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Unit Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `primary_pick_distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Operator Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_value_regex' = '^CTN[0-9A-Z]{8,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `gs1_128_label` SET TAGS ('dbx_business_glossary_term' = 'GS1-128 Label Data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `otif_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pack_station_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Station Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^PLT[0-9A-Z]{8,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_accuracy_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Accuracy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_list_number` SET TAGS ('dbx_business_glossary_term' = 'Pick List Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_list_number` SET TAGS ('dbx_value_regex' = '^PL[0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pick Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'discrete|batch|zone|wave|cluster');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration in Seconds');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Started Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|assigned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'pick|pack|pick_and_pack|replenishment_pick');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Packer Operator Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `cartonization_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Cartonization Rule Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `destination_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `label_printed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Label Printed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'gs1_128|sscc|shipping_label|hazmat|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `otif_target_ship_date` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Pack Duration (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_station_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Station Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_status` SET TAGS ('dbx_business_glossary_term' = 'Pack Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|verified|exception|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_type` SET TAGS ('dbx_business_glossary_term' = 'Pack Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pack_type` SET TAGS ('dbx_value_regex' = 'carton|pallet|mixed_pallet|overpack|bulk');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^d{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `total_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `intransit_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Intransit Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Loaded By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'ground|express|overnight|two_day|economy|premium');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'retail_store|distribution_center|customer|warehouse|third_party');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `estimated_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|fob_origin|fob_destination');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `goods_issue_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `load_number` SET TAGS ('dbx_business_glossary_term' = 'Load Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late|incomplete|damaged|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|dsd|cross_dock|transfer|return');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `source_dc_code` SET TAGS ('dbx_business_glossary_term' = 'Source Distribution Center (DC) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `source_dc_code` SET TAGS ('dbx_value_regex' = '^DC[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `total_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Dc Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `actual_weight` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `catch_weight_flag` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `days_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Days On Hand (DOH)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `days_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_business_glossary_term' = 'Inventory Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_value_regex' = 'new|refurbished|returned|damaged|expired|recalled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|allocated|quarantine|hold|damaged|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `license_plate_number` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number (LPN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'owned|consignment|customer_owned|vendor_managed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `putaway_date` SET TAGS ('dbx_business_glossary_term' = 'Putaway Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_allocated` SET TAGS ('dbx_business_glossary_term' = 'Quantity Allocated');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available (ATP - Available to Promise)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_damaged` SET TAGS ('dbx_business_glossary_term' = 'Quantity Damaged');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_hold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand (QOH)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_quarantine` SET TAGS ('dbx_business_glossary_term' = 'Quantity Quarantine');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `storage_zone` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = 'LB|KG|OZ|G');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `distribution_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Cycle Count ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `primary_distribution_counter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `primary_distribution_counter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `primary_distribution_counter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `adjustment_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `adjustment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|rf_scanner|voice_picking|automated');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Count Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_reason_code` SET TAGS ('dbx_value_regex' = 'routine|discrepancy|audit|quality|recall|transfer');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|exception|blind|targeted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `inventory_value_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value Variance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `inventory_value_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `recount_number` SET TAGS ('dbx_business_glossary_term' = 'Recount Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'available|hold|quarantine|damaged|expired|reserved');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `tolerance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `tolerance_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ALTER COLUMN `wms_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` SET TAGS ('dbx_subdomain' = 'direct_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `distribution_dsd_route_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Direct Store Delivery (DSD) Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `average_order_value` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `average_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `estimated_drive_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Drive Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `estimated_service_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Service Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `last_optimization_date` SET TAGS ('dbx_business_glossary_term' = 'Last Optimization Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `merchandising_required` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `number_of_stops` SET TAGS ('dbx_business_glossary_term' = 'Number of Stops');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `osa_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `planned_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `planned_return_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Return Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Route Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `requires_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Requires Cold Chain Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `requires_hazmat_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Hazardous Materials (HAZMAT) Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `route_optimization_score` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Score');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|seasonal_closed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'standard|express|bulk|emergency|seasonal');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `service_day_pattern` SET TAGS ('dbx_business_glossary_term' = 'Service Day Pattern');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `service_day_pattern` SET TAGS ('dbx_value_regex' = '^(Mon|Tue|Wed|Thu|Fri|Sat|Sun)(,(Mon|Tue|Wed|Thu|Fri|Sat|Sun))*$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Start Location Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Start Location Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `total_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Total Route Distance (Kilometers)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `vehicle_capacity_required_units` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Capacity Required (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `vehicle_type_required` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type Required');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ALTER COLUMN `vehicle_type_required` SET TAGS ('dbx_value_regex' = 'small_van|medium_truck|large_truck|refrigerated_truck|flatbed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` SET TAGS ('dbx_subdomain' = 'direct_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `distribution_dsd_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Direct Store Delivery (DSD) Delivery ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `delivery_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_value_regex' = '^DSD-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `delivery_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `departure_time` SET TAGS ('dbx_business_glossary_term' = 'Departure Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `merchandising_activity_type` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Activity Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `merchandising_activity_type` SET TAGS ('dbx_value_regex' = 'shelf_stocking|rotation|display_setup|planogram_compliance|price_check|promotional_setup');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `merchandising_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Duration Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `merchandising_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Performed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `net_delivery_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Delivery Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `otif_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `pod_capture_method` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Capture Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `pod_capture_method` SET TAGS ('dbx_value_regex' = 'electronic_signature|photo|barcode_scan|manual_entry|none');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `pod_photo_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Photo URL');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `pod_signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature Image URL');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `return_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Credit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `scheduled_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `total_cases_delivered` SET TAGS ('dbx_business_glossary_term' = 'Total Cases Delivered');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `total_cases_returned` SET TAGS ('dbx_business_glossary_term' = 'Total Cases Returned');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `total_units_delivered` SET TAGS ('dbx_business_glossary_term' = 'Total Units Delivered');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `total_units_returned` SET TAGS ('dbx_business_glossary_term' = 'Total Units Returned');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` SET TAGS ('dbx_subdomain' = 'direct_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `dsd_delivery_line_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Delivery Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `distribution_dsd_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Delivery ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12}$|^d{13}$|^d{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'DELIVERED|PARTIAL|REJECTED|RETURNED|CANCELLED');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `planogram_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = 'DAMAGED|WRONG_PRODUCT|QUALITY|UNAUTHORIZED|EXPIRED|OTHER');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `shelf_placement_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Shelf Placement Confirmed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'AMBIENT|CHILLED|FROZEN');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `unit_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Selling Price');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `unit_selling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `otif_event_id` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `committed_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'dsd|ltl_carrier|ftl_carrier|parcel|customer_pickup|third_party_logistics');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `delivery_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Variance Days');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'OTIF Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|resolved|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `failure_category` SET TAGS ('dbx_business_glossary_term' = 'OTIF Failure Root Cause Category');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `failure_reason_detail` SET TAGS ('dbx_business_glossary_term' = 'OTIF Failure Reason Detail');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `in_full_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'In Full Tolerance Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'OTIF Measurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `otif_score` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Score');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `pod_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature Captured Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `quantity_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'dc_operations|inventory_planning|transportation|carrier|customer|external_factor');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `retailer_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Retailer Penalty Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `retailer_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|expedited|premium|next_day|same_day');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `dock_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Dock Appointment Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `actual_case_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `actual_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'inbound_receipt|outbound_load|inter_dc_transfer|cross_dock|returns_processing|emergency_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,25}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross Dock Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `detention_minutes` SET TAGS ('dbx_business_glossary_term' = 'Detention Time in Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `driver_phone` SET TAGS ('dbx_business_glossary_term' = 'Driver Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `driver_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `driver_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `expected_case_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `expected_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `expected_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Expected Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|emergency');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `scheduled_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|deep_frozen');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Load Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Supervisor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `actual_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|next_day|two_day|economy|white_glove');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `case_count` SET TAGS ('dbx_business_glossary_term' = 'Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `estimated_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Freight Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `estimated_freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `load_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `load_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `load_sequence_strategy` SET TAGS ('dbx_business_glossary_term' = 'Load Sequence Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `load_sequence_strategy` SET TAGS ('dbx_value_regex' = 'fifo|lifo|stop_sequence|priority');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'full_truckload|less_than_truckload|parcel|intermodal|dsd|pool_distribution');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `loading_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Loading Completion Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `loading_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Loading Start Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `otif_target_delivery_datetime` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Delivery Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `pallet_configuration` SET TAGS ('dbx_business_glossary_term' = 'Pallet Configuration');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `planned_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `stop_count` SET TAGS ('dbx_business_glossary_term' = 'Stop Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `total_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `trailer_code` SET TAGS ('dbx_business_glossary_term' = 'Trailer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `trailer_type` SET TAGS ('dbx_business_glossary_term' = 'Trailer Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `trailer_type` SET TAGS ('dbx_value_regex' = 'dry_van|refrigerated|flatbed|tanker|intermodal|box_truck');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `trailer_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Trailer Utilization Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `returns_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspector ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `receiving_clerk_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Clerk ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `receiving_clerk_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `receiving_clerk_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `case_count` SET TAGS ('dbx_business_glossary_term' = 'Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_value_regex' = 'resalable|damaged|expired|defective|contaminated');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM[0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `destroy_quantity` SET TAGS ('dbx_business_glossary_term' = 'Destroy Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `disposition_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'resale|destroy|rework|donate|return_to_vendor');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `inspection_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `resalable_quantity` SET TAGS ('dbx_business_glossary_term' = 'Resalable Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization (RA) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_value_regex' = '^RA[0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'damaged|expired|overstock|recall|defective|wrong_item');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_status` SET TAGS ('dbx_value_regex' = 'pending|received|inspected|processed|closed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'retailer|dsd_customer|consumer|recall|internal_transfer');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `scheduled_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `temperature_reading_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ALTER COLUMN `wms_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` SET TAGS ('dbx_association_edges' = 'distribution.distribution_facility,sustainability.carbon_offset');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ALTER COLUMN `distribution_offset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Allocation - Offset Allocation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Allocation - Carbon Offset Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Allocation - Distribution Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Offset Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `previous_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Wave Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `previous_wave_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `distribution_center_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `wave_name` SET TAGS ('dbx_business_glossary_term' = 'Wave Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `on_time_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `picker_count` SET TAGS ('dbx_business_glossary_term' = 'Picker Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wave Release Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `wave_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `strategy` SET TAGS ('dbx_business_glossary_term' = 'Wave Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `total_items` SET TAGS ('dbx_business_glossary_term' = 'Total Items');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `total_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Orders');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_business_glossary_term' = 'Wave Type');
