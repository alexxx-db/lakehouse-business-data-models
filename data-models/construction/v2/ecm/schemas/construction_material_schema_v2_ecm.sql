-- Schema for Domain: material | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`material` COMMENT 'Materials management domain tracking inventory, stock levels, material receipts, consumption, transfers between sites, and material traceability (batch/lot tracking for concrete, steel, MEP components). Manages BOQ (Bill of Quantities) reconciliation, material specifications, FAT/SAT records, material conformance certificates, and warehouse operations for construction materials and consumables.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`master` (
    `master_id` BIGINT COMMENT 'Primary key for master',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Required for material master creation audit; compliance reports need the employee who created each material record.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Required for Procurements Approved Supplier List process; links each material to the subcontractor approved to supply it, enabling sourcing decisions and compliance checks.',
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
    `hr_employee_id` BIGINT COMMENT 'Identifier of the person or department responsible for warehouse oversight.',
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
    `master_id` BIGINT COMMENT 'FK to material.material_master',
    `warehouse_id` BIGINT COMMENT 'FK to material.warehouse',
    `batch_number` STRING COMMENT 'Identifier for the production batch, used for traceability of concrete, steel, etc.',
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
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Links goods receipt to the activity that triggered the material purchase, enabling receipt‑to‑schedule reconciliation and progress tracking.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Goods receipts are tied to client orders; needed for delivery confirmation and contract compliance.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the receipt.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for Inventory Valuation: goods receipt creates a GL entry to record inventory value in the general ledger.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Stock movement records must be linked to the originating purchase order for audit trails, cost allocation, and receipt verification.',
    `site_id` BIGINT COMMENT 'Identifier of the construction site or warehouse where material is received.',
    `accounting_entry_posted` BOOLEAN COMMENT 'True when the financial posting for the receipt has been completed.',
    `actual_delivery_date` DATE COMMENT 'Date on which the material physically arrived at the site.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the received material.',
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
    `lot_number` STRING COMMENT 'Lot identifier used for materials that are tracked by lot.',
    `material_code` STRING COMMENT 'Master data identifier for the material (e.g., steel grade, concrete mix).',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and any discounts.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the accounting entry was posted.',
    `quality_certificate_number` STRING COMMENT 'Reference number of the quality certificate attached to the material batch.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Amount of material physically received, expressed in the unit of measure.',
    `receipt_number` STRING COMMENT 'Business‑visible identifier assigned to the receipt (e.g., GR‑2023‑000123).',
    `receipt_status` STRING COMMENT 'Overall processing status of the goods receipt.. Valid values are `partial|complete|over_delivery|rejected`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Exact date and time the goods receipt was posted in the system.',
    `remarks` STRING COMMENT 'Free‑text field for additional comments or notes about the receipt.',
    `source_warehouse_code` STRING COMMENT 'Code of the warehouse or location from which the material originated.',
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
    `activity_id` BIGINT COMMENT 'Primavera activity identifier linked to the material consumption.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Required for tracking consumable material issues to specific equipment for cost allocation, compliance, and operational reporting.',
    `batch_lot_id` BIGINT COMMENT 'Identifier used for end‑to‑end traceability of the material batch.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Material issues are charged to a specific client; the link supports client cost tracking and invoicing.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the issue.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost Allocation: material issue costs are charged to a cost center for project accounting and financial reporting.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Materials Issue process records which craft worker receives material for job tasks, needed for labor cost allocation and safety compliance.',
    `master_id` BIGINT COMMENT 'Unique identifier of the material being issued.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee who requested the material issue.',
    `return_issue_goods_issue_id` BIGINT COMMENT 'Identifier of the goods issue record that reverses this transaction, if any.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier that provided the material.',
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
    `wbs_code` STRING COMMENT 'WBS element to which the material is allocated.',
    CONSTRAINT pk_goods_issue PRIMARY KEY(`goods_issue_id`)
) COMMENT 'Transactional record of materials issued from warehouse/stock to a WBS element, cost center, or work front for construction consumption. Captures issue date, WBS/cost code, material, quantity issued, unit of measure, batch/lot, issuing warehouse, requestor, and issue reason. Drives material cost allocation to project activities and updates stock levels. Supports EVM cost tracking and BOQ consumption reconciliation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`stock_transfer` (
    `stock_transfer_id` BIGINT COMMENT 'System-generated unique identifier for the stock transfer transaction.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Tracks material transfers that are initiated for a specific construction project in the Project Transfer Log.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Material Transfer SOP records the crew responsible for moving stock between warehouses, supporting logistics accountability and cost tracking.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or storage location receiving the material.',
    `master_id` BIGINT COMMENT 'Identifier of the material being transferred (e.g., concrete, steel, MEP component).',
    `source_warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or storage location from which the material is transferred.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Timestamp when the material was actually received at the destination warehouse.',
    `batch_number` STRING COMMENT 'Lot or batch identifier for traceability of the material (e.g., concrete batch, steel roll).',
    `carrier_name` STRING COMMENT 'Name of the logistics provider or carrier responsible for moving the material.',
    `comments` STRING COMMENT 'Free‑text field for additional notes or remarks about the transfer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock transfer record was first created in the system.',
    `document_reference` STRING COMMENT 'Reference to related documents such as transfer orders, packing lists, or customs paperwork.',
    `expected_arrival_date` DATE COMMENT 'Planned date on which the material is expected to arrive at the destination.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material moved in the transfer, expressed in the unit specified by unit_of_measure.',
    `stock_transfer_status` STRING COMMENT 'Current lifecycle state of the stock transfer (e.g., draft, planned, in‑transit, completed, cancelled).. Valid values are `draft|planned|in_transit|completed|cancelled`',
    `transfer_number` STRING COMMENT 'Human‑readable reference number assigned to the stock transfer for tracking and communication.',
    `transfer_reason` STRING COMMENT 'Business reason for the material movement, such as site reallocation or surplus return.. Valid values are `site_reallocation|project_closure|surplus_return|maintenance|other`',
    `transfer_timestamp` TIMESTAMP COMMENT 'Date and time when the material movement was initiated or recorded.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the transfer.. Valid values are `truck|rail|ship|air|pipeline`',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity (kilograms, cubic meters, pieces, tons, pounds, gallons).. Valid values are `kg|m3|pcs|ton|lb|gal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the stock transfer record.',
    CONSTRAINT pk_stock_transfer PRIMARY KEY(`stock_transfer_id`)
) COMMENT 'Transactional record of material movements between warehouses, sites, or storage locations within the enterprise. Captures transfer date, source warehouse, destination warehouse, material, quantity, batch/lot, transfer reason (site reallocation, project closure, surplus return), transport reference, and transfer status (in-transit, completed, cancelled). Supports multi-site material balancing and inter-project material sharing.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`batch_lot` (
    `batch_lot_id` BIGINT COMMENT 'System-generated unique identifier for the batch or lot record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Batch/lot traceability often requires knowing the client for warranty, quality and regulatory reporting.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project using the material.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Required: Batch lot compliance records need to point to the Regulatory Authority whose regulation the batch satisfies; standard practice in construction.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Assigns a responsible employee for each batch/lot; required for traceability and quality incident investigations.',
    `project_site_id` BIGINT COMMENT 'Identifier of the construction site where the material is applied.',
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
    `material_description` STRING COMMENT 'Free‑text description of the material, including grade or specification.',
    `material_type` STRING COMMENT 'Category of material represented by the batch/lot.. Valid values are `concrete|steel|rebar|mep_cable|adhesive`',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`conformance_certificate` (
    `conformance_certificate_id` BIGINT COMMENT 'Primary key for conformance_certificate',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project where the material is used.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Links certificate to the inspector who performed the test; needed for HSE compliance and audit trails.',
    `master_id` BIGINT COMMENT 'Identifier of the material to which this certificate applies.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the certificate was approved.',
    `approved_by` STRING COMMENT 'Name of the person or authority that approved the certificate for use.',
    `batch_number` STRING COMMENT 'Batch or lot identifier for traceability of the material.',
    `certificate_number` STRING COMMENT 'Official certificate number assigned by the issuing authority or lab.',
    `certificate_title` STRING COMMENT 'Human‑readable title or description of the certificate (e.g., "Structural Steel Grade A Certification").',
    `certificate_version` STRING COMMENT 'Version identifier of the certificate document.',
    `compliance_status` STRING COMMENT 'Overall compliance determination based on test results.. Valid values are `compliant|non_compliant|conditionally_compliant`',
    `conformance_certificate_status` STRING COMMENT 'Lifecycle status of the certificate.. Valid values are `draft|issued|revoked|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate record was first created in the system.',
    `expiry_date` DATE COMMENT 'Date when the certificate expires or becomes invalid.',
    `humidity_recorded` DECIMAL(18,2) COMMENT 'Relative humidity during the material test (%).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the certificate is currently active and usable.',
    `issuing_lab` STRING COMMENT 'Name of the laboratory or authority that issued the certificate.',
    `location` STRING COMMENT 'Site or warehouse location code associated with the certificate.',
    `material_type` STRING COMMENT 'Category of the material (e.g., steel, concrete, MEP component).',
    `measured_unit` STRING COMMENT 'Unit of the measured value (e.g., MPa for strength).. Valid values are `MPa|psi|kg/m3|mm|cm`',
    `measured_value` DECIMAL(18,2) COMMENT 'Primary quantitative measurement from the test (e.g., compressive strength).',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the certificate.',
    `related_document_ref` STRING COMMENT 'Reference (e.g., file path or URL) to the digital copy of the certificate.',
    `result_details` STRING COMMENT 'Narrative description of test outcomes, observations, and any deviations.',
    `revision_number` STRING COMMENT 'Sequential revision number for updates to the certificate.',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Temperature at which the material test was conducted (°C).',
    `test_date` DATE COMMENT 'Date on which the material test was performed.',
    `test_method` STRING COMMENT 'Methodology used for the test (e.g., compression, tensile, chemical analysis).',
    `test_result` STRING COMMENT 'Outcome of the material test indicating pass or fail.. Valid values are `pass|fail`',
    `test_standard` STRING COMMENT 'Standard used for testing (e.g., ASTM C39, ISO 9001).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certificate record.',
    CONSTRAINT pk_conformance_certificate PRIMARY KEY(`conformance_certificate_id`)
) COMMENT 'Material conformance and test certificate records for construction materials — mill certificates for structural steel, concrete mix design approvals, aggregate gradation reports, MEP component type-test certificates, and LEED-compliant material declarations. Captures certificate number, issuing lab/authority, material reference, batch/lot, test standard (ASTM, BS, ISO), test results, pass/fail status, expiry date, and document reference. Mandatory for QA/QC ITP compliance and regulatory handover packages.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`material_boq_line` (
    `material_boq_line_id` BIGINT COMMENT 'System‑generated unique identifier for the BOQ line item.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Required for BOQ line to be assigned to the scheduled activity that will consume the material, enabling cost‑tracking, schedule integration, and material requirement reports.',
    `boq_id` BIGINT COMMENT 'Identifier of the parent Bill of Quantities (BOQ) record to which this line belongs.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Required for BOQ Budgeting: each BOQ line is associated with a cost code to track planned vs. actual costs.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Needed for BOQ line allocation; assigns a subcontractor responsible for delivering the material, used in cost tracking and contract award reports.',
    `master_id` BIGINT COMMENT 'Identifier of the material or item that this BOQ line represents.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Needed for BOQ generation to ensure each line item references the approved sustainable material data (recycled content, EPD) as required by green certification specifications.',
    `bid_boq_line_id` BIGINT COMMENT 'SSOT reference to canonical bid.bid_boq_line resolving cross-domain duplicate.',
    `change_order_number` STRING COMMENT 'Identifier of the change order that introduced this line, if applicable.',
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
    `wbs_code` STRING COMMENT 'WBS element code linking the line to the project hierarchy.',
    CONSTRAINT pk_material_boq_line PRIMARY KEY(`material_boq_line_id`)
) COMMENT 'Bill of Quantities (BOQ) line item representing material and work quantities baselined for a project, used as the material domains reference for take-off reconciliation, consumption tracking, and procurement planning. Captures BOQ item code, description, unit of measure, contract quantity, unit rate, total value, WBS element, trade/discipline, and revision history. While contractual BOQ ownership may reside in the contract domain, this product serves as the material domains operational view for MTO reconciliation, material consumption variance analysis, and progress measurement against planned quantities.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`mto_line` (
    `mto_line_id` BIGINT COMMENT 'Primary key for mto_line',
    `bim_model_id` BIGINT COMMENT 'Identifier of the BIM model version containing the material definition.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with this MTO line.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for MTO Cost Planning: material take‑off quantities are allocated to cost centers for cost estimation and forecasting.',
    `master_id` BIGINT COMMENT 'Reference to the material master record representing the specific material.',
    `mto_header_id` BIGINT COMMENT 'Identifier of the parent MTO document to which this line belongs.',
    `actual_received_date` DATE COMMENT 'Date when the material was received on site.',
    `actual_received_quantity` DECIMAL(18,2) COMMENT 'Quantity of material actually received on site.',
    `approved_by` STRING COMMENT 'Identifier of the user who approved the MTO line.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the MTO line was approved.',
    `change_order_number` STRING COMMENT 'Reference to a change order that modifies this MTO line.',
    `compliance_certification` STRING COMMENT 'Applicable certification or standard (e.g., ISO9001, ASTM) that the material meets.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the MTO line record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 code of the currency for cost estimates.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `design_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material calculated from design drawings or BIM models.',
    `discipline` STRING COMMENT 'Engineering discipline associated with the material.. Valid values are `civil|structural|electrical|mechanical|plumbing|hvac`',
    `drawing_number` STRING COMMENT 'Reference number of the engineering drawing that defines the material requirement.',
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
    `hr_employee_id` BIGINT COMMENT 'Identifier of the person who approved or rejected the requisition.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Client‑initiated material requisitions need client_account_id for billing, cost allocation and compliance reporting.',
    `construction_project_id` BIGINT COMMENT 'Unique identifier of the construction project to which the requisition belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Budget Control: material requisitions are budgeted and approved against a specific cost center.',
    `master_id` BIGINT COMMENT 'Master data identifier of the material or component being requested.',
    `primary_requisition_employee_id` BIGINT COMMENT 'Identifier of the employee or subcontractor who created the requisition.',
    `site_id` BIGINT COMMENT 'Identifier of the physical construction site or location where the material is needed.',
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
    `wbs_code` STRING COMMENT 'WBS element that the material request is charged to.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Site or project team request for materials to be issued from warehouse stock or procured. Captures requisition number, requesting WBS/work front, required material, quantity, required-by date, priority, justification, approval status (pending, approved, rejected), approver, and fulfilment status. Triggers either a goods issue (if stock available) or a purchase requisition in procurement. Supports site operations planning and material demand management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`physical_inventory` (
    `physical_inventory_id` BIGINT COMMENT 'System-generated unique identifier for the physical inventory count record.',
    `construction_project_id` BIGINT COMMENT 'Foreign key to project.construction_project.construction_project_id',
    `master_id` BIGINT COMMENT 'Unique identifier of the material being counted.',
    `warehouse_id` BIGINT COMMENT 'Foreign key to material.warehouse.warehouse_id',
    `audit_created_by` STRING COMMENT 'Identifier of the user who created the count record.',
    `audit_updated_by` STRING COMMENT 'Identifier of the user who last modified the count record.',
    `batch_number` STRING COMMENT 'Batch or lot identifier for traceability of the material.',
    `count_date` DATE COMMENT 'Date on which the inventory count was performed.',
    `count_number` STRING COMMENT 'Business identifier assigned to each inventory count event, used for tracking and reconciliation.',
    `count_type` STRING COMMENT 'Indicates whether the count is a full inventory, a cycle count, or a spot check.. Valid values are `full|cycle|spot`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'Quantity of material physically counted during the inventory event.',
    `counter_name` STRING COMMENT 'Name of the employee or system that performed the count.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory count record was initially created in the system.',
    `expiry_date` DATE COMMENT 'Expiration date of the material, if applicable (e.g., chemicals, adhesives).',
    `location_code` STRING COMMENT 'Specific sub‑location or aisle within the warehouse where the count was performed.',
    `lot_number` STRING COMMENT 'Lot identifier when batch tracking is not used.',
    `material_description` STRING COMMENT 'Human‑readable description of the material (e.g., concrete grade, steel type).',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the counter.',
    `physical_inventory_status` STRING COMMENT 'Current lifecycle status of the count record.. Valid values are `open|counted|posted|reconciled`',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the count results were posted to the financial period for valuation.',
    `recount_flag` BOOLEAN COMMENT 'Indicates whether the item was recounted due to a discrepancy.',
    `system_book_quantity` DECIMAL(18,2) COMMENT 'Quantity of material recorded in the ERP system before the physical count.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the material quantity.. Valid values are `kg|m3|pcs|ton|lb`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the inventory count record.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between system book quantity and counted quantity (counted_quantity - system_book_quantity).',
    `variance_value` DECIMAL(18,2) COMMENT 'Monetary value of the quantity variance based on standard cost.',
    CONSTRAINT pk_physical_inventory PRIMARY KEY(`physical_inventory_id`)
) COMMENT 'Physical stock count event record for warehouse cycle counts and annual inventory audits. Captures count date, warehouse, count type (full, cycle, spot), material, system book quantity, physically counted quantity, variance quantity, variance value, count status (open, counted, posted), counter name, and recount flag. Supports inventory accuracy management, shrinkage tracking, and financial period-end stock valuation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`specification` (
    `specification_id` BIGINT COMMENT 'Primary key for specification',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Specification defines technical details for a material; linking to material_master removes duplicate type and grade attributes and connects the spec to its parent material.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Required: Material specifications are tied to Regulatory Obligations that define performance and safety standards; essential for compliance verification.',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: REQUIRED: Tender documents cite specific material specifications that suppliers must meet; linking enables traceability of spec compliance.',
    `applicable_project_type` STRING COMMENT 'Project categories where this specification may be applied.. Valid values are `highway|bridge|residential|commercial|industrial|airport`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the specification.',
    `specification_code` STRING COMMENT 'Business identifier code assigned to the specification (e.g., SPEC-00123).',
    `compliance_requirements` STRING COMMENT 'Textual description of regulatory or client compliance requirements tied to the specification.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of the material per unit of measure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost per unit.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `specification_description` STRING COMMENT 'Detailed textual description of the specification purpose, scope, and application.',
    `effective_from` DATE COMMENT 'Date when the specification becomes effective for use.',
    `effective_until` DATE COMMENT 'Date when the specification expires or is superseded (nullable).',
    `handling_instructions` STRING COMMENT 'Guidelines for safe handling and transport of the material.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this specification is the default for its material type.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification record.',
    `lead_time_days` STRING COMMENT 'Expected lead time from order to delivery for the material.',
    `leeds_credit_applicability` STRING COMMENT 'Indicates whether the specification contributes to a LEED credit (yes) or not (no).. Valid values are `yes|no`',
    `material_category` STRING COMMENT 'High‑level category of the material (e.g., concrete, steel, MEP).',
    `min_compressive_strength_mpa` DECIMAL(18,2) COMMENT 'Minimum compressive strength required for the material, expressed in megapascal.',
    `min_modulus_of_elasticity_gpa` DECIMAL(18,2) COMMENT 'Minimum modulus of elasticity required, expressed in gigapascal.',
    `min_tensile_strength_mpa` DECIMAL(18,2) COMMENT 'Minimum tensile strength required for the material, expressed in megapascal.',
    `min_yield_strength_mpa` DECIMAL(18,2) COMMENT 'Minimum yield strength required for the material, expressed in megapascal.',
    `specification_name` STRING COMMENT 'Human‑readable name of the material specification.',
    `safety_data_sheet_url` STRING COMMENT 'Link to the electronic safety data sheet (SDS) for the material.',
    `specification_status` STRING COMMENT 'Current lifecycle status of the specification.. Valid values are `draft|approved|superseded|retired`',
    `standard_code` STRING COMMENT 'Specific standard code (e.g., ASTM C150, ISO 9001).',
    `standard_reference` STRING COMMENT 'Reference to the governing standard body (e.g., ASTM, ISO, BS, ACI).',
    `storage_requirements` STRING COMMENT 'Special storage conditions required (e.g., temperature, humidity).',
    `substitute_specification_code` STRING COMMENT 'Code of an alternative specification that can be used in place of this one.',
    `supplier_code` STRING COMMENT 'Identifier of the preferred supplier for this material specification.',
    `version_number` STRING COMMENT 'Sequential version number of the specification.',
    `warranty_conditions` STRING COMMENT 'Specific conditions or exclusions that apply to the warranty.',
    `warranty_period_months` STRING COMMENT 'Length of warranty coverage for the material, expressed in months.',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Technical specification master for construction materials defining approved material standards, grades, and performance requirements for a project or enterprise. Captures specification code, material category, applicable standard (ASTM, BS, ISO, ACI, AISC), grade/class, minimum performance criteria, approved equivalent substitutes, LEED credit applicability, and specification status (draft, approved, superseded). Links design requirements to procurement and QA/QC inspection criteria.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`approved_material_list` (
    `approved_material_list_id` BIGINT COMMENT 'System-generated unique identifier for each approved material list record.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Replaces free‑text approving engineer with FK; required for project approval records and engineer accountability.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the approved material list belongs.',
    `master_id` BIGINT COMMENT 'Identifier of the alternative material approved as a substitution.',
    `approval_date` DATE COMMENT 'Date when the material received formal approval.',
    `approved_material_list_status` STRING COMMENT 'Current lifecycle status of the approved material entry.. Valid values are `active|inactive|revoked|pending|expired|withdrawn`',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material approved for use on the project.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the material lot.',
    `client_approval_reference` STRING COMMENT 'Reference number or code from the client/owner confirming approval.',
    `compliance_certificate_expiry_date` DATE COMMENT 'Expiration date of the compliance certificate.',
    `compliance_certificate_issue_date` DATE COMMENT 'Date the compliance certificate was issued.',
    `compliance_certificate_number` STRING COMMENT 'Reference number of the certificate confirming material compliance.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of one unit of the material in the project currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the approved material record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for cost values.',
    `environmental_rating` STRING COMMENT 'Sustainability certification or rating applicable to the material.. Valid values are `LEED|BREEAM|None`',
    `expiry_date` DATE COMMENT 'Date after which the material approval is no longer valid.',
    `grade` STRING COMMENT 'Standard grade or specification level of the material (e.g., ASTM A36, C30/37).',
    `handling_instructions` STRING COMMENT 'Operational guidance for safe handling and installation of the material.',
    `hazardous_classification` STRING COMMENT 'Regulatory classification of the hazardous material, if applicable.. Valid values are `Class1|Class2|Class3|None`',
    `is_hazardous` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous.',
    `is_primary_material` BOOLEAN COMMENT 'Indicates if the material is a primary (non‑substitutable) component of the design.',
    `is_substituted` BOOLEAN COMMENT 'Flag showing whether this entry represents a substitution for another approved material.',
    `lot_number` STRING COMMENT 'Lot identifier used for quality and regulatory tracking.',
    `manufacturer` STRING COMMENT 'Name of the company that produces the material.',
    `material_category` STRING COMMENT 'High‑level classification of the material (e.g., concrete, structural steel, MEP component).',
    `material_name` STRING COMMENT 'Descriptive name of the material as used in project documentation.',
    `material_origin_country` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code where the material was manufactured.. Valid values are `^[A-Z]{3}$`',
    `material_origin_state` STRING COMMENT 'State or province of manufacture, if applicable.',
    `model_number` STRING COMMENT 'Manufacturer‑assigned model or part number identifying the specific material variant.',
    `notes` STRING COMMENT 'Free‑form comments or remarks related to the approval.',
    `project_phase` STRING COMMENT 'Lifecycle phase of the project during which the material was approved.. Valid values are `design|construction|commissioning|handover`',
    `safety_data_sheet_url` STRING COMMENT 'Link to the electronic Safety Data Sheet (SDS) for the material.',
    `specification` STRING COMMENT 'Detailed technical specification or data sheet reference for the material.',
    `storage_requirements` STRING COMMENT 'Special storage conditions required for the material (e.g., temperature, humidity).',
    `substitution_allowed` BOOLEAN COMMENT 'Indicates whether the material may be substituted with an equivalent.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for quantity tracking of the material.. Valid values are `kg|m3|pcs|l|m|ft`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `warranty_expiry_date` DATE COMMENT 'Date when the warranty coverage ends.',
    `warranty_period_months` STRING COMMENT 'Length of the manufacturer warranty expressed in months.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_approved_material_list PRIMARY KEY(`approved_material_list_id`)
) COMMENT 'Project-level Approved Material List (AML) / Approved Vendor List for materials — the authoritative register of materials and brands approved by the client/engineer for use on a specific project. Captures material category, approved manufacturer, product model/grade, approval date, approving engineer, client approval reference, substitution status, and expiry date. Mandatory for contract compliance and submittal management. Prevents use of non-compliant materials on site.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`wastage` (
    `wastage_id` BIGINT COMMENT 'Primary key for wastage',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract under which the material was procured.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Waste records are allocated to a client for environmental reporting, cost recovery and contractual penalties.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the wastage belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Waste Cost Tracking: waste records must be posted to the responsible cost center for cost control and reporting.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Wastage tracking logs the worker generating waste, required for waste cost attribution and regulatory reporting.',
    `master_id` BIGINT COMMENT 'Identifier of the material type that was wasted.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the user who initially created the record.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier that provided the material.',
    `actual_quantity_consumed` DECIMAL(18,2) COMMENT 'Quantity of material actually used in the activity.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was approved.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the material.',
    `cause` STRING COMMENT 'Root cause of the material wastage.. Valid values are `cutting_loss|breakage|over_pour|theft|weather_damage|other`',
    `cost_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the waste cost values.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the wastage record was first created in the system.',
    `disposal_date` DATE COMMENT 'Date on which the waste was actually disposed.',
    `disposal_location` STRING COMMENT 'Physical location where the waste was disposed or processed.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the wasted material.. Valid values are `recycled|landfill|returned|incinerated|other`',
    `hazard_classification` STRING COMMENT 'Hazard class of the material according to regulatory standards.. Valid values are `class_a|class_b|class_c|class_d|class_e|class_f`',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the wasted material is classified as hazardous.',
    `is_recyclable` BOOLEAN COMMENT 'Flag indicating whether the waste material is recyclable.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the wastage record.',
    `lot_number` STRING COMMENT 'Lot identifier for the material, used for quality and compliance tracking.',
    `material_code` STRING COMMENT 'Standard code or SKU for the material.',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the waste event.',
    `percentage` DECIMAL(18,2) COMMENT 'Wastage quantity expressed as a percentage of planned quantity.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of material originally planned for the activity.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material that was wasted or scrapped.',
    `regulatory_compliance_flag` STRING COMMENT 'Indicates compliance status of waste handling with applicable regulations (e.g., OSHA, EPA).. Valid values are `compliant|non_compliant|exempt`',
    `reporting_period` STRING COMMENT 'Period (e.g., YYYY‑MM) for which the waste is reported.',
    `unit_of_measure` STRING COMMENT 'Unit used for quantity fields (e.g., kilograms, cubic meters).. Valid values are `kg|m3|ton|lb`',
    `wastage_date` DATE COMMENT 'Date on which the material wastage event occurred.',
    `wastage_status` STRING COMMENT 'Current lifecycle status of the wastage record.. Valid values are `recorded|reviewed|approved|closed`',
    `waste_cost_adjustment` DECIMAL(18,2) COMMENT 'Adjustments (e.g., rebates, penalties) applied to the gross waste cost.',
    `waste_cost_gross` DECIMAL(18,2) COMMENT 'Total cost associated with the waste before any adjustments.',
    `waste_cost_net` DECIMAL(18,2) COMMENT 'Net cost after adjustments, representing the financial impact of the waste.',
    `waste_record_number` STRING COMMENT 'Human‑readable identifier assigned to the wastage entry for tracking and reference.',
    `waste_type` STRING COMMENT 'Category of material that was wasted.. Valid values are `concrete|steel|mep|wood|plastic|other`',
    `wbs_code` STRING COMMENT 'WBS element to which the waste is allocated.',
    `work_front` STRING COMMENT 'Specific work front or location on site where waste occurred.',
    CONSTRAINT pk_wastage PRIMARY KEY(`wastage_id`)
) COMMENT 'Transactional record tracking material wastage and scrap generated during construction activities. Captures wastage date, WBS/work front, material, planned quantity, actual quantity consumed, wastage quantity, wastage percentage, wastage cause (cutting loss, breakage, over-pour, theft, weather damage), disposal method (recycled, landfill, returned), and cost impact. Supports waste reduction programs, LEED waste diversion tracking, and project cost control.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`hazmat_register` (
    `hazmat_register_id` BIGINT COMMENT 'System-generated unique identifier for each hazardous material register entry.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Required: Hazardous material register must reference the Permit authorising storage; experts track permit_id for each hazardous material.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Designates the HSE employee responsible for each hazardous material entry; needed for safety incident reporting.',
    `site_id` BIGINT COMMENT 'Identifier of the construction site where the material is located.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or storage facility holding the material.',
    `batch_number` STRING COMMENT 'Manufacturer-assigned batch identifier for traceability.',
    `cas_number` STRING COMMENT 'Unique Chemical Abstracts Service identifier for the material.. Valid values are `^d{2,7}-d{2}-d$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hazardous material record was created.',
    `date_received` DATE COMMENT 'Date the hazardous material was received on site.',
    `disposal_requirements` STRING COMMENT 'Procedures and regulatory requirements for disposing of the material.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of an incident involving the material.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.. Valid values are `^+?[0-9-]{7,15}$`',
    `expiration_date` DATE COMMENT 'Date after which the material should not be used.',
    `hazard_description` STRING COMMENT 'Narrative description of the hazards associated with the material.',
    `hazmat_register_status` STRING COMMENT 'Current lifecycle status of the hazardous material record.. Valid values are `active|inactive|retired|pending|archived`',
    `hse_notification_status` STRING COMMENT 'Current status of health, safety, and environment notification for the material.. Valid values are `notified|pending|exempt`',
    `is_corrosive` BOOLEAN COMMENT 'True if the material is corrosive.',
    `is_environmentally_hazardous` BOOLEAN COMMENT 'True if the material poses environmental hazards.',
    `is_explosive` BOOLEAN COMMENT 'True if the material is classified as explosive.',
    `is_flammable` BOOLEAN COMMENT 'True if the material is classified as flammable.',
    `is_radioactive` BOOLEAN COMMENT 'True if the material emits ionizing radiation.',
    `is_toxic` BOOLEAN COMMENT 'True if the material is toxic to humans or animals.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety inspection for the material.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `lot_number` STRING COMMENT 'Lot identifier used for inventory and quality control.',
    `material_code` STRING COMMENT 'Internal code used to uniquely identify the hazardous material across systems.',
    `material_description` STRING COMMENT 'Detailed description of the hazardous material, including composition and use.',
    `material_name` STRING COMMENT 'Descriptive name of the hazardous material.',
    `material_type` STRING COMMENT 'Broad category of the hazardous material.. Valid values are `fuel|solvent|adhesive|asbestos|chemical`',
    `next_inspection_due` DATE COMMENT 'Planned date for the next required safety inspection.',
    `quantity_on_site` DECIMAL(18,2) COMMENT 'Current amount of the hazardous material physically present at the site.',
    `risk_category` STRING COMMENT 'Overall risk level assigned to the material based on hazard classification.. Valid values are `low|medium|high|critical`',
    `sds_reference` STRING COMMENT 'Link or identifier to the Safety Data Sheet (SDS) for the material.',
    `storage_location` STRING COMMENT 'Designated area or zone within the site where the material is stored.',
    `storage_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the material requires temperature-controlled storage.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius.',
    `un_hazard_class` STRING COMMENT 'UN classification code indicating the type of hazard (e.g., 1 for explosives, 2 for gases). [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — promote to reference product]',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., kilograms, liters).. Valid values are `kg|l|m3|ton|g`',
    CONSTRAINT pk_hazmat_register PRIMARY KEY(`hazmat_register_id`)
) COMMENT 'Hazardous materials register tracking dangerous goods stored and used on construction sites — fuels, solvents, epoxy resins, asbestos-containing materials, and chemical admixtures. Captures material name, UN hazard class, CAS number, quantity on site, storage location, SDS (Safety Data Sheet) reference, regulatory permit number, disposal requirements, emergency contact, and HSE notification status. Mandatory for OSHA, EPA, and site HSE compliance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`material`.`mto_header` (
    `mto_header_id` BIGINT COMMENT 'Primary key for mto_header',
    `project_site_id` BIGINT COMMENT 'Identifier of the site or warehouse receiving the materials.',
    `parent_mto_header_id` BIGINT COMMENT 'Self-referencing FK on mto_header (parent_mto_header_id)',
    `party_id` BIGINT COMMENT 'Identifier of the internal or external party that requested the material transfer.',
    `source_site_id` BIGINT COMMENT 'Identifier of the site or warehouse where materials are shipped from.',
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
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_return_issue_goods_issue_id` FOREIGN KEY (`return_issue_goods_issue_id`) REFERENCES `vibe_construction_v1`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_source_warehouse_id` FOREIGN KEY (`source_warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ADD CONSTRAINT `fk_material_conformance_certificate_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_mto_header_id` FOREIGN KEY (`mto_header_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_header`(`mto_header_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ADD CONSTRAINT `fk_material_physical_inventory_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ADD CONSTRAINT `fk_material_physical_inventory_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ADD CONSTRAINT `fk_material_approved_material_list_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ADD CONSTRAINT `fk_material_hazmat_register_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_parent_mto_header_id` FOREIGN KEY (`parent_mto_header_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_header`(`mto_header_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`material` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`material` SET TAGS ('pii_domain' = 'material');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('pii_subdomain' = 'material_catalog');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`master` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Master Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Approved Supplier Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `substitution_material_master_id` SET TAGS ('pii_business_glossary_term' = 'Substitution Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `conformance_certificate_date` SET TAGS ('pii_business_glossary_term' = 'Conformance Certificate Date');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `conformance_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Conformance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `cost_per_unit` SET TAGS ('pii_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `master_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `dimensions_cm` SET TAGS ('pii_business_glossary_term' = 'Dimensions (cm)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `leeds_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'LEED Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('pii_business_glossary_term' = 'LEED Credit Applicability');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('pii_value_regex' = 'energy|water|materials|innovation|none');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Material Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'active|inactive|discontinued|draft|pending');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `manufacturer_country` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Country');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `material_code` SET TAGS ('pii_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `material_origin_country` SET TAGS ('pii_business_glossary_term' = 'Material Origin Country');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `max_order_qty` SET TAGS ('pii_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `min_order_qty` SET TAGS ('pii_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `minimum_performance_criteria` SET TAGS ('pii_business_glossary_term' = 'Minimum Performance Criteria');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `master_name` SET TAGS ('pii_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `reorder_point_qty` SET TAGS ('pii_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `safety_stock_qty` SET TAGS ('pii_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `shelf_life_days` SET TAGS ('pii_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `specification_grade` SET TAGS ('pii_business_glossary_term' = 'Specification Grade');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `specification_standard` SET TAGS ('pii_business_glossary_term' = 'Specification Standard');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `storage_requirements` SET TAGS ('pii_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `substitution_approval_reference` SET TAGS ('pii_business_glossary_term' = 'Substitution Approval Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `substitution_reason` SET TAGS ('pii_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `supplier_part_number` SET TAGS ('pii_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `technical_specification` SET TAGS ('pii_business_glossary_term' = 'Technical Specification');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|pcs|l|m|ft');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `volume_m3` SET TAGS ('pii_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`material`.`master` ALTER COLUMN `weight_kg` SET TAGS ('pii_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('pii_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Custodian Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `access_control_method` SET TAGS ('pii_business_glossary_term' = 'Access Control Method');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `access_control_method` SET TAGS ('pii_value_regex' = 'badge|biometric|keycard|none');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `capacity_area_sqm` SET TAGS ('pii_business_glossary_term' = 'Warehouse Area Capacity (SQM)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `capacity_weight_tonnes` SET TAGS ('pii_business_glossary_term' = 'Warehouse Weight Capacity (TONNES)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `certification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `climate_control_type` SET TAGS ('pii_business_glossary_term' = 'Climate Control Type');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `climate_control_type` SET TAGS ('pii_value_regex' = 'refrigerated|heated|ambient');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('pii_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code (ISO‑3166‑1 Alpha‑3)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = 'USA|CAN|MEX|GBR|AUS');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_description` SET TAGS ('pii_business_glossary_term' = 'Warehouse Description');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('pii_business_glossary_term' = 'GPS Accuracy (METERS)');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('pii_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('pii_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `hazardous_material_certification_type` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Certification Type');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `hazardous_material_certification_type` SET TAGS ('pii_value_regex' = 'hazmat|none');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `inventory_management_system` SET TAGS ('pii_business_glossary_term' = 'Inventory Management System');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `is_hazardous_material_certified` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Certification Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('pii_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `next_inspection_due` SET TAGS ('pii_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Warehouse Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `operating_hours` SET TAGS ('pii_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('pii_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `storage_zone_details` SET TAGS ('pii_business_glossary_term' = 'Storage Zone Details');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `temperature_controlled` SET TAGS ('pii_business_glossary_term' = 'Temperature‑Controlled Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('pii_business_glossary_term' = 'Warehouse Status');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|maintenance');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('pii_business_glossary_term' = 'Warehouse Type');
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('pii_value_regex' = 'bonded|open_yard|climate_controlled|hazmat_certified|general');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('pii_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `stock_level_id` SET TAGS ('pii_business_glossary_term' = 'Stock Level ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `master_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse Id');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `warehouse_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `blocked_quantity` SET TAGS ('pii_business_glossary_term' = 'Blocked Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `committed_quantity` SET TAGS ('pii_business_glossary_term' = 'Committed Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `cost_per_unit` SET TAGS ('pii_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `in_transit_quantity` SET TAGS ('pii_business_glossary_term' = 'In‑Transit Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `last_movement_date` SET TAGS ('pii_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `last_movement_type` SET TAGS ('pii_business_glossary_term' = 'Last Movement Type');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `last_movement_type` SET TAGS ('pii_value_regex' = 'receipt|issue|transfer|return|adjustment');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `material_code` SET TAGS ('pii_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `max_stock_level` SET TAGS ('pii_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `min_stock_level` SET TAGS ('pii_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `quality_inspection_quantity` SET TAGS ('pii_business_glossary_term' = 'Quality Inspection Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `quantity_on_hand` SET TAGS ('pii_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `reorder_point` SET TAGS ('pii_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `reserved_quantity` SET TAGS ('pii_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `safety_stock` SET TAGS ('pii_business_glossary_term' = 'Safety Stock');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `stock_level_status` SET TAGS ('pii_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `stock_level_status` SET TAGS ('pii_value_regex' = 'available|blocked|reserved|in_transit|quality_hold|consumed');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `supplier_code` SET TAGS ('pii_business_glossary_term' = 'Supplier Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|pcs|ton|lb|gal');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('pii_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('pii_business_glossary_term' = 'Stock Movement Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Receiving Inspector ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `accounting_entry_posted` SET TAGS ('pii_business_glossary_term' = 'Accounting Entry Posted Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `actual_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `destination_warehouse_code` SET TAGS ('pii_business_glossary_term' = 'Destination Warehouse Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `expected_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `freight_cost` SET TAGS ('pii_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `freight_currency_code` SET TAGS ('pii_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `freight_currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `goods_receipt_type` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Type');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `goods_receipt_type` SET TAGS ('pii_value_regex' = 'purchase|transfer|return');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `inspection_status` SET TAGS ('pii_value_regex' = 'pending|passed|failed|rework');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `is_critical_material` SET TAGS ('pii_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `is_hazardous` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `material_code` SET TAGS ('pii_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `posted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `quality_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `quantity_received` SET TAGS ('pii_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `receipt_number` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `receipt_status` SET TAGS ('pii_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `receipt_status` SET TAGS ('pii_value_regex' = 'partial|complete|over_delivery|rejected');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `receipt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `source_warehouse_code` SET TAGS ('pii_business_glossary_term' = 'Source Warehouse Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `storage_location_code` SET TAGS ('pii_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m|l|pcs|m2|m3');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('pii_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `goods_issue_id` SET TAGS ('pii_business_glossary_term' = 'Goods Issue ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `batch_lot_id` SET TAGS ('pii_business_glossary_term' = 'Lot Traceability ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `return_issue_goods_issue_id` SET TAGS ('pii_business_glossary_term' = 'Return Issue ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `delivery_note_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('pii_business_glossary_term' = 'Goods Issue Status');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('pii_value_regex' = 'draft|issued|cancelled|reversed');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Amount (Currency)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `hazard_classification` SET TAGS ('pii_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `hazard_classification` SET TAGS ('pii_value_regex' = 'hazardous|non_hazardous|flammable|toxic|none');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `inspection_required` SET TAGS ('pii_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `inspection_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `inspection_timestamp` SET TAGS ('pii_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `is_returned` SET TAGS ('pii_business_glossary_term' = 'Returned Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `issue_number` SET TAGS ('pii_business_glossary_term' = 'Goods Issue Number (GI Number)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `issue_reason` SET TAGS ('pii_business_glossary_term' = 'Issue Reason');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `issue_reason` SET TAGS ('pii_value_regex' = 'construction|maintenance|repair|testing|spare|other');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `issue_timestamp` SET TAGS ('pii_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount (Currency)');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `quantity_issued` SET TAGS ('pii_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `source_document_number` SET TAGS ('pii_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|pcs|l|ton|bag');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure Code');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` SET TAGS ('pii_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('pii_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Destination Warehouse ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `source_warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Source Warehouse ID');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('pii_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `expected_arrival_date` SET TAGS ('pii_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Transfer Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `stock_transfer_status` SET TAGS ('pii_business_glossary_term' = 'Transfer Status');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `stock_transfer_status` SET TAGS ('pii_value_regex' = 'draft|planned|in_transit|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('pii_business_glossary_term' = 'Transfer Number');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `transfer_reason` SET TAGS ('pii_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `transfer_reason` SET TAGS ('pii_value_regex' = 'site_reallocation|project_closure|surplus_return|maintenance|other');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `transfer_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transfer Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `transport_mode` SET TAGS ('pii_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `transport_mode` SET TAGS ('pii_value_regex' = 'truck|rail|ship|air|pipeline');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|pcs|ton|lb|gal');
ALTER TABLE `vibe_construction_v1`.`material`.`stock_transfer` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('pii_subdomain' = 'material_catalog');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `batch_lot_id` SET TAGS ('pii_business_glossary_term' = 'Batch Lot Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `regulatory_authority_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `batch_status` SET TAGS ('pii_business_glossary_term' = 'Batch Status');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `batch_status` SET TAGS ('pii_value_regex' = 'produced|received|in_use|completed|recalled');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `certificate_of_conformance_ref` SET TAGS ('pii_business_glossary_term' = 'Certificate of Conformance Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `cost` SET TAGS ('pii_business_glossary_term' = 'Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `disposal_method` SET TAGS ('pii_value_regex' = 'recycle|landfill|hazardous|reuse');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `inspection_passed` SET TAGS ('pii_business_glossary_term' = 'Inspection Passed Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `lot_traceability_flag` SET TAGS ('pii_business_glossary_term' = 'Lot Traceability Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `material_type` SET TAGS ('pii_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `material_type` SET TAGS ('pii_value_regex' = 'concrete|steel|rebar|mep_cable|adhesive');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `production_date` SET TAGS ('pii_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `quarantine_status` SET TAGS ('pii_business_glossary_term' = 'Quarantine Status');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `quarantine_status` SET TAGS ('pii_value_regex' = 'active|inactive|quarantined|released|recalled');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `receipt_reference` SET TAGS ('pii_business_glossary_term' = 'Receipt Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `safety_data_sheet_ref` SET TAGS ('pii_business_glossary_term' = 'Safety Data Sheet Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `supplier` SET TAGS ('pii_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `test_passed` SET TAGS ('pii_business_glossary_term' = 'Test Passed Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `test_results_date` SET TAGS ('pii_business_glossary_term' = 'Test Results Date');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `test_results_summary` SET TAGS ('pii_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|lb|m3|pcs');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `unit_volume` SET TAGS ('pii_business_glossary_term' = 'Unit Volume');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `unit_weight` SET TAGS ('pii_business_glossary_term' = 'Unit Weight');
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` SET TAGS ('pii_subdomain' = 'material_catalog');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `conformance_certificate_id` SET TAGS ('pii_business_glossary_term' = 'Conformance Certificate Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `certificate_title` SET TAGS ('pii_business_glossary_term' = 'Certificate Title');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `certificate_version` SET TAGS ('pii_business_glossary_term' = 'Certificate Version');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|conditionally_compliant');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `conformance_certificate_status` SET TAGS ('pii_business_glossary_term' = 'Certificate Status');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `conformance_certificate_status` SET TAGS ('pii_value_regex' = 'draft|issued|revoked|expired');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `humidity_recorded` SET TAGS ('pii_business_glossary_term' = 'Recorded Humidity');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `issuing_lab` SET TAGS ('pii_business_glossary_term' = 'Issuing Laboratory');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Location');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `material_type` SET TAGS ('pii_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `measured_unit` SET TAGS ('pii_business_glossary_term' = 'Measured Unit');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `measured_unit` SET TAGS ('pii_value_regex' = 'MPa|psi|kg/m3|mm|cm');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `measured_value` SET TAGS ('pii_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `related_document_ref` SET TAGS ('pii_business_glossary_term' = 'Related Document Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `result_details` SET TAGS ('pii_business_glossary_term' = 'Result Details');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `temperature_recorded` SET TAGS ('pii_business_glossary_term' = 'Recorded Temperature');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `test_date` SET TAGS ('pii_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `test_method` SET TAGS ('pii_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `test_result` SET TAGS ('pii_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `test_result` SET TAGS ('pii_value_regex' = 'pass|fail');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `test_standard` SET TAGS ('pii_business_glossary_term' = 'Test Standard');
ALTER TABLE `vibe_construction_v1`.`material`.`conformance_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_subdomain' = 'quantity_planning');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_ssot_role' = 'master');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_ssot_counterpart' = 'bid.bid_boq_line');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `material_boq_line_id` SET TAGS ('pii_business_glossary_term' = 'Material BOQ Line ID');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `boq_id` SET TAGS ('pii_business_glossary_term' = 'BOQ Header ID');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `sustainable_material_id` SET TAGS ('pii_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `bid_boq_line_id` SET TAGS ('pii_business_glossary_term' = 'Bid Boq Line Id');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `bid_boq_line_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `bid_boq_line_id` SET TAGS ('pii_ssot' = 'bid.bid_boq_line');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `change_order_number` SET TAGS ('pii_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `contract_quantity` SET TAGS ('pii_business_glossary_term' = 'Contract Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `is_change_order` SET TAGS ('pii_business_glossary_term' = 'Is Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `material_boq_line_status` SET TAGS ('pii_business_glossary_term' = 'BOQ Line Status');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `material_boq_line_status` SET TAGS ('pii_value_regex' = 'active|inactive|revised|deleted');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `total_value` SET TAGS ('pii_business_glossary_term' = 'Total Line Value');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `trade_discipline` SET TAGS ('pii_business_glossary_term' = 'Trade / Discipline');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `unit_rate` SET TAGS ('pii_business_glossary_term' = 'Unit Rate (Price per UOM)');
ALTER TABLE `vibe_construction_v1`.`material`.`material_boq_line` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('pii_subdomain' = 'quantity_planning');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `mto_line_id` SET TAGS ('pii_business_glossary_term' = 'Mto Line Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `bim_model_id` SET TAGS ('pii_business_glossary_term' = 'BIM Model Identifier (BIM_ID)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `mto_header_id` SET TAGS ('pii_business_glossary_term' = 'Material Take-Off Header ID');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `actual_received_date` SET TAGS ('pii_business_glossary_term' = 'Actual Received Date');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `actual_received_quantity` SET TAGS ('pii_business_glossary_term' = 'Actual Received Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `change_order_number` SET TAGS ('pii_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `compliance_certification` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `design_quantity` SET TAGS ('pii_business_glossary_term' = 'Design Quantity (DESIGN_QTY)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `discipline` SET TAGS ('pii_business_glossary_term' = 'Discipline');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `discipline` SET TAGS ('pii_value_regex' = 'civil|structural|electrical|mechanical|plumbing|hvac');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `drawing_number` SET TAGS ('pii_business_glossary_term' = 'Drawing Number (DRW_NO)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `estimated_unit_price` SET TAGS ('pii_business_glossary_term' = 'Estimated Unit Price (EST_UNIT_PRICE)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `is_deleted` SET TAGS ('pii_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `is_hazardous` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot / Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `material_specification` SET TAGS ('pii_business_glossary_term' = 'Material Specification');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `mto_status` SET TAGS ('pii_business_glossary_term' = 'MTO Line Status');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `mto_status` SET TAGS ('pii_value_regex' = 'draft|approved|issued|rejected|closed|pending');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `net_required_quantity` SET TAGS ('pii_business_glossary_term' = 'Net Required Quantity (NET_QTY)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `procurement_status` SET TAGS ('pii_business_glossary_term' = 'Procurement Status');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `procurement_status` SET TAGS ('pii_value_regex' = 'not_started|ordered|received|backordered|canceled|partial');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `quantity_uom_factor` SET TAGS ('pii_business_glossary_term' = 'Quantity UOM Conversion Factor');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `required_by_date` SET TAGS ('pii_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('pii_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `site_location_code` SET TAGS ('pii_business_glossary_term' = 'Site Location Code');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `supplier_preferred` SET TAGS ('pii_business_glossary_term' = 'Preferred Supplier');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `total_estimated_cost` SET TAGS ('pii_business_glossary_term' = 'Total Estimated Cost (EST_TOTAL_COST)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|pcs|ton|lb|gal');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `variance_cost` SET TAGS ('pii_business_glossary_term' = 'Cost Variance');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `variance_quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ALTER COLUMN `wastage_factor` SET TAGS ('pii_business_glossary_term' = 'Wastage Factor (WASTAGE_FCTR)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('pii_subdomain' = 'quantity_planning');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('pii_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `primary_requisition_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requester ID');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `primary_requisition_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `primary_requisition_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Inventory Location ID');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `change_order_number` SET TAGS ('pii_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `compliance_document_number` SET TAGS ('pii_business_glossary_term' = 'Compliance Document Number');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_estimate_gross` SET TAGS ('pii_business_glossary_term' = 'Estimated Gross Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_estimate_net` SET TAGS ('pii_business_glossary_term' = 'Estimated Net Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `cost_estimate_tax` SET TAGS ('pii_business_glossary_term' = 'Estimated Tax Amount');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `fulfillment_date` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `fulfillment_status` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `fulfillment_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `is_emergency` SET TAGS ('pii_business_glossary_term' = 'Emergency Request Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `is_stock_available` SET TAGS ('pii_business_glossary_term' = 'Stock Availability Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `justification` SET TAGS ('pii_business_glossary_term' = 'Requisition Justification');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requester_department` SET TAGS ('pii_business_glossary_term' = 'Requester Department');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `required_by_date` SET TAGS ('pii_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('pii_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|fulfilled|closed');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `safety_review_status` SET TAGS ('pii_business_glossary_term' = 'Safety Review Status');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `safety_review_status` SET TAGS ('pii_value_regex' = 'pending|cleared|failed');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|pcs|ton|l');
ALTER TABLE `vibe_construction_v1`.`material`.`requisition` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` SET TAGS ('pii_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `physical_inventory_id` SET TAGS ('pii_business_glossary_term' = 'Physical Inventory Record ID');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse Id');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `audit_created_by` SET TAGS ('pii_business_glossary_term' = 'Created By (User ID)');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `audit_updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By (User ID)');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `count_date` SET TAGS ('pii_business_glossary_term' = 'Physical Inventory Count Date');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `count_number` SET TAGS ('pii_business_glossary_term' = 'Physical Inventory Count Number');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `count_type` SET TAGS ('pii_business_glossary_term' = 'Physical Inventory Count Type');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `count_type` SET TAGS ('pii_value_regex' = 'full|cycle|spot');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `counted_quantity` SET TAGS ('pii_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `counter_name` SET TAGS ('pii_business_glossary_term' = 'Counter Name');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Count Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `physical_inventory_status` SET TAGS ('pii_business_glossary_term' = 'Physical Inventory Status');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `physical_inventory_status` SET TAGS ('pii_value_regex' = 'open|counted|posted|reconciled');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `posted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `recount_flag` SET TAGS ('pii_business_glossary_term' = 'Recount Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `system_book_quantity` SET TAGS ('pii_business_glossary_term' = 'System Book Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|pcs|ton|lb');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `variance_quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_construction_v1`.`material`.`physical_inventory` ALTER COLUMN `variance_value` SET TAGS ('pii_business_glossary_term' = 'Variance Value (Monetary)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` SET TAGS ('pii_subdomain' = 'material_catalog');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `specification_id` SET TAGS ('pii_business_glossary_term' = 'Specification Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `tender_id` SET TAGS ('pii_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `applicable_project_type` SET TAGS ('pii_business_glossary_term' = 'Applicable Project Type');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `applicable_project_type` SET TAGS ('pii_value_regex' = 'highway|bridge|residential|commercial|industrial|airport');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `specification_code` SET TAGS ('pii_business_glossary_term' = 'Specification Code');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `cost_per_unit` SET TAGS ('pii_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `specification_description` SET TAGS ('pii_business_glossary_term' = 'Specification Description');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `handling_instructions` SET TAGS ('pii_business_glossary_term' = 'Handling Instructions');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `is_default` SET TAGS ('pii_business_glossary_term' = 'Is Default Specification');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('pii_business_glossary_term' = 'LEED Credit Applicability');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('pii_value_regex' = 'yes|no');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `material_category` SET TAGS ('pii_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `min_compressive_strength_mpa` SET TAGS ('pii_business_glossary_term' = 'Minimum Compressive Strength (MPa)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `min_modulus_of_elasticity_gpa` SET TAGS ('pii_business_glossary_term' = 'Minimum Modulus of Elasticity (GPa)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `min_tensile_strength_mpa` SET TAGS ('pii_business_glossary_term' = 'Minimum Tensile Strength (MPa)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `min_yield_strength_mpa` SET TAGS ('pii_business_glossary_term' = 'Minimum Yield Strength (MPa)');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `specification_name` SET TAGS ('pii_business_glossary_term' = 'Specification Name');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('pii_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `specification_status` SET TAGS ('pii_business_glossary_term' = 'Specification Status');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `specification_status` SET TAGS ('pii_value_regex' = 'draft|approved|superseded|retired');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `standard_code` SET TAGS ('pii_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `standard_reference` SET TAGS ('pii_business_glossary_term' = 'Standard Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `storage_requirements` SET TAGS ('pii_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `substitute_specification_code` SET TAGS ('pii_business_glossary_term' = 'Substitute Specification Code');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `supplier_code` SET TAGS ('pii_business_glossary_term' = 'Supplier Code');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `warranty_conditions` SET TAGS ('pii_business_glossary_term' = 'Warranty Conditions');
ALTER TABLE `vibe_construction_v1`.`material`.`specification` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` SET TAGS ('pii_subdomain' = 'material_catalog');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `approved_material_list_id` SET TAGS ('pii_business_glossary_term' = 'Approved Material List ID');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approving Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Substitution Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `approved_material_list_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `approved_material_list_status` SET TAGS ('pii_value_regex' = 'active|inactive|revoked|pending|expired|withdrawn');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `approved_quantity` SET TAGS ('pii_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `client_approval_reference` SET TAGS ('pii_business_glossary_term' = 'Client Approval Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `compliance_certificate_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `compliance_certificate_issue_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `compliance_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Compliance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `cost_per_unit` SET TAGS ('pii_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `environmental_rating` SET TAGS ('pii_business_glossary_term' = 'Environmental Rating');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `environmental_rating` SET TAGS ('pii_value_regex' = 'LEED|BREEAM|None');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `grade` SET TAGS ('pii_business_glossary_term' = 'Material Grade');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `handling_instructions` SET TAGS ('pii_business_glossary_term' = 'Handling Instructions');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `hazardous_classification` SET TAGS ('pii_business_glossary_term' = 'Hazardous Classification');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `hazardous_classification` SET TAGS ('pii_value_regex' = 'Class1|Class2|Class3|None');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `is_hazardous` SET TAGS ('pii_business_glossary_term' = 'Is Hazardous');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `is_primary_material` SET TAGS ('pii_business_glossary_term' = 'Is Primary Material');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `is_substituted` SET TAGS ('pii_business_glossary_term' = 'Is Substituted');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `material_category` SET TAGS ('pii_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `material_name` SET TAGS ('pii_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `material_origin_country` SET TAGS ('pii_business_glossary_term' = 'Material Origin Country');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `material_origin_country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `material_origin_state` SET TAGS ('pii_business_glossary_term' = 'Material Origin State/Province');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `model_number` SET TAGS ('pii_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `project_phase` SET TAGS ('pii_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `project_phase` SET TAGS ('pii_value_regex' = 'design|construction|commissioning|handover');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('pii_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `specification` SET TAGS ('pii_business_glossary_term' = 'Material Specification');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `storage_requirements` SET TAGS ('pii_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `substitution_allowed` SET TAGS ('pii_business_glossary_term' = 'Substitution Allowed');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|pcs|l|m|ft');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `warranty_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `warranty_period_months` SET TAGS ('pii_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_construction_v1`.`material`.`approved_material_list` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` SET TAGS ('pii_subdomain' = 'inventory_control');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `wastage_id` SET TAGS ('pii_business_glossary_term' = 'Wastage Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `actual_quantity_consumed` SET TAGS ('pii_business_glossary_term' = 'Actual Quantity Consumed');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `cause` SET TAGS ('pii_business_glossary_term' = 'Wastage Cause');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `cause` SET TAGS ('pii_value_regex' = 'cutting_loss|breakage|over_pour|theft|weather_damage|other');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Cost Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `disposal_location` SET TAGS ('pii_business_glossary_term' = 'Disposal Location');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `disposal_method` SET TAGS ('pii_value_regex' = 'recycled|landfill|returned|incinerated|other');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `hazard_classification` SET TAGS ('pii_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `hazard_classification` SET TAGS ('pii_value_regex' = 'class_a|class_b|class_c|class_d|class_e|class_f');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `is_hazardous` SET TAGS ('pii_business_glossary_term' = 'Is Hazardous');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `is_recyclable` SET TAGS ('pii_business_glossary_term' = 'Is Recyclable');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `material_code` SET TAGS ('pii_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `percentage` SET TAGS ('pii_business_glossary_term' = 'Wastage Percentage');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `planned_quantity` SET TAGS ('pii_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Wastage Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `reporting_period` SET TAGS ('pii_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|m3|ton|lb');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `wastage_date` SET TAGS ('pii_business_glossary_term' = 'Wastage Date');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `wastage_status` SET TAGS ('pii_business_glossary_term' = 'Wastage Record Status');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `wastage_status` SET TAGS ('pii_value_regex' = 'recorded|reviewed|approved|closed');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `waste_cost_adjustment` SET TAGS ('pii_business_glossary_term' = 'Waste Cost Adjustment');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `waste_cost_gross` SET TAGS ('pii_business_glossary_term' = 'Gross Waste Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `waste_cost_net` SET TAGS ('pii_business_glossary_term' = 'Net Waste Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `waste_record_number` SET TAGS ('pii_business_glossary_term' = 'Waste Record Number (WRN)');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `waste_type` SET TAGS ('pii_business_glossary_term' = 'Waste Type');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `waste_type` SET TAGS ('pii_value_regex' = 'concrete|steel|mep|wood|plastic|other');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`material`.`wastage` ALTER COLUMN `work_front` SET TAGS ('pii_business_glossary_term' = 'Work Front');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` SET TAGS ('pii_subdomain' = 'material_catalog');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hazmat_register_id` SET TAGS ('pii_business_glossary_term' = 'Hazardous Materials Register ID');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `warehouse_id` SET TAGS ('pii_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `cas_number` SET TAGS ('pii_business_glossary_term' = 'CAS Registry Number');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `cas_number` SET TAGS ('pii_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `date_received` SET TAGS ('pii_business_glossary_term' = 'Date Received');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `disposal_requirements` SET TAGS ('pii_business_glossary_term' = 'Disposal Requirements');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_value_regex' = '^+?[0-9-]{7,15}$');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hazard_description` SET TAGS ('pii_business_glossary_term' = 'Hazard Description');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hazmat_register_status` SET TAGS ('pii_business_glossary_term' = 'Material Status');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hazmat_register_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|pending|archived');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hse_notification_status` SET TAGS ('pii_business_glossary_term' = 'HSE Notification Status');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `hse_notification_status` SET TAGS ('pii_value_regex' = 'notified|pending|exempt');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `is_corrosive` SET TAGS ('pii_business_glossary_term' = 'Is Corrosive');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `is_environmentally_hazardous` SET TAGS ('pii_business_glossary_term' = 'Is Environmentally Hazardous');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `is_explosive` SET TAGS ('pii_business_glossary_term' = 'Is Explosive');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `is_flammable` SET TAGS ('pii_business_glossary_term' = 'Is Flammable');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `is_radioactive` SET TAGS ('pii_business_glossary_term' = 'Is Radioactive');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `is_toxic` SET TAGS ('pii_business_glossary_term' = 'Is Toxic');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `material_code` SET TAGS ('pii_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `material_name` SET TAGS ('pii_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `material_type` SET TAGS ('pii_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `material_type` SET TAGS ('pii_value_regex' = 'fuel|solvent|adhesive|asbestos|chemical');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `next_inspection_due` SET TAGS ('pii_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `quantity_on_site` SET TAGS ('pii_business_glossary_term' = 'Quantity on Site');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `risk_category` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `sds_reference` SET TAGS ('pii_business_glossary_term' = 'Safety Data Sheet Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `storage_temperature_controlled` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature Controlled');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `temperature_max_celsius` SET TAGS ('pii_business_glossary_term' = 'Maximum Storage Temperature (°C)');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `temperature_min_celsius` SET TAGS ('pii_business_glossary_term' = 'Minimum Storage Temperature (°C)');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `un_hazard_class` SET TAGS ('pii_business_glossary_term' = 'UN Hazard Class');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`material`.`hazmat_register` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'kg|l|m3|ton|g');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('pii_subdomain' = 'quantity_planning');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `mto_header_id` SET TAGS ('pii_business_glossary_term' = 'Mto Header Identifier');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Destination Site Id');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `parent_mto_header_id` SET TAGS ('pii_business_glossary_term' = 'Parent Mto Header Id');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `parent_mto_header_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Party Id');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `source_site_id` SET TAGS ('pii_business_glossary_term' = 'Source Site Id');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `mto_header_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `mto_number` SET TAGS ('pii_business_glossary_term' = 'Mto Number');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `total_cost` SET TAGS ('pii_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `total_quantity` SET TAGS ('pii_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `total_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Total Weight Kg');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `transfer_reason` SET TAGS ('pii_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
