-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`supply` COMMENT 'End-to-end semiconductor supply chain including supplier master data, raw material procurement, subcontractor management, OSAT vendor relationships, and inbound logistics. Owns supplier qualification records, approved vendor lists, lead time data, supply risk assessments, and material planning.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supplier` (
    `supplier_id` BIGINT COMMENT 'System-generated unique identifier for the supplier record.',
    `site_id` BIGINT COMMENT 'add column site_id (BIGINT) with FK to shared.site.site_id - suppliers have physical locations requiring site linkage',
    `address_line1` STRING COMMENT 'First line of the suppliers primary address.',
    `address_line2` STRING COMMENT 'Second line of the suppliers primary address (optional).',
    `approval_date` DATE COMMENT 'Date when the supplier was approved for procurement.',
    `approved_by` STRING COMMENT 'Name of the internal user who approved the supplier onboarding.',
    `city` STRING COMMENT 'City component of the suppliers primary address.',
    `supplier_code` STRING COMMENT 'Coded value representing the code of the supplier supply record.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the supplier with internal and external regulations.. Valid values are `compliant|non_compliant|under_review`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the suppliers primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the supplier.',
    `currency_code` STRING COMMENT 'Default transaction currency used with the supplier.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the supplier organization.. Valid values are `^[0-9]{9,10}$`',
    `ear_controlled` BOOLEAN COMMENT 'Indicates whether the supplier is subject to EAR export controls.',
    `export_control_classification` STRING COMMENT 'Export classification code for the suppliers products or services.. Valid values are `EAR99|ECCN5A|ECCN5B`',
    `financial_rating` STRING COMMENT 'Credit rating assigned to the supplier based on financial health.. Valid values are `A|B|C|D|E`',
    `global_footprint` STRING COMMENT 'Scope of the suppliers operational presence.. Valid values are `Global|Regional|Local`',
    `industry_classification` STRING COMMENT 'Broad industry segment to which the supplier belongs.. Valid values are `Raw Material|Chemical|Equipment|OSAT|Design Service`',
    `is_certified_kga` BOOLEAN COMMENT 'Indicates whether the supplier holds a KGA (Known Good Assembly) certification.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the supplier is subject to ITAR export controls.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier quality or compliance audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supplier record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Typical number of days from order placement to delivery.',
    `legal_name` STRING COMMENT 'Full legal registered name of the supplier entity.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the supplier record in the supply domain.',
    `supplier_name` STRING COMMENT 'Primary display name of the supplier used in business transactions.',
    `notes` STRING COMMENT 'Additional remarks or comments about the supplier.',
    `parent_company_name` STRING COMMENT 'Name of the ultimate parent organization if the supplier is a subsidiary.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the supplier.. Valid values are `Net30|Net45|Net60|Cash`',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the suppliers primary address.',
    `preferred_logistics_partner` STRING COMMENT 'Logistics provider most frequently used for shipments from this supplier.',
    `primary_contact_name` STRING COMMENT 'Name of the main contact person for the supplier.',
    `primary_email` STRING COMMENT 'Email address of the primary supplier contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Telephone number of the primary supplier contact.. Valid values are `^+?[0-9]{7,15}$`',
    `quality_rating` STRING COMMENT 'Overall quality performance rating based on audits and defect data.. Valid values are `Excellent|Good|Fair|Poor`',
    `registration_number` STRING COMMENT 'Official registration number of the suppliers legal entity.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk score derived from financial, geopolitical, and operational factors.',
    `state_province` STRING COMMENT 'State or province of the suppliers primary address.',
    `supplier_group` STRING COMMENT 'Business grouping used for strategic sourcing and spend analysis.. Valid values are `Strategic|Preferred|Standard|Transactional`',
    `supplier_status` STRING COMMENT 'Current lifecycle status of the supplier record.. Valid values are `active|inactive|suspended|pending|terminated`',
    `supplier_type` STRING COMMENT 'Classification of the supplier based on strategic importance and spend volume.. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers environmental and social responsibility performance.',
    `tax_number` STRING COMMENT 'Government‑issued tax registration number for the supplier.. Valid values are `^[A-Z0-9]{10,15}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the supplier record.',
    `website` STRING COMMENT 'Public website URL of the supplier.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all semiconductor supply chain vendors including raw material suppliers, chemical suppliers, gas suppliers, photomask vendors, OSAT partners, and subcontractors. Captures supplier identity, classification (Tier 1/2/3), business registration, DUNS number, geographic footprint, financial health rating, strategic importance, and ITAR/EAR export control classification. SSOT for supplier identity across the supply domain. Sourced from SAP S/4HANA MM Vendor Master.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` (
    `approved_vendor_id` BIGINT COMMENT 'Primary key for approved_vendor',
    `supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — AVL records authorize a specific supplier — this is the most fundamental FK in the domain. Cannot operate AVL without knowing which supplier is approved.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - vendor approvals may be node specific',
    `material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — AVL records approve a supplier FOR a specific material category. The material_master is the SSOT for whats being approved.',
    `primary_approved_supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Each approved vendor record belongs to a single supplier; linking provides parent‑child hierarchy and removes redundant supplier details that may exist in approved_vendor.',
    `address_line1` STRING COMMENT 'First line of the vendors street address.',
    `address_line2` STRING COMMENT 'Second line of the vendors street address (optional).',
    `approval_date` DATE COMMENT 'Date on which the vendor was granted approved status.',
    `approval_status` STRING COMMENT 'Current qualification status of the vendor within the Approved Vendor List.. Valid values are `approved|pending|rejected|revoked`',
    `approved_commodity_scope` STRING COMMENT 'List or description of material categories, chemical families, or process inputs the vendor is qualified to supply.',
    `approved_vendor_status` STRING COMMENT 'Overall operational status of the vendor within the enterprise.. Valid values are `active|inactive|expired|suspended|pending`',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical result of the latest audit (0‑100).',
    `city` STRING COMMENT 'City component of the vendors address.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of certifications (e.g., ISO 9001, IATF 16949, RoHS) held by the vendor.',
    `country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 country code of the vendors primary location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the approved vendor record in the supply domain.',
    `currency` STRING COMMENT 'Currency code used for transactions with the vendor.. Valid values are `^[A-Z]{3}$`',
    `approved_vendor_description` STRING COMMENT 'Free‑form text providing additional context or notes about the vendor.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the vendor organization.',
    `expiry_date` DATE COMMENT 'Date on which the vendors approved status expires unless renewed.',
    `financial_rating` STRING COMMENT 'Credit rating assigned to the vendor based on financial health.. Valid values are `A|B|C|D|E|F`',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the approved vendor record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Average number of calendar days from order placement to material receipt for this vendor.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the approved vendor record in the supply domain.',
    `notes` STRING COMMENT 'The notes of the approved vendor record in the supply domain.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the vendor.. Valid values are `net30|net45|net60|cash|prepay`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the vendors address.',
    `primary_contact_email` STRING COMMENT 'Email address of the vendors primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the main point of contact for the vendor.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the vendors primary contact.',
    `quality_tier` STRING COMMENT 'Internal quality classification assigned to the vendor based on performance and compliance.. Valid values are `tier1|tier2|tier3|tier4`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the approved vendor record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the approved vendor record.',
    `regulatory_status` STRING COMMENT 'Current status of the vendor with respect to applicable semiconductor regulations.. Valid values are `compliant|non_compliant|under_review`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) derived from supply‑risk assessments.',
    `state` STRING COMMENT 'State or province component of the vendors address.',
    `tax_number` STRING COMMENT 'Vendors tax registration number for invoicing and compliance.',
    `vendor_code` STRING COMMENT 'Internal alphanumeric code used to uniquely identify the vendor within the enterprise.',
    `vendor_name` STRING COMMENT 'Full legal name of the supplier organization.',
    `vendor_type` STRING COMMENT 'Category of the vendor based on its role in the semiconductor supply chain.. Valid values are `supplier|subcontractor|osat|service_provider`',
    CONSTRAINT pk_approved_vendor PRIMARY KEY(`approved_vendor_id`)
) COMMENT 'Approved Vendor List (AVL) records establishing which suppliers are qualified and authorized to supply specific material categories, chemical families, or process inputs to the fab. Tracks qualification status, approval date, expiry date, approved commodity scope, quality tier, and the engineering/procurement authority who granted approval. Supports DFM and process qualification gating. Sourced from Oracle Agile PLM and SAP MM.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'System-generated unique identifier for each material master record.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Each material must have an ECCN for export‑control classification; used in licensing and reporting.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - materials may be node specific',
    `supplier_id` BIGINT COMMENT 'Reference to the approved vendor supplying this material.',
    `base_unit_of_measure` STRING COMMENT 'The base unit of measure of the material master record in the supply domain.',
    `base_uom` STRING COMMENT 'Standard unit of measure used for inventory and procurement transactions (e.g., kg, L, pcs).',
    `batch_management` BOOLEAN COMMENT 'True if the material is managed in batches for traceability.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO country code indicating where the material originates.. Valid values are `USA|CHN|KOR|JPN|DEU|TWN`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency for the standard cost.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `eccn_code` STRING COMMENT 'Coded value representing the eccn code of the material master supply record.',
    `expiration_date` DATE COMMENT 'Date after which the material must not be used.',
    `hazardous_classification` STRING COMMENT 'Regulatory classification indicating the materials hazardous status under RoHS, REACH, and TSCA.. Valid values are `non_hazardous|hazardous|restricted|controlled`',
    `hazardous_flag` BOOLEAN COMMENT 'The hazardous flag of the material master record in the supply domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the material master record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Average number of days from purchase order issuance to receipt of the material.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the material record.. Valid values are `active|inactive|discontinued|pending`',
    `lot_size_qty` DECIMAL(18,2) COMMENT 'Standard production or procurement lot size for the material.',
    `material_code` STRING COMMENT 'Coded value representing the material code of the material master supply record.',
    `material_description` STRING COMMENT 'Detailed textual description of the material, including its purpose and key characteristics.',
    `material_group` STRING COMMENT 'The material group of the material master record in the supply domain.',
    `material_master_status` STRING COMMENT 'The status of the material master record in the supply domain.',
    `material_name` STRING COMMENT 'Human‑readable name or title of the material.',
    `material_number` STRING COMMENT 'Business-visible alphanumeric code that uniquely identifies the material across the enterprise.',
    `material_type` STRING COMMENT 'Classification of the material by its functional role in semiconductor manufacturing.. Valid values are `raw|consumable|component|packaging|chemical|gas`',
    `max_order_qty` DECIMAL(18,2) COMMENT 'Largest quantity that can be ordered in a single purchase order.',
    `min_order_qty` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from a supplier.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the material master record in the supply domain.',
    `notes` STRING COMMENT 'The notes of the material master record in the supply domain.',
    `procurement_group` STRING COMMENT 'Organizational group responsible for procuring the material.',
    `procurement_type` STRING COMMENT 'The procurement type of the material master record in the supply domain.',
    `quality_inspection_required` BOOLEAN COMMENT 'True if incoming or in‑process inspection is mandatory for the material.',
    `reach_compliant` BOOLEAN COMMENT 'True if the material meets the Registration, Evaluation, Authorisation and Restriction of Chemicals (REACH) requirements.',
    `reorder_point_qty` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment order.',
    `rohs_compliant` BOOLEAN COMMENT 'True if the material complies with the Restriction of Hazardous Substances (RoHS) directive.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Quantity of material kept on hand to protect against demand or supply variability.',
    `serial_management` BOOLEAN COMMENT 'True if the material is tracked by serial numbers.',
    `shelf_life_days` STRING COMMENT 'Number of days the material can be stored before it expires.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Default cost used for valuation and planning, expressed in the base currency.',
    `storage_humidity_max_pct` DECIMAL(18,2) COMMENT 'Highest permissible relative humidity percentage for storage.',
    `storage_humidity_min_pct` DECIMAL(18,2) COMMENT 'Lowest permissible relative humidity percentage for storage.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Highest permissible storage temperature in degrees Celsius.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Lowest permissible storage temperature in degrees Celsius.',
    `tsca_compliant` BOOLEAN COMMENT 'True if the material is compliant with the US Toxic Substances Control Act (TSCA).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the material master record.',
    `valuation_class` STRING COMMENT 'Key for grouping materials with similar accounting treatment.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Authoritative master record for all procured materials used in semiconductor manufacturing: silicon wafer substrates, process chemicals (slurries, etchants, photoresists), specialty gases (silane, nitrogen, argon), photomasks, packaging substrates, lead frames, bonding wire, and consumables. Captures material number, description, material type, base unit of measure, hazardous material classification (RoHS/REACH/TSCA), storage conditions, shelf life, procurement lead time, safety stock levels, reorder points, and lot sizing parameters. SSOT for material identity and procurement parameters within the supply domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'System-generated unique identifier for the purchase order record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Purchase order fulfills a specific customer account order; linking enables order‑to‑cash reconciliation and profitability analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PO accounting requires posting expenses to a cost center for internal budgeting and cost‑reporting; the finance cost_center entity holds the approved cost center hierarchy.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Purchase orders are raised for specific IC catalog items; linking enables order‑to‑item traceability and cost reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee who created the PO request.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier (vendor) to which the purchase order is issued.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis allocates PO spend to a profit center, enabling product‑line P&L reporting; finance profit_center stores the responsible profit center codes.',
    `purchase_buyer_employee_id` BIGINT COMMENT 'Unique identifier for the purchase buyer employee record within the purchase order supply entity.',
    `purchase_supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Every PO is issued to exactly one supplier. This is the most fundamental FK in procurement — cannot ship without it.',
    `sourcing_contract_id` BIGINT COMMENT 'Unique identifier for the sourcing contract record within the purchase order supply entity.',
    `actual_delivery_date` DATE COMMENT 'Date when goods/services were actually received.',
    `approval_date` DATE COMMENT 'Date when the purchase order was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the purchase order.. Valid values are `pending|approved|rejected`',
    `buyer_name` STRING COMMENT 'The buyer name of the purchase order record in the supply domain.',
    `compliance_flags` STRING COMMENT 'Semicolon‑separated list of compliance indicators (e.g., RoHS, REACH).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was first captured in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts on the PO.',
    `delivery_date` DATE COMMENT 'The delivery date associated with the purchase order supply record.',
    `delivery_schedule` STRING COMMENT 'Free‑text description of delivery windows or milestones.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount granted on the gross amount.',
    `expected_delivery_date` DATE COMMENT 'Planned date for goods/services to be delivered.',
    `export_control_classification` STRING COMMENT 'Export classification code (e.g., EAR99, ITAR, ECCN) for the items on the PO.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Monetary cost of freight/shipping.',
    `freight_terms` STRING COMMENT 'Responsibility for freight costs.. Valid values are `prepaid|collect|third_party`',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — 7 candidates stripped; promote to reference product]',
    `is_ear_controlled` BOOLEAN COMMENT 'Indicates whether the PO is subject to U.S. Export Administration Regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the purchase order record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Planned number of days from PO issuance to expected receipt.',
    `material_description` STRING COMMENT 'Human‑readable description of the material or service.',
    `material_number` STRING COMMENT 'Identifier of the material or service being procured.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the purchase order record in the supply domain.',
    `notes` STRING COMMENT 'The notes of the purchase order record in the supply domain.',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the purchase order was initially created/submitted.',
    `payment_terms` STRING COMMENT 'Agreed payment schedule and conditions for the purchase order.. Valid values are `NET30|NET45|NET60|PREPAID|COD`',
    `plant` STRING COMMENT 'SAP plant code where the goods are to be received.',
    `plant_code` STRING COMMENT 'Coded value representing the plant code of the purchase order supply record.',
    `po_number` STRING COMMENT 'External business identifier assigned to the purchase order by the procurement system.',
    `po_status` STRING COMMENT 'The po status of the purchase order record in the supply domain.',
    `po_type` STRING COMMENT 'The po type of the purchase order record in the supply domain.',
    `purchase_group` STRING COMMENT 'Organizational group responsible for the procurement.',
    `purchase_order_status` STRING COMMENT 'Current lifecycle state of the purchase order.. Valid values are `draft|open|released|closed|cancelled|blocked`',
    `purchase_order_type` STRING COMMENT 'Classification of the PO based on its procurement strategy.. Valid values are `standard|blanket|contract|planned`',
    `purchasing_org` STRING COMMENT 'SAP purchasing organization that owns the PO.',
    `quantity` BIGINT COMMENT 'Number of units ordered for the material.',
    `release_date` DATE COMMENT 'Date when the purchase order was released to the supplier.',
    `storage_location` STRING COMMENT 'Warehouse or storage bin identifier for receipt.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the purchase order record in the supply domain.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and freight.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after taxes, discounts, and freight.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax amount applied to the purchase order.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the ordered quantity (e.g., EA, KG, L).',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of the material before taxes and discounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the purchase order record.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Procurement purchase orders issued to qualified suppliers for raw materials, process chemicals, gases, photomasks, equipment spare parts, and subcontracted services (OSAT assembly/test). Captures PO number, supplier, line items, ordered quantities, agreed unit price, currency, delivery schedule, Incoterms, payment terms, and export control classification (EAR/ITAR). Represents the legally binding procurement commitment. Sourced from SAP S/4HANA MM (EKKO/EKPO).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique surrogate identifier for the purchase order line record.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Each PO line references the exact IC part being ordered, supporting receipt matching and inventory control.',
    `material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — Each PO line references a specific material being procured.',
    `purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Header-line relationship. PO lines cannot exist without their parent PO header.',
    `primary_po_material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — Each PO line procures a specific material. Essential for material traceability and MRP consumption.',
    `primary_purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Header-line pattern: every PO line belongs to exactly one PO. Critical structural relationship.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the material.',
    `account_assignment_code` STRING COMMENT 'Identifier of the specific cost center, WBS element, or order linked to this line.',
    `account_assignment_type` STRING COMMENT 'Classification of the cost object (cost center, WBS element, or internal order).. Valid values are `COST_CENTER|WBS|ORDER`',
    `contract_number` STRING COMMENT 'Reference to a framework contract governing this line, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order line record was created.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for the monetary values on the line.. Valid values are `USD|EUR|JPY|CNY|KRW`',
    `delivery_date` DATE COMMENT 'Date by which the supplier should deliver the material.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount value applied to the line.',
    `goods_receipt_status` STRING COMMENT 'Current status of goods receipt for this line.. Valid values are `Not_Received|Partially_Received|Fully_Received|Cancelled`',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities.. Valid values are `EXW|FCA|FOB|CFR|CIF|DDP`',
    `is_final_invoice` BOOLEAN COMMENT 'Indicates whether this line has been invoiced in its final form.',
    `is_service_line` BOOLEAN COMMENT 'True if the line represents a service rather than a material.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the po line record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Planned number of days from order to delivery for this line.',
    `line_amount` DECIMAL(18,2) COMMENT 'The line amount of the po line record in the supply domain.',
    `line_number` STRING COMMENT 'Sequential number of the line within the purchase order.',
    `line_status` STRING COMMENT 'Current processing status of the purchase order line.. Valid values are `Open|Closed|Cancelled|On_Hold`',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Gross amount before tax and discount (ordered_quantity * net_price).',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `material_number` STRING COMMENT 'Master data identifier for the material or component being procured.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the po line record in the supply domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of the line after tax and discount.',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit of the material before taxes and discounts.',
    `notes` STRING COMMENT 'The notes of the po line record in the supply domain.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material requested on this line.',
    `plant` STRING COMMENT 'Code of the manufacturing plant or site receiving the material.',
    `po_line_status` STRING COMMENT 'The status of the po line record in the supply domain.',
    `price_unit` STRING COMMENT 'Number of units that the net price applies to (e.g., price per 1000 pieces).',
    `purchase_group` STRING COMMENT 'Organizational group responsible for the procurement.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the po line record in the supply domain.',
    `receipt_date` DATE COMMENT 'Date on which the goods were received.',
    `receipt_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that has been received against this line.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The received quantity of the po line record in the supply domain.',
    `storage_location` STRING COMMENT 'Warehouse or storage bin where the material will be stocked.',
    `supply_risk_score` STRING COMMENT 'Risk rating (0‑100) assessing supplier and material availability risk.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for the line.',
    `tax_code` STRING COMMENT 'Tax classification code used to calculate tax for the line.',
    `unit_of_measure` STRING COMMENT 'Unit in which the ordered quantity is expressed.. Valid values are `EA|KG|L|M|PCS`',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the po line record in the supply domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the line record.',
    `vendor_material_number` STRING COMMENT 'Suppliers own part number for the material.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order, each representing a distinct material or service being procured. Captures line number, material number, ordered quantity, unit of measure, net price, delivery date, plant/storage location destination, account assignment (cost center or WBS element), and goods receipt status. Enables granular tracking of multi-material POs and partial deliveries. Sourced from SAP S/4HANA MM (EKPO).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'System-generated unique identifier for the goods receipt record.',
    `purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Goods receipts are posted against purchase orders for three-way matching. Critical operational link.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Goods receipt ties received material to the IC catalog entry for quality verification and traceability.',
    `inbound_shipment_id` BIGINT COMMENT 'Unique identifier for the inbound shipment record within the goods receipt supply entity.',
    `po_line_id` BIGINT COMMENT 'Unique identifier for the po line record within the goods receipt supply entity.',
    `primary_goods_purchase_order_id` BIGINT COMMENT 'System identifier of the purchase order associated with the receipt.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the goods.',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'The accepted quantity of the goods receipt record in the supply domain.',
    `batch_number` STRING COMMENT 'Identifier for the production batch or lot of the received material.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the material complies with applicable regulations (e.g., RoHS).',
    `compliance_status` STRING COMMENT 'Detailed compliance status of the material.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods receipt record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for monetary values.. Valid values are `^[A-Z]{3}$`',
    `external_reference` STRING COMMENT 'Any external system reference linked to this receipt (e.g., logistics tracking ID).',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the receipt (e.g., posted, reversed, pending).. Valid values are `posted|reversed|pending`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the receipt before taxes and discounts.',
    `inspection_lot_number` STRING COMMENT 'Reference to the quality inspection lot created for this receipt.',
    `inspection_result` STRING COMMENT 'The inspection result of the goods receipt record in the supply domain.',
    `inspection_status` STRING COMMENT 'The inspection status of the goods receipt record in the supply domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the goods receipt record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Number of calendar days between purchase order issuance and goods receipt.',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `material_number` STRING COMMENT 'Master data identifier for the material received.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the goods receipt record in the supply domain.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the receipt (e.g., 101 = goods receipt).. Valid values are `101|102|201|202`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and discounts.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or observations.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant or fab where receipt is posted.',
    `posting_date` DATE COMMENT 'Date on which the receipt is posted to financial accounting.',
    `quality_status` STRING COMMENT 'Result of the incoming quality inspection for the received material.. Valid values are `passed|failed|rework|pending`',
    `quantity_received` DECIMAL(18,2) COMMENT 'Amount of material physically received, expressed in the unit of measure.',
    `receipt_date` DATE COMMENT 'Calendar date when the goods were physically received.',
    `receipt_number` STRING COMMENT 'Business identifier assigned to the receipt document (e.g., GR number).',
    `receipt_status` STRING COMMENT 'The receipt status of the goods receipt record in the supply domain.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Exact date and time when the receipt was recorded in the system.',
    `received_by` STRING COMMENT 'Name or employee identifier of the person who logged the receipt.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The received quantity of the goods receipt record in the supply domain.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'The rejected quantity of the goods receipt record in the supply domain.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score representing supply risk for the received material (higher = higher risk).',
    `storage_location` STRING COMMENT 'Warehouse or fab location where the material is stored after receipt.',
    `supplier_batch_reference` STRING COMMENT 'Reference supplied by the vendor for the batch (e.g., vendor lot number).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the receipt.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is measured (e.g., each, kilogram, liter, meter).. Valid values are `EA|KG|L|M`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goods receipt record.',
    `valuation_type` STRING COMMENT 'Valuation category for the material (e.g., S = standard, U = moving average, V = special).. Valid values are `S|U|V`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of materials and goods at the fab or warehouse against a purchase order. Captures GR document number, posting date, received quantity, unit of measure, storage location, batch number, quality inspection lot reference, and movement type. Triggers inventory update and initiates incoming quality inspection. Sourced from SAP S/4HANA MM (MSEG/MKPF — movement type 101).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` (
    `supplier_qualification_id` BIGINT COMMENT 'System-generated unique identifier for each supplier qualification record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Qualification programs are linked to a specific compliance certification required for supplier approval.',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer or authority who approved the qualification.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record within the supplier qualification supply entity.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier being qualified, linking to the supplier master record.',
    `tertiary_supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Qualification records assess a specific supplier. Cannot exist without supplier reference.',
    `approval_date` DATE COMMENT 'Date on which the qualification was formally approved.',
    `audit_date` DATE COMMENT 'Calendar date on which the audit was performed.',
    `audit_score` DECIMAL(18,2) COMMENT 'The audit score of the supplier qualification record in the supply domain.',
    `audit_team` STRING COMMENT 'Comma‑separated list of auditors and subject‑matter experts who conducted the audit.',
    `audit_type` STRING COMMENT 'Classification of the audit execution: initial qualification, routine surveillance, or for‑cause audit.. Valid values are `initial|surveillance|for_cause`',
    `auditor_name` STRING COMMENT 'The auditor name of the supplier qualification record in the supply domain.',
    `compliance_standards` STRING COMMENT 'Semicolon‑separated list of regulatory or industry standards the qualification satisfies.. Valid values are `IATF16949|ISO9001|SEMI|JEDEC|IEC|ISO14001`',
    `corrective_action_due_date` DATE COMMENT 'Date by which all corrective actions must be completed.',
    `corrective_action_plan` STRING COMMENT 'Detailed plan describing corrective actions required to resolve audit findings.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `open|in_progress|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the supplier qualification supply record.',
    `findings_severity` STRING COMMENT 'Highest severity level of audit findings identified during the assessment.. Valid values are `critical|major|minor`',
    `findings_summary` STRING COMMENT 'Narrative summary of audit observations, non‑conformances, and strengths.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supplier qualification record in the supply domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the supplier qualification record in the supply domain.',
    `notes` STRING COMMENT 'Free‑form comments or additional information captured by the qualification team.',
    `overall_rating` STRING COMMENT 'Result of the qualification audit after considering findings and corrective actions.. Valid values are `pass|fail|conditional`',
    `qualification_date` DATE COMMENT 'The qualification date associated with the supplier qualification supply record.',
    `qualification_number` STRING COMMENT 'External reference number assigned to the qualification program for tracking and audit purposes.',
    `qualification_program_type` STRING COMMENT 'Type of qualification program: initial onboarding, scheduled periodic review, or change‑triggered re‑qualification.. Valid values are `initial|periodic|change_triggered`',
    `qualification_scope` STRING COMMENT 'Scope of the qualification assessment covering quality system audit, process capability, material certification, or a combination.. Valid values are `quality_system_audit|process_capability|material_certification|combined`',
    `qualification_standard` STRING COMMENT 'The qualification standard of the supplier qualification record in the supply domain.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification record.. Valid values are `pending|approved|expired|revoked`',
    `qualification_type` STRING COMMENT 'The qualification type of the supplier qualification record in the supply domain.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (0‑100) derived from supplier risk assessment models.',
    `score` DECIMAL(18,2) COMMENT 'The score of the supplier qualification record in the supply domain.',
    `standard` STRING COMMENT 'The standard of the supplier qualification record in the supply domain.',
    `supplier_qualification_status` STRING COMMENT 'The status of the supplier qualification record in the supply domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualification record.',
    `validity_end_date` DATE COMMENT 'Date when the supplier qualification expires unless re‑qualified.',
    `validity_start_date` DATE COMMENT 'Date when the supplier qualification becomes effective.',
    CONSTRAINT pk_supplier_qualification PRIMARY KEY(`supplier_qualification_id`)
) COMMENT 'Formal supplier qualification lifecycle records encompassing the full assessment, audit, and approval process for onboarding new suppliers or re-qualifying existing ones. Captures qualification program type (initial, periodic, change-triggered), assessment scope (quality system audit, process capability, material certification review), on-site and remote audit execution details (audit type — initial qualification, surveillance, for-cause; audit team composition; findings by severity — critical/major/minor; corrective action plans and closure tracking; overall audit rating), qualification criteria and pass/fail results, validity period, and approving engineer. SSOT for all supplier audit and qualification activity within the supply domain. Supports IATF 16949, ISO 9001, and SEMI standards supplier approval requirements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` (
    `supplier_audit_id` BIGINT COMMENT 'System-generated unique identifier for the supplier audit record.',
    `audit_event_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_event. Business justification: Supplier audits are recorded as compliance audit events, enabling unified audit tracking and reporting.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the auditor employee record within the supplier audit supply entity.',
    `supplier_employee_id` BIGINT COMMENT 'Name of the manager or authority who approved the audit results.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier being audited.',
    `approval_date` DATE COMMENT 'Date when the audit was formally approved.',
    `audit_category` STRING COMMENT 'High‑level category of the audit focus.. Valid values are `quality|environment|security|process`',
    `audit_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, expressed in US dollars.',
    `audit_date` TIMESTAMP COMMENT 'Date and time when the audit was performed.',
    `audit_document_version` STRING COMMENT 'Version identifier of the audit report document.',
    `audit_duration_hours` DECIMAL(18,2) COMMENT 'Total time spent on the audit, expressed in hours.',
    `audit_findings_document_reference` BIGINT COMMENT 'Internal identifier of the detailed findings document.',
    `audit_method` STRING COMMENT 'Method used to conduct the audit.. Valid values are `on_site|remote|hybrid`',
    `audit_number` STRING COMMENT 'Business-assigned audit number used for tracking and reference.. Valid values are `^AUD-d{4}-d{3}$`',
    `audit_report_url` STRING COMMENT 'Link to the stored audit report document.',
    `audit_result` STRING COMMENT 'The audit result of the supplier audit record in the supply domain.',
    `audit_scope` STRING COMMENT 'Scope of standards and processes covered by the audit.. Valid values are `iso_9001|iif_14949|semi_gs|custom`',
    `audit_score` DECIMAL(18,2) COMMENT 'The audit score of the supplier audit record in the supply domain.',
    `audit_source_system` STRING COMMENT 'Source system that originated the audit record.. Valid values are `SAP|MES|Custom|Other`',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `audit_team` STRING COMMENT 'Names of the auditors or audit team members.',
    `audit_type` STRING COMMENT 'Classification of the audit purpose.. Valid values are `initial|surveillance|for_cause`',
    `auditor_name` STRING COMMENT 'The auditor name of the supplier audit record in the supply domain.',
    `auditor_notes` STRING COMMENT 'Free‑form notes captured by the audit team.',
    `compliance_status` STRING COMMENT 'Overall compliance determination after the audit.. Valid values are `compliant|non_compliant|conditionally_compliant`',
    `corrective_action_due_date` DATE COMMENT 'Target date by which all corrective actions must be completed.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `open|in_progress|closed|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|JPY|CNY|GBP|Other`',
    `ear_controlled` BOOLEAN COMMENT 'Indicates whether the audited supplier is subject to EAR regulations.',
    `export_control_classification` STRING COMMENT 'Export control classification applicable to the supplier.. Valid values are `EAR99|CCL|None`',
    `finding_count` STRING COMMENT 'The finding count of the supplier audit record in the supply domain.',
    `findings_count` STRING COMMENT 'The findings count of the supplier audit record in the supply domain.',
    `findings_critical_count` STRING COMMENT 'Number of critical severity findings identified.',
    `findings_major_count` STRING COMMENT 'Number of major severity findings identified.',
    `findings_minor_count` STRING COMMENT 'Number of minor severity findings identified.',
    `findings_summary` STRING COMMENT 'Narrative summary of audit findings across severity levels.',
    `follow_up_date` DATE COMMENT 'The follow up date associated with the supplier audit supply record.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the audited supplier is subject to ITAR regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supplier audit record in the supply domain.',
    `location` STRING COMMENT 'Physical site or facility where the audit was conducted.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the supplier audit record in the supply domain.',
    `next_audit_due_date` DATE COMMENT 'Planned date for the suppliers next audit.',
    `notes` STRING COMMENT 'The notes of the supplier audit record in the supply domain.',
    `overall_rating` STRING COMMENT 'Overall rating assigned to the audit based on findings.. Valid values are `excellent|good|fair|poor|unsatisfactory`',
    `overall_score` DECIMAL(18,2) COMMENT 'The overall score of the supplier audit record in the supply domain.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score assigned to the supplier based on audit outcomes.',
    `supplier_audit_status` STRING COMMENT 'The status of the supplier audit record in the supply domain.',
    `supplier_rating` STRING COMMENT 'Overall rating assigned to the supplier after the audit.. Valid values are `A|B|C|D|E`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers environmental and social performance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    CONSTRAINT pk_supplier_audit PRIMARY KEY(`supplier_audit_id`)
) COMMENT 'Records of on-site and remote quality system audits conducted at supplier facilities. Captures audit type (initial qualification, surveillance, for-cause), audit date, audit team, scope of audit (ISO 9001, IATF 16949, SEMI standards), findings count by severity (critical, major, minor), corrective action plan status, and overall audit rating. Drives supplier performance management and AVL maintenance decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Primary key for risk_assessment',
    `disruption_event_id` BIGINT COMMENT 'Unique identifier for a recorded supply disruption event.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or component impacted.',
    `supplier_id` BIGINT COMMENT 'Identifier of an approved alternate supplier for the material.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Project‑Level Supply Risk Assessment records risk scores per research project, supporting risk registers and mitigation planning.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Risk assessments assign an employee owner for accountability; the owner is recorded in the risk owner employee field.',
    `risk_supplier_id` BIGINT COMMENT 'Unique identifier for the risk supplier record within the risk assessment supply entity.',
    `assessment_code` STRING COMMENT 'Business identifier code for the assessment, used for tracking and reporting.',
    `assessment_date` DATE COMMENT 'Date when the risk assessment was initially created.',
    `assessment_name` STRING COMMENT 'Descriptive name of the risk assessment, typically includes supplier or material reference.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment.. Valid values are `draft|approved|rejected|archived`',
    `assessor_name` STRING COMMENT 'Name of the individual who performed the risk assessment.',
    `buffer_stock_target_qty` STRING COMMENT 'Target quantity of safety stock to buffer against the risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first created.',
    `disruption_end_date` DATE COMMENT 'Date when the disruption was resolved or ended.',
    `disruption_escalation_level` STRING COMMENT 'Severity level for escalation and response.. Valid values are `low|medium|high|critical`',
    `disruption_event_type` STRING COMMENT 'Category of the disruption that occurred.. Valid values are `factory_shutdown|natural_disaster|logistics_delay|customs_hold|quality_hold|geopolitical_restriction`',
    `disruption_report_date` DATE COMMENT 'Date when the disruption was reported.',
    `disruption_reported_by` STRING COMMENT 'Name of the person who reported the disruption.',
    `disruption_start_date` DATE COMMENT 'Date when the disruption began.',
    `disruption_status` STRING COMMENT 'Current status of the disruption record.. Valid values are `open|closed|monitoring`',
    `estimated_fab_impact_wafer_starts` STRING COMMENT 'Projected loss of wafer starts due to the disruption.',
    `financial_risk` STRING COMMENT 'The financial risk of the risk assessment record in the supply domain.',
    `geographic_risk` STRING COMMENT 'The geographic risk of the risk assessment record in the supply domain.',
    `geopolitical_risk` STRING COMMENT 'The geopolitical risk of the risk assessment record in the supply domain.',
    `impact_estimate_wafer_starts` STRING COMMENT 'Estimated number of wafer starts that could be lost if the risk occurs.',
    `impact_severity` STRING COMMENT 'Potential impact level if the risk materializes.. Valid values are `low|medium|high|critical`',
    `impacted_po_quantity` STRING COMMENT 'Total purchase order quantity affected by the disruption.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the risk assessment record in the supply domain.',
    `last_review_date` DATE COMMENT 'Date of the most recent risk assessment review.',
    `mitigation_actions_taken` STRING COMMENT 'Actions executed to mitigate the disruption impact.',
    `mitigation_plan` STRING COMMENT 'The mitigation plan of the risk assessment record in the supply domain.',
    `mitigation_strategy` STRING COMMENT 'Planned actions to reduce probability or impact of the risk.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the risk assessment record in the supply domain.',
    `notes` STRING COMMENT 'The notes of the risk assessment record in the supply domain.',
    `probability_percent` DECIMAL(18,2) COMMENT 'Likelihood of the risk event occurring, expressed as a percentage.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the disruption handling process.. Valid values are `resolved|unresolved|partial`',
    `review_cadence` STRING COMMENT 'Frequency at which the risk assessment is reviewed.. Valid values are `monthly|quarterly|annually`',
    `risk_assessment_status` STRING COMMENT 'The status of the risk assessment record in the supply domain.',
    `risk_category` STRING COMMENT 'Classification of the risk type being evaluated.. Valid values are `single_source|geopolitical|financial|natural_disaster|export_control|other`',
    `risk_comments` STRING COMMENT 'Free‑form notes and observations about the risk.',
    `risk_effective_date` DATE COMMENT 'Date from which the risk assessment becomes effective.',
    `risk_expiration_date` DATE COMMENT 'Date after which the risk assessment is no longer valid.',
    `risk_last_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the risk record.',
    `risk_level` STRING COMMENT 'The risk level of the risk assessment record in the supply domain.',
    `risk_owner_department` STRING COMMENT 'Organizational department of the risk owner.',
    `risk_owner_name` STRING COMMENT 'Name of the person accountable for managing the risk.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite numeric score (0‑100) representing overall risk severity.',
    `single_source_flag` BOOLEAN COMMENT 'The single source flag of the risk assessment record in the supply domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Comprehensive supply risk management combining prospective risk assessments and actual disruption event records. Captures risk evaluations (risk category — single-source, geopolitical, financial, natural disaster, export control; probability, impact severity, risk score, mitigation strategy, buffer stock targets, alternate supplier identification, review cadence) and realized disruption incidents (disruption ID, event type — supplier factory shutdown, natural disaster, logistics delay, customs hold, quality hold, geopolitical trade restriction; affected supplier and materials, disruption start and end dates, impacted PO quantities, estimated fab impact in wafer starts at risk, escalation level, mitigation actions taken, resolution outcome). SSOT for all supply risk evaluation and disruption tracking within the supply domain. Supports supply chain resilience planning, CHIPS Act compliance reporting, and executive supply chain risk dashboards.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` (
    `sourcing_contract_id` BIGINT COMMENT 'System-generated unique identifier for the sourcing contract record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Sourcing contracts are negotiated to supply products for a specific customer account, critical for contract management and revenue forecasting.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the individual who approved the contract.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Contracts for controlled commodities must reference the export license that governs the supply terms.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record within the sourcing contract supply entity.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier party associated with this contract.',
    `sourcing_supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Contracts are negotiated with specific suppliers. Essential commercial relationship link.',
    `approval_date` DATE COMMENT 'Date on which the contract received final approval.',
    `approval_status` STRING COMMENT 'Current approval state of the contract within internal governance.. Valid values are `pending|approved|rejected`',
    `auto_renew_flag` BOOLEAN COMMENT 'The auto renew flag of the sourcing contract record in the supply domain.',
    `commodity_code` STRING COMMENT 'Internal or industry code (e.g., part number, SKU) that uniquely identifies the commodity.',
    `commodity_description` STRING COMMENT 'Textual description of the material, component, or service being sourced.',
    `contract_number` STRING COMMENT 'External contract number assigned by the organization for tracking and reference.',
    `contract_status` STRING COMMENT 'The contract status of the sourcing contract record in the supply domain.',
    `contract_type` STRING COMMENT 'Category of the sourcing contract indicating its business purpose.. Valid values are `RFQ|Purchase|Service|License|Consignment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for all monetary values in the contract.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `delivery_terms` STRING COMMENT 'Incoterms governing responsibility and cost transfer between buyer and supplier.. Valid values are `FOB|CIF|EXW|DDP|FCA|CFR`',
    `effective_date` DATE COMMENT 'Date on which the contract becomes legally binding.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the sourcing contract supply record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the sourcing contract supply record.',
    `expiry_date` DATE COMMENT 'Date on which the contract terminates unless extended; nullable for open‑ended agreements.',
    `force_majeure_clause` STRING COMMENT 'Text describing conditions under which performance may be excused due to extraordinary events.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the sourcing contract record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Standard supplier lead time in calendar days for the commodity.',
    `maximum_order_quantity` BIGINT COMMENT 'Largest quantity the supplier agrees to deliver in a single order.',
    `minimum_order_quantity` BIGINT COMMENT 'Smallest quantity the supplier will accept per order under the contract.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the sourcing contract record in the supply domain.',
    `notes` STRING COMMENT 'The notes of the sourcing contract record in the supply domain.',
    `payment_terms` STRING COMMENT 'The payment terms of the sourcing contract record in the supply domain.',
    `pcn_notification_obligation` STRING COMMENT 'Suppliers obligation to notify the buyer of Product Change Notifications.. Valid values are `required|optional|none`',
    `price_escalation_clause` STRING COMMENT 'Text describing any price adjustment mechanisms (e.g., CPI‑linked escalations).',
    `quality_requirements` STRING COMMENT 'Specific quality standards, inspection criteria, and acceptance metrics required by the buyer.',
    `rebate_tier` STRING COMMENT 'Rebate level applicable based on purchase volume or other criteria.. Valid values are `none|tier1|tier2|tier3|tier4|tier5`',
    `sourcing_contract_status` STRING COMMENT 'Current lifecycle state of the contract.. Valid values are `draft|active|suspended|terminated|expired|closed`',
    `supply_continuity_obligation` STRING COMMENT 'Commitments related to uninterrupted supply, safety stock, or backup sources.',
    `target_quantity` BIGINT COMMENT 'Planned total quantity to be procured under the contract.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the contract (unit_price * target_quantity). Stored as raw data; derived metrics are calculated downstream.',
    `total_value` DECIMAL(18,2) COMMENT 'The total value of the sourcing contract record in the supply domain.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the target quantity (e.g., pieces, kilograms).. Valid values are `pcs|kg|mm|inch|cm|m`',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of the commodity, expressed in the contract currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the contract record.',
    CONSTRAINT pk_sourcing_contract PRIMARY KEY(`sourcing_contract_id`)
) COMMENT 'End-to-end sourcing lifecycle records from initial solicitation through executed supply agreement. Covers RFQ issuance (commodity description, target quantity, technical specifications, evaluation criteria, submission deadline), supplier quotation responses (quoted unit price, currency, delivery lead time, MOQ, technical deviations), comparative evaluation and award decisions, and executed contract terms (contract number, supplier, commodity scope, effective and expiry dates, minimum order quantities, volume rebate tiers, price escalation clauses, force majeure terms, PCN notification obligations, quality requirements, and supply continuity obligations). SSOT for the complete RFQ-to-contract sourcing lifecycle within the supply domain. Distinct from customer-facing sales contracts owned by the sales domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` (
    `material_requirement_plan_id` BIGINT COMMENT 'Unique surrogate key for each material requirement plan record.',
    `material_master_id` BIGINT COMMENT 'Surrogate key referencing the material master record.',
    `supplier_id` BIGINT COMMENT 'Reference to the approved supplier that will fulfill the planned order.',
    `tertiary_material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — MRP outputs are calculated for specific materials.',
    `batch_managed_flag` STRING COMMENT 'Flag indicating if the material requires batch tracking (Y) or not (N).. Valid values are `Y|N`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the material requirement plan record in the supply domain.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date‑time when the MRP system generated this record.',
    `currency_code` STRING COMMENT 'Currency in which the planned cost is expressed.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `demand_date` DATE COMMENT 'Date on which the underlying demand (e.g., production start) is scheduled.',
    `demand_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material required by production orders or forecasts.',
    `exception_message` STRING COMMENT 'Textual description of any planning exception (e.g., shortfall, excess).',
    `gross_requirement` DECIMAL(18,2) COMMENT 'The gross requirement of the material requirement plan record in the supply domain.',
    `is_fixed_lot` BOOLEAN COMMENT 'True if the lot size is fixed by engineering, otherwise False.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the material requirement plan record in the supply domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification (e.g., quantity change, status update).',
    `lead_time_days` STRING COMMENT 'Number of calendar days from order placement to receipt of material.',
    `lot_sizing_procedure` STRING COMMENT 'Algorithm used to calculate the lot size for the planned order.. Valid values are `EXACT|FOQ|LFL|LOT|MIN|MAX`',
    `material_number` STRING COMMENT 'Customer‑visible material number (e.g., SKU) used in procurement and production.',
    `material_requirement_plan_status` STRING COMMENT 'Operational status indicating whether the line is still in planning, released to procurement, or flagged.. Valid values are `planned|released|cancelled|exception`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the material requirement plan record in the supply domain.',
    `mrp_controller` STRING COMMENT 'Code of the person or system that owns the MRP parameters for the material.',
    `mrp_status` STRING COMMENT 'The mrp status of the material requirement plan record in the supply domain.',
    `mrp_type` STRING COMMENT 'Classification of the planning method used for this line.. Valid values are `PD|VB|ND|VV|VV|V1`',
    `net_requirement` DECIMAL(18,2) COMMENT 'The net requirement of the material requirement plan record in the supply domain.',
    `notes` STRING COMMENT 'The notes of the material requirement plan record in the supply domain.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'The on hand quantity of the material requirement plan record in the supply domain.',
    `plan_date` DATE COMMENT 'The plan date associated with the material requirement plan supply record.',
    `plan_period` STRING COMMENT 'The plan period of the material requirement plan record in the supply domain.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Estimated monetary cost of the planned quantity based on standard price.',
    `planned_delivery_date` DATE COMMENT 'Target date by which the material must be available for production.',
    `planned_order_quantity` DECIMAL(18,2) COMMENT 'The planned order quantity of the material requirement plan record in the supply domain.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that the MRP run recommends procuring.',
    `planning_horizon_end` DATE COMMENT 'Last day of the time window considered by the MRP run.',
    `planning_horizon_start` DATE COMMENT 'First day of the time window considered by the MRP run.',
    `planning_horizon_weeks` STRING COMMENT 'The planning horizon weeks of the material requirement plan record in the supply domain.',
    `planning_run_date` DATE COMMENT 'Calendar date on which the MRP calculation was performed.',
    `planning_run_number` BIGINT COMMENT 'Identifier of the MRP execution that generated this plan.',
    `plant_code` STRING COMMENT 'Identifier of the fabrication plant or site for which the plan is created.',
    `procurement_group` STRING COMMENT 'Organizational unit within supply chain that owns the procurement process.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level that triggers a new procurement recommendation.',
    `required_date` DATE COMMENT 'The required date associated with the material requirement plan supply record.',
    `required_quantity` DECIMAL(18,2) COMMENT 'The required quantity of the material requirement plan record in the supply domain.',
    `requirement_date` DATE COMMENT 'The requirement date associated with the material requirement plan supply record.',
    `safety_stock` DECIMAL(18,2) COMMENT 'The safety stock of the material requirement plan record in the supply domain.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity kept as buffer to protect against demand or supply variability.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the planned quantity is expressed.. Valid values are `kg|pcs|l|m|mol|g`',
    CONSTRAINT pk_material_requirement_plan PRIMARY KEY(`material_requirement_plan_id`)
) COMMENT 'Material Requirements Planning (MRP) run outputs defining planned procurement quantities and timing for all fab materials based on production schedules, wafer start plans, safety stock levels, and reorder points. Captures planning run date, material, plant, planned order quantity, planned delivery date, MRP type, lot sizing procedure, and exception messages (shortfall, excess, rescheduling). Sourced from SAP S/4HANA PP-MRP (MDKP/MDTB).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` (
    `inbound_shipment_id` BIGINT COMMENT 'System-generated unique identifier for the inbound shipment record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to supply.carrier. Business justification: Link inbound shipments to carrier entity for logistics; replace free-text carrier column with carrier_id FK.',
    `experimental_lot_id` BIGINT COMMENT 'Foreign key linking to research.experimental_lot. Business justification: Shipment Tracking links each inbound shipment to the specific experimental lot it supplies; required for logistics and receipt reconciliation.',
    `purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Inbound shipments fulfill specific purchase orders. Critical for logistics-to-procurement traceability.',
    `primary_inbound_purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Inbound shipments deliver against purchase orders. Required for logistics tracking and landed cost.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the material.',
    `actual_arrival_date` DATE COMMENT 'Date on which the shipment was physically received.',
    `bill_of_lading_number` STRING COMMENT 'Reference number of the bill of lading document.',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether temperature‑controlled handling is required.',
    `compliance_status` STRING COMMENT 'Overall compliance assessment for the shipment (e.g., compliant, exception, pending).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inbound shipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the freight cost.',
    `customs_declaration_number` STRING COMMENT 'Identifier of the customs entry for the shipment.',
    `delivery_window_end` DATE COMMENT 'End date of the agreed delivery window.',
    `delivery_window_start` DATE COMMENT 'Start date of the agreed delivery window.',
    `destination_plant` STRING COMMENT 'Identifier of the fab or warehouse receiving the shipment.',
    `ear_controlled` BOOLEAN COMMENT 'Indicates whether the shipment contains items subject to Export Administration Regulations.',
    `estimated_arrival_date` DATE COMMENT 'Planned date on which the shipment is expected to arrive.',
    `expected_arrival_date` DATE COMMENT 'The expected arrival date associated with the inbound shipment supply record.',
    `export_control_classification` STRING COMMENT 'Export control classification code (e.g., ECCN) for the shipment.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total cost charged by the carrier for transporting the shipment.',
    `hazardous_goods_classification` STRING COMMENT 'Classification code for hazardous materials per UN/ADR.',
    `inbound_shipment_status` STRING COMMENT 'Current lifecycle status of the inbound shipment.. Valid values are `pending|in_transit|arrived|delayed|cancelled`',
    `incoterms` STRING COMMENT 'International commercial term defining responsibility and cost allocation.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the shipment contains items subject to ITAR regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the inbound shipment record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Planned number of days from shipment dispatch to arrival.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the inbound shipment record in the supply domain.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the shipment.',
    `origin_country` STRING COMMENT 'Three‑letter ISO country code of the shipment origin.. Valid values are `^[A-Z]{3}$`',
    `packaging_type` STRING COMMENT 'Description of the primary packaging used (e.g., pallet, container, drum).',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating for the shipment based on supplier and logistics factors.',
    `ship_date` DATE COMMENT 'The ship date associated with the inbound shipment supply record.',
    `shipment_number` STRING COMMENT 'External shipment reference number assigned by the carrier or logistics provider.',
    `shipment_status` STRING COMMENT 'The shipment status of the inbound shipment record in the supply domain.',
    `shipment_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary shipment event (e.g., departure from supplier).',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for the shipment when cold chain is required.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for the shipment when cold chain is required.',
    `tracking_number` STRING COMMENT 'Unique tracking identifier provided by the carrier.',
    `transport_mode` STRING COMMENT 'Mode of transport used for the inbound shipment.. Valid values are `air|sea|road|courier`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inbound shipment record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    CONSTRAINT pk_inbound_shipment PRIMARY KEY(`inbound_shipment_id`)
) COMMENT 'Inbound logistics records tracking the physical movement of procured materials from supplier origin to fab or warehouse destination. Captures shipment number, carrier, mode of transport (air, sea, road, courier), origin country, destination plant, estimated and actual arrival dates, freight cost, customs declaration number, Incoterms, hazardous goods classification, and cold chain requirements for temperature-sensitive chemicals. Supports landed cost calculation and supply continuity monitoring.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` (
    `supplier_scorecard_id` BIGINT COMMENT 'Unique identifier for the supplier scorecard record.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal reviewer who approved the scorecard.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier to which this scorecard applies.',
    `tertiary_supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Scorecards rate a specific suppliers performance.',
    `assessment_name` STRING COMMENT 'Descriptive name of the scorecard assessment period or initiative.',
    `closure_date` DATE COMMENT 'Date when the scorecard was formally closed.',
    `contact_name` STRING COMMENT 'Primary internal contact responsible for the scorecard.',
    `containment_action` STRING COMMENT 'Immediate actions taken to contain the defect.',
    `corrective_action` STRING COMMENT 'Planned corrective action to resolve the defect.',
    `cost_score` DECIMAL(18,2) COMMENT 'The cost score of the supplier scorecard record in the supply domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scorecard record was created.',
    `defect_description` STRING COMMENT 'Description of the defect or non-conformance that prompted the SCAR.',
    `delivery_score` DECIMAL(18,2) COMMENT 'The delivery score of the supplier scorecard record in the supply domain.',
    `dppm` STRING COMMENT 'The dppm of the supplier scorecard record in the supply domain.',
    `incoming_quality_rejection_rate_dppm` STRING COMMENT 'Defective parts per million observed on incoming material.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supplier scorecard record in the supply domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the supplier scorecard record in the supply domain.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `on_time_delivery_pct` DECIMAL(18,2) COMMENT 'The on time delivery pct of the supplier scorecard record in the supply domain.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of deliveries received on or before the promised date.',
    `overall_rating` STRING COMMENT 'Overall performance rating for the supplier in the period.. Valid values are `excellent|good|fair|poor`',
    `overall_score` DECIMAL(18,2) COMMENT 'The overall score of the supplier scorecard record in the supply domain.',
    `pcn_compliance` BOOLEAN COMMENT 'Indicates whether the supplier complied with required PCNs during the period.',
    `period` STRING COMMENT 'The period of the supplier scorecard record in the supply domain.',
    `preventive_action` STRING COMMENT 'Preventive measures to avoid recurrence of the defect.',
    `quality_score` DECIMAL(18,2) COMMENT 'The quality score of the supplier scorecard record in the supply domain.',
    `rating` STRING COMMENT 'The rating of the supplier scorecard record in the supply domain.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Composite risk score based on supply risk factors.',
    `root_cause` STRING COMMENT 'Root cause identified for the defect.',
    `scar_due_date` DATE COMMENT 'Date by which the supplier must complete corrective actions.',
    `scar_number` STRING COMMENT 'Unique identifier for a Supplier Corrective Action Request linked to this scorecard.',
    `scar_trigger_event` STRING COMMENT 'Event or issue that initiated the SCAR.',
    `score_date` DATE COMMENT 'The score date associated with the supplier scorecard supply record.',
    `scorecard_period` STRING COMMENT 'The scorecard period of the supplier scorecard record in the supply domain.',
    `scorecard_type` STRING COMMENT 'Frequency or nature of the assessment (e.g., annual, quarterly, monthly).',
    `scoring_period_end` DATE COMMENT 'End date of the scoring period.',
    `scoring_period_start` DATE COMMENT 'Start date of the scoring period.',
    `strategic_tier` STRING COMMENT 'Strategic importance tier assigned to the supplier.. Valid values are `tier1|tier2|tier3|tier4`',
    `supplier_scorecard_status` STRING COMMENT 'Current lifecycle status of the scorecard.. Valid values are `draft|final|approved|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scorecard.',
    `verification_status` STRING COMMENT 'Status of verification of the corrective action implementation.. Valid values are `pending|verified|failed`',
    CONSTRAINT pk_supplier_scorecard PRIMARY KEY(`supplier_scorecard_id`)
) COMMENT 'Unified supplier performance management, corrective action, and continuous improvement records. Captures periodic scorecard assessments (scoring period, overall rating, on-time delivery rate, incoming quality rejection rate in DPPM, PCN compliance, strategic tier), plus formal Supplier Corrective Action Requests (SCARs) issued for quality escapes, inspection failures, delivery non-conformances, or audit findings. SCAR records include SCAR number, triggering event, defect description, 8D problem-solving steps (containment, root cause, corrective action, preventive action), supplier response due dates, verification status, and closure dates. SSOT for all supplier performance measurement and corrective action within the supply domain. Drives AVL status decisions, preferred supplier designations, FMEA-driven quality improvement, DPPM reduction programs, and annual supplier business reviews.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` (
    `osat_work_order_id` BIGINT COMMENT 'Unique identifier for the OSAT work order record.',
    `approved_vendor_id` BIGINT COMMENT 'Identifier of the outsourced assembly and test (OSAT) vendor responsible for execution.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the work order record.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the osat work order supply entity.',
    `supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — OSAT work orders are issued to a specific OSAT vendor (who is a supplier). Mandatory for subcontractor management.',
    `primary_supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — OSAT work orders are issued to a specific OSAT vendor (who is a supplier).',
    `project_id` BIGINT COMMENT 'Reference to the internal IC design project associated with this work order.',
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record within the osat work order supply entity.',
    `approval_date` DATE COMMENT 'Date when the work order received final approval.',
    `approval_status` STRING COMMENT 'Current approval state of the work order within internal governance.. Valid values are `pending|approved|rejected`',
    `assembly_process_spec` STRING COMMENT 'Detailed description of the assembly steps, materials, and equipment to be used.',
    `completion_date` DATE COMMENT 'The completion date associated with the osat work order supply record.',
    `compliance_status` STRING COMMENT 'Current compliance verification result for export controls and regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values in the work order.',
    `delivery_commit_date` DATE COMMENT 'Date by which the OSAT vendor must deliver the finished product.',
    `die_quantity` BIGINT COMMENT 'Number of individual dies to be assembled and packaged under this work order.',
    `due_date` DATE COMMENT 'The due date associated with the osat work order supply record.',
    `export_control_classification` STRING COMMENT 'Classification of export control regime applicable to the work order.. Valid values are `EAR|ITAR|none`',
    `is_ear_controlled` BOOLEAN COMMENT 'Indicates whether the work order is subject to U.S. Export Administration Regulations (EAR).',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was officially issued to the OSAT vendor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the osat work order record in the supply domain.',
    `last_updated_by` STRING COMMENT 'User identifier of the person who last modified the work order record.',
    `lead_time_days` STRING COMMENT 'Historical or contracted lead time for the OSAT process.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the osat work order record in the supply domain.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information or special instructions.',
    `nre_charge` DECIMAL(18,2) COMMENT 'One-time engineering fee associated with the work order.',
    `order_date` DATE COMMENT 'The order date associated with the osat work order supply record.',
    `osat_work_order_status` STRING COMMENT 'Current lifecycle status of the work order.. Valid values are `draft|issued|in_progress|completed|cancelled|closed`',
    `package_type` STRING COMMENT 'Type of semiconductor package to be produced (e.g., Wafer-Level Chip Scale Package, Integrated Fan-Out).. Valid values are `wlcsp|info|cowos|flip_chip|wire_bond|die_attach`',
    `priority` STRING COMMENT 'Business priority level for scheduling and resource allocation.. Valid values are `high|medium|low`',
    `quality_rating` STRING COMMENT 'Quality tier assigned to the work order based on inspection results.. Valid values are `a|b|c|d|e|f`',
    `quantity` STRING COMMENT 'The quantity of the osat work order record in the supply domain.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score representing supply risk for this work order (higher = higher risk).',
    `service_type` STRING COMMENT 'The service type of the osat work order record in the supply domain.',
    `shipment_tracking_number` STRING COMMENT 'Carrier‑provided tracking identifier for the outbound shipment.',
    `start_date` DATE COMMENT 'The start date associated with the osat work order supply record.',
    `substrate_type` STRING COMMENT 'Material of the substrate used for the package (e.g., silicon, glass).. Valid values are `silicon|glass|ceramic|organic`',
    `target_cycle_time_days` STRING COMMENT 'Planned number of days from work order issue to delivery commitment.',
    `total_assembly_cost` DECIMAL(18,2) COMMENT 'Total monetary amount contracted for assembly (unit cost * quantity + NRE).',
    `unit_assembly_cost` DECIMAL(18,2) COMMENT 'Cost to assemble a single die/package unit, excluding NRE.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the work order record.',
    `vendor_name` STRING COMMENT 'Legal name of the OSAT subcontractor.',
    `work_order_number` STRING COMMENT 'Business identifier assigned to the work order by the OSAT vendor or internal system.',
    `work_order_status` STRING COMMENT 'The work order status of the osat work order record in the supply domain.',
    CONSTRAINT pk_osat_work_order PRIMARY KEY(`osat_work_order_id`)
) COMMENT 'Work orders issued to OSAT (Outsourced Semiconductor Assembly and Test) subcontractors for backend services including die packaging, wire bonding, flip-chip assembly, wafer-level packaging (WLCSP, InFO, CoWoS), and final test. Captures work order number, OSAT vendor, package type, die quantity, substrate type, assembly process specification, target cycle time, NRE charges, unit assembly cost, delivery commit date, and shipment tracking. Primary transactional record for managing outsourced backend operations within the supply domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` (
    `supplier_corrective_action_id` BIGINT COMMENT 'System-generated unique identifier for the supplier corrective action record.',
    `defect_record_id` BIGINT COMMENT 'Identifier of the defect record in the defect tracking system.',
    `supplier_audit_id` BIGINT COMMENT 'Unique identifier for the supplier audit record within the supplier corrective action supply entity.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier to which the corrective action applies.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual monetary cost incurred after corrective action completion.',
    `attached_document_url` STRING COMMENT 'Link to supporting documentation (e.g., inspection reports, photos).',
    `car_number` STRING COMMENT 'The car number of the supplier corrective action record in the supply domain.',
    `car_status` STRING COMMENT 'The car status of the supplier corrective action record in the supply domain.',
    `closure_date` DATE COMMENT 'The closure date associated with the supplier corrective action supply record.',
    `compliance_flag` STRING COMMENT 'Indicates whether the corrective action meets regulatory compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `containment_action` STRING COMMENT 'Immediate actions taken to contain the defect and prevent further impact.',
    `corrective_action` STRING COMMENT 'Planned action(s) the supplier must implement to eliminate the root cause.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation.. Valid values are `pending|completed|failed`',
    `cost_justification` STRING COMMENT 'Explanation of why the estimated/actual cost was incurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SCAR record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for cost fields.',
    `defect_description` STRING COMMENT 'Detailed description of the defect or non‑conformance discovered.',
    `due_date` DATE COMMENT 'Date by which the supplier must submit a response or corrective plan.',
    `ear_controlled` BOOLEAN COMMENT 'True if the SCAR involves items subject to Export Administration Regulations.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated monetary cost to implement the corrective action.',
    `export_control_classification` STRING COMMENT 'Export control classification code (e.g., ECCN) applicable to the SCAR.',
    `issue_date` DATE COMMENT 'The issue date associated with the supplier corrective action supply record.',
    `issue_description` STRING COMMENT 'The issue description of the supplier corrective action record in the supply domain.',
    `issued_timestamp` TIMESTAMP COMMENT 'Timestamp when the SCAR was formally issued to the supplier.',
    `itar_controlled` BOOLEAN COMMENT 'True if the SCAR involves items subject to International Traffic in Arms Regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supplier corrective action record in the supply domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the supplier corrective action record in the supply domain.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the SCAR.',
    `preventive_action` STRING COMMENT 'Long‑term actions to prevent recurrence of similar defects.',
    `preventive_action_status` STRING COMMENT 'Current status of the preventive action implementation.. Valid values are `pending|completed|failed`',
    `priority` STRING COMMENT 'Priority assigned to the SCAR for handling.. Valid values are `high|medium|low`',
    `related_po_number` STRING COMMENT 'Purchase order number associated with the material that triggered the SCAR, if applicable.',
    `risk_assessment_score` STRING COMMENT 'Numeric score representing the risk associated with the defect.',
    `root_cause` STRING COMMENT 'The root cause of the supplier corrective action record in the supply domain.',
    `root_cause_analysis` STRING COMMENT 'Analysis identifying the underlying cause of the defect.',
    `root_cause_category` STRING COMMENT 'High‑level classification of the root cause (e.g., process, material, design).',
    `scar_number` STRING COMMENT 'External reference number assigned to the SCAR by the organization.',
    `scar_status` STRING COMMENT 'The scar status of the supplier corrective action record in the supply domain.',
    `severity` STRING COMMENT 'Severity classification of the defect impact.. Valid values are `critical|high|medium|low`',
    `supplier_corrective_action_status` STRING COMMENT 'Overall lifecycle status of the SCAR.. Valid values are `open|in_progress|closed|cancelled`',
    `supplier_response` STRING COMMENT 'Narrative response provided by the supplier to the SCAR.',
    `supplier_response_date` DATE COMMENT 'Date on which the supplier submitted their response.',
    `triggering_event` STRING COMMENT 'Description of the event (e.g., inspection failure, delivery non‑conformance) that initiated the SCAR.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SCAR record.',
    `verification_date` DATE COMMENT 'Date on which the corrective action was verified as effective.',
    `verification_method` STRING COMMENT 'Method used to verify corrective action (e.g., inspection, test, audit).',
    `verification_status` STRING COMMENT 'Current status of the verification of the corrective action implementation.. Valid values are `pending|verified|failed`',
    CONSTRAINT pk_supplier_corrective_action PRIMARY KEY(`supplier_corrective_action_id`)
) COMMENT 'Formal Supplier Corrective Action Requests (SCARs) issued to suppliers following quality escapes, incoming inspection failures, delivery non-conformances, or audit findings. Captures SCAR number, triggering event, defect description, 8D problem-solving steps (containment, root cause, corrective action, preventive action), supplier response due date, verification status, and closure date. Supports FMEA-driven quality improvement and DPPM reduction programs.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` (
    `material_certification_id` BIGINT COMMENT 'System-generated unique identifier for each material certification record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Material certifications are a type of compliance certification; linking provides traceability to the certifying body.',
    `employee_id` BIGINT COMMENT 'Name of the internal engineer or manager who approved the certification for use.',
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt record within the material certification supply entity.',
    `material_supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Certifications are issued by the supplying vendor. Required for traceability.',
    `materials_research_id` BIGINT COMMENT 'Foreign key linking to research.materials_research. Business justification: Materials Research requires certification records for each researched material; linking certification to materials_research_id ensures compliance tracking.',
    `material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — Certifications (CoC/CoA) are issued for specific materials. Required for incoming quality release.',
    `primary_material_supplier_id` BIGINT COMMENT 'Identifier of the supplier that issued the certification.',
    `supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Certifications are issued BY a specific supplier for their material lots.',
    `tertiary_material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — Material certifications (CoC/CoA) are issued for specific materials. Required for incoming quality release decisions.',
    `approval_date` DATE COMMENT 'Date the certification was approved for production release.',
    `certificate_number` STRING COMMENT 'The certificate number of the material certification record in the supply domain.',
    `certificate_of_analysis` STRING COMMENT 'The certificate of analysis of the material certification record in the supply domain.',
    `certification_number` STRING COMMENT 'The certification number of the material certification record in the supply domain.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `issued|expired|revoked|pending`',
    `certification_type` STRING COMMENT 'Category of certification document, such as Certificate of Conformance, Certificate of Analysis, RoHS compliance, REACH compliance, TSCA certification, or Product Change Notification.. Valid values are `CoC|CoA|RoHS|REACH|TSCA|PCN`',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard to which the certification attests compliance.. Valid values are `RoHS|REACH|TSCA|IEC|ISO|Other`',
    `compliance_status` STRING COMMENT 'The compliance status of the material certification record in the supply domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `document_reference` STRING COMMENT 'Path or URL to the electronic certification document.',
    `document_version` STRING COMMENT 'Version identifier of the certification document.',
    `expiry_date` DATE COMMENT 'Date the certification expires or becomes invalid.',
    `issue_date` DATE COMMENT 'Date the certification was issued by the supplier.',
    `issuing_body` STRING COMMENT 'Name of the organization or department that issued the certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the material certification record in the supply domain.',
    `lot_number` STRING COMMENT 'The lot number of the material certification record in the supply domain.',
    `material_certification_status` STRING COMMENT 'The status of the material certification record in the supply domain.',
    `material_lot_number` STRING COMMENT 'Lot identifier assigned to the batch of material covered by the certification.',
    `material_number` STRING COMMENT 'Reference number of the material as defined in the material master.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the material certification record in the supply domain.',
    `notes` STRING COMMENT 'Free‑text field for additional remarks or observations.',
    `pcn_change_description` STRING COMMENT 'Detailed description of the change communicated in the PCN.',
    `pcn_change_type` STRING COMMENT 'Category of change described in the PCN.. Valid values are `process|material|site|eol|other`',
    `pcn_customer_notification_required` BOOLEAN COMMENT 'Indicates whether the PCN must be communicated to customers.',
    `pcn_effective_date` DATE COMMENT 'Date when the PCN change becomes effective.',
    `pcn_impact_assessment` STRING COMMENT 'Summary of the impact of the PCN on downstream processes and customers.',
    `pcn_number` STRING COMMENT 'Identifier of the PCN associated with this material certification, if applicable.',
    `pcn_requalification_decision` STRING COMMENT 'Decision on whether the material requires re‑qualification after the PCN.. Valid values are `required|not_required|pending`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating associated with the material based on certification and supplier data.',
    `test_result` STRING COMMENT 'Outcome of the compliance test associated with the certification.. Valid values are `pass|fail|conditional`',
    `test_results` STRING COMMENT 'The test results of the material certification record in the supply domain.',
    `test_units` STRING COMMENT 'Units of measurement for the test value, such as ppm, mg/kg, or %.',
    `test_value` DECIMAL(18,2) COMMENT 'Quantitative result of the test (e.g., concentration, impurity level).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_material_certification PRIMARY KEY(`material_certification_id`)
) COMMENT 'Supplier-originated material compliance documents including quality certifications and product change notifications. Captures Certificate of Conformance (CoC), Certificate of Analysis (CoA), RoHS compliance declarations, REACH SVHC declarations, TSCA certifications, and Product Change Notifications (PCNs). For certifications: certification type, issuing supplier, material lot number, test results, compliance standard, issue date, expiry date, and document reference. For PCNs: PCN number, supplier, affected material or component, change type (process, material, site, EOL), change description, effective date, impact assessment, required customer notification obligation, and re-qualification decision. SSOT for all supplier-originated material compliance and change documentation within the supply domain. Required for regulatory compliance, incoming quality release, process stability, and customer PCN pass-through obligations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` (
    `supply_forecast_id` BIGINT COMMENT 'Unique identifier for each supply forecast entry.',
    `material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — Forecasts specify quantities for specific materials.',
    `primary_supply_material_master_id` BIGINT COMMENT 'Identifier of the material (part number) for which the forecast is generated.',
    `primary_supply_supplier_id` BIGINT COMMENT 'Identifier of the strategic supplier receiving the forecast.',
    `supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Purchase forecasts are communicated TO specific suppliers for capacity planning.',
    `compliance_flag` BOOLEAN COMMENT 'True if the material is subject to regulatory constraints (e.g., RoHS, REACH) during the forecast period.',
    `confidence_level` DECIMAL(18,2) COMMENT 'The confidence level of the supply forecast record in the supply domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency used for price‑related attributes.',
    `demand_signal` STRING COMMENT 'The demand signal of the supply forecast record in the supply domain.',
    `forecast_date` DATE COMMENT 'The forecast date associated with the supply forecast supply record.',
    `forecast_method` STRING COMMENT 'The forecast method of the supply forecast record in the supply domain.',
    `forecast_period` STRING COMMENT 'The forecast period of the supply forecast record in the supply domain.',
    `forecast_quantity` DECIMAL(18,2) COMMENT 'The forecast quantity of the supply forecast record in the supply domain.',
    `forecast_source` STRING COMMENT 'Name of the ERP or planning system (e.g., SAP S/4HANA MM) that produced the forecast record.',
    `forecast_status` STRING COMMENT 'Lifecycle state of the forecast (e.g., draft, released to supplier, approved, or rejected).. Valid values are `draft|released|approved|rejected`',
    `forecast_type` STRING COMMENT 'Specifies if the forecast quantity is a firm commitment (firm) or an indicative estimate (indicative).. Valid values are `firm|indicative`',
    `horizon_end_date` DATE COMMENT 'Last calendar date covered by the forecast horizon.',
    `horizon_start_date` DATE COMMENT 'First calendar date covered by the forecast horizon.',
    `is_ltb` BOOLEAN COMMENT 'True if the forecast is used for planning a final purchase of an end‑of‑life material.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supply forecast record in the supply domain.',
    `last_review_date` DATE COMMENT 'Calendar date when the forecast was last reviewed by supply‑chain planners.',
    `lead_time_days` STRING COMMENT 'Planned supplier lead time in calendar days for the material during the forecast horizon.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the supply forecast record in the supply domain.',
    `notes` STRING COMMENT 'Additional remarks, assumptions, or explanations related to the forecast.',
    `period` STRING COMMENT 'Defines whether the forecast is expressed per week or per month.. Valid values are `weekly|monthly`',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Estimated cost per unit of material for the forecast horizon.',
    `prior_forecast_quantity` DECIMAL(18,2) COMMENT 'Forecast quantity from the immediately preceding version, used for variance calculations.',
    `quantity` DECIMAL(18,2) COMMENT 'Projected amount of the material to be supplied during the forecast horizon, expressed in the unit of measure.',
    `regulatory_status` STRING COMMENT 'Indicates which regulatory regime applies to the material for the forecasted period.. Valid values are `rohs|reach|none`',
    `risk_score` STRING COMMENT 'Numeric risk rating (0‑100) reflecting supply‑chain uncertainty for the forecasted material.',
    `supply_forecast_status` STRING COMMENT 'The status of the supply forecast record in the supply domain.',
    `unit_of_measure` STRING COMMENT 'Standard unit (e.g., pcs, kg) used for the forecast quantity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the forecast record.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Numeric difference between the current forecast quantity and the quantity from the previous forecast version.',
    `version` STRING COMMENT 'Sequential version number of the forecast, incremented on each revision.',
    CONSTRAINT pk_supply_forecast PRIMARY KEY(`supply_forecast_id`)
) COMMENT 'Forward-looking supply demand forecasts communicated to strategic suppliers as rolling purchase forecasts (typically 12-52 week horizon) to enable supplier capacity planning and material pre-positioning. Captures forecast period, material, supplier, forecasted quantity by week/month, firm vs. indicative horizon split, forecast version, and variance from prior forecast. Supports supplier capacity reservation and LTB (Last Time Buy) planning for EOL materials.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` (
    `supplier_quotation_id` BIGINT COMMENT 'Unique identifier for the supplier quotation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal buying organization requesting the quotation.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Supplier quotations are issued for specific IC parts; linking enables price and lead‑time analysis per part.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record within the supplier quotation supply entity.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the quotation response.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Research Project Quotation Request process records which project initiated a supplier quotation; enables project‑level cost analysis.',
    `award_currency` STRING COMMENT 'Currency used for the awarded price.. Valid values are `^[A-Z]{3}$`',
    `award_date` DATE COMMENT 'Date on which the quotation was awarded to the supplier.',
    `award_decision` STRING COMMENT 'Result of the quotation evaluation.. Valid values are `awarded|declined|pending`',
    `award_lead_time_days` STRING COMMENT 'Agreed delivery lead time after award.',
    `award_price` DECIMAL(18,2) COMMENT 'Final agreed price per unit after award.',
    `commodity_code` STRING COMMENT 'Standard code representing the material or service being sourced.',
    `commodity_description` STRING COMMENT 'Free‑text description of the commodity requested.',
    `compliance_flag` STRING COMMENT 'Indicates whether the quotation meets regulatory compliance requirements.. Valid values are `compliant|non_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quotation record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the quoted total price.',
    `evaluation_criteria` STRING COMMENT 'Criteria used to score and compare supplier quotations.',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the supplier quotation based on evaluation criteria.',
    `export_control_classification` STRING COMMENT 'Export control classification code (e.g., ECCN) for the quoted item.',
    `is_ear_controlled` BOOLEAN COMMENT 'True if the quotation is subject to U.S. Export Administration Regulations.',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ was issued to suppliers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supplier quotation record in the supply domain.',
    `lead_time_days` STRING COMMENT 'The lead time days of the supplier quotation record in the supply domain.',
    `minimum_order_quantity` STRING COMMENT 'Minimum quantity the supplier is willing to sell.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the supplier quotation record in the supply domain.',
    `net_price` DECIMAL(18,2) COMMENT 'Final net price after discounts and taxes.',
    `notes` STRING COMMENT 'The notes of the supplier quotation record in the supply domain.',
    `quotation_date` DATE COMMENT 'The quotation date associated with the supplier quotation supply record.',
    `quotation_number` STRING COMMENT 'External reference number assigned to the RFQ/quotation.',
    `quotation_status` STRING COMMENT 'The quotation status of the supplier quotation record in the supply domain.',
    `quoted_lead_time_days` STRING COMMENT 'Supplier‑stated delivery lead time in days.',
    `quoted_price` DECIMAL(18,2) COMMENT 'The quoted price of the supplier quotation record in the supply domain.',
    `quoted_total_price` DECIMAL(18,2) COMMENT 'Total price (unit price multiplied by quoted quantity) before discounts and taxes.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Price per unit offered by the supplier.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score associated with this quotation.',
    `submission_deadline` DATE COMMENT 'Last date suppliers may submit their quotation.',
    `supplier_quotation_status` STRING COMMENT 'Current lifecycle status of the quotation.. Valid values are `draft|issued|responded|evaluated|awarded|declined`',
    `supplier_response_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier submitted their quotation.',
    `target_quantity` STRING COMMENT 'Quantity the buyer intends to procure.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applicable to the quoted total price.',
    `technical_deviation_notes` STRING COMMENT 'Supplier‑provided notes on any deviations from the requested specifications.',
    `technical_specifications` STRING COMMENT 'Detailed technical requirements attached to the RFQ.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the target quantity.. Valid values are `pcs|kg|mm|cm|in|um`',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the supplier quotation record in the supply domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the quotation record.',
    `valid_until` DATE COMMENT 'The valid until of the supplier quotation record in the supply domain.',
    `valid_until_date` DATE COMMENT 'The valid until date associated with the supplier quotation supply record.',
    CONSTRAINT pk_supplier_quotation PRIMARY KEY(`supplier_quotation_id`)
) COMMENT 'Sourcing solicitation and supplier response records covering the full RFQ-to-award lifecycle. Captures RFQ issuance (commodity description, target quantity, technical specifications, evaluation criteria, submission deadline), supplier responses (quoted unit price, currency, delivery lead time, MOQ, technical deviations), comparative evaluation scores, and award/decline decisions. Enables competitive bidding, side-by-side comparison for sourcing decisions, and forms the basis for PO price negotiation. Sourced from SAP S/4HANA MM (EKKO type AN).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` (
    `product_change_notification_id` BIGINT COMMENT 'System-generated unique identifier for the product change notification record.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material impacted by the change.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier issuing the PCN.',
    `product_supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — PCNs are issued by specific suppliers. Must trace which supplier initiated the change notification.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: PCNs often trigger regulatory filings; linking enables automatic filing generation and status tracking.',
    `affected_component` STRING COMMENT 'Specific component or part of the product impacted by the change.',
    `affected_material_number` STRING COMMENT 'Material number of the impacted component.',
    `affected_process_step` STRING COMMENT 'Specific process step (e.g., lithography, etch) impacted by the change.',
    `affected_site` STRING COMMENT 'Manufacturing site or fab location impacted by the change.',
    `attachment_url` STRING COMMENT 'Link to the PDF or electronic file containing the full PCN details.',
    `change_category` STRING COMMENT 'The change category of the product change notification record in the supply domain.',
    `change_description` STRING COMMENT 'Detailed narrative describing the nature of the change.',
    `change_title` STRING COMMENT 'The change title of the product change notification record in the supply domain.',
    `change_type` STRING COMMENT 'Category of the change being announced.. Valid values are `process|material|site|eol|design|packaging`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PCN record was first created in the system.',
    `customer_notification_deadline` DATE COMMENT 'Latest date by which the customer must acknowledge or act on the PCN.',
    `ear_controlled` BOOLEAN COMMENT 'True if the change is subject to Export Administration Regulations.',
    `effective_date` DATE COMMENT 'Date on which the change becomes effective in production.',
    `export_control_classification` STRING COMMENT 'Export control classification code (e.g., ECCN) associated with the change.',
    `impact_assessment` STRING COMMENT 'Qualitative assessment of how the change affects product performance, yield, and qualification.',
    `impact_severity` STRING COMMENT 'Severity level of the change impact.. Valid values are `low|medium|high|critical`',
    `itar_controlled` BOOLEAN COMMENT 'True if the change is subject to International Traffic in Arms Regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the product change notification record in the supply domain.',
    `last_time_buy_date` DATE COMMENT 'The last time buy date associated with the product change notification supply record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the product change notification record in the supply domain.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `notification_date` DATE COMMENT 'The notification date associated with the product change notification supply record.',
    `pcn_number` STRING COMMENT 'External identifier assigned by the supplier for the change notification.',
    `pcn_status` STRING COMMENT 'The pcn status of the product change notification record in the supply domain.',
    `product_change_notification_status` STRING COMMENT 'Current lifecycle status of the product change notification.. Valid values are `draft|issued|closed|withdrawn`',
    `regulatory_body` STRING COMMENT 'Governing body or standard organization to which the PCN is reported.. Valid values are `SEMI|JEDEC|IEEE|IPC|ISO|EICC`',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates if the PCN must be reported to a governing body (e.g., SEMI).',
    `requalification_decision_date` DATE COMMENT 'Date on which the re‑qualification decision was made.',
    `requalification_required` BOOLEAN COMMENT 'Indicates if the change triggers a re‑qualification of the affected product.',
    `requalification_status` STRING COMMENT 'Current status of the re‑qualification effort.. Valid values are `pending|completed|not_required`',
    `required_customer_notification` BOOLEAN COMMENT 'Indicates whether the supplier requires the customer to be notified of the change.',
    `risk_score` STRING COMMENT 'Numerical risk rating assigned to the PCN based on supply impact.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the PCN record.',
    `version_number` STRING COMMENT 'Version of the PCN document, incremented on each amendment.',
    CONSTRAINT pk_product_change_notification PRIMARY KEY(`product_change_notification_id`)
) COMMENT 'Product Change Notifications (PCNs) received from suppliers announcing changes to materials, processes, packaging, or manufacturing sites that may impact semiconductor product performance or qualification status. Captures PCN number, supplier, affected material or component, change type (process, material, site, EOL), change description, effective date, impact assessment, required customer notification obligation, and re-qualification decision. Critical for maintaining process stability and customer PCN pass-through compliance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` (
    `disruption_event_id` BIGINT COMMENT 'Primary key for disruption_event',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier impacted by the disruption.',
    `disruption_supplier_id` BIGINT COMMENT 'Unique identifier for the disruption supplier record within the disruption event supply entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who logged the disruption.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material (part) impacted by the disruption.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order that is impacted by the disruption.',
    `cause_description` STRING COMMENT 'Narrative description of the root cause of the disruption.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disruption record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the financial impact amount.',
    `disruption_event_description` STRING COMMENT 'The description of the disruption event record in the supply domain.',
    `disruption_category` STRING COMMENT 'High‑level classification of the disruption domain.. Valid values are `supplier|logistics|quality|regulatory|environmental`',
    `disruption_duration_days` STRING COMMENT 'Calculated duration of the disruption in whole days.',
    `disruption_end_timestamp` TIMESTAMP COMMENT 'Date and time when the disruption ended or was resolved.',
    `disruption_event_status` STRING COMMENT 'Current lifecycle status of the disruption event.. Valid values are `reported|investigating|mitigated|resolved|closed`',
    `disruption_number` STRING COMMENT 'External reference number assigned to the disruption event for tracking across systems.',
    `disruption_start_timestamp` TIMESTAMP COMMENT 'Date and time when the disruption began.',
    `disruption_type` STRING COMMENT 'Categorizes the root cause of the supply disruption.. Valid values are `supplier_shutdown|natural_disaster|logistics_delay|customs_hold|quality_hold|geopolitical_restriction`',
    `ear_controlled` BOOLEAN COMMENT 'Indicates whether the disruption involves items subject to the U.S. Export Administration Regulations.',
    `escalation_level` STRING COMMENT 'Severity level used to prioritize response actions.. Valid values are `low|medium|high|critical`',
    `estimated_fab_impact_wafer_starts` STRING COMMENT 'Estimated number of wafer starts that could be delayed or lost due to the disruption.',
    `estimated_financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary estimate of the financial loss caused by the disruption.',
    `event_date` DATE COMMENT 'The event date associated with the disruption event supply record.',
    `event_description` STRING COMMENT 'The event description of the disruption event record in the supply domain.',
    `event_number` STRING COMMENT 'The event number of the disruption event record in the supply domain.',
    `event_severity` STRING COMMENT 'The event severity of the disruption event record in the supply domain.',
    `event_status` STRING COMMENT 'The event status of the disruption event record in the supply domain.',
    `event_type` STRING COMMENT 'The event type of the disruption event record in the supply domain.',
    `expected_recovery_date` DATE COMMENT 'The expected recovery date associated with the disruption event supply record.',
    `export_control_classification` STRING COMMENT 'Export control classification code (e.g., ECCN) relevant to the disrupted material.',
    `impact_assessment` STRING COMMENT 'The impact assessment of the disruption event record in the supply domain.',
    `impacted_po_quantity` DECIMAL(18,2) COMMENT 'Total quantity on the affected purchase order that is at risk.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the disruption involves ITAR‑controlled items.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the disruption event record in the supply domain.',
    `location_code` STRING COMMENT 'Factory or site code where the disruption originated or was observed.',
    `mitigation_action_taken` STRING COMMENT 'Description of actions performed to mitigate the disruption.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the disruption event record in the supply domain.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the disruption.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the disruption was first reported in the system.',
    `resolution_date` DATE COMMENT 'The resolution date associated with the disruption event supply record.',
    `resolution_outcome` STRING COMMENT 'Result of the disruption handling process.. Valid values are `resolved|partial|unresolved|cancelled`',
    `resolution_status` STRING COMMENT 'The resolution status of the disruption event record in the supply domain.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating assigned to the disruption event.',
    `severity` STRING COMMENT 'The severity of the disruption event record in the supply domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the disruption record.',
    CONSTRAINT pk_disruption_event PRIMARY KEY(`disruption_event_id`)
) COMMENT 'Records of actual supply disruption events impacting material availability, including supplier factory shutdowns, natural disasters, logistics delays, customs holds, quality holds, and geopolitical trade restrictions. Captures disruption event type, affected supplier and materials, disruption start and end dates, impacted PO quantity, estimated fab impact (wafer starts at risk), escalation level, mitigation actions taken, and resolution outcome. Feeds supply risk assessment updates and executive supply chain reporting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key for the SupplyAgreement association',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record within the supply agreement supply entity.',
    `project_id` BIGINT COMMENT 'Links to the R&D project consuming the supplied material or service',
    `sourcing_contract_id` BIGINT COMMENT 'Unique identifier for the sourcing contract record within the supply agreement supply entity.',
    `supplier_id` BIGINT COMMENT 'Links to the supplier providing the material or service',
    `agreement_number` STRING COMMENT 'Enriched attribute for supply_agreement.',
    `agreement_status` STRING COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `agreement_type` STRING COMMENT 'The agreement type of the supply agreement record in the supply domain.',
    `annual_price_review_flag` BOOLEAN COMMENT 'Whether annual price review is required',
    `auto_renew_flag` BOOLEAN COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `auto_renewal_flag` BOOLEAN COMMENT 'The auto renewal flag of the supply agreement record in the supply domain.',
    `capacity_commitment` STRING COMMENT 'The capacity commitment of the supply agreement record in the supply domain.',
    `capacity_reservation_qty` BIGINT COMMENT 'Reserved capacity quantity guaranteed by the supplier',
    `committed_volume` BIGINT COMMENT 'Enriched attribute for supply_agreement.',
    `contract_number` STRING COMMENT 'Unique identifier of the contract between supplier and project',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the supply agreement record in the supply domain.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the supply agreement supply record.',
    `delivery_frequency` STRING COMMENT 'Agreed delivery frequency (weekly, bi-weekly, monthly)',
    `delivery_terms` STRING COMMENT 'The delivery terms of the supply agreement record in the supply domain.',
    `dispute_resolution_method` STRING COMMENT 'Method for resolving disputes (arbitration, mediation, litigation)',
    `dual_source_flag` BOOLEAN COMMENT 'Whether this material is dual-sourced',
    `effective_date` DATE COMMENT 'Enriched attribute for supply_agreement.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the supply agreement supply record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the supply agreement supply record.',
    `expiration_date` DATE COMMENT 'The expiration date associated with the supply agreement supply record.',
    `expiry_date` DATE COMMENT 'Enriched attribute for supply_agreement.',
    `force_majeure_clause` STRING COMMENT 'Force majeure clause terms in the supply agreement',
    `governing_law` STRING COMMENT 'The governing law of the supply agreement record in the supply domain.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction governing this supply agreement',
    `incoterms` STRING COMMENT 'The incoterms of the supply agreement record in the supply domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the supply agreement record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Agreed lead time for delivery of supplies to the project',
    `liability_cap_usd` DECIMAL(18,2) COMMENT 'Maximum liability cap in USD under this agreement',
    `minimum_order_quantity` BIGINT COMMENT 'The minimum order quantity of the supply agreement record in the supply domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the supply agreement record in the supply domain.',
    `notes` STRING COMMENT 'The notes of the supply agreement record in the supply domain.',
    `payment_terms` STRING COMMENT 'The payment terms of the supply agreement record in the supply domain.',
    `penalty_clause` STRING COMMENT 'The penalty clause of the supply agreement record in the supply domain.',
    `penalty_terms` STRING COMMENT 'Added in v2 to expand attribute depth for thin product.',
    `price_escalation_clause` STRING COMMENT 'Clause describing how prices may be adjusted over the contract term',
    `price_structure` STRING COMMENT 'The price structure of the supply agreement record in the supply domain.',
    `price_terms` STRING COMMENT 'The price terms of the supply agreement record in the supply domain.',
    `pricing_terms` STRING COMMENT 'Enriched attribute for supply_agreement.',
    `priority_allocation_flag` BOOLEAN COMMENT 'The priority allocation flag of the supply agreement record in the supply domain.',
    `quality_rating` STRING COMMENT 'Quality performance rating for the supplier in the context of the project',
    `quality_requirement_spec` STRING COMMENT 'Quality specification requirements referenced in the agreement',
    `quality_requirements` STRING COMMENT 'The quality requirements of the supply agreement record in the supply domain.',
    `renewal_term_months` STRING COMMENT 'The renewal term months of the supply agreement record in the supply domain.',
    `renewal_terms` STRING COMMENT 'The renewal terms of the supply agreement record in the supply domain.',
    `risk_score` STRING COMMENT 'Risk rating assigned to the supplier for this project',
    `safety_stock_weeks` STRING COMMENT 'Required safety stock in weeks of supply',
    `supply_agreement_status` STRING COMMENT 'Enriched attribute for supply_agreement.',
    `sustainability_requirement` STRING COMMENT 'Sustainability and environmental requirements in the agreement',
    `termination_clause` STRING COMMENT 'The termination clause of the supply agreement record in the supply domain.',
    `termination_notice_days` STRING COMMENT 'The termination notice days of the supply agreement record in the supply domain.',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'The unit price usd of the supply agreement record in the supply domain.',
    `volume_commitment_qty` STRING COMMENT 'The volume commitment qty of the supply agreement record in the supply domain.',
    `volume_commitment_unit` STRING COMMENT 'The volume commitment unit of the supply agreement record in the supply domain.',
    `volume_flexibility_percent` DECIMAL(18,2) COMMENT 'Allowed volume flexibility percentage above/below committed volume',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'Represents the contractual relationship between a supplier and a research project. Each record captures the specific terms of that engagement, such as contract identifier, agreed lead time, risk assessment, quality rating, and any price‑escalation clauses.. Existence Justification: Suppliers provide materials, services, or equipment to many R&D projects, and each research project sources from multiple suppliers. The partnership is managed through formal contracts that capture lead times, risk scores, quality ratings, and pricing clauses, and these contracts are created, updated, and retired by business users.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` (
    `consignment_agreement_id` BIGINT COMMENT 'Primary key for consignment_agreement',
    `material_master_id` BIGINT COMMENT 'Identifier of the product or component that is being consigned.',
    `renewed_consignment_agreement_id` BIGINT COMMENT 'Self-referencing FK on consignment_agreement (renewed_consignment_agreement_id)',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier party that owns the consigned inventory.',
    `agreement_name` STRING COMMENT 'Human‑readable name or title of the consignment agreement.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the consignment agreement by the organization.',
    `agreement_status` STRING COMMENT 'The agreement status of the consignment agreement record in the supply domain.',
    `agreement_type` STRING COMMENT 'Category of consignment agreement indicating the fulfillment model.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement received formal approval.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the consignment agreement.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the agreement with internal and external regulations.',
    `consignment_agreement_status` STRING COMMENT 'Current lifecycle state of the consignment agreement.',
    `consignment_location` STRING COMMENT 'Warehouse or facility code where the consigned inventory is stored.',
    `consignment_quantity` DECIMAL(18,2) COMMENT 'Total quantity of the item placed on consignment.',
    `contract_version` STRING COMMENT 'Version identifier of the agreement document (e.g., v1.0, v2.1).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consignment agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the consignment agreement supply record.',
    `effective_from` DATE COMMENT 'Date on which the consignment agreement becomes binding.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the consignment agreement supply record.',
    `effective_until` DATE COMMENT 'Date on which the consignment agreement expires or is scheduled to end; null for open‑ended contracts.',
    `inventory_item_sku` STRING COMMENT 'Stock‑keeping unit of the consigned item as defined in the product master.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the consignment agreement record in the supply domain.',
    `max_consignment_value` DECIMAL(18,2) COMMENT 'The max consignment value of the consignment agreement record in the supply domain.',
    `max_stock_level` DECIMAL(18,2) COMMENT 'The max stock level of the consignment agreement record in the supply domain.',
    `min_stock_level` DECIMAL(18,2) COMMENT 'The min stock level of the consignment agreement record in the supply domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the consignment agreement record in the supply domain.',
    `notes` STRING COMMENT 'Free‑form text field for additional remarks, special conditions, or comments.',
    `ownership_transfer_trigger` STRING COMMENT 'The ownership transfer trigger of the consignment agreement record in the supply domain.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Agreed price for each unit of the consigned item.',
    `renewal_option` STRING COMMENT 'Indicates whether the agreement renews automatically, requires manual action, or does not renew.',
    `replenishment_terms` STRING COMMENT 'The replenishment terms of the consignment agreement record in the supply domain.',
    `risk_rating` STRING COMMENT 'Internal assessment of supply‑chain risk associated with the consignment agreement.',
    `settlement_terms` STRING COMMENT 'The settlement terms of the consignment agreement record in the supply domain.',
    `termination_notice_period_days` STRING COMMENT 'Number of days the counter‑party must be notified prior to termination.',
    `total_value` DECIMAL(18,2) COMMENT 'Calculated total monetary value of the consignment (quantity × price per unit).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the consigned quantity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the consignment agreement record.',
    CONSTRAINT pk_consignment_agreement PRIMARY KEY(`consignment_agreement_id`)
) COMMENT 'Master reference table for consignment_agreement. Referenced by consignment_agreement_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Primary key for carrier',
    `parent_carrier_id` BIGINT COMMENT 'Self-referencing FK on carrier (parent_carrier_id)',
    `site_id` BIGINT COMMENT 'add column site_id (BIGINT) with FK to shared.site.site_id - carriers operate from physical locations',
    `address_line1` STRING COMMENT 'First line of the carriers mailing address.',
    `address_line2` STRING COMMENT 'Second line of the carriers mailing address, if applicable.',
    `carrier_status` STRING COMMENT 'Current lifecycle status of the carrier record.',
    `carrier_type` STRING COMMENT 'Mode of transportation provided by the carrier.',
    `city` STRING COMMENT 'City component of the carriers mailing address.',
    `carrier_code` STRING COMMENT 'Internal business code used to reference the carrier within the enterprise.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of regulatory or industry certifications held by the carrier (e.g., ISO 9001, C‑TPAT).',
    `contact_email` STRING COMMENT 'Email address of the carriers primary contact.',
    `contact_name` STRING COMMENT 'Name of the primary contact person for the carrier.',
    `contact_phone` STRING COMMENT 'Telephone number of the carriers primary contact.',
    `contract_end_date` DATE COMMENT 'Date when the carrier agreement expires or is terminated; null if open‑ended.',
    `contract_start_date` DATE COMMENT 'Date when the carrier agreement became effective.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the carrier is headquartered.',
    `country_code` STRING COMMENT 'Coded value representing the country code of the carrier supply record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier record was first created in the system.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the carrier supply record.',
    `duns_number` STRING COMMENT 'The duns number of the carrier record in the supply domain.',
    `incoterms_supported` STRING COMMENT 'The incoterms supported of the carrier record in the supply domain.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Monetary value of cargo insurance coverage provided by the carrier.',
    `insurance_currency` STRING COMMENT 'Three‑letter ISO currency code for the insurance coverage amount.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the carrier record in the supply domain.',
    `lead_time_days` STRING COMMENT 'Typical number of days from shipment booking to delivery.',
    `max_volume_cbm` DECIMAL(18,2) COMMENT 'Maximum cargo volume the carrier can accommodate per shipment, expressed in cubic meters.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum payload weight the carrier can handle per shipment, expressed in kilograms.',
    `mode_of_transport` STRING COMMENT 'The mode of transport of the carrier record in the supply domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the carrier record in the supply domain.',
    `carrier_name` STRING COMMENT 'Legal or trade name of the logistics carrier.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information about the carrier.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'The on time delivery rate of the carrier record in the supply domain.',
    `on_time_rate_pct` DECIMAL(18,2) COMMENT 'The on time rate pct of the carrier record in the supply domain.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the carriers mailing address.',
    `primary_contact_name` STRING COMMENT 'The primary contact name of the carrier record in the supply domain.',
    `primary_phone` STRING COMMENT 'The primary phone of the carrier record in the supply domain.',
    `rating_score` DECIMAL(18,2) COMMENT 'Performance rating of the carrier on a 0‑5 scale.',
    `rating_source` STRING COMMENT 'Source or agency that provided the carrier rating.',
    `scac_code` STRING COMMENT 'Four‑character code assigned to the carrier by the Standard Carrier Alpha Code registry.',
    `service_area` STRING COMMENT 'Geographic regions or markets served by the carrier.',
    `service_level` STRING COMMENT 'The service level of the carrier record in the supply domain.',
    `service_levels` STRING COMMENT 'The service levels of the carrier record in the supply domain.',
    `state` STRING COMMENT 'State or province component of the carriers mailing address.',
    `state_province` STRING COMMENT 'The state province of the carrier record in the supply domain.',
    `tax_number` STRING COMMENT 'The tax number of the carrier record in the supply domain.',
    `transport_mode` STRING COMMENT 'The transport mode of the carrier record in the supply domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the carrier record.',
    `website` STRING COMMENT 'The website of the carrier record in the supply domain.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master reference table for carrier. Referenced by carrier_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_primary_approved_supplier_id` FOREIGN KEY (`primary_approved_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_purchase_supplier_id` FOREIGN KEY (`purchase_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_primary_po_material_master_id` FOREIGN KEY (`primary_po_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_primary_purchase_order_id` FOREIGN KEY (`primary_purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_primary_goods_purchase_order_id` FOREIGN KEY (`primary_goods_purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_tertiary_supplier_id` FOREIGN KEY (`tertiary_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ADD CONSTRAINT `fk_supply_supplier_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ADD CONSTRAINT `fk_supply_risk_assessment_disruption_event_id` FOREIGN KEY (`disruption_event_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`disruption_event`(`disruption_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ADD CONSTRAINT `fk_supply_risk_assessment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ADD CONSTRAINT `fk_supply_risk_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ADD CONSTRAINT `fk_supply_risk_assessment_risk_supplier_id` FOREIGN KEY (`risk_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_sourcing_supplier_id` FOREIGN KEY (`sourcing_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_tertiary_material_master_id` FOREIGN KEY (`tertiary_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_primary_inbound_purchase_order_id` FOREIGN KEY (`primary_inbound_purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ADD CONSTRAINT `fk_supply_supplier_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ADD CONSTRAINT `fk_supply_supplier_scorecard_tertiary_supplier_id` FOREIGN KEY (`tertiary_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_approved_vendor_id` FOREIGN KEY (`approved_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`approved_vendor`(`approved_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_primary_supplier_id` FOREIGN KEY (`primary_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ADD CONSTRAINT `fk_supply_supplier_corrective_action_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ADD CONSTRAINT `fk_supply_supplier_corrective_action_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_material_supplier_id` FOREIGN KEY (`material_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_primary_material_supplier_id` FOREIGN KEY (`primary_material_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_tertiary_material_master_id` FOREIGN KEY (`tertiary_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ADD CONSTRAINT `fk_supply_supply_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ADD CONSTRAINT `fk_supply_supply_forecast_primary_supply_material_master_id` FOREIGN KEY (`primary_supply_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ADD CONSTRAINT `fk_supply_supply_forecast_primary_supply_supplier_id` FOREIGN KEY (`primary_supply_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ADD CONSTRAINT `fk_supply_supply_forecast_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ADD CONSTRAINT `fk_supply_supplier_quotation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ADD CONSTRAINT `fk_supply_supplier_quotation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ADD CONSTRAINT `fk_supply_product_change_notification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ADD CONSTRAINT `fk_supply_product_change_notification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ADD CONSTRAINT `fk_supply_product_change_notification_product_supplier_id` FOREIGN KEY (`product_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ADD CONSTRAINT `fk_supply_disruption_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ADD CONSTRAINT `fk_supply_disruption_event_disruption_supplier_id` FOREIGN KEY (`disruption_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ADD CONSTRAINT `fk_supply_disruption_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ADD CONSTRAINT `fk_supply_disruption_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ADD CONSTRAINT `fk_supply_consignment_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ADD CONSTRAINT `fk_supply_consignment_agreement_renewed_consignment_agreement_id` FOREIGN KEY (`renewed_consignment_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`consignment_agreement`(`consignment_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ADD CONSTRAINT `fk_supply_consignment_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ADD CONSTRAINT `fk_supply_carrier_parent_carrier_id` FOREIGN KEY (`parent_carrier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`carrier`(`carrier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN5A|ECCN5B');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `financial_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `global_footprint` SET TAGS ('dbx_business_glossary_term' = 'Global Footprint');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `global_footprint` SET TAGS ('dbx_value_regex' = 'Global|Regional|Local');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `industry_classification` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `industry_classification` SET TAGS ('dbx_value_regex' = 'Raw Material|Chemical|Equipment|OSAT|Design Service');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `is_certified_kga` SET TAGS ('dbx_business_glossary_term' = 'KGA Certified');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net30|Net45|Net60|Cash');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `preferred_logistics_partner` SET TAGS ('dbx_business_glossary_term' = 'Preferred Logistics Partner');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_group` SET TAGS ('dbx_business_glossary_term' = 'Supplier Group');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_group` SET TAGS ('dbx_value_regex' = 'Strategic|Preferred|Standard|Transactional');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,15}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `website` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_commodity_scope` SET TAGS ('dbx_business_glossary_term' = 'Approved Commodity Scope');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_vendor_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `financial_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash|prepay');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `quality_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'supplier|subcontractor|osat|service_provider');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier (MMID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (LIFNR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (MEINS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `batch_management` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Indicator (XCHPF)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = 'USA|CHN|KOR|JPN|DEU|TWN');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Eccn Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `hazardous_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Classification (HAZ_CLASS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `hazardous_classification` SET TAGS ('dbx_value_regex' = 'non_hazardous|hazardous|restricted|controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `hazardous_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (LEAD_TIME_D)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (STAT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `lot_size_qty` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity (LOT_SIZE_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description (MAKTX_LONG)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_master_status` SET TAGS ('dbx_business_glossary_term' = 'Material Master Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name (MAKTX)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MATNR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type (MTART)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw|consumable|component|packaging|chemical|gas');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `max_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity (MAX_ORDER_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MIN_ORDER_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `procurement_group` SET TAGS ('dbx_business_glossary_term' = 'Procurement Group (EKGRP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag (QINSP_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag (REACH_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity (REORDER_PT_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag (ROHS_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SAFETY_STOCK_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `serial_management` SET TAGS ('dbx_business_glossary_term' = 'Serial Management Indicator (XCHPF_SERIAL)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (SHELF_LIFE_D)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (STAND_COST)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `storage_humidity_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Humidity (HUM_MAX_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `storage_humidity_min_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Humidity (HUM_MIN_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (TEMP_MAX_C)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (TEMP_MIN_C)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `tsca_compliant` SET TAGS ('dbx_business_glossary_term' = 'TSCA Compliance Flag (TSCA_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class (BKLAS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_buyer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_buyer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_buyer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_schedule` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `is_ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `is_ear_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MATNR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Date (PO_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'NET30|NET45|NET60|PREPAID|COD');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Po Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Po Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_group` SET TAGS ('dbx_business_glossary_term' = 'Purchase Group');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Status (PO_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_status` SET TAGS ('dbx_value_regex' = 'draft|open|released|closed|cancelled|blocked');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Type (PO_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|planned');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchasing_org` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (PO_GROSS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (PO_NET)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (PO_TAX)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `primary_po_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Po Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `primary_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Purchase Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `account_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `account_assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `account_assignment_type` SET TAGS ('dbx_value_regex' = 'COST_CENTER|WBS|ORDER');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'Not_Received|Partially_Received|Fully_Received|Cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DDP');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `is_final_invoice` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `is_service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'Open|Closed|Cancelled|On_Hold');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `po_line_status` SET TAGS ('dbx_business_glossary_term' = 'Po Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `purchase_group` SET TAGS ('dbx_business_glossary_term' = 'Purchase Group');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PCS');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '101|102|201|202');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|rework|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `received_by` SET TAGS ('dbx_business_glossary_term' = 'Received By');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `supplier_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Batch Reference');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'S|U|V');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Engineer ID (APPROVER_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `tertiary_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date (AUDIT_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team (AUDIT_TEAM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'initial|surveillance|for_cause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standards (COMPLIANCE_STD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_value_regex' = 'IATF16949|ISO9001|SEMI|JEDEC|IEC|ISO14001');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CAP_DUE_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CAP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `findings_severity` SET TAGS ('dbx_business_glossary_term' = 'Findings Severity (FIND_SEV)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `findings_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary (FIND_SUM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Rating (QUAL_RATING)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number (QUAL_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_program_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Type (QUAL_PROG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_program_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|change_triggered');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope (QUAL_SCOPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_value_regex' = 'quality_system_audit|process_capability|material_certification|combined');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|approved|expired|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score (RISK_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Standard');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `supplier_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VALID_TO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VALID_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `supplier_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `supplier_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `supplier_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category (AUDIT_CATEGORY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'quality|environment|security|process');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost (AUDIT_COST_USD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date (AUDIT_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_document_version` SET TAGS ('dbx_business_glossary_term' = 'Audit Document Version (DOC_VERSION)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration (DURATION_HOURS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_findings_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Document ID (FINDINGS_DOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method (AUDIT_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Number (AUDIT_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^AUD-d{4}-d{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL (REPORT_URL)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope (AUDIT_SCOPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_value_regex' = 'iso_9001|iif_14949|semi_gs|custom');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Audit Source System (SOURCE_SYSTEM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_value_regex' = 'SAP|MES|Custom|Other');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUDIT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team (AUDIT_TEAM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'initial|surveillance|for_cause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Notes (AUDITOR_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditionally_compliant');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CA_DUE_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CORRECTIVE_ACTION_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|not_required');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|Other');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled (EAR_CONTROLLED)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification (EXPORT_CLASS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|CCL|None');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `finding_count` SET TAGS ('dbx_business_glossary_term' = 'Finding Count');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `findings_critical_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count (CRITICAL_FINDINGS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `findings_major_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count (MAJOR_FINDINGS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `findings_minor_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count (MINOR_FINDINGS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary (FINDINGS_SUMMARY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled (ITAR_CONTROLLED)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location (AUDIT_LOCATION)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date (NEXT_AUDIT_DUE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Rating (OVERALL_RATING)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|unsatisfactory');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `supplier_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `supplier_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Rating (SUPPLIER_RATING)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `supplier_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score (SUSTAINABILITY_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_event_id` SET TAGS ('dbx_business_glossary_term' = 'Disruption ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Alternate Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|approved|rejected|archived');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `buffer_stock_target_qty` SET TAGS ('dbx_business_glossary_term' = 'Buffer Stock Target Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_end_date` SET TAGS ('dbx_business_glossary_term' = 'Disruption End Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Disruption Escalation Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_escalation_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_event_type` SET TAGS ('dbx_business_glossary_term' = 'Disruption Event Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_event_type` SET TAGS ('dbx_value_regex' = 'factory_shutdown|natural_disaster|logistics_delay|customs_hold|quality_hold|geopolitical_restriction');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_report_date` SET TAGS ('dbx_business_glossary_term' = 'Disruption Report Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_reported_by` SET TAGS ('dbx_business_glossary_term' = 'Disruption Reported By');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_start_date` SET TAGS ('dbx_business_glossary_term' = 'Disruption Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_status` SET TAGS ('dbx_business_glossary_term' = 'Disruption Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `disruption_status` SET TAGS ('dbx_value_regex' = 'open|closed|monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `estimated_fab_impact_wafer_starts` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fab Impact (Wafer Starts)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `financial_risk` SET TAGS ('dbx_business_glossary_term' = 'Financial Risk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `geographic_risk` SET TAGS ('dbx_business_glossary_term' = 'Geographic Risk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `geopolitical_risk` SET TAGS ('dbx_business_glossary_term' = 'Geopolitical Risk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `impact_estimate_wafer_starts` SET TAGS ('dbx_business_glossary_term' = 'Impact Estimate (Wafer Starts)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `impacted_po_quantity` SET TAGS ('dbx_business_glossary_term' = 'Impacted PO Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `mitigation_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions Taken');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability Percent');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|partial');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `review_cadence` SET TAGS ('dbx_business_glossary_term' = 'Review Cadence');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `review_cadence` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'single_source|geopolitical|financial|natural_disaster|export_control|other');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_comments` SET TAGS ('dbx_business_glossary_term' = 'Risk Comments');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Risk Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Department');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `sourcing_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'RFQ|Purchase|Service|License|Consignment');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP|FCA|CFR');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `pcn_notification_obligation` SET TAGS ('dbx_business_glossary_term' = 'PCN Notification Obligation');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `pcn_notification_obligation` SET TAGS ('dbx_value_regex' = 'required|optional|none');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `rebate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rebate Tier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `rebate_tier` SET TAGS ('dbx_value_regex' = 'none|tier1|tier2|tier3|tier4|tier5');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `sourcing_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `sourcing_contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|closed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `supply_continuity_obligation` SET TAGS ('dbx_business_glossary_term' = 'Supply Continuity Obligation');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pcs|kg|mm|inch|cm|m');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`sourcing_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_requirement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Plan Identifier (MRP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MAT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (VEND_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `tertiary_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag (BATCH_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_value_regex' = 'Y|N');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `demand_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Date (DEMAND_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand Quantity (DEMAND_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `exception_message` SET TAGS ('dbx_business_glossary_term' = 'Exception Message (EXC_MSG)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `gross_requirement` SET TAGS ('dbx_business_glossary_term' = 'Gross Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `is_fixed_lot` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Indicator (FIXED_LOT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (LEAD_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Procedure (LOT_SIZ_PROC)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_value_regex' = 'EXACT|FOQ|LFL|LOT|MIN|MAX');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MAT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_requirement_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Line Status (PLAN_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_requirement_plan_status` SET TAGS ('dbx_value_regex' = 'planned|released|cancelled|exception');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'MRP Controller (MRP_CTRL)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `mrp_status` SET TAGS ('dbx_business_glossary_term' = 'Mrp Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'MRP Type (MRP_TYP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|ND|VV|VV|V1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `net_requirement` SET TAGS ('dbx_business_glossary_term' = 'Net Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `plan_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `plan_period` SET TAGS ('dbx_business_glossary_term' = 'Plan Period');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost (PLAN_COST)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (PLAN_DELIV_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planned_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity (PLAN_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date (HORIZON_END_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date (HORIZON_START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Weeks');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_run_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Date (RUN_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_run_number` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Identifier (RUN_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `procurement_group` SET TAGS ('dbx_business_glossary_term' = 'Procurement Group (PURCH_GRP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity (ROP_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `required_date` SET TAGS ('dbx_business_glossary_term' = 'Required Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SAFE_STK_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|pcs|l|m|mol|g');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` SET TAGS ('dbx_subdomain' = 'logistics_coordination');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `primary_inbound_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Purchase Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `destination_plant` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Goods Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_[enum_ref_candidate' = 'class_1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_2' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_3' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_4' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_5' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_6' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_7' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_8' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_9_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|arrived|delayed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_[enum_ref_candidate' = 'exw');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_fca' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_fas' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_fob' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_cfr' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_cif' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_cpt' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_cip' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_dat' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_dap' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_dpu' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_ddp_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `origin_country` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `origin_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipment Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|sea|road|courier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Shipment Volume (m³)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (kg)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard ID (SCID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID (RID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `tertiary_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Assessment Name (SCN)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Closure Date (SCD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Contact Name (SCN)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action (CA)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action (CAct)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `cost_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description (DD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `delivery_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `dppm` SET TAGS ('dbx_business_glossary_term' = 'Dppm');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `incoming_quality_rejection_rate_dppm` SET TAGS ('dbx_business_glossary_term' = 'Incoming Quality Rejection Rate (DPPM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Notes (SN)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `on_time_delivery_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Pct');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate (OTDR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating (OR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `pcn_compliance` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification Compliance (PCN)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action (PAct)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score (RAS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scar_due_date` SET TAGS ('dbx_business_glossary_term' = 'SCAR Due Date (SCAR-DD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scar_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Corrective Action Request Number (SCAR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scar_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'SCAR Trigger Event (SCAR-TE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `score_date` SET TAGS ('dbx_business_glossary_term' = 'Score Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scorecard_period` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Period');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scorecard_type` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Type (SCT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scoring_period_end` SET TAGS ('dbx_business_glossary_term' = 'Scoring Period End Date (SPED)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scoring_period_start` SET TAGS ('dbx_business_glossary_term' = 'Scoring Period Start Date (SPSD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Tier (ST)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status (SS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|final|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` SET TAGS ('dbx_subdomain' = 'logistics_coordination');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `osat_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Work Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `approved_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Vendor Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `primary_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Project Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `assembly_process_spec` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Specification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `delivery_commit_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Commitment Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Die Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|none');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `is_ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Work Order Issue Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `nre_charge` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Charge');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `osat_work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `osat_work_order_status` SET TAGS ('dbx_value_regex' = 'draft|issued|in_progress|completed|cancelled|closed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'wlcsp|info|cowos|flip_chip|wire_bond|die_attach');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'a|b|c|d|e|f');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `substrate_type` SET TAGS ('dbx_value_regex' = 'silicon|glass|ceramic|organic');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `target_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Target Cycle Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `total_assembly_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Assembly Cost');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `unit_assembly_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Assembly Cost');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'OSAT Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'OSAT Work Order Number (WO#)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`osat_work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `supplier_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Corrective Action ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Related Defect ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `attached_document_url` SET TAGS ('dbx_business_glossary_term' = 'Attached Document URL');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `car_number` SET TAGS ('dbx_business_glossary_term' = 'Car Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `car_status` SET TAGS ('dbx_business_glossary_term' = 'Car Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `cost_justification` SET TAGS ('dbx_business_glossary_term' = 'Cost Justification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SCAR Issued Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `preventive_action_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `preventive_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `related_po_number` SET TAGS ('dbx_business_glossary_term' = 'Related Purchase Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root‑Cause Analysis');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root‑Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `scar_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Corrective Action Request (SCAR) Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `scar_status` SET TAGS ('dbx_business_glossary_term' = 'Scar Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `supplier_corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'SCAR Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `supplier_corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `supplier_response` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `supplier_response_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `materials_research_id` SET TAGS ('dbx_business_glossary_term' = 'Materials Research Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `primary_material_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Supplier Fk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `tertiary_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certificate_of_analysis` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (CERT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'issued|expired|revoked|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (CERT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'CoC|CoA|RoHS|REACH|TSCA|PCN');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard (STD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'RoHS|REACH|TSCA|IEC|ISO|Other');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference (DOC_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version (DOC_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body (ISSUER)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Material Lot Number (LOT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MAT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_change_description` SET TAGS ('dbx_business_glossary_term' = 'PCN Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_change_type` SET TAGS ('dbx_business_glossary_term' = 'PCN Change Type (PCN_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_change_type` SET TAGS ('dbx_value_regex' = 'process|material|site|eol|other');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'PCN Customer Notification Required');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_effective_date` SET TAGS ('dbx_business_glossary_term' = 'PCN Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'PCN Impact Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification Number (PCN_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_requalification_decision` SET TAGS ('dbx_business_glossary_term' = 'PCN Re‑qualification Decision');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_requalification_decision` SET TAGS ('dbx_value_regex' = 'required|not_required|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result (TEST_RES)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_results` SET TAGS ('dbx_business_glossary_term' = 'Test Results');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_units` SET TAGS ('dbx_business_glossary_term' = 'Test Units (TEST_UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_value` SET TAGS ('dbx_business_glossary_term' = 'Test Value (TEST_VAL)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `supply_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Forecast ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `primary_supply_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `primary_supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `demand_signal` SET TAGS ('dbx_business_glossary_term' = 'Demand Signal');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_period` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_source` SET TAGS ('dbx_business_glossary_term' = 'Forecast Source System');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|released|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'firm|indicative');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon End Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `is_ltb` SET TAGS ('dbx_business_glossary_term' = 'Last‑Time‑Buy Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Granularity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `period` SET TAGS ('dbx_value_regex' = 'weekly|monthly');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `prior_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Prior Forecast Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'rohs|reach|none');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Forecast Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `supply_forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Forecast Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_forecast` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `supplier_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quotation ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Party ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Party ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `award_currency` SET TAGS ('dbx_business_glossary_term' = 'Award Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `award_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `award_decision` SET TAGS ('dbx_business_glossary_term' = 'Award Decision');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `award_decision` SET TAGS ('dbx_value_regex' = 'awarded|declined|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `award_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Awarded Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `award_price` SET TAGS ('dbx_business_glossary_term' = 'Awarded Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `is_ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFQ Issue Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `quotation_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number (RFQ Number)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `quoted_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Quoted Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `quoted_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `quoted_total_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Total Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `supplier_quotation_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `supplier_quotation_status` SET TAGS ('dbx_value_regex' = 'draft|issued|responded|evaluated|awarded|declined');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `supplier_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `technical_deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Deviation Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `technical_specifications` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pcs|kg|mm|cm|in|um');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Valid Until');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_quotation` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` SET TAGS ('dbx_subdomain' = 'logistics_coordination');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `product_change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `product_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `affected_component` SET TAGS ('dbx_business_glossary_term' = 'Affected Component');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `affected_material_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Material Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `affected_process_step` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Step');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `affected_site` SET TAGS ('dbx_business_glossary_term' = 'Affected Site');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type (Process/Material/Site/EOL/Design/Packaging)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'process|material|site|eol|design|packaging');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `customer_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `pcn_status` SET TAGS ('dbx_business_glossary_term' = 'Pcn Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `product_change_notification_status` SET TAGS ('dbx_business_glossary_term' = 'PCN Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `product_change_notification_status` SET TAGS ('dbx_value_regex' = 'draft|issued|closed|withdrawn');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'SEMI|JEDEC|IEEE|IPC|ISO|EICC');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `requalification_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Decision Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `requalification_required` SET TAGS ('dbx_business_glossary_term' = 'Requalification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `requalification_status` SET TAGS ('dbx_business_glossary_term' = 'Requalification Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `requalification_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_required');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `required_customer_notification` SET TAGS ('dbx_business_glossary_term' = 'Required Customer Notification Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`product_change_notification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` SET TAGS ('dbx_subdomain' = 'logistics_coordination');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_event_id` SET TAGS ('dbx_business_glossary_term' = 'Disruption Event Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Material ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Purchase Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_event_description` SET TAGS ('dbx_business_glossary_term' = 'Disruption Event Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_category` SET TAGS ('dbx_business_glossary_term' = 'Disruption Category');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_category` SET TAGS ('dbx_value_regex' = 'supplier|logistics|quality|regulatory|environmental');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Disruption Duration (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disruption End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_event_status` SET TAGS ('dbx_business_glossary_term' = 'Disruption Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_event_status` SET TAGS ('dbx_value_regex' = 'reported|investigating|mitigated|resolved|closed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_number` SET TAGS ('dbx_business_glossary_term' = 'Disruption Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disruption Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_type` SET TAGS ('dbx_business_glossary_term' = 'Disruption Type (DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `disruption_type` SET TAGS ('dbx_value_regex' = 'supplier_shutdown|natural_disaster|logistics_delay|customs_hold|quality_hold|geopolitical_restriction');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `estimated_fab_impact_wafer_starts` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fab Impact (Wafer Starts)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `expected_recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Recovery Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `impacted_po_quantity` SET TAGS ('dbx_business_glossary_term' = 'Impacted PO Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `mitigation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action Taken');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'resolved|partial|unresolved|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`disruption_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'supply.supplier,research.project');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supply Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Research Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `annual_price_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Annual Price Review Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `capacity_commitment` SET TAGS ('dbx_business_glossary_term' = 'Capacity Commitment');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `capacity_reservation_qty` SET TAGS ('dbx_business_glossary_term' = 'Capacity Reservation Qty');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `dual_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Source Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `liability_cap_usd` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Usd');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `penalty_terms` SET TAGS ('dbx_business_glossary_term' = 'Penalty Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `price_terms` SET TAGS ('dbx_business_glossary_term' = 'Price Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Pricing Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `priority_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Allocation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `quality_requirement_spec` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirement Spec');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `safety_stock_weeks` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Weeks');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `supply_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `sustainability_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Usd');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supply_agreement` ALTER COLUMN `volume_flexibility_percent` SET TAGS ('dbx_business_glossary_term' = 'Volume Flexibility Percent');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` SET TAGS ('dbx_subdomain' = 'logistics_coordination');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `consignment_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Agreement Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `renewed_consignment_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Consignment Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `renewed_consignment_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `consignment_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `consignment_location` SET TAGS ('dbx_business_glossary_term' = 'Consignment Location');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `consignment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consignment Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `inventory_item_sku` SET TAGS ('dbx_business_glossary_term' = 'Inventory Item Sku');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `max_consignment_value` SET TAGS ('dbx_business_glossary_term' = 'Max Consignment Value');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Max Stock Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Min Stock Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `ownership_transfer_trigger` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transfer Trigger');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `replenishment_terms` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`consignment_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` SET TAGS ('dbx_subdomain' = 'logistics_coordination');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `parent_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Carrier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `parent_carrier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Duns Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `incoterms_supported` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Supported');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `insurance_currency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `max_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Max Volume Cbm');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Max Weight Kg');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode Of Transport');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Rate');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `on_time_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time Rate Pct');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Rating Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `rating_source` SET TAGS ('dbx_business_glossary_term' = 'Rating Source');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Scac Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `service_area` SET TAGS ('dbx_business_glossary_term' = 'Service Area');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `service_levels` SET TAGS ('dbx_business_glossary_term' = 'Service Levels');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`carrier` ALTER COLUMN `website` SET TAGS ('dbx_business_glossary_term' = 'Website');
