-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`supply` COMMENT 'Procurement and supply chain management including vendor management, purchase requisitions and orders, chemical procurement (chlorine, coagulants, polymers, fluoride), materials and spare parts inventory, warehouse management, contract management, supplier performance, and procurement compliance. Integrates with SAP MM for materials management supporting O&M and CIP execution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key. Ref: AWWA.',
    `address_line1` STRING COMMENT 'Primary street address line for the vendors business location including street number and name. Ref: AWWA.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, building, or unit information for the vendors business location. Ref: AWWA.',
    `approved_by` STRING COMMENT 'Name or identifier of the procurement manager or authority who approved the vendor for business. Ref: AWWA.',
    `approved_date` DATE COMMENT 'Date when the vendor was approved for procurement transactions following vendor qualification and onboarding process. Ref: AWWA.',
    `city` STRING COMMENT 'City name for the vendors business address. Ref: AWWA.',
    `classification` STRING COMMENT 'Business classification indicating the vendors relationship tier and procurement priority with the utility. Ref: AWWA.. Valid values are `strategic|preferred|approved|conditional|restricted`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the vendors business address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for vendor transactions. Typically USD for domestic water utility vendors.. Valid values are `^[A-Z]{3}$`',
    `diversity_certification` STRING COMMENT 'Diversity business certification status: Minority-owned Business Enterprise (MBE), Women-owned Business Enterprise (WBE), Disadvantaged Business Enterprise (DBE), Small Business Enterprise (SBE), Veteran-owned Business Enterprise (VBE), Service-Disabled Veteran-Owned Small Business (SDVOSB), Historically Underutilized Business Zone (HUBZone), or none. [ENUM-REF-CANDIDATE: mbe|wbe|dbe|sbe|vbe|sdvosb|hubzone|none — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet used for vendor credit assessment and business verification. Ref: AWWA.. Valid values are `^[0-9]{9}$`',
    `email_address` STRING COMMENT 'Primary business email address for vendor communication and electronic invoice delivery. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Business fax number for vendor document transmission if applicable. Ref: AWWA.. Valid values are `^+?[0-9]{10,15}$`',
    `insurance_certificate_on_file_flag` BOOLEAN COMMENT 'Indicates whether a current certificate of insurance meeting utility requirements is on file for this vendor. Ref: AWWA.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the vendors insurance certificate on file, used to track compliance with insurance requirements. Ref: AWWA.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order or invoice transaction with this vendor, used to identify inactive vendors. Ref: AWWA.',
    `minority_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a minority-owned business enterprise. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was last modified or updated. Ref: AWWA.',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor organization as registered with tax authorities and used in contracts. Ref: AWWA.',
    `name_short` STRING COMMENT 'Abbreviated or common name of the vendor used for display and reporting purposes. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text field for additional vendor information, special handling instructions, or procurement notes. Ref: AWWA.',
    `payment_method` STRING COMMENT 'Preferred method of payment for vendor invoices as specified in the vendor master record. Ref: AWWA.. Valid values are `ach|wire_transfer|check|credit_card|procurement_card`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor specifying the number of days for invoice payment or early payment discount terms. [ENUM-REF-CANDIDATE: net_10|net_15|net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30 — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `performance_rating` STRING COMMENT 'Overall vendor performance rating based on quality, delivery, service, and compliance metrics from vendor scorecards. Ref: AWWA.. Valid values are `excellent|good|satisfactory|needs_improvement|poor|not_rated`',
    `phone_number` STRING COMMENT 'Primary business phone number for vendor contact. Ref: AWWA.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the vendors business address, supporting 5-digit or ZIP+4 format. Ref: AWWA.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_contact_email` STRING COMMENT 'Email address for the primary contact person at the vendor. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account manager at the vendor organization. Ref: AWWA.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the primary contact person at the vendor. Ref: AWWA.. Valid values are `^+?[0-9]{10,15}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the vendor organization. Ref: AWWA.',
    `small_business_flag` BOOLEAN COMMENT 'Indicates whether the vendor qualifies as a small business under SBA size standards. Ref: AWWA.',
    `state_province` STRING COMMENT 'Two-letter state or province code for the vendors business address. Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number used for tax reporting and 1099 processing. Ref: AWWA.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `vendor_number` STRING COMMENT 'External business identifier for the vendor, typically assigned by SAP MM or procurement system. Used in purchase orders and invoices. Ref: AWWA.. Valid values are `^[A-Z0-9]{6,10}$`',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor record indicating whether the vendor is approved for procurement transactions. Ref: AWWA.. Valid values are `active|inactive|suspended|pending_approval|blocked`',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on the primary goods or services provided to the water utility. Ref: AWWA.. Valid values are `chemical_supplier|equipment_manufacturer|spare_parts_distributor|service_contractor|professional_services|utility_provider`',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `w9_on_file_flag` BOOLEAN COMMENT 'Indicates whether a current IRS Form W-9 (Request for Taxpayer Identification Number and Certification) is on file for this vendor. Ref: AWWA.',
    `website_url` STRING COMMENT 'Vendors corporate website URL for reference and product catalog access. Ref: AWWA.',
    `woman_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a woman-owned business enterprise. Ref: AWWA.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers and vendors providing goods and services to the water utility, including chemical suppliers (chlorine, coagulants, polymers, fluoride), equipment manufacturers, spare parts distributors, and service contractors. Captures vendor identity, classification, tax information, payment terms, approved status, diversity classification, and SAP MM vendor master attributes. Serves as the SSOT for vendor identity within the supply domain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key for the material catalog. Ref: AWWA.',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP) or wastewater treatment plant (WWTP) where this material is stocked and used. Materials may be plant-specific for operational segregation. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred or primary vendor for procurement of this material. Links to vendor master for pricing, lead time, and contract terms. Ref: AWWA.',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management: A (high-value, tight control), B (moderate-value), C (low-value, loose control), X (unclassified). Based on consumption value and criticality. Ref: AWWA.. Valid values are `A|B|C|X`',
    `base_unit_of_measure` STRING COMMENT 'Primary unit of measure for inventory management and procurement. Common units: EA (each), LB (pounds), GAL (gallons), KG (kilograms), L (liters), M (meters), FT (feet), M3 (cubic meters), CF (cubic feet), TON (tons), BOX, DRUM, PAIL. [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|M3|CF|TON|BOX|DRUM|PAIL — 13 candidates stripped; promote to reference product]. Ref: AWWA.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether material is managed in batches with unique batch numbers for traceability. True for chemicals, coagulants, polymers, and materials requiring lot tracking for quality control and regulatory compliance. Ref: AWWA.',
    `cas_number` STRING COMMENT 'Unique chemical substance identifier assigned by CAS. Used for water treatment chemicals, coagulants, polymers, disinfectants, and fluoride compounds. Ref: AWWA.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system. Used for catalog governance and audit trails. Ref: AWWA.',
    `critical_spare_flag` BOOLEAN COMMENT 'Indicates whether the material is a critical spare part required for emergency repairs of high-criticality assets (pumps, motors, valves, SCADA components). True for items with long lead times or single-source suppliers. Ref: AWWA.',
    `discontinued_date` DATE COMMENT 'Date when the material was marked as obsolete or phased out. Used for lifecycle management and historical procurement analysis. Ref: AWWA.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous under OSHA, EPA, or DOT regulations. True for chemicals requiring special handling, storage, and disposal (chlorine gas, caustic soda, acids).',
    `hazmat_class` STRING COMMENT 'DOT hazard class for transportation and storage (e.g., Class 2.3 Toxic Gas for chlorine, Class 8 Corrosive for caustic soda). Required for hazardous materials only. Ref: AWWA.',
    `issue_unit_of_measure` STRING COMMENT 'Unit of measure used when issuing materials from warehouse to work orders, maintenance activities, or treatment operations. [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|M3|CF|TON|BOX|DRUM|PAIL — 13 candidates stripped; promote to reference product]. Ref: AWWA.',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last updated. Tracks changes to descriptions, pricing, procurement parameters, or classification. Ref: AWWA.',
    `lead_time_days` STRING COMMENT 'Average number of calendar days from purchase order creation to goods receipt. Used for reorder point calculation and production planning. Ref: AWWA.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer or chemical producer. Used for warranty tracking, technical support, and approved vendor management. Ref: AWWA.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturers unique part number or catalog identifier. Critical for cross-referencing spare parts, ensuring correct replacements, and warranty claims. Ref: AWWA.',
    `material_description` STRING COMMENT 'Full business description of the material, chemical, spare part, or consumable. Includes technical specifications and usage context. Ref: AWWA.',
    `material_group` STRING COMMENT 'Hierarchical classification grouping materials by procurement category (e.g., water treatment chemicals, mechanical spares, electrical components, pipe fittings, meters, PPE). Used for purchasing analytics and vendor management. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,9}$`',
    `material_number` STRING COMMENT 'Externally-known unique material identifier used across procurement, inventory, and operations. Aligns with SAP MM material number format. Ref: AWWA.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material in the catalog. Active materials are available for procurement and use; obsolete materials are retained for historical reference only. Ref: AWWA.. Valid values are `active|inactive|obsolete|pending_approval|restricted|phased_out`',
    `material_type` STRING COMMENT 'SAP MM material type classification: ROH (raw material/chemical), HALB (semi-finished), FERT (finished product), HAWA (trading goods), VERP (packaging), DIEN (services), UNBW (non-valuated), NLAG (non-stock). [ENUM-REF-CANDIDATE: ROH|HALB|FERT|HAWA|VERP|DIEN|UNBW|NLAG|ERSA|IBAU|KMAT|LEER|LEIH|PIPE — promote to reference product]. Ref: AWWA.',
    `maximum_stock_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory level for the material. Used to prevent overstocking and optimize warehouse space utilization. Ref: AWWA.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum acceptable remaining shelf life at time of goods receipt. Materials received with less remaining shelf life are rejected or flagged for immediate use. Ref: AWWA.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Continuously updated average unit cost based on actual procurement transactions. Used for materials with price volatility (chemicals, fuel, metals). Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text field for additional material information including technical specifications, usage instructions, cross-reference notes, or special handling requirements not captured in structured fields. Ref: AWWA.',
    `price_unit` STRING COMMENT 'Quantity unit for which the price is specified (e.g., price per 1, per 100, per 1000). Used when materials are priced in bulk quantities. Ref: AWWA.',
    `procurement_type` STRING COMMENT 'Indicates whether material is procured externally from vendors, produced internally, both, or not procured (non-stock service items). Ref: AWWA.. Valid values are `external|internal|both|no_procurement`',
    `purchase_unit_of_measure` STRING COMMENT 'Unit of measure used for procurement transactions and purchase orders. May differ from base UOM for bulk chemical purchases. [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|M3|CF|TON|BOX|DRUM|PAIL — 13 candidates stripped; promote to reference product]. Ref: AWWA.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers automatic purchase requisition generation. Based on lead time demand and safety stock requirements. Ref: AWWA.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory buffer maintained to prevent stockouts during lead time variability or demand spikes. Critical for essential treatment chemicals and high-criticality spare parts. Ref: AWWA.',
    `serialized_flag` BOOLEAN COMMENT 'Indicates whether individual units of this material are tracked by unique serial numbers. True for high-value equipment, meters, and assets requiring individual lifecycle tracking. Ref: AWWA.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material remains usable from receipt date. Critical for chemicals with expiration dates (polymers, coagulants) and perishable consumables. Ref: AWWA.',
    `short_description` STRING COMMENT 'Abbreviated material description for display in transaction screens, purchase orders, and inventory reports. Ref: AWWA.',
    `standard_price` DECIMAL(18,2) COMMENT 'Standard unit cost used for inventory valuation and cost accounting. Updated periodically based on procurement history and market conditions. Ref: AWWA.',
    `storage_condition` STRING COMMENT 'Required storage conditions for the material including temperature range, humidity control, ventilation requirements, and segregation rules. Critical for chemicals and temperature-sensitive spare parts. Ref: AWWA.',
    `storage_location_code` STRING COMMENT 'Four-character code identifying the warehouse, chemical storage facility, or stockroom where the material is physically stored within the plant. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials used in international shipping and regulatory compliance (e.g., UN1017 for chlorine gas). Ref: AWWA.. Valid values are `^UN[0-9]{4}$`',
    `valuation_class` STRING COMMENT 'Four-digit code linking material to general ledger accounts for inventory valuation, cost of goods sold, and procurement expense posting. Ref: AWWA.. Valid values are `^[0-9]{4}$`',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Authoritative catalog of all materials, chemicals, spare parts, and consumables managed within the utilitys supply chain. Includes water treatment chemicals (chlorine, alum, polymer, fluoride, caustic soda), mechanical spare parts, electrical components, pipe fittings, meters, and PPE. Captures material number, description, unit of measure, material group, hazardous material flags, storage conditions, shelf life, and SAP MM material type. Aligns with SAP MM Material Master (MARA/MARC).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the manager or authorized person who approved the requisition. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Requisitions for project-specific materials and services require formal project linkage for approval workflow, budget validation, and procurement planning. Water utilities capital procurement processe. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Cost center code of the department or operational unit initiating the requisition. Used for budget tracking and financial allocation. Ref: AWWA.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Requisitions check budget availability for pre-encumbrance control. Standard budget workflow ensuring requisitions have budget authority before approval and PO creation. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Requisitions check fund availability before approval in governmental accounting. Required budget control ensuring requisitions dont exceed fund appropriations before PO creation. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'General ledger account number to which the requisition cost will be charged. Used for financial reporting and compliance with Generally Accepted Accounting Principles (GAAP) and Governmental Accounting Standards Board (GASB). Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Purchase requisitions request specific materials from the material catalog. Currently uses denormalized material_code STRING; should be proper FK to material_master. Removes redundant material_code, m. Ref: AWWA.',
    `primary_purchase_requisitioner_employee_id` BIGINT COMMENT 'Employee identifier of the person who created or submitted the requisition. Used for accountability and audit trail. Ref: AWWA.',
    `account_assignment_category` STRING COMMENT 'Type of financial account assignment for the requisition: cost center for Operations and Maintenance (O&M), work order for maintenance tasks, project for Capital Improvement Program (CIP), asset for asset procurement, or sales order for third-party. Ref: AWWA.. Valid values are `cost_center|work_order|project|asset|sales_order`',
    `approval_date` DATE COMMENT 'Date when the requisition was approved by the authorized approver. Ref: AWWA.',
    `asset_number` STRING COMMENT 'Asset master number if the requisition is for procurement of a new asset or major component to be capitalized. Ref: AWWA.. Valid values are `^[A-Z0-9]{8,12}$`',
    `contract_number` STRING COMMENT 'Reference to an existing contract or blanket purchase agreement under which this requisition should be processed. Ref: AWWA.. Valid values are `^[A-Z0-9]{8,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the system. Used for audit trail and process analytics. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the requisition (quantity × estimated unit price), used for financial approval routing. Ref: AWWA.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the requested material or service, used for budget planning and approval thresholds. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was last updated. Used for change tracking and audit compliance. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional free-text notes or special instructions provided by the requisitioner to guide procurement or delivery. Ref: AWWA.',
    `priority_code` STRING COMMENT 'Urgency level of the requisition indicating how quickly the procurement must be processed. Ref: AWWA.. Valid values are `low|normal|high|urgent|emergency`',
    `purchase_order_number` STRING COMMENT 'Purchase order number generated from this requisition once it has been converted by the purchasing department. Ref: AWWA.. Valid values are `^[A-Z0-9]{10}$`',
    `purchasing_group` STRING COMMENT 'Purchasing group or buyer code responsible for processing the requisition and creating the purchase order. Ref: AWWA.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Purchasing organization code responsible for procurement activities. May represent a regional or centralized procurement function. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of material or service units requested in the requisition. Ref: AWWA.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver if the requisition was rejected. Used for feedback and process improvement. Ref: AWWA.',
    `requesting_plant_code` STRING COMMENT 'Plant or facility code where the materials or services are required. Corresponds to Water Treatment Plant (WTP) or Wastewater Treatment Plant (WWTP) location. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `requesting_storage_location` STRING COMMENT 'Storage location or warehouse code within the plant where materials should be delivered. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials or services must be delivered to meet operational or project needs. Ref: AWWA.',
    `requisition_date` DATE COMMENT 'Date when the purchase requisition was created or submitted by the requesting department. Ref: AWWA.',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows. Corresponds to SAP BANF number. Ref: AWWA.. Valid values are `^[A-Z0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and procurement workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|partially_ordered|fully_ordered|cancelled|closed — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on procurement category: standard purchase, stock replenishment, service procurement, subcontracting, consignment, or third-party. Ref: AWWA.. Valid values are `standard|stock|service|subcontracting|consignment|third_party`',
    `requisitioner_name` STRING COMMENT 'Full name of the employee who created the requisition. Provides human-readable context for the request. Ref: AWWA.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system from which the requisition originated (SAP MM, IBM Maximo CMMS, Microsoft Dynamics 365, or manual entry).. Valid values are `SAP_MM|MAXIMO|DYNAMICS|MANUAL`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity (e.g., EA for each, LB for pounds, GAL for gallons, KG for kilograms). Ref: AWWA.. Valid values are `^[A-Z]{2,3}$`',
    `vendor_code` STRING COMMENT 'Preferred or suggested vendor code for the procurement. May be populated if the requisitioner has a specific supplier in mind. Ref: AWWA.. Valid values are `^[A-Z0-9]{6,10}$`',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `work_order_number` STRING COMMENT 'Reference to the originating work order in the Computerized Maintenance Management System (CMMS) such as IBM Maximo, if the requisition is triggered by a maintenance or repair task.. Valid values are `^[A-Z0-9]{8,12}$`',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal request to procure materials or services, initiated by operations, maintenance, or project teams. Captures requisition number, requesting cost center, material or service description, quantity, estimated value, required delivery date, priority, approval status, and originating work order or CIP project reference. Represents the demand signal that triggers the procurement workflow in SAP MM (BANF/EBAN).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record. Primary key. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Capital equipment and materials procurement for CIP projects requires direct project assignment on POs for cost allocation, budget tracking, and financial reporting. Water utilities track project cost. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center to which this purchase order expenditure is charged. Used for Operations and Maintenance (O&M) or Capital Expenditure (CAPEX) tracking. Ref: AWWA.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: POs consume budget line allocations for encumbrance accounting. Core budget control requirement linking purchase commitments to approved budgets for spending authority validation. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: POs encumber fund budgets in governmental accounting per GASB standards. Critical for public water utility fund accounting, ensuring expenditures charge correct funds (operating, capital, debt service. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'General ledger account code for financial posting of this purchase order. Aligns with chart of accounts. Ref: AWWA.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_category. Business justification: Purchase orders are classified by procurement category for spend analysis, compliance tracking, and approval routing. Currently uses denormalized procurement_category STRING; should be proper FK. Card. Ref: AWWA.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Purchase orders can be issued against blanket procurement contracts. Currently uses denormalized contract_number STRING; should be proper FK to enable contract compliance tracking and spend rollup. Ca. Ref: AWWA.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_requisition. Business justification: Purchase orders are created FROM purchase requisitions in the procurement workflow. Currently uses denormalized requisition_number STRING; should be proper FK. This enables tracing PO back to originat. Ref: AWWA.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Purchase orders specify delivery location. Currently uses denormalized ship_to_location_code STRING; should be proper FK to warehouse_location. Label prefix ship_to_ distinguishes this from other po. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor to whom this purchase order is issued. Links to vendor master data. Ref: AWWA.',
    `approval_date` DATE COMMENT 'Date when the purchase order received final approval and was authorized for issuance to vendor. Ref: AWWA.',
    `approval_status` STRING COMMENT 'Current state in the purchase order approval workflow. Tracks progression through approval chain based on dollar thresholds and authority matrix. Ref: AWWA.. Valid values are `not_submitted|pending|approved|rejected|cancelled`',
    `approved_by` STRING COMMENT 'Name or identifier of the approving authority who authorized this purchase order. May be manager, director, or executive based on approval limits. Ref: AWWA.',
    `buyer_email` STRING COMMENT 'Email address of the procurement buyer for vendor communication and order inquiries. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `buyer_name` STRING COMMENT 'Name of the procurement specialist or buyer who created and manages this purchase order. Ref: AWWA.',
    `buyer_phone` STRING COMMENT 'Contact phone number of the procurement buyer. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was first created in the system. Audit trail for record creation. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order.. Valid values are `^[A-Z]{3}$`',
    `delivery_address_line1` STRING COMMENT 'Primary street address line for delivery location. May be Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), warehouse, or field site. Ref: AWWA.',
    `delivery_address_line2` STRING COMMENT 'Secondary address line for delivery location (building, suite, department). Ref: AWWA.',
    `delivery_city` STRING COMMENT 'City name for the delivery location. Ref: AWWA.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code for the delivery location.. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for the delivery location. Ref: AWWA.',
    `delivery_state` STRING COMMENT 'Two-letter state or province code for the delivery location. Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `freight_amount` DECIMAL(18,2) COMMENT 'Shipping and freight charges associated with this purchase order. May be included in line items or as separate charge. Ref: AWWA.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for shipping, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]. Ref: AWWA.',
    `is_capital_purchase` BOOLEAN COMMENT 'Indicates whether this purchase order is for capital assets (CAPEX) versus operating expenses (OPEX). True for Capital Improvement Program (CIP) purchases. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was last updated. Tracks changes to PO details, status, or line items. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text notes and special instructions for the vendor or internal procurement team. May include delivery instructions, quality requirements, or compliance notes. Ref: AWWA.',
    `payment_terms` STRING COMMENT 'Agreed payment terms with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Defines when payment is due after invoice receipt. Ref: AWWA.',
    `po_date` DATE COMMENT 'Date when the purchase order was created or issued. Principal business event timestamp for procurement tracking. Ref: AWWA.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Unique document number used in vendor communications and invoice matching. Ref: AWWA.. Valid values are `^[A-Z0-9]{10,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle state of the purchase order. Tracks progression from creation through approval, issuance, receipt, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `po_type` STRING COMMENT 'Classification of the purchase order by procurement category. Standard for one-time purchases, blanket for recurring, contract for long-term agreements, emergency for urgent needs, capital for Capital Improvement Program (CIP) assets, service for professional services. Ref: AWWA.. Valid values are `standard|blanket|contract|emergency|capital|service`',
    `promised_delivery_date` DATE COMMENT 'Date confirmed by the vendor for delivery. May differ from requested date based on vendor capacity and lead time. Ref: AWWA.',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services. Used for planning and vendor performance tracking. Ref: AWWA.',
    `requestor_name` STRING COMMENT 'Name of the employee or department that originated the purchase request. May be operations, maintenance, or capital projects team. Ref: AWWA.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order. Includes sales tax, use tax, or value-added tax (VAT) as applicable. Ref: AWWA.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and fees. Represents committed spend. Ref: AWWA.',
    `total_amount_with_tax` DECIMAL(18,2) COMMENT 'Grand total of the purchase order including base amount, taxes, and freight. Represents total financial commitment. Ref: AWWA.',
    `vendor_site_code` STRING COMMENT 'Specific vendor location or site code for delivery and invoicing purposes. Used when vendor has multiple facilities. Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `wbs_element` STRING COMMENT 'Project WBS element for capital projects. Used when purchase order supports Capital Improvement Program (CIP) execution. Ref: AWWA.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal procurement document issued to a vendor for the supply of materials or services at agreed price and delivery terms, including release orders against blanket contracts and scheduling agreements. Captures PO number, vendor, document type (standard, release, framework call-off), parent contract reference, line items, quantities, unit prices, total value, delivery address (WTP, WWTP, warehouse), payment terms, incoterms, approval chain, cumulative released value versus contract ceiling, and SAP MM document type. Supports both O&M consumables and CIP capital procurement. Aligns with SAP MM Purchase Order (EKKO/EKPO).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Cost center code to which Operating Expenditure (OPEX) for this line item is charged. Used for departmental cost tracking and O&M budget management. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Line items allocate to funds for detailed encumbrance tracking in governmental accounting. Enables fund-level budget monitoring and GASB-compliant financial reporting for water utilities. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'General Ledger account number to which this line item expenditure is posted. Used for financial reporting in accordance with Generally Accepted Accounting Principles (GAAP) and Governmental Accounting Standards Board (GASB) standards for municipal utilities. Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record being procured. Identifies the specific chemical, spare part, equipment, or service item. Ref: AWWA.',
    `primary_po_material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record being procured. Identifies the specific chemical, spare part, equipment, or service item. Ref: AWWA.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document. Ref: AWWA.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_requisition. Business justification: PO line items are created FROM purchase requisition line items in the procurement workflow. This traces each PO line back to the originating business need for audit and requirement fulfillment trackin. Ref: AWWA.',
    `account_assignment_category` STRING COMMENT 'Type of financial account assignment for this line item. Determines whether costs are charged to a cost center (Operations and Maintenance / O&M), asset (capitalized equipment), Work Breakdown Structure (WBS) element (Capital Improvement Program / CIP project), or internal order. Ref: AWWA.. Valid values are `cost_center|asset|wbs_element|order|network`',
    `asset_number` STRING COMMENT 'Fixed asset number for capitalized equipment or infrastructure. Used when the procurement is for a capital asset that will be depreciated over its useful life. Ref: AWWA.. Valid values are `^[A-Z0-9]{8,12}$`',
    `confirmation_control_key` STRING COMMENT 'Control key determining whether and how vendor confirmations (order acknowledgments, shipping notifications) are required for this line item. Used for supply chain visibility and delivery tracking. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order line item record was first created in the system. Used for audit trail and procurement cycle time analysis. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the net price. Typically USD for US-based water utilities.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been marked for deletion. Deleted line items are excluded from further processing but retained for audit trail. Ref: AWWA.',
    `delivery_date` DATE COMMENT 'Requested or committed delivery date for this line item. Critical for chemical inventory management and project scheduling in Capital Improvement Program (CIP) and Operations and Maintenance (O&M) activities. Ref: AWWA.',
    `delivery_status` STRING COMMENT 'Current delivery fulfillment status of this line item. Tracks progress from order placement through complete goods receipt. Ref: AWWA.. Valid values are `not_delivered|partially_delivered|fully_delivered|over_delivered`',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether a goods receipt is required for this line item. True for materials requiring physical receipt confirmation; false for services or non-stock items. Ref: AWWA.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this line item to date. Updated as goods receipts are posted. Used to track delivery fulfillment and outstanding quantities. Ref: AWWA.',
    `invoice_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced against this line item to date. Used for invoice verification and to identify discrepancies between ordered, received, and invoiced quantities. Ref: AWWA.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether an invoice is expected for this line item. Used to control invoice verification and three-way matching (PO, goods receipt, invoice) in accounts payable processing. Ref: AWWA.',
    `item_category` STRING COMMENT 'Classification of the procurement line item type. Determines procurement processing rules, inventory treatment, and account assignment behavior. Ref: AWWA.. Valid values are `standard|consignment|subcontracting|service|stock_transfer|third_party`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this line item record. Tracks changes to quantities, prices, delivery dates, or other line item attributes. Ref: AWWA.',
    `line_number` STRING COMMENT 'Sequential line number within the purchase order. Determines the ordering and position of this item in the multi-line PO document. Ref: AWWA.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer (OEM) part number. Critical for spare parts procurement to ensure compatibility with existing equipment in treatment plants and distribution infrastructure. Ref: AWWA.',
    `material_group` STRING COMMENT 'Material group classification code for procurement analytics and spend categorization. Groups similar materials (e.g., all treatment chemicals, all pipe fittings, all electrical components) for supplier performance analysis and contract management. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,9}$`',
    `material_number` STRING COMMENT 'Business identifier for the material being procured. Alphanumeric code used across procurement, inventory, and operations to identify chemicals (chlorine, coagulants, polymers, fluoride), spare parts, equipment, or services. Ref: AWWA.. Valid values are `^[A-Z0-9]{6,18}$`',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total net value for this line item, calculated as quantity_ordered multiplied by net_price, adjusted for price_unit. Excludes taxes. Ref: AWWA.',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit of measure for this line item, excluding taxes and discounts. Used to calculate line item total value. Ref: AWWA.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the vendor may over-deliver beyond the ordered quantity without requiring approval. Expressed as a percentage (e.g., 5.00 for 5%). Ref: AWWA.',
    `plant_code` STRING COMMENT 'Four-character code identifying the receiving plant or facility. Typically represents a Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), or warehouse location. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `price_unit` STRING COMMENT 'Number of units to which the net price applies. For example, if price is $100 per 10 gallons, price_unit would be 10. Ref: AWWA.',
    `purchase_requisition_item` STRING COMMENT 'Line item number within the source purchase requisition. Used in conjunction with purchase_requisition_number for complete requisition-to-PO traceability. Ref: AWWA.',
    `purchasing_group` STRING COMMENT 'Three-character code identifying the buyer or purchasing team responsible for this procurement. Used for workload distribution and buyer performance tracking. Ref: AWWA.. Valid values are `^[A-Z0-9]{3}$`',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity of material or service ordered on this line item. Expressed in the unit of measure specified for this line. Ref: AWWA.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that originated the purchase requisition leading to this PO line item. Used for procurement tracking and accountability. Ref: AWWA.',
    `short_text` STRING COMMENT 'Brief description of the material or service being procured on this line. Provides human-readable context for the line item, especially useful for non-stock materials or services. Ref: AWWA.',
    `storage_location` STRING COMMENT 'Storage location code within the plant where material will be received and stored. Used for warehouse management and inventory tracking. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_code` STRING COMMENT 'Tax jurisdiction code determining applicable sales tax, use tax, or VAT for this line item. Used for tax calculation and compliance reporting. Ref: AWWA.. Valid values are `^[A-Z0-9]{1,2}$`',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the vendor may under-deliver below the ordered quantity without penalty. Expressed as a percentage (e.g., 2.00 for 2%). Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the ordered quantity. Common units include EA (each), GAL (gallons) for chemicals, LB (pounds), KG (kilograms), HR (hours) for services, TON for bulk materials. [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|TON|CY|HR|DAY — 11 candidates stripped; promote to reference product]. Ref: AWWA.',
    `vendor_material_number` STRING COMMENT 'Vendors own material or catalog number for the item being procured. Used for cross-reference and to ensure correct item is supplied, especially critical for chemical procurement (chlorine, coagulants, polymers, fluoride). Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `wbs_element` STRING COMMENT 'WBS element code for Capital Improvement Program (CIP) project assignment. Used to track Capital Expenditure (CAPEX) for infrastructure projects such as treatment plant upgrades, distribution network expansion, or asset renewal. Ref: AWWA.. Valid values are `^[A-Z0-9-.]{8,24}$`',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line item within a purchase order representing a specific material or service being procured. Captures line number, material number, short text, quantity ordered, unit of measure, net price, delivery date, account assignment (cost center, WBS element, asset), goods receipt indicator, invoice receipt indicator, and delivery status. Enables granular tracking of multi-line procurement transactions. Aligns with SAP MM EKPO table.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for the goods receipt record. Ref: AWWA.',
    `facility_id` BIGINT COMMENT 'Reference to the utility facility where the goods were received. May be a Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), warehouse, or field location. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Goods receipts post to GL accounts for inventory valuation and expense recognition in direct-charge scenarios. Required for three-way match accounting and inventory-to-GL reconciliation. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'The employee identifier of the person who received the goods. Links to workforce management systems. Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the item received. Links to chemicals, spare parts, equipment, or other materials. Ref: AWWA.',
    `goods_material_material_master_id` BIGINT COMMENT 'Reference to the material master record for the item received. Links to chemicals, spare parts, equipment, or other materials. Ref: AWWA.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to supply.po_line_item. Business justification: Goods receipts are posted against specific PO line items, not just the header. This is critical for three-way matching (PO line, GR, Invoice) in accounts payable. Currently uses denormalized purchase_. Ref: AWWA.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods or services were received. Links to the originating procurement document. Ref: AWWA.',
    `receiving_personnel_employee_id` BIGINT COMMENT 'The employee identifier of the person who received the goods. Links to workforce management systems. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier who delivered the goods or services. Links to the vendor master record. Ref: AWWA.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Goods receipts post inventory to specific warehouse locations. Currently uses denormalized storage_location_code STRING; should be proper FK to enable location-based inventory tracking and capacity ma. Ref: AWWA.',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to the received material, particularly important for chemicals (chlorine, coagulants, polymers, fluoride) for traceability and quality control. Ref: AWWA.',
    `created_by_user` STRING COMMENT 'The system user ID who created this goods receipt record. Used for audit trail and accountability. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this goods receipt record was first created in the system. Used for audit trail and data lineage. Ref: AWWA.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction amount. Typically USD for US-based water utilities.. Valid values are `^[A-Z]{3}$`',
    `delivery_condition` STRING COMMENT 'The physical condition of the delivered goods at the time of receipt. Good indicates acceptable condition, damaged indicates physical damage, partial indicates incomplete delivery, incorrect indicates wrong items, contaminated indicates quality issues. Ref: AWWA.. Valid values are `good|damaged|partial|incorrect|contaminated`',
    `delivery_note_number` STRING COMMENT 'The delivery note or packing slip number provided by the vendor at the time of delivery. Used for cross-referencing with vendor documentation. Ref: AWWA.',
    `delivery_notes` STRING COMMENT 'Free-text notes or comments recorded by receiving personnel regarding the delivery. May include observations about packaging, condition, discrepancies, or special handling. Ref: AWWA.',
    `gr_document_date` DATE COMMENT 'The date on the goods receipt document, typically the date of physical receipt or delivery note date. Ref: AWWA.',
    `gr_document_number` STRING COMMENT 'The externally-known goods receipt document number generated by the ERP system. Used for tracking and audit purposes. Ref: AWWA.. Valid values are `^[0-9]{10}$`',
    `gr_posting_date` DATE COMMENT 'The date when the goods receipt was posted in the system. This is the principal business event timestamp for inventory valuation and financial accounting. Ref: AWWA.',
    `gr_status` STRING COMMENT 'Current status of the goods receipt transaction in its lifecycle. Posted indicates successful receipt, reversed indicates cancellation, pending inspection indicates awaiting QC, completed indicates fully processed. Ref: AWWA.. Valid values are `posted|reversed|cancelled|pending_inspection|completed`',
    `inspection_lot_number` STRING COMMENT 'The quality inspection lot number created for this goods receipt if quality inspection is required. Links to quality management records. Ref: AWWA.',
    `invoice_verification_date` DATE COMMENT 'The date when the vendor invoice was verified and matched against this goods receipt. Null if invoice not yet received or verified. Ref: AWWA.',
    `last_modified_by_user` STRING COMMENT 'The system user ID who last modified this goods receipt record. Used for audit trail and accountability. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this goods receipt record was last modified. Used for audit trail and change tracking. Ref: AWWA.',
    `material_document_year` STRING COMMENT 'The fiscal year in which the goods receipt material document was created. Used as part of the document key in SAP MM. Ref: AWWA.',
    `movement_type` STRING COMMENT 'SAP movement type code that classifies the type of goods receipt transaction. Common types: 101 (GR for PO), 103 (GR into blocked stock), 105 (GR from release order), 161 (GR for returnable transport packaging), 501 (GR without PO), 511 (GR from delivery without PO). [ENUM-REF-CANDIDATE: 101|103|105|161|501|511|Z01|Z02 — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received material requires quality inspection before it can be released for use. True if inspection is required, False otherwise. Ref: AWWA.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service received and accepted. Measured in the base unit of measure for the material. Ref: AWWA.',
    `receiving_personnel_name` STRING COMMENT 'The name of the warehouse or operations personnel who physically received and verified the goods. Used for accountability and audit purposes. Ref: AWWA.',
    `reversal_date` DATE COMMENT 'The date when this goods receipt was reversed or cancelled. Null if not reversed. Ref: AWWA.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt was cancelled. Used for audit trail and reconciliation. Ref: AWWA.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. True if reversed, False if active. Ref: AWWA.',
    `reversal_reason_code` STRING COMMENT 'The reason code explaining why this goods receipt was reversed. Examples include incorrect quantity, wrong material, damaged goods, vendor return. Ref: AWWA.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types such as consignment stock, returnable packaging, or project stock. Blank for standard stock. Ref: AWWA.',
    `stock_type` STRING COMMENT 'The type of stock into which the material was received. Unrestricted stock is available for use, quality inspection stock is pending QC, blocked stock is not available, restricted stock has limited use. Ref: AWWA.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order, goods receipt, and vendor invoice. Matched indicates all documents agree, variance indicates discrepancies, blocked indicates payment hold. Ref: AWWA.. Valid values are `pending|matched|variance|blocked`',
    `total_amount` DECIMAL(18,2) COMMENT 'The total value of the goods receipt calculated as received quantity multiplied by unit price. Used for financial posting and invoice verification. Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the received quantity. Common units include EA (each), GAL (gallons) for chemicals, LB (pounds), KG (kilograms), L (liters), TON (tons), DRUM, CYL (cylinder). [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|TON|BAG|DRUM|PAIL|CYL|BOX — 13 candidates stripped; promote to reference product]. Ref: AWWA.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for the received material as per the purchase order. Used for inventory valuation and three-way match. Ref: AWWA.',
    `unloading_point` STRING COMMENT 'The specific physical location or dock where the goods were unloaded at the facility. Used for logistics tracking and facility management. Ref: AWWA.',
    `valuation_type` STRING COMMENT 'The valuation type used for split valuation of materials with different prices or qualities. Used when the same material is valued differently based on source or quality. Ref: AWWA.',
    `vendor_batch_number` STRING COMMENT 'The batch or lot number provided by the vendor on the delivery documentation. Used for vendor traceability and quality issues. Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of materials, chemicals, or services at a utility facility (WTP, WWTP, warehouse, field location) against a purchase order. Captures GR document number, posting date, delivery note number, received quantity, storage location, batch/lot number, supplier lot number for chemicals, certificate of analysis reference, quality inspection flag, acceptance status, storage tank or container assigned, delivery vehicle, SDS version, and movement type. Triggers inventory update and three-way match for invoice verification. Supports chemical traceability and regulatory compliance for treatment chemical receipts. Aligns with SAP MM Goods Receipt (MIGO/MSEG).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` (
    `inventory_stock_id` BIGINT COMMENT 'Unique identifier for the inventory stock record. Primary key for the inventory stock data product. Ref: AWWA.',
    `facility_id` BIGINT COMMENT 'Reference to the plant or facility where the storage location resides. Links to WTP, WWTP, or operations center. Ref: AWWA.',
    `inventory_wtp_facility_id` BIGINT COMMENT 'Reference to the plant or facility where the storage location resides. Links to WTP, WWTP, or operations center. Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record. Links to the material being stocked (chemicals, spare parts, equipment, consumables). Ref: AWWA.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the storage location where the material is held. Links to warehouse, chemical storage facility, or field storeroom. Ref: AWWA.',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management prioritization. A = high-value/critical items requiring tight control; B = moderate-value items; C = low-value items with relaxed controls. Ref: AWWA.. Valid values are `A|B|C`',
    `available_quantity` DECIMAL(18,2) COMMENT 'Quantity of material available for new consumption or reservation. Calculated as unrestricted stock minus reserved quantity. Ref: AWWA.',
    `average_daily_consumption` DECIMAL(18,2) COMMENT 'Average quantity consumed per day based on historical usage. Used for demand forecasting and reorder point calculation. Ref: AWWA.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether this material is managed at the batch level. True for chemicals and materials requiring lot tracking for quality, expiration, or regulatory compliance. Ref: AWWA.',
    `blocked_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material blocked from use due to quality issues, expiration, damage, or regulatory hold. Cannot be issued until block is removed. Ref: AWWA.',
    `consignment_stock_flag` BOOLEAN COMMENT 'Indicates whether this stock is held on consignment from a vendor. Consignment stock remains vendor-owned until consumed, reducing carrying costs. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory stock record was first created in the system. Ref: AWWA.',
    `cycle_count_indicator` STRING COMMENT 'Frequency classification for cycle counting. A = high-frequency (monthly); B = medium-frequency (quarterly); C = low-frequency (annual); X = excluded from cycle counting. Ref: AWWA.. Valid values are `A|B|C|X`',
    `days_of_supply` DECIMAL(18,2) COMMENT 'Number of days the current available stock will last based on average daily consumption. Calculated as available quantity divided by average daily consumption. Ref: AWWA.',
    `expiration_controlled_flag` BOOLEAN COMMENT 'Indicates whether the material has a limited shelf life and requires expiration date tracking. True for chemicals, reagents, and time-sensitive consumables. Ref: AWWA.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous and requires special handling, storage, and regulatory compliance (e.g., chlorine gas, sodium hypochlorite, acids). Ref: AWWA.',
    `last_goods_issue_date` DATE COMMENT 'Date of the most recent goods issue transaction that decreased stock for this material at this location. Ref: AWWA.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt transaction that increased stock for this material at this location. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory stock record was last updated. Tracks any change to stock quantities, valuation, or master data attributes. Ref: AWWA.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical inventory count for this material at this storage location. Used to track inventory accuracy and compliance with audit requirements. Ref: AWWA.',
    `last_stock_adjustment_date` DATE COMMENT 'Date of the most recent manual stock adjustment or inventory correction transaction for this material at this location. Ref: AWWA.',
    `lead_time_days` STRING COMMENT 'Planned delivery time in days from purchase requisition creation to goods receipt. Used for reorder point calculation and procurement planning. Ref: AWWA.',
    `material_description` STRING COMMENT 'Short text description of the material for identification and reporting purposes. Ref: AWWA.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum quantity to be maintained in stock. Used for inventory optimization and to prevent overstocking of chemicals with limited shelf life or high carrying costs. Ref: AWWA.',
    `mrp_type` STRING COMMENT 'MRP procedure used for automatic replenishment. PD = MRP; VB = manual reorder point; VM = forecast-based planning; ND = no planning. Ref: AWWA.. Valid values are `PD|VB|VM|ND`',
    `plant_code` STRING COMMENT 'Four-character code identifying the plant or facility (e.g., WTP1, WWTP2, DIST). Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `procurement_type` STRING COMMENT 'Indicates how the material is procured. External = purchased from vendors; In-house = manufactured or produced internally; Both = can be procured either way. Ref: AWWA.. Valid values are `external|in_house|both`',
    `quality_inspection_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently under quality inspection. Stock is on hold pending laboratory testing or quality assurance approval before release to unrestricted use. Ref: AWWA.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Minimum stock level that triggers automatic replenishment. When available quantity falls below this threshold, a purchase requisition is generated. Ref: AWWA.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of unrestricted stock reserved for specific work orders, maintenance activities, or planned consumption. Reserved stock is committed but not yet issued. Ref: AWWA.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer stock maintained to protect against stockouts due to demand variability or supply delays. Critical for chemicals required for continuous treatment operations. Ref: AWWA.',
    `serial_number_managed_flag` BOOLEAN COMMENT 'Indicates whether this material is managed at the serial number level. True for high-value equipment and assets requiring individual unit tracking. Ref: AWWA.',
    `stock_status` STRING COMMENT 'Current status of stock availability. Derived from comparison of available quantity against reorder point and maximum stock level thresholds.. Valid values are `in_stock|low_stock|out_of_stock|overstocked|obsolete`',
    `stock_turnover_ratio` DECIMAL(18,2) COMMENT 'Number of times inventory is consumed and replenished during a period. Indicates inventory efficiency and demand velocity. Ref: AWWA.',
    `stock_type` STRING COMMENT 'Classification of stock ownership and purpose. Distinguishes between utility-owned stock, vendor consignment, project-specific stock, and other special stock categories. Ref: AWWA.. Valid values are `own|consignment|project|subcontracting|returnable_packaging`',
    `stock_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of unrestricted stock at this location. Calculated as unrestricted quantity multiplied by material standard price or moving average price. Ref: AWWA.',
    `storage_location_code` STRING COMMENT 'Four-character alphanumeric code identifying the storage location (e.g., WTP chemical storage, WWTP chemical storage, central warehouse, field storeroom). Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for stock quantities (e.g., EA for each, LB for pounds, GAL for gallons, KG for kilograms, L for liters). Ref: AWWA.. Valid values are `^[A-Z]{2,3}$`',
    `unrestricted_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material available for unrestricted use. This stock is available for consumption, transfer, or issue to work orders and operations. Ref: AWWA.',
    `valuation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for stock valuation (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    CONSTRAINT pk_inventory_stock PRIMARY KEY(`inventory_stock_id`)
) COMMENT 'Current stock levels for all materials and chemicals held across utility warehouses, treatment plant storage, and field storerooms. Captures material number, storage location, plant, unrestricted stock quantity, quality inspection stock, blocked stock, reserved quantity, reorder point, maximum stock level, safety stock level, days of supply remaining, last physical inventory date, book vs counted quantity (for physical inventory reconciliation), chemical-specific attributes (tank ID, expiry date, hazmat classification), and last replenishment date. Supports chemical dosing continuity, maintenance spare parts availability, and physical inventory audit. Aligns with SAP MM stock overview (MARD/MMBE) and physical inventory (IKPF/ISEG).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction. Primary key for the stock movement record. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Ten-character cost center code to which the material movement cost is charged. Used for internal consumption and expense allocation. Ref: AWWA.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Stock movements track transfers between warehouse locations. Currently uses denormalized storage_location_from STRING; should be proper FK. Label prefix from_ distinguishes source location from dest. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Ten-digit general ledger account number to which the material movement value is posted. Determines the financial accounting impact. Ref: AWWA.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Stock movements of type goods receipt should link to the originating goods_receipt record for full traceability. Currently uses denormalized goods_receipt_slip_number STRING; should be proper FK. En. Ref: AWWA.',
    `material_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.material_requisition. Business justification: Stock movements for material issues to work orders should link to the material requisition/reservation that authorized the issue. Currently uses denormalized reservation_number STRING; should be prope. Ref: AWWA.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Stock movements related to procurement should link to the originating purchase order for cost tracking and audit trail. Currently uses denormalized purchase_order_number STRING; should be proper FK. C. Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Reference to the material being moved. Links to the material master record for chemicals, spare parts, or other inventory items. Ref: AWWA.',
    `stock_material_material_master_id` BIGINT COMMENT 'Reference to the material being moved. Links to the material master record for chemicals, spare parts, or other inventory items. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor from whom material was received (for goods receipt movements). Null for internal movements and issues. Ref: AWWA.',
    `amount_in_local_currency` DECIMAL(18,2) COMMENT 'The monetary value of the material movement in the local currency of the plant (typically USD for U.S. water utilities). Calculated as quantity × unit price. Ref: AWWA.',
    `asset_number` STRING COMMENT 'Fixed asset number if this material movement is capitalized as part of an asset acquisition or improvement. Links to asset management for depreciation tracking. Ref: AWWA.. Valid values are `^[0-9]{12}$`',
    `batch_number` STRING COMMENT 'Unique identifier for the batch or lot of material being moved. Critical for chemicals (chlorine, coagulants, polymers) to track expiration, quality, and traceability. Ref: AWWA.. Valid values are `^[A-Z0-9]{1,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each stock movement record in the supply domain.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'External document number from the vendors delivery note or packing slip. Used for goods receipt reconciliation and proof of delivery. Ref: AWWA.. Valid values are `^[A-Z0-9]{1,16}$`',
    `document_date` DATE COMMENT 'The date printed on the external document (e.g., delivery note, packing slip, invoice) that accompanies the material movement. May differ from posting date. Ref: AWWA.',
    `entry_date` DATE COMMENT 'The date on which the material document was created in the system. Audit timestamp for record creation. Ref: AWWA.',
    `entry_time` TIMESTAMP COMMENT 'Timestamp when the material document was created in the system. Provides precise audit trail for transaction timing. Ref: AWWA.',
    `material_document_number` STRING COMMENT 'The externally-known unique document number assigned to this material movement transaction in the ERP system. Serves as the business identifier for traceability and audit. Ref: AWWA.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year in which the material document was posted. Part of the compound key in SAP MM along with material document number. Ref: AWWA.',
    `movement_indicator` STRING COMMENT 'Single-character indicator for special movement scenarios: B=Goods Movement for Purchase Order, H=Reversal Movement, F=Goods Movement for Production Order, E=Goods Movement for Sales Order, L=Goods Movement for Delivery. Ref: AWWA.. Valid values are `B|H|F|E|L`',
    `movement_status` STRING COMMENT 'Current lifecycle status of the material movement transaction: posted=Successfully posted to inventory and accounting, pending=Awaiting approval or verification, cancelled=Reversed or voided, error=Failed posting requiring correction. Ref: AWWA.. Valid values are `posted|pending|cancelled|error`',
    `movement_type` STRING COMMENT 'Three-digit code classifying the type of inventory movement (e.g., 101=Goods Receipt from PO, 261=Goods Issue to Work Order, 311=Transfer Posting, 122=Return to Vendor, 701=Physical Inventory Adjustment). Determines the accounting and inventory impact. Ref: AWWA.. Valid values are `^[0-9]{3}$`',
    `physical_inventory_document_number` STRING COMMENT 'Reference to the physical inventory count document if this movement is an inventory adjustment resulting from a cycle count or annual physical inventory. Ref: AWWA.. Valid values are `^[0-9]{10}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the plant or facility where the material movement occurred (e.g., WTP1=Water Treatment Plant 1, WWTP=Wastewater Treatment Plant). Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the material movement was posted to inventory and financial accounting. Represents the business event date for the transaction. Ref: AWWA.',
    `profit_center` STRING COMMENT 'Ten-character profit center code for internal management accounting and segment reporting. Used to allocate costs and revenues to business units or service areas. Ref: AWWA.. Valid values are `^[A-Z0-9]{10}$`',
    `purchase_order_item` STRING COMMENT 'Line item number within the purchase order that this goods receipt fulfills. Typically a sequential integer (10, 20, 30, etc.). Ref: AWWA.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material moved in this transaction, expressed in the base unit of measure. Positive for receipts, negative for issues. Ref: AWWA.',
    `reason_code` STRING COMMENT 'Code explaining the reason for the material movement (e.g., MAINT=Maintenance Consumption, EMER=Emergency Issue, QUAL=Quality Hold, SCRAP=Scrap/Disposal, RETN=Return to Vendor). Provides additional context beyond movement type. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,4}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this material movement is a reversal (cancellation) of a previous movement. True if this is a reversal transaction. Ref: AWWA.',
    `reversed_document_number` STRING COMMENT 'Material document number of the original transaction that this movement reverses. Populated only when reversal_indicator is true. Ref: AWWA.. Valid values are `^[0-9]{10}$`',
    `special_stock_indicator` STRING COMMENT 'Single-character code for special stock types: E=Sales Order Stock, K=Consignment Stock, O=Project Stock, Q=Quality Inspection Stock, W=Returnable Packaging. Blank for standard unrestricted stock. Ref: AWWA.. Valid values are `E|K|O|Q|W`',
    `storage_location_to` STRING COMMENT 'Four-character code identifying the destination storage location to which material was moved. Null for goods issues to external consumption. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `text_header` STRING COMMENT 'Free-form text field at the document header level providing additional context, notes, or instructions for the entire material movement transaction. Ref: AWWA.',
    `text_item` STRING COMMENT 'Free-form text field at the line item level providing specific notes or details about this particular material movement (e.g., condition observed, special handling instructions). Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is expressed (e.g., EA=Each, GAL=Gallon, LB=Pound, KG=Kilogram, L=Liter). Aligns with ISO unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `unloading_point` STRING COMMENT 'Physical location or dock where material was received or issued. Provides granular location tracking within a plant or warehouse. Ref: AWWA.. Valid values are `^[A-Z0-9]{1,25}$`',
    `user_name` STRING COMMENT 'System user ID of the person who created or posted the material movement transaction. Used for audit trail and accountability. Ref: AWWA.. Valid values are `^[A-Z0-9_]{1,12}$`',
    `valuation_type` STRING COMMENT 'Code used to differentiate materials with the same material number but different valuations (e.g., different procurement sources, quality grades). Enables split valuation for inventory accounting. Ref: AWWA.. Valid values are `^[A-Z0-9]{0,10}$`',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `wbs_element` STRING COMMENT 'Project WBS element code to which the material movement cost is allocated. Used for Capital Improvement Program (CIP) project tracking and CAPEX accounting. Ref: AWWA.. Valid values are `^[A-Z0-9-]{1,24}$`',
    `work_order_number` STRING COMMENT 'Twelve-digit work order number to which material was issued (for goods issue movements). Links the material consumption to maintenance or operations activities. Ref: AWWA.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record of every inventory movement including goods receipts, goods issues to work orders, transfers between storage locations, returns to vendor (movement type 122/161), physical inventory adjustments, and scrap postings. Captures movement type, material, quantity, unit of measure, source and destination storage location, posting date, reference document (work order, PO, reservation), movement reason, return reason code, and vendor reference for returns. Provides full material ledger traceability. Aligns with SAP MM Material Document (MSEG/MKPF).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` (
    `warehouse_location_id` BIGINT COMMENT 'Unique identifier for the warehouse location record. Primary key. Ref: AWWA.',
    `access_hours` STRING COMMENT 'Standard operating hours or access schedule for the warehouse location. May be 24/7, business hours only, or by appointment. Ref: AWWA.',
    `address_line_1` STRING COMMENT 'Primary street address of the warehouse location. Organizational contact data classified as confidential. Ref: AWWA.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building, suite, or unit number. Organizational contact data classified as confidential. Ref: AWWA.',
    `available_capacity_sqft` DECIMAL(18,2) COMMENT 'Currently available storage capacity in square feet. Updated based on inventory levels and space allocation. Ref: AWWA.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for capacity reporting. Supports square feet, square meters, cubic feet, cubic meters, or pallet positions. Ref: AWWA.. Valid values are `sqft|sqm|cubic_ft|cubic_m|pallet_positions`',
    `city` STRING COMMENT 'City where the warehouse location is situated. Organizational contact data classified as confidential. Ref: AWWA.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the warehouse location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse location record was first created in the system. Ref: AWWA.',
    `custodian_contact_email` STRING COMMENT 'Email address for the warehouse custodian. Organizational contact data classified as confidential. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `custodian_contact_phone` STRING COMMENT 'Primary contact phone number for the warehouse custodian. Organizational contact data classified as confidential. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date when the warehouse location was decommissioned or ceased operations. Null for active locations. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when the warehouse location became operational and available for inventory storage. Ref: AWWA.',
    `facility_type` STRING COMMENT 'Classification of the warehouse facility based on its operational purpose. Central warehouse serves enterprise-wide inventory; WTP (Water Treatment Plant) and WWTP (Wastewater Treatment Plant) chemical stores hold treatment chemicals; field storerooms support distribution network maintenance; maintenance depots support asset management; emergency stockpiles hold critical spare parts. Ref: AWWA.. Valid values are `central_warehouse|wtp_chemical_store|wwtp_chemical_store|field_storeroom|maintenance_depot|emergency_stockpile`',
    `fire_suppression_system` STRING COMMENT 'Type of fire suppression system installed at the warehouse location. Critical for chemical storage safety and insurance compliance. Ref: AWWA.. Valid values are `sprinkler|foam|gas|none|dry_chemical`',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the location is certified for storage of hazardous materials such as chlorine, coagulants, polymers, and other treatment chemicals. Required for chemical procurement and FOG (Fats Oils and Grease) management compliance. Ref: AWWA.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the warehouse location and its contents. Business-sensitive financial data. Ref: AWWA.',
    `inventory_cycle_count_frequency` STRING COMMENT 'Standard frequency for physical inventory cycle counts at this location. Supports inventory accuracy and audit compliance. Ref: AWWA.. Valid values are `daily|weekly|monthly|quarterly|annual|on_demand`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection of the warehouse location. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse location record was last updated. Ref: AWWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the warehouse location in decimal degrees. Used for GIS integration and logistics optimization. Ref: AWWA.',
    `location_code` STRING COMMENT 'Business identifier for the warehouse location. Unique alphanumeric code used in SAP MM and operational systems for inventory transactions and storage location assignment. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,12}$`',
    `location_description` STRING COMMENT 'Detailed description of the warehouse location, including purpose, layout, and special characteristics. Ref: AWWA.',
    `location_name` STRING COMMENT 'Human-readable name of the warehouse or storeroom location. Ref: AWWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the warehouse location in decimal degrees. Used for GIS integration and logistics optimization. Ref: AWWA.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next safety or compliance inspection of the warehouse location. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or operational notes about the warehouse location. Ref: AWWA.',
    `operational_status` STRING COMMENT 'Current operational status of the warehouse location. Indicates whether the location is available for inventory storage and transactions. Ref: AWWA.. Valid values are `active|inactive|under_construction|decommissioned|temporarily_closed|restricted_access`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the warehouse location. Organizational contact data classified as confidential. Ref: AWWA.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `responsible_custodian` STRING COMMENT 'Name or identifier of the person or role responsible for managing and securing the warehouse location. Accountable for inventory accuracy and safety compliance. Ref: AWWA.',
    `sap_plant_code` STRING COMMENT 'SAP MM plant code to which this warehouse location is assigned. Links warehouse location to the SAP organizational structure for materials management and procurement. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `sap_storage_location_code` STRING COMMENT 'SAP MM storage location code within the plant. Used for inventory transactions, goods receipts, and goods issues in SAP ERP. Ref: AWWA.. Valid values are `^[A-Z0-9]{4}$`',
    `security_level` STRING COMMENT 'Physical security classification of the warehouse location. Determines access control requirements and monitoring protocols. Ref: AWWA.. Valid values are `public|restricted|controlled|high_security`',
    `spill_containment_available` BOOLEAN COMMENT 'Indicates whether the location has spill containment infrastructure for chemical storage. Required for EPA SPCC (Spill Prevention Control and Countermeasure) compliance. Ref: AWWA.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the warehouse is located. Organizational contact data classified as confidential. Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `storage_conditions` STRING COMMENT 'Environmental and safety classification of the storage location. Indicates whether the location is temperature-controlled, hazmat-rated for chemical storage, or outdoor. Critical for chemical procurement compliance and inventory safety. [ENUM-REF-CANDIDATE: ambient|temperature_controlled|refrigerated|hazmat_rated|outdoor_covered|outdoor_uncovered|climate_controlled — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `temperature_control_available` BOOLEAN COMMENT 'Indicates whether the location has active temperature control systems (HVAC). Required for certain chemical and equipment storage. Ref: AWWA.',
    `temperature_range_max_f` DECIMAL(18,2) COMMENT 'Maximum temperature maintained at the warehouse location in degrees Fahrenheit. Relevant for temperature-controlled storage. Ref: AWWA.',
    `temperature_range_min_f` DECIMAL(18,2) COMMENT 'Minimum temperature maintained at the warehouse location in degrees Fahrenheit. Relevant for temperature-controlled storage. Ref: AWWA.',
    `total_capacity_sqft` DECIMAL(18,2) COMMENT 'Total storage capacity of the warehouse location measured in square feet. Used for space utilization analysis and capacity planning. Ref: AWWA.',
    `ventilation_type` STRING COMMENT 'Type of ventilation system in the warehouse. Important for chemical storage safety and worker health compliance. Ref: AWWA.. Valid values are `natural|mechanical|forced_air|none|exhaust_only`',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    CONSTRAINT pk_warehouse_location PRIMARY KEY(`warehouse_location_id`)
) COMMENT 'Master data for all physical storage locations within the utilitys warehouse and field storeroom network. Captures location code, description, facility type (central warehouse, WTP chemical store, WWTP chemical store, field storeroom), address, storage conditions (temperature-controlled, hazmat-rated, outdoor), capacity, responsible custodian, and SAP MM plant/storage location assignment. Enables inventory segregation and chemical safety compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key. Ref: AWWA.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Contracts reserve multi-year budget allocations for long-term planning. Critical for contract budgeting, ensuring multi-year commitments have appropriated budget authority across fiscal years. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Contracts encumber multi-year fund commitments for long-term budget planning. Critical for governmental accounting, ensuring multi-year contracts reserve appropriate fund balances per GASB standards. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor party with whom this contract is established. Links to the vendor master data. Ref: AWWA.',
    `amendment_count` STRING COMMENT 'The total number of amendments or modifications made to the contract since its original execution. Used to track contract stability and change frequency. Ref: AWWA.',
    `commodity_category` STRING COMMENT 'High-level classification of the goods or services covered by this contract. Chemicals include chlorine, coagulants, polymers, fluoride, and other treatment chemicals. Other categories support infrastructure maintenance, capital projects, and operations. [ENUM-REF-CANDIDATE: chemicals|pipes_fittings|pumps_motors|valves_actuators|meters_instrumentation|electrical_components|laboratory_supplies|vehicles_equipment|professional_services|maintenance_services — 10 candidates stripped; promote to reference product]. Ref: AWWA.',
    `compliance_requirements` STRING COMMENT 'Summary of regulatory, environmental, safety, or quality compliance obligations imposed on the vendor, such as EPA (Environmental Protection Agency) chemical handling standards, OSHA (Occupational Safety and Health Administration) safety requirements, AWWA (American Water Works Association) product certifications, or NSF (National Sanitation Foundation) approval for water treatment chemicals.',
    `contract_approval_date` DATE COMMENT 'The date on which the contract was formally approved by the authorized signatory or approval authority, such as the procurement director, CFO, or board of directors for high-value contracts. Ref: AWWA.',
    `contract_description` STRING COMMENT 'Free-text summary of the contract scope, including the types of goods or services covered, key terms, and any special conditions. Provides context for users reviewing the contract in procurement or financial systems. Ref: AWWA.',
    `contract_document_url` STRING COMMENT 'The file path or URL to the signed contract document stored in the document management system or contract repository. Enables quick access to the full legal agreement for review and audit purposes. Ref: AWWA.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract, typically assigned by the procurement system or legal department. Used for vendor communication and reference in purchase orders. Ref: AWWA.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_owner` STRING COMMENT 'The name or identifier of the procurement professional or contract manager responsible for administering this contract, including renewals, amendments, and vendor performance monitoring. Ref: AWWA.',
    `contract_signed_date` DATE COMMENT 'The date on which both parties executed the contract, making it legally binding. May differ from the effective start date if the contract includes a future commencement provision. Ref: AWWA.',
    `contract_status` STRING COMMENT 'Current state of the contract in its lifecycle. Draft contracts are being prepared, pending approval contracts await authorization, active contracts are in force, suspended contracts are temporarily halted, expired contracts have passed their validity period, terminated contracts were ended early, and closed contracts are completed and archived. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|closed — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `contract_type` STRING COMMENT 'Classification of the procurement contract based on its structure and commitment mechanism. Value contracts specify total monetary value, quantity contracts specify total quantity, framework agreements establish terms without commitment, blanket orders cover recurring purchases, service contracts cover maintenance or professional services, and chemical supply agreements are specialized for treatment chemicals. Ref: AWWA.. Valid values are `value_contract|quantity_contract|framework_agreement|blanket_order|service_contract|chemical_supply_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this contract record was first created in the procurement system. Used for audit trail and data lineage tracking. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value and pricing terms. Typically USD for domestic US water utilities, but may vary for international suppliers or multi-currency organizations.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'The default delivery destination for goods or services under this contract, typically a Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), warehouse, or central receiving facility. May reference a facility code or address. Ref: AWWA.',
    `delivery_terms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities for shipping, insurance, and risk transfer. FOB (Free On Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid), EXW (Ex Works), and FCA (Free Carrier) are common in chemical and materials procurement. Ref: AWWA.. Valid values are `FOB|CIF|DDP|EXW|FCA`',
    `effective_end_date` DATE COMMENT 'The date on which the contract expires and no further releases or purchases can be made unless renewed. Nullable for open-ended contracts or contracts with automatic renewal clauses. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'The date from which the contract terms become binding and procurement can begin releasing orders against this contract. Aligns with contract execution date or a future commencement date specified in the agreement. Ref: AWWA.',
    `insurance_requirements` STRING COMMENT 'Description of the insurance coverage the vendor must maintain, including general liability, product liability, workers compensation, and environmental liability. Specifies minimum coverage amounts and certificate of insurance requirements. Ref: AWWA.',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment or modification to the contract terms, such as price adjustments, scope changes, or term extensions. Nullable if no amendments have been made. Ref: AWWA.',
    `minority_business_enterprise` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a Minority Business Enterprise, supporting diversity and inclusion goals in procurement. Used for compliance reporting and supplier diversity tracking. Ref: AWWA.',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this contract record. Used for audit trail and accountability. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this contract record was last updated in the procurement system. Used for audit trail and change tracking. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or internal notes about the contract that do not fit in other structured fields. May include historical context, negotiation outcomes, or operational considerations. Ref: AWWA.',
    `payment_method` STRING COMMENT 'The instrument or mechanism by which payments will be made to the vendor under this contract. ACH (Automated Clearing House) and wire transfers are common for large chemical suppliers, checks for smaller vendors, and procurement cards for low-value recurring purchases. Ref: AWWA.. Valid values are `ach|wire_transfer|check|credit_card|procurement_card`',
    `payment_terms` STRING COMMENT 'Standard payment terms code defining the due date calculation and discount conditions. Examples include NET30 (net 30 days), 2/10NET30 (2% discount if paid within 10 days, otherwise net 30), or custom terms negotiated with the vendor. Ref: AWWA.. Valid values are `^[A-Z0-9]{1,10}$`',
    `performance_clause` STRING COMMENT 'Description of performance standards, service level agreements (SLAs), quality requirements, and penalties or incentives tied to vendor performance. May include delivery time commitments, product quality specifications, and response time requirements for emergency chemical deliveries. Ref: AWWA.',
    `price_escalation_clause` STRING COMMENT 'Details of any provisions allowing the vendor to adjust prices during the contract term, including triggers (e.g., CPI increases, raw material cost changes), frequency of adjustments, and caps on increases. Critical for budget forecasting and OPEX management. Ref: AWWA.',
    `pricing_condition` STRING COMMENT 'The pricing structure defined in the contract. Fixed price remains constant, variable price adjusts based on market conditions or volume, cost-plus adds a markup to vendor costs, index-linked ties pricing to a commodity index, and tiered pricing offers volume discounts. Ref: AWWA.. Valid values are `fixed_price|variable_price|cost_plus|index_linked|tiered_pricing`',
    `purchasing_group` STRING COMMENT 'The buyer group or team within the purchasing organization responsible for this contract. Typically organized by commodity category (e.g., chemicals, equipment, services). Ref: AWWA.. Valid values are `^[A-Z0-9]{3,10}$`',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for negotiating and managing this contract. In multi-site utilities, different purchasing organizations may handle different regions or commodity categories. Ref: AWWA.. Valid values are `^[A-Z0-9]{4,10}$`',
    `remaining_contract_value` DECIMAL(18,2) COMMENT 'The remaining monetary value available for future releases under this contract, calculated as total contract value minus total released value. Used for budget planning and procurement decision-making. Ref: AWWA.',
    `renewal_terms` STRING COMMENT 'Free-text description of the renewal provisions, including automatic renewal clauses, notice periods for non-renewal, and conditions for extension. Critical for ensuring continuity of chemical supply and avoiding service interruptions. Ref: AWWA.',
    `small_business_enterprise` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a Small Business Enterprise, supporting local economic development and small business participation goals. Used for compliance reporting and procurement policy adherence. Ref: AWWA.',
    `termination_clause` STRING COMMENT 'Summary of the conditions under which either party may terminate the contract early, including notice periods, penalties, and force majeure provisions. Important for risk management and vendor relationship governance. Ref: AWWA.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The maximum monetary value committed under this contract for value contracts, or the estimated total spend for quantity and framework agreements. Used for budget tracking and OPEX (Operating Expenditure) or CAPEX (Capital Expenditure) allocation. Currency is USD unless otherwise specified in contract terms. Ref: AWWA.',
    `total_released_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods or services released against this contract to date, measured in the contracts unit of measure. Used to track contract utilization for quantity contracts. Ref: AWWA.',
    `total_released_value` DECIMAL(18,2) COMMENT 'The cumulative monetary value of all purchase orders or releases issued against this contract to date. Used to track contract utilization and remaining available value for value contracts. Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `created_by` STRING COMMENT 'The username or identifier of the system user who created this contract record. Used for audit trail and accountability. Ref: AWWA.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Long-term supply agreements and blanket purchase orders negotiated with vendors for recurring procurement of chemicals, materials, and services. Captures contract number, vendor, contract type (value contract, quantity contract, framework agreement), validity period, total contract value, pricing conditions, payment terms, renewal terms, performance clauses, and associated commodity categories. Supports chemical supply continuity and OPEX/CAPEX budget management. Aligns with SAP MM Outline Agreement (EKKO with doc type MK/WK).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key. Ref: Oracle CC&B.',
    `goods_receipt_id` BIGINT COMMENT 'Identifier of the goods receipt document confirming delivery of materials or services, used in three-way match validation. Ref: Oracle CC&B.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to supply.po_line_item. Business justification: Vendor invoices are matched at line-item level for three-way matching (PO line, GR, Invoice). Currently vendor_invoice only links to purchase_order header; adding line-item FK enables precise matching. Ref: Oracle CC&B.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order against which this invoice is matched in the three-way match workflow (PO, GR, invoice). Ref: Oracle CC&B.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who submitted this invoice. Links to the vendor master record. Ref: Oracle CC&B.',
    `approved_by` STRING COMMENT 'User ID of the manager or authorized approver who approved the invoice for payment. Used for segregation of duties and audit compliance. Ref: Oracle CC&B.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time the invoice was approved for payment. Used for approval workflow tracking and compliance reporting. Ref: Oracle CC&B.',
    `baseline_date` DATE COMMENT 'Reference date from which payment terms are calculated. Typically the invoice date or goods receipt date depending on payment term configuration. Ref: Oracle CC&B.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity or utility district that is the invoice recipient and payer. Ref: Oracle CC&B.',
    `cost_center` STRING COMMENT 'Cost center to which the invoice amount is charged for internal cost accounting and budget tracking. Ref: Oracle CC&B.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the invoice record was first created in the system. Used for audit trail and processing time analysis. Ref: Oracle CC&B.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Cash discount amount available if payment is made within the discount period per payment terms. Ref: Oracle CC&B.',
    `document_date` DATE COMMENT 'Date the invoice document was received or entered into the system. Used for document control and audit trail. Ref: Oracle CC&B.',
    `exception_code` STRING COMMENT 'Code identifying the type of exception or discrepancy detected during three-way match (e.g., price variance, quantity variance, no PO match, no GR match). Ref: Oracle CC&B.',
    `exception_description` STRING COMMENT 'Detailed description of the invoice exception or discrepancy requiring resolution before payment can be released. Ref: Oracle CC&B.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year in which the invoice was posted. Used for monthly financial reporting. Ref: Oracle CC&B.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the invoice was posted. Used for financial reporting and period closing. Ref: Oracle CC&B.',
    `general_ledger_account` STRING COMMENT 'General ledger account number to which the invoice is posted in the chart of accounts. Determines financial statement classification. Ref: Oracle CC&B.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before tax. Sum of all line item amounts for goods and services. Ref: Oracle CC&B.',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice. Used for aging analysis and payment term calculation. Ref: Oracle CC&B.',
    `invoice_number` STRING COMMENT 'Vendor-assigned invoice number as printed on the invoice document. Business identifier for external reference. Ref: Oracle CC&B.',
    `invoice_receipt_date` DATE COMMENT 'Date the physical or electronic invoice was received by the accounts payable department. Used for processing time metrics. Ref: Oracle CC&B.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. [ENUM-REF-CANDIDATE: draft|posted|blocked|approved|paid|cancelled|disputed — 7 candidates stripped; promote to reference product]. Ref: Oracle CC&B.',
    `modified_by` STRING COMMENT 'User ID of the last person who modified the invoice record. Used for change tracking and accountability. Ref: Oracle CC&B.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time the invoice record was last modified. Used for audit trail and version control. Ref: Oracle CC&B.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total invoice amount including tax. Gross amount plus tax amount. The amount payable to the vendor. Ref: Oracle CC&B.',
    `payment_block_code` STRING COMMENT 'Code indicating if payment is blocked and the reason (e.g., price variance, quantity variance, quality issue, missing documentation). Blank if no block. Ref: Oracle CC&B.',
    `payment_block_reason` STRING COMMENT 'Detailed explanation of why the invoice payment is blocked. Used for exception management and resolution tracking. Ref: Oracle CC&B.',
    `payment_cleared_date` DATE COMMENT 'Date the invoice was fully paid and cleared from open items. Used for cash flow analysis and vendor payment performance. Ref: Oracle CC&B.',
    `payment_document_number` STRING COMMENT 'Document number of the payment transaction that cleared this invoice. Used to link invoice to payment for reconciliation. Ref: Oracle CC&B.',
    `payment_due_date` DATE COMMENT 'Date by which payment must be made to the vendor per the agreed payment terms. Used for cash flow planning and avoiding late payment penalties. Ref: Oracle CC&B.',
    `payment_method_code` STRING COMMENT 'Code indicating the method by which payment will be made (e.g., check, wire transfer, ACH, credit card). Ref: Oracle CC&B.',
    `payment_run_date` DATE COMMENT 'Date the invoice was included in an automatic payment run. Null if not yet paid or paid manually. Ref: Oracle CC&B.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the vendor (e.g., Net 30, 2/10 Net 30). Defines due date and discount conditions. Ref: Oracle CC&B.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the water treatment plant (WTP) or wastewater treatment plant (WWTP) or facility receiving the goods or services. Ref: Oracle CC&B.',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the financial ledger in SAP FI. Determines the fiscal period for accounting purposes. Ref: Oracle CC&B.',
    `reference_document_number` STRING COMMENT 'Reference to related documents such as contract number, service entry sheet, or delivery note. Used for audit trail and document linkage. Ref: Oracle CC&B.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice. Includes sales tax, VAT, or other applicable taxes. Ref: Oracle CC&B.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction applicable to this invoice (state, county, city). Used for tax compliance and reporting. Ref: Oracle CC&B.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: Oracle CC&B.',
    `wbs_element` STRING COMMENT 'WBS element code if the invoice is charged to a capital improvement program (CIP) project. Used for CAPEX tracking. Ref: Oracle CC&B.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the invoice payment per tax regulations. Remitted directly to tax authority. Ref: Oracle CC&B.',
    `created_by` STRING COMMENT 'User ID of the accounts payable clerk or system user who created the invoice record in the system. Ref: Oracle CC&B.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor-submitted invoice for goods delivered or services rendered, processed through the three-way match (PO, GR, invoice) workflow. Captures invoice number, vendor, invoice date, posting date, gross amount, tax amount, currency, payment due date, payment block status, matched PO and GR references, and exception reason codes. Feeds accounts payable in SAP FI. Aligns with SAP MM Invoice Verification (RBKP/RSEG — Logistics Invoice Verification).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique identifier for the vendor performance evaluation record. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the procurement or supply chain professional who conducted the vendor performance evaluation. Ref: AWWA.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the master contract or blanket purchase agreement under which the vendor was evaluated. Links to contract management system. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor being evaluated. Links to the vendor master record in SAP MM. Ref: AWWA.',
    `approved_by_name` STRING COMMENT 'Name of the manager or procurement director who approved the vendor performance evaluation. Ref: AWWA.',
    `approved_date` DATE COMMENT 'Date when the vendor performance evaluation was formally approved by management. Ref: AWWA.',
    `coa_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of chemical deliveries accompanied by valid Certificate of Analysis (COA) documentation meeting regulatory and quality standards. Essential for water treatment chemicals to ensure Safe Drinking Water Act (SDWA) compliance. Ref: AWWA.',
    `commodity_category` STRING COMMENT 'Category of goods or services procured from the vendor during the evaluation period (e.g., chemicals for water treatment such as chlorine, coagulants, polymers, fluoride; equipment; spare parts; construction services). Ref: AWWA.. Valid values are `chemicals|equipment|services|materials|spare_parts|construction`',
    `corrective_action_description` STRING COMMENT 'Detailed description of corrective actions required from the vendor to address performance deficiencies identified during the evaluation period. Ref: AWWA.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether vendor performance deficiencies require formal corrective action plan. True if corrective action is required, False otherwise. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance evaluation record was first created in the system. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total order value (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `evaluation_date` DATE COMMENT 'Date when the vendor performance evaluation was conducted and finalized. Ref: AWWA.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluator providing additional context, observations, or qualitative feedback about vendor performance during the evaluation period. Ref: AWWA.',
    `evaluation_number` STRING COMMENT 'Business identifier for the vendor performance evaluation, typically generated by SAP MM or procurement system. Ref: AWWA.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the period covered by this vendor performance evaluation. Ref: AWWA.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the period covered by this vendor performance evaluation. Ref: AWWA.',
    `evaluation_status` STRING COMMENT 'Current workflow status of the vendor performance evaluation record (e.g., draft, submitted for approval, approved, rejected, closed). Ref: AWWA.. Valid values are `draft|submitted|approved|rejected|closed`',
    `evaluator_name` STRING COMMENT 'Name of the procurement or supply chain professional who conducted the vendor performance evaluation. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance evaluation record was last updated or modified. Ref: AWWA.',
    `on_time_delivery_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the scheduled delivery date during the evaluation period. Key Performance Indicator (KPI) for vendor reliability. Ref: AWWA.',
    `order_fill_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of purchase order line items delivered in full (complete quantity) during the evaluation period. Measures vendor ability to fulfill orders completely. Ref: AWWA.',
    `overall_performance_rating` STRING COMMENT 'Composite rating summarizing vendor performance across all Key Performance Indicators (KPIs) during the evaluation period. Used for vendor qualification decisions and contract renewals. Ref: AWWA.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `overall_performance_score` DECIMAL(18,2) COMMENT 'Numeric composite score (typically 0-100 scale) calculated from weighted individual Key Performance Indicator (KPI) scores. Supports quantitative vendor comparison and ranking.',
    `pricing_accuracy_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of invoices that matched contracted pricing without discrepancies during the evaluation period. Measures vendor adherence to contract terms and billing accuracy. Ref: AWWA.',
    `quality_conformance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of delivered goods or services that met quality specifications and acceptance criteria during the evaluation period. Critical for chemical procurement (chlorine, coagulants, polymers, fluoride) where quality directly impacts water treatment efficacy. Ref: AWWA.',
    `recommendation` STRING COMMENT 'Evaluator recommendation for future business relationship with the vendor based on performance evaluation results (e.g., continue current relationship, renew contract, renegotiate terms, place on probation, discontinue). Ref: AWWA.. Valid values are `continue|renew_contract|renegotiate_terms|probation|discontinue`',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Qualitative score (typically 1-5 or 1-10 scale) rating vendor responsiveness to inquiries, issue resolution, and communication timeliness during the evaluation period. Ref: AWWA.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of all purchase orders from the vendor during the evaluation period. Provides spend context for vendor importance and risk assessment. Ref: AWWA.',
    `total_orders_evaluated` STRING COMMENT 'Total number of purchase orders from the vendor included in this performance evaluation period. Provides context for the statistical significance of Key Performance Indicator (KPI) scores. Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic evaluation records of vendor performance against contractual and operational KPIs including on-time delivery rate, order fill rate, chemical quality conformance, certificate of analysis compliance, pricing accuracy, and responsiveness. Captures evaluation period, vendor, commodity category, individual KPI scores, overall performance rating, corrective action flags, and evaluator. Supports vendor qualification decisions and contract renewals. Aligns with SAP MM Vendor Evaluation (ME61/ME6B).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` (
    `material_requisition_id` BIGINT COMMENT 'Unique identifier for the material requisition record. Primary key. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Reference to the Capital Improvement Program (CIP) project if the requisition supports capital work. Null for Operations and Maintenance (O&M) activities. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Cost center to which the material consumption will be charged. Used for financial tracking and budget allocation. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Material issues may charge specific funds to distinguish capital vs operating expenses. Relevant for CIP work orders where materials charge capital project funds per GASB requirements. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'General ledger account to which the material cost is posted. Used for financial accounting and expense tracking. Ref: AWWA.',
    `registry_id` BIGINT COMMENT 'Reference to the asset or equipment for which the material is being requisitioned. Links to asset registry for maintenance context. Ref: AWWA.',
    `material_registry_id` BIGINT COMMENT 'Reference to the asset or equipment for which the material is being requisitioned. Links to asset registry for maintenance context. Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record being requisitioned. Links to inventory item, spare part, or chemical. Ref: AWWA.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order for which materials are being requisitioned. Links maintenance demand to supply fulfillment. Ref: AWWA.',
    `batch_number` STRING COMMENT 'Batch or lot number of the material being requisitioned. Critical for chemicals and materials requiring traceability for quality and regulatory compliance. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the material requisition record was first created in the system. Audit trail for record creation. Ref: AWWA.',
    `deleted_flag` BOOLEAN COMMENT 'Indicates whether the reservation has been marked for deletion. Deleted reservations are retained for audit purposes but excluded from active processing. Ref: AWWA.',
    `final_issue_flag` BOOLEAN COMMENT 'Indicates whether the reservation is marked for final issue. When true, no further material withdrawals are expected and the reservation can be closed. Ref: AWWA.',
    `issue_date` DATE COMMENT 'Date when the material was physically issued from the warehouse. Null if not yet issued. Ref: AWWA.',
    `issued_by` STRING COMMENT 'Name or identifier of the warehouse personnel who fulfilled the requisition and issued the material. Null if not yet issued. Ref: AWWA.',
    `issued_quantity` DECIMAL(18,2) COMMENT 'Quantity of material actually issued from warehouse to fulfill this requisition. May differ from requested quantity due to stock availability or adjustments. Ref: AWWA.',
    `material_description` STRING COMMENT 'Short text description of the material being requisitioned. Provides human-readable context for the item. Ref: AWWA.',
    `material_document_number` STRING COMMENT 'Material document number generated upon goods issue. Links the requisition to the actual inventory transaction in SAP MM. Ref: AWWA.',
    `material_document_year` STRING COMMENT 'Fiscal year of the material document. Used in combination with material document number for unique identification. Ref: AWWA.',
    `material_number` STRING COMMENT 'Business identifier for the material in the source system. Stock keeping unit or material code. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the material requisition record was last modified. Audit trail for record updates. Ref: AWWA.',
    `movement_type` STRING COMMENT 'SAP movement type code that defines the nature of the material transaction: goods issue, return, scrap, etc. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the material requisition. May include special handling instructions, substitution approvals, or issue explanations. Ref: AWWA.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be issued. Calculated as requested quantity minus issued quantity. Ref: AWWA.',
    `plant_code` STRING COMMENT 'Plant or facility code where the material will be consumed. Aligns with Water Treatment Plant (WTP) or Wastewater Treatment Plant (WWTP) organizational structure. Ref: AWWA.',
    `priority` STRING COMMENT 'Urgency level of the material requisition. Emergency requisitions support critical failures; high priority supports urgent maintenance; normal and low support planned work. Ref: AWWA.. Valid values are `emergency|high|normal|low`',
    `requested_by` STRING COMMENT 'Name or identifier of the person who created the material requisition. Typically a maintenance planner, operator, or project manager. Ref: AWWA.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of material requested for reservation. Original demand quantity before any adjustments or partial issues. Ref: AWWA.',
    `requesting_department` STRING COMMENT 'Department or organizational unit that initiated the material requisition. Typically the maintenance, operations, or project team. Ref: AWWA.',
    `required_date` DATE COMMENT 'Date by which the material is needed to support the work order or operation. Drives warehouse picking and fulfillment priority. Ref: AWWA.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the material requisition: open (not yet fulfilled), partially issued (some materials released), fully issued (complete), cancelled, or closed. Ref: AWWA.. Valid values are `open|partially_issued|fully_issued|cancelled|closed`',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on its purpose: maintenance work, treatment operations, capital improvement program, emergency response, or planned activity. Ref: AWWA.. Valid values are `maintenance|operations|capital_project|emergency|planned`',
    `reservation_date` DATE COMMENT 'Date when the material reservation was created in the system. Represents the business event timestamp for demand registration. Ref: AWWA.',
    `reservation_item_number` STRING COMMENT 'Line item number within the reservation document. Identifies individual material line within a multi-line reservation. Ref: AWWA.',
    `reservation_number` STRING COMMENT 'Business identifier for the material reservation in the source system. Externally-known unique code for tracking and reference. Ref: AWWA.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types such as consignment, project stock, or vendor-managed inventory. Blank for standard warehouse stock. Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'Unit in which the material quantity is expressed: gallons, pounds, each, feet, etc. Aligns with material master base unit. Ref: AWWA.',
    `valuation_type` STRING COMMENT 'Material valuation category used for inventory accounting. Distinguishes between different stock types or procurement sources. Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `warehouse_location` STRING COMMENT 'Warehouse or storage location from which the material will be issued. Identifies the physical inventory source. Ref: AWWA.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element for Capital Improvement Program (CIP) projects. Enables project cost tracking and reporting. Ref: AWWA.',
    CONSTRAINT pk_material_requisition PRIMARY KEY(`material_requisition_id`)
) COMMENT 'Reservation or issue request for materials from warehouse stock to support a specific work order, maintenance activity, or treatment operation. Captures reservation number, requesting department, work order or project reference, material, required quantity, required date, issue status, issuing warehouse location, and issued quantity. Bridges the asset/maintenance domain demand with supply domain fulfillment. Aligns with SAP MM Reservation (RESB/RKPF).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the request for quotation record. Primary key. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor selected and awarded the contract resulting from this RFQ. Populated when rfq_status = awarded. Links to supply.vendor. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: RFQs for project-specific equipment, materials, or services must track the driving CIP project for sourcing decisions, budget validation, and procurement documentation. Water utilities issue project-s. Ref: AWWA.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: RFQs validate budget before solicitation for procurement planning. Budget control ensuring competitive solicitations only proceed when budget exists, preventing unauthorized commitments. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: RFQs verify fund availability before solicitation to ensure budget exists. Procurement control preventing solicitations for purchases without appropriated funds in governmental accounting. Ref: AWWA.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record if this RFQ is for a specific cataloged material or spare part. Links to supply.material_master for materials procurement. Ref: AWWA.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_category. Business justification: RFQs are classified by procurement category for routing to appropriate buyers and compliance with category-specific sourcing rules. Currently uses denormalized procurement_category STRING; should be p. Ref: AWWA.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_requisition. Business justification: RFQs are often created FROM purchase requisitions to source materials or services. Currently uses denormalized requisition_number STRING; should be proper FK to trace sourcing back to business need. C. Ref: AWWA.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'Total contract value or purchase order amount awarded to the selected vendor. Confidential business data. Ref: AWWA.',
    `awarded_date` DATE COMMENT 'Date the RFQ was awarded to the selected vendor and purchase order was issued or contract was executed. Ref: AWWA.',
    `bonding_required_flag` BOOLEAN COMMENT 'Indicates whether vendors must provide bid bonds, performance bonds, or payment bonds. Common for construction and large equipment procurements. True if bonding is required. Ref: AWWA.',
    `buyer_email` STRING COMMENT 'Email address of the buyer for vendor inquiries and communication. Confidential organizational contact information. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `buyer_name` STRING COMMENT 'Name of the procurement specialist or buyer responsible for managing this RFQ process, vendor communication, and quote evaluation. Ref: AWWA.',
    `buyer_phone` STRING COMMENT 'Phone number of the buyer for vendor inquiries. Confidential organizational contact information. Ref: AWWA.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the RFQ was cancelled if rfq_status = cancelled. Examples: Insufficient vendor response, Budget unavailable, Requirements changed, Procurement method changed. Ref: AWWA.',
    `closing_date` DATE COMMENT 'Deadline date by which vendors must submit their quotations. After this date, the RFQ is typically closed to new submissions. Ref: AWWA.',
    `closing_time` TIMESTAMP COMMENT 'Precise timestamp (date and time) when the RFQ closes for quote submissions. Used when exact time matters for competitive bidding. Ref: AWWA.',
    `competitive_bidding_flag` BOOLEAN COMMENT 'Indicates whether this RFQ is part of a formal competitive bidding process requiring multiple vendor quotes. True if competitive bidding is required, False if sole-source or limited competition. Ref: AWWA.',
    `cost_center` STRING COMMENT 'Cost center or department code responsible for this procurement. Used for budget tracking and financial reporting. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ record was first created in the system. Audit trail for record creation. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the RFQ and expected quotations (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Physical location or facility where materials or equipment should be delivered, or where services should be performed (e.g., Main WTP, North WWTP, Central Warehouse). Ref: AWWA.',
    `delivery_required_date` DATE COMMENT 'Target date by which the materials or services must be delivered or completed. Critical for operational planning and vendor evaluation. Ref: AWWA.',
    `rfq_description` STRING COMMENT 'Detailed description of the materials, services, or scope of work being solicited. May include technical specifications, performance requirements, and background context. Ref: AWWA.',
    `diversity_preference_flag` BOOLEAN COMMENT 'Indicates whether this RFQ includes preference or set-aside provisions for minority-owned, woman-owned, or small business vendors. True if diversity preferences apply. Ref: AWWA.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Internal estimated budget or cost target for this procurement. Typically not disclosed to vendors but used for internal approval and evaluation. Confidential business data. Ref: AWWA.',
    `evaluation_criteria` STRING COMMENT 'Criteria and weighting factors used to evaluate and compare vendor quotations (e.g., Price 50%, Delivery Time 20%, Quality 20%, Vendor Experience 10%). Ensures transparent and objective vendor selection. Ref: AWWA.',
    `general_ledger_account` STRING COMMENT 'General ledger account code to which the procurement cost will be charged. Used for financial accounting and expense classification (OPEX vs CAPEX). Ref: AWWA.',
    `incoterms` STRING COMMENT 'Standard trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and seller (e.g., FOB, CIF, DDP). Applicable for equipment and chemical procurement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]. Ref: AWWA.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether vendors must provide proof of insurance (general liability, workers compensation, professional liability) to be eligible for award. True if insurance is required. Ref: AWWA.',
    `invited_vendor_count` STRING COMMENT 'Total number of vendors invited to submit quotations for this RFQ. Used to track solicitation breadth and competitive participation. Ref: AWWA.',
    `issue_date` DATE COMMENT 'Date the RFQ was officially issued and distributed to invited vendors. Marks the start of the quotation period. Ref: AWWA.',
    `minimum_vendors_required` STRING COMMENT 'Minimum number of vendor quotations required to satisfy competitive procurement policies. Typically 3 for formal competitive bids. Ref: AWWA.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this RFQ record. Audit trail for accountability. Ref: AWWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ record was last modified. Audit trail for record updates. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-form notes and comments about the RFQ process, vendor interactions, evaluation decisions, or special circumstances. Used for audit trail and knowledge capture. Ref: AWWA.',
    `payment_terms` STRING COMMENT 'Standard payment terms offered to vendors (e.g., Net 30, Net 60, 2/10 Net 30). Defines when payment is due after invoice receipt. Ref: AWWA.',
    `pre_bid_attendance_mandatory_flag` BOOLEAN COMMENT 'Indicates whether vendor attendance at the pre-bid meeting is mandatory to submit a valid quotation. True if mandatory, False if optional. Ref: AWWA.',
    `pre_bid_meeting_date` DATE COMMENT 'Date of optional pre-bid or pre-proposal meeting where vendors can ask questions and clarify requirements before submitting quotes. Common for complex procurements. Ref: AWWA.',
    `pre_bid_meeting_location` STRING COMMENT 'Physical or virtual location of the pre-bid meeting (e.g., Main Office Conference Room, Microsoft Teams Virtual Meeting). Ref: AWWA.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Total quantity of materials or units of service being solicited in this RFQ. Used for vendor pricing and capacity evaluation. Ref: AWWA.',
    `quotes_received_count` STRING COMMENT 'Number of vendor quotations actually received in response to this RFQ. Used to assess vendor interest and competitive response rate. Ref: AWWA.',
    `response_due_date` DATE COMMENT 'Expected date by which vendors should respond with their quotations. May differ from closing_date if there is a grace period or clarification window. Ref: AWWA.',
    `rfq_number` STRING COMMENT 'Business identifier for the RFQ document, externally visible and used for vendor communication and tracking. Typically system-generated sequential or pattern-based number. Ref: AWWA.. Valid values are `^[A-Z0-9]{10,20}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ: draft (being prepared), issued (sent to vendors), open (accepting quotes), closed (quote period ended), cancelled (RFQ withdrawn), awarded (vendor selected and purchase order issued). Ref: AWWA.. Valid values are `draft|issued|open|closed|cancelled|awarded`',
    `rfq_type` STRING COMMENT 'Classification of the RFQ by procurement category: materials (spare parts, consumables), services (maintenance, consulting), equipment (capital assets), chemicals (treatment chemicals), construction (infrastructure projects), or professional services (engineering, legal). Ref: AWWA.. Valid values are `materials|services|equipment|chemicals|construction|professional_services`',
    `technical_contact_email` STRING COMMENT 'Email address of the technical contact for vendor technical inquiries. Confidential organizational contact information. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_contact_name` STRING COMMENT 'Name of the technical subject matter expert (e.g., plant operator, engineer) who can answer technical questions about specifications and requirements. Ref: AWWA.',
    `title` STRING COMMENT 'Short descriptive title or subject line for the RFQ, summarizing the procurement need (e.g., Chlorine Gas Supply Q2 2024, SCADA Upgrade Services). Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is expressed (e.g., EA for each, LB for pounds, GAL for gallons, TON for tons, HR for hours of service). Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this RFQ record. Audit trail for accountability. Ref: AWWA.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation issued to one or more vendors to solicit competitive pricing for materials or services, and the vendor responses received. Captures RFQ number, issue date, closing date, commodity description, quantity, delivery requirements, evaluation criteria, invited vendors, vendor-submitted pricing, delivery lead times, payment terms, technical compliance notes, bid comparison scores, and award decision. Supports the full solicitation-to-award lifecycle for chemicals, equipment, and construction services. Aligns with SAP MM RFQ/Quotation (EKKO doc type AN / ME41-ME49).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Unique identifier for the approved vendor list entry. Primary key for this registry of pre-qualified vendors authorized to supply specific materials or service categories. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who granted final approval for this vendor qualification. Links to the HR employee master for audit and accountability. Ref: AWWA.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_category. Business justification: Vendor approvals are category-specific (e.g., approved for chemicals, not for construction services). Currently uses denormalized material_category_code STRING; should be proper FK to procurement_cate. Ref: AWWA.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Vendor approvals can be tied to specific contracts (e.g., pre-qualified under a master service agreement). Currently uses denormalized contract_number STRING; should be proper FK to enable contract-ba. Ref: AWWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor entity that has been pre-qualified and approved for specific procurement categories. Links to the vendor master record in SAP MM. Ref: AWWA.',
    `approval_justification` STRING COMMENT 'Business rationale and supporting documentation summary for why this vendor was approved for the specified category. May reference evaluation scores, past performance, unique capabilities, or sole-source justifications. Ref: AWWA.',
    `approval_number` STRING COMMENT 'Unique business identifier assigned to this vendor approval record for tracking and audit purposes. Used in procurement compliance reporting. Ref: AWWA.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the vendor approval. Approved vendors may be used in procurement; suspended or revoked vendors are blocked from new purchase orders until reinstated. Ref: AWWA.. Valid values are `approved|pending|suspended|expired|revoked|under_review`',
    `approval_type` STRING COMMENT 'Classification of the approval level. Preferred vendors receive priority consideration; emergency vendors are pre-approved for urgent procurements; conditional approvals have restrictions; trial approvals are temporary for evaluation. Ref: AWWA.. Valid values are `standard|preferred|emergency|conditional|trial`',
    `approved_spend_limit_amount` DECIMAL(18,2) COMMENT 'The maximum cumulative purchase amount authorized for this vendor in the approved category without requiring additional approval authority. Null indicates no limit. Used to enforce procurement controls and delegation of authority. Ref: AWWA.',
    `approved_spend_limit_currency_code` STRING COMMENT 'The currency in which the approved spend limit is denominated, using ISO 4217 three-letter currency codes (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `approved_spend_limit_period` STRING COMMENT 'The time period over which the approved spend limit applies. Per-transaction limits apply to individual purchase orders; annual limits reset each fiscal year; contract lifetime limits apply to the duration of the approval. Ref: AWWA.. Valid values are `per_transaction|annual|contract_lifetime|unlimited`',
    `awwa_standards_compliance_flag` BOOLEAN COMMENT 'Indicates whether the vendor supplies materials or services that comply with AWWA standards for water treatment chemicals, pipes, valves, and equipment. Critical for ensuring product quality and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this approved vendor list record was first created in the system. Used for audit trail and data lineage tracking. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'The date from which this vendor approval becomes active and the vendor may be used for procurement in the approved category. May differ from qualification date due to administrative processing. Ref: AWWA.',
    `environmental_qualification_met_flag` BOOLEAN COMMENT 'Indicates whether the vendor has met environmental compliance criteria including EPA permits, waste disposal certifications, and environmental management system standards (ISO 14001). Required for chemical suppliers and waste management vendors.',
    `expiration_date` DATE COMMENT 'The date on which this vendor approval expires and must be renewed. Ensures periodic re-evaluation of vendor qualifications, insurance, and compliance status. Null for indefinite approvals. Ref: AWWA.',
    `financial_qualification_met_flag` BOOLEAN COMMENT 'Indicates whether the vendor has met financial stability criteria including credit rating, financial statements review, and bonding capacity. Required for high-value or critical procurements. Ref: AWWA.',
    `insurance_qualification_met_flag` BOOLEAN COMMENT 'Indicates whether the vendor maintains required insurance coverage including general liability, professional liability, and workers compensation at levels specified in procurement policy. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this approved vendor list record was most recently updated. Used for audit trail, change tracking, and data synchronization. Ref: AWWA.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent formal performance evaluation for this vendor. Used to ensure periodic assessment of vendor performance against service level agreements and quality standards. Ref: AWWA.',
    `last_review_date` DATE COMMENT 'The most recent date on which this vendor approval was reviewed for continued compliance with qualification criteria. Used to track periodic vendor performance and compliance audits. Ref: AWWA.',
    `local_vendor_flag` BOOLEAN COMMENT 'Indicates whether the vendor is located within the utilitys service area or designated local procurement zone. Used to support local economic development and reduce transportation costs and lead times. Ref: AWWA.',
    `minority_owned_business_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a minority-owned business enterprise. Used to track diversity spend and meet regulatory or policy goals for supplier diversity. Ref: AWWA.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this vendor approval. Ensures timely re-evaluation of vendor qualifications and performance before expiration. Ref: AWWA.',
    `notes` STRING COMMENT 'Free-form text field for additional information about this vendor approval, including special conditions, restrictions, preferred use cases, or historical context not captured in structured fields. Ref: AWWA.',
    `nsf_certification_flag` BOOLEAN COMMENT 'Indicates whether the vendor supplies products certified by NSF International for use in drinking water systems. NSF 60 certification is required for treatment chemicals; NSF 61 for materials in contact with drinking water. Ref: AWWA.',
    `performance_rating_score` DECIMAL(18,2) COMMENT 'Quantitative performance score for this vendor in the approved category, based on delivery timeliness, quality, responsiveness, and compliance. Used for vendor selection and re-qualification decisions. Typically on a scale of 0-100 or 1-5. Ref: AWWA.',
    `qualification_date` DATE COMMENT 'The date on which the vendor successfully completed the qualification process and was approved for the specified category. Used to track vendor tenure and re-qualification cycles. Ref: AWWA.',
    `quality_qualification_met_flag` BOOLEAN COMMENT 'Indicates whether the vendor has demonstrated quality management capabilities including ISO 9001 certification, quality control procedures, and product testing protocols. Critical for treatment chemicals and critical spare parts.',
    `reinstatement_date` DATE COMMENT 'The date on which a previously suspended or revoked vendor approval was reinstated after corrective actions were completed and verified. Null if never suspended or not yet reinstated. Ref: AWWA.',
    `reviewing_authority_name` STRING COMMENT 'The name of the individual or committee that reviewed and approved this vendor qualification. Used for accountability and audit trail purposes. Ref: AWWA.',
    `reviewing_authority_title` STRING COMMENT 'The job title or role of the reviewing authority who approved this vendor qualification (e.g., Procurement Manager, Director of Supply Chain, Vendor Review Committee Chair). Ref: AWWA.',
    `safety_qualification_met_flag` BOOLEAN COMMENT 'Indicates whether the vendor has met safety requirements including OSHA compliance, safety training records, and incident history review. Mandatory for vendors providing on-site services or hazardous materials.',
    `service_category_code` STRING COMMENT 'The service category for which this vendor is approved, such as construction, engineering, laboratory testing, or maintenance services. Used when approval is for services rather than materials. Ref: AWWA.',
    `small_business_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a small business. Used to track small business spend and meet regulatory requirements for small business participation in public utility procurement. Ref: AWWA.',
    `suspension_date` DATE COMMENT 'The date on which this vendor approval was suspended or revoked. Used to track the duration of suspension and enforce procurement blocks in SAP MM. Ref: AWWA.',
    `suspension_reason` STRING COMMENT 'Explanation for why this vendor approval was suspended or revoked, such as performance issues, compliance violations, insurance lapse, or safety incidents. Null when approval status is active. Ref: AWWA.',
    `technical_qualification_met_flag` BOOLEAN COMMENT 'Indicates whether the vendor has demonstrated technical competence for the approved category, including certifications, past performance, and capability assessments. Critical for specialized materials and services. Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `woman_owned_business_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a woman-owned business enterprise. Used to track diversity spend and meet regulatory or policy goals for supplier diversity. Ref: AWWA.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'Registry of vendors pre-qualified and approved to supply specific materials or service categories to the water utility. Captures vendor, material or service category, approval status, qualification date, expiry date, qualification criteria met (financial, technical, safety, insurance), approved spend limit, and reviewing authority. Enforces procurement compliance and ensures only vetted suppliers are used for critical chemicals and infrastructure materials.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` (
    `procurement_category_id` BIGINT COMMENT 'Unique identifier for the procurement category. Primary key for the procurement category taxonomy. Ref: AWWA.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the procurement professional responsible for managing sourcing strategy, supplier relationships, and spend optimization for this category. Ref: AWWA.',
    `cost_center_id` BIGINT COMMENT 'Default cost center code for budget tracking and cost allocation of procurement in this category. Ref: AWWA.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Categories may link to standing budgets for recurring commodity purchases. Supports automated budget checking for routine purchases like chemicals, ensuring ongoing budget authority. Ref: AWWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Categories may default to specific funds (capital vs operating) for automated fund assignment. Supports procurement configuration ensuring chemicals charge operating fund, equipment charges capital fu. Ref: AWWA.',
    `general_ledger_id` BIGINT COMMENT 'Default general ledger account code for financial posting of expenditures in this procurement category. Used for integration with SAP FI/CO financial accounting. Ref: AWWA.',
    `parent_procurement_category_id` BIGINT COMMENT 'Self-referencing FK on procurement_category (parent_procurement_category_id). Ref: AWWA.',
    `parent_procurement_category_id_legacy` BIGINT COMMENT 'Reference to the parent category in the hierarchical taxonomy. Null for top-level categories. Ref: AWWA.',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Total annual procurement spend for this category in the most recent fiscal year, used for spend analytics and sourcing prioritization. Ref: AWWA.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Dollar amount above which purchases in this category require additional management or executive approval per delegation of authority matrix. Ref: AWWA.',
    `average_lead_time_days` STRING COMMENT 'Typical procurement lead time in days for items in this category, used for materials planning and inventory management. Ref: AWWA.',
    `awwa_standards_compliance_flag` BOOLEAN COMMENT 'Indicates whether materials in this category must comply with American Water Works Association (AWWA) standards for water utility infrastructure and equipment.',
    `budget_code` STRING COMMENT 'Default budget or cost center code for purchases in this category, used for financial planning and cost allocation. Ref: AWWA.',
    `capital_eligible_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category are eligible for capitalization under GAAP or GASB accounting standards as part of Capital Improvement Program (CIP) expenditures. Ref: AWWA.',
    `capital_vs_opex_classification` STRING COMMENT 'Accounting classification indicating whether purchases in this category are typically capitalized as assets or expensed as operations and maintenance costs. Ref: AWWA.. Valid values are `capital|operating|mixed`',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the procurement category. Used for classification and reporting purposes. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,20}$`',
    `category_description` STRING COMMENT 'Detailed description of the goods and services included in this procurement category, including scope and boundaries. Ref: AWWA.',
    `category_level` STRING COMMENT 'Hierarchical level of the category in the taxonomy tree. Level 1 is top-level, increasing numbers represent deeper nesting. Ref: AWWA.',
    `category_name` STRING COMMENT 'Full descriptive name of the procurement category. Human-readable label for the category. Ref: AWWA.',
    `category_status` STRING COMMENT 'Current lifecycle status of the procurement category. Active categories are available for use in requisitions and purchase orders. Ref: AWWA.. Valid values are `active|inactive|deprecated|under_review`',
    `category_type` STRING COMMENT 'High-level classification of the procurement category distinguishing between materials, services, chemicals, equipment, utilities, and professional services. Ref: AWWA.. Valid values are `materials|services|chemicals|equipment|utilities|professional_services`',
    `chemical_category_flag` BOOLEAN COMMENT 'Indicates whether this category includes water or wastewater treatment chemicals (chlorine, coagulants, polymers, fluoride, etc.) requiring specialized procurement and inventory management. Ref: AWWA.',
    `commodity_code` STRING COMMENT 'Standard commodity classification code aligned with NIGP (National Institute of Governmental Purchasing) or UNSPSC (United Nations Standard Products and Services Code) for procurement standardization. Ref: AWWA.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `commodity_group` STRING COMMENT 'High-level commodity grouping for the category. Aligns with water utility operational needs including treatment chemicals, infrastructure components, and support services. Ref: AWWA.. Valid values are `chemicals|mechanical_parts|electrical_components|civil_materials|professional_services|information_technology`',
    `competitive_bid_required_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category require competitive bidding process per procurement regulations and internal policy. Ref: AWWA.',
    `competitive_bidding_required_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category require competitive bidding or request for quotation (RFQ) processes per regulatory or organizational procurement policies. Ref: AWWA.',
    `contract_required_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category must be made under an established contract or blanket purchase agreement. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement category record was first created in the system. Ref: AWWA.',
    `critical_spare_flag` BOOLEAN COMMENT 'Indicates whether items in this category are classified as critical spare parts essential for maintaining water and wastewater infrastructure operations and minimizing downtime. Ref: AWWA.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary thresholds and budgets associated with this procurement category (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `default_lead_time_days` STRING COMMENT 'Standard procurement lead time in days for items in this category, used for materials planning and inventory replenishment calculations. Ref: AWWA.',
    `diversity_preference_flag` BOOLEAN COMMENT 'Indicates whether this procurement category has organizational or regulatory preferences for minority-owned, woman-owned, or small business enterprise (MBE/WBE/SBE) vendors. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date when this procurement category was retired or deprecated. Null for currently active categories. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when this procurement category became active and available for use in requisitions and purchase orders. Ref: AWWA.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether procurement in this category requires environmental compliance documentation such as Safety Data Sheets (SDS), EPA certifications, or environmental impact assessments. Ref: AWWA.',
    `environmental_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether procurement in this category requires environmental compliance certifications or assessments (e.g., ISO 14001, EPA environmental standards).',
    `gl_account_code` STRING COMMENT 'Default general ledger account code for expenses in this category, used for financial accounting and reporting per GASB standards. Ref: AWWA.. Valid values are `^[0-9]{4,10}$`',
    `hazardous_material_category_flag` BOOLEAN COMMENT 'Indicates whether this category includes hazardous materials requiring special handling, storage, and regulatory compliance per OSHA and EPA standards.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether materials in this category are classified as hazardous materials requiring special handling, storage, and regulatory compliance per OSHA and EPA standards.',
    `insurance_requirement_description` STRING COMMENT 'Description of insurance coverage requirements for vendors supplying goods or services in this category, including liability limits and coverage types. Ref: AWWA.',
    `inventory_managed_flag` BOOLEAN COMMENT 'Indicates whether items in this category are tracked in inventory management systems and subject to stock level monitoring, reorder points, and cycle counting. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement category record was last updated, used for change tracking and data lineage. Ref: AWWA.',
    `local_preference_flag` BOOLEAN COMMENT 'Indicates whether this category has a local sourcing preference to support regional economic development and reduce supply chain risk. Ref: AWWA.',
    `material_group_code` STRING COMMENT 'SAP MM material group code for integration with enterprise resource planning systems. Used for procurement planning and materials management. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,10}$`',
    `minimum_order_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum dollar value threshold for purchase orders in this category. Orders below this threshold may require different approval workflows or procurement methods. Ref: AWWA.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum dollar threshold for purchase orders in this category, used to enforce procurement policy and prevent maverick spending. Ref: AWWA.',
    `minority_business_enterprise_goal_percent` DECIMAL(18,2) COMMENT 'Target percentage of spend in this category to be directed to certified minority-owned businesses to support supplier diversity objectives. Ref: AWWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to procurement in this category. Ref: AWWA.',
    `nsf_certification_required_flag` BOOLEAN COMMENT 'Indicates whether materials in this category require NSF/ANSI 60 or NSF/ANSI 61 certification for use in drinking water systems per EPA and state drinking water program requirements. Ref: AWWA.',
    `preferred_sourcing_strategy` STRING COMMENT 'Recommended procurement approach for this category based on market dynamics, risk profile, and spend characteristics. Ref: AWWA.. Valid values are `competitive_bid|sole_source|preferred_vendor|blanket_order|spot_buy|cooperative_contract`',
    `procurement_category_status` STRING COMMENT 'Current lifecycle status of the procurement category indicating whether it is actively used for procurement operations. Ref: AWWA.. Valid values are `active|inactive|deprecated|pending_approval`',
    `purchasing_group_code` STRING COMMENT 'Code identifying the purchasing group or buyer team responsible for procuring items in this category. Ref: AWWA.. Valid values are `^[A-Z0-9]{2,10}$`',
    `quality_certification_required` STRING COMMENT 'Industry or regulatory quality certifications required for suppliers in this category, such as ISO 9001, NSF/ANSI 60/61 for water treatment chemicals, or AWWA standards.',
    `responsible_buyer_email` STRING COMMENT 'Email address of the procurement specialist responsible for this category for vendor inquiries and procurement coordination. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_buyer_name` STRING COMMENT 'Name of the procurement specialist or buyer responsible for managing vendor relationships and purchase orders for this category. Ref: AWWA.',
    `spend_visibility_flag` BOOLEAN COMMENT 'Indicates whether this category is included in executive spend analytics dashboards and strategic sourcing reviews. Ref: AWWA.',
    `standard_unit_of_measure` STRING COMMENT 'Default unit of measure for procurement and inventory tracking of items in this category (e.g., EA, LB, GAL, FT, TON). Ref: AWWA.',
    `strategic_category_flag` BOOLEAN COMMENT 'Indicates whether this category is designated as strategic for the utility, requiring enhanced sourcing governance and supplier relationship management. Ref: AWWA.',
    `unspsc_code` STRING COMMENT 'Eight-digit UNSPSC classification code for global procurement standardization and spend analytics. Ref: AWWA.. Valid values are `^[0-9]{8}$`',
    `unspsc_description` STRING COMMENT 'Descriptive label corresponding to the UNSPSC code for reference and validation purposes. Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `woman_business_enterprise_goal_percent` DECIMAL(18,2) COMMENT 'Target percentage of spend in this category to be directed to certified woman-owned businesses to support supplier diversity objectives. Ref: AWWA.',
    CONSTRAINT pk_procurement_category PRIMARY KEY(`procurement_category_id`)
) COMMENT 'Master reference table for procurement_category. ';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` (
    `project_vendor_engagement_id` BIGINT COMMENT 'Unique identifier for this project-vendor engagement record. Primary key. Ref: AWWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to the CIP project master record. Ref: AWWA.',
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract referenced by each project vendor engagement record in the supply domain.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record in the supply domain. Ref: AWWA.',
    `actual_amount_paid` DECIMAL(18,2) COMMENT 'Cumulative actual payments made to this vendor for work on this project. Used to track contract spend against awarded value. Ref: AWWA.',
    `change_order_count` STRING COMMENT 'Number of change orders issued to this vendor for this project. Indicator of scope changes and contract modifications. Ref: AWWA.',
    `committed_amount` DECIMAL(18,2) COMMENT 'The committed amount value recorded for each project vendor engagement in the supply domain.',
    `contract_award_date` DATE COMMENT 'Date the construction contract was awarded to the general contractor. Marks the formal start of the construction procurement phase. [Moved from cip_project: This attribute on the CIP project appears to reference a single contract award date, but projects have multiple contracts with different vendors awarded at different times. Each vendor engagement has its own contract_start_date. This project-level attribute is ambiguous when multiple vendors are involved.]. Ref: AWWA.',
    `contract_end_date` DATE COMMENT 'The date this vendors contract or engagement ended (or is planned to end) for this specific project. Identified in detection reasoning as relationship data. Ref: AWWA.',
    `contract_start_date` DATE COMMENT 'The date this vendors contract or engagement began for this specific project. Identified in detection reasoning as relationship data. Ref: AWWA.',
    `contract_status` STRING COMMENT 'Current status of this vendors contract for this project. Tracks the lifecycle of the engagement from award through completion or termination. Ref: AWWA.',
    `contract_value` DECIMAL(18,2) COMMENT 'The total awarded contract value for this vendors engagement on this project. Identified in detection reasoning as relationship data. Represents the financial commitment for this specific vendor-project combination. Ref: AWWA.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this engagement record was created in the system. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each project vendor engagement record in the supply domain.',
    `design_firm_name` STRING COMMENT 'Name of the engineering or architectural firm contracted to provide design services for the project. Null if design is performed in-house. [Moved from cip_project: This attribute currently stores a single design firm name on the CIP project, but in reality multiple vendors can serve in design roles (architectural, civil, electrical, environmental). This should be captured as vendor engagements with role_type=design_engineer rather than a single text field on the project.]. Ref: AWWA.',
    `engaged_value_amount` DECIMAL(18,2) COMMENT 'The engaged value amount value recorded for each project vendor engagement in the supply domain.',
    `engagement_end_date` TIMESTAMP COMMENT 'The engagement end date associated with each project vendor engagement record in the supply domain.',
    `engagement_number` STRING COMMENT 'The engagement number value recorded for each project vendor engagement in the supply domain.',
    `engagement_role` STRING COMMENT 'The engagement role value recorded for each project vendor engagement in the supply domain.',
    `engagement_start_date` TIMESTAMP COMMENT 'The engagement start date associated with each project vendor engagement record in the supply domain.',
    `engagement_status` STRING COMMENT 'The engagement status value recorded for each project vendor engagement in the supply domain.',
    `general_contractor_name` STRING COMMENT 'Name of the general contractor or construction manager awarded the construction contract. Null if project has not reached construction phase or is performed by utility forces. [Moved from cip_project: This attribute currently stores a single general contractor name on the CIP project, but this is actually a vendor engagement relationship. The general contractor is a vendor with role_type=general_contractor. Storing the name redundantly on the project creates data integrity issues when the same information exists in the vendor master.]. Ref: AWWA.',
    `insurance_verified_flag` BOOLEAN COMMENT 'Indicates whether required insurance certificates (general liability, workers comp, professional liability) have been verified for this vendor on this project. Ref: AWWA.',
    `invoiced_to_date_amount` DECIMAL(18,2) COMMENT 'The invoiced to date amount associated with each project vendor engagement record in the supply domain.',
    `is_prime_contractor` BOOLEAN COMMENT 'Boolean flag indicating whether the is prime contractor condition applies to the project vendor engagement record.',
    `last_updated_by` STRING COMMENT 'User ID or name of the person who last updated this engagement record. Ref: AWWA.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this engagement record. Ref: AWWA.',
    `performance_rating` STRING COMMENT 'Performance evaluation rating for this vendors work on this specific project. Identified in detection reasoning as relationship data. Used for future vendor selection and contract award decisions. Ref: AWWA.',
    `purchase_order_number` STRING COMMENT 'The purchase order or contract number issued to this vendor for this project. Links to procurement and accounts payable systems. Ref: AWWA.',
    `role_type` STRING COMMENT 'The specific role this vendor plays in the CIP project. Identified in detection reasoning as relationship data. Examples: general_contractor, design_engineer, specialty_subcontractor, materials_supplier, testing_lab, environmental_consultant. Ref: AWWA.',
    `vibe_supply_domain_flag` BOOLEAN COMMENT 'Provenance flag set during supply domain build. Ref: AWWA.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this engagement record. Ref: AWWA.',
    CONSTRAINT pk_project_vendor_engagement PRIMARY KEY(`project_vendor_engagement_id`)
) COMMENT 'This association product represents the contractual engagement between a vendor and a CIP project. It captures the specific role, contract terms, performance, and financial details for each vendor participating in a capital improvement project. Each record links one vendor to one CIP project with attributes that exist only in the context of this specific engagement, such as contract value, dates, performance ratings, and the vendors role (general contractor, design engineer, materials supplier, testing lab, specialty consultant).. Existence Justification: In water utility capital improvement programs, CIP projects engage multiple vendors simultaneously in different roles (general contractor, design engineer, materials suppliers, testing labs, specialty consultants), and each vendor typically works on multiple projects concurrently across the utilitys CIP portfolio. The utility actively manages these engagements as distinct business entities, tracking contract-specific data such as awarded value, performance ratings, role assignments, and contract dates for each vendor-project combination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_primary_po_material_master_id` FOREIGN KEY (`primary_po_material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_goods_material_material_master_id` FOREIGN KEY (`goods_material_material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_material_requisition_id` FOREIGN KEY (`material_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_stock_material_material_master_id` FOREIGN KEY (`stock_material_material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ADD CONSTRAINT `fk_supply_approved_vendor_list_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ADD CONSTRAINT `fk_supply_approved_vendor_list_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ADD CONSTRAINT `fk_supply_approved_vendor_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_parent_procurement_category_id` FOREIGN KEY (`parent_procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_parent_procurement_category_id_legacy` FOREIGN KEY (`parent_procurement_category_id_legacy`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ADD CONSTRAINT `fk_supply_project_vendor_engagement_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ADD CONSTRAINT `fk_supply_project_vendor_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`supply` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|restricted');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `diversity_certification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate On File Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `minority_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority Owned Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `name_short` SET TAGS ('dbx_business_glossary_term' = 'Vendor Short Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `name_short` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|procurement_card');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor|not_rated');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'chemical_supplier|equipment_manufacturer|spare_parts_distributor|service_contractor|professional_services|utility_provider');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `w9_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'W-9 Form On File Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `woman_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Woman Owned Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_subdomain' = 'inventory_materials');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `critical_spare_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Spare Part Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `discontinued_date` SET TAGS ('dbx_business_glossary_term' = 'Material Discontinued Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `issue_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Issue Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Last Modified Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,9}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval|restricted|phased_out');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Material Master Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|internal|both|no_procurement');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Purchase Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `serialized_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Material Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Material Short Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `primary_purchase_requisitioner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `primary_purchase_requisitioner_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `primary_purchase_requisitioner_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|work_order|project|asset|sales_order');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|emergency');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requesting_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Requesting Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requesting_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requesting_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Requesting Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requesting_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard|stock|service|subcontracting|consignment|third_party');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_MM|MAXIMO|DYNAMICS|MANUAL');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Warehouse Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_business_glossary_term' = 'Buyer Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_business_glossary_term' = 'Delivery State');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `is_capital_purchase` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Purchase Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|emergency|capital|service');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `requestor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `total_amount_with_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Amount With Tax');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_site_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `primary_po_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|asset|wbs_element|order|network');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `confirmation_control_key` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Control Key');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `confirmation_control_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'not_delivered|partially_delivered|fully_delivered|over_delivered');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `invoice_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|service|stock_transfer|third_party');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,9}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price per Unit');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchase_requisition_item` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Item Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Short Text');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,2}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{8,24}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'inventory_materials');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Personnel Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_material_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Personnel Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_business_glossary_term' = 'Delivery Condition');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_value_regex' = 'good|damaged|partial|incorrect|contaminated');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending_inspection|completed');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `invoice_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Personnel Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'pending|matched|variance|blocked');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_subdomain' = 'inventory_materials');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Stock Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `inventory_wtp_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `average_daily_consumption` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `blocked_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `consignment_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `cycle_count_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `cycle_count_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `expiration_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Expiration Controlled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_stock_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stock Adjustment Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|VM|ND');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|in_house|both');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `quality_inspection_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `serial_number_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Managed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'in_stock|low_stock|out_of_stock|overstocked|obsolete');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_turnover_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stock Turnover Ratio');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'own|consignment|project|subcontracting|returnable_packaging');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Stock Value Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `unrestricted_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_subdomain' = 'inventory_materials');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'From Warehouse Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_material_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `amount_in_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `amount_in_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,16}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `entry_time` SET TAGS ('dbx_business_glossary_term' = 'Entry Time');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Movement Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_value_regex' = 'B|H|F|E|L');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'posted|pending|cancelled|error');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `physical_inventory_document_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `physical_inventory_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_item` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Item Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Material Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'E|K|O|Q|W');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `storage_location_to` SET TAGS ('dbx_business_glossary_term' = 'Storage Location To');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `storage_location_to` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `text_header` SET TAGS ('dbx_business_glossary_term' = 'Header Text');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `text_item` SET TAGS ('dbx_business_glossary_term' = 'Item Text');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `unloading_point` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,25}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_business_glossary_term' = 'User Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,24}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_subdomain' = 'inventory_materials');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `access_hours` SET TAGS ('dbx_business_glossary_term' = 'Access Hours');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `available_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (Square Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'sqft|sqm|cubic_ft|cubic_m|pallet_positions');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'central_warehouse|wtp_chemical_store|wwtp_chemical_store|field_storeroom|maintenance_depot|emergency_stockpile');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_value_regex' = 'sprinkler|foam|gas|none|dry_chemical');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `inventory_cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cycle Count Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `inventory_cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_demand');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `location_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|temporarily_closed|restricted_access');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `responsible_custodian` SET TAGS ('dbx_business_glossary_term' = 'Responsible Custodian');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Storage Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'public|restricted|controlled|high_security');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `spill_containment_available` SET TAGS ('dbx_business_glossary_term' = 'Spill Containment Available');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `temperature_control_available` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Available');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `temperature_range_max_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Fahrenheit)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `temperature_range_min_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Fahrenheit)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Square Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `ventilation_type` SET TAGS ('dbx_business_glossary_term' = 'Ventilation Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `ventilation_type` SET TAGS ('dbx_value_regex' = 'natural|mechanical|forced_air|none|exhaust_only');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL (Uniform Resource Locator)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'value_contract|quantity_contract|framework_agreement|blanket_order|service_contract|chemical_supply_agreement');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Primary Delivery Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|DDP|EXW|FCA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insurance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `minority_business_enterprise` SET TAGS ('dbx_business_glossary_term' = 'Minority Business Enterprise (MBE) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|procurement_card');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `performance_clause` SET TAGS ('dbx_business_glossary_term' = 'Performance Clause Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_value_regex' = 'fixed_price|variable_price|cost_plus|index_linked|tiered_pricing');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `remaining_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `small_business_enterprise` SET TAGS ('dbx_business_glossary_term' = 'Small Business Enterprise (SBE) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `total_released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Released Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `total_released_value` SET TAGS ('dbx_business_glossary_term' = 'Total Released Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_system_of_record' = 'Oracle_CC&B');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Cleared Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_run_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Evaluation ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `coa_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Compliance Rate Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `commodity_category` SET TAGS ('dbx_value_regex' = 'chemicals|equipment|services|materials|spare_parts|construction');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_number` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `order_fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Order Fill Rate Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `overall_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `pricing_accuracy_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Pricing Accuracy Rate Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `quality_conformance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Quality Conformance Rate Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Recommendation');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `recommendation` SET TAGS ('dbx_value_regex' = 'continue|renew_contract|renegotiate_terms|probation|discontinue');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `total_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Orders Evaluated');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_subdomain' = 'inventory_materials');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `deleted_flag` SET TAGS ('dbx_business_glossary_term' = 'Deleted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `final_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Issue Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `issued_by` SET TAGS ('dbx_business_glossary_term' = 'Issued By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `issued_quantity` SET TAGS ('dbx_business_glossary_term' = 'Issued Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'emergency|high|normal|low');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `required_date` SET TAGS ('dbx_business_glossary_term' = 'Required Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'open|partially_issued|fully_issued|cancelled|closed');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'maintenance|operations|capital_project|emergency|planned');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `reservation_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `reservation_item_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Item Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `awarded_date` SET TAGS ('dbx_business_glossary_term' = 'Awarded Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `bonding_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonding Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_business_glossary_term' = 'Buyer Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `closing_time` SET TAGS ('dbx_business_glossary_term' = 'Closing Time');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `competitive_bidding_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bidding Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `delivery_required_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Required Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_description` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `diversity_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Preference Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `invited_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Invited Vendor Count');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `minimum_vendors_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Vendors Required');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `pre_bid_attendance_mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Bid Attendance Mandatory Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `pre_bid_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Bid Meeting Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `pre_bid_meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Pre-Bid Meeting Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `quotes_received_count` SET TAGS ('dbx_business_glossary_term' = 'Quotes Received Count');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|open|closed|cancelled|awarded');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_value_regex' = 'materials|services|equipment|chemicals|construction|professional_services');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Title');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_justification` SET TAGS ('dbx_business_glossary_term' = 'Approval Justification');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|suspended|expired|revoked|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_type` SET TAGS ('dbx_value_regex' = 'standard|preferred|emergency|conditional|trial');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_spend_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Spend Limit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_spend_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Approved Spend Limit Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_spend_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_spend_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Approved Spend Limit Period');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_spend_limit_period` SET TAGS ('dbx_value_regex' = 'per_transaction|annual|contract_lifetime|unlimited');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `awwa_standards_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'American Water Works Association (AWWA) Standards Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `environmental_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `financial_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `insurance_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `local_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Vendor Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `minority_owned_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority Owned Business Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `nsf_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'National Sanitation Foundation (NSF) Certification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `performance_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating Score');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `quality_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `reviewing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Authority Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `reviewing_authority_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `reviewing_authority_title` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Authority Title');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `safety_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `service_category_code` SET TAGS ('dbx_business_glossary_term' = 'Service Category Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `technical_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `woman_owned_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Woman Owned Business Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `parent_procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Procurement Category Id');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `parent_procurement_category_id_legacy` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `awwa_standards_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'AWWA Standards Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `capital_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `capital_vs_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) vs Operating Expenditure (OPEX) Classification');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `capital_vs_opex_classification` SET TAGS ('dbx_value_regex' = 'capital|operating|mixed');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'materials|services|chemicals|equipment|utilities|professional_services');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `chemical_category_flag` SET TAGS ('dbx_business_glossary_term' = 'Chemical Category Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `commodity_group` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `commodity_group` SET TAGS ('dbx_value_regex' = 'chemicals|mechanical_parts|electrical_components|civil_materials|professional_services|information_technology');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `competitive_bid_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bid Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `competitive_bidding_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bidding Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `contract_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `critical_spare_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Spare Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `default_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Default Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `diversity_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Preference Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `environmental_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `hazardous_material_category_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Category Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `insurance_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `inventory_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Managed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `local_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Preference Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `minimum_order_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `minority_business_enterprise_goal_percent` SET TAGS ('dbx_business_glossary_term' = 'Minority Business Enterprise (MBE) Goal Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `nsf_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'NSF Certification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `preferred_sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Preferred Sourcing Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `preferred_sourcing_strategy` SET TAGS ('dbx_value_regex' = 'competitive_bid|sole_source|preferred_vendor|blanket_order|spot_buy|cooperative_contract');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `procurement_category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `procurement_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `quality_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Buyer Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Buyer Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `spend_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Spend Visibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `standard_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `strategic_category_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Category Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `unspsc_description` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC) Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `woman_business_enterprise_goal_percent` SET TAGS ('dbx_business_glossary_term' = 'Woman Business Enterprise (WBE) Goal Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_association_edges' = 'supply.vendor,project.cip_project');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `project_vendor_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Vendor Engagement ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Vendor Engagement - Cip Project Id');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Project Vendor Engagement - Vendor Id');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `actual_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount Paid');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_award_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Award Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `design_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Design Firm Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `design_firm_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `general_contractor_name` SET TAGS ('dbx_business_glossary_term' = 'General Contractor Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `general_contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `general_contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `general_contractor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `insurance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Role Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
