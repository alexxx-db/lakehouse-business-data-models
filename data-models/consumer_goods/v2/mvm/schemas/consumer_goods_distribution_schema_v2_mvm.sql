-- Schema for Domain: distribution | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-07-10 14:48:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`distribution` COMMENT 'Owns warehouse operations, inventory management, and order fulfillment across distribution centers. Manages inbound/outbound logistics within DCs, put-away/picking/packing processes, cycle counting, FEFO/FIFO inventory rotation, WMS integration (Blue Yonder), OTIF performance, OSA metrics, and DSD execution for direct store delivery channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` (
    `distribution_facility_id` BIGINT COMMENT 'Primary key for facility',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each distribution facility belongs to a legal entity (company code) for statutory reporting, intercompany billing between DCs, and tax compliance. Multi-entity consumer goods companies require this fo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DC facility operating costs (labor, utilities, lease) are tracked against a cost center for overhead allocation and logistics budget management. Every consumer goods DC is assigned a cost center in SA',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Primary key for storage_location',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the parent distribution center facility where this storage location resides.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: DC slotting optimization and putaway strategy designate storage locations for specific product categories (e.g., hazmat zones, temperature zones, promotional zones). Category-based slotting is a named',
    `abc_classification` STRING COMMENT 'Velocity-based classification of the location for slotting optimization: A (high-velocity/fast-moving), B (medium-velocity), C (low-velocity/slow-moving).. Valid values are `A|B|C`',
    `aisle` STRING COMMENT 'Aisle designation within the warehouse layout for physical navigation and picking route optimization.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bay` STRING COMMENT 'Bay or column position within the aisle for precise horizontal location reference.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bin_position` STRING COMMENT 'Specific bin or slot position within the level for granular inventory placement and retrieval.. Valid values are `^[A-Z0-9]{1,5}$`',
    `blocked_date` DATE COMMENT 'Date when the storage location was blocked or made unavailable for operations.',
    `blocked_reason` STRING COMMENT 'Explanation for why the location is blocked or unavailable, such as maintenance, damage, safety hold, or quality quarantine.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the storage location record was first created in the WMS system.',
    `cycle_count_frequency` STRING COMMENT 'Scheduled frequency for cycle counting inventory at this location to maintain inventory accuracy and compliance.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `distribution_storage_location_level` STRING COMMENT 'Vertical level or shelf position within the bay for height-based slotting and equipment compatibility.. Valid values are `^[A-Z0-9]{1,3}$`',
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
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Granular storage location master within a distribution center — aisles, bays, levels, bin positions, and pick faces as defined in Blue Yonder WMS. Tracks location type (bulk, pick, reserve, staging, dock), zone classification, temperature zone, weight/volume capacity, and FEFO/FIFO eligibility flags. Enables put-away and picking optimization at the slot level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` (
    `inbound_receipt_id` BIGINT COMMENT 'Unique identifier for the inbound receipt transaction. Primary key for this entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Inbound receipts are posted against a specific legal entity for 3-way match processing, statutory inventory accounting, and intercompany goods receipt reconciliation. Required for correct AP invoice m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receiving operations incur expenses (labor, equipment) that are allocated to a cost center for expense tracking and budgeting.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Inbound receipts planned against demand plans for synchronized replenishment timing. Essential for S&OP execution tracking, plan vs. actual receipt variance analysis, and demand-supply synchronization',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Goods receipt postings debit the inventory GL account and credit GR/IR clearing. The inbound_receipt must reference the GL account to support 3-way match (PO/GR/Invoice) and inventory valuation postin',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Internal transfer receipt: inbound receipts from own plants need the source manufacturing facility to track internal logistics and cost allocation.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center facility where the goods were received.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Required for R&D material receipt tracking; links each inbound receipt to the RD project that requested the raw material for formulation trials.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: 3-way match (PO/GR/invoice) is the core AP reconciliation process in consumer goods. Linking inbound_receipt to purchase_order enables automated quantity variance reporting, OTIF compliance tracking a',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor who shipped the goods, representing the counterparty in this receipt transaction.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Site-level supplier performance tracking (OTIF, quality compliance, lead time actuals vs. contracted) is a standard consumer goods procurement KPI. Linking inbound_receipt to supplier_site enables sit',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each receipt line generates a line-level GL posting (inventory account debit by SKU/category). Line-level GL account linkage supports detailed cost accounting, inventory variance analysis by product, ',
    `gtin_registry_id` BIGINT COMMENT 'Foreign key linking to product.gtin_registry. Business justification: GS1 GTIN validation at inbound receiving is a mandatory consumer goods compliance process — receipt lines must validate scanned GTINs against the GS1 registry to confirm product authenticity, correct ',
    `inbound_receipt_id` BIGINT COMMENT 'Reference to the parent inbound receipt header transaction. Links this line to the overall receipt event.',
    `label_spec_id` BIGINT COMMENT 'Foreign key linking to product.label_spec. Business justification: Inbound label compliance verification is a regulatory requirement in consumer goods — received products must have labels matching the approved label spec for the target market (correct language, regul',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Regulatory registration verification during inbound receipt ensures each received SKU is registered in the jurisdiction, a standard compliance step.',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: Inbound receiving process requires verification that received packaging matches the approved packaging spec (dimensions, weight, material type) for quality inspection and putaway decisions — a standar',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Line-level 3-way match (PO line vs receipt line vs invoice line) is standard AP reconciliation in consumer goods. This FK enables over/under delivery tolerance checks, quantity variance reporting per ',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Needed to associate each receipt line (specific SKU/lot) with the RD project using it, enabling traceability of trial material consumption.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: RECEIVING: When a receipt line is processed, a Stock Position record is created/updated to reflect on‑hand quantity at the DC.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Link receipt line to SKU master for traceability and quality inspection; required by receipt processing and compliance audit reports.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Each inbound receipt line records the specific storage location where goods were put away after receipt (FEFO/FIFO putaway). inbound_receipt_line.storage_location_code is a denormalized STRING code re',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who shipped the goods. Used for supplier performance tracking and procurement analytics.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Lot and batch traceability to specific supplier manufacturing sites is a regulatory requirement in consumer goods (food safety, cosmetics GMP). Linking receipt lines to supplier_site enables site-leve',
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
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was last updated. Audit trail for tracking changes to receipt data.',
    `line_number` STRING COMMENT 'Sequential line number within the inbound receipt. Used for ordering and referencing specific lines in the receipt document.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number assigned by the supplier. Critical for traceability, quality control, and recall management in consumer goods.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `manufacture_date` DATE COMMENT 'Date when the product was manufactured by the supplier. Used for shelf-life calculations and FEFO inventory rotation.',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet or handling unit containing this receipt line. Used for put-away and storage location assignment.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `put_away_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were put away into their assigned storage location. Used for warehouse productivity and cycle time measurement.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this receipt line requires quality inspection before being released to available inventory. True for regulated or high-risk products.',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection for this receipt line. Determines whether goods can be released to available inventory or must remain in quarantine.. Valid values are `not_required|pending|in_progress|passed|failed|conditional`',
    `receipt_status` STRING COMMENT 'Current processing status of this receipt line within the warehouse workflow. Tracks progression from initial receipt through put-away completion.. Valid values are `pending|received|inspected|put_away|discrepancy|rejected`',
    `received_quantity_cases` DECIMAL(18,2) COMMENT 'Quantity of product received measured in cases. Represents the outer packaging unit typically used for warehouse handling.',
    `received_quantity_eaches` DECIMAL(18,2) COMMENT 'Quantity of product received measured in individual units (eaches). Represents the consumer-facing unit count.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were physically received at the warehouse dock. Critical for OTIF performance measurement and cycle time analytics.',
    `sscc` STRING COMMENT '18-digit Serial Shipping Container Code identifying the logistics unit. Global standard for tracking pallets and containers in the supply chain.. Valid values are `^[0-9]{18}$`',
    `temperature_at_receipt_celsius` DECIMAL(18,2) COMMENT 'Temperature measurement in Celsius recorded at the time of receipt. Critical for cold chain compliance and product quality verification.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for the received goods as specified in the purchase order. Used for inventory valuation and COGS calculation.',
    `unit_of_measure` STRING COMMENT 'Primary unit of measure for the received quantity. Defines the counting and handling unit for warehouse operations.. Valid values are `case|each|pallet|layer|inner_pack|display_unit`',
    `upc` STRING COMMENT 'Universal Product Code barcode identifier for the received item. Standard 12-digit UPC-A format used in North American retail.. Valid values are `^[0-9]{12}$`',
    `variance_quantity_cases` DECIMAL(18,2) COMMENT 'Difference between expected and received quantity in cases. Positive values indicate overages, negative values indicate shortages.',
    `variance_quantity_eaches` DECIMAL(18,2) COMMENT 'Difference between expected and received quantity in eaches. Positive values indicate overages, negative values indicate shortages.',
    CONSTRAINT pk_inbound_receipt_line PRIMARY KEY(`inbound_receipt_line_id`)
) COMMENT 'Line-level detail for each SKU/lot received within an inbound receipt transaction. Captures SKU code, GTIN, lot number, manufacture date, expiry date, received quantity (cases and eaches), unit of measure, pallet ID, temperature at receipt, and variance from expected ASN quantity. Supports FEFO/FIFO lot registration and discrepancy resolution workflows.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` (
    `outbound_order_id` BIGINT COMMENT 'Unique identifier for the outbound fulfillment order. Primary key for the outbound order entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Outbound orders are executed under a specific legal entity for revenue recognition, intercompany sales billing, and statutory reporting. Required for correct sales order-to-cash accounting in multi-en',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Outbound order fulfillment costs (pick, pack, ship labor) are tracked against cost centers for distribution cost management. Consumer goods companies allocate order fulfillment expenses to cost center',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Outbound orders fulfill demand plan commitments to customers/retailers. Critical for demand plan consumption tracking, forecast accuracy measurement, and S&OP cycle performance reporting in consumer g',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotional Order Fulfillment Tracking: trade promotion managers measure OTIF compliance at the order level against promotional commitments. Linking outbound_order directly to promotion_event enables ',
    `inventory_policy_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_policy. Business justification: Outbound orders must respect inventory policies for allocation rules, service level commitments, and OTIF targets. Critical for order promising, allocation decisions, and retailer service level agreem',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Freight order creation for every outbound order manages carrier tendering, freight cost tracking, and audit.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order document in the ERP system. Links outbound fulfillment to revenue recognition and customer order management.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center fulfilling the outbound order. Determines inventory source and warehouse operations responsible for order execution.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Supports pilot order execution; outbound orders for prototype SKUs are linked to the RD project that owns the launch trial.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Regulatory traceability: outbound orders must reference the production order that generated the shipped product for recall and compliance reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed for revenue recognition and profit‑center reporting; each outbound orders sales revenue is attributed to a profit center.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: In consumer goods, intercompany transfers and DSD replenishment outbound orders are triggered by purchase orders from receiving entities. Linking outbound_order to purchase_order enables PO-driven ful',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: DSD (direct store delivery) orders in consumer goods are fulfilled directly to retail stores. Essential for store-level delivery tracking, DSD route management, and store replenishment operations.',
    `sku_id` BIGINT COMMENT 'FK to product.sku.sku_id — Links distribution outbound orders to product master. Required for product-level fulfillment analytics, category-level DC throughput reporting.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Make-to-order and direct-ship scenarios require outbound orders to specify the source manufacturing plant. Critical for plant-direct shipments, custom production orders, and supply chain visibility wh',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Line-level lot traceability for serialized products and mixed-lot shipments. Each line item must reference the specific manufacturing batch for granular recall execution, quality investigations, and r',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotion Attribution Report requires linking each order line to the promotion event that drove the sale; experts expect this FK to attribute revenue to promotions.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each outbound order line drives revenue and COGS GL postings at goods issue. Line-level GL account linkage supports revenue recognition by product line, channel profitability reporting, and audit trai',
    `gtin_registry_id` BIGINT COMMENT 'Foreign key linking to product.gtin_registry. Business justification: Outbound EDI compliance and retailer GTIN validation require each order lines GTIN to be validated against the GS1 registry. Consumer goods retailers mandate GS1-compliant GTIN data on ASNs and EDI 8',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound fulfillment order header.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: PICKING: Outbound order line pick reduces the corresponding Stock Position quantity, linking order fulfillment to inventory balances.',
    `promoted_price_id` BIGINT COMMENT 'Foreign key linking to promotion.promoted_price. Business justification: Promotional Pricing Audit and Deduction Reconciliation: deduction settlement teams verify that the price applied on each outbound order line matches the approved promoted_price record. This direct FK ',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: Each outbound order line is fulfilled by a specific distribution shipment — the shipment carries the physical goods for that line. outbound_order_line has ship_timestamp, shipped_quantity, and actual_',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Label version compliance check before order fulfillment guarantees the label used for the SKU is approved for the destination market.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Outbound order line items are stored in a DC location before picking. Adding a FK to distribution_storage_location enables location lookup and normalizes location data.',
    `actual_ship_date` DATE COMMENT 'Actual date the line was shipped from the distribution center.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity allocated from warehouse inventory to this order line.',
    `base_unit_quantity` DECIMAL(18,2) COMMENT 'Quantity converted to base unit of measure for standardized reporting and inventory tracking.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed available for fulfillment after ATP (Available to Promise) check.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order line record was first created in the system.',
    `customer_po_line_number` STRING COMMENT 'Customers purchase order line number for cross-reference and reconciliation.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this line is part of a direct store delivery order bypassing retailer distribution centers.',
    `edi_line_reference` STRING COMMENT 'EDI transaction line reference number for electronic order processing and ASN generation.',
    `expiry_date` DATE COMMENT 'Product expiration date for FEFO inventory rotation and shelf-life management.',
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
    `atp_record_id` BIGINT COMMENT 'Foreign key linking to supply.atp_record. Business justification: Pick tasks execute against ATP confirmations for order promising accuracy. Links warehouse execution to supply availability commitments, essential for ATP consumption tracking and order fulfillment re',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Picking must specify lot/batch for FEFO compliance and traceability. WMS pick tasks require batch_record linkage to enforce expiry-based picking strategies, quality status checks, and maintain unbroke',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pick task labor costs are charged to a cost center; required for labor cost analysis and OTIF performance metrics.',
    `storage_location_id` BIGINT COMMENT 'Reference to the target location where picked items are staged or packed (e.g., pack station, staging lane, loading dock).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pick tasks generate direct labor cost GL postings in consumer goods DC operations. Linking pick_task to gl_account enables labor cost accounting by GL account, supports activity-based costing for pick',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound order or shipment order that generated this pick task.',
    `outbound_order_line_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order_line. Business justification: Pick tasks are generated at the order line level in WMS execution — each pick task fulfills a specific SKU/quantity from a specific outbound order line. pick_task already has outbound_order_id (header',
    `primary_pick_distribution_storage_location_id` BIGINT COMMENT 'Reference to the warehouse storage location (bin, shelf, pallet position) from which inventory is picked.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: In DC outbound execution, pick and pack tasks are directly associated with a specific shipment — the packed carton (identified by pick_task.carton_code and pick_task.sscc) is loaded onto a specific tr',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the distribution shipment record. Primary key for the distribution shipment entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Shipments are executed under a specific legal entity for intercompany freight billing, statutory freight cost reporting, and customs/export compliance. Required for correct entity-level logistics cost',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for shipment cost allocation report; logistics expenses are charged to a cost center, a standard practice in consumer‑goods distribution.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Shipment Manifest for Promotional Campaigns tracks which shipment fulfills which promotion event, used for logistics planning and compliance reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Shipments generate freight cost GL postings (freight expense account debit). Linking distribution_shipment to gl_account enables freight cost accrual reporting, carrier spend analysis by GL account, a',
    `load_plan_id` BIGINT COMMENT 'Foreign key linking to distribution.load_plan. Business justification: A distribution shipment is the physical execution of a load plan — the load plan defines trailer assignment, stop sequence, and departure schedule, while the shipment records actual departure and deli',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Shipment origin tracking: linking shipments to the originating manufacturing facility enables performance dashboards and OTIF analysis.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Costing and transit planning use lane definitions; linking shipment to lane provides distance, rate, and compliance data.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: SHIPMENT HAND‑OFF: Distribution shipment creates an In‑Transit Shipment record to track movement from DC to destination.',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order. Business justification: Shipment is a child of an outbound order; each shipment fulfills an order. Adding outbound_order_id to distribution_shipment creates the necessary parent link without creating a bidirectional relation',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Enables shipment‑level reporting for R&D pilot shipments, required for OTIF and regulatory compliance of trial product deliveries.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Shipment-level profit center assignment supports channel/region profitability reporting — standard in consumer goods for trade spend and logistics cost allocation by brand or sales channel. Enables se',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Shipments to retail stores (especially DSD) require direct tracking for delivery confirmation, store receiving, and store-level OTIF performance measurement. Core to consumer goods store delivery oper',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: OTIF and delivery KPI dashboards measure shipment performance per marketing campaign, requiring a direct shipment‑to‑campaign link.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: A distribution shipment physically departs from a specific DC. distribution_shipment.source_dc_code is a denormalized STRING code referencing the originating distribution facility. Replacing it with a',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Shipments must track which customer account theyre for, essential for customer-level OTIF reporting, billing reconciliation, and customer service inquiries. Core to consumer goods account management.',
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
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this shipment requires temperature-controlled transportation for product integrity.',
    `total_units` STRING COMMENT 'Total quantity of individual sellable units (eaches) included in the shipment across all SKUs.',
    `total_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total cube or volume of the shipment in cubic meters. Critical for trailer utilization and dimensional weight calculations.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms including product and packaging. Used for freight rating and load planning.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for real-time shipment visibility and customer self-service tracking.',
    `trailer_number` STRING COMMENT 'Identifier of the trailer or container unit used to transport the shipment. Critical for load tracking and yard management.',
    `wave_number` STRING COMMENT 'Identifier of the warehouse picking wave that generated the orders included in this shipment. Links shipment to WMS wave planning.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Outbound shipment record representing the physical dispatch of goods from a DC to a customer, retailer, or downstream DC. Captures shipment number, carrier, trailer/container ID, seal number, dock door, scheduled and actual departure datetime, destination, total weight, total cube, pallet count, carton count, and OTIF status. Integrates with Blue Yonder WMS load planning and SAP SD goods issue. SSOT for DC-level outbound shipment execution distinct from the logistics domains carrier-level shipment tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` (
    `inventory_position_id` BIGINT COMMENT 'Primary key for inventory_position',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Lot-controlled inventory management requires each inventory position to reference the manufacturing batch. Essential for FEFO picking, expiry management, quality holds, and recall execution. Consumer ',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Inventory is owned by a specific legal entity — required for statutory balance sheet reporting, intercompany inventory transfer pricing, and legal entity-level working capital reporting. Fundamental f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory positions require cost center assignment for inventory carrying cost allocation, cycle count cost tracking, and write-off/write-down postings. Consumer goods finance teams report inventory h',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotional Inventory Reservation: CPG planners ring-fence stock for specific promotion events to guarantee availability. Linking inventory_position to promotion_event enables visibility into how much',
    `inventory_policy_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_policy. Business justification: DC inventory positions governed by inventory policies defining service levels, reorder points, and replenishment methods. Essential for policy compliance reporting and automated replenishment rule exe',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the specific lot or batch of the SKU. Critical for traceability, quality control, and FEFO inventory rotation.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Provides real‑time visibility of prototype SKU inventory tied to the RD project, essential for launch readiness dashboards.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Inventory positions are assigned to profit centers for segment-level inventory valuation and working capital reporting by brand/channel. Required for profit center accounting (PCA) in SAP — standard c',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: DC inventory positions reference safety stock policies to trigger replenishment when on-hand falls below safety stock thresholds. Critical for automated replenishment decisions and stockout prevention',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU for which inventory position is tracked.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Inventory valuation in consumer goods uses standard costs per SKU. Linking inventory_position to standard_cost enables real-time inventory value calculation (qty × standard cost), purchase price varia',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Inventory position records on‑hand quantities at a specific DC location. Linking to distribution_storage_location provides the authoritative location details and removes the generic storage_location_i',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` (
    `load_plan_id` BIGINT COMMENT 'Unique identifier for the outbound load plan record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Load plans drive freight cost commitments and carrier spend tracked against cost centers for logistics budget management. Consumer goods DC operations allocate planned freight costs to cost centers fo',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center from which this load is being dispatched.',
    `outbound_order_id` BIGINT COMMENT 'add column outbound_order_id (BIGINT) with FK to distribution.outbound_order.outbound_order_id - load plans fulfill outbound orders and need that reference',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Category-based load planning is a real consumer goods DC process — hazmat product categories require trailer segregation, temperature-sensitive categories require specific zones, and promotional categ',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Load plans for DSD routes consolidate deliveries to multiple retail stores. Essential for multi-stop route optimization, store delivery sequencing, and DSD logistics planning in consumer goods.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ADD CONSTRAINT `fk_distribution_storage_location_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`(`outbound_order_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_primary_pick_distribution_storage_location_id` FOREIGN KEY (`primary_pick_distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_load_plan_id` FOREIGN KEY (`load_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`load_plan`(`load_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Velocity Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_business_glossary_term' = 'Bin Position Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_business_glossary_term' = 'Rack Level Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Location Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_business_glossary_term' = 'Material Handling Equipment Type Required');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_value_regex' = 'forklift|reach_truck|order_picker|pallet_jack|manual|automated');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Location Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `fefo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `fifo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Height (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Length (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|quarantine|damaged');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bulk|pick|reserve|staging|dock|cross_dock');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `mixed_lot_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Lot/Batch Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `mixed_sku_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'batch|wave|zone|discrete|cluster');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_business_glossary_term' = 'Put-Away Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_value_regex' = 'directed|random|fixed|dynamic');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `replenishment_priority` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `volume_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume Capacity (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Width (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` SET TAGS ('dbx_subdomain' = 'inbound_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` SET TAGS ('dbx_subdomain' = 'inbound_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `temperature_at_receipt_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receipt Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'case|each|pallet|layer|inner_pack|display_unit');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `variance_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `variance_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Manufacturing Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `promoted_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `base_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `customer_po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `edi_line_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Line Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `atp_record_id` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `primary_pick_distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Intransit Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'ground|express|overnight|two_day|economy|premium');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'retail_store|distribution_center|customer|warehouse|third_party');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `estimated_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|fob_origin|fob_destination');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `goods_issue_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late|incomplete|damaged|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|dsd|cross_dock|transfer|return');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `total_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Dc Location Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Load Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
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
