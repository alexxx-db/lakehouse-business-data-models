-- Schema for Domain: material | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`material` COMMENT 'Materials management domain tracking inventory, stock levels, material receipts, consumption, transfers between sites, and material traceability (batch/lot tracking for concrete, steel, MEP components). Manages BOQ (Bill of Quantities) reconciliation, material specifications, FAT/SAT records, material conformance certificates, and warehouse operations for construction materials and consumables.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`master` (
    `master_id` BIGINT COMMENT 'Primary key for master',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Material master records are assigned to GL accounts (inventory account, consumption account) for automatic account determination during goods movements. This is a fundamental ERP pattern in constructi',
    `substitution_material_master_id` BIGINT COMMENT 'Identifier of an approved substitute material.',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary supplier for this material.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the material record was approved for use.',
    `conformance_certificate_date` DATE COMMENT 'Date the compliance certificate was issued.',
    `conformance_certificate_number` STRING COMMENT 'Reference number of the material’s compliance certificate (e.g., ISO, ASTM).',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of one unit of material in the specified currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the material master record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for cost fields.',
    `master_description` STRING COMMENT 'Detailed textual description of the material, including typical applications.',
    `dimensions_cm` STRING COMMENT 'Length×Width×Height dimensions in centimeters, formatted as LxWxH.',
    `expiration_date` DATE COMMENT 'Calendar date when the material batch expires.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'True if the material is classified as hazardous under OSHA/EPA regulations.',
    `lead_time_days` STRING COMMENT 'Average number of days from order to receipt.',
    `leeds_compliance_flag` BOOLEAN COMMENT 'Indicates whether the material is eligible for LEED credit consideration.',
    `leeds_credit_applicability` STRING COMMENT 'LEED credit categories the material can contribute to.. Valid values are `energy|water|materials|innovation|none`',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the material record.. Valid values are `active|inactive|discontinued|draft|pending`',
    `lot_number` STRING COMMENT 'Lot identifier used for quality control and recall management.',
    `manufacturer_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the manufacturer’s country.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactures the material.',
    `material_code` STRING COMMENT 'Enterprise‑wide unique code or catalogue number for the material.',
    `material_origin_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the materials source.',
    `max_order_qty` STRING COMMENT 'Largest quantity that can be ordered in a single purchase.',
    `min_order_qty` STRING COMMENT 'Smallest quantity that can be ordered from the supplier.',
    `minimum_performance_criteria` STRING COMMENT 'Minimum performance thresholds the material must meet (e.g., compressive strength).',
    `master_name` STRING COMMENT 'Human‑readable name of the material.',
    `reorder_point_qty` STRING COMMENT 'Inventory level that triggers a replenishment order.',
    `safety_stock_qty` STRING COMMENT 'Buffer stock kept to protect against demand variability.',
    `shelf_life_days` STRING COMMENT 'Number of days the material can be stored before it expires.',
    `specification_grade` STRING COMMENT 'Grade or class of the material as defined by the governing standard.',
    `specification_standard` STRING COMMENT 'Reference standard governing the material (e.g., ASTM, BS, ISO, ACI, AISC).',
    `storage_requirements` STRING COMMENT 'Special storage conditions (e.g., temperature, humidity, segregation).',
    `substitution_approval_reference` STRING COMMENT 'Reference to the client/engineer approval document for the substitution.',
    `substitution_reason` STRING COMMENT 'Engineering or client‑approved justification for the substitution.',
    `supplier_part_number` STRING COMMENT 'Supplier‑assigned part number for the material.',
    `technical_specification` STRING COMMENT 'Full technical specification document reference or summary.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for inventory and consumption tracking.. Valid values are `kg|m3|pcs|l|m|ft`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the material record.',
    `version_number` STRING COMMENT 'Incremental version of the material record for change control.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Physical volume of a single unit of material in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of a single unit of material in kilograms.',
    CONSTRAINT pk_master PRIMARY KEY(`master_id`)
) COMMENT 'Authoritative master record for all construction materials and consumables used across projects. Captures material identity, detailed technical specifications (applicable standards — ASTM, BS, ISO, ACI, AISC — grade/class, minimum performance criteria, specification code, specification revision), classification (concrete, steel, MEP components, aggregates, timber, formwork, etc.), unit of measure, approved equivalent substitutes with engineering justification, LEED compliance flags, LEED credit applicability, hazardous material indicators, shelf life, storage requirements, and supplier cross-references. Manages specification lifecycle (draft, approved, superseded) and material qualification status. Records approved substitutions with reason, client/engineer approval reference, cost impact, and affected BOQ lines. This is the SSOT for material identity, technical specifications, and approved substitutes in the construction enterprise — all transactions reference this record.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'System-generated unique identifier for the warehouse record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Some warehouses are owned or leased by a client; the FK enables asset ownership and liability tracking.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Warehouses belong to a legal entity (company code) for financial reporting, inventory ownership, and intercompany stock transfer accounting. Construction groups with multiple legal entities require co',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Warehouses are operated under specific cost centers for overhead cost allocation (storage, handling, security). Construction finance requires cost center on warehouse to allocate warehouse operating c',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Hazardous material warehouses on construction sites must be governed by a documented HSE plan covering storage requirements, emergency procedures, and regulatory compliance. This link enables complian',
    `site_id` BIGINT COMMENT 'Identifier of the construction site or project to which the warehouse is attached.',
    `access_control_method` STRING COMMENT 'Primary method used to control entry to the warehouse.. Valid values are `badge|biometric|keycard|none`',
    `address_line1` STRING COMMENT 'Primary street address of the warehouse.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_area_sqm` DECIMAL(18,2) COMMENT 'Maximum usable floor area in square metres.',
    `capacity_weight_tonnes` DECIMAL(18,2) COMMENT 'Maximum total weight the warehouse can safely store, expressed in metric tonnes.',
    `certification_expiry_date` DATE COMMENT 'Date on which the hazardous‑material certification expires.',
    `city` STRING COMMENT 'City where the warehouse is located.',
    `climate_control_type` STRING COMMENT 'Specific climate control method applied when temperature_controlled is true.. Valid values are `refrigerated|heated|ambient`',
    `warehouse_code` STRING COMMENT 'Business‑visible alphanumeric code used to reference the warehouse in external systems.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the warehouse location.. Valid values are `USA|CAN|MEX|GBR|AUS`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse record was first created in the system.',
    `warehouse_description` STRING COMMENT 'Narrative description of the warehouse, its purpose, and special characteristics.',
    `effective_from` DATE COMMENT 'Date when the warehouse became operational or was officially opened.',
    `effective_until` DATE COMMENT 'Date when the warehouse ceased operations or is scheduled for closure (null if still active).',
    `gps_accuracy_meters` STRING COMMENT 'Estimated positional accuracy of the GPS coordinates, in metres.',
    `gps_latitude` DOUBLE COMMENT 'Latitude coordinate of the warehouse centre point.',
    `gps_longitude` DOUBLE COMMENT 'Longitude coordinate of the warehouse centre point.',
    `hazardous_material_certification_type` STRING COMMENT 'Specific type of hazardous‑material certification held, if any.. Valid values are `hazmat|none`',
    `inventory_management_system` STRING COMMENT 'Name of the downstream system that tracks inventory within this warehouse (e.g., SAP WM, Procore).',
    `is_hazardous_material_certified` BOOLEAN COMMENT 'Indicates whether the warehouse holds a valid hazardous‑material storage certification.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `warehouse_name` STRING COMMENT 'Human‑readable name of the warehouse or laydown yard.',
    `next_inspection_due` DATE COMMENT 'Planned date for the next required inspection.',
    `notes` STRING COMMENT 'Additional free‑form remarks or operational comments.',
    `operating_hours` STRING COMMENT 'Standard daily operating window (e.g., 08:00‑17:00).',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the warehouse address.',
    `security_level` STRING COMMENT 'Overall security classification of the warehouse.. Valid values are `low|medium|high|critical`',
    `state` STRING COMMENT 'State or province of the warehouse location.',
    `storage_zone_details` STRING COMMENT 'Free‑form description of internal zones, racks, bins, or yard sections.',
    `temperature_controlled` BOOLEAN COMMENT 'True if the warehouse maintains a controlled temperature environment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warehouse record.',
    `warehouse_status` STRING COMMENT 'Current operational status of the warehouse.. Valid values are `active|inactive|closed|maintenance`',
    `warehouse_type` STRING COMMENT 'Classification of the warehouse based on construction and regulatory characteristics.. Valid values are `bonded|open_yard|climate_controlled|hazmat_certified|general`',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master record for physical warehouse, laydown yard, and storage locations across construction sites and central depots. Tracks warehouse type (bonded, open yard, climate-controlled, hazmat-certified), capacity (area sqm, weight tonnes), GPS coordinates, site association, custodian, operating hours, hazardous material storage certification, and granular storage locations (rack positions, bin rows, open yard zones). Supports multi-site inventory management, material transfer logistics, and FIFO/FEFO stock management for batch-tracked materials.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`stock_level` (
    `stock_level_id` BIGINT COMMENT 'System-generated unique identifier for each stock level record.',
    `batch_lot_id` BIGINT COMMENT 'Foreign key linking to material.batch_lot. Business justification: stock_level tracks on-hand inventory and has batch_number as a denormalized STRING. For batch-tracked materials, the stock level record must link to the specific batch_lot record to enable traceabilit',
    `master_id` BIGINT COMMENT 'FK to material.material_master',
    `warehouse_id` BIGINT COMMENT 'FK to material.warehouse',
    `blocked_quantity` DECIMAL(18,2) COMMENT 'Quantity held due to quality issues, holds, or regulatory restrictions.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'Quantity allocated to specific construction activities or contracts.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of a single unit of material in the base currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the stock level record was first created.',
    `expiration_date` DATE COMMENT 'Date after which the material is considered unusable or non‑compliant.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity that has been dispatched but not yet received at the location.',
    `last_movement_date` TIMESTAMP COMMENT 'Date and time of the most recent stock transaction affecting this record.',
    `last_movement_type` STRING COMMENT 'Category of the most recent stock transaction.. Valid values are `receipt|issue|transfer|return|adjustment`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the stock level record.',
    `location_code` STRING COMMENT 'Identifier of the warehouse or storage site where the stock resides.',
    `lot_number` STRING COMMENT 'Identifier for a lot of material, often used for quality tracking.',
    `material_code` STRING COMMENT 'External business identifier or catalogue number for the material.',
    `max_stock_level` DECIMAL(18,2) COMMENT 'Upper threshold for inventory to avoid over‑stocking.',
    `min_stock_level` DECIMAL(18,2) COMMENT 'Lowest permissible inventory level before stock is considered understocked.',
    `quality_inspection_quantity` DECIMAL(18,2) COMMENT 'Quantity currently undergoing quality inspection or testing.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Total amount of material physically present in the location.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment request.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity earmarked for pending work packages or purchase orders.',
    `safety_stock` DECIMAL(18,2) COMMENT 'Buffer quantity maintained to protect against demand variability or supply delays.',
    `stock_level_status` STRING COMMENT 'Current lifecycle status of the stock quantity.. Valid values are `available|blocked|reserved|in_transit|quality_hold|consumed`',
    `supplier_code` STRING COMMENT 'External identifier of the supplier providing the material.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity fields.. Valid values are `kg|m3|pcs|ton|lb|gal`',
    CONSTRAINT pk_stock_level PRIMARY KEY(`stock_level_id`)
) COMMENT 'Current on-hand inventory position for each material at each warehouse/storage location. Captures unrestricted stock, quality-inspection stock, blocked stock, reserved stock, in-transit quantities, and committed (reserved-for-activity) quantities. Tracks reorder point, minimum/maximum stock levels, safety stock thresholds, and last movement date. Updated in real-time by stock movements (receipts, issues, transfers, returns). Critical for BOQ reconciliation, preventing site stoppages due to material shortages, and supporting procurement trigger automation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Primary key for stock_movement',
    `batch_lot_id` BIGINT COMMENT 'Foreign key linking to material.batch_lot. Business justification: stock_movement stores batch_number and lot_number as denormalized strings. For materials requiring chain-of-custody tracking (concrete, steel, MEP components), the goods receipt must link to the batch',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Goods receipts are tied to client orders; needed for delivery confirmation and contract compliance.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Goods receipts (stock movements) are posted against cost codes in construction job costing. Cost controllers require cost_code assignment on every material receipt to track actual vs. budgeted materia',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for Inventory Valuation: goods receipt creates a GL entry to record inventory value in the general ledger.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: stock_movement records a physical goods receipt against a material. It currently stores material_code and material_description as denormalized strings. Adding material_master_id FK normalizes this to ',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to material.warehouse. Business justification: stock_movement has source_warehouse_code as a denormalized STRING. For inter-warehouse transfers and returns, the source warehouse must be a proper FK reference to the warehouse master. Adding source_',
    `accounting_entry_posted` BOOLEAN COMMENT 'True when the financial posting for the receipt has been completed.',
    `actual_delivery_date` DATE COMMENT 'Date on which the material physically arrived at the site.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the received material.. Valid values are `compliant|non_compliant|exempt`',
    `cost_center_code` STRING COMMENT 'Cost center to which the receipt expense is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `delivery_note_number` STRING COMMENT 'Reference number of the suppliers delivery note accompanying the shipment.',
    `destination_warehouse_code` STRING COMMENT 'Code of the warehouse or site where the material is being received.',
    `expected_delivery_date` DATE COMMENT 'Planned delivery date as per the purchase order.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost associated with delivering the material.',
    `freight_currency_code` STRING COMMENT 'Currency of the freight cost.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `goods_receipt_type` STRING COMMENT 'Indicates whether the receipt is from a purchase, internal transfer, or return.. Valid values are `purchase|transfer|return`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the received material before taxes and discounts.',
    `inspection_status` STRING COMMENT 'Current status of the quality inspection for the receipt.. Valid values are `pending|passed|failed|rework`',
    `is_critical_material` BOOLEAN COMMENT 'Indicates whether the material is classified as critical for project execution.',
    `is_hazardous` BOOLEAN COMMENT 'True if the material is hazardous and subject to special handling.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and any discounts.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the accounting entry was posted.',
    `quality_certificate_number` STRING COMMENT 'Reference number of the quality certificate attached to the material batch.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Amount of material physically received, expressed in the unit of measure.',
    `receipt_number` STRING COMMENT 'Business‑visible identifier assigned to the receipt (e.g., GR‑2023‑000123).',
    `receipt_status` STRING COMMENT 'Overall processing status of the goods receipt.. Valid values are `partial|complete|over_delivery|rejected`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Exact date and time the goods receipt was posted in the system.',
    `remarks` STRING COMMENT 'Free‑text field for additional comments or notes about the receipt.',
    `storage_location_code` STRING COMMENT 'Code of the warehouse or site location where the material is stored.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the goods receipt.',
    `tax_code` STRING COMMENT 'Tax classification code applied to the receipt.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the received quantity (e.g., kilograms, meters).. Valid values are `kg|m|l|pcs|m2|m3`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goods receipt record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the receipt record.',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record of materials physically received at site or warehouse against a Purchase Order (PO). Captures GR date, PO reference, delivery note number, supplier, material, quantity received, unit of measure, batch/lot number, storage location, receiving inspector, and GR status (partial, complete, over-delivery). Triggers quality inspection workflow and updates stock levels. Aligns with SAP S/4HANA MIGO GR posting and Procore material delivery logs.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`goods_issue` (
    `goods_issue_id` BIGINT COMMENT 'System-generated unique identifier for the goods issue transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost Allocation: material issue costs are charged to a cost center for project accounting and financial reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material issues to site are charged to cost codes for job cost tracking. Construction cost controllers require cost_code on every goods issue to report actual material consumption by cost code against',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Crew-level material consumption tracking: materials (concrete, rebar, formwork) are issued to crews as a unit for their work scope. This link supports crew productivity analysis, cost-per-crew reporti',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Goods issues post to GL accounts (inventory credit, WIP/expense debit) via automatic account determination. Construction finance teams require GL account traceability on material issues for financial ',
    `job_cost_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.job_cost_transaction. Business justification: Goods issues to site generate job cost transactions recording actual material cost against the project. Direct FK enables cost-to-issue traceability for project cost reporting, EVM, and audit — a stan',
    `master_id` BIGINT COMMENT 'Unique identifier of the material being issued.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Construction HSE compliance requires material issues for hazardous work (hot work, confined space, working at heights) to reference the authorizing Permit to Work. Auditors trace material consumption ',
    `requisition_id` BIGINT COMMENT 'Foreign key linking to material.requisition. Business justification: A goods_issue fulfills a material requisition — the requisition is the demand document that triggers the warehouse to issue materials. This is a fundamental procurement-to-issue traceability link. goo',
    `return_issue_goods_issue_id` BIGINT COMMENT 'Identifier of the goods issue record that reverses this transaction, if any.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or stock location from which the material was issued.',
    `approval_status` STRING COMMENT 'Current approval state of the goods issue.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the issue was approved.',
    `batch_number` STRING COMMENT 'Batch or lot identifier for traceability of the material.',
    `comments` STRING COMMENT 'Free‑form notes entered by users regarding the issue.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the issued material complies with project specifications and safety standards.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods issue record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `delivery_note_number` STRING COMMENT 'Reference number of the delivery note accompanying the material receipt.',
    `expiration_date` DATE COMMENT 'Date after which the material is no longer usable (if applicable).',
    `goods_issue_status` STRING COMMENT 'Current processing state of the goods issue record.. Valid values are `draft|issued|cancelled|reversed`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the issued material before taxes or discounts.',
    `hazard_classification` STRING COMMENT 'Safety classification of the material for handling and storage.. Valid values are `hazardous|non_hazardous|flammable|toxic|none`',
    `inspection_required` BOOLEAN COMMENT 'True if a post‑issue inspection is mandated for the material.',
    `inspection_status` STRING COMMENT 'Current status of the required inspection.. Valid values are `not_started|in_progress|completed|failed`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was performed.',
    `is_returned` BOOLEAN COMMENT 'Indicates whether the issued material was later returned to inventory.',
    `issue_number` STRING COMMENT 'External reference number assigned to the goods issue for tracking and reconciliation.',
    `issue_reason` STRING COMMENT 'Business reason for issuing the material.. Valid values are `construction|maintenance|repair|testing|spare|other`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the material was physically issued from inventory.',
    `material_description` STRING COMMENT 'Human‑readable description of the material (e.g., grade, size).',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and any discounts.',
    `quantity_issued` DECIMAL(18,2) COMMENT 'Amount of material issued, expressed in the selected unit of measure.',
    `receipt_date` DATE COMMENT 'Date the material was received into the warehouse before issuance.',
    `source_document_number` STRING COMMENT 'Reference number of the originating purchase order or requisition.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Applicable tax amount for the issued material.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is measured.. Valid values are `kg|m3|pcs|l|ton|bag`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the goods issue record.',
    CONSTRAINT pk_goods_issue PRIMARY KEY(`goods_issue_id`)
) COMMENT 'Transactional record of materials issued from warehouse/stock to a WBS element, cost center, or work front for construction consumption. Captures issue date, WBS/cost code, material, quantity issued, unit of measure, batch/lot, issuing warehouse, requestor, and issue reason. Drives material cost allocation to project activities and updates stock levels. Supports EVM cost tracking and BOQ consumption reconciliation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`batch_lot` (
    `batch_lot_id` BIGINT COMMENT 'System-generated unique identifier for the batch or lot record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Batch/lot traceability often requires knowing the client for warranty, quality and regulatory reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Batch lots received are assigned to cost centers for inventory cost tracking and overhead allocation. Construction finance requires cost center on batch_lot to support inventory valuation reporting an',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Batch/lot receipts are costed to specific cost codes for inventory valuation and job costing in construction. Cost code assignment on batch_lot enables traceability from physical material batches to f',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: batch_lot is the traceability master for materials requiring lot tracking, yet it has no FK to the material master. It stores material_description and material_type as denormalized strings. Adding mat',
    `warehouse_id` BIGINT COMMENT 'Unique identifier of the warehouse holding the material.',
    `batch_number` STRING COMMENT 'Manufacturer-assigned batch number used to identify a specific production run.',
    `batch_status` STRING COMMENT 'Lifecycle status of the batch/lot.. Valid values are `produced|received|in_use|completed|recalled`',
    `certificate_of_conformance_ref` STRING COMMENT 'Reference number of the certificate confirming material meets specifications.',
    `cost` DECIMAL(18,2) COMMENT 'Acquisition cost of the batch/lot.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch/lot record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for the cost.. Valid values are `USD|EUR|GBP|JPY`',
    `disposal_method` STRING COMMENT 'Preferred method for disposing of excess or waste material.. Valid values are `recycle|landfill|hazardous|reuse`',
    `expiry_date` DATE COMMENT 'Date after which the material should not be used.',
    `inspection_passed` BOOLEAN COMMENT 'Indicates whether the last inspection met acceptance criteria.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent quality or safety inspection.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability when a batch is split into multiple lots.',
    `lot_traceability_flag` BOOLEAN COMMENT 'Indicates whether the lot is subject to full chain‑of‑custody tracking.',
    `manufacturer` STRING COMMENT 'Name of the company that produced the material.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or observations.',
    `production_date` DATE COMMENT 'Date the material batch was manufactured.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material in the batch expressed in the unit of measure.',
    `quarantine_status` STRING COMMENT 'Current quarantine state of the batch/lot.. Valid values are `active|inactive|quarantined|released|recalled`',
    `receipt_reference` STRING COMMENT 'Reference number of the goods receipt document.',
    `received_date` DATE COMMENT 'Date the batch was received at the construction site or warehouse.',
    `safety_data_sheet_ref` STRING COMMENT 'Reference to the SDS document for hazardous materials.',
    `storage_location` STRING COMMENT 'Physical location (e.g., warehouse aisle) where the batch is stored.',
    `supplier` STRING COMMENT 'Name of the entity that supplied the material to the construction site.',
    `test_passed` BOOLEAN COMMENT 'Indicates whether the material batch passed required quality tests.',
    `test_results_date` DATE COMMENT 'Date the material tests were performed.',
    `test_results_summary` STRING COMMENT 'Brief summary of test outcomes for the batch (e.g., compressive strength).',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity field.. Valid values are `kg|lb|m3|pcs`',
    `unit_volume` DECIMAL(18,2) COMMENT 'Volume per unit of material (e.g., cubic meters per bag).',
    `unit_weight` DECIMAL(18,2) COMMENT 'Weight per unit of material (e.g., kg per piece).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch/lot record.',
    CONSTRAINT pk_batch_lot PRIMARY KEY(`batch_lot_id`)
) COMMENT 'Batch and lot traceability master for materials requiring full chain-of-custody tracking — concrete pours (batch plant ticket), structural steel heats, rebar coils, MEP cable drums, and chemical admixtures. Captures batch number, lot number, manufacturer, production date, expiry date, certificate of conformance reference, test results summary, quarantine status, and linked goods receipt. Supports FAT/SAT traceability and NCR investigations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`boq_line` (
    `boq_line_id` BIGINT COMMENT 'System‑generated unique identifier for the BOQ line item.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Required for BOQ line to be assigned to the scheduled activity that will consume the material, enabling cost‑tracking, schedule integration, and material requirement reports.',
    `commercial_change_order_id` BIGINT COMMENT 'Foreign key linking to contract.commercial_change_order. Business justification: Commercial change orders modify BOQ quantities and unit rates. Quantity surveyors require this link to identify which BOQ lines were created or revised by a specific change order, supporting variation',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: BOQ lines are assigned to cost centers for budget allocation and cost control reporting. Construction cost controllers require cost_center on BOQ lines to enable budget vs. actual analysis at cost cen',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Required for BOQ Budgeting: each BOQ line is associated with a cost code to track planned vs. actual costs.',
    `master_id` BIGINT COMMENT 'Identifier of the material or item that this BOQ line represents.',
    `mto_line_id` BIGINT COMMENT 'Foreign key linking to material.mto_line. Business justification: BOQ (Bill of Quantities) lines represent budgeted material quantities, while MTO (Material Take-Off) lines represent engineered quantities from drawings. These two must be reconciled in construction p',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: BOQ lines are the basis for project budget line items in construction. Linking material_boq_line to project_budget enables direct BOQ-to-budget variance analysis — a standard construction quantity sur',
    `rfp_issuance_id` BIGINT COMMENT 'Foreign key linking to client.rfp_issuance. Business justification: BOQ (Bill of Quantities) lines are a core deliverable of the RFP response process in construction. Quantity surveyors prepare material BOQ lines directly against a specific RFP issuance. Bid complianc',
    `contract_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material that is contractually committed in the BOQ.',
    `is_change_order` BOOLEAN COMMENT 'Indicates whether this line originates from a change order (true) or the original BOQ (false).',
    `item_description` STRING COMMENT 'Narrative description of the material or work item represented by the line.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the BOQ, used for sorting and display.',
    `material_boq_line_status` STRING COMMENT 'Current lifecycle status of the BOQ line.. Valid values are `active|inactive|revised|deleted`',
    `quantity` DECIMAL(18,2) COMMENT 'Planned quantity of the material as defined in the BOQ line, expressed in the unit of measure.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOQ line record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BOQ line record.',
    `revision_number` STRING COMMENT 'Version number of the line after each amendment.',
    `total_value` DECIMAL(18,2) COMMENT 'Calculated line value (contract_quantity × unit_rate) in the project currency.',
    `trade_discipline` STRING COMMENT 'Construction trade or discipline (e.g., concrete, steel, MEP) associated with the line.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the quantity (e.g., m3, ton, pcs).',
    `unit_rate` DECIMAL(18,2) COMMENT 'Agreed price per unit of measure for the material.',
    CONSTRAINT pk_boq_line PRIMARY KEY(`boq_line_id`)
) COMMENT 'Bill of Quantities (BOQ) line item representing material and work quantities baselined for a project, used as the material domains reference for take-off reconciliation, consumption tracking, and procurement planning. Captures BOQ item code, description, unit of measure, contract quantity, unit rate, total value, WBS element, trade/discipline, and revision history. While contractual BOQ ownership may reside in the contract domain, this product serves as the material domains operational view for MTO reconciliation, material consumption variance analysis, and progress measurement against planned quantities.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`mto_line` (
    `mto_line_id` BIGINT COMMENT 'Primary key for mto_line',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Each MTO lines required_by_date is driven by the linked schedule activitys planned start. Procurement schedulers use this FK to generate material procurement schedules and identify long-lead items t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for MTO Cost Planning: material take‑off quantities are allocated to cost centers for cost estimation and forecasting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: MTO lines define planned material quantities and costs by cost code for procurement budget control. Construction estimators and cost controllers require cost_code on MTO lines to validate procurement ',
    `master_id` BIGINT COMMENT 'Reference to the material master record representing the specific material.',
    `mto_header_id` BIGINT COMMENT 'Identifier of the parent MTO document to which this line belongs.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: MTO lines represent planned material procurement that consumes project budget. Direct FK to project_budget enables budget commitment tracking at MTO line level — essential for construction cost-to-com',
    `actual_received_date` DATE COMMENT 'Date when the material was received on site.',
    `actual_received_quantity` DECIMAL(18,2) COMMENT 'Quantity of material actually received on site.',
    `approved_by` STRING COMMENT 'Identifier of the user who approved the MTO line.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the MTO line was approved.',
    `compliance_certification` STRING COMMENT 'Applicable certification or standard (e.g., ISO9001, ASTM) that the material meets.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the MTO line record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 code of the currency for cost estimates.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `design_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material calculated from design drawings or BIM models.',
    `discipline` STRING COMMENT 'Engineering discipline associated with the material.. Valid values are `civil|structural|electrical|mechanical|plumbing|hvac`',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated cost per unit of material for procurement planning.',
    `expiry_date` DATE COMMENT 'Date after which the material is no longer usable or compliant.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the material is critical to project schedule or safety.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the record has been logically deleted.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous.',
    `lead_time_days` STRING COMMENT 'Estimated number of days from order to delivery for the material.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the MTO header.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability of the material.',
    `material_specification` STRING COMMENT 'Detailed specification or grade of the material as defined in the BOQ.',
    `mto_status` STRING COMMENT 'Current lifecycle status of the MTO line.. Valid values are `draft|approved|issued|rejected|closed|pending`',
    `net_required_quantity` DECIMAL(18,2) COMMENT 'Total material quantity required after applying wastage factor.',
    `notes` STRING COMMENT 'Free-text field for additional comments or remarks about the MTO line.',
    `procurement_status` STRING COMMENT 'Current status of the procurement process for this material line.. Valid values are `not_started|ordered|received|backordered|canceled|partial`',
    `quantity_uom_factor` DECIMAL(18,2) COMMENT 'Factor to convert between alternative units of measure for the material.',
    `required_by_date` DATE COMMENT 'Date by which the material must be on site to meet construction schedule.',
    `revision_number` STRING COMMENT 'Revision identifier of the drawing or BIM model for this line.',
    `safety_data_sheet_url` STRING COMMENT 'Link to the safety data sheet document for the material.',
    `site_location_code` STRING COMMENT 'Code representing the construction site or warehouse where material will be used or stored.',
    `supplier_preferred` STRING COMMENT 'Name or identifier of the preferred supplier for this material.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost calculated as net_required_quantity multiplied by estimated_unit_price.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the material quantities.. Valid values are `kg|m3|pcs|ton|lb|gal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the MTO line record.',
    `variance_cost` DECIMAL(18,2) COMMENT 'Difference between total_estimated_cost and actual cost incurred.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between net_required_quantity and actual_received_quantity.',
    `wastage_factor` DECIMAL(18,2) COMMENT 'Percentage factor applied to account for material loss during construction.',
    CONSTRAINT pk_mto_line PRIMARY KEY(`mto_line_id`)
) COMMENT 'Material Take-Off (MTO) line item derived from engineering drawings and BIM models, representing the estimated material quantities required for construction. Captures MTO item, material master reference, design quantity, wastage factor, net required quantity, unit of measure, drawing/BIM model reference, discipline (civil, structural, MEP), revision number, and MTO status (draft, approved, issued-for-procurement). Bridges design domain and procurement/inventory planning.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Primary key for requisition',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Material requisitions are raised against specific schedule activities in construction look-ahead planning and material readiness tracking. Planners use this link to confirm materials are requisitioned',
    `boq_line_id` BIGINT COMMENT 'Foreign key linking to material.material_boq_line. Business justification: A requisition should be traceable to the BOQ (Bill of Quantities) line that budgeted for the material. Linking requisition to material_boq_line enables BOQ reconciliation — tracking how much of the bu',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Client‑initiated material requisitions need client_account_id for billing, cost allocation and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Budget Control: material requisitions are budgeted and approved against a specific cost center.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material requisitions are raised against cost codes for budget availability checking before approval. Construction project controls require cost_code on requisitions to track commitments and prevent b',
    `master_id` BIGINT COMMENT 'Master data identifier of the material or component being requested.',
    `mto_line_id` BIGINT COMMENT 'Foreign key linking to material.mto_line. Business justification: A material requisition is often raised to fulfill a specific MTO (Material Take-Off) line requirement derived from engineering drawings. Linking requisition to mto_line enables traceability from engin',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Requisition approval requires budget availability check against the project budget. Linking requisition to project_budget enables commitment tracking and budget consumption reporting — a core construc',
    `warehouse_id` BIGINT COMMENT 'Warehouse or storage location identifier from which the material will be drawn.',
    `approval_status` STRING COMMENT 'Status of the managerial or engineering approval workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the approval decision was recorded.',
    `change_order_number` STRING COMMENT 'Associated change order identifier if the requisition results from a scope change.',
    `compliance_document_number` STRING COMMENT 'Reference to any regulatory or safety document attached to the requisition (e.g., MSDS number).',
    `cost_estimate_gross` DECIMAL(18,2) COMMENT 'Projected total cost of the requested material before taxes and discounts.',
    `cost_estimate_net` DECIMAL(18,2) COMMENT 'Projected net cost after tax and any discounts.',
    `cost_estimate_tax` DECIMAL(18,2) COMMENT 'Estimated tax component applicable to the material cost.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for the cost estimate.',
    `fulfillment_date` DATE COMMENT 'Date on which the material was actually issued to the site or received from a supplier.',
    `fulfillment_status` STRING COMMENT 'Progress state of the material issue or purchase fulfillment.. Valid values are `not_started|in_progress|completed|cancelled`',
    `is_emergency` BOOLEAN COMMENT 'Indicates whether the requisition is an emergency (e.g., safety‑critical) request.',
    `is_stock_available` BOOLEAN COMMENT 'Indicates whether the requested material is currently available in warehouse inventory.',
    `justification` STRING COMMENT 'Narrative explanation for why the material is needed, supporting approval decisions.',
    `notes` STRING COMMENT 'Free‑form comments or additional information supplied by the requester.',
    `priority` STRING COMMENT 'Business priority indicating the urgency of the material request.. Valid values are `low|medium|high|critical`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material requested, expressed in the selected unit of measure.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when the requisition record was first persisted in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the requisition record.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the requisition was initially submitted by the site team.',
    `requester_department` STRING COMMENT 'Organizational department or trade responsible for the material request.',
    `required_by_date` DATE COMMENT 'Date by which the material must be available on site to avoid schedule impact.',
    `requisition_number` STRING COMMENT 'External business identifier assigned to the requisition (e.g., RQ‑2024‑00123).',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition.. Valid values are `pending|approved|rejected|fulfilled|closed`',
    `safety_review_status` STRING COMMENT 'Result of the safety compliance review required for certain hazardous materials.. Valid values are `pending|cleared|failed`',
    `tax_code` STRING COMMENT 'Tax classification code applied to the material cost.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the requested quantity (e.g., kilograms, cubic meters).. Valid values are `kg|m3|pcs|ton|l`',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Site or project team request for materials to be issued from warehouse stock or procured. Captures requisition number, requesting WBS/work front, required material, quantity, required-by date, priority, justification, approval status (pending, approved, rejected), approver, and fulfilment status. Triggers either a goods issue (if stock available) or a purchase requisition in procurement. Supports site operations planning and material demand management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`mto_header` (
    `mto_header_id` BIGINT COMMENT 'Primary key for mto_header',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: MTO headers represent bulk material procurement/transfer events owned by a cost center for financial control and overhead allocation. Construction finance requires cost center assignment on MTO header',
    `master_services_agreement_id` BIGINT COMMENT 'Foreign key linking to client.master_services_agreement. Business justification: Under framework/MSA contracts in construction, procurement teams prepare Material Take-Off headers for each call-off order referencing the governing MSA. This link enables MSA ceiling-value tracking, ',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: In construction pre-construction/bid phase, estimators prepare Material Take-Off headers directly tied to a client opportunity for cost estimation and procurement planning. Bid managers need to trace ',
    `parent_mto_header_id` BIGINT COMMENT 'Self-referencing FK on mto_header (parent_mto_header_id)',
    `project_site_id` BIGINT COMMENT 'Identifier of the site or warehouse where materials are shipped from.',
    `party_id` BIGINT COMMENT 'Identifier of the internal or external party that requested the material transfer.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the material transfer order was approved.',
    `batch_number` STRING COMMENT 'Identifier of the production batch associated with the transferred materials.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the material transfer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MTO header record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of total_cost.',
    `document_reference` STRING COMMENT 'External document or certificate identifier linked to the transfer (e.g., conformance certificate).',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the material transfer was initiated or recorded.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the transfer is considered critical for project schedule.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of concrete, steel, or other consumables.',
    `mto_header_status` STRING COMMENT 'Current lifecycle state of the material transfer order.',
    `mto_number` STRING COMMENT 'Human‑readable identifier assigned to the material transfer order.',
    `priority` STRING COMMENT 'Urgency level assigned to the material transfer.',
    `remarks` STRING COMMENT 'Free‑form comments or notes entered by users regarding the transfer.',
    `total_cost` DECIMAL(18,2) COMMENT 'Gross monetary value of the material transfer before discounts or taxes.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all material line items in the transfer (unit of measure defined by material type).',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Combined weight of transferred materials expressed in kilograms.',
    `transfer_reason` STRING COMMENT 'Business purpose for moving the materials.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this MTO header record.',
    CONSTRAINT pk_mto_header PRIMARY KEY(`mto_header_id`)
) COMMENT 'Master reference table for mto_header. Referenced by mto_header_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`material`.`master` ADD CONSTRAINT `fk_material_master_substitution_material_master_id` FOREIGN KEY (`substitution_material_master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_construction_v1`.`material`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_return_issue_goods_issue_id` FOREIGN KEY (`return_issue_goods_issue_id`) REFERENCES `vibe_construction_v1`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_mto_line_id` FOREIGN KEY (`mto_line_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_line`(`mto_line_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_mto_header_id` FOREIGN KEY (`mto_header_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_header`(`mto_header_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_boq_line_id` FOREIGN KEY (`boq_line_id`) REFERENCES `vibe_construction_v1`.`material`.`boq_line`(`boq_line_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_mto_line_id` FOREIGN KEY (`mto_line_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_line`(`mto_line_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_parent_mto_header_id` FOREIGN KEY (`parent_mto_header_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_header`(`mto_header_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`material` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`material` SET TAGS ('dbx_domain' = 'material');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Master Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `substitution_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Substitution Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `conformance_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Conformance Certificate Date');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `conformance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Conformance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `master_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions (cm)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `leeds_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'LEED Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('dbx_business_glossary_term' = 'LEED Credit Applicability');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('dbx_value_regex' = 'energy|water|materials|innovation|none');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Material Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|draft|pending');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `manufacturer_country` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Country');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `material_origin_country` SET TAGS ('dbx_business_glossary_term' = 'Material Origin Country');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `max_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `minimum_performance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Minimum Performance Criteria');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `master_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `specification_grade` SET TAGS ('dbx_business_glossary_term' = 'Specification Grade');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `specification_standard` SET TAGS ('dbx_business_glossary_term' = 'Specification Standard');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `substitution_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Substitution Approval Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `technical_specification` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|l|m|ft');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `access_control_method` SET TAGS ('dbx_business_glossary_term' = 'Access Control Method');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `access_control_method` SET TAGS ('dbx_value_regex' = 'badge|biometric|keycard|none');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `capacity_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Area Capacity (SQM)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `capacity_weight_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Weight Capacity (TONNES)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_business_glossary_term' = 'Climate Control Type');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_value_regex' = 'refrigerated|heated|ambient');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO‑3166‑1 Alpha‑3)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|AUS');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_description` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Description');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (METERS)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `hazardous_material_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Certification Type');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `hazardous_material_certification_type` SET TAGS ('dbx_value_regex' = 'hazmat|none');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `inventory_management_system` SET TAGS ('dbx_business_glossary_term' = 'Inventory Management System');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `is_hazardous_material_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Certification Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `storage_zone_details` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone Details');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature‑Controlled Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Status');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|maintenance');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Type');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('dbx_value_regex' = 'bonded|open_yard|climate_controlled|hazmat_certified|general');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `stock_level_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Level ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `batch_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Lot Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `blocked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In‑Transit Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Type');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_value_regex' = 'receipt|issue|transfer|return|adjustment');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `quality_inspection_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `stock_level_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `stock_level_status` SET TAGS ('dbx_value_regex' = 'available|blocked|reserved|in_transit|quality_hold|consumed');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|ton|lb|gal');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `batch_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Lot Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `accounting_entry_posted` SET TAGS ('dbx_business_glossary_term' = 'Accounting Entry Posted Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `destination_warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Warehouse Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `goods_receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Type');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `goods_receipt_type` SET TAGS ('dbx_value_regex' = 'purchase|transfer|return');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|rework');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `is_critical_material` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'partial|complete|over_delivery|rejected');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m|l|pcs|m2|m3');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Job Cost Transaction Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `return_issue_goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Return Issue ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Status');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_value_regex' = 'draft|issued|cancelled|reversed');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (Currency)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|flammable|toxic|none');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `is_returned` SET TAGS ('dbx_business_glossary_term' = 'Returned Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Number (GI Number)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `issue_reason` SET TAGS ('dbx_business_glossary_term' = 'Issue Reason');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `issue_reason` SET TAGS ('dbx_value_regex' = 'construction|maintenance|repair|testing|spare|other');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (Currency)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|l|ton|bag');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `batch_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Lot Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'produced|received|in_use|completed|recalled');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `certificate_of_conformance_ref` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycle|landfill|hazardous|reuse');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `inspection_passed` SET TAGS ('dbx_business_glossary_term' = 'Inspection Passed Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `lot_traceability_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Status');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_value_regex' = 'active|inactive|quarantined|released|recalled');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `receipt_reference` SET TAGS ('dbx_business_glossary_term' = 'Receipt Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `safety_data_sheet_ref` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `supplier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `test_passed` SET TAGS ('dbx_business_glossary_term' = 'Test Passed Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `test_results_date` SET TAGS ('dbx_business_glossary_term' = 'Test Results Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|m3|pcs');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Unit Volume');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `unit_weight` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `boq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Material BOQ Line ID');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `commercial_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Change Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `mto_line_id` SET TAGS ('dbx_business_glossary_term' = 'Mto Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Issuance Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `contract_quantity` SET TAGS ('dbx_business_glossary_term' = 'Contract Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `is_change_order` SET TAGS ('dbx_business_glossary_term' = 'Is Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `material_boq_line_status` SET TAGS ('dbx_business_glossary_term' = 'BOQ Line Status');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `material_boq_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revised|deleted');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Line Value');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `trade_discipline` SET TAGS ('dbx_business_glossary_term' = 'Trade / Discipline');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate (Price per UOM)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `mto_line_id` SET TAGS ('dbx_business_glossary_term' = 'Mto Line Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `mto_header_id` SET TAGS ('dbx_business_glossary_term' = 'Material Take-Off Header ID');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `actual_received_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Received Date');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `actual_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Received Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `design_quantity` SET TAGS ('dbx_business_glossary_term' = 'Design Quantity (DESIGN_QTY)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `discipline` SET TAGS ('dbx_value_regex' = 'civil|structural|electrical|mechanical|plumbing|hvac');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price (EST_UNIT_PRICE)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot / Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `material_specification` SET TAGS ('dbx_business_glossary_term' = 'Material Specification');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `mto_status` SET TAGS ('dbx_business_glossary_term' = 'MTO Line Status');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `mto_status` SET TAGS ('dbx_value_regex' = 'draft|approved|issued|rejected|closed|pending');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `net_required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Required Quantity (NET_QTY)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `procurement_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Status');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `procurement_status` SET TAGS ('dbx_value_regex' = 'not_started|ordered|received|backordered|canceled|partial');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `quantity_uom_factor` SET TAGS ('dbx_business_glossary_term' = 'Quantity UOM Conversion Factor');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `site_location_code` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `supplier_preferred` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost (EST_TOTAL_COST)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|ton|lb|gal');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `variance_cost` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `wastage_factor` SET TAGS ('dbx_business_glossary_term' = 'Wastage Factor (WASTAGE_FCTR)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `boq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Material Boq Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `mto_line_id` SET TAGS ('dbx_business_glossary_term' = 'Mto Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location ID');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `compliance_document_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Number');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_estimate_gross` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_estimate_net` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_estimate_tax` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Request Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `is_stock_available` SET TAGS ('dbx_business_glossary_term' = 'Stock Availability Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Requisition Justification');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requester_department` SET TAGS ('dbx_business_glossary_term' = 'Requester Department');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|fulfilled|closed');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Status');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|failed');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|ton|l');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `mto_header_id` SET TAGS ('dbx_business_glossary_term' = 'Mto Header Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `master_services_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Services Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `parent_mto_header_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Mto Header Id');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `parent_mto_header_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Source Site Id');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Id');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `mto_header_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `mto_number` SET TAGS ('dbx_business_glossary_term' = 'Mto Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kg');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
