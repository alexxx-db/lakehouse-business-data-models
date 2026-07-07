-- Schema for Domain: inventory | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`inventory` COMMENT 'Inventory management for WIP wafer lots, raw materials (silicon wafers, chemicals, gases, photomasks), finished goods (packaged chips), die banks, and consignment stock at OSAT partners. Tracks lot traceability, KGD status, bin classifications, shelf life, storage conditions, and inventory valuation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` (
    `inventory_wafer_lot_id` BIGINT COMMENT 'Unique surrogate identifier for the wafer lot master record within the inventory domain. Primary key for the inventory_wafer_lot data product. Role: TRANSACTION_HEADER — this entity represents a discrete WIP business event (a lot moving through FAB) with a clear lifecycle, party references, timestamps, and quantitative results.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom this wafer lot is being fabricated. Applicable for foundry/OSAT business models where lots are customer-specific. Null for internal product lots. This is the PARTY_REFERENCE category field for this TRANSACTION_HEADER entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating wafer‑lot production costs to a cost center for internal cost‑of‑goods‑sold reporting.',
    `customer_design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Required for Production Tracking Report linking each wafer lot to the originating customer design win for revenue and yield attribution.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: ECCN classification is needed for export control of wafer lots; linking lot to its ECCN record enables automated compliance checks and reporting.',
    `experimental_lot_id` BIGINT COMMENT 'Foreign key linking to research.experimental_lot. Business justification: Needed for the Experimental Wafer Lot Tracking report that ties research lots to physical inventory for traceability.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export License Management requires each wafer lot to be tied to the specific export license authorizing its shipment, a standard practice in semiconductor export compliance.',
    `equipment_fab_id` BIGINT COMMENT 'Reference to the fabrication facility (FAB) where this wafer lot is being processed. Supports multi-fab inventory tracking and capacity allocation. This is the PARTY_REFERENCE / facility reference category field for this TRANSACTION_HEADER entity.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the specific equipment unit currently processing or last processing this wafer lot. Enables equipment-to-lot traceability for defect root cause analysis and equipment qualification tracking.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Identifier of the MES process route (flow plan) assigned to this wafer lot, defining the ordered sequence of operations from wafer start through final FAB step. Determines which process steps, equipment, and recipes apply to the lot.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the semiconductor process technology definition (PDK / technology platform) used for this lot. Links to the technology master record which defines design rules, layer stack, and process parameters.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Required for Wafer Lot Production Traceability Report linking each wafer lot to its IC catalog; replaces denormalized product_code with a proper FK.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Wafer‑lot allocation to a specific IC design project is required for production planning and capacity reports.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW shuttle run if this lot is part of a multi-project wafer program. MPW lots share a single wafer with multiple customer designs to reduce NRE costs. Null for dedicated production lots.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lot Management requires assigning a process engineer to each wafer lot for traceability, accountability, and release approval.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables profitability analysis per wafer lot by linking to the profit center that owns the product line.',
    `reticle_set_id` BIGINT COMMENT 'Identifier of the photomask (reticle) set used for photolithography patterning of this wafer lot. Enables traceability between WIP lots and mask inventory, supporting mask defect impact analysis and OPC (Optical Proximity Correction) version tracking.',
    `order_id` BIGINT COMMENT 'Reference to the SAP SD sales order that triggered this wafer lot start. Links WIP inventory to customer demand for order-to-cash traceability and delivery commitment tracking.',
    `sku_id` BIGINT COMMENT 'FK to product.sku',
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location record within the inventory wafer lot inventory entity.',
    `tapeout_id` BIGINT COMMENT 'Reference to the tapeout record (final design submission for manufacturing) associated with this wafer lot. Links WIP inventory to the design domain for design-to-silicon traceability and first silicon yield analysis.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `primary_inventory_fabrication_wafer_lot_id` BIGINT COMMENT 'Externally-known, human-readable lot identifier assigned by the Manufacturing Execution System (MES) at lot creation. Used across FAB operations, quality systems, and customer traceability. Corresponds to the Camstar MES Lot ID / SAP PP Production Order number. This is the BUSINESS_IDENTIFIER category field for this TRANSACTION_HEADER entity.',
    `actual_completion_date` DATE COMMENT 'Actual date on which the wafer lot completed all FAB process steps. Populated upon lot completion. Used for cycle time actuals, on-time delivery KPI calculation, and process improvement analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this wafer lot master record was first created in the inventory data product (Silver layer). Represents the RECORD_AUDIT_CREATED category for this TRANSACTION_HEADER entity. Used for data lineage and audit trail.',
    `current_operation_step` STRING COMMENT 'The current process operation step name or code at which the wafer lot is positioned in the process flow (e.g., FEOL_Gate_Oxide, MOL_Contact_Etch, BEOL_Metal1_CVD). Sourced from the MES process flow definition. Critical for WIP traceability and cycle time analysis.',
    `die_per_wafer` STRING COMMENT 'Theoretical number of die that can be patterned on a single wafer for this product at the given process node and die size. Used as the denominator for yield calculations and finished goods quantity forecasting.',
    `good_wafer_count` STRING COMMENT 'Number of wafers in the lot that have passed all in-line inspection and metrology checks to date. Represents the current count of wafers expected to yield good die. Updated after each inspection or disposition event.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the wafer lot is currently placed on hold and cannot proceed to the next process step. A True value means the lot is blocked pending engineering review, quality disposition, or management approval. Sourced from MES hold management.',
    `hold_reason_code` STRING COMMENT 'Coded reason for the current or most recent hold placed on the wafer lot (e.g., PROCESS_EXCURSION, EQUIPMENT_FAILURE, YIELD_LOSS, CUSTOMER_REQUEST, ENGINEERING_REVIEW). Populated when hold_flag is True. Used for hold disposition tracking and FMEA analysis. [ENUM-REF-CANDIDATE: PROCESS_EXCURSION|EQUIPMENT_FAILURE|YIELD_LOSS|CUSTOMER_REQUEST|ENGINEERING_REVIEW|MATERIAL_SHORTAGE|QUALITY_DISPOSITION — promote to reference product]',
    `hold_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent hold was placed on the wafer lot. Null if the lot has never been placed on hold. Used for hold duration tracking and SPC (Statistical Process Control) excursion response time measurement.',
    `inventory_fabrication_wafer_lot_id` BIGINT COMMENT 'SSOT reference to authoritative owner fabrication.fabrication_wafer_lot for concept wafer_lot',
    `inventory_valuation_amount` DECIMAL(18,2) COMMENT 'Current standard cost valuation of the wafer lot in the inventory ledger, expressed in the functional currency. Calculated based on the number of wafers and the standard cost per wafer at the current process step. Used for WIP inventory valuation in SAP FI/CO and financial reporting under SOX.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the inventory wafer lot record in the inventory domain.',
    `lithography_type` STRING COMMENT 'Type of photolithography exposure technology used for the critical layers of this wafer lot. EUV (Extreme Ultraviolet) is used for leading-edge nodes (sub-7nm); DUV (Deep Ultraviolet) for mature nodes. Determines equipment routing and cost structure.. Valid values are `EUV|DUV|i-line|g-line`',
    `lot_number` STRING COMMENT 'The lot number of the inventory wafer lot record in the inventory domain.',
    `lot_start_date` DATE COMMENT 'Calendar date on which the wafer lot was officially started (wafer start authorization executed) in the FAB. Used for cycle time measurement, WIP aging analysis, and on-time delivery tracking. This is the BUSINESS_EVENT_TIMESTAMP (date precision) category field.',
    `lot_status` STRING COMMENT 'Current lifecycle state of the wafer lot within the FAB WIP flow. active indicates the lot is progressing through process steps; on_hold indicates a hold flag is set pending disposition; completed indicates all process steps are finished; scrapped indicates the lot has been disposed; cancelled indicates the lot was terminated before completion. This is the LIFECYCLE_STATUS category field.. Valid values are `active|on_hold|completed|scrapped|cancelled`',
    `lot_type` STRING COMMENT 'Classification of the wafer lot by its manufacturing purpose. production lots are for customer shipment; engineering lots support process development; qualification lots validate new processes or products; monitor lots track process stability; reliability lots support JEDEC/IATF reliability testing. This is the CLASSIFICATION_OR_TYPE category field.. Valid values are `production|engineering|qualification|monitor|reliability`',
    `mes_lot_reference` STRING COMMENT 'Native lot reference number as recorded in the Applied Materials SmartFactory or Camstar MES system. Enables direct cross-reference to the operational system of record for lot tracking, dispatch, and WIP management.',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `priority_class` STRING COMMENT 'Dispatch priority classification assigned to the wafer lot, used by MES to sequence lot movement through FAB equipment queues. hot lots receive highest priority for customer-critical or yield-recovery situations; expedite for accelerated delivery; standard for normal flow; low for non-urgent engineering runs.. Valid values are `hot|expedite|standard|low`',
    `process_node` STRING COMMENT 'Semiconductor manufacturing process technology node (e.g., 5nm, 7nm, 14nm, 28nm, 65nm) used to fabricate this wafer lot. Determines the Process Design Kit (PDK), equipment set, and yield expectations. Critical for capacity planning and technology roadmap tracking.',
    `process_stage` STRING COMMENT 'High-level semiconductor fabrication stage classification: FEOL (Front End of Line) covers transistor formation; MOL (Middle of Line) covers local interconnects; BEOL (Back End of Line) covers metal interconnect layers. Used for WIP stage-gate reporting and cycle time decomposition.. Valid values are `FEOL|MOL|BEOL`',
    `route_version` STRING COMMENT 'Version identifier of the process route assigned to this lot. Tracks which revision of the process flow was active at lot start, supporting process change impact analysis and PCN (Product Change Notification) traceability.',
    `scrap_wafer_count` STRING COMMENT 'Cumulative number of wafers scrapped from this lot since lot creation. Includes wafers scrapped due to process excursions, equipment failures, or quality dispositions. Used for yield loss analysis and DPPM (Defective Parts Per Million) reporting.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this wafer lot record was sourced (e.g., CAMSTAR for Camstar MES, SMARTFACTORY for Applied Materials SmartFactory, SAP_PP for SAP Production Planning). Supports data lineage and multi-system reconciliation in the Databricks Silver layer.. Valid values are `CAMSTAR|SMARTFACTORY|SAP_PP|MANUAL`',
    `target_completion_date` DATE COMMENT 'Planned date by which the wafer lot is expected to complete all FAB process steps and be ready for wafer probe/test. Derived from the process flow cycle time and lot start date. Used for delivery commitment and capacity planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this wafer lot master record was last modified in the inventory data product. Represents the RECORD_AUDIT_UPDATED category for this TRANSACTION_HEADER entity. Used for incremental data pipeline processing and audit trail.',
    `valuation_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the inventory valuation amount (e.g., USD, EUR, JPY, TWD). Required for multi-currency financial reporting and SOX compliance.. Valid values are `^[A-Z]{3}$`',
    `wafer_count` STRING COMMENT 'The wafer count of the inventory wafer lot record in the inventory domain.',
    `wafer_count_current` STRING COMMENT 'Current number of wafers remaining in the lot after accounting for any scrapped or split wafers during processing. Reflects real-time WIP inventory quantity for this lot.',
    `wafer_count_start` STRING COMMENT 'Number of wafers in the lot at the time of lot creation (wafer start). Typically 25 wafers per FOUP/cassette for standard lots. Used as the baseline denominator for yield and scrap rate calculations. This is the QUANTITATIVE_RESULT / principal measured quantity for this WIP transaction.',
    `wafer_diameter_mm` STRING COMMENT 'Physical diameter of the silicon wafers in this lot, in millimeters. Standard values are 200mm (8-inch) and 300mm (12-inch). Determines equipment compatibility, cassette type, and cost per wafer.',
    CONSTRAINT pk_inventory_wafer_lot PRIMARY KEY(`inventory_wafer_lot_id`)
) COMMENT 'Master record for a wafer lot (batch of wafers) moving through the FAB as work-in-process inventory. Tracks lot ID, wafer count, process node, product code, lot type (production/engineering/qualification), priority class, current operation step, WIP status (active/hold/complete/scrapped), start date, target completion date, hold flags, cumulative scrap count, good wafer count, and MES lot reference. SSOT for WIP lot identity and traceability across FEOL, MOL, and BEOL process stages within the inventory domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` (
    `raw_material_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a raw material master record in the semiconductor inventory domain. Primary key for the raw_material product.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record within the raw material inventory entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Raw Material Quality Management designates an owner engineer for each material to ensure compliance with RoHS, REACH, and internal quality audits.',
    `storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Raw materials need a default storage location for receiving and replenishment workflows.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PROCUREMENT: Supplier of each raw material is required for qualification, lead‑time, and compliance tracking; experts expect a direct supplier_id FK.',
    `base_unit_of_measure` STRING COMMENT 'The primary unit of measure in which the raw material is stocked and consumed (e.g., EA for each wafer, KG for chemicals, L for liquids, M2 for photomasks). Corresponds to SAP MARA.MEINS (base unit of measure). [ENUM-REF-CANDIDATE: EA|KG|L|M2|M3|PC|SHT|BOX|DRUM|CYLINDER — 10 candidates stripped; promote to reference product]',
    `batch_managed` BOOLEAN COMMENT 'Indicates whether the raw material is managed at the batch/lot level in SAP inventory management. Batch management is mandatory for silicon wafers, photomasks, and shelf-life-controlled chemicals to enable full lot traceability from receipt through consumption. Corresponds to SAP MARA.XCHPF.',
    `cas_number` STRING COMMENT 'The unique CAS Registry Number assigned by the American Chemical Society to identify chemical substances. Mandatory for process chemicals, specialty gases, CMP slurries, and ALD precursors for REACH, RoHS, and TSCA regulatory compliance reporting.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `certificate_of_analysis_number` STRING COMMENT 'The certificate of analysis number of the raw material record in the inventory domain.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the raw material was manufactured or substantially transformed. Required for export control compliance (EAR/ITAR), customs declarations, and CHIPS Act domestic content tracking.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the raw material master record was first created in the system of record (SAP S/4HANA MM). Used for audit trail, data lineage, and compliance with SOX internal controls over financial reporting.',
    `discontinuation_date` DATE COMMENT 'Date on which the raw material is scheduled to be discontinued or reaches end-of-life (EOL). Triggers last-time-buy (LTB) procurement actions and product change notification (PCN) processes. Null if the material is not scheduled for discontinuation.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the raw material inventory record.',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number (ECCN) assigned under the US Export Administration Regulations (EAR) for dual-use materials. Required for export license determination for specialty chemicals, gases, and advanced materials used in semiconductor manufacturing.. Valid values are `^[0-9A-Z]{4,10}$`',
    `fixed_lot_qty` DECIMAL(18,2) COMMENT 'Fixed order quantity used when lot_size_type is fixed. Represents the standard purchase order quantity per replenishment cycle, often aligned with supplier minimum order quantities or packaging units. Corresponds to SAP MARC.BSTFE.',
    `hazard_classification` STRING COMMENT 'GHS/UN hazard classification of the raw material for safe storage, handling, and transport. Drives storage location assignment, PPE requirements, and emergency response procedures. [ENUM-REF-CANDIDATE: non_hazardous|flammable|corrosive|toxic|oxidizer|pyrophoric|compressed_gas|carcinogen — promote to reference product]',
    `hazardous_flag` BOOLEAN COMMENT 'The hazardous flag of the raw material record in the inventory domain.',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether incoming quality inspection (IQC) is mandatory upon goods receipt for this raw material. When true, received lots are placed in quality inspection stock in SAP QM before being released to unrestricted use. Corresponds to SAP MARC.QKZUL.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the raw material is subject to ITAR controls under the US Munitions List. ITAR-controlled materials require State Department licensing for export and impose strict access and handling restrictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the raw material master record. Supports change tracking, delta extraction for the Silver layer, and audit compliance. Corresponds to SAP MARA.LAEDA (last change date).',
    `lead_time_days` STRING COMMENT 'Planned procurement lead time in calendar days from purchase order placement to goods receipt. Used by SAP MRP for replenishment scheduling and safety stock calculations. Corresponds to SAP MARC.PLIFZ (planned delivery time).',
    `lot_number` STRING COMMENT 'The lot number of the raw material record in the inventory domain.',
    `lot_size_type` STRING COMMENT 'SAP MRP lot-sizing procedure that determines how replenishment quantities are calculated. fixed orders a fixed quantity, lot_for_lot orders exact requirement, min_max uses min/max boundaries, periodic groups requirements by period. Corresponds to SAP MARC.DISMM.. Valid values are `fixed|lot_for_lot|min_max|periodic`',
    `manufacturer_part_number` STRING COMMENT 'The original manufacturers part number for the raw material, which may differ from the supplier part number when the supplier is a distributor. Critical for photomasks, specialty chemicals, and ALD precursors where manufacturer identity affects process qualification.',
    `material_class` STRING COMMENT 'High-level classification of the raw material type used in semiconductor manufacturing. Drives storage, handling, and compliance rules. [ENUM-REF-CANDIDATE: silicon_wafer|photomask|process_chemical|specialty_gas|cmp_slurry|ald_precursor|packaging_material|other — promote to reference product]',
    `material_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the raw material in SAP S/4HANA MM (Material Master number / MATNR). Used across procurement, inventory, and manufacturing systems as the primary business identifier for the material.. Valid values are `^[A-Z0-9_-]{3,40}$`',
    `material_grade` STRING COMMENT 'The material grade of the raw material record in the inventory domain.',
    `material_group` STRING COMMENT 'SAP material group code (MARA.MATKL) used to categorize raw materials for procurement, reporting, and spend analytics. Examples: WAFER-SI, CHEM-ETCH, GAS-SPEC, MASK-EUV.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `material_name` STRING COMMENT 'Human-readable short description or name of the raw material (e.g., Silicon Wafer 300mm P-Type, HMDS Adhesion Promoter, ArF Photomask Layer 1). Corresponds to SAP MARA.MAKTX (material description).',
    `material_status` STRING COMMENT 'Current lifecycle status of the raw material master record. Controls whether the material can be procured, consumed in production, or is subject to end-of-life (EOL) restrictions. Aligns with SAP MARA.MMSTA (plant-level material status).. Valid values are `active|blocked|discontinued|under_qualification|obsolete|phase_out`',
    `material_type` STRING COMMENT 'The material type of the raw material record in the inventory domain.',
    `max_stock_qty` DECIMAL(18,2) COMMENT 'Maximum allowable inventory quantity for the raw material, used to prevent overstocking of hazardous materials, shelf-life-limited chemicals, or high-cost items. Corresponds to SAP MARC.MABST (maximum stock level).',
    `min_remaining_shelf_life_days` STRING COMMENT 'Minimum number of days of remaining shelf life required at the time of goods receipt for the material to be accepted into inventory. Materials received with less than this remaining shelf life are rejected or placed in restricted use. Corresponds to SAP MARA.MHDLP.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the raw material record in the inventory domain.',
    `moving_avg_price` DECIMAL(18,2) COMMENT 'Current moving average price per base unit of measure, recalculated with each goods receipt based on actual purchase prices. Used for inventory valuation under the moving average price control method. Corresponds to SAP MBEW.VERPR.',
    `price_control_type` STRING COMMENT 'Determines the inventory valuation method for the material: standard uses a fixed standard price, moving_average recalculates price with each goods movement. Corresponds to SAP MBEW.VPRSV (price control indicator: S or V).. Valid values are `standard|moving_average`',
    `price_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the standard price and moving average price fields (e.g., USD, EUR, JPY, TWD). Required for multi-currency financial reporting and SOX compliance.. Valid values are `^[A-Z]{3}$`',
    `purity_pct` DECIMAL(18,2) COMMENT 'Chemical purity of the raw material expressed as a percentage (e.g., 99.9999 for 6N-grade specialty gases, 99.99 for ultra-high-purity chemicals). Critical quality specification for process chemicals, specialty gases, and ALD precursors where trace contamination causes yield loss.',
    `purity_percent` DECIMAL(18,2) COMMENT 'The purity percent of the raw material record in the inventory domain.',
    `qualification_status` STRING COMMENT 'Process qualification status of the raw material indicating whether it has been approved for use in production. Materials must pass incoming quality inspection and process qualification before being released for fab consumption. Managed in Oracle Agile PLM and SAP QM.. Valid values are `qualified|in_qualification|conditionally_approved|disqualified|not_evaluated`',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The quantity on hand of the raw material record in the inventory domain.',
    `raw_material_status` STRING COMMENT 'The status of the raw material record in the inventory domain.',
    `reach_svhc_flag` BOOLEAN COMMENT 'Indicates whether the raw material contains or is classified as a Substance of Very High Concern (SVHC) under the EU REACH Regulation. Triggers mandatory disclosure obligations when SVHC concentration exceeds 0.1% w/w in articles.',
    `receipt_date` DATE COMMENT 'The receipt date associated with the raw material inventory record.',
    `received_date` DATE COMMENT 'The received date associated with the raw material inventory record.',
    `reorder_point_qty` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment purchase requisition is automatically triggered in SAP MRP. When on-hand stock falls to or below this quantity, procurement is initiated to prevent production line stoppages. Corresponds to SAP MARC.MINBE (reorder point).',
    `resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'Electrical resistivity of the silicon wafer substrate in Ohm·cm, indicating doping concentration and conductivity type. Critical specification for FEOL process compatibility and device electrical performance. Null for non-wafer materials.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the raw material complies with the EU RoHS Directive (2011/65/EU) restricting the use of hazardous substances including lead, mercury, cadmium, hexavalent chromium, PBB, and PBDE. Required for materials used in products shipped to EU markets.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Minimum buffer stock quantity maintained to protect against supply disruptions, demand variability, and supplier lead time uncertainty. Represents the floor below which inventory should not fall under normal operating conditions. Corresponds to SAP MARC.EISBE (safety stock).',
    `serialized` BOOLEAN COMMENT 'Indicates whether individual units of the raw material are tracked by unique serial number. Applicable to high-value items such as photomasks and reticles where individual unit traceability is required for defect root cause analysis and reticle qualification tracking.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the raw material can be stored from the date of manufacture or receipt before it is considered expired and must be quarantined or disposed of. Critical for photoresists, ALD precursors, and specialty chemicals with time-sensitive stability. Corresponds to SAP MARA.MHDRZ (shelf life in days).',
    `standard_price` DECIMAL(18,2) COMMENT 'Standard cost price per base unit of measure used for inventory valuation in SAP CO (Controlling) and FI (Financial Accounting). Used for WIP costing, variance analysis, and financial reporting. Corresponds to SAP MBEW.STPRS (standard price).',
    `storage_condition` STRING COMMENT 'Categorical storage environment required for the raw material. Drives warehouse location assignment and storage area classification. Examples: cleanroom for bare silicon wafers, refrigerated for certain photoresists, nitrogen_purge for moisture-sensitive ALD precursors. [ENUM-REF-CANDIDATE: ambient|refrigerated|frozen|cleanroom|nitrogen_purge|dark_storage|fireproof_cabinet — 7 candidates stripped; promote to reference product]',
    `storage_humidity_max_pct` DECIMAL(18,2) COMMENT 'Maximum allowable relative humidity percentage for storage of the raw material. Particularly critical for silicon wafers, photomasks, and hygroscopic chemicals where moisture exposure causes defects or degradation.',
    `storage_temp_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for the raw material. Exceeding this threshold may degrade material quality, trigger safety hazards, or invalidate process qualification. Used for warehouse environmental compliance monitoring.',
    `storage_temp_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius for the raw material. Used to configure environmental monitoring alerts in the warehouse management system and ensure compliance with material safety data sheet (SDS) requirements.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'The storage temperature c of the raw material record in the inventory domain.',
    `supplier_part_number` STRING COMMENT 'The part number or catalog number assigned by the primary supplier to this raw material. Used for purchase order creation, supplier communication, and incoming inspection cross-referencing. Stored in SAP INFO record (EINE.IDNLF).',
    `unit_cost_usd` DECIMAL(18,2) COMMENT 'The unit cost usd of the raw material record in the inventory domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the raw material record in the inventory domain.',
    `wafer_diameter_mm` DECIMAL(18,2) COMMENT 'Nominal diameter of the silicon wafer in millimeters (e.g., 200.0 for 8-inch, 300.0 for 12-inch). Applicable only to silicon wafer material class. Critical for process tool compatibility and fab line qualification. Null for non-wafer materials.',
    `wafer_type` STRING COMMENT 'Specifies the silicon wafer substrate type: bare_silicon (polished CZ), epitaxial (epi-layer deposited), soi (Silicon-on-Insulator), fz (Float Zone), or cz (Czochralski). Determines process compatibility and electrical characteristics. Null for non-wafer materials.. Valid values are `bare_silicon|epitaxial|soi|fz|cz`',
    CONSTRAINT pk_raw_material PRIMARY KEY(`raw_material_id`)
) COMMENT 'Master record for raw materials consumed in semiconductor manufacturing including silicon wafers (bare and epitaxial), process chemicals, specialty gases, photomasks, CMP slurries, and ALD precursors. Captures material code, description, material class, unit of measure, supplier part number, shelf life, storage temperature range, hazard classification (RoHS/REACH), reorder point, and safety stock level. SSOT for raw material identity in the inventory domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` (
    `finished_good_id` BIGINT COMMENT 'Unique surrogate identifier for the finished good master record in the inventory system. Primary key for the finished_good data product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Needed for Order Fulfillment process to associate shipped finished goods with the purchasing customer account for invoicing and compliance.',
    `assembly_lot_id` BIGINT COMMENT 'Unique identifier for the assembly lot record within the finished good inventory entity.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Finished goods must be associated with product certifications to satisfy regulatory audits and customer qualification requirements.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - finished goods are manufactured on specific nodes',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the finished good inventory entity.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Linking finished goods to their design project supports warranty tracking and post‑sale support processes.',
    `osat_vendor_id` BIGINT COMMENT 'Reference to the Outsourced Semiconductor Assembly and Test (OSAT) partner responsible for packaging and assembly of this finished good. Used for consignment stock tracking and supplier quality management.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Finished‑Good Release process mandates an engineer to approve product release, linking the lot to the responsible employee for regulatory traceability.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU catalog entry in the product domain that defines the commercial product specification for this finished good.',
    `storage_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where this finished good inventory is physically held, including OSAT consignment locations.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Finished‑good traceability to the originating tapeout is needed for quality audits and regulatory compliance.',
    `aec_q_qualified` BOOLEAN COMMENT 'Indicates whether the finished good has been qualified to AEC-Q100 (IC), AEC-Q101 (discrete), or AEC-Q200 (passive) automotive reliability standards. Required for automotive supply chain design-in.',
    `bin_code` STRING COMMENT 'Test bin classification code assigned during wafer sort or final test indicating the performance and quality tier of the die/device. Bin codes map to specific product SKUs and determine commercial grade.. Valid values are `^[A-Z0-9]{1,10}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the finished good was manufactured or substantially transformed. Required for customs declarations, trade compliance, and preferential tariff determination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finished good master record was first created in the inventory system. Audit trail field for data governance and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard cost and inventory valuation of this finished good (e.g., USD, EUR, TWD).. Valid values are `^[A-Z]{3}$`',
    `date_code` STRING COMMENT 'Manufacturing date code in YYWW format (year + work week) indicating when the device was assembled and packaged. Used for shelf life tracking, lot traceability, and field failure analysis.. Valid values are `^d{4}[0-5]d$`',
    `device_marking` STRING COMMENT 'Alphanumeric marking laser-inscribed or printed on the physical package surface. Includes part number, speed grade, temperature grade, and manufacturer code. Used for traceability and counterfeit detection.',
    `device_type` STRING COMMENT 'Classification of the semiconductor device type. Indicates whether the finished good is an Integrated Circuit (IC), System on Chip (SoC), Application-Specific Integrated Circuit (ASIC), Field-Programmable Gate Array (FPGA), discrete device, or other category. [ENUM-REF-CANDIDATE: IC|SoC|ASIC|FPGA|Discrete|MCU|DSP|PMIC|Memory|RF|Sensor|Analog — promote to reference product]',
    `dppm_target` DECIMAL(18,2) COMMENT 'Quality target expressed as Defective Parts Per Million (DPPM) for outgoing quality of this finished good. Used in customer quality agreements and SPC monitoring. Automotive-grade typically requires <10 DPPM.',
    `eccn_number` STRING COMMENT 'Export Control Classification Number (ECCN) assigned under the US Export Administration Regulations (EAR) administered by BIS. Determines export licensing requirements and restricted country applicability. Sensitive for trade compliance purposes.. Valid values are `^[0-9][A-Z][0-9]{3}.[a-z]$`',
    `eol_date` DATE COMMENT 'Announced End of Life (EOL) date after which the finished good will no longer be manufactured or sold. Triggers Last Time Buy (LTB) notifications to customers per JEDEC JESD48 standard.',
    `expiration_date` DATE COMMENT 'The expiration date associated with the finished good inventory record.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the finished good inventory record.',
    `finished_good_status` STRING COMMENT 'The status of the finished good record in the inventory domain.',
    `hold_flag` BOOLEAN COMMENT 'The hold flag of the finished good record in the inventory domain.',
    `hts_code` STRING COMMENT 'Harmonized Tariff Schedule (HTS) classification code used for customs declaration, import/export duty determination, and trade statistics reporting. Follows the 10-digit US HTS format.. Valid values are `^d{4}.d{2}.d{4}$`',
    `inventory_status` STRING COMMENT 'Current inventory disposition status of the finished good lot. available indicates unrestricted stock; quarantine indicates pending quality review; reserved indicates allocated to an order; consignment indicates stock held at OSAT or customer site; hold indicates engineering or compliance hold.. Valid values are `available|quarantine|reserved|consignment|scrapped|hold`',
    `inventory_valuation_method` STRING COMMENT 'Accounting method used to value this finished good inventory in the general ledger. standard = standard cost; moving_average = moving average price (MAP); fifo = First In First Out; lifo = Last In First Out.. Valid values are `standard|moving_average|fifo|lifo`',
    `inventory_value_usd` DECIMAL(18,2) COMMENT 'The inventory value usd of the finished good record in the inventory domain.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the finished good is subject to International Traffic in Arms Regulations (ITAR) controls administered by the US State Department DDTC. ITAR-controlled items require specific export licenses and handling procedures.',
    `kgd_status` BOOLEAN COMMENT 'Indicates whether the die used in this finished good has been verified as a Known Good Die (KGD) through wafer-level testing prior to packaging. Critical for advanced packaging (CoWoS, InFO, chiplet) and high-reliability applications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the finished good record in the inventory domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finished good master record. Used for change data capture (CDC), data lineage tracking, and audit compliance.',
    `lifecycle_status` STRING COMMENT 'Commercial lifecycle stage of the finished good. active = in production and available; nrnd = Not Recommended for New Designs; eol = End of Life (EOL) announced; ltb = Last Time Buy (LTB) window open; discontinued = no longer available.. Valid values are `active|nrnd|eol|ltb|discontinued`',
    `lot_number` STRING COMMENT 'The lot number of the finished good record in the inventory domain.',
    `lot_status` STRING COMMENT 'The lot status of the finished good record in the inventory domain.',
    `lot_traceability_code` STRING COMMENT 'Unique lot or batch identifier linking the finished good back to the wafer fabrication lot, enabling full forward and backward traceability through the manufacturing supply chain. Aligns with Camstar MES lot number.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `manufacture_date` DATE COMMENT 'The manufacture date associated with the finished good inventory record.',
    `manufacturing_date` DATE COMMENT 'The manufacturing date associated with the finished good inventory record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the finished good record in the inventory domain.',
    `moisture_sensitivity_level` STRING COMMENT 'The moisture sensitivity level of the finished good record in the inventory domain.',
    `msd_level` STRING COMMENT 'Moisture Sensitivity Level (MSL) classification per IPC/JEDEC J-STD-020 indicating the devices sensitivity to ambient moisture during storage and handling. Level 1 = unlimited floor life; Level 6 = must be baked immediately before use. [ENUM-REF-CANDIDATE: 1|2|2a|3|4|5|5a|6 — 8 candidates stripped; promote to reference product]',
    `package_body_size_mm` STRING COMMENT 'Physical body dimensions of the semiconductor package expressed as length x width in millimeters (e.g., 10x10, 5.5x5.5). Used for PCB design, handling equipment setup, and storage tray selection.. Valid values are `^d+(.d+)?xd+(.d+)?$`',
    `package_type` STRING COMMENT 'Physical semiconductor package format of the finished good (e.g., Ball Grid Array (BGA), Quad Flat No-lead (QFN), Wafer-Level Chip Scale Package (WLCSP), Chip on Wafer on Substrate (CoWoS), Integrated Fan-Out (InFO)). Determines handling, PCB footprint, and storage requirements. [ENUM-REF-CANDIDATE: BGA|QFN|QFP|WLCSP|CoWoS|InFO|LGA|DIP|SOP|CSP|FCBGA|PGA — promote to reference product]',
    `packaging_type` STRING COMMENT 'The packaging type of the finished good record in the inventory domain.',
    `pcn_reference` STRING COMMENT 'Reference number of the most recent Product Change Notification (PCN) affecting this finished good. PCNs document changes to materials, processes, or package that may impact customer qualification status.',
    `pin_count` STRING COMMENT 'Total number of electrical pins, balls, or leads on the finished good package. Critical for PCB design compatibility, socket selection, and ATE (Automatic Test Equipment) configuration.',
    `product_family` STRING COMMENT 'Product family grouping to which this finished good belongs (e.g., high-performance compute SoC family, automotive microcontroller family). Used for portfolio reporting and demand planning.',
    `qualification_status` STRING COMMENT 'Current product qualification status indicating whether the finished good has passed all required reliability and quality qualification tests for its target market segment (consumer, industrial, automotive, military).. Valid values are `qualified|in_qualification|conditionally_qualified|not_qualified|requalification_required`',
    `quality_disposition` STRING COMMENT 'The quality disposition of the finished good record in the inventory domain.',
    `quality_status` STRING COMMENT 'The quality status of the finished good record in the inventory domain.',
    `quantity` STRING COMMENT 'The quantity of the finished good record in the inventory domain.',
    `quantity_on_hand` STRING COMMENT 'Current physical inventory quantity of this finished good in units (individual packaged devices). Reflects unrestricted stock available for order fulfillment as tracked in SAP MM inventory management.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the finished good complies with EU REACH Regulation (EC No 1907/2006) regarding chemical substance safety, including absence of Substances of Very High Concern (SVHC) above threshold concentrations.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the finished good complies with the EU RoHS Directive (2011/65/EU) restricting use of hazardous substances including lead, mercury, cadmium, and hexavalent chromium in electronic equipment.',
    `serial_number` STRING COMMENT 'The serial number of the finished good record in the inventory domain.',
    `shelf_life_days` STRING COMMENT 'Maximum allowable storage duration in days from the manufacturing date before the finished good must be baked, re-qualified, or scrapped. Particularly relevant for moisture-sensitive devices (MSD) per IPC/JEDEC J-STD-033.',
    `shelf_life_expiry_date` DATE COMMENT 'Calculated date on which the shelf life of this finished good lot expires, derived from the manufacturing date code plus shelf life days. Triggers re-bake or scrap workflow in SAP MM.',
    `speed_grade` STRING COMMENT 'Performance speed grade or frequency bin classification of the finished good (e.g., -1, -2, 3.0GHz, 800MHz). Determined during wafer sort and final test binning. Differentiates product variants within the same die.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of the finished good in the functional currency as maintained in SAP CO (Controlling) for inventory valuation, cost of goods sold calculation, and variance analysis.',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'The standard cost usd of the finished good record in the inventory domain.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for this finished good. Exceeding this threshold may degrade device reliability or void qualification. Used to configure warehouse environmental monitoring alerts.',
    `temperature_grade` STRING COMMENT 'Operating temperature range classification of the finished good. commercial (0°C to 70°C), industrial (-40°C to 85°C), automotive (-40°C to 125°C/150°C per AEC-Q100), military (-55°C to 125°C), extended for specialized ranges.. Valid values are `commercial|industrial|automotive|military|extended`',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for inventory counting of the finished good. EA = each (individual device); TRAY = JEDEC tray; REEL = tape-and-reel; TUBE = tube/stick packaging; BOX = bulk box.. Valid values are `EA|TRAY|REEL|TUBE|BOX`',
    CONSTRAINT pk_finished_good PRIMARY KEY(`finished_good_id`)
) COMMENT 'Master record for packaged semiconductor finished goods held in inventory including ICs, SoCs, ASICs, FPGAs, and discrete devices in final package form. Tracks SKU, product family, package type (WLCSP, BGA, QFN, CoWoS), device marking, date code, lot traceability code, HTS classification, RoHS compliance status, ECCN number for export control, and shelf life. Links to product domain SKU catalog.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` (
    `die_bank_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the die bank inventory record. Primary key for the die_bank data product.',
    `device_architecture_id` BIGINT COMMENT 'Foreign key linking to research.device_architecture. Business justification: Die banks are allocated per device architecture; link supports the Die Bank Allocation per Architecture operational dashboard.',
    `storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Die banks in waffle/gel packs must track their physical storage location for retrieval and environmental compliance.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Die banks contain IP that may be subject to ECCN rules; linking enables tracking of classification per bank for export compliance.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the fabrication facility (FAB) where the parent wafer lot was manufactured. Supports multi-fab sourcing analysis and compliance traceability.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - die banks are technology node specific',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the originating wafer lot from which these dies were singulated. Provides full traceability from die bank back to fabrication lot in Camstar MES and SAP PP.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Needed for Die Bank Allocation and Yield Reporting, tying each die bank to the specific IC catalog it supports; removes denormalized product_code/name.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Die‑bank inventory is tracked per design project for yield analysis and customer yield reporting.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the inventory wafer lot record within the die bank inventory entity.',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW shuttle run if the parent wafer lot was fabricated as part of a multi-project wafer program. Null for dedicated production wafer lots.',
    `osat_vendor_id` BIGINT COMMENT 'Reference to the OSAT partner at whose facility this die bank is held as consignment stock, if applicable. Null if stored at internal warehouse.',
    `primary_die_storage_location_id` BIGINT COMMENT 'Reference to the physical storage location (warehouse bin, cold storage unit, or OSAT vault) where the die bank is currently stored. Managed in SAP WM/EWM.',
    `probe_card_id` BIGINT COMMENT 'Identifier of the probe card used during wafer sort for the parent wafer lot. Enables correlation of test results to probe card condition and supports yield excursion root cause analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Die Bank Inventory must record the responsible engineer who authorizes releases and handles quality holds, supporting compliance audits.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the die bank inventory entity.',
    `aging_days` STRING COMMENT 'The aging days of the die bank record in the inventory domain.',
    `available_quantity` STRING COMMENT 'The available quantity of the die bank record in the inventory domain.',
    `bank_code` STRING COMMENT 'Coded value representing the bank code of the die bank inventory record.',
    `bank_status` STRING COMMENT 'The bank status of the die bank record in the inventory domain.',
    `bin_class` BIGINT COMMENT 'FK to inventory.bin_classification.bin_classification_id — Every die bank entry is classified by bin (speed grade, power class, pass/fail). This FK drives KGD allocation and customer shipment decisions.',
    `bin_classification` STRING COMMENT 'Electrical test bin classification assigned during wafer probe/sort (e.g., Bin1=Full-speed pass, Bin2=Speed-binned, Bin3=Partial-function, Bin99=Fail). Determines product grade, pricing tier, and eligible end markets. [ENUM-REF-CANDIDATE: bin1|bin2|bin3|bin4|bin5|bin6|bin99|scrap — promote to reference product]',
    `carrier_type` STRING COMMENT 'Physical carrier medium in which the singulated dies are stored (e.g., waffle pack, gel pack, tape-and-reel, JEDEC tray). Determines handling requirements, automated pick-and-place compatibility, and storage density.. Valid values are `waffle_pack|gel_pack|tape_and_reel|tray|bare_die`',
    `die_bank_code` STRING COMMENT 'Human-readable, externally-known unique business identifier for the die bank lot, used in MES, ERP, and OSAT partner communications. Follows internal lot numbering conventions.. Valid values are `^DB-[A-Z0-9]{4,12}-[0-9]{4,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this die bank record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit cost and inventory valuation of this die bank (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `date_code` STRING COMMENT 'Coded value representing the date code of the die bank inventory record.',
    `die_bank_status` STRING COMMENT 'Current lifecycle status of the die bank inventory record. Available indicates dies are ready for allocation; Reserved indicates committed to an order; Consumed indicates fully used in packaging; Quarantined indicates hold pending quality investigation; Scrapped indicates disposed; Expired indicates shelf life exceeded.. Valid values are `available|reserved|consumed|quarantined|scrapped|expired`',
    `die_count` STRING COMMENT 'The die count of the die bank record in the inventory domain.',
    `die_part_number` STRING COMMENT 'The die part number of the die bank record in the inventory domain.',
    `die_quantity` STRING COMMENT 'The die quantity of the die bank record in the inventory domain.',
    `die_revision` STRING COMMENT 'Silicon revision or stepping identifier for the die (e.g., A0, B1, C2). Tracks design iterations post-tapeout; critical for distinguishing engineering samples from production silicon.. Valid values are `^[A-Z][0-9]{0,2}$`',
    `die_size_mm2` DECIMAL(18,2) COMMENT 'Physical area of a single die in square millimeters. Critical for packaging selection, cost-per-die calculations, and wafer yield modeling.',
    `die_value_usd` DECIMAL(18,2) COMMENT 'The die value usd of the die bank record in the inventory domain.',
    `disposition_status` STRING COMMENT 'The disposition status of the die bank record in the inventory domain.',
    `entry_date` DATE COMMENT 'The entry date associated with the die bank inventory record.',
    `esd_sensitivity_class` STRING COMMENT 'JEDEC Human Body Model (HBM) or Charged Device Model (CDM) ESD sensitivity classification for the dies. Determines handling precautions, packaging requirements, and ESD-protected area (EPA) storage mandates.. Valid values are `HBM_0|HBM_1A|HBM_1B|HBM_1C|HBM_2|CDM_C1`',
    `expiry_date` DATE COMMENT 'Calculated date on which the die bank shelf life expires, based on creation date plus shelf_life_days under specified storage conditions. After this date, dies require re-qualification before use.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) assigned to this die product. Determines export license requirements and restricted country applicability under BIS/EAR and ITAR.',
    `good_die_count` STRING COMMENT 'The good die count of the die bank record in the inventory domain.',
    `hold_flag` BOOLEAN COMMENT 'The hold flag of the die bank record in the inventory domain.',
    `inventory_valuation_method` STRING COMMENT 'Accounting method used to value this die bank inventory in the ERP system (e.g., Standard Cost, Moving Average Price, FIFO, LIFO). Determines how cost of goods sold is calculated upon consumption.. Valid values are `standard_cost|moving_average|fifo|lifo`',
    `inventory_value_usd` DECIMAL(18,2) COMMENT 'The inventory value usd of the die bank record in the inventory domain.',
    `is_consignment` BOOLEAN COMMENT 'Indicates whether this die bank is held as consignment stock at an OSAT partner or customer site (True) versus owned and stored at an internal facility (False). Affects inventory ownership, liability, and financial reporting.',
    `is_engineering_sample` BOOLEAN COMMENT 'Indicates whether the dies in this bank are engineering samples (True) or production-qualified silicon (False). Engineering samples may have restricted use, limited warranty, and different pricing terms.',
    `kgd_certified_flag` BOOLEAN COMMENT 'The kgd certified flag of the die bank record in the inventory domain.',
    `kgd_flag` BOOLEAN COMMENT 'The kgd flag of the die bank record in the inventory domain.',
    `kgd_status` STRING COMMENT 'Known Good Die (KGD) certification status indicating whether the dies in this bank have passed all required electrical and functional tests and are certified for packaging or direct shipment. Certified dies meet full production test specifications.. Valid values are `certified|pending|rejected|conditionally_approved`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical or visual inspection of the die bank, including carrier integrity check, quantity verification, and storage condition audit. Required for periodic quality surveillance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the die bank record in the inventory domain.',
    `lot_origin` BIGINT COMMENT 'FK to inventory.wafer_lot.wafer_lot_id — Die banks trace back to their source wafer lot for genealogy and quality traceability. Critical for IATF 16949.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the die bank record in the inventory domain.',
    `moisture_sensitivity_level` STRING COMMENT 'JEDEC/IPC Moisture Sensitivity Level classification for the dies, indicating how sensitive the package or die is to ambient moisture and the required floor life before reflow. Governs dry-pack and bake-out requirements.. Valid values are `MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5`',
    `process_node` STRING COMMENT 'Semiconductor fabrication process technology node at which the dies were manufactured (e.g., 5nm, 7nm, 28nm, 65nm). Critical for yield benchmarking, packaging compatibility, and customer qualification.',
    `quality_hold_reason` STRING COMMENT 'Free-text or coded reason for placing this die bank on quality hold or quarantine status. Populated when die_bank_status is quarantined. Examples: parametric excursion, contamination event, ESD damage suspected.',
    `quantity_available` STRING COMMENT 'Current count of dies available for allocation or shipment in this die bank record. Decremented upon reservation or consumption. Expressed in units of individual dies.',
    `quantity_initial` STRING COMMENT 'Original count of dies placed into this die bank at the time of creation, before any consumption, scrap, or reservation. Used as the baseline for yield and consumption tracking.',
    `quantity_reserved` STRING COMMENT 'Count of dies in this die bank that are currently reserved against open orders or packaging work orders but not yet physically consumed. Supports ATP (Available-to-Promise) calculations.',
    `quantity_scrapped` STRING COMMENT 'Cumulative count of dies from this die bank that have been scrapped due to handling damage, quality failures, or shelf life expiry. Used for loss tracking and yield analysis.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the die and carrier materials comply with EU REACH Regulation (Registration, Evaluation, Authorisation and Restriction of Chemicals), confirming no SVHC (Substances of Very High Concern) above threshold.',
    `reserved_quantity` STRING COMMENT 'The reserved quantity of the die bank record in the inventory domain.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the dies and their carrier materials comply with the EU RoHS Directive (Restriction of Hazardous Substances), restricting lead, mercury, cadmium, and other hazardous materials. Required for EU market access.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the dies can be stored under specified conditions before they are considered expired and require re-qualification or scrap. Drives FEFO (First Expired First Out) inventory rotation.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The standard cost of the die bank record in the inventory domain.',
    `storage_form` STRING COMMENT 'The storage form of the die bank record in the inventory domain.',
    `storage_humidity_max_pct` DECIMAL(18,2) COMMENT 'Maximum allowable relative humidity percentage for storage of this die bank. Moisture-sensitive dies require controlled humidity to prevent MSL (Moisture Sensitivity Level) violations.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for this die bank. Exceeding this limit risks solder bump oxidation, adhesive degradation, or ESD damage.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius for this die bank. Violations may cause electrostatic or material degradation. Enforced by warehouse management system.',
    `tapeout_version` STRING COMMENT 'Identifier of the tapeout submission (GDSII release version) from which the wafers in this die bank were fabricated. Enables traceability back to the design release in EDA and PLM systems.',
    `test_program_version` STRING COMMENT 'Version identifier of the ATE (Automatic Test Equipment) test program used during wafer probe/sort to classify and bin the dies in this die bank. Critical for test traceability and re-test qualification.',
    `total_die_count` BIGINT COMMENT 'The total die count of the die bank record in the inventory domain.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard or moving average cost per individual die in the die bank, expressed in the functional currency. Used for inventory valuation, cost of goods sold, and transfer pricing to OSAT partners.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this die bank record in the data platform. Used for change tracking, incremental ETL, and audit compliance.',
    `wafer_count` STRING COMMENT 'The wafer count of the die bank record in the inventory domain.',
    `wafer_form` STRING COMMENT 'The wafer form of the die bank record in the inventory domain.',
    `wafer_probe_yield_pct` DECIMAL(18,2) COMMENT 'Electrical test yield percentage from wafer probe/sort for the parent wafer lot, representing the fraction of dies that passed all probe tests. Expressed as a decimal percentage (e.g., 92.5000). Used for cost modeling and quality benchmarking.',
    `creation_date` DATE COMMENT 'Business date on which this die bank record was created, representing when the singulated dies were formally received into die bank inventory following wafer dicing and initial inspection.',
    CONSTRAINT pk_die_bank PRIMARY KEY(`die_bank_id`)
) COMMENT 'Master record for die bank inventory — singulated known-good dies (KGD) stored in waffle packs, gel packs, or tape-and-reel awaiting packaging or direct shipment. Tracks die bank ID, product code, process node, die revision, KGD certification status, bin classification, quantity available, storage location, storage temperature, wafer lot origin, tapeout version, and die bank creation date. Critical for fabless and OSAT-model inventory management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` (
    `photomask_asset_id` BIGINT COMMENT 'Primary key for photomask_asset',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Photomask Custody Tracking logs the employee with physical custody of each mask to meet EHS and export‑control compliance.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the IC design project for which this photomask was created. Links the mask asset to the product design domain for end-to-end traceability from design intent to physical mask.',
    `mask_set_id` BIGINT COMMENT 'Unique identifier for the mask set record within the photomask asset inventory entity.',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) version under which this mask was designed and qualified. Ensures mask-process compatibility and supports PDK version change impact analysis.',
    `photomask_id` BIGINT COMMENT 'Externally-known unique identifier assigned to the photomask by the mask vendor or internal mask management system. Used for cross-system traceability and vendor communication.',
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the photomask storage location record within the photomask asset inventory entity.',
    `primary_storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — High-value photomasks must track their storage location for retrieval and environmental control.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PHOTOMASK PROCUREMENT: Mask vendor is a supplier; linking enables vendor performance, cost, and compliance reporting.',
    `tapeout_experiment_id` BIGINT COMMENT 'Foreign key linking to research.tapeout_experiment. Business justification: Tapeout experiments must record assigned photomasks; this FK enables the Tapeout Mask Allocation compliance report.',
    `tapeout_id` BIGINT COMMENT 'Reference to the tapeout record that generated the GDS/GDSII data used to manufacture this photomask. Links the mask asset to the design domain for full design-to-fab traceability.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'The acquisition cost of the photomask asset record in the inventory domain.',
    `acquisition_cost_usd` DECIMAL(18,2) COMMENT 'The acquisition cost usd of the photomask asset record in the inventory domain.',
    `acquisition_date` DATE COMMENT 'The acquisition date associated with the photomask asset inventory record.',
    `asset_code` STRING COMMENT 'Coded value representing the asset code of the photomask asset inventory record.',
    `asset_number` STRING COMMENT 'The asset number of the photomask asset record in the inventory domain.',
    `asset_status` STRING COMMENT 'The asset status of the photomask asset record in the inventory domain.',
    `asset_valuation_usd` DECIMAL(18,2) COMMENT 'Financial book value of the photomask asset in US dollars as recorded in the fixed asset or inventory valuation module. EUV masks can cost $500K–$1M+; DUV masks range from $10K–$100K. Used for inventory valuation, depreciation, and insurance purposes.',
    `asset_value_usd` DECIMAL(18,2) COMMENT 'The asset value usd of the photomask asset record in the inventory domain.',
    `blank_material` STRING COMMENT 'The blank material of the photomask asset record in the inventory domain.',
    `cd_uniformity_nm` DECIMAL(18,2) COMMENT 'Measured critical dimension (CD) uniformity across the mask in nanometers, as determined during mask inspection. A key quality metric indicating pattern fidelity; tighter CD uniformity is required at advanced nodes.',
    `cleaning_count` STRING COMMENT 'The cleaning count of the photomask asset record in the inventory domain.',
    `condition_status` STRING COMMENT 'The condition status of the photomask asset record in the inventory domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this photomask asset record was first created in the inventory management system. Provides audit trail for record provenance.',
    `defect_count` STRING COMMENT 'Total number of defects detected on the photomask surface during the most recent inspection cycle. Compared against the maximum allowable defect specification to determine pass/fail disposition. Tracked per KLA ICOS inspection records.',
    `defect_inspection_status` STRING COMMENT 'The defect inspection status of the photomask asset record in the inventory domain.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility (FAB) where this photomask is assigned for use. A mask may be qualified for use at a specific fab site due to equipment compatibility and process qualification requirements.',
    `inspection_status` STRING COMMENT 'Result of the most recent mask inspection performed by metrology equipment (e.g., KLA ICOS). Indicates whether the mask meets defect density and CD uniformity specifications for continued production use.. Valid values are `pass|fail|conditional_pass|pending|not_inspected`',
    `is_mpw_mask` BOOLEAN COMMENT 'Indicates whether this photomask was manufactured as part of a Multi-Project Wafer (MPW) shuttle run, where multiple designs share a single mask set to reduce NRE costs. MPW masks have shared ownership and usage constraints.',
    `itar_controlled_flag` BOOLEAN COMMENT 'The itar controlled flag of the photomask asset record in the inventory domain.',
    `last_inspection_date` DATE COMMENT 'Date on which the most recent mask inspection was performed using metrology equipment (e.g., KLA ICOS). Used to schedule next inspection interval and assess mask health currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this photomask asset record. Used for change tracking, data lineage, and audit compliance.',
    `last_used_date` DATE COMMENT 'The last used date associated with the photomask asset inventory record.',
    `layer_name` STRING COMMENT 'Name of the photolithography process layer this mask patterns (e.g., POLY, METAL1, VIA2, DIFFUSION). Identifies the specific fabrication step in the FEOL/MOL/BEOL stack.',
    `lithography_type` STRING COMMENT 'Classification of the lithography exposure technology for which this mask is designed. Extreme Ultraviolet (EUV) masks are used for sub-7nm nodes; Deep Ultraviolet (DUV) masks are used for 7nm and above. Drives storage, handling, and cost classification.. Valid values are `EUV|DUV|i-line|g-line`',
    `manufacture_date` DATE COMMENT 'Date on which the photomask was manufactured and released by the mask vendor. Used for age-based shelf life tracking and vendor lead time analysis.',
    `mask_asset_code` STRING COMMENT 'Coded value representing the mask asset code of the photomask asset inventory record.',
    `mask_generation` STRING COMMENT 'Version or generation identifier of the mask corresponding to the tapeout revision (e.g., v1.0, v2.1, ECO_rev3). Tracks which design tapeout iteration this mask was manufactured from, enabling traceability to the GDS/GDSII submission.',
    `mask_layer` STRING COMMENT 'The mask layer of the photomask asset record in the inventory domain.',
    `mask_serial_number` STRING COMMENT 'The mask serial number of the photomask asset record in the inventory domain.',
    `mask_size_mm` DECIMAL(18,2) COMMENT 'Physical size of the photomask substrate in millimeters (e.g., 152mm for standard 6-inch reticle). Determines compatibility with the lithography scanner chuck and handling equipment.',
    `mask_status` STRING COMMENT 'Current lifecycle status of the photomask asset. Active masks are available for production use; quarantined masks are held pending defect review; retired masks have exceeded usage limits or been superseded; scrapped masks have been physically destroyed. [ENUM-REF-CANDIDATE: active|quarantined|retired|in_inspection|pending_qualification|scrapped — promote to reference product]. Valid values are `active|quarantined|retired|in_inspection|pending_qualification|scrapped`',
    `mask_substrate_material` STRING COMMENT 'Material of the photomask substrate. Fused silica and quartz are standard for DUV masks; Low Thermal Expansion Material (LTEM) and Ultra-Low Expansion (ULE) glass are used for EUV masks to minimize thermal distortion.. Valid values are `fused_silica|quartz|LTEM|ULE`',
    `mask_type` STRING COMMENT 'Physical mask type classification: binary (chrome-on-glass), attenuated phase-shifting mask (attPSM), alternating phase-shifting mask (altPSM), chromeless phase lithography (CPL), or EUV reflective mask. Determines optical proximity correction (OPC) strategy and imaging performance.. Valid values are `binary|attPSM|altPSM|CPL|EUV`',
    `max_defect_limit` STRING COMMENT 'Specification-defined maximum number of defects permitted on the photomask before it must be quarantined or retired. Established during mask qualification per process node requirements.',
    `max_usage_count` STRING COMMENT 'The max usage count of the photomask asset record in the inventory domain.',
    `max_usage_limit` STRING COMMENT 'Manufacturer- or process-qualified maximum number of exposure shots allowed before mandatory retirement or re-qualification of the photomask. Exceeding this limit triggers automatic quarantine in the MES.',
    `meef_value` DECIMAL(18,2) COMMENT 'Mask Error Enhancement Factor (MEEF) quantifying how mask CD (critical dimension) errors are amplified onto the wafer. A MEEF > 1 indicates that mask errors are magnified; used in process window analysis and mask specification setting.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the photomask asset record in the inventory domain.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The net book value of the photomask asset record in the inventory domain.',
    `net_book_value_usd` DECIMAL(18,2) COMMENT 'The net book value usd of the photomask asset record in the inventory domain.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date by which the next mandatory mask inspection must be completed, based on usage count thresholds or calendar-based inspection intervals defined in the mask management plan.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'Non-Recurring Engineering (NRE) cost in USD associated with the design and manufacture of this photomask set. NRE costs are one-time charges incurred at tapeout and are tracked for product cost accounting and customer billing.',
    `opc_version` STRING COMMENT 'Version identifier of the Optical Proximity Correction (OPC) recipe applied during mask data preparation. OPC compensates for diffraction effects in photolithography; version tracking ensures reproducibility and supports yield analysis.',
    `pellicle_present` BOOLEAN COMMENT 'Indicates whether a protective pellicle membrane is currently mounted on the photomask. Pellicles protect the mask pattern from particle contamination during exposure. EUV masks use specialized EUV-transparent pellicles.',
    `pellicle_type` STRING COMMENT 'Type of pellicle membrane mounted on the photomask. Standard pellicles are used for DUV masks; EUV pellicles are specialized thin-film membranes for EUV lithography. None indicates no pellicle is installed.. Valid values are `standard|EUV|none`',
    `photomask_asset_status` STRING COMMENT 'The status of the photomask asset record in the inventory domain.',
    `qualification_date` DATE COMMENT 'Date on which the photomask was formally qualified for production use following initial inspection and process verification. Marks the start of the active production lifecycle.',
    `registration_error_nm` DECIMAL(18,2) COMMENT 'Measured overlay registration error of the mask pattern in nanometers, indicating how accurately the mask features are positioned relative to the design intent. Critical for multi-layer overlay budget management.',
    `reticle_pod_code` STRING COMMENT 'Identifier of the Reticle Storage Pod (RSP) or reticle SMIF pod in which this photomask is currently housed. RSP tracking is critical for contamination prevention and automated mask library management.',
    `reticle_type` STRING COMMENT 'The reticle type of the photomask asset record in the inventory domain.',
    `retirement_date` DATE COMMENT 'Date on which the photomask was retired from production use, either due to exceeding usage limits, excessive defect count, design obsolescence, or end-of-life (EOL) of the associated product. Nullable for active masks.',
    `scanner_model` STRING COMMENT 'Model identifier of the lithography scanner (stepper/scanner) for which this photomask is qualified (e.g., ASML NXT:2000i, ASML NXE:3600D). Masks are qualified to specific scanner models due to optical system compatibility.',
    `storage_humidity_pct` DECIMAL(18,2) COMMENT 'Required relative humidity percentage for photomask storage environment. Controlled humidity prevents electrostatic discharge damage and contamination on the mask substrate.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Required storage temperature in degrees Celsius for this photomask. EUV masks and phase-shifting masks may have tighter temperature requirements to prevent pellicle degradation or substrate stress.',
    `technology_node` STRING COMMENT 'Process technology node for which this photomask was designed (e.g., 7nm, 5nm, 3nm, 28nm). Determines compatibility with the Process Design Kit (PDK) and fabrication process.',
    `usage_count` STRING COMMENT 'Cumulative number of wafer exposure shots (uses) this photomask has undergone since manufacture or last qualification. Tracked by the MES to manage mask wear and schedule preventive inspection.',
    CONSTRAINT pk_photomask_asset PRIMARY KEY(`photomask_asset_id`)
) COMMENT 'Master record for photomasks (reticles) used in photolithography patterning steps. Tracks mask ID, mask set name, layer name, technology node, EUV/DUV classification, mask generation (tapeout version), OPC version, MEEF value, mask vendor, mask type (binary/attPSM/altPSM), inspection status, defect count, usage count, maximum usage limit, storage location, and retirement date. Masks are high-value, reusable inventory assets.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique surrogate identifier for the storage location master record within the inventory management system. Primary key for the storage_location entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Storage Location Management assigns a manager responsible for safety, access control, and inventory integrity, used in location audit reports.',
    `parent_storage_location_id` BIGINT COMMENT 'Unique identifier for the parent storage location record within the storage location inventory entity.',
    `site_id` BIGINT COMMENT 'Unique identifier for the site record within the storage location inventory entity.',
    `access_restriction_level` STRING COMMENT 'Physical access control level for this storage location. unrestricted — open access; badge-access — requires valid facility badge; authorized-personnel — restricted to named personnel list (e.g., for ITAR-controlled materials); security-vault — highest security for KGD die banks, photomask vaults, and ITAR-controlled IP. Supports ITAR/EAR export control compliance.. Valid values are `unrestricted|badge-access|authorized-personnel|security-vault`',
    `aisle` STRING COMMENT 'The aisle of the storage location record in the inventory domain.',
    `bay` STRING COMMENT 'Bay designation within the building or cleanroom where this storage location is physically situated (e.g., BAY-03, A-WEST). Used for precise physical navigation, equipment layout planning, and cleanroom zone management per SEMI E187.',
    `bin` STRING COMMENT 'The bin of the storage location record in the inventory domain.',
    `building_code` STRING COMMENT 'Identifier for the physical building within the facility where this storage location resides (e.g., FAB1, CHEM-WH-B, OSAT-PKG-C). Supports facility layout mapping, emergency response planning, and environmental zone management.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure used to express the maximum capacity and current utilization of this storage location. Varies by facility type: cassette (wafer storage), pod (photomask storage), tray (packaged chip storage), container (chemical storage), box (die bank storage), pallet (bulk warehouse storage).. Valid values are `cassette|container|pod|tray|box|pallet`',
    `capacity_units` STRING COMMENT 'The capacity units of the storage location record in the inventory domain.',
    `cleanroom_class` STRING COMMENT 'The cleanroom class of the storage location record in the inventory domain.',
    `cleanroom_iso_class` STRING COMMENT 'ISO 14644-1 cleanroom classification for this storage location, defining the maximum allowable airborne particulate concentration. Critical for wafer, photomask, and KGD die storage compliance. Applicable only to cleanroom facility types; null for non-cleanroom locations. Values: ISO-1 (cleanest) through ISO-6.. Valid values are `ISO-1|ISO-2|ISO-3|ISO-4|ISO-5|ISO-6`',
    `commissioned_date` DATE COMMENT 'Date on which this storage location was formally commissioned and made available for inventory use. Marks the start of the locations operational lifecycle. Used for asset age tracking, depreciation scheduling, and facility capacity planning.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where this storage location is physically situated (e.g., USA, TWN, KOR, JPN). Critical for ITAR/EAR export control jurisdiction determination, REACH/RoHS regulatory applicability, and multi-national inventory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location master record was first created in the system (ISO 8601 format: yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for record provenance and data governance compliance per SOX and ISO 9001 quality management requirements.',
    `current_utilization_pct` DECIMAL(18,2) COMMENT 'The current utilization pct of the storage location record in the inventory domain.',
    `current_utilization_percent` DECIMAL(18,2) COMMENT 'The current utilization percent of the storage location record in the inventory domain.',
    `current_utilization_units` STRING COMMENT 'Current number of inventory units occupying this storage location at the time of last inventory update. Compared against max_capacity_units to compute utilization percentage for capacity planning and inventory placement decisions. Updated by MES and SAP MM inventory movements.',
    `decommissioned_date` DATE COMMENT 'Date on which this storage location was permanently decommissioned and removed from active inventory use. Populated only when location_status is decommissioned. Supports facility lifecycle management and historical inventory traceability.',
    `esd_protected_flag` BOOLEAN COMMENT 'The esd protected flag of the storage location record in the inventory domain.',
    `esd_protection_class` STRING COMMENT 'ESD protection classification of this storage location per ANSI/ESD S20.20 and JEDEC JESD625 standards. Determines suitability for storing ESD-sensitive devices (ICs, dies, packaged chips). class-0 (most sensitive, <250V HBM) through class-3 (>2000V HBM); unprotected for non-ESD-controlled areas.. Valid values are `class-0|class-1|class-2|class-3|unprotected`',
    `facility_type` STRING COMMENT 'Classification of the physical facility type housing this storage location. Drives environmental compliance rules, MSD floor life management, and hazmat handling procedures. Valid values: cleanroom (ISO-classified FAB area), warehouse (general materials storage), cold-storage (temperature-controlled for chemicals/biologics), gas-cabinet (pressurized specialty gas storage), nitrogen-cabinet (nitrogen-purged dry storage for moisture-sensitive devices), die-vault (secure KGD die bank storage).. Valid values are `cleanroom|warehouse|cold-storage|gas-cabinet|nitrogen-cabinet|die-vault`',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed at this storage location. Critical for chemical warehouse and gas cabinet locations storing flammable or reactive materials. Drives emergency response planning and insurance compliance. Values: sprinkler, halon (legacy), fm200 (clean agent), co2, dry-powder, none.. Valid values are `sprinkler|halon|fm200|co2|dry-powder|none`',
    `geo_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the facility where this storage location resides. Used for multi-site supply chain mapping, emergency response planning, and regulatory jurisdiction determination for ITAR/EAR export control compliance.',
    `geo_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the facility where this storage location resides. Used in conjunction with geo_latitude for multi-site supply chain mapping and regulatory jurisdiction determination.',
    `hazmat_approved_flag` BOOLEAN COMMENT 'The hazmat approved flag of the storage location record in the inventory domain.',
    `hazmat_classification` STRING COMMENT 'UN/DOT hazardous materials classification code applicable to materials stored at this location (e.g., UN1170 for ethanol, UN2014 for hydrogen peroxide, FLAMMABLE-LIQUID, CORROSIVE, COMPRESSED-GAS, NON-HAZMAT). Governs storage segregation, emergency response, and regulatory reporting under REACH, RoHS, and TSCA. [ENUM-REF-CANDIDATE: flammable-liquid|corrosive|compressed-gas|oxidizer|toxic|non-hazmat|pyrophoric — promote to reference product]',
    `humidity_controlled_flag` BOOLEAN COMMENT 'The humidity controlled flag of the storage location record in the inventory domain.',
    `inventory_valuation_method` STRING COMMENT 'Inventory valuation method applied to stock held at this storage location for financial reporting purposes. standard-cost (used for WIP wafer lots), moving-average (raw materials), fifo (finished goods), fefo (shelf-life-managed chemicals). Aligns with SAP S/4HANA FI/CO valuation area configuration and SOX financial reporting requirements.. Valid values are `standard-cost|moving-average|fifo|fefo`',
    `is_active` BOOLEAN COMMENT 'The is active of the storage location record in the inventory domain.',
    `is_osat_partner_location` BOOLEAN COMMENT 'Indicates whether this storage location is physically situated at an OSAT (Outsourced Semiconductor Assembly and Test) partner facility rather than an internal company site. True for consignment stock locations at OSAT partners. Drives consignment inventory valuation, ownership tracking, and inter-company transfer accounting.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether this storage location is designated for ITAR-controlled materials, requiring strict access logging, personnel authorization, and regulatory reporting. True for locations storing defense-related ICs, ASIC designs, or photomasks subject to ITAR jurisdiction. Drives export control compliance workflows.',
    `kgd_storage_certified` BOOLEAN COMMENT 'Indicates whether this storage location is certified for KGD (Known Good Die) die bank storage, meeting requirements for ESD protection, nitrogen purge, temperature/humidity control, and access security. KGD storage certification is required for high-value tested dies awaiting packaging or shipment.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent environmental and safety inspection conducted for this storage location. Used to track compliance with SEMI S2, ISO 14001, and ISO 45001 periodic inspection requirements. Drives inspection scheduling and regulatory audit readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this storage location master record (ISO 8601 format: yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), data synchronization between SAP S/4HANA and the Databricks Silver Layer, and audit trail maintenance.',
    `location_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the storage location, aligned with SAP S/4HANA MM storage location key (LGORT) and Camstar MES location identifiers. Used for lot traceability, WIP tracking, and inventory placement across FAB, warehouse, and OSAT partner facilities.. Valid values are `^[A-Z0-9]{2,20}$`',
    `location_name` STRING COMMENT 'Human-readable descriptive name of the storage location (e.g., Bay 3 Shelf 12 — EUV Photomask Vault, Cleanroom A Chemical Cabinet Row 5). Used in operational reports, MES screens, and inventory placement instructions.',
    `location_status` STRING COMMENT 'Current operational lifecycle status of the storage location. active — available for inventory placement; blocked — temporarily unavailable due to maintenance, contamination, or audit hold; decommissioned — permanently retired from use. Controls whether new inventory can be assigned to this location.. Valid values are `active|blocked|decommissioned`',
    `location_type` STRING COMMENT 'The location type of the storage location record in the inventory domain.',
    `max_capacity_units` STRING COMMENT 'Maximum number of inventory units (wafer cassettes, chemical containers, photomask pods, chip trays, or die boxes) that can be physically stored at this location. Used for capacity planning, inventory placement optimization, and utilization reporting.',
    `max_humidity_pct` DECIMAL(18,2) COMMENT 'Maximum allowable relative humidity percentage (0–100%) for this storage location. Exceedance above maximum triggers MSD floor life reset, inventory quarantine, and environmental non-conformance reporting per IPC/JEDEC J-STD-033.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for this location. Defines the upper bound of the acceptable temperature range. Exceedance triggers inventory quarantine and environmental non-conformance reporting per ISO 14001 and SEMI C10 chemical storage guidelines.',
    `min_humidity_pct` DECIMAL(18,2) COMMENT 'Minimum allowable relative humidity percentage (0–100%) for this storage location. Critical for MSD floor life management, photomask storage, and chemical stability. Exceedance below minimum may cause ESD risk or material degradation.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius for this location. Defines the lower bound of the acceptable temperature range for stored materials (chemicals, photoresists, gases, packaged devices). Used for environmental compliance monitoring and MSD (Moisture Sensitive Device) floor life management per IPC/JEDEC J-STD-033.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the storage location record in the inventory domain.',
    `msd_floor_life_capable` BOOLEAN COMMENT 'Indicates whether this storage location is equipped and certified to manage MSD floor life tracking per IPC/JEDEC J-STD-033. True for nitrogen-purged cabinets, dry-storage cabinets, and controlled-humidity cleanroom locations. Enables automatic floor life clock suspension for stored MSDs.',
    `msd_sensitivity_level` STRING COMMENT 'Maximum Moisture Sensitivity Level (MSL) of devices that can be safely stored at this location per IPC/JEDEC J-STD-020. MSL-1 (unlimited floor life at ≤30°C/85%RH) through MSL-5 (most sensitive, 24-hour floor life). Determines which packaged semiconductor devices are eligible for placement at this location.. Valid values are `MSL-1|MSL-2|MSL-2a|MSL-3|MSL-4|MSL-5`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory environmental and safety inspection of this storage location. Automatically calculated based on inspection frequency requirements per SEMI S2 and ISO 14001. Triggers inspection work orders in the facility management system.',
    `nitrogen_purge_capable` BOOLEAN COMMENT 'Indicates whether this storage location is equipped with nitrogen purge capability to maintain an inert, moisture-free atmosphere. True for nitrogen-cabinet and die-vault locations used for long-term KGD die storage, photomask preservation, and moisture-sensitive chemical storage. Drives MSD floor life management decisions.',
    `osat_partner_name` STRING COMMENT 'Name of the OSAT partner company at whose facility this storage location resides (e.g., ASE Group, Amkor Technology, JCET). Populated only when is_osat_partner_location is True. Used for consignment stock management, partner performance reporting, and supply chain visibility.',
    `photomask_storage_capable` BOOLEAN COMMENT 'Indicates whether this storage location meets the environmental and cleanliness requirements for photomask (reticle) storage, including ISO cleanroom class, nitrogen purge, and ESD protection. Photomasks are high-value assets used in EUV/DUV lithography and require specialized storage conditions.',
    `plant_code` STRING COMMENT 'SAP S/4HANA plant identifier to which this storage location belongs. Represents the manufacturing or distribution facility (FAB, OSAT partner site, or warehouse) in the enterprise organizational hierarchy. Enables multi-plant inventory management and inter-plant transfer tracking.. Valid values are `^[A-Z0-9]{1,10}$`',
    `rack` STRING COMMENT 'The rack of the storage location record in the inventory domain.',
    `row` STRING COMMENT 'Row designation within the bay for this storage location (e.g., R-12, ROW-A). Provides granular physical addressing for inventory placement, pick-and-put-away operations, and automated storage/retrieval system (ASRS) integration.',
    `shelf` STRING COMMENT 'Shelf or bin designation within the row for this storage location (e.g., S-04, BIN-002). Lowest level of the physical location hierarchy, enabling precise inventory placement and retrieval for wafer cassettes, chemical containers, photomasks, and packaged chip trays.',
    `shelf_life_tracking_enabled` BOOLEAN COMMENT 'Indicates whether shelf life expiry tracking is enabled for materials stored at this location. True for chemical storage, photoresist storage, and gas cabinet locations where materials have defined shelf lives. Enables automated expiry alerts and FEFO (First Expired First Out) inventory management.',
    `storage_conditions` STRING COMMENT 'The storage conditions of the storage location record in the inventory domain.',
    `storage_location_status` STRING COMMENT 'The status of the storage location record in the inventory domain.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'The temperature controlled flag of the storage location record in the inventory domain.',
    `warehouse_code` STRING COMMENT 'Coded value representing the warehouse code of the storage location inventory record.',
    `warehouse_zone` STRING COMMENT 'The warehouse zone of the storage location record in the inventory domain.',
    `weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum allowable total weight in kilograms for materials stored at this location. Critical for shelf structural integrity compliance, particularly for heavy chemical drums, gas cylinders, and bulk wafer cassette storage. Enforced per facility safety standards.',
    `wip_staging_area` BOOLEAN COMMENT 'Indicates whether this storage location is designated as a WIP (Work in Process) staging area for wafer lots between process steps. True for inter-bay buffers, equipment load ports, and process queue areas within the FAB cleanroom. Enables WIP flow tracking and cycle time analysis in the MES.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master record for physical and logical storage locations within FAB cleanrooms, chemical warehouses, gas cabinets, die bank vaults, and OSAT partner facilities. Captures location code, location name, facility type (cleanroom/warehouse/cold-storage/gas-cabinet/nitrogen-cabinet/die-vault), building, bay, row, shelf, temperature range, humidity range, ESD protection class, nitrogen purge capability, hazmat classification, maximum capacity, current utilization, and location status (active/blocked/decommissioned). Enables precise inventory placement, environmental compliance tracking, and MSD floor life management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` (
    `stock_balance_id` BIGINT COMMENT 'Unique surrogate identifier for each stock balance snapshot record in the inventory management system. Primary key for the stock_balance data product.',
    `experimental_lot_id` BIGINT COMMENT 'Foreign key linking to research.experimental_lot. Business justification: Tracks raw material consumption per experimental lot for cost accounting and yield analysis.',
    `finished_good_id` BIGINT COMMENT 'Unique identifier for the finished good record within the stock balance inventory entity.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the stock balance inventory entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Stock Balance Reconciliation assigns a controller employee who validates periodic counts, supporting financial reporting and SOX compliance.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Reference to the specific production or procurement lot associated with this stock balance record. Enables full lot traceability from raw silicon wafer through WIP to finished packaged chip, as required by IATF 16949 and JEDEC traceability standards.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the source material master record within the stock balance inventory entity.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility (FAB, OSAT partner site, assembly and test facility) where this stock balance is maintained.',
    `primary_stock_material_master_id` BIGINT COMMENT 'Reference to the material master record representing the specific semiconductor material, component, or product (e.g., silicon wafer, photomask, packaged IC, chemical) for which this stock balance is recorded.',
    `primary_stock_raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: raw_material is a master for raw materials; linking stock_balance to raw_material via raw_material_id replaces generic material_master references and enables direct lookup of raw material attributes.',
    `storage_location_id` BIGINT COMMENT 'Reference to the physical or logical storage location (e.g., FAB cleanroom bay, chemical storage vault, finished goods warehouse, OSAT consignment location) where this inventory is held.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: INVENTORY RECEIPT: Stock balance must be tied to the PO that supplied the material for traceability and financial reconciliation.',
    `raw_material_id` BIGINT COMMENT 'FK to inventory.raw_material.raw_material_id — Stock balance for raw materials must reference the raw_material master record. This is the core master-transaction relationship for material inventory visibility.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the stock balance inventory entity.',
    `stock_storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Stock balance is always per-location. Without this FK, inventory visibility by location is impossible.',
    `balance_date` DATE COMMENT 'The balance date associated with the stock balance inventory record.',
    `balance_type` STRING COMMENT 'The balance type of the stock balance record in the inventory domain.',
    `batch_classification` STRING COMMENT 'Quality grade classification of the wafer or material batch. prime = meets all specifications for production; test = test wafers used for process qualification; engineering = engineering samples not for production; monitor = process monitor wafers; reject = failed quality inspection and not usable.. Valid values are `prime|test|engineering|monitor|reject`',
    `bin_classification` STRING COMMENT 'Die or wafer bin classification code assigned during wafer sort or final test, indicating the performance grade or speed bin of the die (e.g., BIN1_HIGH_PERF, BIN2_STD, BIN3_LOW_SPEED, REJECT). Used for die bank management, customer order fulfillment by grade, and yield analysis. [ENUM-REF-CANDIDATE: promote to reference product as bin classifications vary by product family]',
    `consignment_partner_code` STRING COMMENT 'Identifier of the Outsourced Semiconductor Assembly and Test (OSAT) partner or external consignee at whose facility this consignment stock is physically held. Populated only for stock_type = consignment. Used for consignment reconciliation and OSAT partner performance tracking.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the stock balance record in the inventory domain.',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether this material is subject to export control regulations (True), including ITAR (International Traffic in Arms Regulations) or EAR (Export Administration Regulations) administered by BIS. Export-controlled inventory requires additional authorization before transfer to foreign nationals or shipment to controlled countries.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this material is classified as hazardous (True) under applicable regulations (OSHA HazCom, REACH, TSCA, or DOT). Hazardous materials include certain process chemicals, gases (e.g., arsine, phosphine), and solvents used in semiconductor fabrication. Triggers special storage, handling, and disposal requirements.',
    `kgd_status` STRING COMMENT 'Indicates the Known Good Die (KGD) qualification status for die bank inventory. known_good = die has passed all electrical and functional tests; failed = die has failed one or more tests; untested = die has not yet been tested; conditionally_good = die passed with minor deviations within specification limits. Applicable only to die bank material types.. Valid values are `known_good|failed|untested|conditionally_good`',
    `last_goods_issue_date` DATE COMMENT 'Date of the most recent goods issue (GI) posting for this material from this storage location. Used to identify dormant inventory, assess consumption velocity, and support slow-moving inventory analysis.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt (GR) posting for this material at this storage location. Used to calculate stock aging, assess replenishment lead times, and support FIFO/FEFO inventory consumption sequencing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the stock balance record in the inventory domain.',
    `last_movement_date` DATE COMMENT 'The last movement date associated with the stock balance inventory record.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'The last movement timestamp of the stock balance record in the inventory domain.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count performed for this material at this storage location. Used to assess inventory accuracy, schedule next count, and support SOX financial reporting requirements for inventory valuation.',
    `lot_number` STRING COMMENT 'The human-readable lot or batch identifier assigned by the MES (Camstar or Applied Materials SmartFactory) for WIP wafer lots, or by the ERP for raw material and finished goods batches. Critical for traceability, yield analysis, and IATF 16949 compliance.. Valid values are `^[A-Z0-9_-]{1,30}$`',
    `material_code` STRING COMMENT 'Coded value representing the material code of the stock balance inventory record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the stock balance record in the inventory domain.',
    `msd_level` STRING COMMENT 'Moisture Sensitivity Level (MSL) classification per IPC/JEDEC J-STD-020 for packaged semiconductor devices and components. Determines floor life limits and baking requirements before reflow soldering. Applicable to finished goods and packaging inventory. [ENUM-REF-CANDIDATE: 1|2|2a|3|4|5|5a|6 — 8 candidates stripped; promote to reference product]',
    `qty_available` DECIMAL(18,2) COMMENT 'Quantity of unrestricted stock that is not committed to any open reservation or production order. Represents the net available quantity for Available-to-Promise (ATP) calculations and new production planning decisions. Computed as unrestricted stock minus open reservations.',
    `qty_blocked` DECIMAL(18,2) COMMENT 'Quantity of material placed in blocked stock due to quality rejection, ITAR/EAR export control restrictions, supplier non-conformance, or regulatory hold. Blocked stock is not available for production or shipment until formally released.',
    `qty_in_transit` DECIMAL(18,2) COMMENT 'Quantity of material that has been shipped from a source location but has not yet been received at the destination location. Includes inter-plant transfers, OSAT shipments, and inbound supplier deliveries in transit.',
    `qty_in_wip` DECIMAL(18,2) COMMENT 'Quantity of material currently consumed into active production orders and undergoing fabrication processing (e.g., wafer lots in FEOL/BEOL processing, die in packaging). Tracked by the MES and reflected in SAP PP WIP accounts.',
    `qty_on_hand` DECIMAL(18,2) COMMENT 'Total physical quantity of the material present at the storage location across all stock types, expressed in the base unit of measure. Represents the gross inventory position before reservations or quality holds are considered.',
    `qty_quality_inspection` DECIMAL(18,2) COMMENT 'Quantity of material currently held in SAP QM quality inspection stock, pending disposition decision (accept, reject, rework). Includes incoming inspection lots, in-process inspection holds, and post-process quality holds.',
    `qty_reserved` DECIMAL(18,2) COMMENT 'Total quantity committed to active inventory reservations linked to open production orders, sales orders, or transfer orders. Corresponds to open inventory_reservation records and reduces the available quantity for new demand.',
    `quantity_available` DECIMAL(18,2) COMMENT 'The quantity available of the stock balance record in the inventory domain.',
    `quantity_blocked` DECIMAL(18,2) COMMENT 'The quantity blocked of the stock balance record in the inventory domain.',
    `quantity_in_transit` DECIMAL(18,2) COMMENT 'The quantity in transit of the stock balance record in the inventory domain.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The quantity on hand of the stock balance record in the inventory domain.',
    `quantity_quality_hold` DECIMAL(18,2) COMMENT 'The quantity quality hold of the stock balance record in the inventory domain.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'The quantity reserved of the stock balance record in the inventory domain.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock balance record was first created in the lakehouse silver layer. Supports audit trail requirements for SOX financial reporting and data governance lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock balance record was last updated in the lakehouse silver layer, reflecting the most recent refresh from the source system. Used for incremental load processing and data freshness monitoring.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The reorder point of the stock balance record in the inventory domain.',
    `reorder_point_qty` DECIMAL(18,2) COMMENT 'The minimum on-hand quantity threshold at which a replenishment order should be triggered for this material at this storage location. Maintained in SAP MRP parameters and used by production planning to prevent stockouts of critical raw materials, chemicals, and gases.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether this material lot is compliant with the EU RoHS Directive (Restriction of Hazardous Substances), restricting the use of lead, mercury, cadmium, hexavalent chromium, PBB, and PBDE. Required for finished goods destined for EU markets and tracked per Oracle Agile PLM compliance records.',
    `safety_stock` DECIMAL(18,2) COMMENT 'The safety stock of the stock balance record in the inventory domain.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'The safety stock level of the stock balance record in the inventory domain.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Buffer stock quantity maintained above the reorder point to protect against demand variability and supply lead time uncertainty. Defined in SAP MRP safety stock parameters. Critical for high-value materials like EUV photomasks and specialty process gases with long procurement lead times.',
    `shelf_life_expiry_date` DATE COMMENT 'Date on which the materials shelf life expires and it becomes unusable for production. Applicable to chemicals, photoresists, gases, and certain packaging materials. Enforced by SAP batch management shelf-life expiration date (SLED) functionality. Materials past this date must be quarantined and disposed per REACH and RoHS regulations.',
    `slow_moving_flag` BOOLEAN COMMENT 'Indicates whether this stock balance has been flagged as slow-moving (True) based on the stock_aging_days exceeding the material-specific slow-moving threshold. Used for inventory write-down risk assessment, EOL (End of Life) planning, and LTB (Last Time Buy) decision support.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The principal business event timestamp indicating when this stock balance snapshot was captured from the source system (SAP MM or MES). Represents the point-in-time inventory position and is the primary temporal key for real-time inventory visibility and ATP calculations.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this stock balance record was sourced. Enables data lineage tracking and reconciliation across SAP MM, Camstar MES, Applied Materials SmartFactory MES, and Oracle Agile PLM in the lakehouse silver layer.. Valid values are `SAP_MM|CAMSTAR|SMARTFACTORY|AGILE_PLM`',
    `special_stock_indicator` STRING COMMENT 'SAP special stock indicator identifying non-standard stock ownership or custody arrangements. E = sales order stock; K = consignment stock at customer; Q = project stock; W = consignment stock from vendor; O = stock at subcontractor (OSAT). Empty value indicates standard own stock.. Valid values are `E|K|Q|W|O|`',
    `stock_aging_days` STRING COMMENT 'Number of days the current on-hand stock has been held at this storage location since the oldest receipt date. Used for slow-moving inventory identification, shelf-life monitoring, and obsolescence risk assessment. Critical for chemicals, gases, and photoresists with defined shelf lives.',
    `stock_type` STRING COMMENT 'SAP stock category indicating the usability status of the inventory. unrestricted is available for production or shipment; quality_inspection is under QM hold pending disposition; blocked is rejected or quarantined; consignment is held at OSAT partner sites; restricted is subject to export control or ITAR/EAR restrictions.. Valid values are `unrestricted|quality_inspection|blocked|consignment|restricted`',
    `storage_condition_code` STRING COMMENT 'Required storage environment classification for this material. Drives warehouse management system (WMS) slotting and compliance with SEMI, REACH, and OSHA storage requirements. nitrogen_purge for moisture-sensitive devices (MSD); cold_storage for temperature-sensitive chemicals; cleanroom_class1/10 for wafers and photomasks; hazmat for regulated chemicals.. Valid values are `ambient|nitrogen_purge|cold_storage|cleanroom_class1|cleanroom_class10|hazmat`',
    `total_value_usd` DECIMAL(18,2) COMMENT 'The total value usd of the stock balance record in the inventory domain.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for all quantity fields on this stock balance record. EA = each (packaged chips), WFR = wafer, LOT = wafer lot, KG = kilogram (chemicals), L = liter (liquid chemicals/gases), M2 = square meter (substrate), MASK = photomask, DIE = individual die. Aligned with SAP base UoM configuration. [ENUM-REF-CANDIDATE: EA|WFR|LOT|KG|L|M2|MASK|DIE — 8 candidates stripped; promote to reference product]',
    `unrestricted_use_flag` BOOLEAN COMMENT 'Indicates whether this stock balance record represents inventory that is fully available for unrestricted use in production or shipment (True), or whether it is subject to any hold, restriction, or quality disposition (False). Derived from stock_type but maintained as an explicit flag for rapid ATP query performance.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The valuation amount of the stock balance record in the inventory domain.',
    `valuation_class` STRING COMMENT 'SAP valuation class code that determines the general ledger (GL) accounts to which inventory postings are made for this material. Links inventory movements to the correct balance sheet accounts for financial reporting. Detailed financial valuation fields are maintained in the stock_valuation data product.. Valid values are `^[A-Z0-9]{4}$`',
    `valuation_method` STRING COMMENT 'The valuation method of the stock balance record in the inventory domain.',
    `value_usd` DECIMAL(18,2) COMMENT 'The value usd of the stock balance record in the inventory domain.',
    `wafer_process_node` STRING COMMENT 'The semiconductor process technology node at which the wafer lot or die was fabricated (e.g., 7nm, 14nm, 28nm, 180nm). Critical for inventory segregation, process compatibility checks, and customer design-in alignment.. Valid values are `^[0-9]{1,4}nm$`',
    CONSTRAINT pk_stock_balance PRIMARY KEY(`stock_balance_id`)
) COMMENT 'Transactional snapshot of on-hand inventory quantities by material, storage location, lot, and stock type (unrestricted, quality inspection, blocked, consignment). Captures quantity on hand, quantity available (unreserved), quantity reserved (linked to active inventory_reservation records), quantity in transit, quantity in WIP, unit of measure, last physical count date, and stock aging days. Supports real-time inventory visibility, ATP calculations, and production planning decisions. Financial valuation fields are maintained in stock_valuation.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` (
    `goods_movement_id` BIGINT COMMENT 'Unique identifier for the goods movement transaction. Primary key for the goods movement record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer for goods issue transactions related to sales orders or consignment stock transfers. Links to customer master for finished goods shipments.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost center on each goods movement is needed for accurate cost allocation in financial statements.',
    `export_license_usage_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license_usage. Business justification: Each goods movement (shipment) must record the specific export license usage to satisfy license utilization reporting and audit trails.',
    `finished_good_id` BIGINT COMMENT 'Unique identifier for the finished good record within the goods movement inventory entity.',
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the from location record within the goods movement inventory entity.',
    `from_storage_location_id` BIGINT COMMENT 'Unique identifier for the from storage location record within the goods movement inventory entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account on movement ties inventory transactions to the general ledger for audit‑ready posting.',
    `employee_id` BIGINT COMMENT 'User ID of the person who executed the goods movement transaction. Used for SOX Section 404 audit trail and segregation of duties compliance.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the goods material master record within the goods movement inventory entity.',
    `goods_performed_by_employee_id` BIGINT COMMENT 'Unique identifier for the goods performed by employee record within the goods movement inventory entity.',
    `stock_balance_id` BIGINT COMMENT 'FK to inventory.stock_balance.stock_balance_id — Goods movements update stock balances — the transactional movement must reference the balance it affects for real-time inventory accuracy.',
    `goods_storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Every goods movement must reference destination location for receiving and placement.',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: REQUIRED: Financial and logistics reporting ties inventory movements to the originating sales order for cost of goods sold and compliance.',
    `primary_goods_material_master_id` BIGINT COMMENT 'Identifier of the material being moved. References the material master record for silicon wafers, chemicals, gases, photomasks, packaged chips, or die banks.',
    `primary_goods_stock_balance_id` BIGINT COMMENT 'FK to inventory.stock_balance.stock_balance_id — Every goods movement posting updates the stock balance. This is the fundamental inventory equation: stock_balance = sum(goods_movements). Critical for reconciliation and audit.',
    `primary_goods_storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Every goods movement must reference source location for audit trail and inventory reconciliation.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: LOGISTICS: Each goods movement (receipt/shipment) is driven by a PO; linking supports audit, costing, and on‑time delivery metrics.',
    `raw_material_id` BIGINT COMMENT 'Unique identifier for the raw material record within the goods movement inventory entity.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Links material movements to a research project, required for the Project Material Movement Log.',
    `source_storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Every goods movement has a source location (for issues, transfers) or destination location (for receipts). Location reference is mandatory for movement posting and audit trail.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier for goods receipt transactions. Links to vendor master for silicon wafer suppliers, chemical vendors, gas suppliers, or OSAT (Outsourced Semiconductor Assembly and Test) partners.',
    `to_storage_location_id` BIGINT COMMENT 'Unique identifier for the to storage location record within the goods movement inventory entity.',
    `batch_number` STRING COMMENT 'Batch or lot number for batch-managed materials such as chemicals, gases, or raw wafers. Distinct from wafer lot number; used for supplier batch traceability and shelf-life management.',
    `bin_classification` STRING COMMENT 'Quality bin or grade classification for die or wafer inventory: Bin 1 (prime), Bin 2 (downgrade), Bin 3 (scrap), or custom bin codes. Used for Known Good Die (KGD) status tracking and yield analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the goods movement record in the inventory domain.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount. Typically company currency (USD, EUR, JPY, etc.) for inventory accounting.',
    `delivery_note_number` STRING COMMENT 'Delivery note or packing slip number from the supplier or shipping carrier. Used for goods receipt matching and three-way match (PO, goods receipt, invoice) reconciliation.',
    `destination_plant_code` STRING COMMENT 'Plant or FAB site code where the material was moved to. Used for inter-plant transfers and multi-site inventory tracking. Critical for global supply chain visibility.',
    `destination_storage_location` STRING COMMENT 'Storage location code where the material was moved to. Represents warehouse, stockroom, or FAB storage area. Empty for goods issues to external customers or scrap.',
    `document_line_item` STRING COMMENT 'Line item number within the material document. Supports multi-line goods movement documents where multiple materials or lots are moved in a single transaction.',
    `document_number` STRING COMMENT 'Unique material document number generated by the ERP system for this goods movement. Primary business identifier for the transaction, used for audit trail and reversal references.',
    `document_type` STRING COMMENT 'The document type of the goods movement record in the inventory domain.',
    `goods_movement_status` STRING COMMENT 'The status of the goods movement record in the inventory domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the goods movement record in the inventory domain.',
    `lot_number` STRING COMMENT 'Wafer lot or batch identifier for Work in Process (WIP) inventory. Critical for lot traceability and IATF 16949 compliance. Tracks wafer lots through fabrication, die banks, and packaging.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the goods movement record in the inventory domain.',
    `movement_date` DATE COMMENT 'Date when the physical goods movement occurred. Business event date for inventory transaction, distinct from posting date. Critical for SOX Section 404 audit trail and inventory valuation.',
    `movement_number` STRING COMMENT 'The movement number of the goods movement record in the inventory domain.',
    `movement_quantity` DECIMAL(18,2) COMMENT 'The movement quantity of the goods movement record in the inventory domain.',
    `movement_reason_code` STRING COMMENT 'Coded value representing the movement reason code of the goods movement inventory record.',
    `movement_status` STRING COMMENT 'The movement status of the goods movement record in the inventory domain.',
    `movement_timestamp` TIMESTAMP COMMENT 'The movement timestamp of the goods movement record in the inventory domain.',
    `movement_type` STRING COMMENT 'Classification of the inventory movement transaction: goods receipt from supplier, goods issue to production, inter-location transfer, scrap disposal, return from production, or posting reversal. Aligns with SAP MM movement type codes.. Valid values are `goods_receipt|goods_issue|transfer_posting|scrap|return|reversal`',
    `movement_value_usd` DECIMAL(18,2) COMMENT 'The movement value usd of the goods movement record in the inventory domain.',
    `notes` STRING COMMENT 'Free-text notes or comments about the goods movement transaction. Used for documenting special handling instructions, quality issues, or operational exceptions.',
    `posting_date` DATE COMMENT 'Date when the goods movement was posted to the financial ledger. Used for period-end closing and financial reporting. May differ from movement date for backdated or delayed postings.',
    `production_order_number` STRING COMMENT 'Production order number for goods issues to manufacturing or goods receipts from production. Links inventory movements to wafer fabrication, die packaging, or assembly operations.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material moved in this transaction. Positive for receipts and transfers-in, negative for issues and transfers-out. Precision supports wafer counts, die counts, and chemical volumes.',
    `reason_code` STRING COMMENT 'Code indicating the business reason for the goods movement: quality hold, scrap due to defect, return to vendor, obsolescence, cycle count adjustment, or other operational reason. Required for scrap and adjustment transactions.',
    `reference_document` STRING COMMENT 'The reference document of the goods movement record in the inventory domain.',
    `reference_document_line_item` STRING COMMENT 'Line item number within the reference document. Provides precise linkage to the specific line of the purchase order, production order, or delivery note.',
    `reference_document_number` STRING COMMENT 'Number of the source document that triggered this goods movement. Links to purchase order, production order, delivery note, or other originating transaction for full traceability.',
    `reference_document_type` STRING COMMENT 'Type of source document that triggered this goods movement: purchase order (PO) for receipts, production order for manufacturing issues/receipts, delivery note for shipments, transfer order for inter-location moves, sales order for customer shipments, or reservation for planned consumption.. Valid values are `purchase_order|production_order|delivery_note|transfer_order|sales_order|reservation`',
    `reservation_number` STRING COMMENT 'Material reservation number for planned goods issues. Links to production order or maintenance order reservations for material requirements planning (MRP) and allocation.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this goods movement is a reversal of a previous transaction. True for cancellation or correction postings. Used for audit trail and error correction tracking.',
    `reversed_document_number` STRING COMMENT 'Material document number of the original transaction being reversed. Populated only when reversal_indicator is true. Provides linkage for audit trail and reconciliation.',
    `serial_number` STRING COMMENT 'Serial number for serialized inventory items such as high-value equipment parts or Known Good Die (KGD) units. Enables unit-level traceability for critical components.',
    `shelf_life_expiration_date` DATE COMMENT 'Expiration date for time-sensitive materials such as photoresists, chemicals, or adhesives. Used for shelf-life management and FIFO (First In First Out) inventory control.',
    `source_plant_code` STRING COMMENT 'Plant or FAB site code where the material originated. Used for inter-plant transfers and multi-site inventory tracking. Aligns with SEMI E120 traceability requirements.',
    `source_storage_location` STRING COMMENT 'Storage location code where the material was moved from. Represents warehouse, stockroom, or FAB storage area. Empty for goods receipts from external suppliers.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types: consignment stock at OSAT partners, project-specific stock, sales order allocated stock, returnable packaging, or pipeline inventory. Affects ownership and valuation rules.. Valid values are `consignment|project_stock|sales_order_stock|returnable_packaging|pipeline`',
    `stock_type` STRING COMMENT 'Stock status classification: unrestricted (available for use), quality inspection (pending QA release), blocked (quality hold or obsolete), or restricted use (conditional release). Determines material availability for production and sales.. Valid values are `unrestricted|quality_inspection|blocked|restricted_use`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the goods movement transaction was recorded in the system. Used for audit trail, sequence verification, and real-time inventory updates.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the movement quantity: wafers (EA), dies (PC), liters (L), kilograms (KG), or other standard units. Aligns with ISO 80000 quantity standards.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the goods movement in company currency. Calculated as quantity multiplied by material standard cost or moving average price. Used for inventory valuation and financial reporting.',
    `value_usd` DECIMAL(18,2) COMMENT 'The value usd of the goods movement record in the inventory domain.',
    `work_center` STRING COMMENT 'Work center or production resource where the material was issued or received. Identifies specific FAB equipment, packaging line, or assembly station for process traceability.',
    CONSTRAINT pk_goods_movement PRIMARY KEY(`goods_movement_id`)
) COMMENT 'Transactional record for every inventory movement event: goods receipts from suppliers, goods issues to production, inter-location transfers, scrap disposals, returns, and posting reversals. Captures movement type, date, material, quantity, UoM, source/destination locations, reference document (PO/production order/delivery note), posting date, and document number. Provides the complete inventory audit trail required for SOX Section 404 controls, IATF 16949 traceability, and real-time stock balance updates.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` (
    `inventory_lot_hold_id` BIGINT COMMENT 'Unique identifier for the inventory lot hold record. Primary key for the inventory lot hold transaction.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the lot under hold. Applicable for customer-specific holds or customer-requested holds.',
    `capa_record_id` BIGINT COMMENT 'Identifier of the corrective action plan or CAPA (Corrective and Preventive Action) record associated with this hold. Links the hold to the formal corrective action process.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the manufacturing equipment or tool associated with the hold. Links the hold to the specific machine or tool that processed the lot before the hold was placed.',
    `fabrication_process_step_id` BIGINT COMMENT 'Identifier of the manufacturing process step where the hold was triggered. References the specific operation or stage in the fabrication flow (e.g., lithography, etch, CMP).',
    `fmea_record_id` BIGINT COMMENT 'Reference to the FMEA document or record associated with this hold. Links the hold to the failure mode analysis that identified the risk or defect mode.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Lot‑hold decisions are often triggered by design‑specific issues; linking hold records to the project enables root‑cause analysis.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the inventory placed by employee record within the inventory lot hold inventory entity.',
    `inventory_released_by_employee_id` BIGINT COMMENT 'Unique identifier for the inventory released by employee record within the inventory lot hold inventory entity.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot or finished goods lot subject to this hold. References the inventory lot under hold restriction.',
    `primary_inventory_employee_id` BIGINT COMMENT 'Identifier of the person or system that initiated the hold. References employee ID or automated system identifier responsible for placing the hold.',
    `quality_notification_id` BIGINT COMMENT 'Reference to the associated quality notification or non-conformance report. Links the hold to the formal quality management record (e.g., SAP QM notification number).',
    `sku_id` BIGINT COMMENT 'Identifier of the product or device type associated with the lot under hold. References the IC design, SoC, or ASIC product code.',
    `trade_compliance_hold_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_hold. Business justification: Lot holds often stem from trade compliance issues; linking hold records to the underlying trade compliance hold provides traceability for release decisions.',
    `order_id` BIGINT COMMENT 'Identifier of the manufacturing work order or production order associated with the lot under hold. Links the hold to the specific production run or batch.',
    `fabrication_lot_hold_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `affected_quantity` STRING COMMENT 'The affected quantity of the inventory lot hold record in the inventory domain.',
    `containment_action` STRING COMMENT 'Description of the immediate containment action taken to prevent further impact. Details the steps taken to isolate the affected lot and prevent similar issues in other lots.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hold record was first created in the system. Audit trail timestamp for record creation.',
    `defect_count` STRING COMMENT 'Number of defects detected that triggered the hold. Represents the count of non-conformances or defects identified during inspection or testing.',
    `die_quantity` STRING COMMENT 'Total number of die (individual chips) in the lot subject to this hold. Applicable for finished goods or die bank inventory holds.',
    `disposition` STRING COMMENT 'The disposition of the inventory lot hold record in the inventory domain.',
    `disposition_action` STRING COMMENT 'The disposition action of the inventory lot hold record in the inventory domain.',
    `dppm_value` DECIMAL(18,2) COMMENT 'Calculated defect rate in parts per million for the lot under hold. Quality metric indicating the severity of the defect condition.',
    `expected_release_date` DATE COMMENT 'The expected release date associated with the inventory lot hold inventory record.',
    `export_control_classification` STRING COMMENT 'Export control classification code for the lot under hold. Indicates the regulatory classification under EAR (Export Administration Regulations) or ITAR (International Traffic in Arms Regulations). Used for export-control holds.. Valid values are `EAR99|ECCN_[0-9A-Z]{5,10}|ITAR|NLR`',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility or site where the lot was processed. Indicates the manufacturing location associated with the hold.. Valid values are `^[A-Z]{3}[0-9]{2}$`',
    `hold_comments` STRING COMMENT 'Additional free-text comments or notes related to the hold. Provides supplementary information, investigation findings, or disposition rationale.',
    `hold_date` TIMESTAMP COMMENT 'Date and time when the hold was placed on the lot. Represents the principal business event timestamp when the lot became restricted from further processing or shipment.',
    `hold_description` STRING COMMENT 'The hold description of the inventory lot hold record in the inventory domain.',
    `hold_disposition` STRING COMMENT 'Final disposition decision for the lot after hold investigation. Indicates the action taken: rework (reprocess the lot), scrap (discard the lot), release (approve for continued flow), return (send back to supplier or customer), quarantine (extended hold pending further review), or retest (re-inspect or re-qualify).. Valid values are `rework|scrap|release|return|quarantine|retest`',
    `hold_expiration_date` TIMESTAMP COMMENT 'Date and time when the hold automatically expires if not explicitly released. Null if no expiration is set. Used for time-limited holds that auto-release after a defined period.',
    `hold_initiator_name` STRING COMMENT 'Full name of the person or system that initiated the hold. Provides human-readable identification of the hold originator.',
    `hold_number` STRING COMMENT 'Business identifier for the hold event. Externally-known unique code assigned to this hold transaction for tracking and reference purposes.. Valid values are `^HOLD-[0-9]{8,12}$`',
    `hold_priority` STRING COMMENT 'Priority level assigned to the hold. Indicates the urgency and business impact of the hold (critical for safety or regulatory issues, high for customer impact, medium for process improvement, low for administrative holds).. Valid values are `critical|high|medium|low`',
    `hold_reason_code` STRING COMMENT 'Standardized code representing the specific reason for the hold. Maps to internal quality management or MES reason code taxonomy (e.g., DEFECT_EXCURSION, SPC_VIOLATION, CUSTOMER_RETURN, ITAR_REVIEW).. Valid values are `^[A-Z0-9_]{3,10}$`',
    `hold_reason_description` STRING COMMENT 'Detailed free-text explanation of the hold reason. Provides context and specifics beyond the hold reason code, including root cause details, defect description, or customer complaint reference.',
    `hold_release_authority_name` STRING COMMENT 'Full name of the person or system that released the hold. Provides human-readable identification of the release authority.',
    `hold_release_date` TIMESTAMP COMMENT 'Date and time when the hold was released or lifted. Null if the hold is still active. Marks the point when the lot was cleared for continued processing or shipment.',
    `hold_status` STRING COMMENT 'Current lifecycle state of the hold. Indicates whether the hold is currently active (lot is restricted), released (hold lifted and lot available), expired (hold auto-released after time limit), or cancelled (hold invalidated).. Valid values are `active|released|expired|cancelled`',
    `hold_timestamp` TIMESTAMP COMMENT 'The hold timestamp of the inventory lot hold record in the inventory domain.',
    `hold_type` STRING COMMENT 'Classification of the hold event. Indicates the functional area or business reason category that triggered the hold (engineering investigation, quality issue, customer request, export control compliance, process deviation, equipment failure, or material defect). [ENUM-REF-CANDIDATE: engineering|quality|customer|export_control|process|equipment|material — 7 candidates stripped; promote to reference product]',
    `inventory_fabrication_lot_hold_id` BIGINT COMMENT 'SSOT reference to authoritative owner fabrication.fabrication_lot_hold for concept lot_hold',
    `is_regulatory_hold` BOOLEAN COMMENT 'Flag indicating whether the hold is mandated by regulatory compliance requirements (e.g., export control, environmental, safety). True if the hold is regulatory-driven, false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this hold record was last updated. Audit trail timestamp for record modification.',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `mrb_required_flag` BOOLEAN COMMENT 'The mrb required flag of the inventory lot hold record in the inventory domain.',
    `ncr_reference` STRING COMMENT 'The ncr reference of the inventory lot hold record in the inventory domain.',
    `notes` STRING COMMENT 'The notes of the inventory lot hold record in the inventory domain.',
    `placed_timestamp` TIMESTAMP COMMENT 'The placed timestamp of the inventory lot hold record in the inventory domain.',
    `primary_fabrication_lot_hold_id` BIGINT COMMENT 'Unique identifier for the primary fabrication lot hold record within the inventory lot hold inventory entity.',
    `released_by` STRING COMMENT 'The released by of the inventory lot hold record in the inventory domain.',
    `released_timestamp` TIMESTAMP COMMENT 'The released timestamp of the inventory lot hold record in the inventory domain.',
    `root_cause_code` STRING COMMENT 'Standardized code representing the identified root cause of the issue that triggered the hold. Maps to internal root cause taxonomy (e.g., MATERIAL_DEFECT, PROCESS_DRIFT, EQUIPMENT_FAILURE, OPERATOR_ERROR).. Valid values are `^[A-Z0-9_]{3,10}$`',
    `severity` STRING COMMENT 'The severity of the inventory lot hold record in the inventory domain.',
    `wafer_quantity` STRING COMMENT 'Number of wafers in the lot subject to this hold. Represents the count of silicon wafers affected by the hold restriction.',
    CONSTRAINT pk_inventory_lot_hold PRIMARY KEY(`inventory_lot_hold_id`)
) COMMENT 'Transactional record capturing hold events placed on wafer lots or finished goods inventory. Tracks hold ID, lot reference, hold type (engineering/quality/customer/export-control), hold reason code, hold initiator, hold date, release date, release authority, hold disposition (rework/scrap/release/return), and associated quality notification or FMEA reference. Critical for quality management and regulatory compliance workflows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` (
    `physical_inventory_id` BIGINT COMMENT 'Unique identifier for the physical inventory count event record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record within the physical inventory inventory entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the physical counted by employee record within the physical inventory inventory entity.',
    `storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Physical counts are performed AT specific storage locations. Location is a mandatory dimension for count execution and variance analysis.',
    `primary_physical_counter_employee_id` BIGINT COMMENT 'Employee identifier of the person who performed the physical count, ensuring accountability and traceability per ISO 9001 requirements.',
    `primary_storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Physical counts are always performed at a specific location. Required for SOX audit trail.',
    `adjustment_posted_flag` BOOLEAN COMMENT 'The adjustment posted flag of the physical inventory record in the inventory domain.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the supervisor approved the physical count results, authorizing variance posting to the system.',
    `approved_by` STRING COMMENT 'The approved by of the physical inventory record in the inventory domain.',
    `bin_classification` STRING COMMENT 'Bin classification code for die or chip inventory, categorizing units by electrical test performance (e.g., Bin 1 for prime Known Good Die (KGD), Bin 2-9 for various performance grades or defects).. Valid values are `^[A-Z0-9]{1,4}$`',
    `book_quantity` DECIMAL(18,2) COMMENT 'System-recorded inventory quantity (book quantity) at the time of the physical count, representing the expected quantity per ERP records.',
    `consignment_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this inventory is consignment stock held at an OSAT (Outsourced Semiconductor Assembly and Test) partner or customer location, owned by the company but physically located off-site.',
    `consignment_partner_code` STRING COMMENT 'Vendor or partner code identifying the OSAT partner or customer location where consignment inventory is held.. Valid values are `^[A-Z0-9]{4,10}$`',
    `count_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the physical count activity was completed and submitted for review.',
    `count_date` DATE COMMENT 'The date on which the physical inventory count was performed or is scheduled to be performed.',
    `count_document_number` STRING COMMENT 'Externally-known unique document number assigned to this physical inventory count event for traceability and audit purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `count_method` STRING COMMENT 'The count method of the physical inventory record in the inventory domain.',
    `count_notes` STRING COMMENT 'Free-text notes or comments recorded by the counter or supervisor regarding count conditions, discrepancies observed, damaged goods, or other relevant observations.',
    `count_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the physical count activity began for this inventory event.',
    `count_status` STRING COMMENT 'Current lifecycle status of the physical inventory count event: planned (scheduled but not started), in-progress (counting underway), completed (count finished awaiting approval), posted (variance posted to system), cancelled, or on-hold.. Valid values are `planned|in_progress|completed|posted|cancelled|on_hold`',
    `count_type` STRING COMMENT 'Classification of the physical inventory count event: cycle count (periodic rotation), annual wall-to-wall (full facility), triggered count (post-movement discrepancy or system exception), spot check, variance recount, or regulatory audit.. Valid values are `cycle_count|annual_wall_to_wall|triggered_count|spot_check|variance_recount|regulatory_audit`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'Physically counted quantity recorded by the counter during the inventory count event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this physical inventory count record was first created in the system.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year when the count was performed, supporting periodic financial close and inventory valuation.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the physical inventory count was performed, supporting annual financial reporting and SOX compliance.',
    `freeze_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether inventory movements were frozen (blocked) during the count period to ensure accuracy and prevent discrepancies.',
    `inventory_category` STRING COMMENT 'High-level classification of the inventory being counted: raw material (silicon wafers, chemicals, gases, photomasks), WIP (Work in Process wafer lots), finished goods (packaged chips), die bank, consignment stock, or spare parts.. Valid values are `raw_material|wip|finished_goods|die_bank|consignment|spare_parts`',
    `inventory_count_number` STRING COMMENT 'The inventory count number of the physical inventory record in the inventory domain.',
    `kgd_status` STRING COMMENT 'Status indicating whether the die or chip inventory has been verified as Known Good Die (KGD) through electrical testing, is non-KGD (failed test), untested, or in quarantine pending test results.. Valid values are `kgd|non_kgd|untested|quarantine`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this physical inventory count record was last updated or modified in the system.',
    `lot_number` STRING COMMENT 'Lot or batch identifier for WIP wafer lots, die banks, or consignment stock being counted, enabling full traceability per IATF 16949 requirements.. Valid values are `^[A-Z0-9]{8,20}$`',
    `material_number` STRING COMMENT 'Unique identifier for the material being counted: raw materials (silicon wafers, chemicals, gases, photomasks), Work in Process (WIP) wafer lots, finished goods (packaged chips), or die bank inventory.. Valid values are `^[A-Z0-9-]{6,18}$`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the physical inventory record in the inventory domain.',
    `notes` STRING COMMENT 'The notes of the physical inventory record in the inventory domain.',
    `plant_code` STRING COMMENT 'Code identifying the manufacturing plant or facility where the physical count was performed.. Valid values are `^[A-Z0-9]{4,6}$`',
    `posting_date` DATE COMMENT 'The date on which the inventory variance was posted to the financial and inventory management system, adjusting book quantities and valuations.',
    `recount_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this count is a recount of a previously counted item due to variance exceeding tolerance thresholds or supervisor request.',
    `recount_reason` STRING COMMENT 'Reason code for why a recount was triggered: variance exceeds threshold, supervisor request, system discrepancy, damaged goods, quality hold, or initial count error.. Valid values are `variance_exceeds_threshold|supervisor_request|system_discrepancy|damaged_goods|quality_hold|initial_count_error`',
    `recount_required_flag` BOOLEAN COMMENT 'The recount required flag of the physical inventory record in the inventory domain.',
    `shelf_life_expiry_date` DATE COMMENT 'Expiration date for materials with limited shelf life (chemicals, photoresists, gases, adhesives), beyond which the material may not meet specification and must be disposed or retested.',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'Standard cost per unit of the material at the time of count, used for variance valuation and financial reporting.',
    `storage_condition_code` STRING COMMENT 'Code indicating required storage conditions for the material: ambient, controlled temperature, controlled humidity, nitrogen purge (for moisture-sensitive devices), vacuum, or cleanroom environment.. Valid values are `ambient|controlled_temp|controlled_humidity|nitrogen_purge|vacuum|cleanroom`',
    `system_quantity` DECIMAL(18,2) COMMENT 'The system quantity of the physical inventory record in the inventory domain.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the counted quantity: EA (each for wafers or chips), KG (kilograms for chemicals), L (liters for gases or liquids), or other standard UOM codes.. Valid values are `^[A-Z]{2,6}$`',
    `variance_exceeds_tolerance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the calculated variance exceeds the defined tolerance threshold, requiring investigation or recount per quality management procedures.',
    `variance_percent` DECIMAL(18,2) COMMENT 'The variance percent of the physical inventory record in the inventory domain.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Calculated difference between counted quantity and book quantity (counted minus book), representing inventory discrepancy. Positive values indicate surplus, negative values indicate shortage.',
    `variance_tolerance_pct` DECIMAL(18,2) COMMENT 'Acceptable variance tolerance percentage for this count event, beyond which a recount or investigation is triggered. Typically set per material category and value class.',
    `variance_value` DECIMAL(18,2) COMMENT 'The variance value of the physical inventory record in the inventory domain.',
    `variance_value_usd` DECIMAL(18,2) COMMENT 'Financial value of the inventory variance in US dollars, calculated as variance quantity multiplied by standard cost or moving average price. Critical for SOX Section 404 financial controls and inventory valuation accuracy.',
    CONSTRAINT pk_physical_inventory PRIMARY KEY(`physical_inventory_id`)
) COMMENT 'Transactional record of physical inventory count events including cycle counts, annual wall-to-wall counts, and triggered counts (post-movement discrepancy or system exception). Captures count document number, count date, material/lot reference, storage location, system book quantity, physically counted quantity, variance quantity, variance value, count status (planned/in-progress/completed/posted), recount flag, counter ID, supervisor approval, and posting date. Supports SOX Section 404 financial controls, IATF 16949 inventory accuracy requirements, and ISO 9001 documented evidence of stock verification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` (
    `consignment_stock_id` BIGINT COMMENT 'Unique identifier for the consignment stock record. Primary key.',
    `account_id` BIGINT COMMENT 'Unique identifier for the account record within the consignment stock inventory entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to invoice.ar_invoice. Business justification: Consignment Billing Report ties each consignment stock record to the customer invoice that records consumption for revenue and inventory valuation.',
    `consignment_agreement_id` BIGINT COMMENT 'Business identifier for the consignment agreement governing this stock arrangement between the semiconductor company and the OSAT partner or VMI hub.',
    `die_bank_id` BIGINT COMMENT 'FK to inventory.die_bank.die_bank_id — Consignment stock at OSAT partners frequently consists of die bank inventory (KGD dies sent for packaging). This is a primary use case in fabless semiconductor model.',
    `storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Consignment stock is held at specific OSAT partner locations. Required for consignment reconciliation and liability tracking.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Reference to the originating wafer lot for traceability of consigned die or finished goods.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or die bank being consigned (finished goods, die banks, or raw materials).',
    `osat_vendor_id` BIGINT COMMENT 'Reference to the OSAT partner or customer VMI hub where the consignment stock is physically located.',
    `primary_consignment_die_bank_id` BIGINT COMMENT 'Reference to the die bank if the consignment stock consists of Known Good Die (KGD) awaiting packaging.',
    `primary_consignment_storage_location_id` BIGINT COMMENT 'FK to inventory.storage_location.storage_location_id — Consignment stock must reference the OSAT/partner storage location for reconciliation and ownership transfer.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the consignment stock inventory entity.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: CONSIGNMENT: Consigned inventory is owned by a supplier; the FK identifies the responsible supplier for liability and settlement.',
    `agreement_end_date` DATE COMMENT 'The agreement end date associated with the consignment stock inventory record.',
    `agreement_start_date` DATE COMMENT 'The agreement start date associated with the consignment stock inventory record.',
    `available_quantity` DECIMAL(18,2) COMMENT 'Quantity of consigned material currently available at the OSAT partner location for consumption.',
    `bin_location` STRING COMMENT 'Specific bin or rack location within the OSAT partner warehouse where the consignment stock is stored.',
    `consigned_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material consigned to the OSAT partner or VMI hub under this agreement.',
    `consignment_expiry_date` DATE COMMENT 'Date when the consignment agreement expires or when the material must be consumed, returned, or settled.',
    `consignment_number` STRING COMMENT 'The consignment number of the consignment stock record in the inventory domain.',
    `consignment_start_date` DATE COMMENT 'Date when the material was first consigned to the OSAT partner or VMI hub under this agreement.',
    `consignment_status` STRING COMMENT 'Current lifecycle status of the consignment stock record.. Valid values are `active|in_transit|consumed|returned|settled|expired`',
    `consignment_stock_status` STRING COMMENT 'The status of the consignment stock record in the inventory domain.',
    `consignment_type` STRING COMMENT 'Type of consignment arrangement: OSAT assembly, OSAT test, vendor-managed inventory hub, or customer consignment.. Valid values are `osat_assembly|osat_test|vmi_hub|customer_consignment`',
    `consignment_value_usd` DECIMAL(18,2) COMMENT 'The consignment value usd of the consignment stock record in the inventory domain.',
    `consumed_quantity` DECIMAL(18,2) COMMENT 'Quantity of consigned material that has been consumed or used by the OSAT partner, triggering ownership transfer.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the consigned material was manufactured or substantially transformed.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consignment stock record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for valuation and settlement amounts.. Valid values are `^[A-Z]{3}$`',
    `eccn_number` STRING COMMENT 'Export Control Classification Number assigned to the consigned material under US Export Administration Regulations.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity of consigned material currently in transit to or from the OSAT partner or VMI hub.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the consigned material is subject to ITAR export control regulations.',
    `kgd_status` STRING COMMENT 'Indicates whether the consigned die or material has been tested and certified as Known Good Die.. Valid values are `kgd|non_kgd|untested|mixed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consignment stock record in the inventory domain.',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent consignment stock reconciliation between the semiconductor company and the OSAT partner.',
    `last_settlement_date` DATE COMMENT 'Date of the most recent financial settlement for consumed consignment stock with the OSAT partner.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consignment stock record was most recently updated or modified.',
    `liability_aging_days` STRING COMMENT 'Number of days the consignment stock has been at the OSAT partner location, used for aging analysis and liability reporting.',
    `lot_traceability_code` STRING COMMENT 'Traceability code linking the consigned material to its manufacturing lot, wafer lot, and production history for quality and compliance tracking.',
    `max_stock_level` DECIMAL(18,2) COMMENT 'The max stock level of the consignment stock record in the inventory domain.',
    `min_stock_level` DECIMAL(18,2) COMMENT 'The min stock level of the consignment stock record in the inventory domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the consignment stock record in the inventory domain.',
    `msd_level` STRING COMMENT 'JEDEC moisture sensitivity level classification for the consigned material, indicating required storage and handling conditions. [ENUM-REF-CANDIDATE: 1|2|2a|3|4|5|5a|6 — 8 candidates stripped; promote to reference product]',
    `next_reconciliation_due_date` DATE COMMENT 'Scheduled date for the next consignment stock reconciliation based on the reconciliation frequency.',
    `ownership` STRING COMMENT 'The ownership of the consignment stock record in the inventory domain.',
    `ownership_party` STRING COMMENT 'The ownership party of the consignment stock record in the inventory domain.',
    `ownership_transfer_trigger` STRING COMMENT 'Event that triggers ownership transfer from the semiconductor company to the OSAT partner: consumption, shipment, time-based, or withdrawal.. Valid values are `consumption|shipment|time_based|withdrawal`',
    `quantity_consumed` STRING COMMENT 'The quantity consumed of the consignment stock record in the inventory domain.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The quantity on hand of the consignment stock record in the inventory domain.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the consigned material complies with EU REACH regulation for chemical substance safety.',
    `reconciliation_frequency` STRING COMMENT 'Frequency at which consignment stock levels are reconciled between the semiconductor company and the OSAT partner.. Valid values are `daily|weekly|biweekly|monthly|quarterly`',
    `returned_quantity` DECIMAL(18,2) COMMENT 'Quantity of consigned material returned to the semiconductor company from the OSAT partner or VMI hub.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the consigned material complies with EU RoHS directive restricting hazardous substances in electronic equipment.',
    `settlement_document_reference` STRING COMMENT 'Reference number of the most recent settlement document or invoice generated for consumed consignment stock.',
    `settlement_frequency` STRING COMMENT 'The settlement frequency of the consignment stock record in the inventory domain.',
    `settlement_terms` STRING COMMENT 'The settlement terms of the consignment stock record in the inventory domain.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the consigned material can be stored before it must be used or returned, applicable to moisture-sensitive devices.',
    `shelf_life_expiry_date` DATE COMMENT 'Date when the consigned material reaches the end of its shelf life and must be consumed, returned, or scrapped.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost of the consigned material used for inventory valuation and settlement calculations.',
    `stock_status` STRING COMMENT 'The stock status of the consignment stock record in the inventory domain.',
    `storage_humidity_max_pct` DECIMAL(18,2) COMMENT 'Maximum relative humidity percentage allowed for storage of the consigned material at the OSAT partner location.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius required for the consigned material at the OSAT partner location.',
    `total_valuation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the consigned stock at the OSAT partner location, calculated as available quantity times standard cost.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the consigned material quantities (each, piece, kilogram, wafer, die, etc.). [ENUM-REF-CANDIDATE: EA|PC|KG|LB|M|FT|L|GAL|WAFER|DIE — 10 candidates stripped; promote to reference product]',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The valuation amount of the consignment stock record in the inventory domain.',
    CONSTRAINT pk_consignment_stock PRIMARY KEY(`consignment_stock_id`)
) COMMENT 'Master record for inventory consigned to OSAT assembly/test partners or customer vendor-managed inventory (VMI) hubs where ownership transfers upon consumption or shipment. Tracks consignment agreement ID, OSAT partner reference, material/die bank reference, consigned quantity, consumed quantity, returned quantity, in-transit quantity, ownership transfer trigger (consumption/shipment/time-based), valuation currency, reconciliation frequency (weekly/monthly), last reconciliation date, settlement document reference, and liability aging. Enables monthly consignment settlement with OSAT partners, VMI replenishment automation, and accurate liability reporting for finance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` (
    `stock_valuation_id` BIGINT COMMENT 'Primary key for stock_valuation',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links each stock valuation record to the cost center that bears the inventory cost for reporting.',
    `finished_good_id` BIGINT COMMENT 'Unique identifier for the finished good record within the stock valuation inventory entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Associates valuation entries with a GL account to post inventory value changes to the ledger.',
    `stock_balance_id` BIGINT COMMENT 'FK to inventory.stock_balance.stock_balance_id — Financial valuation must reference the quantity position it values. Links financial and physical inventory views.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record being valued (raw material, WIP wafer lot, die bank, or finished good).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supports profit‑center‑level inventory valuation for margin analysis across product lines.',
    `raw_material_id` BIGINT COMMENT 'Unique identifier for the raw material record within the stock valuation inventory entity.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the stock valuation inventory entity.',
    `stock_material_master_id` BIGINT COMMENT 'Unique identifier for the stock material master record within the stock valuation inventory entity.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: stock_valuation tracks valuation per location using a code; a FK to storage_location provides referential integrity and eliminates duplicate location data.',
    `bin_classification` STRING COMMENT 'The test bin classification code indicating the quality grade and performance characteristics of the die or packaged chip.',
    `cost_center` STRING COMMENT 'The cost center responsible for the inventory and its associated costs.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory valuation record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this valuation record.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for this valuation record.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this valuation record belongs, supporting period-based financial reporting.',
    `inventory_category` STRING COMMENT 'The category of inventory being valued: raw material (silicon wafers, chemicals, gases, photomasks), WIP (Work In Process) wafer lots, die bank, finished goods (packaged chips), consignment stock at OSAT partners, or MPW (Multi-Project Wafer) shuttle.. Valid values are `raw_material|wip|die_bank|finished_good|consignment|mpw_shuttle`',
    `is_consignment` BOOLEAN COMMENT 'Indicates whether this inventory is consignment stock held at an OSAT (Outsourced Semiconductor Assembly and Test) partner or customer location, affecting ownership and valuation treatment.',
    `kgd_status` STRING COMMENT 'Indicates whether the die or wafer lot has been tested and verified as Known Good Die (KGD), critical for die bank and finished goods valuation.. Valid values are `kgd|non_kgd|untested|pending`',
    `labor_cost` DECIMAL(18,2) COMMENT 'The direct labor cost component allocated to the inventory valuation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory valuation record was last updated or modified.',
    `last_valuation_date` DATE COMMENT 'The date of the previous valuation calculation for this inventory position, enabling period-over-period variance analysis.',
    `lot_number` STRING COMMENT 'The wafer lot number or batch identifier for WIP and die bank inventory, enabling full traceability.',
    `material_cost` DECIMAL(18,2) COMMENT 'The direct material cost component of the valuation (silicon wafers, chemicals, gases, photomasks, packaging materials).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the stock valuation record in the inventory domain.',
    `moving_average_cost_usd` DECIMAL(18,2) COMMENT 'The moving average cost usd of the stock valuation record in the inventory domain.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'The moving average price per unit, recalculated with each goods receipt when using moving average valuation.',
    `moving_avg_price` DECIMAL(18,2) COMMENT 'The moving avg price of the stock valuation record in the inventory domain.',
    `nre_cost_allocation` DECIMAL(18,2) COMMENT 'The allocated portion of NRE costs (design, tapeout, mask set, PDK licensing) amortized into the inventory valuation.',
    `obsolescence_reserve_usd` DECIMAL(18,2) COMMENT 'The obsolescence reserve usd of the stock valuation record in the inventory domain.',
    `overhead_cost` DECIMAL(18,2) COMMENT 'The manufacturing overhead cost component (facility, equipment depreciation, utilities) allocated to the inventory valuation.',
    `plant_code` STRING COMMENT 'The fabrication facility (FAB) or manufacturing plant code where the inventory is located.',
    `price_unit` STRING COMMENT 'The price unit of the stock valuation record in the inventory domain.',
    `price_variance_usd` DECIMAL(18,2) COMMENT 'The price variance usd of the stock valuation record in the inventory domain.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The physical quantity of inventory on hand at the valuation date.',
    `quantity_valued` DECIMAL(18,2) COMMENT 'The quantity valued of the stock valuation record in the inventory domain.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the inventory item complies with EU REACH regulation for chemical substance safety.',
    `revaluation_amount_usd` DECIMAL(18,2) COMMENT 'The revaluation amount usd of the stock valuation record in the inventory domain.',
    `revaluation_flag` BOOLEAN COMMENT 'The revaluation flag of the stock valuation record in the inventory domain.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the inventory item complies with EU RoHS directive restricting hazardous substances in electronic equipment.',
    `shelf_life_expiry_date` DATE COMMENT 'The date when the inventory item reaches the end of its shelf life and may require requalification or disposal, critical for chemicals, photomasks, and moisture-sensitive devices.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this valuation record is subject to SOX financial reporting controls and audit requirements.',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'The standard cost usd of the stock valuation record in the inventory domain.',
    `standard_price` DECIMAL(18,2) COMMENT 'The standard cost per unit as defined in the material master for standard costing valuation.',
    `total_quantity` DECIMAL(18,2) COMMENT 'The total quantity of the stock valuation record in the inventory domain.',
    `total_stock_value` DECIMAL(18,2) COMMENT 'The total financial value of the inventory position (quantity × unit price), representing the balance sheet valuation.',
    `total_value` DECIMAL(18,2) COMMENT 'The total value of the stock valuation record in the inventory domain.',
    `total_value_usd` DECIMAL(18,2) COMMENT 'The total value usd of the stock valuation record in the inventory domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity (e.g., EA for each/die, WF for wafer, KG for kilograms, LT for liters).',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The valuation amount of the stock valuation record in the inventory domain.',
    `valuation_class` STRING COMMENT 'The valuation class that groups materials for accounting purposes and determines the general ledger accounts for posting.',
    `valuation_date` DATE COMMENT 'The date on which the inventory valuation was calculated and recorded. Principal business event timestamp for this financial snapshot.',
    `valuation_method` STRING COMMENT 'The inventory costing method applied: standard cost, moving average price, FIFO (First In First Out), LIFO (Last In First Out), or weighted average.. Valid values are `standard_cost|moving_average|fifo|lifo|weighted_average`',
    `valuation_status` STRING COMMENT 'The current status of the inventory valuation: active (available for use), blocked (restricted), quality hold (pending inspection), obsolete (end of life), or scrapped.. Valid values are `active|blocked|quality_hold|obsolete|scrapped`',
    `valuation_type` STRING COMMENT 'Classification of the valuation split (e.g., unrestricted use, quality inspection, blocked stock, consignment).',
    `valuation_variance` DECIMAL(18,2) COMMENT 'The variance between current and previous valuation amounts, highlighting inventory value changes for management review.',
    `wip_cost_accumulation` DECIMAL(18,2) COMMENT 'The accumulated manufacturing costs for WIP wafer lots, including FEOL (Front End of Line), MOL (Middle of Line), and BEOL (Back End of Line) processing costs.',
    `write_down_amount_usd` DECIMAL(18,2) COMMENT 'The write down amount usd of the stock valuation record in the inventory domain.',
    `yield_impact_factor` DECIMAL(18,2) COMMENT 'A factor representing the yield percentage impact on valuation, used to adjust WIP and die bank valuations based on expected good die yield.',
    CONSTRAINT pk_stock_valuation PRIMARY KEY(`stock_valuation_id`)
) COMMENT 'Transactional record capturing the financial valuation of inventory positions including WIP wafer lots, raw materials, die banks, and finished goods. Tracks valuation date, material or lot reference, valuation class, valuation method (standard cost/moving average/FIFO), standard price, moving average price, total stock value, WIP cost accumulation, NRE cost allocation, currency, and cost center. Supports SAP CO-PC product costing and SOX financial reporting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` (
    `inventory_kgd_certification_id` BIGINT COMMENT 'Unique identifier for the KGD certification record. Primary key for the certification transaction.',
    `allocation_record_id` BIGINT COMMENT 'Reference to the customer allocation record if this KGD certification is tied to a specific customer order or design-win. Enables customer-specific quality tracking.',
    `die_bank_id` BIGINT COMMENT 'Reference to the die bank inventory that this certification applies to. Links the certification to the specific die bank lot being certified.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the inventory kgd certification inventory entity.',
    `certification_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `employee_id` BIGINT COMMENT 'Unique identifier for the inventory certified by employee record within the inventory kgd certification inventory entity.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Reference to the originating wafer lot from which the die bank was created. Provides full upstream traceability to fabrication.',
    `primary_inventory_employee_id` BIGINT COMMENT 'Reference to the quality engineer who performed the certification and signed off on the KGD status. Provides accountability and traceability.',
    `primary_inventory_quality_kgd_certification_id` BIGINT COMMENT 'Unique identifier for the primary inventory quality kgd certification record within the inventory kgd certification inventory entity.',
    `primary_quality_kgd_certification_id` BIGINT COMMENT 'Unique identifier for the primary quality kgd certification record within the inventory kgd certification inventory entity.',
    `probe_card_id` BIGINT COMMENT 'Identifier of the probe card used during wafer-level testing. Critical for correlating test results with probe card condition and maintenance.',
    `quality_kgd_certification_id` BIGINT COMMENT 'SSOT reference to authoritative owner quality.quality_kgd_certification for concept kgd_certification',
    `ate_equipment_code` STRING COMMENT 'Identifier of the Automatic Test Equipment (ATE) used for electrical testing. Enables equipment-specific yield analysis and calibration tracking.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `bin_1_count` STRING COMMENT 'Number of die classified as Bin 1 (highest quality, full specification pass). Prime die suitable for all applications.',
    `bin_2_count` STRING COMMENT 'Number of die classified as Bin 2 (good quality with minor parametric variations). Suitable for most applications.',
    `bin_3_count` STRING COMMENT 'Number of die classified as Bin 3 (acceptable quality with reduced specifications). May be suitable for specific applications or downgraded products.',
    `burn_in_completed_flag` BOOLEAN COMMENT 'The burn in completed flag of the inventory kgd certification record in the inventory domain.',
    `burn_in_duration_hours` STRING COMMENT 'Duration in hours for which the die were subjected to burn-in stress testing. Typical values range from 48 to 168 hours.',
    `burn_in_temperature_c` STRING COMMENT 'Temperature in degrees Celsius at which burn-in testing was performed. Typical values are 125°C or 150°C.',
    `burn_in_test_result` STRING COMMENT 'Result of high-temperature operating life (HTOL) burn-in stress testing. Identifies early-life failures and ensures reliability.. Valid values are `pass|fail|not_performed|conditional_pass`',
    `certificate_number` STRING COMMENT 'The certificate number of the inventory kgd certification record in the inventory domain.',
    `certification_date` DATE COMMENT 'Date on which the KGD certification was issued. Represents the business event timestamp when the die bank was officially certified as Known Good Die.',
    `certification_expiry_date` DATE COMMENT 'Date on which the KGD certification expires. After this date, die must be re-certified or scrapped based on shelf-life and storage conditions.',
    `certification_number` STRING COMMENT 'Business identifier for the KGD certification. Externally-known unique code used for traceability and customer communication.. Valid values are `^KGD-[A-Z0-9]{8,16}$`',
    `certification_standard` STRING COMMENT 'The certification standard of the inventory kgd certification record in the inventory domain.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the KGD certification. Indicates whether the certification is active, expired, or has been revoked due to quality issues.. Valid values are `certified|expired|revoked|pending|conditional`',
    `certified_die_count` STRING COMMENT 'The certified die count of the inventory kgd certification record in the inventory domain.',
    `certified_quantity` BIGINT COMMENT 'The certified quantity of the inventory kgd certification record in the inventory domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this KGD certification record was first created in the system. Audit trail for data lineage and compliance.',
    `dppm_level` DECIMAL(18,2) COMMENT 'The dppm level of the inventory kgd certification record in the inventory domain.',
    `dppm_rate` DECIMAL(18,2) COMMENT 'Calculated defect rate in parts per million for this KGD certification batch. Key quality metric for customer quality agreements and Six Sigma tracking.',
    `dppm_value` DECIMAL(18,2) COMMENT 'The dppm value of the inventory kgd certification record in the inventory domain.',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned to the certified KGD under US Export Administration Regulations (EAR). Determines export licensing requirements.. Valid values are `^[0-9][A-Z][0-9]{3}(.[a-z])?$`',
    `electrical_test_pass_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of die that passed comprehensive electrical parametric testing during KGD certification. Includes DC, AC, and functional tests.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the inventory kgd certification inventory record.',
    `fail_bin_count` STRING COMMENT 'Total number of die classified into fail bins (did not meet minimum electrical or functional specifications). Not certified as KGD.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the certified KGD is subject to ITAR export control regulations due to defense or military applications.',
    `kgd_grade` STRING COMMENT 'Quality grade assigned to the certified KGD. Grade A is highest quality for mission-critical applications; Grade B for commercial; Grade C for cost-sensitive applications.. Valid values are `grade_a|grade_b|grade_c|engineering_sample`',
    `known_good_die_count` STRING COMMENT 'The known good die count of the inventory kgd certification record in the inventory domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this KGD certification record was last updated. Tracks changes for audit trail and data governance.',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `notes` STRING COMMENT 'The notes of the inventory kgd certification record in the inventory domain.',
    `packaging_application` STRING COMMENT 'Intended advanced packaging technology for which the KGD is certified. Includes Chip on Wafer on Substrate (CoWoS), Integrated Fan-Out (InFO), Through-Silicon Via (TSV), or direct die shipment.. Valid values are `cowos|info|tsv|standard_wirebond|flip_chip|direct_die_shipment`',
    `probe_yield_pct` DECIMAL(18,2) COMMENT 'Percentage of die that passed wafer probe testing. Key quality metric indicating the proportion of functional die before singulation.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether the certified KGD is currently under quality hold due to suspected reliability issues, customer complaints, or internal quality alerts.',
    `quality_hold_reason` STRING COMMENT 'Detailed explanation of why the KGD certification is under quality hold. Includes root cause analysis reference and corrective action plan.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the certified KGD meets EU REACH Regulation requirements for chemical substance registration and safety.',
    `reliability_qualified_flag` BOOLEAN COMMENT 'The reliability qualified flag of the inventory kgd certification record in the inventory domain.',
    `reliability_screen_result` STRING COMMENT 'Result of comprehensive reliability screening tests including temperature cycling, humidity exposure, and electrostatic discharge (ESD) testing.. Valid values are `pass|fail|not_performed|conditional_pass`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special handling instructions, or deviations from standard certification procedures. Used for audit trail and quality documentation.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the certified KGD meets EU RoHS Directive requirements for restriction of hazardous substances (lead, mercury, cadmium, etc.).',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the kgd_certification concept (quality.quality_kgd_certification)',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'The test coverage percent of the inventory kgd certification record in the inventory domain.',
    `test_facility_code` STRING COMMENT 'Code identifying the test facility (internal or Outsourced Semiconductor Assembly and Test partner) where KGD certification testing was performed.. Valid values are `^[A-Z0-9]{3,10}$`',
    `test_program_reference` STRING COMMENT 'The test program reference of the inventory kgd certification record in the inventory domain.',
    `test_program_version` STRING COMMENT 'Version identifier of the Automatic Test Equipment (ATE) test program used for electrical and functional testing during KGD certification.. Valid values are `^[A-Z0-9._-]{1,50}$`',
    `tested_die_count` STRING COMMENT 'The tested die count of the inventory kgd certification record in the inventory domain.',
    `yield_percent` DECIMAL(18,2) COMMENT 'The yield percent of the inventory kgd certification record in the inventory domain.',
    CONSTRAINT pk_inventory_kgd_certification PRIMARY KEY(`inventory_kgd_certification_id`)
) COMMENT 'Transactional record documenting the Known Good Die (KGD) certification status for die bank inventory. Captures certification ID, die bank reference, wafer lot origin, test program version, probe yield percentage, bin distribution, electrical test pass rate, burn-in test result, reliability screen result, certification date, certifying engineer, certification expiry date, and KGD grade. Drives die allocation for advanced packaging (CoWoS, InFO, TSV) and direct die shipments.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` (
    `inventory_lot_genealogy_id` BIGINT COMMENT 'Unique identifier for the lot genealogy association record. Primary key for traceability relationships between wafer lots, die banks, and finished goods across manufacturing transformations.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who executed or supervised the transformation operation. Used for training effectiveness analysis and quality investigation.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the manufacturing equipment that performed the transformation. Links to equipment master data for tool-specific traceability and FMEA analysis.',
    `fabrication_lot_genealogy_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `inventory_fabrication_lot_genealogy_id` BIGINT COMMENT 'SSOT reference to authoritative owner fabrication.fabrication_lot_genealogy for concept lot_genealogy',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the parent inventory wafer lot record within the inventory lot genealogy inventory entity.',
    `parent_lot_id` BIGINT COMMENT 'Unique identifier for the parent lot record within the inventory lot genealogy inventory entity.',
    `primary_fabrication_lot_genealogy_id` BIGINT COMMENT 'Unique identifier for the primary fabrication lot genealogy record within the inventory lot genealogy inventory entity.',
    `primary_inventory_fabrication_lot_genealogy_id` BIGINT COMMENT 'Unique identifier for the primary inventory fabrication lot genealogy record within the inventory lot genealogy inventory entity.',
    `primary_inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: inventory_lot_genealogy already captures parent/child IDs generically; adding a direct FK to the wafer lot simplifies lineage queries without removing existing generic columns.',
    `automotive_ppap_required` BOOLEAN COMMENT 'Indicates whether this transformation requires PPAP documentation for automotive customers. True for new products, process changes, or supplier changes affecting automotive-qualified parts.',
    `bin_classification` STRING COMMENT 'Bin classification assigned to the child entity after transformation. Identifies pass/fail status and performance grade for Known Good Die (KGD) tracking.',
    `child_entity_reference` BIGINT COMMENT 'Unique identifier of the child entity. References the specific wafer lot, die bank, or finished good that resulted from the transformation process.',
    `child_entity_type` STRING COMMENT 'Type of the child entity in the genealogy relationship. Identifies whether the output material is a wafer lot, die bank, or finished good after transformation.. Valid values are `wafer_lot|die_bank|finished_good`',
    `child_lot_number` STRING COMMENT 'The child lot number of the inventory lot genealogy record in the inventory domain.',
    `comments` STRING COMMENT 'Free-text comments or notes about the transformation operation. Captures operator observations, special handling instructions, or investigation findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the genealogy record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether customer notification is required for this transformation. True for significant process changes, rework operations, or quality excursions that trigger PCN or customer alert requirements.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp of the inventory lot genealogy record in the inventory domain.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility or OSAT partner site where the transformation occurred. Critical for multi-site traceability and supply chain visibility.',
    `genealogy_path` STRING COMMENT 'File system or storage genealogy path for the inventory lot genealogy inventory record.',
    `genealogy_status` STRING COMMENT 'Current status of the genealogy record. Active indicates ongoing transformation, completed indicates finished operation, voided indicates cancelled or reversed transaction, under_investigation indicates quality review in progress.. Valid values are `active|completed|voided|under_investigation`',
    `genealogy_type` STRING COMMENT 'The genealogy type of the inventory lot genealogy record in the inventory domain.',
    `kgd_status` STRING COMMENT 'Known Good Die status of the child entity. Indicates whether the output material has passed all quality gates and is approved for customer shipment or further assembly.. Valid values are `kgd|non_kgd|pending|quarantine`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the genealogy record was last updated. Tracks changes to transformation data for compliance and investigation purposes.',
    `level_depth` STRING COMMENT 'The level depth of the inventory lot genealogy record in the inventory domain.',
    `lot_traceability_code` STRING COMMENT 'Composite traceability code combining parent and child lot identifiers. Used for rapid lookup during customer complaint investigations and field return analysis.',
    `merge_indicator` BOOLEAN COMMENT 'The merge indicator of the inventory lot genealogy record in the inventory domain.',
    `merge_sequence` STRING COMMENT 'The merge sequence of the inventory lot genealogy record in the inventory domain.',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `parent_entity_reference` BIGINT COMMENT 'Unique identifier of the parent entity. References the specific wafer lot, die bank, or finished good that served as input to the transformation process.',
    `parent_entity_type` STRING COMMENT 'Type of the parent entity in the genealogy relationship. Identifies whether the source material is a wafer lot, die bank, finished good, or raw material before transformation.. Valid values are `wafer_lot|die_bank|finished_good|raw_material`',
    `pcn_reference_number` STRING COMMENT 'Reference number of the Product Change Notification associated with this transformation. Links genealogy to formal customer communication for process or material changes.',
    `process_step_code` STRING COMMENT 'Manufacturing process step code where the transformation occurred. References the specific operation in the process flow (e.g., wafer probe, die saw, wire bond, final test).',
    `process_step_name` STRING COMMENT 'Human-readable name of the manufacturing process step. Provides business context for the transformation operation.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether the child entity is under quality hold. True if material is blocked from further processing or shipment pending investigation.',
    `quality_hold_reason` STRING COMMENT 'Reason for quality hold if quality_hold_flag is true. Documents the specific quality issue requiring investigation or containment action.',
    `quantity_in` DECIMAL(18,2) COMMENT 'Quantity of parent entity material consumed in the transformation. Measured in units appropriate to parent entity type (wafers, dies, or packaged units).',
    `quantity_out` DECIMAL(18,2) COMMENT 'Quantity of child entity material produced by the transformation. Measured in units appropriate to child entity type (wafers, dies, or packaged units).',
    `quantity_transferred` STRING COMMENT 'The quantity transferred of the inventory lot genealogy record in the inventory domain.',
    `relationship_type` STRING COMMENT 'Type of transformation relationship between parent and child entities. Defines the manufacturing operation that created the genealogy link: split (one-to-many), merge (many-to-one), rework, retest, package, assembly, die attach, wire bond, molding, or singulation. [ENUM-REF-CANDIDATE: split|merge|rework|retest|package|assembly|die_attach|wire_bond|molding|singulation — 10 candidates stripped; promote to reference product]',
    `rework_cycle_count` STRING COMMENT 'Number of rework cycles applied to the material. Tracks cumulative rework history for quality risk assessment and customer notification requirements.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scrapped during the transformation operation. Used for yield loss analysis and cost accounting.',
    `scrap_reason_code` STRING COMMENT 'Code identifying the reason for material scrap. Links to defect classification taxonomy for root cause analysis and FMEA.',
    `source_operation` STRING COMMENT 'The source operation of the inventory lot genealogy record in the inventory domain.',
    `split_quantity` STRING COMMENT 'The split quantity of the inventory lot genealogy record in the inventory domain.',
    `split_sequence` STRING COMMENT 'The split sequence of the inventory lot genealogy record in the inventory domain.',
    `split_sequence_number` STRING COMMENT 'The split sequence number of the inventory lot genealogy record in the inventory domain.',
    `test_program_version` STRING COMMENT 'Version of the test program used during transformation (for retest operations). Critical for correlating test results across genealogy and validating test program changes.',
    `traceability_notes` STRING COMMENT 'The traceability notes of the inventory lot genealogy record in the inventory domain.',
    `transaction_timestamp` TIMESTAMP COMMENT 'The transaction timestamp of the inventory lot genealogy record in the inventory domain.',
    `transaction_type` STRING COMMENT 'The transaction type of the inventory lot genealogy record in the inventory domain.',
    `transformation_date` DATE COMMENT 'The transformation date associated with the inventory lot genealogy inventory record.',
    `transformation_timestamp` TIMESTAMP COMMENT 'Date and time when the transformation operation occurred. Critical for forward and backward traceability in automotive PPAP documentation and field return investigations.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantity tracking. Specifies whether quantities are counted in wafers, dies, packaged units, kilograms, or liters depending on material type.. Valid values are `wafer|die|unit|kg|liter`',
    `work_order_number` STRING COMMENT 'Manufacturing work order number authorizing the transformation operation. Links genealogy to production planning and scheduling systems.',
    `yield_at_transformation_pct` DECIMAL(18,2) COMMENT 'Yield percentage achieved during the transformation operation. Calculated as (quantity_out / quantity_in) * 100. Critical for process capability analysis and SPC monitoring.',
    CONSTRAINT pk_inventory_lot_genealogy PRIMARY KEY(`inventory_lot_genealogy_id`)
) COMMENT 'Association record capturing parent-child relationships between wafer lots, die banks, and finished goods to enable full forward and backward traceability across split, merge, rework, retest, and packaging transformations. Tracks genealogy record ID, parent entity type and ID, child entity type and ID, relationship type (split/merge/rework/retest/package), transformation date, quantity in, quantity out, yield at transformation, process step at split/merge, and operator reference. Supports IATF 16949 traceability, automotive PPAP documentation, customer complaint root cause analysis, and field return investigation.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` (
    `reservation_id` BIGINT COMMENT 'System-generated unique identifier for the inventory reservation record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the reservation, if applicable.',
    `goods_movement_id` BIGINT COMMENT 'Reference to the goods movement that will consume the reservation.',
    `finished_good_id` BIGINT COMMENT 'Unique identifier for the finished good record within the reservation inventory entity.',
    `material_master_id` BIGINT COMMENT 'Identifier of the raw material or finished‑good SKU associated with the reservation.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who performed the reservation.',
    `order_id` BIGINT COMMENT 'Unique identifier for the primary order record within the reservation inventory entity.',
    `reservation_reserved_by_employee_id` BIGINT COMMENT 'Unique identifier for the reserved by employee record within the reservation inventory entity.',
    `reservation_sales_order_id` BIGINT COMMENT 'Unique identifier for the sales order record within the reservation inventory entity.',
    `sku_id` BIGINT COMMENT 'Unique identifier for the sku record within the reservation inventory entity.',
    `split_from_reservation_id` BIGINT COMMENT 'Self-referencing FK on reservation (split_from_reservation_id)',
    `stock_balance_id` BIGINT COMMENT 'Unique identifier for the stock balance record within the reservation inventory entity.',
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location record within the reservation inventory entity.',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer or material lot that is being reserved.',
    `auto_release_flag` BOOLEAN COMMENT 'The auto release flag of the reservation record in the inventory domain.',
    `bin_classification` STRING COMMENT 'Classification of the inventory bin (e.g., A, B, C) used for yield or quality segregation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reservation record was first captured in the lakehouse.',
    `demand_source_reference` BIGINT COMMENT 'Identifier of the originating demand record (e.g., sales order, production order).',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation automatically expires if not consumed.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the reservation inventory record.',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'The fulfilled quantity of the reservation record in the inventory domain.',
    `inventory_status` STRING COMMENT 'Current operational status of the reserved inventory (e.g., available, on_hold).',
    `is_kgd` BOOLEAN COMMENT 'Indicates whether the reservation is for KGD‑qualified inventory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the reservation record in the inventory domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the reservation record in the inventory domain.',
    `notes` STRING COMMENT 'The notes of the reservation record in the inventory domain.',
    `priority` STRING COMMENT 'Business priority used for allocation sequencing.. Valid values are `high|medium|low`',
    `reason` STRING COMMENT 'Free‑text explanation for why the reservation was created.',
    `reference_document` STRING COMMENT 'The reference document of the reservation record in the inventory domain.',
    `reference_document_type` STRING COMMENT 'The reference document type of the reservation record in the inventory domain.',
    `requested_delivery_date` DATE COMMENT 'Customer‑or‑production requested date for the reserved inventory to be delivered.',
    `required_by_date` DATE COMMENT 'The required by date associated with the reservation inventory record.',
    `required_date` DATE COMMENT 'The required date associated with the reservation inventory record.',
    `requirement_date` DATE COMMENT 'The requirement date associated with the reservation inventory record.',
    `reservation_date` DATE COMMENT 'The date associated with the reservation inventory record.',
    `reservation_number` STRING COMMENT 'Business-visible reservation code used in communications and reporting.',
    `reservation_status` STRING COMMENT 'Current lifecycle state of the reservation.. Valid values are `active|consumed|cancelled|expired`',
    `reservation_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation was created in the source system.',
    `reservation_type` STRING COMMENT 'Category of demand source that triggered the reservation.. Valid values are `customer_order|production_order|packaging_run|engineering_sample`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Amount of inventory units earmarked by the reservation.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the reserved quantity (e.g., pcs, wafers, kg).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the reservation record.',
    CONSTRAINT pk_reservation PRIMARY KEY(`reservation_id`)
) COMMENT 'Transactional record for inventory allocation and reservation events that earmark specific quantities of WIP lots, die bank dies, raw materials, or finished goods for a designated demand source (customer order, production order, packaging run, engineering sample request). Captures reservation ID, material/lot reference, reserved quantity, UoM, demand source type and ID, reservation date, requested delivery date, priority, reservation status (active/consumed/cancelled/expired), consuming goods_movement reference, and reserving user. Enables ATP (available-to-promise) calculations, prevents double-allocation of scarce KGD inventory, and supports OSAT packaging run scheduling.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_primary_die_storage_location_id` FOREIGN KEY (`primary_die_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_primary_storage_location_id` FOREIGN KEY (`primary_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_parent_storage_location_id` FOREIGN KEY (`parent_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_primary_stock_raw_material_id` FOREIGN KEY (`primary_stock_raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_stock_storage_location_id` FOREIGN KEY (`stock_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_from_storage_location_id` FOREIGN KEY (`from_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_stock_balance_id` FOREIGN KEY (`stock_balance_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_goods_storage_location_id` FOREIGN KEY (`goods_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_primary_goods_stock_balance_id` FOREIGN KEY (`primary_goods_stock_balance_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_primary_goods_storage_location_id` FOREIGN KEY (`primary_goods_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_source_storage_location_id` FOREIGN KEY (`source_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_to_storage_location_id` FOREIGN KEY (`to_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_primary_storage_location_id` FOREIGN KEY (`primary_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_primary_consignment_die_bank_id` FOREIGN KEY (`primary_consignment_die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_primary_consignment_storage_location_id` FOREIGN KEY (`primary_consignment_storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_stock_balance_id` FOREIGN KEY (`stock_balance_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ADD CONSTRAINT `fk_inventory_inventory_kgd_certification_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_parent_lot_id` FOREIGN KEY (`parent_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ADD CONSTRAINT `fk_inventory_inventory_lot_genealogy_primary_inventory_wafer_lot_id` FOREIGN KEY (`primary_inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_split_from_reservation_id` FOREIGN KEY (`split_from_reservation_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`reservation`(`reservation_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_stock_balance_id` FOREIGN KEY (`stock_balance_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` SET TAGS ('dbx_subdomain' = 'material_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` SET TAGS ('dbx_ssot_owner' = 'fabrication.fabrication_wafer_lot');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `equipment_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Facility (FAB) ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Process Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `reticle_set_id` SET TAGS ('dbx_business_glossary_term' = 'Reticle Set ID (Photomask Set ID)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Fabrication Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `primary_inventory_fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID (Business Identifier)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `current_operation_step` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Step');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `die_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Die Per Wafer (DPW)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `good_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Good Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `hold_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `inventory_fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `inventory_fabrication_wafer_lot_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `inventory_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `inventory_valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type (Extreme Ultraviolet / Deep Ultraviolet)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|i-line|g-line');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `lot_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status (Work-in-Process Status)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|completed|scrapped|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'production|engineering|qualification|monitor|reliability');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `mes_lot_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Lot Reference');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `priority_class` SET TAGS ('dbx_value_regex' = 'hot|expedite|standard|low');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `process_stage` SET TAGS ('dbx_business_glossary_term' = 'Process Stage (Front End of Line / Middle of Line / Back End of Line)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `process_stage` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `route_version` SET TAGS ('dbx_business_glossary_term' = 'Process Route Version');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `scrap_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Scrap Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'CAMSTAR|SMARTFACTORY|SAP_PP|MANUAL');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `valuation_currency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `valuation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `wafer_count_current` SET TAGS ('dbx_business_glossary_term' = 'Current Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `wafer_count_start` SET TAGS ('dbx_business_glossary_term' = 'Starting Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ALTER COLUMN `wafer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` SET TAGS ('dbx_subdomain' = 'material_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UoM)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `batch_managed` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Material Discontinuation Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{4,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `fixed_lot_qty` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Size Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `hazardous_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Incoming Inspection Required');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `lot_size_type` SET TAGS ('dbx_business_glossary_term' = 'MRP Lot Size Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `lot_size_type` SET TAGS ('dbx_value_regex' = 'fixed|lot_for_lot|min_max|periodic');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_class` SET TAGS ('dbx_business_glossary_term' = 'Material Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,40}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|blocked|discontinued|under_qualification|obsolete|phase_out');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `max_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `min_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `moving_avg_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `moving_avg_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `price_control_type` SET TAGS ('dbx_business_glossary_term' = 'Price Control Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `price_control_type` SET TAGS ('dbx_value_regex' = 'standard|moving_average');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `purity_pct` SET TAGS ('dbx_business_glossary_term' = 'Material Purity (%)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Material Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|in_qualification|conditionally_approved|disqualified|not_evaluated');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `raw_material_status` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `reach_svhc_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Substance of Very High Concern (SVHC) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `resistivity_ohm_cm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Resistivity (Ohm·cm)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `serialized` SET TAGS ('dbx_business_glossary_term' = 'Serialized Material');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `standard_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `storage_humidity_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Relative Humidity (%)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `storage_temp_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `storage_temp_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `wafer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `wafer_type` SET TAGS ('dbx_business_glossary_term' = 'Wafer Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ALTER COLUMN `wafer_type` SET TAGS ('dbx_value_regex' = 'bare_silicon|epitaxial|soi|fz|cz');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` SET TAGS ('dbx_subdomain' = 'material_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Partner ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Release Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `aec_q_qualified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Electronics Council (AEC-Q) Qualified');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `bin_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `bin_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `date_code` SET TAGS ('dbx_business_glossary_term' = 'Date Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `date_code` SET TAGS ('dbx_value_regex' = '^d{4}[0-5]d$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `device_marking` SET TAGS ('dbx_business_glossary_term' = 'Device Marking');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `dppm_target` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM) Target');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `eccn_number` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `eccn_number` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}.[a-z]$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `eccn_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `eol_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `finished_good_status` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^d{4}.d{2}.d{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|quarantine|reserved|consignment|scrapped|hold');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `inventory_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|nrnd|eol|ltb|discontinued');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `lot_traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `lot_traceability_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `msd_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSD)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `package_body_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Package Body Size (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `package_body_size_mm` SET TAGS ('dbx_value_regex' = '^d+(.d+)?xd+(.d+)?$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `pcn_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Reference');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Pin Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|in_qualification|conditionally_qualified|not_qualified|requalification_required');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `quality_disposition` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity on Hand');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Temperature Grade');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive|military|extended');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|TRAY|REEL|TUBE|BOX');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` SET TAGS ('dbx_subdomain' = 'material_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `device_architecture_id` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Facility (FAB) ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Partner ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `primary_die_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `bank_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `bank_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `bin_class` SET TAGS ('dbx_business_glossary_term' = 'Bin Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `bin_classification` SET TAGS ('dbx_business_glossary_term' = 'Bin Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Die Carrier Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'waffle_pack|gel_pack|tape_and_reel|tray|bare_die');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_bank_code` SET TAGS ('dbx_value_regex' = '^DB-[A-Z0-9]{4,12}-[0-9]{4,8}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `date_code` SET TAGS ('dbx_business_glossary_term' = 'Date Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_bank_status` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_bank_status` SET TAGS ('dbx_value_regex' = 'available|reserved|consumed|quarantined|scrapped|expired');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_count` SET TAGS ('dbx_business_glossary_term' = 'Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_part_number` SET TAGS ('dbx_business_glossary_term' = 'Die Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Die Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_revision` SET TAGS ('dbx_business_glossary_term' = 'Die Revision');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_revision` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{0,2}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Size (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `die_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Die Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `esd_sensitivity_class` SET TAGS ('dbx_business_glossary_term' = 'Electrostatic Discharge (ESD) Sensitivity Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `esd_sensitivity_class` SET TAGS ('dbx_value_regex' = 'HBM_0|HBM_1A|HBM_1B|HBM_1C|HBM_2|CDM_C1');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'standard_cost|moving_average|fifo|lifo');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `inventory_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `is_consignment` SET TAGS ('dbx_business_glossary_term' = 'Is Consignment Stock');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `is_engineering_sample` SET TAGS ('dbx_business_glossary_term' = 'Is Engineering Sample');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `kgd_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kgd Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `kgd_flag` SET TAGS ('dbx_business_glossary_term' = 'Kgd Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'certified|pending|rejected|conditionally_approved');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `lot_origin` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_value_regex' = 'MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `quality_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `quantity_initial` SET TAGS ('dbx_business_glossary_term' = 'Initial Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `quantity_scrapped` SET TAGS ('dbx_business_glossary_term' = 'Quantity Scrapped');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `storage_form` SET TAGS ('dbx_business_glossary_term' = 'Storage Form');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `storage_humidity_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Humidity (%RH)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `tapeout_version` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Version');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost per Die');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `wafer_form` SET TAGS ('dbx_business_glossary_term' = 'Wafer Form');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `wafer_probe_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Yield (%)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Creation Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` SET TAGS ('dbx_subdomain' = 'material_tracking');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `photomask_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask Asset Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'IC Design Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `primary_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `tapeout_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Experiment Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `asset_valuation_usd` SET TAGS ('dbx_business_glossary_term' = 'Photomask Asset Valuation (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `asset_valuation_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `asset_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Asset Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `blank_material` SET TAGS ('dbx_business_glossary_term' = 'Blank Material');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `cd_uniformity_nm` SET TAGS ('dbx_business_glossary_term' = 'Critical Dimension (CD) Uniformity (nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `cleaning_count` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Mask Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `defect_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Inspection Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Mask Inspection Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending|not_inspected');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `is_mpw_mask` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Mask Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Process Layer Name');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type (EUV/DUV)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|i-line|g-line');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Mask Manufacture Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Mask Asset Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_generation` SET TAGS ('dbx_business_glossary_term' = 'Mask Generation (Tapeout Version)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_layer` SET TAGS ('dbx_business_glossary_term' = 'Mask Layer');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Mask Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Mask Size (millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_status` SET TAGS ('dbx_business_glossary_term' = 'Photomask Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_status` SET TAGS ('dbx_value_regex' = 'active|quarantined|retired|in_inspection|pending_qualification|scrapped');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_substrate_material` SET TAGS ('dbx_business_glossary_term' = 'Mask Substrate Material');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_substrate_material` SET TAGS ('dbx_value_regex' = 'fused_silica|quartz|LTEM|ULE');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_type` SET TAGS ('dbx_business_glossary_term' = 'Photomask Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `mask_type` SET TAGS ('dbx_value_regex' = 'binary|attPSM|altPSM|CPL|EUV');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `max_defect_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Defect Limit');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `max_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Max Usage Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `max_usage_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Usage Limit');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `net_book_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `opc_version` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Version');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `pellicle_present` SET TAGS ('dbx_business_glossary_term' = 'Pellicle Present Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `pellicle_type` SET TAGS ('dbx_business_glossary_term' = 'Pellicle Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `pellicle_type` SET TAGS ('dbx_value_regex' = 'standard|EUV|none');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `photomask_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Photomask Asset Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Mask Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `registration_error_nm` SET TAGS ('dbx_business_glossary_term' = 'Mask Registration Error (nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `reticle_pod_code` SET TAGS ('dbx_business_glossary_term' = 'Reticle Storage Pod (RSP) ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `reticle_type` SET TAGS ('dbx_business_glossary_term' = 'Reticle Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Mask Retirement Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `scanner_model` SET TAGS ('dbx_business_glossary_term' = 'Lithography Scanner Model');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `storage_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Storage Relative Humidity Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`photomask_asset` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Mask Usage Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `parent_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_value_regex' = 'unrestricted|badge-access|authorized-personnel|security-vault');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bin');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'cassette|container|pod|tray|box|pallet');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `cleanroom_iso_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom ISO Classification Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `cleanroom_iso_class` SET TAGS ('dbx_value_regex' = 'ISO-1|ISO-2|ISO-3|ISO-4|ISO-5|ISO-6');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `commissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioned Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `current_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Current Utilization Pct');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `current_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Current Utilization Percent');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `current_utilization_units` SET TAGS ('dbx_business_glossary_term' = 'Current Storage Utilization (Units)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `decommissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioned Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `esd_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Esd Protected Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `esd_protection_class` SET TAGS ('dbx_business_glossary_term' = 'Electrostatic Discharge (ESD) Protection Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `esd_protection_class` SET TAGS ('dbx_value_regex' = 'class-0|class-1|class-2|class-3|unprotected');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'cleanroom|warehouse|cold-storage|gas-cabinet|nitrogen-cabinet|die-vault');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_value_regex' = 'sprinkler|halon|fm200|co2|dry-powder|none');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `geo_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `geo_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `geo_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `geo_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `geo_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `geo_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `hazmat_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Approved Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `humidity_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Humidity Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'standard-cost|moving-average|fifo|fefo');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `is_osat_partner_location` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Partner Location Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `kgd_storage_certified` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Storage Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Environmental Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|blocked|decommissioned');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `max_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Capacity (Units)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `max_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Relative Humidity Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `min_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Relative Humidity Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `msd_floor_life_capable` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitive Device (MSD) Floor Life Management Capable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `msd_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL) Rating');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `msd_sensitivity_level` SET TAGS ('dbx_value_regex' = 'MSL-1|MSL-2|MSL-2a|MSL-3|MSL-4|MSL-5');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Environmental Inspection Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `nitrogen_purge_capable` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Purge Capability Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `osat_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `osat_partner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `photomask_storage_capable` SET TAGS ('dbx_business_glossary_term' = 'Photomask Storage Capable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `rack` SET TAGS ('dbx_business_glossary_term' = 'Rack');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `row` SET TAGS ('dbx_business_glossary_term' = 'Row Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `shelf` SET TAGS ('dbx_business_glossary_term' = 'Shelf Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `shelf_life_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Tracking Enabled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `warehouse_zone` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Kilograms)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ALTER COLUMN `wip_staging_area` SET TAGS ('dbx_business_glossary_term' = 'Work in Process (WIP) Staging Area Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Controller Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `primary_stock_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `primary_stock_raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `balance_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `batch_classification` SET TAGS ('dbx_business_glossary_term' = 'Batch Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `batch_classification` SET TAGS ('dbx_value_regex' = 'prime|test|engineering|monitor|reject');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `bin_classification` SET TAGS ('dbx_business_glossary_term' = 'Bin Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `consignment_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Consignment Partner Code (OSAT)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `consignment_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'known_good|failed|untested|conditionally_good');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Count Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `msd_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `qty_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available (Unreserved)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `qty_blocked` SET TAGS ('dbx_business_glossary_term' = 'Quantity Blocked');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `qty_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `qty_in_wip` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Work In Process (WIP)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `qty_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `qty_quality_inspection` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Quality Inspection');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `qty_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `quantity_blocked` SET TAGS ('dbx_business_glossary_term' = 'Quantity Blocked');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `quantity_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `quantity_quality_hold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Quality Hold');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `slow_moving_flag` SET TAGS ('dbx_business_glossary_term' = 'Slow Moving Inventory Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_MM|CAMSTAR|SMARTFACTORY|AGILE_PLM');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'E|K|Q|W|O|');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_aging_days` SET TAGS ('dbx_business_glossary_term' = 'Stock Aging Days');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|consignment|restricted');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_value_regex' = 'ambient|nitrogen_purge|cold_storage|cleanroom_class1|cleanroom_class10|hazmat');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `total_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `unrestricted_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Use Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `value_usd` SET TAGS ('dbx_business_glossary_term' = 'Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `wafer_process_node` SET TAGS ('dbx_business_glossary_term' = 'Wafer Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ALTER COLUMN `wafer_process_node` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}nm$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `export_license_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Usage Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'From Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `from_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'From Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_performed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_performed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_performed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `primary_goods_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `primary_goods_stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Stock Balance Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `primary_goods_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `source_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `to_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'To Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `bin_classification` SET TAGS ('dbx_business_glossary_term' = 'Bin Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `destination_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `destination_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Document Line Item Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_date` SET TAGS ('dbx_business_glossary_term' = 'Movement Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_number` SET TAGS ('dbx_business_glossary_term' = 'Movement Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|goods_issue|transfer_posting|scrap|return|reversal');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Movement Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Movement Notes');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `production_order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Line Item');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_value_regex' = 'purchase_order|production_order|delivery_note|transfer_order|sales_order|reservation');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `shelf_life_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `source_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Source Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `source_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'consignment|project_stock|sales_order_stock|returnable_packaging|pipeline');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted_use');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `value_usd` SET TAGS ('dbx_business_glossary_term' = 'Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ALTER COLUMN `work_center` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` SET TAGS ('dbx_ssot_owner' = 'fabrication.fabrication_lot_hold');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `inventory_lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Hold ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `fabrication_process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Reference ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placed By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `inventory_released_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Released By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `inventory_released_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `inventory_released_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `primary_inventory_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiator ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `primary_inventory_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `primary_inventory_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `quality_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `trade_compliance_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Hold Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `fabrication_lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Fabrication Lot Hold Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Die Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `dppm_value` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM) Value');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `expected_release_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN_[0-9A-Z]{5,10}|ITAR|NLR');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_comments` SET TAGS ('dbx_business_glossary_term' = 'Hold Comments');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Description');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_disposition` SET TAGS ('dbx_business_glossary_term' = 'Hold Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_disposition` SET TAGS ('dbx_value_regex' = 'rework|scrap|release|return|quarantine|retest');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_initiator_name` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiator Name');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_value_regex' = '^HOLD-[0-9]{8,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_release_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Authority Name');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `inventory_fabrication_lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Hold Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `inventory_fabrication_lot_hold_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `is_regulatory_hold` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Hold');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `mrb_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Mrb Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Ncr Reference');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Placed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `primary_fabrication_lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fabrication Lot Hold Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `released_by` SET TAGS ('dbx_business_glossary_term' = 'Released By');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `physical_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counted By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `primary_physical_counter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `primary_physical_counter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `primary_physical_counter_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `primary_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `bin_classification` SET TAGS ('dbx_business_glossary_term' = 'Bin Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `bin_classification` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `book_quantity` SET TAGS ('dbx_business_glossary_term' = 'Book Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `consignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Consignment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `consignment_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Consignment Partner Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `consignment_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_document_number` SET TAGS ('dbx_business_glossary_term' = 'Count Document Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_notes` SET TAGS ('dbx_business_glossary_term' = 'Count Notes');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|posted|cancelled|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'cycle_count|annual_wall_to_wall|triggered_count|spot_check|variance_recount|regulatory_audit');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `freeze_flag` SET TAGS ('dbx_business_glossary_term' = 'Freeze Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `inventory_category` SET TAGS ('dbx_business_glossary_term' = 'Inventory Category');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `inventory_category` SET TAGS ('dbx_value_regex' = 'raw_material|wip|finished_goods|die_bank|consignment|spare_parts');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `inventory_count_number` SET TAGS ('dbx_business_glossary_term' = 'Inventory Count Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'kgd|non_kgd|untested|quarantine');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,18}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `recount_reason` SET TAGS ('dbx_business_glossary_term' = 'Recount Reason');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `recount_reason` SET TAGS ('dbx_value_regex' = 'variance_exceeds_threshold|supervisor_request|system_discrepancy|damaged_goods|quality_hold|initial_count_error');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_value_regex' = 'ambient|controlled_temp|controlled_humidity|nitrogen_purge|vacuum|cleanroom');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `variance_exceeds_tolerance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Exceeds Tolerance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `variance_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Tolerance Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `variance_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Variance Value (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ALTER COLUMN `variance_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Partner ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `primary_consignment_die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `primary_consignment_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consigned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consigned Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consignment Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_number` SET TAGS ('dbx_business_glossary_term' = 'Consignment Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Consignment Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_status` SET TAGS ('dbx_business_glossary_term' = 'Consignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_status` SET TAGS ('dbx_value_regex' = 'active|in_transit|consumed|returned|settled|expired');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_stock_status` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_type` SET TAGS ('dbx_business_glossary_term' = 'Consignment Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_type` SET TAGS ('dbx_value_regex' = 'osat_assembly|osat_test|vmi_hub|customer_consignment');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Consignment Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `eccn_number` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'kgd|non_kgd|untested|mixed');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `liability_aging_days` SET TAGS ('dbx_business_glossary_term' = 'Liability Aging Days');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `lot_traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Max Stock Level');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Min Stock Level');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `msd_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `next_reconciliation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reconciliation Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `ownership` SET TAGS ('dbx_business_glossary_term' = 'Ownership');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `ownership_party` SET TAGS ('dbx_business_glossary_term' = 'Ownership Party');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `ownership_transfer_trigger` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transfer Trigger');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `ownership_transfer_trigger` SET TAGS ('dbx_value_regex' = 'consumption|shipment|time_based|withdrawal');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|quarterly');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `settlement_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Document Reference');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `storage_humidity_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity Maximum Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `total_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Valuation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `total_valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`consignment_stock` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `stock_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Valuation Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Stock Balance Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `stock_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `bin_classification` SET TAGS ('dbx_business_glossary_term' = 'Bin Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_category` SET TAGS ('dbx_business_glossary_term' = 'Inventory Category');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_category` SET TAGS ('dbx_value_regex' = 'raw_material|wip|die_bank|finished_good|consignment|mpw_shuttle');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `is_consignment` SET TAGS ('dbx_business_glossary_term' = 'Is Consignment Stock');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'kgd|non_kgd|untested|pending');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `moving_average_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `moving_avg_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Avg Price');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `nre_cost_allocation` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost Allocation');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `obsolescence_reserve_usd` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Reserve Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Overhead Cost');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `price_variance_usd` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `quantity_valued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Valued');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `revaluation_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Amount Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `revaluation_flag` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Value');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `total_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'standard_cost|moving_average|fifo|lifo|weighted_average');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'active|blocked|quality_hold|obsolete|scrapped');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_variance` SET TAGS ('dbx_business_glossary_term' = 'Valuation Variance');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `wip_cost_accumulation` SET TAGS ('dbx_business_glossary_term' = 'Work In Process (WIP) Cost Accumulation');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `write_down_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Write Down Amount Usd');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_valuation` ALTER COLUMN `yield_impact_factor` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Factor');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` SET TAGS ('dbx_subdomain' = 'quality_certification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` SET TAGS ('dbx_ssot_owner' = 'quality.quality_kgd_certification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `inventory_kgd_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Certification ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `allocation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Allocation ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Quality Kgd Certification Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certified By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `primary_inventory_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Engineer ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `primary_inventory_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `primary_inventory_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `primary_inventory_quality_kgd_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventory Quality Kgd Certification Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `primary_quality_kgd_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Quality Kgd Certification Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `quality_kgd_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Kgd Certification Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `quality_kgd_certification_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `ate_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Automatic Test Equipment (ATE) Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `ate_equipment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `bin_1_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 1 Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `bin_2_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 2 Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `bin_3_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 3 Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `burn_in_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Burn In Completed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `burn_in_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Burn-In Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `burn_in_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Burn-In Temperature Celsius');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `burn_in_test_result` SET TAGS ('dbx_business_glossary_term' = 'Burn-In Test Result');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `burn_in_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_performed|conditional_pass');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_value_regex' = '^KGD-[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|revoked|pending|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certified_die_count` SET TAGS ('dbx_business_glossary_term' = 'Certified Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `certified_quantity` SET TAGS ('dbx_business_glossary_term' = 'Certified Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `dppm_level` SET TAGS ('dbx_business_glossary_term' = 'Dppm Level');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `dppm_rate` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM) Rate');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `dppm_value` SET TAGS ('dbx_business_glossary_term' = 'Dppm Value');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN) Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `eccn_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}(.[a-z])?$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `electrical_test_pass_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Electrical Test Pass Rate Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `fail_bin_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Bin Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `kgd_grade` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Grade');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `kgd_grade` SET TAGS ('dbx_value_regex' = 'grade_a|grade_b|grade_c|engineering_sample');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `known_good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `packaging_application` SET TAGS ('dbx_business_glossary_term' = 'Packaging Application');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `packaging_application` SET TAGS ('dbx_value_regex' = 'cowos|info|tsv|standard_wirebond|flip_chip|direct_die_shipment');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `probe_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Probe Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `quality_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `reliability_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Reliability Qualified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `reliability_screen_result` SET TAGS ('dbx_business_glossary_term' = 'Reliability Screen Result');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `reliability_screen_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_performed|conditional_pass');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Certification Remarks');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percent');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `test_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Test Facility Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `test_facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `test_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Program Reference');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `test_program_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,50}$');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `tested_die_count` SET TAGS ('dbx_business_glossary_term' = 'Tested Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` SET TAGS ('dbx_subdomain' = 'quality_certification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` SET TAGS ('dbx_ssot_owner' = 'fabrication.fabrication_lot_genealogy');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `inventory_lot_genealogy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Genealogy ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `fabrication_lot_genealogy_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Fabrication Lot Genealogy Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `inventory_fabrication_lot_genealogy_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Genealogy Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `inventory_fabrication_lot_genealogy_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Inventory Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `parent_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `primary_fabrication_lot_genealogy_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fabrication Lot Genealogy Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `primary_inventory_fabrication_lot_genealogy_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventory Fabrication Lot Genealogy Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `primary_inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `automotive_ppap_required` SET TAGS ('dbx_business_glossary_term' = 'Automotive Production Part Approval Process (PPAP) Required');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `bin_classification` SET TAGS ('dbx_business_glossary_term' = 'Bin Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `child_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Child Entity ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `child_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Child Entity Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `child_entity_type` SET TAGS ('dbx_value_regex' = 'wafer_lot|die_bank|finished_good');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `child_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Child Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `genealogy_path` SET TAGS ('dbx_business_glossary_term' = 'Genealogy Path');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `genealogy_status` SET TAGS ('dbx_business_glossary_term' = 'Genealogy Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `genealogy_status` SET TAGS ('dbx_value_regex' = 'active|completed|voided|under_investigation');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `genealogy_type` SET TAGS ('dbx_business_glossary_term' = 'Genealogy Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'kgd|non_kgd|pending|quarantine');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `level_depth` SET TAGS ('dbx_business_glossary_term' = 'Level Depth');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `lot_traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `merge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Merge Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `merge_sequence` SET TAGS ('dbx_business_glossary_term' = 'Merge Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `parent_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_value_regex' = 'wafer_lot|die_bank|finished_good|raw_material');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `pcn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `process_step_code` SET TAGS ('dbx_business_glossary_term' = 'Process Step Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `process_step_name` SET TAGS ('dbx_business_glossary_term' = 'Process Step Name');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `quality_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `quantity_in` SET TAGS ('dbx_business_glossary_term' = 'Quantity In');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `quantity_out` SET TAGS ('dbx_business_glossary_term' = 'Quantity Out');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `quantity_transferred` SET TAGS ('dbx_business_glossary_term' = 'Quantity Transferred');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `rework_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Rework Cycle Count');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `source_operation` SET TAGS ('dbx_business_glossary_term' = 'Source Operation');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `split_quantity` SET TAGS ('dbx_business_glossary_term' = 'Split Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `split_sequence` SET TAGS ('dbx_business_glossary_term' = 'Split Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `split_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Split Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `traceability_notes` SET TAGS ('dbx_business_glossary_term' = 'Traceability Notes');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `transformation_date` SET TAGS ('dbx_business_glossary_term' = 'Transformation Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `transformation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transformation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'wafer|die|unit|kg|liter');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy` ALTER COLUMN `yield_at_transformation_pct` SET TAGS ('dbx_business_glossary_term' = 'Yield at Transformation Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Consuming Goods Movement ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reserving User ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_reserved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reserved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_reserved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_reserved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `split_from_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Split From Reservation Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `split_from_reservation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `auto_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Release Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `bin_classification` SET TAGS ('dbx_business_glossary_term' = 'Bin Classification');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `demand_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Demand Source ID (DEMAND_SOURCE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Expiration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `is_kgd` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die Flag');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Reservation Priority');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Reservation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `required_date` SET TAGS ('dbx_business_glossary_term' = 'Required Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Date');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number (RESERVATION_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status (RESERVATION_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'active|consumed|cancelled|expired');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_business_glossary_term' = 'Reservation Type (RESERVATION_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_value_regex' = 'customer_order|production_order|packaging_run|engineering_sample');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
