-- Schema for Domain: distribution | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`distribution` COMMENT 'Owns warehouse operations, inventory management, and order fulfillment across distribution centers. Manages inbound/outbound logistics within DCs, put-away/picking/packing processes, cycle counting, FEFO/FIFO inventory rotation, WMS integration (Blue Yonder), OTIF performance, OSA metrics, and DSD execution for direct store delivery channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` (
    `distribution_facility_id` BIGINT COMMENT 'Primary key for facility',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Multi-entity consumer goods companies assign each distribution facility to a legal entity for statutory reporting, intercompany billing, and tax compliance. Required for correct GL posting of facility',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Distribution facility operating costs (labor, utilities, maintenance) are allocated to a cost center for overhead reporting and P&L. Consumer goods finance teams require facility-level cost center ass',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distribution facilities in consumer goods are mapped to profit centers for segment profitability reporting and distribution network P&L. Required for management reporting on distribution cost per prof',
    `address_line_1` STRING COMMENT 'The address line 1 of the distribution facility record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the distribution facility record',
    `city` STRING COMMENT 'The city of the distribution facility record',
    `closed_date` DATE COMMENT 'The closed date of the distribution facility record',
    `distribution_facility_code` STRING COMMENT 'The distribution facility code of the distribution facility record',
    `country_code` STRING COMMENT 'The country code of the distribution facility record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the distribution facility record',
    `cross_dock_enabled_flag` BOOLEAN COMMENT 'The cross dock enabled flag of the distribution facility record',
    `currency_code` STRING COMMENT 'The currency code of the distribution facility record',
    `dc_code` STRING COMMENT 'The dc code of the distribution facility record',
    `dc_name` STRING COMMENT 'The dc name of the distribution facility record',
    `distribution_facility_description` STRING COMMENT 'The distribution facility description of the distribution facility record',
    `distribution_facility_status` STRING COMMENT 'The distribution facility status of the distribution facility record',
    `dock_doors_inbound` STRING COMMENT 'The dock doors inbound of the distribution facility record',
    `dock_doors_outbound` STRING COMMENT 'The dock doors outbound of the distribution facility record',
    `dsd_hub_flag` BOOLEAN COMMENT 'The dsd hub flag of the distribution facility record',
    `effective_from` DATE COMMENT 'The effective from of the distribution facility record',
    `effective_until` DATE COMMENT 'The effective until of the distribution facility record',
    `facility_code` STRING COMMENT 'The facility code of the distribution facility record',
    `facility_name` STRING COMMENT 'The facility name of the distribution facility record',
    `facility_type` STRING COMMENT 'The facility type of the distribution facility record',
    `gmp_certified_flag` BOOLEAN COMMENT 'The gmp certified flag of the distribution facility record',
    `hazmat_certified_flag` BOOLEAN COMMENT 'The hazmat certified flag of the distribution facility record',
    `inventory_rotation_method` STRING COMMENT 'The inventory rotation method of the distribution facility record',
    `latitude` DECIMAL(18,2) COMMENT 'The latitude of the distribution facility record',
    `longitude` DECIMAL(18,2) COMMENT 'The longitude of the distribution facility record',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the distribution facility record',
    `distribution_facility_name` STRING COMMENT 'The distribution facility name of the distribution facility record',
    `notes` STRING COMMENT 'The notes of the distribution facility record',
    `number_of_dock_doors` STRING COMMENT 'The number of dock doors of the distribution facility record',
    `opened_date` DATE COMMENT 'The opened date of the distribution facility record',
    `operational_status` STRING COMMENT 'The operational status of the distribution facility record',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'The otif target percentage of the distribution facility record',
    `postal_code` STRING COMMENT 'The postal code of the distribution facility record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the distribution facility record',
    `sap_plant_code` STRING COMMENT 'The sap plant code of the distribution facility record',
    `source_system_code` STRING COMMENT 'The source system code of the distribution facility record',
    `square_footage` DECIMAL(18,2) COMMENT 'The square footage of the distribution facility record',
    `state_province` STRING COMMENT 'The state province of the distribution facility record',
    `storage_capacity_pallet_positions` STRING COMMENT 'The storage capacity pallet positions of the distribution facility record',
    `storage_capacity_pallets` STRING COMMENT 'The storage capacity pallets of the distribution facility record',
    `supply_network_node_code` BIGINT COMMENT 'The supply network node id of the distribution facility record',
    `temperature_controlled_flag` BOOLEAN COMMENT 'The temperature controlled flag of the distribution facility record',
    `time_zone` STRING COMMENT 'The time zone of the distribution facility record',
    `total_capacity_sqft` DECIMAL(18,2) COMMENT 'The total capacity sqft of the distribution facility record',
    `uom` STRING COMMENT 'The uom of the distribution facility record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the distribution facility record',
    `wms_site_code` STRING COMMENT 'The wms site code of the distribution facility record',
    CONSTRAINT pk_distribution_facility PRIMARY KEY(`distribution_facility_id`)
) COMMENT 'Master record for each physical distribution center (DC) or warehouse facility in the CPG network. Captures DC identity, location, type (ambient, chilled, frozen, DSD hub), capacity metrics, WMS integration identifiers (Blue Yonder site codes), SAP plant/storage location mappings, operating hours, and operational status. SSOT for DC facility master data across the distribution domain. [SSOT: authoritative table is manufacturing.manufacturing_facility; this table is a deprecated duplicate.] [SSOT: authoritative table is manufacturing.manufacturing_facility; this is a deprecated duplicate for concept facility.] [Non-authoritative; defers to SSOT manufacturing.manufacturing_facility for concept facility.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Primary key for storage_location',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the parent distribution center facility where this storage location resides.',
    `abc_classification` STRING COMMENT 'The abc classification of the distribution storage location record',
    `aisle` STRING COMMENT 'The aisle of the distribution storage location record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the distribution storage location record',
    `bay` STRING COMMENT 'The bay of the distribution storage location record',
    `bin_code` STRING COMMENT 'The bin code of the distribution storage location record',
    `bin_position` STRING COMMENT 'The bin position of the distribution storage location record',
    `blocked_date` DATE COMMENT 'The blocked date of the distribution storage location record',
    `blocked_reason` STRING COMMENT 'The blocked reason of the distribution storage location record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the distribution storage location record',
    `currency_code` STRING COMMENT 'The currency code of the distribution storage location record',
    `cycle_count_frequency` STRING COMMENT 'The cycle count frequency of the distribution storage location record',
    `distribution_storage_location_code` STRING COMMENT 'The distribution storage location code of the distribution storage location record',
    `distribution_storage_location_description` STRING COMMENT 'The distribution storage location description of the distribution storage location record',
    `distribution_storage_location_level` STRING COMMENT 'The distribution storage location level of the distribution storage location record',
    `distribution_storage_location_name` STRING COMMENT 'The distribution storage location name of the distribution storage location record',
    `distribution_storage_location_status` STRING COMMENT 'The distribution storage location status of the distribution storage location record',
    `dsd_eligible_flag` BOOLEAN COMMENT 'The dsd eligible flag of the distribution storage location record',
    `effective_date` DATE COMMENT 'The effective date of the distribution storage location record',
    `effective_from` DATE COMMENT 'The effective from of the distribution storage location record',
    `effective_until` DATE COMMENT 'The effective until of the distribution storage location record',
    `equipment_type_required` STRING COMMENT 'The equipment type required of the distribution storage location record',
    `expiration_date` DATE COMMENT 'The expiration date of the distribution storage location record',
    `fefo_eligible_flag` BOOLEAN COMMENT 'The fefo eligible flag of the distribution storage location record',
    `fifo_eligible_flag` BOOLEAN COMMENT 'The fifo eligible flag of the distribution storage location record',
    `hazmat_certified_flag` BOOLEAN COMMENT 'The hazmat certified flag of the distribution storage location record',
    `height_cm` DECIMAL(18,2) COMMENT 'The height cm of the distribution storage location record',
    `is_blocked` BOOLEAN COMMENT 'The is blocked of the distribution storage location record',
    `is_pickable` BOOLEAN COMMENT 'The is pickable of the distribution storage location record',
    `level_code` STRING COMMENT 'The level code of the distribution storage location record',
    `location_code` STRING COMMENT 'The location code of the distribution storage location record',
    `location_type` STRING COMMENT 'The location type of the distribution storage location record',
    `max_volume_cubic_m` DECIMAL(18,2) COMMENT 'The max volume cubic m of the distribution storage location record',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'The max weight kg of the distribution storage location record',
    `notes` STRING COMMENT 'The notes of the distribution storage location record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the distribution storage location record',
    `source_system_code` STRING COMMENT 'The source system code of the distribution storage location record',
    `storage_class` STRING COMMENT 'The storage class of the distribution storage location record',
    `temperature_zone` STRING COMMENT 'The temperature zone of the distribution storage location record',
    `uom` STRING COMMENT 'The uom of the distribution storage location record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the distribution storage location record',
    `zone_code` STRING COMMENT 'The zone code of the distribution storage location record',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Granular storage location master within a distribution center — aisles, bays, levels, bin positions, and pick faces as defined in Blue Yonder WMS. Tracks location type (bulk, pick, reserve, staging, dock), zone classification, temperature zone, weight/volume capacity, and FEFO/FIFO eligibility flags. Enables put-away and picking optimization at the slot level. [SSOT: authoritative table is inventory.inventory_storage_location; this table is a deprecated duplicate.] [SSOT: authoritative table is inventory.inventory_storage_location; this is a deprecated duplicate for concept storage_location.] [Non-authoritative; defers to SSOT inventory.inventory_storage_location for concept storage_location.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` (
    `inbound_receipt_id` BIGINT COMMENT 'Unique identifier for the inbound receipt transaction. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier that delivered the shipment to the distribution center.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receiving operations incur expenses (labor, equipment) that are allocated to a cost center for expense tracking and budgeting.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Inbound receipts trigger a specific inspection plan governing AQL level, sampling procedure, and test requirements. The receipts quality_inspection_required_flag and quality_inspection_status fields ',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Inbound freight audit and carrier performance: consumer goods DC receiving teams match inbound receipts to logistics shipments to validate carrier delivery performance, measure transit time accuracy, ',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Internal transfer receipt: inbound receipts from own plants need the source manufacturing facility to track internal logistics and cost allocation.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center facility where the goods were received.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: In consumer goods, finished goods transfers from plant to DC are triggered by production orders. The inbound receipt at the DC must reference the originating production order for goods movement tracea',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: DRP-generated replenishment orders are the source documents for DC inbound receipts. DC receiving teams match receipts to replenishment orders for OTIF measurement, discrepancy resolution, and invento',
    `return_order_id` BIGINT COMMENT 'Foreign key linking to sales.return_order. Business justification: Consumer goods reverse logistics: customer return authorizations (return_order) must be matched to physical inbound receipts at the DC for quantity reconciliation, quality inspection disposition, and ',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor who shipped the goods, representing the counterparty in this receipt transaction.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Inbound receipts capture supplier_id but not supplier_site_id, losing site-level granularity needed for quality inspection routing, GMP compliance verification by site, and supplier site OTIF scorecar',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods accepted into inventory after quality inspection, excluding rejected or damaged items.',
    `actual_arrival` TIMESTAMP COMMENT 'The actual arrival of the inbound receipt record',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'The actual arrival timestamp of the inbound receipt record',
    `actual_receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical goods arrived and were checked in at the receiving dock, representing the principal business event for this transaction.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the inbound receipt record',
    `asn_number` STRING COMMENT 'Reference to the Advanced Shipping Notice document sent by the supplier prior to shipment arrival, enabling pre-receipt planning and dock scheduling.. Valid values are `^[A-Z0-9]{8,30}$`',
    `asn_reference` STRING COMMENT 'The asn reference of the inbound receipt record',
    `case_count` STRING COMMENT 'Number of cases or cartons received in this inbound shipment.',
    `inbound_receipt_code` STRING COMMENT 'The inbound receipt code of the inbound receipt record',
    `container_number` STRING COMMENT 'ISO standard container identifier for ocean freight shipments, following the BIC (Bureau International des Containers) format.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt record was first created in the system, representing the audit trail start point.',
    `currency_code` STRING COMMENT 'The currency code of the inbound receipt record',
    `inbound_receipt_description` STRING COMMENT 'The inbound receipt description of the inbound receipt record',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicator of whether any discrepancies (quantity, quality, or documentation) were identified during the receiving process.',
    `discrepancy_notes` STRING COMMENT 'Free-text description providing additional details about any discrepancies identified during the receiving process.',
    `discrepancy_reason` STRING COMMENT 'Classification of the type of discrepancy identified during receiving, used for root cause analysis and supplier performance management.. Valid values are `overage|shortage|damage|wrong_product|quality_issue|documentation_error`',
    `dock_door` STRING COMMENT 'The dock door of the inbound receipt record',
    `dock_door_number` STRING COMMENT 'Physical dock door location where the inbound shipment was unloaded, used for labor planning and dock utilization tracking.. Valid values are `^[A-Z0-9]{1,10}$`',
    `effective_from` DATE COMMENT 'The effective from of the inbound receipt record',
    `effective_until` DATE COMMENT 'The effective until of the inbound receipt record',
    `expected_arrival_timestamp` TIMESTAMP COMMENT 'The expected arrival timestamp of the inbound receipt record',
    `expected_quantity` DECIMAL(18,2) COMMENT 'Total quantity of goods expected to be received based on the ASN or purchase order, used for discrepancy detection.',
    `goods_receipt_document_number` STRING COMMENT 'SAP Material Management (MM) goods receipt document number generated upon posting the receipt to inventory, linking WMS to ERP.. Valid values are `^[A-Z0-9]{8,20}$`',
    `inbound_receipt_status` STRING COMMENT 'The inbound receipt status of the inbound receipt record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt record was last updated, supporting audit trail and data lineage requirements.',
    `inbound_receipt_name` STRING COMMENT 'The inbound receipt name of the inbound receipt record',
    `notes` STRING COMMENT 'The notes of the inbound receipt record',
    `otif_compliant_flag` BOOLEAN COMMENT 'Indicator of whether this receipt met both on-time delivery and complete quantity requirements, key supplier performance metric.',
    `pallet_count` STRING COMMENT 'Number of pallets received in this inbound shipment, used for dock capacity planning and labor allocation.',
    `putaway_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all received goods were moved from the receiving dock to their designated storage locations, completing the inbound process.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicator of whether formal quality inspection was required for this receipt based on product category, supplier risk profile, or regulatory requirements.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection process for this receipt, tracking progression through quality control workflow.. Valid values are `not_required|pending|in_progress|passed|failed`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the inbound receipt record',
    `receipt_completed_timestamp` TIMESTAMP COMMENT 'The receipt completed timestamp of the inbound receipt record',
    `receipt_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all receiving activities (unloading, inspection, put-away) were completed and the receipt was closed in the WMS.',
    `receipt_date` DATE COMMENT 'The receipt date of the inbound receipt record',
    `receipt_number` STRING COMMENT 'Externally-known business identifier for the inbound receipt, used for tracking and reference across systems and with suppliers.. Valid values are `^[A-Z0-9]{8,20}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the inbound receipt transaction, tracking progression from scheduling through completion or exception handling.. Valid values are `scheduled|in_progress|completed|discrepancy|cancelled`',
    `receipt_type` STRING COMMENT 'Classification of the inbound receipt based on the source and nature of the goods being received.. Valid values are `supplier_delivery|plant_transfer|inter_dc_transfer|return_from_customer|production_output`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual total quantity of goods physically received and counted during the receiving process.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods rejected during receiving due to quality issues, damage, or non-conformance to specifications.',
    `scheduled_arrival` TIMESTAMP COMMENT 'The scheduled arrival of the inbound receipt record',
    `scheduled_receipt_date` DATE COMMENT 'Planned date for the inbound shipment to arrive at the distribution center, based on ASN or supplier commitment.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicator of whether the security seal was found intact upon arrival, critical for quality control and loss prevention.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the trailer or container, verified upon receipt to ensure shipment integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,20}$`',
    `source_system_code` STRING COMMENT 'The source system code of the inbound receipt record',
    `temperature_check_required_flag` BOOLEAN COMMENT 'Indicator of whether temperature verification was required for this receipt due to cold chain or temperature-sensitive product requirements.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicator of whether the recorded temperature was within acceptable range per product specifications and cold chain requirements.',
    `temperature_reading_celsius` DECIMAL(18,2) COMMENT 'Actual temperature reading in Celsius recorded during receipt inspection for temperature-sensitive products, critical for cold chain compliance.',
    `total_lines` STRING COMMENT 'The total lines of the inbound receipt record',
    `total_quantity` DECIMAL(18,2) COMMENT 'The total quantity of the inbound receipt record',
    `total_units_received` DECIMAL(18,2) COMMENT 'The total units received of the inbound receipt record',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or truck that delivered the shipment, used for tracking and carrier performance analysis.. Valid values are `^[A-Z0-9]{4,20}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the quantities recorded in this receipt (Each, Case, Pallet, Kilogram, Pound, Liter, Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|EA|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the inbound receipt record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the inbound receipt record',
    CONSTRAINT pk_inbound_receipt PRIMARY KEY(`inbound_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of goods at a DC from suppliers, manufacturing plants, or inter-DC transfers. Records ASN reference, carrier, trailer/container ID, dock door, receipt date/time, received quantity by SKU/lot, temperature check results, and discrepancy flags. Integrates with SAP WM goods receipt and Blue Yonder WMS inbound processing. Drives inventory on-hand updates and FEFO/FIFO lot registration.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` (
    `inbound_receipt_line_id` BIGINT COMMENT 'Unique identifier for the inbound receipt line. Primary key for this entity.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Line-level linkage between warehouse receiving lines and ERP goods receipt enables line-level 3-way match (PO line → GR → invoice line), critical for invoice discrepancy resolution, quality hold manag',
    `inbound_receipt_id` BIGINT COMMENT 'Reference to the parent inbound receipt header transaction. Links this line to the overall receipt event.',
    `label_spec_id` BIGINT COMMENT 'Foreign key linking to product.label_spec. Business justification: Consumer goods inbound receipt requires label compliance verification — confirming received product labels match the approved label spec for the target market (regulatory statements, ingredient declar',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Consumer goods DCs receive raw materials and packaging components (not just finished SKUs) from suppliers. Inbound receipt lines for raw material/component receipts must reference the material master ',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: Consumer goods inbound receipt process requires packaging compliance verification — warehouse teams confirm received packaging matches the approved spec (dimensions, material, GS1 barcodes, recyclabil',
    `po_line_id` BIGINT COMMENT 'The po line id of the inbound receipt line record',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Link receipt line to SKU master for traceability and quality inspection; required by receipt processing and compliance audit reports.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Each inbound receipt line is inspected against a product specification (physical, chemical, or microbiological). Linking receipt lines to specifications enables automated pass/fail evaluation during r',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: When goods are received at a DC, each receipt line is put away to a specific storage location (bin/bay/aisle). The inbound_receipt_line already tracks putaway_status and put_away_timestamp, confirming',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who shipped the goods. Used for supplier performance tracking and procurement analytics.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the inbound receipt line record',
    `asn_line_number` STRING COMMENT 'Line number within the ASN document corresponding to this receipt line. Enables automated matching between ASN and physical receipt.',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice document number sent by the supplier prior to shipment arrival. Used for pre-receipt planning and variance detection.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `inbound_receipt_line_code` STRING COMMENT 'The inbound receipt line code of the inbound receipt line record',
    `condition_code` STRING COMMENT 'Quality condition assessment of the received goods. Determines whether product can be put away into available inventory or requires special handling.. Valid values are `good|damaged|expired|quarantine|rejected|hold`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was first created in the warehouse management system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost and extended cost. Supports multi-currency procurement operations.. Valid values are `^[A-Z]{3}$`',
    `damage_description` STRING COMMENT 'Free-text description of any damage, defects, or quality issues observed during receipt inspection. Used for claims and supplier performance tracking.',
    `damaged_quantity` DECIMAL(18,2) COMMENT 'The damaged quantity of the inbound receipt line record',
    `inbound_receipt_line_description` STRING COMMENT 'The inbound receipt line description of the inbound receipt line record',
    `effective_from` DATE COMMENT 'The effective from of the inbound receipt line record',
    `effective_until` DATE COMMENT 'The effective until of the inbound receipt line record',
    `expected_quantity` DECIMAL(18,2) COMMENT 'The expected quantity of the inbound receipt line record',
    `expected_quantity_cases` DECIMAL(18,2) COMMENT 'Expected quantity in cases as specified in the Advanced Shipping Notice (ASN) or purchase order. Used for variance detection.',
    `expected_quantity_eaches` DECIMAL(18,2) COMMENT 'Expected quantity in eaches as specified in the Advanced Shipping Notice (ASN) or purchase order. Used for variance detection.',
    `expiration_date` DATE COMMENT 'The expiration date of the inbound receipt line record',
    `expiry_date` DATE COMMENT 'Date when the product expires and can no longer be sold or used. Critical for FEFO rotation and inventory management in consumer goods.',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total cost for this receipt line calculated as unit cost multiplied by received quantity. Used for inventory valuation and financial reconciliation.',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying the product in the supply chain. May be GTIN-8, GTIN-12, GTIN-13, or GTIN-14 format.. Valid values are `^[0-9]{8,14}$`',
    `inbound_receipt_line_status` STRING COMMENT 'The inbound receipt line status of the inbound receipt line record',
    `inspection_status` STRING COMMENT 'The inspection status of the inbound receipt line record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was last updated. Audit trail for tracking changes to receipt data.',
    `line_number` STRING COMMENT 'Sequential line number within the inbound receipt. Used for ordering and referencing specific lines in the receipt document.',
    `line_status` STRING COMMENT 'The line status of the inbound receipt line record',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number assigned by the supplier. Critical for traceability, quality control, and recall management in consumer goods.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `manufacture_date` DATE COMMENT 'Date when the product was manufactured by the supplier. Used for shelf-life calculations and FEFO inventory rotation.',
    `inbound_receipt_line_name` STRING COMMENT 'The inbound receipt line name of the inbound receipt line record',
    `notes` STRING COMMENT 'The notes of the inbound receipt line record',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet or handling unit containing this receipt line. Used for put-away and storage location assignment.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `purchase_order_line_number` STRING COMMENT 'Line number on the purchase order corresponding to this receipt line. Enables three-way matching between PO, receipt, and invoice.',
    `purchase_order_number` STRING COMMENT 'Purchase order number authorizing the receipt of these goods. Links the receipt to the original procurement transaction.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `put_away_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were put away into their assigned storage location. Used for warehouse productivity and cycle time measurement.',
    `putaway_status` STRING COMMENT 'The putaway status of the inbound receipt line record',
    `quality_hold_flag` BOOLEAN COMMENT 'The quality hold flag of the inbound receipt line record',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this receipt line requires quality inspection before being released to available inventory. True for regulated or high-risk products.',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection for this receipt line. Determines whether goods can be released to available inventory or must remain in quarantine.. Valid values are `not_required|pending|in_progress|passed|failed|conditional`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the inbound receipt line record',
    `receipt_status` STRING COMMENT 'Current processing status of this receipt line within the warehouse workflow. Tracks progression from initial receipt through put-away completion.. Valid values are `pending|received|inspected|put_away|discrepancy|rejected`',
    `received_quantity` DECIMAL(18,2) COMMENT 'The received quantity of the inbound receipt line record',
    `received_quantity_cases` DECIMAL(18,2) COMMENT 'Quantity of product received measured in cases. Represents the outer packaging unit typically used for warehouse handling.',
    `received_quantity_eaches` DECIMAL(18,2) COMMENT 'Quantity of product received measured in individual units (eaches). Represents the consumer-facing unit count.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were physically received at the warehouse dock. Critical for OTIF performance measurement and cycle time analytics.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'The rejected quantity of the inbound receipt line record',
    `source_system_code` STRING COMMENT 'The source system code of the inbound receipt line record',
    `sscc` STRING COMMENT '18-digit Serial Shipping Container Code identifying the logistics unit. Global standard for tracking pallets and containers in the supply chain.. Valid values are `^[0-9]{18}$`',
    `temperature_at_receipt_celsius` DECIMAL(18,2) COMMENT 'Temperature measurement in Celsius recorded at the time of receipt. Critical for cold chain compliance and product quality verification.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for the received goods as specified in the purchase order. Used for inventory valuation and COGS calculation.',
    `unit_of_measure` STRING COMMENT 'Primary unit of measure for the received quantity. Defines the counting and handling unit for warehouse operations.. Valid values are `case|each|pallet|layer|inner_pack|display_unit`',
    `uom` STRING COMMENT 'The uom of the inbound receipt line record',
    `upc` STRING COMMENT 'Universal Product Code barcode identifier for the received item. Standard 12-digit UPC-A format used in North American retail.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the inbound receipt line record',
    `variance_quantity_cases` DECIMAL(18,2) COMMENT 'Difference between expected and received quantity in cases. Positive values indicate overages, negative values indicate shortages.',
    `variance_quantity_eaches` DECIMAL(18,2) COMMENT 'Difference between expected and received quantity in eaches. Positive values indicate overages, negative values indicate shortages.',
    CONSTRAINT pk_inbound_receipt_line PRIMARY KEY(`inbound_receipt_line_id`)
) COMMENT 'Line-level detail for each SKU/lot received within an inbound receipt transaction. Captures SKU code, GTIN, lot number, manufacture date, expiry date, received quantity (cases and eaches), unit of measure, pallet ID, temperature at receipt, and variance from expected ASN quantity. Supports FEFO/FIFO lot registration and discrepancy resolution workflows.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` (
    `outbound_order_id` BIGINT COMMENT 'Unique identifier for the outbound fulfillment order. Primary key for the outbound order entity.',
    `account_address_id` BIGINT COMMENT 'Foreign key linking to sales.account_address. Business justification: Consumer goods order fulfillment: outbound orders ship to a structured account delivery address for address validation, delivery scheduling, and EDI compliance. outbound_order.ship_to_address and ship',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to deliver the outbound order. Used for freight planning, carrier performance tracking, and proof of delivery.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Outbound orders in multi-entity consumer goods companies are issued by a specific legal entity, driving revenue recognition, intercompany sales billing, and statutory reporting. Required for correct A',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: Freight order creation for every outbound order manages carrier tendering, freight cost tracking, and audit.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center fulfilling the outbound order. Determines inventory source and warehouse operations responsible for order execution.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed for revenue recognition and profit‑center reporting; each outbound orders sales revenue is attributed to a profit center.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Consumer goods DSD and store replenishment: outbound orders are fulfilled to specific retail stores for OTIF tracking, planogram compliance, and OSA reporting at store level. trade_account_id alone is',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order document in the ERP system. Links outbound fulfillment to revenue recognition and customer order management.',
    `sku_id` BIGINT COMMENT 'FK to product.sku.sku_id — Links distribution outbound orders to product master. Required for product-level fulfillment analytics, category-level DC throughput reporting.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the customer or retail account placing the outbound order. Links to trade account master for customer details, pricing agreements, and delivery preferences.',
    `actual_delivery_date` DATE COMMENT 'Date when the order was actually delivered to the customer destination. Used to calculate OTIF performance and delivery lead time.',
    `actual_ship_date` DATE COMMENT 'Date when the order was actually shipped from the distribution center. Used to measure warehouse execution performance against requested ship date.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the outbound order record',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether any line items on the order are backordered due to insufficient inventory. True when ordered quantity exceeds available stock.',
    `bill_of_lading_number` STRING COMMENT 'Carrier-issued document number serving as receipt of goods and contract of carriage. Required for freight claims and proof of delivery.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the order was cancelled. Examples include customer request, inventory shortage, credit hold, or duplicate order. Used for root cause analysis.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the order was cancelled. Null for active orders. Used for cancellation rate analysis and order lifecycle reporting.',
    `outbound_order_code` STRING COMMENT 'The outbound order code of the outbound order record',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order record was first created in the system. Audit field for data lineage and order lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order value. Typically USD for domestic US operations, but may vary for export orders.. Valid values are `^[A-Z]{3}$`',
    `outbound_order_description` STRING COMMENT 'The outbound order description of the outbound order record',
    `effective_from` DATE COMMENT 'The effective from of the outbound order record',
    `effective_until` DATE COMMENT 'The effective until of the outbound order record',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of ordered quantity that was fulfilled from available inventory. Calculated as (shipped quantity / ordered quantity) * 100. Key metric for inventory availability and customer service.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the order contains hazardous materials requiring special handling, labeling, and transportation compliance. True for products regulated under DOT hazmat rules.',
    `incoterm` STRING COMMENT 'International Commercial Terms defining the division of costs and risks between buyer and seller. Critical for export orders and freight responsibility determination. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order record was last updated. Audit field for change tracking and data quality monitoring.',
    `outbound_order_name` STRING COMMENT 'The outbound order name of the outbound order record',
    `notes` STRING COMMENT 'The notes of the outbound order record',
    `order_date` DATE COMMENT 'Date when the outbound order was created or received from the customer. Principal business event timestamp for order lifecycle tracking.',
    `order_status` STRING COMMENT 'Current lifecycle status of the outbound order. Draft indicates order creation, released means ready for fulfillment, picking/packing/staged represent warehouse execution phases, shipped indicates in-transit, delivered confirms receipt, cancelled indicates order termination. [ENUM-REF-CANDIDATE: draft|released|picking|packing|staged|shipped|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the outbound order based on fulfillment channel and destination. Retail replenishment serves store orders, DSD (Direct Store Delivery) bypasses DC, ecommerce serves online consumers, inter-DC transfer moves inventory between distribution centers, wholesale serves B2B customers, export serves international markets.. Valid values are `retail_replenishment|dsd|ecommerce|inter_dc_transfer|wholesale|export`',
    `otif_commitment_flag` BOOLEAN COMMENT 'Indicates whether this order is subject to formal OTIF performance measurement and customer scorecard reporting. True for orders with contractual delivery commitments.',
    `outbound_order_status` STRING COMMENT 'The outbound order status of the outbound order record',
    `packing_slip_number` STRING COMMENT 'Document number for the packing slip accompanying the shipment. Used for customer receiving and invoice reconciliation.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the customer for this order. Examples include Net 30, Net 60, COD (Cash on Delivery), or prepaid. Impacts accounts receivable and cash flow management.',
    `pick_ticket_number` STRING COMMENT 'Warehouse document number used to direct picking operations for this order. Generated by WMS when order is released to the warehouse floor.',
    `priority` STRING COMMENT 'The priority of the outbound order record',
    `priority_code` STRING COMMENT 'Priority level assigned to the outbound order for warehouse sequencing and resource allocation. Critical orders receive highest priority, rush orders are expedited, expedited orders have faster processing, standard orders follow normal flow.. Valid values are `standard|expedited|rush|critical`',
    `promised_delivery_date` DATE COMMENT 'The promised delivery date of the outbound order record',
    `proof_of_delivery_timestamp` TIMESTAMP COMMENT 'Date and time when delivery was confirmed by the recipient. Captured from carrier POD or customer signature. Used for OTIF measurement and freight audit.',
    `purchase_order_number` STRING COMMENT 'Customers purchase order number provided for order tracking and invoice reconciliation. Required for EDI (Electronic Data Interchange) transactions with retail customers.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the outbound order record',
    `requested_ship_date` DATE COMMENT 'Date when the customer or system requests the order to be shipped from the distribution center. Used for warehouse planning and scheduling.',
    `required_delivery_date` DATE COMMENT 'Date by which the order must be delivered to the customer destination. Critical for OTIF (On Time In Full) performance measurement and SLA compliance.',
    `service_level` STRING COMMENT 'Delivery speed commitment for the outbound order. Determines carrier selection, freight cost, and OTIF measurement criteria.. Valid values are `standard|next_day|two_day|same_day|scheduled`',
    `shipping_method` STRING COMMENT 'Transportation mode used for order delivery. Ground for truck, air for expedited freight, ocean for international, rail for bulk, parcel for small packages, LTL (Less Than Truckload) for partial loads, FTL (Full Truckload) for full loads. [ENUM-REF-CANDIDATE: ground|air|ocean|rail|parcel|ltl|ftl — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'The source system code of the outbound order record',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for warehouse and logistics teams regarding special handling requirements. May include temperature control, fragile handling, hazmat procedures, or customer-specific delivery instructions.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the order requires temperature-controlled storage and transportation. True for cold chain products requiring refrigeration or freezing.',
    `total_lines` STRING COMMENT 'The total lines of the outbound order record',
    `total_order_quantity` DECIMAL(18,2) COMMENT 'Total quantity of units across all line items in the outbound order. Used for warehouse capacity planning and OTIF fill rate calculation.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the outbound order before taxes and freight charges. Used for order prioritization, credit limit checks, and revenue forecasting.',
    `total_order_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the outbound order in cubic meters. Used for warehouse space planning, truck cube utilization, and pallet configuration.',
    `total_order_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the outbound order in kilograms. Used for freight cost calculation, carrier capacity planning, and vehicle loading optimization.',
    `total_quantity` DECIMAL(18,2) COMMENT 'The total quantity of the outbound order record',
    `total_units` DECIMAL(18,2) COMMENT 'The total units of the outbound order record',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility and customer self-service tracking. Used for parcel and LTL shipments.',
    `uom` STRING COMMENT 'The uom of the outbound order record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the outbound order record',
    CONSTRAINT pk_outbound_order PRIMARY KEY(`outbound_order_id`)
) COMMENT 'Master outbound fulfillment order record representing a customer or retailer replenishment request to be fulfilled from a DC. Captures order number, order type (retail replenishment, DSD, e-commerce, inter-DC transfer), customer/account reference, requested ship date, required delivery date, priority, OTIF commitment, and order status lifecycle. Sourced from SAP SD and Salesforce Consumer Goods Cloud order management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` (
    `outbound_order_line_id` BIGINT COMMENT 'Unique identifier for the outbound order line item.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue GL account assignment at order line level drives revenue recognition reporting by product category in consumer goods. Mixed-category orders require line-level GL assignment for accurate P&L po',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound fulfillment order header.',
    `sku_id` BIGINT COMMENT 'The sku id of the outbound order line record',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Outbound order line items are stored in a DC location before picking. Adding a FK to distribution_storage_location enables location lookup and normalizes location data.',
    `actual_ship_date` DATE COMMENT 'Actual date the line was shipped from the distribution center.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity allocated from warehouse inventory to this order line.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the outbound order line record',
    `base_unit_quantity` DECIMAL(18,2) COMMENT 'Quantity converted to base unit of measure for standardized reporting and inventory tracking.',
    `outbound_order_line_code` STRING COMMENT 'The outbound order line code of the outbound order line record',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed available for fulfillment after ATP (Available to Promise) check.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order line record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the outbound order line record',
    `customer_po_line_number` STRING COMMENT 'Customers purchase order line number for cross-reference and reconciliation.',
    `outbound_order_line_description` STRING COMMENT 'The outbound order line description of the outbound order line record',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this line is part of a direct store delivery order bypassing retailer distribution centers.',
    `edi_line_reference` STRING COMMENT 'EDI transaction line reference number for electronic order processing and ASN generation.',
    `effective_from` DATE COMMENT 'The effective from of the outbound order line record',
    `effective_until` DATE COMMENT 'The effective until of the outbound order line record',
    `expiry_date` DATE COMMENT 'Product expiration date for FEFO inventory rotation and shelf-life management.',
    `gtin` STRING COMMENT 'Global trade item number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) for the product being shipped.. Valid values are `^[0-9]{8,14}$`',
    `handling_unit_code` STRING COMMENT 'Serial shipping container code (SSCC) or handling unit identifier for the container holding this line item.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this line contains hazardous materials requiring special handling and documentation.',
    `line_number` STRING COMMENT 'Sequential line number within the outbound order for ordering and identification.',
    `line_status` STRING COMMENT 'Current fulfillment status of the order line in the warehouse execution lifecycle. [ENUM-REF-CANDIDATE: open|allocated|picked|packed|shipped|cancelled|short_shipped — 7 candidates stripped; promote to reference product]',
    `line_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the shipped quantity for this line in cubic meters.',
    `line_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipped quantity for this line in kilograms.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number for traceability and quality control.',
    `outbound_order_line_name` STRING COMMENT 'The outbound order line name of the outbound order line record',
    `notes` STRING COMMENT 'The notes of the outbound order line record',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU originally requested by the customer in the order.',
    `otif_status` STRING COMMENT 'Line-level OTIF performance status indicating whether the line was delivered on time and in full quantity.. Valid values are `on_time_in_full|late_in_full|on_time_partial|late_partial`',
    `outbound_order_line_status` STRING COMMENT 'The outbound order line status of the outbound order line record',
    `pack_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was packed into shipping containers.',
    `packed_quantity` DECIMAL(18,2) COMMENT 'Quantity packed into shipping containers and ready for dispatch.',
    `pallet_code` STRING COMMENT 'Pallet identifier if the line item was shipped on a palletized load.',
    `pick_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was picked from warehouse inventory.',
    `pick_zone` STRING COMMENT 'Warehouse pick zone designation for labor management and routing optimization.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'Quantity physically picked from warehouse storage locations during fulfillment.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the outbound order line record',
    `requested_ship_date` DATE COMMENT 'Customer-requested or system-calculated target ship date for this line.',
    `serial_numbers` STRING COMMENT 'Comma-separated list of serial numbers for serialized inventory items shipped on this line.',
    `ship_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was shipped from the distribution center.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Quantity actually shipped to the customer, may differ from ordered due to short-ship scenarios.',
    `short_ship_flag` BOOLEAN COMMENT 'Indicates whether this line was short-shipped (shipped quantity less than ordered quantity).',
    `short_ship_reason_code` STRING COMMENT 'Reason code for short shipment (OOS=Out of Stock, DAMAGE=Damaged Inventory, RECALL=Product Recall, EXPIRED=Expired Product, ALLOCATION=Allocation Constraint).. Valid values are `OOS|DAMAGE|RECALL|EXPIRED|ALLOCATION`',
    `source_system_code` STRING COMMENT 'The source system code of the outbound order line record',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this line requires temperature-controlled storage and transportation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities (EA=Each, CS=Case, PL=Pallet, BX=Box, KG=Kilogram, LB=Pound, LT=Liter, GL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|BX|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    `unit_volume_m3` DECIMAL(18,2) COMMENT 'Volume per unit of the SKU in cubic meters for space utilization and load planning.',
    `unit_weight_kg` DECIMAL(18,2) COMMENT 'Weight per unit of the SKU in kilograms for freight calculation and capacity planning.',
    `uom` STRING COMMENT 'The uom of the outbound order line record',
    `upc` STRING COMMENT 'Universal product code (UPC-A) for retail scanning and point-of-sale identification.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the outbound order line record',
    `warehouse_location_code` STRING COMMENT 'Distribution center or warehouse location code from which this line was fulfilled.',
    CONSTRAINT pk_outbound_order_line PRIMARY KEY(`outbound_order_line_id`)
) COMMENT 'Line-level detail for each SKU within an outbound fulfillment order. Records SKU code, GTIN, ordered quantity, confirmed quantity, allocated quantity, picked quantity, shipped quantity, unit of measure, lot number, expiry date, and line-level OTIF status. Enables order fill rate tracking, short-ship identification, and OSA impact analysis at the SKU-customer level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` (
    `pick_task_id` BIGINT COMMENT 'Unique identifier for the pick task record. Primary key for the pick_task data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pick task labor costs are charged to a cost center; required for labor cost analysis and OTIF performance metrics.',
    `storage_location_id` BIGINT COMMENT 'Reference to the target location where picked items are staged or packed (e.g., pack station, staging lane, loading dock).',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse where the pick task is executed.',
    `distribution_shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: A pick task is executed to fulfill a specific outbound shipment in WMS operations. While pick_task already links to outbound_order and outbound_order_line, the direct link to distribution_shipment ena',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound order or shipment order that generated this pick task.',
    `outbound_order_line_id` BIGINT COMMENT 'The outbound order line id of the pick task record',
    `primary_pick_distribution_storage_location_id` BIGINT COMMENT 'Reference to the warehouse storage location (bin, shelf, pallet position) from which inventory is picked.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU being picked or packed in this task.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the pick task record',
    `carton_code` STRING COMMENT 'Unique identifier for the carton or shipping container into which items are packed. May be a license plate number (LPN) or SSCC (Serial Shipping Container Code).. Valid values are `^CTN[0-9A-Z]{8,15}$`',
    `pick_task_code` STRING COMMENT 'The pick task code of the pick task record',
    `completed_timestamp` TIMESTAMP COMMENT 'The completed timestamp of the pick task record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task record was first created in the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'The currency code of the pick task record',
    `pick_task_description` STRING COMMENT 'The pick task description of the pick task record',
    `dsd_flag` BOOLEAN COMMENT 'Boolean indicator of whether this pick task is part of a Direct Store Delivery (DSD) execution workflow (true = DSD, false = standard distribution).',
    `effective_from` DATE COMMENT 'The effective from of the pick task record',
    `effective_until` DATE COMMENT 'The effective until of the pick task record',
    `exception_code` STRING COMMENT 'Code identifying any exception or issue encountered during task execution (e.g., short pick, damaged goods, location discrepancy). Null if no exception.. Valid values are `^[A-Z0-9]{2,6}$`',
    `exception_notes` STRING COMMENT 'Free-text notes entered by the operator or supervisor describing the exception or issue encountered during task execution.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the packed carton or pallet including product and packaging materials, measured in kilograms.',
    `gs1_128_label` STRING COMMENT 'The GS1-128 barcode label data applied to the carton or pallet, encoding SSCC, GTIN, lot, expiry, and other supply chain attributes.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the packed carton or pallet, measured in centimeters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task record was last updated in the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the packed carton or pallet, measured in centimeters.',
    `pick_task_name` STRING COMMENT 'The pick task name of the pick task record',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product content only (excluding packaging), measured in kilograms.',
    `notes` STRING COMMENT 'The notes of the pick task record',
    `otif_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this pick task is subject to OTIF (On Time In Full) performance measurement (true = OTIF tracked, false = not tracked).',
    `pack_station_code` BIGINT COMMENT 'Reference to the packing station where the packing operation is performed. Applicable when task_type includes packing.',
    `packaging_material_code` STRING COMMENT 'Code identifying the type of packaging material used (e.g., corrugated box, poly bag, shrink wrap). Used for cartonization and sustainability tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet onto which cartons or items are loaded. Typically an SSCC or internal LPN.. Valid values are `^PLT[0-9A-Z]{8,15}$`',
    `pick_accuracy_flag` BOOLEAN COMMENT 'Boolean indicator of whether the pick was accurate (true = picked quantity matches requested quantity and correct SKU/lot; false = discrepancy detected).',
    `pick_list_number` STRING COMMENT 'Human-readable pick list reference number assigned by the WMS for operator identification and tracking.. Valid values are `^PL[0-9]{8,12}$`',
    `pick_method` STRING COMMENT 'The pick method of the pick task record',
    `pick_quantity` DECIMAL(18,2) COMMENT 'The quantity of SKU units to be picked for this task, measured in the SKUs base unit of measure.',
    `pick_task_status` STRING COMMENT 'The pick task status of the pick task record',
    `picked_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of SKU units picked by the operator. May differ from pick_quantity due to short picks or overages.',
    `picking_strategy` STRING COMMENT 'The picking methodology applied: discrete (single order), batch (multiple orders), zone (by warehouse zone), wave (grouped by wave), cluster (multi-order cart picking).. Valid values are `discrete|batch|zone|wave|cluster`',
    `priority` STRING COMMENT 'The priority of the pick task record',
    `priority_level` STRING COMMENT 'Priority classification of the pick task for sequencing and resource allocation: urgent (immediate), high (expedited), normal (standard), low (backlog).. Valid values are `urgent|high|normal|low`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the pick task record',
    `source_system_code` STRING COMMENT 'The source system code of the pick task record',
    `sscc` STRING COMMENT '18-digit GS1 Serial Shipping Container Code uniquely identifying the logistics unit (carton or pallet) for tracking through the supply chain.. Valid values are `^[0-9]{18}$`',
    `started_timestamp` TIMESTAMP COMMENT 'The started timestamp of the pick task record',
    `task_assigned_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task was assigned to an operator by the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task was completed and confirmed by the operator or WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from task start to completion. Used for labor productivity analysis and standard time calculation.',
    `task_number` STRING COMMENT 'The task number of the pick task record',
    `task_started_timestamp` TIMESTAMP COMMENT 'Timestamp when the operator began executing the pick task (scanned start or confirmed task initiation). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_status` STRING COMMENT 'Current lifecycle status of the pick task: pending (awaiting assignment), assigned (allocated to operator), in_progress (actively being executed), completed (finished successfully), cancelled (voided), on_hold (temporarily suspended).. Valid values are `pending|assigned|in_progress|completed|cancelled|on_hold`',
    `task_type` STRING COMMENT 'Discriminator indicating the type of fulfillment task: pick (picking only), pack (packing only), pick_and_pack (combined operation), or replenishment_pick (internal stock movement).. Valid values are `pick|pack|pick_and_pack|replenishment_pick`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for pick and picked quantities (e.g., EA for each, CS for case, PL for pallet).. Valid values are `^[A-Z]{2,3}$`',
    `uom` STRING COMMENT 'The uom of the pick task record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the pick task record',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the packed carton or pallet, measured in centimeters.',
    CONSTRAINT pk_pick_task PRIMARY KEY(`pick_task_id`)
) COMMENT 'Fulfillment task record covering both picking and packing operations within DC outbound execution. For picking: captures pick list reference, source location, SKU, lot, pick quantity, assigned operator, wave/batch reference, pick accuracy flag, and task timestamps. For packing: captures pack station, carton/pallet ID, packed SKUs and quantities, packaging material, gross weight, dimensions, GS1-128/SSCC label, and packer operator. Supports wave picking, batch picking, zone picking, and cartonization strategies in Blue Yonder WMS. Task_type discriminator distinguishes pick vs pack execution steps.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` (
    `distribution_shipment_id` BIGINT COMMENT 'Unique identifier for the distribution shipment record. Primary key for the distribution shipment entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign-level logistics cost attribution and OTIF reporting: CPG brand teams track shipment costs and on-time delivery rates per campaign (promotional launches, display programs). Direct campaign_id ',
    `carrier_id` BIGINT COMMENT 'The carrier id of the distribution shipment record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for shipment cost allocation report; logistics expenses are charged to a cost center, a standard practice in consumer‑goods distribution.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Freight cost GL account on shipments enables direct posting of outbound freight expenses to the correct P&L line in consumer goods. Required for freight cost accrual, carrier invoice matching, and log',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: Costing and transit planning use lane definitions; linking shipment to lane provides distance, rate, and compliance data.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Shipment origin tracking: linking shipments to the originating manufacturing facility enables performance dashboards and OTIF analysis.',
    `network_lane_id` BIGINT COMMENT 'Foreign key linking to supply.network_lane. Business justification: Distribution shipments execute over supply network lanes. Supply planners reconcile actual shipment transit times and costs against planned lane parameters (lead time, OTIF target, cost-per-unit) for ',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order. Business justification: Shipment is a child of an outbound order; each shipment fulfills an order. Adding outbound_order_id to distribution_shipment creates the necessary parent link without creating a bidirectional relation',
    `actual_delivery_date` DATE COMMENT 'The actual delivery date of the distribution shipment record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the distribution shipment record',
    `distribution_shipment_code` STRING COMMENT 'The distribution shipment code of the distribution shipment record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the distribution shipment record',
    `currency_code` STRING COMMENT 'The currency code of the distribution shipment record',
    `delivery_date` DATE COMMENT 'The delivery date of the distribution shipment record',
    `distribution_shipment_description` STRING COMMENT 'The distribution shipment description of the distribution shipment record',
    `distribution_shipment_status` STRING COMMENT 'The distribution shipment status of the distribution shipment record',
    `effective_from` DATE COMMENT 'The effective from of the distribution shipment record',
    `effective_until` DATE COMMENT 'The effective until of the distribution shipment record',
    `expected_delivery_date` DATE COMMENT 'The expected delivery date of the distribution shipment record',
    `freight_cost` DECIMAL(18,2) COMMENT 'The freight cost of the distribution shipment record',
    `distribution_shipment_name` STRING COMMENT 'The distribution shipment name of the distribution shipment record',
    `notes` STRING COMMENT 'The notes of the distribution shipment record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the distribution shipment record',
    `ship_date` DATE COMMENT 'The ship date of the distribution shipment record',
    `shipment_number` STRING COMMENT 'The shipment number of the distribution shipment record',
    `shipment_status` STRING COMMENT 'The shipment status of the distribution shipment record',
    `source_system_code` STRING COMMENT 'The source system code of the distribution shipment record',
    `total_cartons` STRING COMMENT 'The total cartons of the distribution shipment record',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total weight kg of the distribution shipment record',
    `tracking_number` STRING COMMENT 'The tracking number of the distribution shipment record',
    `uom` STRING COMMENT 'The uom of the distribution shipment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the distribution shipment record',
    CONSTRAINT pk_distribution_shipment PRIMARY KEY(`distribution_shipment_id`)
) COMMENT 'Outbound shipment record representing the physical dispatch of goods from a DC to a customer, retailer, or downstream DC. Captures shipment number, carrier, trailer/container ID, seal number, dock door, scheduled and actual departure datetime, destination, total weight, total cube, pallet count, carton count, and OTIF status. Integrates with Blue Yonder WMS load planning and SAP SD goods issue. SSOT for DC-level outbound shipment execution distinct from the logistics domains carrier-level shipment tracking. [SSOT: authoritative table is logistics.logistics_shipment; this table is a deprecated duplicate.] [SSOT: authoritative table is logistics.logistics_shipment; this is a deprecated duplicate for concept shipment.] [Non-authoritative; defers to SSOT logistics.logistics_shipment for concept shipment.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` (
    `inventory_position_id` BIGINT COMMENT 'Primary key for inventory_position',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: Inventory positions reflect QA-released stock — the stock_status and inventory_condition fields are directly determined by the batch release decision. This FK enables inventory availability reporting ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory carrying costs (storage, handling, obsolescence) are allocated to cost centers in consumer goods period-end close. Finance requires cost center on inventory positions for inventory carrying ',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center where the inventory is physically located.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Inventory GL account assignment on position records supports balance sheet stock valuation, inventory write-down postings, and cycle count adjustment entries. In consumer goods ERP (SAP), valuation cl',
    `inventory_policy_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_policy. Business justification: Inventory policies define safety stock targets, reorder points, and service level commitments that govern each DCs inventory position. DC planners compare actual inventory_position against policy tar',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Consumer goods VMI and store-level replenishment: inventory positions are earmarked for specific retail stores (retail_store.vmi_enabled_flag confirms VMI is modeled). Store-level inventory allocation',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU for which inventory position is tracked.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Inventory position records on‑hand quantities at a specific DC location. Linking to distribution_storage_location provides the authoritative location details and removes the generic storage_location_i',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: Inventory positions (on_hold_quantity, quantity_quarantine, quantity_available) are directly governed by usage decisions. This FK links current inventory status to the specific QA usage decision that ',
    `actual_weight` DECIMAL(18,2) COMMENT 'The actual measured weight of the inventory for catch weight items. Used for billing and compliance when item weight varies.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The allocated quantity of the inventory position record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the inventory position record',
    `available_quantity` DECIMAL(18,2) COMMENT 'The available quantity of the inventory position record',
    `catch_weight_flag` BOOLEAN COMMENT 'Indicates whether the SKU is a catch weight item requiring actual weight capture at transaction time (true) or standard weight (false).',
    `inventory_position_code` STRING COMMENT 'The inventory position code of the inventory position record',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The unit cost of the inventory lot. Used for inventory valuation and cost of goods sold calculations. Business confidential financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for inventory valuation (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `days_on_hand` STRING COMMENT 'The number of days the inventory has been on hand since receipt. Calculated as current date minus receipt date. Used for aging analysis.',
    `days_to_expiry` STRING COMMENT 'The number of days remaining until the inventory lot expires. Calculated as expiry date minus current date. Critical for FEFO rotation and markdown decisions.',
    `inventory_position_description` STRING COMMENT 'The inventory position description of the inventory position record',
    `effective_from` DATE COMMENT 'The effective from of the inventory position record',
    `effective_until` DATE COMMENT 'The effective until of the inventory position record',
    `expiration_date` DATE COMMENT 'The expiration date of the inventory position record',
    `expiry_date` DATE COMMENT 'The date on which the product lot expires and can no longer be sold or distributed. Critical for FEFO inventory management and regulatory compliance.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'The in transit quantity of the inventory position record',
    `inventory_condition` STRING COMMENT 'The physical condition classification of the inventory. Used for disposition decisions and channel restrictions.. Valid values are `new|refurbished|returned|damaged|expired|recalled`',
    `inventory_position_status` STRING COMMENT 'The inventory position status of the inventory position record',
    `inventory_status` STRING COMMENT 'The current operational status of the inventory position. Determines availability for picking and order fulfillment.. Valid values are `available|allocated|quarantine|hold|damaged|expired`',
    `last_cycle_count_date` DATE COMMENT 'The date when this inventory position was last physically counted during a cycle count operation. Used to schedule next count and assess inventory accuracy.',
    `last_movement_date` DATE COMMENT 'The date when inventory was last moved into or out of this storage location. Used for slow-moving inventory identification.',
    `last_movement_type` STRING COMMENT 'The type of the last inventory movement transaction that affected this position (receipt, putaway, pick, replenishment, transfer, adjustment, return). [ENUM-REF-CANDIDATE: receipt|putaway|pick|replenishment|transfer|adjustment|return — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position record was last modified. Used for change tracking and data freshness assessment.',
    `license_plate_number` STRING COMMENT 'The warehouse management system license plate number assigned to the handling unit. Used for tracking and automated material handling.',
    `lot_number` STRING COMMENT 'The alphanumeric lot or batch number assigned during manufacturing. Used for traceability and recall management.',
    `manufacture_date` DATE COMMENT 'The date on which the product lot was manufactured. Used for shelf-life calculations and FEFO rotation.',
    `inventory_position_name` STRING COMMENT 'The inventory position name of the inventory position record',
    `notes` STRING COMMENT 'The notes of the inventory position record',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'The on hand quantity of the inventory position record',
    `on_hold_quantity` DECIMAL(18,2) COMMENT 'The on hold quantity of the inventory position record',
    `owner_type` STRING COMMENT 'Indicates the ownership model of the inventory (owned by company, consignment from supplier, customer-owned for returns, vendor-managed inventory).. Valid values are `owned|consignment|customer_owned|vendor_managed`',
    `pallet_code` STRING COMMENT 'The unique identifier of the pallet or handling unit on which the inventory is stored. Used for warehouse automation and tracking.',
    `pick_face_flag` BOOLEAN COMMENT 'Indicates whether this inventory position is in a primary pick face location (true) or reserve storage (false). Pick face locations are optimized for order picking efficiency.',
    `putaway_date` DATE COMMENT 'The date when the inventory was put away into this storage location after receiving. Used for aging analysis and FEFO compliance.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the inventory position record',
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
    `source_system_code` STRING COMMENT 'The source system code of the inventory position record',
    `stock_status` STRING COMMENT 'The stock status of the inventory position record',
    `storage_zone` STRING COMMENT 'The logical zone within the distribution center where the inventory is stored (e.g., ambient, refrigerated, frozen, hazmat, high-velocity, reserve).',
    `temperature_zone` STRING COMMENT 'The temperature control zone classification for the storage location. Critical for cold chain compliance and product quality.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'The total financial value of the inventory position calculated as quantity_on_hand multiplied by cost_per_unit. Used for balance sheet reporting. Business confidential financial data.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure in which inventory quantities are tracked (Each, Case, Pallet, Pound, Kilogram, Liter, Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the inventory position record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the inventory position record',
    `weight_unit_of_measure` STRING COMMENT 'The unit of measure for actual weight (Pound, Kilogram, Ounce, Gram). Applicable for catch weight items.. Valid values are `LB|KG|OZ|G`',
    CONSTRAINT pk_inventory_position PRIMARY KEY(`inventory_position_id`)
) COMMENT 'Current on-hand inventory position at the DC-location-SKU-lot level within distribution center walls. Captures storage location, SKU, lot number, manufacture and expiry dates, quantity on hand, allocated quantity, available-to-pick (ATP) quantity, quarantine quantity, inventory status (available, hold, damaged, expired), and last cycle count date. This is the operational working inventory view for DC execution — distinct from the inventory domains network-wide planning position which aggregates across all nodes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ADD CONSTRAINT `fk_distribution_storage_location_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`(`outbound_order_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_primary_pick_distribution_storage_location_id` FOREIGN KEY (`primary_pick_distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross Dock Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Dc Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_name` SET TAGS ('dbx_business_glossary_term' = 'Dc Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_description` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dock_doors_inbound` SET TAGS ('dbx_business_glossary_term' = 'Dock Doors Inbound');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dock_doors_outbound` SET TAGS ('dbx_business_glossary_term' = 'Dock Doors Outbound');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dsd_hub_flag` SET TAGS ('dbx_business_glossary_term' = 'Dsd Hub Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Gmp Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `inventory_rotation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `number_of_dock_doors` SET TAGS ('dbx_business_glossary_term' = 'Number Of Dock Doors');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Otif Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Sap Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Pallet Positions');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallet_positions` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallet_positions` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallets` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Pallets');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallets` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallets` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `supply_network_node_code` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity Sqft');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `wms_site_code` SET TAGS ('dbx_business_glossary_term' = 'Wms Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'Abc Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bin_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_business_glossary_term' = 'Bin Position');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Blocked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_description` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dsd Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Required');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `fefo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fefo Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `fifo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fifo Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height Cm');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Is Blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `is_pickable` SET TAGS ('dbx_business_glossary_term' = 'Is Pickable');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `level_code` SET TAGS ('dbx_business_glossary_term' = 'Level Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `max_volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Max Volume Cubic M');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Max Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `storage_class` SET TAGS ('dbx_business_glossary_term' = 'Storage Class');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `return_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `actual_arrival` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `actual_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_reference` SET TAGS ('dbx_business_glossary_term' = 'Asn Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `case_count` SET TAGS ('dbx_business_glossary_term' = 'Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_code` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_description` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_value_regex' = 'overage|shortage|damage|wrong_product|quality_issue|documentation_error');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door` SET TAGS ('dbx_business_glossary_term' = 'Dock Door');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `expected_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `goods_receipt_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `goods_receipt_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_name` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `putaway_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Put-Away Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|discrepancy|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'supplier_delivery|plant_transfer|inter_dc_transfer|return_from_customer|production_output');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `scheduled_arrival` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `scheduled_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Check Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_reading_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `total_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Lines');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `total_units_received` SET TAGS ('dbx_business_glossary_term' = 'Total Units Received');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_line_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_code` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'good|damaged|expired|quarantine|rejected|hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `damaged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_description` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expected_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expected_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_status` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_name` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `purchase_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `put_away_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Put Away Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `putaway_status` SET TAGS ('dbx_business_glossary_term' = 'Putaway Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'pending|received|inspected|put_away|discrepancy|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `temperature_at_receipt_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receipt Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'case|each|pallet|layer|inner_pack|display_unit');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `variance_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `variance_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_business_glossary_term' = 'Account Address Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_code` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_description` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_name` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'retail_replenishment|dsd|ecommerce|inter_dc_transfer|wholesale|export');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `otif_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Commitment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_status` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `packing_slip_number` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `pick_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Pick Ticket Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'standard|expedited|rush|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|next_day|two_day|same_day|scheduled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Lines');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Order Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Order Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `base_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_line_code` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `customer_po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_line_description` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `edi_line_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Line Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_line_name` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late_in_full|on_time_partial|late_partial');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_line_status` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `packed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pick_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pick_zone` SET TAGS ('dbx_business_glossary_term' = 'Pick Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `serial_numbers` SET TAGS ('dbx_business_glossary_term' = 'Serial Numbers');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_flag` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_reason_code` SET TAGS ('dbx_value_regex' = 'OOS|DAMAGE|RECALL|EXPIRED|ALLOCATION');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Unit Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `primary_pick_distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_value_regex' = '^CTN[0-9A-Z]{8,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_task_code` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_task_description` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `gs1_128_label` SET TAGS ('dbx_business_glossary_term' = 'GS1-128 Label Data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_task_name` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `otif_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pack_station_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Station Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^PLT[0-9A-Z]{8,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_accuracy_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Accuracy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_list_number` SET TAGS ('dbx_business_glossary_term' = 'Pick List Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_list_number` SET TAGS ('dbx_value_regex' = '^PL[0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_method` SET TAGS ('dbx_business_glossary_term' = 'Pick Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pick Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_task_status` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'discrete|batch|zone|wave|cluster');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Started Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration in Seconds');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Started Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|assigned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'pick|pack|pick_and_pack|replenishment_pick');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `distribution_shipment_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `distribution_shipment_description` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `distribution_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `distribution_shipment_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `total_cartons` SET TAGS ('dbx_business_glossary_term' = 'Total Cartons');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Dc Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `actual_weight` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `catch_weight_flag` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `days_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Days On Hand (DOH)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `days_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_description` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In Transit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_business_glossary_term' = 'Inventory Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_value_regex' = 'new|refurbished|returned|damaged|expired|recalled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|allocated|quarantine|hold|damaged|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `license_plate_number` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number (LPN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `license_plate_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `license_plate_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_name` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `on_hold_quantity` SET TAGS ('dbx_business_glossary_term' = 'On Hold Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'owned|consignment|customer_owned|vendor_managed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `putaway_date` SET TAGS ('dbx_business_glossary_term' = 'Putaway Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
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
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `storage_zone` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = 'LB|KG|OZ|G');
