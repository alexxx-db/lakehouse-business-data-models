-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`supply` COMMENT 'Healthcare supply chain and materials management. Owns medical-surgical supplies, implantable device tracking (UDI), prosthetics, procurement, inventory management, requisitions, par-level replenishment, expiration tracking, recall management, vendor management, BOM (Bill of Materials) for surgical procedures, and sterile processing. Integrates with Infor Lawson and SAP MM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique surrogate identifier for each material master record in the healthcare supply chain. Primary key for the material_master data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Healthcare supply chain assigns category managers to material groups (e.g., cardiovascular devices, pharmaceuticals, OR supplies) for strategic sourcing, contract negotiation, vendor performance manag',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Medical devices and controlled substances must comply with specific regulatory programs (FDA device tracking, DEA controlled substance programs). Healthcare organizations track which compliance progra',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Materials have default expense GL accounts for automated posting when issued to cost centers. Enables consistent expense classification and reduces manual coding at transaction time. Standard ERP patt',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Supply items, especially DME and billable medical supplies, require HCPCS codes for reimbursement and formulary management. Enables automated charge capture, contract pricing validation, and payer-spe',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medical supplies and implantables with NDC codes must reference the NDC drug master for accurate product identification, FDA tracking, and recall management. Currently has ndc_code as text. Links supp',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Healthcare supply items have payer-specific coverage policies and reimbursement codes. Real business process: determining if a supply item (especially implants, DME) is covered by a specific payer bef',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred or primary vendor for sourcing this supply item. Drives automated purchase order generation, contract compliance, and vendor performance tracking. Linked to the vendor master.',
    `terminology_mapping_id` BIGINT COMMENT 'Foreign key linking to interoperability.terminology_mapping. Business justification: Supply item master data (NDC, HCPCS, UNSPSC codes) requires standardized terminology mapping for HL7/FHIR transmission. Links items to their code system mappings for interoperability and claims submis',
    `approved_date` DATE COMMENT 'Date on which the supply item was approved for addition to the organizations supply formulary by the Value Analysis Committee (VAC) or equivalent governance body. Marks the start of authorized procurement and use.',
    `catalog_price` DECIMAL(18,2) COMMENT 'Standard catalog or list price per stocking unit of measure as published in the item catalog or charge description master (CDM). Used as the baseline for charge capture, contract price comparison, and cost accounting. Expressed in USD.',
    `cdm_charge_code` STRING COMMENT 'Charge Description Master (CDM) code linking the supply item to the organizations revenue cycle charge capture system. Used for patient billing, revenue cycle management (RCM), and CMS cost reporting.',
    `contract_price` DECIMAL(18,2) COMMENT 'Negotiated contract price per stocking unit of measure under the active GPO or direct vendor contract. Used for purchase order pricing, savings tracking, and contract compliance monitoring. Expressed in USD.',
    `cost_center_code` STRING COMMENT 'SAP cost center code representing the organizational unit responsible for the supply items default cost allocation. Used for departmental budget tracking and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the material master record was first created in the system. Supports audit trail, data lineage, and compliance with HIPAA and organizational data governance policies.',
    `dea_schedule` STRING COMMENT 'DEA controlled substance schedule (CI through CV) for pharmaceutical items. Determines storage security requirements, dispensing controls, and DEA reporting obligations. Null for non-controlled items.. Valid values are `CI|CII|CIII|CIV|CV`',
    `discontinuation_date` DATE COMMENT 'Date on which the supply item was or is scheduled to be discontinued from the formulary and removed from active procurement. Null if the item is currently active. Used for transition planning and inventory rundown management.',
    `fda_device_class` STRING COMMENT 'FDA regulatory classification for medical devices: Class I (low risk, general controls), Class II (moderate risk, special controls), or Class III (high risk, premarket approval required). Drives regulatory compliance requirements, approval workflows, and recall risk stratification.. Valid values are `I|II|III`',
    `fda_product_code` STRING COMMENT 'Three-letter FDA product code identifying the specific device type within the FDAs device classification system. Used for regulatory submissions, 510(k) clearance tracking, and adverse event reporting to MedWatch.. Valid values are `^[A-Z]{3}$`',
    `formulary_status` STRING COMMENT 'Indicates the items approval status on the organizations supply formulary or pharmacy formulary. Controls whether the item can be ordered through standard requisition workflows or requires special approval. Managed by the Value Analysis Committee (VAC).. Valid values are `formulary|non_formulary|restricted|pending_review|therapeutic_substitute`',
    `gl_account_code` STRING COMMENT 'SAP General Ledger (GL) account code to which supply item costs are posted upon consumption or purchase. Enables cost center allocation, financial reporting, and budget variance analysis per GAAP and FASB standards.',
    `gtin` STRING COMMENT 'GS1-assigned Global Trade Item Number (GTIN) used for barcode scanning, automated receiving, and supply chain interoperability. Supports 2D barcode scanning at point of care and integration with GS1 healthcare standards.. Valid values are `^[0-9]{14}$`',
    `is_controlled_substance` BOOLEAN COMMENT 'Indicates whether the supply item is a DEA-scheduled controlled substance requiring enhanced security, chain-of-custody documentation, and DEA reporting. Triggers Willow pharmacy and Pyxis dispensing controls.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the supply item is classified as a hazardous material requiring special handling, storage, labeling, and disposal per OSHA Hazard Communication Standard (HazCom) and EPA regulations. Triggers safety data sheet (SDS) requirements.',
    `is_implantable` BOOLEAN COMMENT 'Indicates whether the supply item is an implantable device requiring UDI tracking, patient implant card issuance, and post-market surveillance per FDA regulations. Triggers mandatory lot/serial tracking and patient-level implant documentation.',
    `is_latex_free` BOOLEAN COMMENT 'Indicates whether the supply item is certified latex-free. Critical for patient safety in latex-allergic patients and required for allergy-safe supply chain management per Joint Commission patient safety standards.',
    `is_sterile` BOOLEAN COMMENT 'Indicates whether the supply item is supplied in a sterile state and requires sterile handling, storage, and processing. Drives sterile processing department (SPD) workflows, storage segregation, and expiration monitoring.',
    `item_category_code` STRING COMMENT 'Internal classification code representing the supply items position within the organizations commodity hierarchy (e.g., cardiovascular implants, orthopedic prosthetics, wound care). Used for spend analytics, formulary management, and par-level grouping.',
    `item_category_name` STRING COMMENT 'Human-readable name of the supply items commodity category corresponding to item_category_code. Supports reporting, catalog browsing, and clinical staff communication.',
    `item_description` STRING COMMENT 'Full descriptive name of the supply item as it appears in the item catalog and on purchase orders, requisitions, and charge description master (CDM). Provides human-readable identification for clinical and supply chain staff.',
    `item_number` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to the supply item within the organizations item catalog (e.g., Infor Lawson item number or SAP material number). Used across procurement, inventory, and clinical systems as the primary business key.',
    `item_status` STRING COMMENT 'Current lifecycle status of the material master record indicating whether the item is available for procurement and use. Controls ordering eligibility and inventory replenishment.. Valid values are `active|inactive|discontinued|on_hold|pending_approval`',
    `item_type` STRING COMMENT 'High-level classification of the supply item by its functional category within the healthcare supply chain. Drives regulatory handling, storage requirements, and charge capture rules. [ENUM-REF-CANDIDATE: medical_surgical|implantable_device|prosthetic|pharmaceutical|consumable|capital_equipment|reagent|sterile_supply — promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the material master record. Used for change tracking, data synchronization across integrated systems (Epic, Infor Lawson, SAP), and audit compliance.',
    `lead_time_days` STRING COMMENT 'Expected number of calendar days from purchase order placement to receipt of the supply item from the preferred vendor. Used for reorder point calculation, safety stock determination, and supply chain risk management.',
    `lot_tracking_required` BOOLEAN COMMENT 'Indicates whether lot/batch number tracking is required for this supply item. Mandatory for implantable devices, biologics, and items subject to FDA recall management. Enables traceability from receipt to patient use.',
    `manufacturer_item_number` STRING COMMENT 'The manufacturers own catalog or part number for the supply item. Used for cross-referencing with vendor catalogs, purchase orders, and recall notices. Distinct from the internal item number.',
    `manufacturer_name` STRING COMMENT 'Legal name of the company that manufactures the supply item. Used for vendor management, recall notifications, FDA adverse event reporting, and GPO contract compliance.',
    `ndc_code` STRING COMMENT 'FDA-assigned National Drug Code (NDC) for pharmaceutical and drug-related supply items. Structured as labeler-product-package segments. Required for pharmacy formulary management, drug charge capture, and CMS billing compliance.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `order_unit_of_measure` STRING COMMENT 'The unit of measure used when placing purchase orders with vendors (e.g., CS=case, PK=pack). May differ from the stocking unit of measure. The conversion factor between order UOM and stock UOM is used for receiving and inventory valuation.',
    `par_level` DECIMAL(18,2) COMMENT 'Periodic Automatic Replenishment (PAR) level representing the target on-hand quantity for this item at a stocking location. Used by supply chain technicians during PAR cart rounds to determine replenishment needs.',
    `preferred_vendor_item_number` STRING COMMENT 'The preferred vendors own catalog or part number for this supply item. Used on purchase orders and for EDI transactions with the vendor. Supports automated order matching and invoice reconciliation.',
    `recall_status` STRING COMMENT 'Current FDA recall status for the supply item. Class I recalls indicate serious health hazard; Class II indicate temporary adverse health consequences; Class III indicate unlikely health hazard. Triggers quarantine and removal workflows.. Valid values are `no_recall|class_i_recall|class_ii_recall|class_iii_recall|market_withdrawal`',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory quantity level at which a replenishment order is automatically triggered for this supply item. Expressed in the stocking unit of measure. Core parameter for par-level replenishment and stockout prevention.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'Standard quantity to be ordered when the reorder point is reached. Expressed in the order unit of measure. Optimized based on usage patterns, lead time, and storage capacity.',
    `serial_tracking_required` BOOLEAN COMMENT 'Indicates whether individual serial number tracking is required for this supply item. Applies to high-value implantable devices and capital equipment requiring unique unit-level traceability for patient safety and recall management.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the supply item can be stored from manufacture or receipt before expiration. Drives FEFO (First Expired First Out) inventory management, expiration date tracking, and waste reduction programs.',
    `storage_location_type` STRING COMMENT 'Required storage environment type for the supply item. Determines physical storage assignment within the warehouse or storeroom and drives compliance with safety and regulatory storage requirements.. Valid values are `ambient|refrigerated|frozen|controlled_room_temp|flammable_cabinet|biohazard`',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for this supply item. Used in conjunction with minimum storage temperature to define the acceptable temperature range for storage compliance and cold chain management.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum required storage temperature in degrees Celsius for this supply item. Critical for temperature-sensitive biologics, vaccines, and reagents. Used to assign items to appropriate storage locations (refrigerator, freezer, ambient).',
    `udi` STRING COMMENT 'FDA-mandated Unique Device Identifier for implantable devices and medical equipment. Composed of a Device Identifier (DI) and Production Identifier (PI). Required for device tracking, recall management, and adverse event reporting under FDA 21 CFR Part 830.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure in which the supply item is stocked, issued, and consumed (e.g., EA=each, BX=box, CS=case, PK=pack, ML=milliliter, GM=gram). Governs inventory counting, par-level management, and charge capture.',
    `unspsc_code` STRING COMMENT 'United Nations Standard Products and Services Code (UNSPSC) providing a globally standardized commodity classification for the supply item. Used for spend analytics, group purchasing organization (GPO) benchmarking, and procurement reporting.. Valid values are `^[0-9]{8}$`',
    `uom_conversion_factor` DECIMAL(18,2) COMMENT 'Numeric conversion factor between the order unit of measure and the stocking unit of measure (e.g., 1 case = 24 each → factor = 24). Used for accurate receiving, inventory valuation, and par-level calculations.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Central master record for all medical-surgical supplies, implantable devices, prosthetics, and consumables in the healthcare supply chain. Stores item identification (UDI, NDC, HCPCS), classification hierarchy, unit of measure, storage requirements, sterility indicators, hazardous material flags, reorder parameters, regulatory attributes (FDA device class), formulary status, preferred vendor, UNSPSC code, GL account mapping, and catalog pricing. SSOT for supply item identity and formulary approval.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique surrogate identifier for the vendor record in the healthcare supply chain master. Primary key for the vendor entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor relationships in healthcare require assigned supply chain staff for ongoing performance management, contract renewals, issue escalation, quarterly business reviews, and strategic partnership de',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Vendors must meet compliance program requirements (diversity certification programs, OIG exclusion screening programs, quality assurance programs). Supply chain tracks which compliance programs each v',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: Vendors who exchange electronic data (EDI transactions, punchout catalogs, recall notifications, ASN messages) are trading partners. Links supply vendors to their interoperability profiles for electro',
    `address_line1` STRING COMMENT 'First line of the vendors primary business address (street number and name). Used for purchase order mailing, contract correspondence, and regulatory filings.',
    `address_line2` STRING COMMENT 'Second line of the vendors primary business address (suite, floor, building). Supplements address_line1 for complete mailing address.',
    `approved_date` DATE COMMENT 'Date on which the vendor was formally approved by the healthcare organizations value analysis committee or supply chain governance process for use in procurement.',
    `bank_account_number` STRING COMMENT 'Bank account number for ACH/EFT payment remittance to the vendor. Classified as restricted financial data. Stored in encrypted form per PCI DSS and SOC 2 requirements.',
    `bank_routing_number` STRING COMMENT 'ABA routing transit number for the vendors bank. Required for ACH and wire transfer payment processing. Classified as restricted financial data.. Valid values are `^[0-9]{9}$`',
    `city` STRING COMMENT 'City of the vendors primary business address. Used for geographic analysis, tax jurisdiction determination, and regulatory reporting.',
    `contract_end_date` DATE COMMENT 'Expiration date of the current active contract or master purchasing agreement with the vendor. Supply chain teams use this for contract renewal planning and sourcing strategy.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current active contract or master purchasing agreement with the vendor. Used for contract compliance monitoring and spend analytics.',
    `contract_tier` STRING COMMENT 'Pricing tier classification for the vendors GPO or direct contract. Tier 1 vendors receive the most favorable pricing. Sole source vendors are the only approved supplier for a specific item.. Valid values are `tier_1|tier_2|tier_3|sole_source|non_contract`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the vendors primary business address. Used for import/export compliance, customs documentation, and international procurement.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor master record was first created in the system. Used for audit trail, data lineage, and compliance with HIPAA and SOC 2 record-keeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the vendors invoicing currency (e.g., USD, CAD, EUR). Used for multi-currency procurement and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `dea_registration_number` STRING COMMENT 'DEA registration number for vendors authorized to distribute controlled substances (Schedule I–V). Required for pharmaceutical wholesalers and specialty pharmacy distributors. Nullable for non-pharmaceutical vendors.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `diversity_certification_expiration_date` DATE COMMENT 'Date on which the vendors diversity certification expires. Supply chain teams must track this to ensure continued compliance with diversity spend reporting requirements.',
    `diversity_certification_number` STRING COMMENT 'Certification number issued by the relevant diversity certifying body (e.g., NMSDC, WBENC, SBA). Used to validate diversity status during supplier diversity reporting.',
    `diversity_classification` STRING COMMENT 'Diversity certification classification for the vendor per federal and state supplier diversity programs. Used for regulatory reporting on diverse spend and compliance with CMS and HHS supplier diversity initiatives.. Valid values are `minority_owned|woman_owned|veteran_owned|small_business|lgbtq_owned|none`',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the vendor operates, if different from the legal name. Commonly used in vendor communications and catalog references.',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the vendor supports Electronic Data Interchange (EDI) for purchase order transmission (EDI 850), invoice processing (EDI 810), and advance ship notices (EDI 856).',
    `fda_establishment_number` STRING COMMENT 'FDA-assigned establishment registration number for vendors who manufacture, repackage, or relabel medical devices or drugs. Required for device and pharmaceutical manufacturers per FDA 21 CFR Part 807.. Valid values are `^[0-9]{7}$`',
    `fill_rate` DECIMAL(18,2) COMMENT 'Percentage of ordered line items fulfilled completely by the vendor without backorder or substitution. Critical metric for supply continuity and par-level replenishment reliability.',
    `gpo_affiliation` STRING COMMENT 'Name of the Group Purchasing Organization (GPO) through which this vendor holds a contract (e.g., Vizient, Premier, HealthTrust). GPO affiliation determines contract pricing tiers and compliance requirements.',
    `gpo_contract_number` STRING COMMENT 'Contract number assigned by the GPO for the vendors pricing agreement. Used to validate contract compliance during purchase order creation and invoice matching.',
    `insurance_certificate_number` STRING COMMENT 'Certificate of insurance number evidencing the vendors general liability, product liability, and workers compensation coverage. Required for vendor credentialing and contract compliance.',
    `insurance_expiration_date` DATE COMMENT 'Date on which the vendors insurance certificate expires. Supply chain and compliance teams must track this to ensure continuous coverage and prevent lapsed vendor access.',
    `lead_time_days` STRING COMMENT 'Standard number of calendar days from purchase order placement to expected delivery for this vendor. Used in par-level replenishment calculations and inventory safety stock planning.',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'Minimum dollar value required per purchase order for this vendor. Orders below this threshold may incur handling fees or be rejected. Used in procurement workflow validation.',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor organization as registered with the state or federal government. Used for contract execution, purchase orders, and regulatory filings.',
    `npi` STRING COMMENT '10-digit National Provider Identifier assigned by CMS to vendors who are also healthcare providers (e.g., pharmacy chains, home health agencies). Nullable for non-provider vendors.. Valid values are `^[0-9]{10}$`',
    `number` STRING COMMENT 'Externally-known alphanumeric vendor code assigned by the healthcare organizations procurement system (SAP MM or Infor Lawson). Used on purchase orders, invoices, and remittance documents.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `oig_excluded_flag` BOOLEAN COMMENT 'Indicates whether the vendor is currently listed on the OIG List of Excluded Individuals/Entities (LEIE) or SAM.gov exclusion list. Excluded vendors must not be used for federally-funded programs.',
    `oig_exclusion_checked_date` DATE COMMENT 'Most recent date on which the vendor was verified against the OIG List of Excluded Individuals/Entities (LEIE) and SAM.gov exclusion database. Required for CMS compliance and fraud prevention.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the confirmed delivery date. Key performance indicator (KPI) for vendor scorecard and contract compliance monitoring.',
    `payment_method` STRING COMMENT 'Method by which the healthcare organization remits payment to the vendor. ACH and EFT are preferred for efficiency. Drives accounts payable processing in SAP FI.. Valid values are `ach|check|wire|virtual_card|eft`',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Drives accounts payable scheduling and early payment discount capture in SAP FI.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Composite performance score (0.00–5.00) assigned to the vendor based on on-time delivery, fill rate, quality, and responsiveness metrics. Used in vendor scorecards and sourcing decisions.',
    `postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the vendors primary business address. Used for geographic segmentation, freight zone determination, and tax jurisdiction.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor has been designated as a preferred supplier by the healthcare organizations value analysis committee or supply chain leadership. Preferred vendors receive priority in sourcing decisions.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor account representative. Used for purchase order transmission, invoice correspondence, and contract communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary account representative or sales contact at the vendor organization. Used for procurement communications, contract negotiations, and issue escalation.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the primary vendor account representative. Used for order inquiries, delivery coordination, and urgent supply chain communications.. Valid values are `^+?[0-9-() ]{7,20}$`',
    `punchout_catalog_url` STRING COMMENT 'URL for the vendors cXML punchout catalog integration, enabling procurement staff to browse and order directly from the vendors online catalog within the ERP system (SAP MM or Infor Lawson).. Valid values are `^https?://.+$`',
    `recall_notification_flag` BOOLEAN COMMENT 'Indicates whether the vendor is enrolled to receive FDA product recall notifications and safety alerts. Critical for medical device and pharmaceutical recall management per FDA requirements.',
    `remittance_email` STRING COMMENT 'Email address designated by the vendor for receipt of Electronic Remittance Advice (ERA) and payment notifications. Used in accounts payable processing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `state_code` STRING COMMENT 'Two-letter US state or territory code for the vendors primary business address. Used for tax jurisdiction, state licensing verification, and regulatory compliance.. Valid values are `^[A-Z]{2}$`',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor record. Active vendors are approved for purchasing. Blocked vendors are temporarily restricted. Debarred vendors are excluded per OIG or SAM.gov exclusion lists.. Valid values are `active|inactive|pending_approval|suspended|blocked|debarred`',
    `tax_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number (TIN) assigned by the IRS. Required for 1099 reporting, contract execution, and financial compliance.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `vendor_type` STRING COMMENT 'Classification of the vendors role in the supply chain. Distinguishes manufacturers (produce devices/drugs), distributors (resell/warehouse), GPO prime vendors, pharmacy wholesalers, service providers, and consultants. [ENUM-REF-CANDIDATE: manufacturer|distributor|gpo_prime_vendor|pharmacy_wholesaler|service_provider|consultant|sole_source|specialty_distributor — promote to reference product]. Valid values are `manufacturer|distributor|gpo_prime_vendor|pharmacy_wholesaler|service_provider|consultant`',
    `udi_capable_flag` BOOLEAN COMMENT 'Indicates whether the vendor supports Unique Device Identifier (UDI) data transmission on invoices and advance ship notices. Required for implantable device tracking per FDA UDI Rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor master record was most recently modified. Used for change tracking, data synchronization between SAP MM and Infor Lawson, and audit compliance.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers, distributors, and manufacturers providing medical supplies, devices, and pharmaceuticals to the healthcare organization. Captures vendor identity, NPI (if applicable), DEA registration, GPO (Group Purchasing Organization) affiliation, contract tier, diversity classification, preferred vendor status, and performance rating. Integrates with SAP MM Vendor Master and Infor Lawson Vendor file.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique surrogate identifier for the purchase order record in the healthcare supply chain data platform. Primary key for the purchase_order data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Healthcare procurement requires tracking the purchasing agent/buyer for each PO to support approval workflows, audit trails, spend analysis by buyer, performance metrics, and accountability for contra',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) that issued this purchase order. Used for facility-level spend reporting and budget allocation.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Purchase orders must post to specific GL accounts for expense recognition and financial reporting. Currently has gl_account_code as text. FK to chart_of_accounts enables proper financial integration, ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: POs are created and approved within fiscal periods for budget period tracking, commitment accounting, and period-end open PO accrual reporting. Essential for budget vs. actual analysis.',
    `inventory_location_id` BIGINT COMMENT 'Reference to the specific delivery location (warehouse, storeroom, department, or clinical unit) where ordered goods are to be received. May differ from the ordering facility.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: When purchasing high-cost implantable devices or capital equipment, healthcare organizations track which payer will reimburse to ensure coverage compliance. Real business process: capital equipment pu',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the vendor contract or Group Purchasing Organization (GPO) contract under which this purchase order is issued. Supports contract compliance validation and pricing verification.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor (supplier) from whom goods or services are being procured. Links to the vendor master record for contract compliance and spend analytics.',
    `actual_delivery_date` DATE COMMENT 'The date on which goods were physically received at the ship-to location. Used to calculate vendor on-time delivery rate and actual lead time versus requested lead time.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the purchase order. Distinct from overall PO status — captures the authorization state within the procurement approval chain (e.g., department head, CFO, supply chain director).. Valid values are `pending|approved|rejected|escalated`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order received final procurement approval. Used for approval cycle time analysis and audit trail compliance.',
    `budget_year` STRING COMMENT 'The fiscal year against which this purchase order is budgeted and encumbered. Used for annual budget consumption tracking and year-end financial close processes.',
    `cancellation_reason` STRING COMMENT 'Business reason for cancellation of the purchase order (e.g., duplicate order, vendor unable to fulfill, product recall, budget freeze). Populated only when po_status is cancelled. Used for procurement analytics and process improvement.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the vendor in response to the purchase order. Compared against requested_delivery_date to measure vendor on-time delivery performance.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the purchase order expenditure is allocated. Used for departmental budget tracking, financial reporting, and cost accounting in SAP FI/CO.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order record was first created in the source procurement system. Used for audit trail, data lineage, and procurement cycle time measurement.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this purchase order (e.g., USD for US Dollar). Supports multi-currency procurement for international medical device vendors.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the purchase order, including GPO contract discounts, volume rebates, and negotiated price reductions. Reduces gross amount to arrive at net order value.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Total freight and shipping charges associated with the purchase order. Captured separately to support freight cost analysis and vendor freight term compliance.',
    `freight_terms_code` STRING COMMENT 'Incoterms or freight terms code defining responsibility for shipping costs and risk of loss during transit (e.g., FOB Origin, FOB Destination). Impacts cost allocation and liability.. Valid values are `FOB_ORIGIN|FOB_DESTINATION|PREPAID|COLLECT|PREPAID_ADD`',
    `fulfillment_status` STRING COMMENT 'Current goods receipt fulfillment status of the purchase order. Tracks whether ordered quantities have been partially or fully received at the ship-to location. Drives open order reporting and expediting.. Valid values are `open|partially_fulfilled|fully_fulfilled|over_received|cancelled`',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account code for financial posting of the purchase order. Determines how the procurement expense is classified in the chart of accounts (e.g., medical supplies, capital equipment).',
    `gpo_contract_number` STRING COMMENT 'The Group Purchasing Organization (GPO) contract number under which this purchase order is placed (e.g., Vizient, Premier, HealthTrust). Used to validate contract compliance and capture GPO-negotiated pricing.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross value of the purchase order before discounts, taxes, and freight charges. Sum of all line item extended prices. Used for budget encumbrance and spend analytics.',
    `invoice_status` STRING COMMENT 'Current invoicing status of the purchase order from the vendor. Tracks whether vendor invoices have been received and matched against the PO. Supports accounts payable aging and cash flow forecasting.. Valid values are `not_invoiced|partially_invoiced|fully_invoiced|disputed`',
    `is_capital_expenditure` BOOLEAN COMMENT 'Indicates whether this purchase order is classified as a capital expenditure (CapEx) for medical equipment or facility assets, as opposed to an operating expenditure (OpEx) for consumable supplies. Drives fixed asset creation workflow.',
    `is_contract_compliant` BOOLEAN COMMENT 'Indicates whether this purchase order was placed in compliance with an active vendor contract or GPO agreement. Non-compliant orders (maverick spend) are flagged for supply chain compliance review.',
    `is_emergency_order` BOOLEAN COMMENT 'Indicates whether this purchase order was issued as an emergency procurement, bypassing standard approval workflows due to urgent patient care or operational need. Triggers post-hoc review and compliance reporting.',
    `line_item_count` STRING COMMENT 'Total number of line items (distinct products or services) included in this purchase order. Used for order complexity analysis and procurement workload metrics.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total net value of the purchase order after discounts, plus taxes and freight. Represents the total financial obligation to the vendor. Used for three-way match invoice validation and budget reporting.',
    `notes` STRING COMMENT 'Free-text notes or special instructions associated with the purchase order, such as delivery instructions, handling requirements for sterile or temperature-sensitive medical supplies, or vendor communication notes.',
    `order_date` DATE COMMENT 'The business date on which the purchase order was formally created and issued. Used as the principal business event date for procurement reporting, aging analysis, and contract compliance.',
    `payment_terms_code` STRING COMMENT 'Vendor payment terms code specifying the due date and early payment discount conditions (e.g., NET30, 2/10NET30). Drives accounts payable scheduling and cash flow management.',
    `po_number` STRING COMMENT 'Externally-known, human-readable purchase order number assigned by the procurement system (SAP MM or Infor Lawson). Used in three-way match (PO → goods receipt → invoice) and vendor communications.. Valid values are `^PO-[0-9]{10}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Tracks progression from draft creation through approval, transmission to vendor, goods receipt, and final closure or cancellation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|sent|partially_received|fully_received|closed|cancelled — promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order by procurement strategy. Standard: one-time order; Blanket: pre-negotiated volume agreement; Emergency: urgent unplanned procurement; Standing: recurring scheduled order; Consignment: vendor-managed inventory at facility.. Valid values are `standard|blanket|emergency|standing|consignment`',
    `purchasing_group_code` STRING COMMENT 'SAP MM purchasing group code identifying the buyer or procurement team responsible for this purchase order. Used for buyer workload analysis and accountability reporting.',
    `purchasing_org_code` STRING COMMENT 'SAP MM purchasing organization code representing the organizational unit responsible for procurement activities. Defines the legal and contractual entity issuing the purchase order.',
    `requested_delivery_date` DATE COMMENT 'The date by which the ordering facility requires the goods to be delivered. Used for vendor performance measurement, lead time analysis, and par-level replenishment planning.',
    `source_system_code` STRING COMMENT 'Identifies the operational source system from which this purchase order record was extracted (e.g., SAP MM, Infor Lawson). Supports data lineage tracking and multi-system reconciliation in the lakehouse.. Valid values are `SAP_MM|INFOR_LAWSON|MEDITECH|MANUAL`',
    `source_system_po_key` STRING COMMENT 'The native primary key or document number of this purchase order in the originating source system (SAP MM EKKO-EBELN or Infor Lawson PO number). Enables back-tracing to the system of record for reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charges applied to the purchase order (e.g., sales tax, use tax on taxable medical supplies). May be zero for tax-exempt healthcare organizations.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process validating alignment between the purchase order, goods receipt, and vendor invoice. Exceptions trigger accounts payable holds and supply chain investigation.. Valid values are `pending|matched|exception|waived`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order record was last modified in the source procurement system. Supports change tracking, audit compliance, and incremental ETL processing.',
    `vendor_quote_number` STRING COMMENT 'The vendor-assigned quotation or bid reference number associated with this purchase order. Used to trace back to the original vendor quote for price verification and contract compliance.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Transactional record of all procurement purchase orders issued to vendors for medical-surgical supplies, devices, and equipment. Captures PO number, vendor reference, vendor contract reference, ordering facility, ship-to location, order date, requested delivery date, total value, approval status, PO type (standard, blanket, emergency, standing), GPO contract reference, freight terms, payment terms, and fulfillment status. Supports three-way match (PO → goods receipt → invoice) and contract compliance validation. Sourced from SAP MM Purchase Orders and Infor Lawson Procurement module.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Unique surrogate identifier for each purchase order line item within the healthcare supply chain. Primary key for this entity in the Databricks Silver Layer.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) that is the delivery destination and consuming entity for this line item. Supports multi-facility procurement analytics and facility-level spend reporting.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: PO lines require GL account assignment for expense classification, automated journal entry posting, and financial statement reporting. Essential for procure-to-pay financial integration and month-end ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Surgical and procedural supply orders often reference specific CPT codes to ensure correct items are ordered for scheduled procedures. Enables procedure-specific supply cost analysis and contract comp',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: PO lines charged to restricted funds enable grant compliance, fund balance checking at PO approval, and restricted fund expenditure tracking. Required for grant-funded research and donor-restricted pu',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: DME and billable supply orders use HCPCS codes for reimbursement tracking and payer compliance. Critical for revenue cycle matching supply costs to billable codes and ensuring formulary compliance.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the item being ordered. Links to the supply domain material catalog, enabling item-level procurement analytics and inventory reconciliation. [RESOURCE_REFERENCE — TRANSACTION_LINE role minimum category]',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header to which this line belongs. Establishes the header-detail relationship for line-level procurement tracking. [HEADER_REFERENCE — TRANSACTION_LINE role minimum category]',
    `requisition_id` BIGINT COMMENT 'Reference to the originating purchase requisition that generated this purchase order line. Enables traceability from clinical or departmental demand through procurement to fulfillment.',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the supply contract or group purchasing organization (GPO) agreement governing the pricing and terms for this line item. Enables contract compliance and off-contract spend detection.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor (supplier) fulfilling this line item. Supports vendor performance analysis, spend analytics, and contract compliance tracking at the line level.',
    `approval_status` STRING COMMENT 'The approval workflow status for this purchase order line, particularly relevant for high-value items, capital equipment, non-formulary items, or off-contract purchases requiring additional authorization.. Valid values are `pending|approved|rejected|not_required`',
    `approved_by` STRING COMMENT 'The name or identifier of the individual who approved this purchase order line. Supports audit trail requirements, segregation of duties compliance, and procurement governance.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line was approved. Provides an audit trail for procurement governance, segregation of duties compliance, and approval cycle time analytics.',
    `backorder_quantity` DECIMAL(18,2) COMMENT 'The quantity of this line item that the vendor has placed on backorder due to stock unavailability. Critical for supply chain risk management, clinical supply continuity planning, and substitute item sourcing.',
    `cancelled_quantity` DECIMAL(18,2) COMMENT 'The quantity of this line item that has been cancelled and will not be fulfilled. Supports open order management, budget release, and vendor communication for partial cancellations.',
    `cost_center_code` STRING COMMENT 'The financial cost center to which the expense for this line item is allocated. Enables departmental spend tracking, budget variance analysis, and cost accounting within the healthcare organizations financial system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was first created in the source system. Supports audit trail, data lineage, and procurement cycle time measurement.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary amounts on this line (e.g., USD). Supports multi-currency procurement for international vendors and foreign-sourced medical supplies.. Valid values are `^[A-Z]{3}$`',
    `discount_percent` DECIMAL(18,2) COMMENT 'The percentage discount applied to the unit price for this line item, as negotiated in the vendor contract or GPO agreement. Used for net price calculation, contract compliance reporting, and savings tracking.',
    `expense_type` STRING COMMENT 'Classification of the line item expenditure as direct patient care supply, indirect supply, capital equipment, research, or administrative. Used for cost accounting, departmental charge allocation, and financial reporting under GAAP.. Valid values are `direct_patient_care|indirect|capital|research|administrative`',
    `expiration_date` DATE COMMENT 'The manufacturer-assigned expiration date for the ordered item. Used for expiration tracking, FEFO (First Expired First Out) inventory management, and compliance with Joint Commission and FDA requirements for expired product management.',
    `extended_amount` DECIMAL(18,2) COMMENT 'The total monetary value of this line item, calculated as ordered quantity multiplied by unit price. Represents the financial commitment for this line and is used for purchase order value reporting, budget encumbrance, and accounts payable matching.',
    `freight_amount` DECIMAL(18,2) COMMENT 'The freight or shipping charge allocated to this purchase order line item. Used for total landed cost calculation, vendor freight compliance, and supply chain cost analytics.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this line items expense is posted in the financial system. Supports financial reporting, audit trails, and integration between supply chain and the SAP S/4HANA FI module.',
    `gpo_contract_number` STRING COMMENT 'The contract number from the Group Purchasing Organization (GPO) agreement under which this item is being procured. Enables GPO compliance reporting, rebate tracking, and contract utilization analytics.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of this line item that has been invoiced by the vendor. Used for three-way match processing, accounts payable reconciliation, and detection of invoice quantity discrepancies.',
    `is_contract_item` BOOLEAN COMMENT 'Indicates whether this line item is purchased under an active vendor contract or GPO (Group Purchasing Organization) agreement. Used to identify off-contract spend and measure contract compliance rates.',
    `is_formulary_item` BOOLEAN COMMENT 'Indicates whether this line item is an approved formulary item (pharmaceutical or supply) within the healthcare organizations approved product list. Non-formulary items may require additional approval workflows.',
    `is_recall_active` BOOLEAN COMMENT 'Indicates whether the item on this purchase order line is currently subject to an active FDA or manufacturer recall. Triggers procurement holds, receiving alerts, and recall management workflows to protect patient safety.',
    `item_category` STRING COMMENT 'Classification of the ordered item into a supply category. Drives procurement routing, budget coding, regulatory handling (e.g., implant tracking, DEA scheduling), and spend analytics by category. [ENUM-REF-CANDIDATE: med_surg|pharmaceutical|implant|capital_equipment|reagent|linen|dietary|office|other — promote to reference product]',
    `item_description` STRING COMMENT 'Free-text description of the medical-surgical supply, implantable device, pharmaceutical, or other material item being ordered. Sourced from the material master or vendor catalog and used for procurement documentation and receiving verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was most recently updated in the source system. Used for change tracking, data synchronization, and incremental ETL processing in the Databricks Silver Layer.',
    `line_number` STRING COMMENT 'Sequential line number identifying the position of this item within the parent purchase order. Used for ordering, display, and reference in procurement documents and EDI transactions. [LINE_SEQUENCE — TRANSACTION_LINE role minimum category]',
    `line_status` STRING COMMENT 'Current workflow status of the purchase order line item. Tracks the lifecycle from open order through receipt, closure, or cancellation. Drives procurement dashboards and open order reporting. [LIFECYCLE_STATUS — TRANSACTION_LINE role minimum category]. Valid values are `open|partially_received|fully_received|cancelled|closed|on_hold`',
    `line_type` STRING COMMENT 'Classifies the procurement mechanism for this line item. Standard lines represent direct purchases; blanket releases draw against a blanket PO; consignment lines track vendor-owned inventory; drop-ship lines are delivered directly to a patient or department.. Valid values are `standard|blanket_release|consignment|drop_ship|service|return`',
    `lot_number` STRING COMMENT 'Manufacturers lot or batch number for the ordered item. Critical for recall management, expiration tracking, and traceability of medical-surgical supplies and pharmaceuticals per FDA and Joint Commission requirements.',
    `ndc_code` STRING COMMENT 'National Drug Code identifying the specific pharmaceutical product, dosage form, and package size when this line item is a drug or pharmaceutical supply. Required for pharmacy procurement, formulary management, and DEA controlled substance tracking.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of the item requested on this purchase order line, expressed in the lines unit of measure. Represents the original procurement intent and is used for receipt matching, backorder tracking, and spend commitment calculations. [LINE_QUANTITY — TRANSACTION_LINE role minimum category]',
    `promised_delivery_date` DATE COMMENT 'The date the vendor has committed to delivering this line item to the ordering facility. Used for supply chain planning, par-level replenishment scheduling, and vendor on-time delivery performance measurement.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of this line item that has been physically received and confirmed at the facility receiving dock. Used for three-way match (PO-receipt-invoice), backorder calculation, and inventory replenishment confirmation.',
    `requested_delivery_date` DATE COMMENT 'The date the ordering department or facility requested delivery of this line item. May differ from the promised delivery date when vendor lead times exceed clinical or operational needs.',
    `ship_to_location_code` STRING COMMENT 'The specific delivery location code (e.g., central receiving dock, pharmacy, OR suite, storeroom) within the facility where this line item is to be delivered. Supports receiving workflow routing and departmental delivery management.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this purchase order line was sourced (e.g., Infor Lawson, SAP S/4HANA MM, MEDITECH). Supports data lineage, multi-system reconciliation, and ETL audit in the Databricks Silver Layer.. Valid values are `LAWSON|SAP_MM|MEDITECH|MANUAL`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The applicable tax amount for this purchase order line item. Supports accounts payable processing, tax reporting, and financial reconciliation for taxable supply purchases.',
    `udi` STRING COMMENT 'FDA-mandated Unique Device Identifier for implantable devices and high-risk medical equipment ordered on this line. Enables device tracking, recall management, and compliance with FDA UDI regulations (21 CFR Part 830). Populated for Class II and Class III medical devices.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the ordered quantity is expressed (e.g., EA=Each, CS=Case, BX=Box, PK=Pack, VI=Vial, BT=Bottle). Governs quantity interpretation for receiving, inventory, and invoice matching. [ENUM-REF-CANDIDATE: EA|CS|BX|PK|DZ|VI|BT|KG|LB|ML|L — 11 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The contracted or negotiated price per unit of measure for this line item, as agreed with the vendor or per the applicable GPO/contract. Used for extended amount calculation, invoice matching, and contract compliance validation. [LINE_VALUE_OR_RESULT — TRANSACTION_LINE role minimum category]',
    `vendor_item_number` STRING COMMENT 'The vendors own catalog or part number for the item being ordered. Used for order transmission to the vendor, EDI matching, and vendor invoice reconciliation.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Line-item detail for each purchase order, representing individual material items ordered from a vendor. Captures line number, material master reference, ordered quantity, unit of measure, unit price, extended amount, promised delivery date, received quantity, and line status. Enables granular tracking of item-level procurement activity and receipt matching.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique surrogate identifier for the goods receipt record in the healthcare supply chain lakehouse. Primary key for this transactional entity.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Patient-specific implant receipts linked to the clinical order awaiting the device (e.g., custom knee implant arrives for scheduled surgery). Enables order-to-receipt workflow and surgical scheduling ',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where the goods were physically received and inventoried.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Goods receipts post to inventory or expense GL accounts for real-time inventory valuation, COGS calculation, and received-not-invoiced accrual processing. Critical for three-way match and financial cl',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Goods receipts must be assigned to fiscal periods for period-end cutoff, inventory valuation timing, received-not-invoiced accrual accuracy, and financial close processes. Critical for matching princi',
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.hipaa_privacy_incident. Business justification: Receipt of patient-specific items (custom orthotics, patient-labeled medications) delivered to wrong location triggers privacy incidents. Privacy officers investigate goods receipt errors that expose ',
    `inventory_location_id` BIGINT COMMENT 'Reference to the specific storage location, warehouse bin, or department within the facility where goods were received (e.g., central supply, pharmacy, OR storeroom).',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: goods_receipt has material_number and item_description which are authoritative attributes of material_master. Each goods receipt line receives a specific material item. This is standard N:1 relationsh',
    `employee_id` BIGINT COMMENT 'Reference to the supply chain or materials management employee who physically received and documented the goods. Required for accountability, audit trail, and Joint Commission receiving documentation standards.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt was posted. Enables three-way match (PO, goods receipt, invoice) for accounts payable processing in Revenue Cycle Management (RCM).',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order_line. Business justification: goods_receipt is the physical receipt event against a specific PO line item. Line-to-header rule applies - goods_receipt should link to purchase_order_line (not just purchase_order header) for traceab',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier who shipped the goods. Used for vendor performance tracking, recall management, and accounts payable matching.',
    `condition_on_receipt` STRING COMMENT 'The physical condition of the goods as assessed by the receiving staff at time of delivery. Drives quality hold, vendor return, or discrepancy workflow initiation. damaged or contaminated triggers a quality block in inventory.. Valid values are `acceptable|damaged|partial|contaminated|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this goods receipt record was first created in the source system. Used for audit trail and data lineage in the lakehouse Silver layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary values on this goods receipt (e.g., USD). Required for multi-currency environments and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The vendors packing slip or delivery note number accompanying the shipment. Used for three-way match (purchase order, delivery note, invoice) and discrepancy resolution with the vendor.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified between the purchase order, delivery note, and actual goods received (quantity, item, condition, or pricing mismatch). When True, triggers a discrepancy resolution workflow and may block accounts payable posting.',
    `discrepancy_notes` STRING COMMENT 'Free-text description of the discrepancy observed at receipt, entered by the receiving staff. Provides context for vendor dispute resolution, accounts payable hold, and quality management follow-up.',
    `discrepancy_type` STRING COMMENT 'Categorizes the nature of the discrepancy identified at receipt: quantity variance, wrong item delivered, price mismatch against purchase order, unacceptable condition, or missing documentation. Populated only when discrepancy_flag is True.. Valid values are `quantity|item_mismatch|price|condition|documentation`',
    `expiration_date` DATE COMMENT 'The manufacturer-assigned expiration or use-by date for the received goods. Critical for par-level replenishment, FEFO (First Expired First Out) inventory management, and preventing use of expired medical supplies per Joint Commission standards.',
    `implantable_device_flag` BOOLEAN COMMENT 'Indicates whether the received item is an implantable medical device subject to FDA UDI scanning requirements and implant registry tracking (e.g., orthopedic implants, cardiac devices, vascular grafts). Drives UDI capture workflow.',
    `inventory_update_flag` BOOLEAN COMMENT 'Indicates whether the goods receipt has successfully triggered an inventory quantity update in the warehouse management system. False may indicate a posting error or quality block preventing inventory movement.',
    `lot_number` STRING COMMENT 'Manufacturers lot or batch number assigned to the received goods. Critical for recall management, expiration tracking, and traceability of medical-surgical supplies and implantable devices per FDA requirements.',
    `manufacture_date` DATE COMMENT 'The date on which the goods were manufactured, as indicated on the product label or UDI barcode. Used for shelf-life calculation, quality assurance, and FDA UDI traceability.',
    `movement_type` STRING COMMENT 'The SAP MM or Infor Lawson inventory movement type code classifying the nature of the goods receipt transaction (e.g., SAP movement type 101=GR for PO, 122=Return to Vendor, 161=GR for Returns). Drives accounting document generation and inventory valuation. [ENUM-REF-CANDIDATE: 101|122|161|501|521|531 — promote to reference product]',
    `plant_code` STRING COMMENT 'The SAP plant code or Infor Lawson site code representing the organizational unit (hospital campus, distribution center) where the goods receipt is posted. Used for inventory segmentation and financial posting to the correct cost center.',
    `posting_timestamp` TIMESTAMP COMMENT 'The exact date and time the goods receipt was posted in the ERP system (SAP MIGO or Infor Lawson), triggering inventory update and accounts payable liability. Distinct from the physical receipt date.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of goods specified on the originating purchase order line. Used to calculate over/under receipt discrepancies and to support three-way match for accounts payable.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The actual quantity of goods physically received and accepted at the receiving dock. Compared against the purchase order quantity and delivery note quantity for three-way match and discrepancy detection.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether the received lot or item has been subsequently identified as subject to an FDA or manufacturer recall. When True, triggers recall management workflow to quarantine and return affected inventory.',
    `recall_reference_number` STRING COMMENT 'The FDA or manufacturer-assigned recall identification number associated with this goods receipt when a recall has been issued. Populated only when recall_flag is True. Supports regulatory reporting to FDA and OIG.',
    `receipt_date` DATE COMMENT 'The calendar date on which the physical receipt of goods occurred at the receiving dock. This is the principal business event date used for inventory valuation, expiration tracking, and accounts payable aging.',
    `receipt_number` STRING COMMENT 'Externally-known business identifier for this goods receipt document, corresponding to the SAP MIGO material document number or Infor Lawson receiving document number. Used in three-way match and audit trails.. Valid values are `^GR-[0-9]{10}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle state of the goods receipt document. posted indicates inventory has been updated; reversed indicates a cancellation posting; blocked indicates a quality or discrepancy hold pending resolution.. Valid values are `draft|posted|reversed|blocked|closed`',
    `serial_number` STRING COMMENT 'Manufacturers serial number for serialized items such as capital equipment, durable medical devices, or high-value implants. Supports individual asset tracking and FDA UDI compliance.',
    `source_document_number` STRING COMMENT 'The native document number from the source system (e.g., SAP material document number from MIGO, or Infor Lawson receiving document number). Enables traceability back to the originating system for audit and reconciliation.',
    `sterile_processing_required` BOOLEAN COMMENT 'Indicates whether the received item requires sterile processing or reprocessing before clinical use. When True, routes the item to the Sterile Processing Department (SPD) workflow rather than direct inventory stocking.',
    `storage_condition` STRING COMMENT 'Required storage condition for the received goods as specified by the manufacturer (e.g., refrigerated for biologics and vaccines, frozen for certain pharmaceuticals, ambient for standard medical-surgical supplies). Drives putaway routing in the warehouse.. Valid values are `ambient|refrigerated|frozen|controlled_room_temp|flammable`',
    `temperature_excursion_flag` BOOLEAN COMMENT 'Indicates whether a temperature excursion was detected during transit or at receipt for cold-chain items (vaccines, biologics, temperature-sensitive pharmaceuticals). When True, triggers quality review and potential rejection per cold-chain management protocols.',
    `three_way_match_status` STRING COMMENT 'Current status of the three-way match process between the purchase order, goods receipt, and vendor invoice. matched enables accounts payable payment; exception indicates a variance requiring resolution before payment release.. Valid values are `pending|matched|exception|cleared`',
    `total_receipt_value` DECIMAL(18,2) COMMENT 'The total monetary value of goods received, calculated as quantity received multiplied by unit cost. Used to post the goods receipt liability in accounts payable and for inventory valuation in SAP FI/CO.',
    `udi_device_identifier` STRING COMMENT 'The FDA-mandated Unique Device Identifier (UDI) Device Identifier (DI) portion scanned from the device label barcode (GS1, HIBCC, or ICCBBA format) for implantable and Class II/III medical devices. Required for FDA UDI compliance and implant registry reporting.',
    `udi_production_identifier` STRING COMMENT 'The FDA-mandated Unique Device Identifier (UDI) Production Identifier (PI) portion containing lot/batch number, serial number, manufacturing date, and/or expiration date as encoded on the device label. Complements the UDI Device Identifier for full UDI compliance.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The contracted or invoice unit cost per unit of measure for the received item. Used for inventory valuation, three-way match, and cost accounting in SAP FI/CO. Classified confidential as it reflects negotiated contract pricing.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., EA=Each, BX=Box, CS=Case, PK=Pack, BT=Bottle, VI=Vial). Aligns with SAP base unit of measure and Infor Lawson stocking unit. [ENUM-REF-CANDIDATE: EA|BX|CS|PK|BT|VI|DZ|TU|KG|LT — promote to reference product]. Valid values are `EA|BX|CS|PK|BT|VI`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this goods receipt record was last modified in the source system (e.g., reversal, correction, or status change). Supports incremental Extract Transform Load (ETL) processing.',
    `vendor_invoice_number` STRING COMMENT 'The vendors invoice number associated with this shipment, if provided at time of receipt. Supports early three-way match initiation and accounts payable processing in SAP FI.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of medical supplies and devices against a purchase order. Records receipt date, receiving location, received quantities, lot numbers, expiration dates, UDI scan data for implantable devices, condition on receipt, and discrepancy flags. Triggers inventory update and three-way match for accounts payable. Sourced from SAP MM Goods Receipt (MIGO) and Infor Lawson Receiving.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` (
    `inventory_location_id` BIGINT COMMENT 'Unique surrogate identifier for each physical or logical inventory storage location within the healthcare supply chain. Primary key for this master record.',
    `building_id` BIGINT COMMENT 'FK to facility.building',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where this inventory location physically resides. Links to the facility master record.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `equipment_asset_id` BIGINT COMMENT 'Unique device identifier for the Automated Dispensing Cabinet (ADC) unit (e.g., Pyxis MedStation, Omnicell) associated with this location. Populated only when location_type is adc. Used for device-level inventory reconciliation and audit trail.',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical or operational department (e.g., ICU, OR, ED, Pharmacy) that owns or primarily uses this inventory location. Drives cost allocation and par-level management.',
    `osha_safety_program_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_safety_program. Business justification: Storage locations must comply with OSHA safety programs (hazmat storage, temperature monitoring, controlled substance security). Safety officers audit locations against program requirements for inspec',
    `parent_location_inventory_location_id` BIGINT COMMENT 'Self-referencing identifier to the parent inventory location in a location hierarchy (e.g., a bin within a storeroom, a storeroom within a facility warehouse). Supports hierarchical location structures for reporting and replenishment rollup.',
    `access_restriction_level` STRING COMMENT 'Physical and system access control level for this location. Drives security configuration in ADC systems, badge access systems, and EHR supply dispensing workflows. Controlled substance locations require dual-key or pharmacist-only access per DEA regulations.. Valid values are `unrestricted|badge_access|dual_key|pharmacist_only|supervisor_override`',
    `adc_manufacturer` STRING COMMENT 'Manufacturer of the Automated Dispensing Cabinet (ADC) installed at this location. Used for maintenance scheduling, vendor management, and integration configuration with pharmacy systems.. Valid values are `BD_Pyxis|Omnicell|Capsa|Aesynt|other`',
    `bin_aisle` STRING COMMENT 'Aisle designation within the storage location (e.g., A, B, 01). Used in warehouse management and central storeroom operations to direct pickers to the correct aisle.',
    `bin_shelf` STRING COMMENT 'Shelf or rack level within the aisle for this storage location. Combined with bin_aisle, provides the precise bin address for pick-and-put-away operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory location master record was first created in the system. Supports data lineage, audit trail, and compliance with HIPAA Security Rule audit control requirements.',
    `cycle_count_frequency` STRING COMMENT 'Scheduled frequency for physical inventory cycle counts at this location. Drives the cycle count calendar in the materials management system. High-value or controlled substance locations typically require more frequent counts per Joint Commission and DEA requirements.. Valid values are `daily|weekly|monthly|quarterly|annual|continuous`',
    `deactivation_date` DATE COMMENT 'Date on which this inventory location was or is scheduled to be deactivated or decommissioned. Nullable for currently active locations. Supports historical analysis and facility transition planning.',
    `effective_date` DATE COMMENT 'Date on which this inventory location became or is scheduled to become operationally active. Used for location lifecycle management, historical reporting, and integration with facility opening/renovation projects.',
    `expiration_tracking_enabled` BOOLEAN COMMENT 'Indicates whether expiration date tracking is enforced for items stored at this location. When true, the system monitors item expiration dates and generates alerts for items approaching or past expiration, supporting patient safety and regulatory compliance.',
    `floor_number` STRING COMMENT 'Floor or level within the building where the inventory location is situated. Used for delivery routing, pick-path optimization, and emergency supply logistics.',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account code to which supply expenses from this location are posted. Supports financial reporting, cost allocation, and budget variance analysis per GAAP and FASB standards.. Valid values are `^[0-9-]{5,20}$`',
    `hazardous_material_storage` BOOLEAN COMMENT 'Indicates whether this location is approved for storage of hazardous materials including chemotherapy agents, flammable chemicals, or OSHA-regulated hazardous substances. Drives compliance with OSHA Hazard Communication Standard and EPA regulations.',
    `humidity_controlled` BOOLEAN COMMENT 'Indicates whether this location has active humidity control. Required for certain medical supplies, sterile packaging, and pharmaceutical products sensitive to moisture per FDA and USP storage standards.',
    `last_cycle_count_date` DATE COMMENT 'Date on which the most recent physical inventory cycle count was completed at this location. Used to identify overdue counts, support audit readiness, and ensure compliance with Joint Commission and DEA inventory requirements.',
    `lawson_location_code` STRING COMMENT 'Source system location identifier from Infor Lawson Supply Chain. Used for ETL reconciliation, cross-system data lineage, and integration with procurement and inventory modules.',
    `location_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the storage location, as assigned in Infor Lawson or SAP MM. Used on requisitions, pick tickets, and transfer orders to reference the physical or logical location.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `location_name` STRING COMMENT 'Human-readable descriptive name of the storage location (e.g., Central Storeroom A, 3rd Floor Nursing Supply Closet, OR Supply Room 2). Used in reports, labels, and user interfaces.',
    `location_notes` STRING COMMENT 'Free-text field for operational notes, special handling instructions, or access directions relevant to this inventory location. Examples: Key held at nursing station, Refrigerator alarm monitored by facilities, Restricted to OR staff only.',
    `location_status` STRING COMMENT 'Current lifecycle status of the inventory location. Controls whether the location is available for receiving, picking, and replenishment transactions. Inactive or decommissioned locations are excluded from par-level replenishment runs.. Valid values are `active|inactive|decommissioned|under_maintenance|pending_activation`',
    `location_type` STRING COMMENT 'Categorical classification of the storage location by its operational role within the supply chain. Drives replenishment rules, access controls, and reporting segmentation. [ENUM-REF-CANDIDATE: central_storeroom|or_supply_room|nursing_unit_closet|adc|off_site_warehouse|satellite_pharmacy|procedure_room|loading_dock — promote to reference product]. Valid values are `central_storeroom|or_supply_room|nursing_unit_closet|adc|off_site_warehouse|satellite_pharmacy`',
    `next_cycle_count_date` DATE COMMENT 'Date on which the next physical inventory cycle count is scheduled for this location. Supports proactive scheduling of materials management staff and compliance monitoring.',
    `par_level_managed` BOOLEAN COMMENT 'Indicates whether this location is managed using par-level replenishment methodology. When true, the system monitors on-hand quantities against defined par levels and triggers automatic replenishment requisitions when stock falls below the par threshold.',
    `par_replenishment_method` STRING COMMENT 'The replenishment methodology used to restock this location. Automated Dispensing Cabinet (ADC) locations use automated dispensing; nursing units may use cart exchange or Periodic Automatic Replenishment (PAR) rounds; central storerooms may use demand-based replenishment.. Valid values are `manual|automated_adc|cart_exchange|periodic_automatic_replenishment|demand_based`',
    `primary_contact_name` STRING COMMENT 'Name of the primary responsible person (e.g., charge nurse, materials manager, storeroom supervisor) accountable for this inventory location. Used for escalation, cycle count coordination, and supply chain communications.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary responsible contact for this inventory location. Used for supply delivery coordination, urgent replenishment requests, and recall notifications.. Valid values are `^+?[0-9-s()]{7,20}$`',
    `recall_management_enabled` BOOLEAN COMMENT 'Indicates whether this location is enrolled in the automated recall management process. When true, FDA and manufacturer recall notifications trigger automated inventory holds and quarantine workflows for affected items at this location.',
    `replenishment_frequency` STRING COMMENT 'How frequently this location is scheduled for replenishment review and restocking. Drives supply chain scheduling and staffing for materials management rounds.. Valid values are `daily|twice_daily|weekly|biweekly|on_demand|shift_based`',
    `room_number` STRING COMMENT 'Specific room or suite identifier within the building and floor for this inventory location. Provides precise physical address for supply delivery and cycle counting.',
    `sap_storage_location_code` STRING COMMENT 'Four-character SAP MM storage location code corresponding to this inventory location. Used for integration with SAP S/4HANA Materials Management for goods movements, purchase orders, and inventory postings.. Valid values are `^[A-Z0-9]{4}$`',
    `secure_controlled_substance` BOOLEAN COMMENT 'Indicates whether this location is designated and secured for storage of DEA Schedule II–V controlled substances. Locations flagged true must comply with DEA 21 CFR Part 1301 physical security requirements and are subject to enhanced audit and access controls.',
    `sterile_processing_staging` BOOLEAN COMMENT 'Indicates whether this location serves as a staging area for sterile processing and reprocessing of reusable surgical instruments and devices. Locations flagged true are subject to sterile processing compliance standards and AAMI/AORN guidelines.',
    `storage_capacity_cubic_ft` DECIMAL(18,2) COMMENT 'Physical volumetric capacity of the storage location in cubic feet. Used for space planning, facility management, and determining whether bulk or oversized items can be stored at this location.',
    `storage_capacity_units` STRING COMMENT 'Maximum number of individual supply units or item slots this location can physically hold. Used for capacity planning, space utilization analysis, and par-level setting. Represents the principal quantitative capacity fact for this resource.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for this location. Exceedances trigger environmental monitoring alerts and may require product quarantine or disposal per FDA and USP guidelines.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius for this location. Used for environmental monitoring alerts and compliance reporting with FDA and USP storage standards.',
    `temperature_requirement` STRING COMMENT 'Required temperature storage condition for items held at this location. Critical for compliance with FDA storage requirements for pharmaceuticals, biologics, and temperature-sensitive medical supplies. Ambient = 15–25°C; Refrigerated = 2–8°C; Frozen = -20°C; Ultra-Low Frozen = -80°C.. Valid values are `ambient|refrigerated|frozen|controlled_room_temperature|ultra_low_frozen`',
    `udi_tracking_enabled` BOOLEAN COMMENT 'Indicates whether this location participates in FDA Unique Device Identification (UDI) tracking for implantable devices and high-risk medical supplies. When true, all UDI-regulated items received or dispensed at this location are captured in the UDI audit trail per FDA 21 CFR Part 830.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory location master record was most recently modified. Used for change data capture, ETL incremental loads, and audit trail compliance.',
    CONSTRAINT pk_inventory_location PRIMARY KEY(`inventory_location_id`)
) COMMENT 'Master record for all physical and logical storage locations within the healthcare supply chain, including central storerooms, OR supply rooms, nursing unit supply closets, automated dispensing cabinets (ADC), and off-site warehouses. Captures location code, facility, department, location type, par-level management flag, temperature requirements, and responsible cost center.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` (
    `inventory_balance_id` BIGINT COMMENT 'Unique surrogate identifier for each inventory balance record representing the on-hand position of a material item at a specific storage location. Primary key for this data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where this inventory balance is held. Supports multi-facility enterprise inventory visibility.',
    `inventory_location_id` BIGINT COMMENT 'Reference to the storage location (e.g., storeroom, OR supply room, nursing unit, pharmacy satellite, or warehouse bin) where this inventory balance is maintained.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record identifying the specific medical-surgical supply, implantable device, pharmaceutical, or consumable item tracked in this inventory balance.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: inventory_balance has contract_number as STRING. For consignment inventory or contract-specific pricing/ownership, this should be FK to vendor_contract for referential integrity and to enable joining ',
    `vendor_id` BIGINT COMMENT 'Reference to the primary vendor or supplier associated with this inventory item, used for consignment reconciliation and replenishment sourcing.',
    `abc_classification` STRING COMMENT 'ABC inventory classification indicating the relative value and usage frequency of the item. A items are high-value/high-usage requiring tight control; B items are moderate; C items are low-value/low-usage; X items are unclassified or obsolete.. Valid values are `A|B|C|X`',
    `balance_snapshot_timestamp` TIMESTAMP COMMENT 'The timestamp at which this inventory balance record was captured or last refreshed from the source system. Represents the as-of time for all quantity fields, enabling point-in-time inventory reporting.',
    `below_reorder_flag` BOOLEAN COMMENT 'Indicates whether the current on-hand quantity has fallen below the defined reorder point, signaling that a replenishment order should be initiated. Distinct from stockout_flag which indicates zero or critically low stock.',
    `consignment_vendor_number` STRING COMMENT 'The vendor account number for consignment stock held at this location. Populated only when ownership_type is consignment. Used for consignment reconciliation, liability reporting, and vendor settlement.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit cost and inventory valuation amounts (e.g., USD). Supports multi-currency enterprise environments.. Valid values are `^[A-Z]{3}$`',
    `days_to_expiration` STRING COMMENT 'Number of days from the current date until the earliest expiration date for on-hand stock. Used to trigger expiration alerts and prioritize consumption. Supports proactive waste management and patient safety.',
    `expiration_date` DATE COMMENT 'The earliest expiration date among current on-hand stock for this item at this location. Used for expiration alerting, FEFO (First Expired First Out) picking, and waste reduction. Critical for patient safety compliance.',
    `formulary_flag` BOOLEAN COMMENT 'Indicates whether this item is on the facilitys approved formulary or preferred item list. Supports value analysis, standardization initiatives, and contract compliance monitoring.',
    `inventory_status` STRING COMMENT 'Current operational status of the inventory balance record. blocked indicates stock held pending quality review; recalled indicates FDA or manufacturer recall action; quarantine indicates items pending investigation or inspection.. Valid values are `active|blocked|restricted|recalled|expired|quarantine`',
    `item_category` STRING COMMENT 'High-level classification of the inventory item type. Drives handling rules, regulatory tracking requirements, and reporting segmentation. [ENUM-REF-CANDIDATE: medical_surgical|implant|pharmaceutical|prosthetic|sterile_processing|capital_equipment|office_supply — promote to reference product]',
    `last_movement_date` DATE COMMENT 'Date of the most recent inventory transaction (receipt, issue, transfer, or adjustment) for this item at this location. Used to identify slow-moving or obsolete stock.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count performed for this item at this location. Used to assess inventory accuracy, schedule next count, and support audit compliance.',
    `last_physical_count_qty` DECIMAL(18,2) COMMENT 'The quantity recorded during the most recent physical inventory count for this item at this location. Used to calculate inventory variance and assess system accuracy.',
    `last_receipt_date` DATE COMMENT 'Date of the most recent goods receipt for this item at this location. Used to assess replenishment cycle performance and vendor delivery timeliness.',
    `lot_number` STRING COMMENT 'Manufacturer or internal lot/batch number for the current stock of this item. Required for expiration tracking, recall management, and FDA traceability. Populated only when lot_tracking_enabled is true.',
    `lot_tracking_enabled` BOOLEAN COMMENT 'Indicates whether lot/batch number tracking is active for this item at this location. Required for items subject to FDA recall management, expiration tracking, and chain-of-custody compliance.',
    `max_level` DECIMAL(18,2) COMMENT 'The maximum quantity of the item that should be held at this storage location. Prevents overstocking, reduces waste from expiration, and optimizes storage space utilization.',
    `ndc_code` STRING COMMENT 'National Drug Code assigned by the FDA for pharmaceutical items in inventory. Identifies the labeler, product, and package configuration. Null for non-pharmaceutical items.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `ownership_type` STRING COMMENT 'Indicates the ownership arrangement for this inventory. consignment means the vendor retains title until use; loaner applies to implant trays or devices temporarily on-site for a specific procedure; owned means the facility has purchased and holds title.. Valid values are `owned|consignment|loaner|demo|leased`',
    `par_level` DECIMAL(18,2) COMMENT 'The target stock quantity (Periodic Automatic Replenishment level) that should be maintained at this location. When on-hand quantity falls below par, a replenishment order is triggered to restore stock to this level.',
    `qty_in_transit` DECIMAL(18,2) COMMENT 'Quantity of the item that has been shipped from the vendor or a central warehouse but has not yet been received at the destination storage location. Supports in-transit visibility for supply chain planning.',
    `qty_on_hand` DECIMAL(18,2) COMMENT 'Current unrestricted quantity of the item physically present and available for use at the storage location. This is the primary stock level metric used for replenishment decisions and inventory valuation.',
    `qty_on_order` DECIMAL(18,2) COMMENT 'Total quantity of the item currently on open purchase orders or requisitions that have not yet been received. Used to project future availability and prevent duplicate ordering.',
    `qty_quarantine` DECIMAL(18,2) COMMENT 'Quantity of the item currently held in quarantine stock pending quality inspection, recall investigation, or regulatory hold. Not available for clinical use until released.',
    `qty_reserved` DECIMAL(18,2) COMMENT 'Quantity of the item reserved for specific procedures, surgical cases, or patient orders but not yet consumed. Reduces available-to-promise quantity for replenishment calculations.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether any on-hand stock of this item at this location is subject to an active FDA or manufacturer recall. When true, the item should be quarantined and removed from clinical use pending recall resolution.',
    `recall_number` STRING COMMENT 'FDA or manufacturer-assigned recall identification number associated with the active recall affecting this inventory. Populated only when recall_flag is true. Used for recall tracking and regulatory reporting.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The minimum quantity threshold at which a replenishment order must be initiated to avoid stockout, accounting for lead time and safety stock. Used in min-max and reorder-point replenishment methods.',
    `replenishment_method` STRING COMMENT 'The method used to trigger restocking of this item at this location. par uses periodic automatic replenishment to a defined par level; kanban uses visual/signal-based pull; min_max triggers orders when quantity falls below minimum; vendor_managed delegates replenishment to the supplier.. Valid values are `par|kanban|min_max|manual|vendor_managed`',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Buffer stock quantity maintained above the reorder point to protect against demand variability and supply lead time uncertainty. Critical for high-utilization clinical items to prevent patient care disruptions.',
    `serial_tracking_enabled` BOOLEAN COMMENT 'Indicates whether individual serial number tracking is active for this item. Typically enabled for high-value implantable devices, capital equipment, and items requiring UDI-level traceability.',
    `source_record_key` STRING COMMENT 'The natural key or composite identifier from the source system (e.g., SAP plant/storage location/material combination or Infor Lawson item/location key) that uniquely identifies this balance record in the originating system.',
    `stockout_flag` BOOLEAN COMMENT 'Indicates whether the current on-hand quantity is zero or below the safety stock threshold, representing a stockout condition. Used to trigger emergency procurement and escalation workflows.',
    `storage_bin` STRING COMMENT 'The specific bin, shelf, or slot identifier within the storage location where this item is physically stored. Supports directed putaway, picking, and cycle count operations.',
    `udi_code` STRING COMMENT 'FDA-mandated Unique Device Identifier for implantable and high-risk medical devices. Enables device tracking, recall management, and post-market surveillance per FDA UDI regulation (21 CFR Part 830). Null for non-device items.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The standard or moving average cost per unit of measure for this item at this location. Used for inventory valuation, charge capture, and cost accounting. Classified as confidential due to vendor pricing sensitivity.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure in which inventory quantities are tracked (e.g., EA=Each, BX=Box, CS=Case, PK=Pack, BG=Bag, DZ=Dozen). Aligns with the material master UOM for consistent quantity reporting.. Valid values are `EA|BX|CS|PK|BG|DZ`',
    CONSTRAINT pk_inventory_balance PRIMARY KEY(`inventory_balance_id`)
) COMMENT 'Current on-hand inventory position for each material item at each storage location, serving as SSOT for stock levels, par-level configuration, and replenishment parameters. Tracks quantity on hand, on order, reserved, and in transit; ownership type (owned, consignment); reorder point, par level, maximum level, and replenishment method (par, kanban, min-max); lot/serial tracking; expiration visibility; and last physical count date. Supports par-level replenishment, stockout prevention, consignment reconciliation, expiration alerting, and inventory valuation. Sourced from SAP MM Inventory Management and Infor Lawson Inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` (
    `inventory_transaction_id` BIGINT COMMENT 'Primary key for inventory_transaction',
    `case_cart_id` BIGINT COMMENT 'Foreign key linking to supply.case_cart. Business justification: inventory_transaction has surgical_case_number as STRING, but case_cart is the operational record for surgical case supply assembly. Inventory movements for case cart assembly/return should link to ca',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Inventory movements (issues, returns, adjustments, write-offs) must post to specific GL accounts for inventory valuation, expense recognition, and financial statement accuracy. Enables automated GL po',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Supply issues and returns tied to specific clinical orders for charge capture audit and inventory reconciliation. Links supply movement to clinical event for billing validation and waste analysis.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Inventory transactions post to specific fiscal periods for inventory valuation, COGS timing, expense recognition, and period-end inventory reconciliation. Required for accurate financial statements an',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Inventory transactions for receipts should link to the goods_receipt record for full traceability of the receiving event (who received, condition on receipt, discrepancies, UDI capture, etc.). This co',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: inventory_transaction has source_storage_location as STRING, but this should be FK to inventory_location for referential integrity and to enable joins for location attributes (care_site, department, t',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: inventory_transaction has material_number and material_description which are authoritative in material_master. Every inventory movement is for a specific material item. Adding material_master_id FK en',
    `employee_id` BIGINT COMMENT 'The employee or user ID of the staff member who performed or authorized the inventory transaction. Supports accountability, audit trail, and compliance with HIPAA and Joint Commission documentation requirements.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: inventory_transaction has purchase_order_number as STRING. For movements related to PO receipts, this should be FK for referential integrity and to enable joining to PO header attributes (vendor, cont',
    `recall_notice_id` BIGINT COMMENT 'Foreign key linking to supply.recall_notice. Business justification: inventory_transaction has recall_flag and recall_number. Movements related to recalls (quarantine, return to vendor, destruction) should link to recall_notice for full context (recall class, health ha',
    `requisition_id` BIGINT COMMENT 'Foreign key linking to supply.requisition. Business justification: inventory_transaction has requisition_number as STRING. For movements related to requisition fulfillment (issues to departments), this should be FK to requisition for traceability to the requesting de',
    `source_inventory_transaction_id` BIGINT COMMENT 'The native transaction identifier from the originating source system (e.g., SAP MM material document item number or Infor Lawson transaction sequence number). Enables traceability back to the system of record for reconciliation and audit.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this inventory transaction, applicable for goods receipt and return-to-vendor movements. Links to the vendor master for supplier performance analysis and accounts payable reconciliation.',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter associated with this inventory transaction, applicable when supplies are issued directly to a patient care event. Enables implant charge capture support and supply cost allocation to specific patient encounters for revenue cycle management.',
    `cost_center_code` STRING COMMENT 'The financial cost center to which the supply cost is allocated. Corresponds to SAP CO cost center (KOSTL) and is used for departmental cost reporting, budget variance analysis, and CMS cost report preparation.',
    `count_variance_quantity` DECIMAL(18,2) COMMENT 'The difference between the physical count quantity and the system book quantity for physical inventory and cycle count transactions. A positive value indicates a surplus; a negative value indicates a shortage. Used for inventory accuracy measurement and shrinkage analysis.',
    `count_variance_value` DECIMAL(18,2) COMMENT 'The monetary value of the physical count variance, calculated as count_variance_quantity multiplied by unit_cost. Used for financial reporting of inventory adjustments and write-offs in the general ledger.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory transaction record was first captured in the system. Used for audit trail, data lineage, and SLA measurement.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary values in this transaction (e.g., USD). Required for multi-entity health systems operating across different currency jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `destination_storage_location` STRING COMMENT 'The receiving storage location or inventory location to which the supply item was moved. Applicable for transfer and receipt transactions. Corresponds to SAP MM receiving storage location or Infor Lawson destination location.',
    `document_date` DATE COMMENT 'The date the physical goods movement or source document was created, which may differ from the posting date. Used for audit trail and reconciliation between physical activity and financial posting.',
    `expiration_date` DATE COMMENT 'The expiration date of the specific lot or batch of the supply item involved in this transaction. Critical for expiration tracking, FEFO (First Expired First Out) inventory management, and compliance with FDA and Joint Commission requirements for expired product management.',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total cost of the inventory transaction calculated as quantity multiplied by unit cost. Represents the monetary value of the goods movement for cost center allocation, departmental charge capture, and financial reporting.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code to which the inventory transaction value is posted in SAP FI. Supports financial reconciliation between supply chain and the general ledger.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal (cancellation) of a previously posted goods movement. When True, the transaction negates the original movement for audit and financial correction purposes.',
    `issuing_department_code` STRING COMMENT 'The organizational department code responsible for issuing or consuming the supply item, such as ICU, ED, OR, or a specific nursing unit. Used for departmental supply utilization reporting and cost allocation.',
    `lot_number` STRING COMMENT 'Manufacturer lot or batch number assigned to the supply item. Critical for recall management, expiration tracking, and traceability of medical-surgical supplies and implantable devices. Corresponds to SAP MM batch number (CHARG).',
    `material_document_number` STRING COMMENT 'The externally-known SAP MM material document number (MBLNR) generated upon goods movement posting. Serves as the primary business identifier for the transaction, traceable in SAP MIGO and Infor Lawson transaction logs.',
    `material_document_year` STRING COMMENT 'The fiscal year associated with the material document number in SAP MM. Required in combination with material_document_number to uniquely identify a goods movement document in SAP.. Valid values are `^[0-9]{4}$`',
    `movement_category` STRING COMMENT 'High-level classification of the inventory movement for analytics and reporting. issue = supply issued to patient care area or department; return = unused supply returned to stock; transfer = movement between storage locations; adjustment = manual inventory correction; waste = disposal or expiration write-off; count = physical or cycle count result; receipt = goods receipt from vendor or PO. [ENUM-REF-CANDIDATE: issue|return|transfer|adjustment|waste|count|receipt — 7 candidates stripped; promote to reference product]',
    `movement_type_code` STRING COMMENT 'SAP MM movement type code (BWART) classifying the nature of the inventory transaction. Examples include 201 (goods issue to cost center), 261 (goods issue to order), 301 (transfer posting), 309 (transfer to storage location), 551 (scrapping/waste). Infor Lawson equivalent transaction type codes are also mapped here. [ENUM-REF-CANDIDATE: 201|261|301|309|551|101|102|122|161|201|202|261|262|301|302|303|304|305|306|309|310|311|312|313|314|315|316|317|318|319|321|322|323|324|325|326|331|332|333|334|335|336|337|338|339|341|342|343|344|345|346|347|348|349|351|352|353|354|355|356|357|358|359|361|362|363|364|365|366|367|368|369|371|372|373|374|375|376|377|378|379|381|382|383|384|385|386|387|388|389|391|392|393|394|395|396|397|398|399|401|402|501|502|551|552|553|554|555|556|557|558|559|561|562|563|564|565|566|567|568|569|601|602|641|642|643|644|645|646|647|648|649|651|652|653|654|655|656|657|658|659|661|662|663|664|665|666|667|668|669|671|672|673|674|675|676|677|678|679|681|682|683|684|685|686|687|688|689|691|692|693|694|695|696|697|698|699|701|702|711|712|721|722|731|732|741|742|751|752|761|762|771|772|781|782|791|792|801|802|811|812|821|822|831|832|841|842|851|852|861|862|871|872|881|882|891|892|901|902|911|912|921|922|931|932|941|942|951|952|961|962|971|972|981|982|991|992 — promote to reference product]',
    `movement_type_description` STRING COMMENT 'Human-readable description of the movement type code, such as Goods Issue to Cost Center, Transfer Posting, Physical Inventory Count Adjustment, Scrapping/Waste Disposal, or Return from Patient Care Area. Supports reporting and analytics without requiring code lookups.',
    `par_location_code` STRING COMMENT 'The PAR (Periodic Automatic Replenishment) location code identifying the nursing unit, procedure room, or supply cabinet from which the item was issued or replenished. Used for par-level replenishment analysis and supply utilization reporting by care area.',
    `plant_code` STRING COMMENT 'SAP MM plant code (WERKS) representing the facility or organizational unit where the inventory transaction occurred. Maps to a hospital, clinic, or outpatient facility within the health system.',
    `posting_date` DATE COMMENT 'The principal real-world business event date on which the inventory movement was posted to the ledger. Determines the accounting period for cost allocation and financial reporting. Corresponds to SAP MIGO Posting Date (BUDAT) and Infor Lawson transaction date.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supply item involved in the inventory movement. Positive values indicate goods receipt or return; negative values indicate goods issue or write-off, consistent with SAP MM sign convention. Supports supply utilization analysis and inventory accuracy measurement.',
    `reason_code` STRING COMMENT 'Coded reason explaining why the inventory transaction occurred, particularly for adjustments, waste disposals, and returns. Examples include EXPIRED (expiration date reached), DAMAGED (item damaged), RECALLED (manufacturer recall), COUNT_VARIANCE (physical count discrepancy), PATIENT_USE (issued for patient care). [ENUM-REF-CANDIDATE: EXPIRED|DAMAGED|RECALLED|COUNT_VARIANCE|PATIENT_USE|OVERSTOCK|WRONG_ITEM|THEFT|SPOILAGE|TRANSFER_REQUEST — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text description providing additional context for the reason code, such as specific details about damage, recall notice number, or count discrepancy explanation. Supports audit trail and investigation workflows.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether the supply item involved in this transaction is subject to an active manufacturer or FDA recall notice. When True, triggers recall management workflows and patient safety notifications.',
    `reversed_document_number` STRING COMMENT 'The material document number of the original transaction that this reversal transaction cancels. Populated only when is_reversal is True. Enables full audit trail linking reversals to their originating documents.',
    `serial_number` STRING COMMENT 'Manufacturer serial number for serialized items such as implantable devices, capital equipment components, or high-value prosthetics. Enables individual unit-level traceability for patient safety and recall management.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this inventory transaction was sourced. Supports data lineage, ETL reconciliation, and multi-system integration auditing in the Databricks Silver Layer.. Valid values are `SAP_MM|INFOR_LAWSON|MEDITECH|MANUAL`',
    `sterile_processing_indicator` BOOLEAN COMMENT 'Indicates whether the supply item involved in this transaction is subject to sterile processing (reprocessing/sterilization) workflows. When True, the item is tracked through the sterile processing department (SPD) for reuse cycle management.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the inventory transaction. posted indicates the goods movement has been successfully recorded; reversed indicates a cancellation document has been posted; pending indicates awaiting system confirmation; error indicates a posting failure requiring resolution.. Valid values are `posted|reversed|cancelled|pending|error`',
    `udi_code` STRING COMMENT 'The FDA-mandated Unique Device Identifier (UDI) for implantable devices and high-risk medical devices. Composed of the Device Identifier (DI) and Production Identifier (PI) components. Required for implant charge capture, recall management, and FDA UDI compliance reporting.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the supply item at the time of the transaction, sourced from the material master valuation price or moving average price. Used for cost allocation to departments and cost center accounting.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the transaction quantity is expressed, such as EA (each), BX (box), CS (case), PK (pack), or ML (milliliter). Corresponds to SAP MM base unit of measure (MEINS) or Infor Lawson unit of measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory transaction record was last modified, such as upon reversal, status change, or correction. Supports change data capture and audit compliance.',
    CONSTRAINT pk_inventory_transaction PRIMARY KEY(`inventory_transaction_id`)
) COMMENT 'Transactional log of all inventory movements including issues to patient care areas, returns, transfers between locations, adjustments, waste disposals, cycle count corrections, and physical count results. Captures movement type, material master reference, quantity, unit of measure, source and destination locations, reference document (PO, requisition, patient encounter), cost center, unit cost, extended cost, posting date, reason code, lot/serial number, and count variance (for physical counts). Provides full audit trail for supply utilization, cost allocation to departments, implant charge capture support, and inventory accuracy measurement. Sourced from SAP MM Goods Movement (MIGO 201-309) and Infor Lawson Inventory Transactions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Unique system-generated identifier for the internal supply requisition record. Primary key for this entity in the Databricks Silver layer.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved or rejected the requisition. Used for accountability, audit trail, and compliance with procurement authorization policies.',
    `care_site_id` BIGINT COMMENT 'Identifier of the hospital, clinic, or outpatient facility from which the requisition originates. Supports multi-facility health system reporting and inventory allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Requisitions originate from requesting cost centers for budget checking, approval routing by cost center manager, and spend tracking against departmental budgets. Core to budget control workflow.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the clinical department, nursing unit, or OR team that submitted the requisition. Links to the facility/department master. Examples include ICU, ED, OR, pharmacy, or a specific nursing unit.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order generated from this requisition when the fulfillment method is direct purchase. Null for stock pull fulfillments. Links the requisition to the procurement and accounts payable workflow.',
    `recall_notice_id` BIGINT COMMENT 'Reference to the product recall event that triggered this requisition, when is_recall_related is True. Links supply replacement activity to FDA recall management records for compliance reporting.',
    `requester_employee_id` BIGINT COMMENT 'Identifier of the employee (nurse, OR coordinator, department manager, or clinical staff member) who created and submitted the requisition. Used for accountability, approval routing, and audit trail.',
    `surgical_bom_id` BIGINT COMMENT 'Reference to the Bill of Materials (BOM) template used to auto-populate line items for a surgical procedure or standard care protocol. Supports standardized supply utilization and procedure cost benchmarking.',
    `surgical_case_id` BIGINT COMMENT 'Reference to the surgical case or procedure for which this requisition was generated. Populated when requisition_type is surgical_case. Links supply consumption to OR scheduling and BOM (Bill of Materials) for procedure costing.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Supply requisitions often triggered BY clinical orders (e.g., surgical case order triggers OR supply pull, patient-specific implant order triggers procurement). Natural parent-child relationship for s',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the active supply contract or group purchasing organization (GPO) agreement under which this requisitions items are procured. Ensures contract compliance and enables contract utilization reporting.',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or contracted vendor for direct purchase fulfillments. Populated when fulfillment_method is direct_purchase or consignment. Links to the vendor master for contract pricing and performance tracking.',
    `actual_total_cost` DECIMAL(18,2) COMMENT 'Actual total cost of all fulfilled line items on the requisition, updated upon fulfillment. May differ from estimated_total_cost due to substitutions, partial fulfillments, or price changes. Used for budget variance analysis and financial reporting.',
    `approval_status` STRING COMMENT 'Current state of the requisition within the approval workflow. Distinct from requisition_status, which tracks overall fulfillment lifecycle. Approval status specifically tracks the authorization decision by supply chain management or department leadership.. Valid values are `pending|approved|rejected|escalated`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition was approved (or rejected) by the authorized approver. Used for cycle time analysis, SLA compliance, and procurement audit trails.',
    `budget_period` STRING COMMENT 'Fiscal budget period (year and quarter or month) to which this requisitions costs are allocated (e.g., 2024-Q3 or 2024-07). Used for departmental budget tracking and financial close.. Valid values are `^[0-9]{4}-(Q[1-4]|[0-9]{2})$`',
    `clinical_justification` STRING COMMENT 'Free-text narrative provided by the requester explaining the clinical or operational reason for the supply request. Required for non-routine or high-cost requisitions. Supports CDI and compliance review.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was first created in the source system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this requisition (e.g., USD). Supports multi-currency health systems and international procurement.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Specific physical delivery point within the facility where the requested supplies should be delivered (e.g., ICU 4N Med Room, OR Suite 3 Supply Closet, ED Trauma Bay). More granular than department; used for last-mile storeroom delivery routing.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of all line items on the requisition at time of submission, based on material master standard costs or contract pricing. Used for budget pre-authorization and spend visibility. Not a calculated aggregate — sourced directly from the requisition system at submission time.',
    `expiration_tracking_required` BOOLEAN COMMENT 'Indicates whether items on this requisition require lot/expiration date tracking at fulfillment. Applies to pharmaceuticals, biologics, sterile supplies, and reagents. Supports FIFO inventory management and recall readiness.',
    `fulfilled_date` DATE COMMENT 'Date on which the requisition was fully fulfilled and materials were delivered to the requesting department. Used for cycle time measurement, SLA reporting, and supply chain performance analytics.',
    `fulfillment_method` STRING COMMENT 'Method by which the requisition will be fulfilled. Stock pull draws from central storeroom inventory; direct purchase triggers a purchase order to a vendor; consignment pulls from vendor-managed inventory on-site; loaner is for temporary implant or device use; transfer moves stock between facilities. [ENUM-REF-CANDIDATE: stock_pull|direct_purchase|consignment|loaner|transfer — promote to reference product]. Valid values are `stock_pull|direct_purchase|consignment|loaner|transfer`',
    `gl_account_code` STRING COMMENT 'General ledger account code used to classify the supply expense for financial reporting. Derived from the charge description master or material master. Supports revenue cycle and financial close processes.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether any items on this requisition are classified as hazardous materials (e.g., chemotherapy agents, radioactive materials, flammable chemicals). Triggers special handling, transport, and storage protocols per OSHA and regulatory requirements.',
    `is_capital_expense` BOOLEAN COMMENT 'Indicates whether any items on this requisition are classified as capital expenditures (equipment or assets above the capitalization threshold) rather than operating supply expenses. Triggers different approval and financial coding workflows.',
    `is_par_triggered` BOOLEAN COMMENT 'Indicates whether this requisition was automatically generated by a par-level replenishment trigger rather than manually submitted. True = system-generated par replenishment; False = manual ad hoc request. Supports par management analytics and storeroom automation reporting.',
    `is_recall_related` BOOLEAN COMMENT 'Indicates whether this requisition was generated in response to a product recall event, requiring replacement of recalled medical-surgical supplies or implantable devices. Supports FDA recall compliance tracking and patient safety reporting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was most recently modified in the source system. Used for change detection, incremental ETL processing, and audit compliance.',
    `needed_by_date` DATE COMMENT 'Date by which the requested materials must be available for clinical use. Drives fulfillment prioritization, vendor lead time calculations, and storeroom scheduling. Maps to SAP MM LFDAT (Delivery Date) and Lawson required date field.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special handling requirements, or communication between the requester and supply chain staff. Examples include delivery location specifics, substitution preferences, or sterile processing instructions.',
    `number` STRING COMMENT 'Externally-known, human-readable requisition identifier assigned by the source system (Infor Lawson or SAP MM). Used for cross-system tracking, communication with supply chain staff, and audit trail. Maps to Lawson RQ10 requisition number or SAP BANFN field.. Valid values are `^REQ-[0-9]{8,12}$`',
    `rejection_reason` STRING COMMENT 'Free-text or coded reason provided by the approver when a requisition is rejected. Supports process improvement, requester feedback, and compliance documentation.',
    `requester_name` STRING COMMENT 'Full name of the employee who submitted the requisition. Retained for display and audit purposes. Classified as confidential as it identifies internal workforce members.',
    `requesting_department_name` STRING COMMENT 'Human-readable name of the clinical department or nursing unit that submitted the requisition (e.g., ICU 4 North, Operating Room 3, Emergency Department). Retained for reporting and display without requiring a join.',
    `source_system_key` STRING COMMENT 'Natural key or internal identifier of this requisition record in the originating source system (e.g., Lawson RQ10 internal ID or SAP BANFN). Used for ETL reconciliation, deduplication, and cross-system traceability.',
    `requisition_status` STRING COMMENT 'Current workflow lifecycle state of the requisition. Drives approval routing, fulfillment actions, and reporting. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|partially_fulfilled|fulfilled|cancelled — promote to reference product]',
    `sterile_processing_required` BOOLEAN COMMENT 'Indicates whether items on this requisition require sterile processing or reprocessing before delivery to the requesting department. Triggers coordination with the sterile processing department (SPD) and tracks instrument tray readiness.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition was formally submitted by the requesting department or unit. Represents the principal business event timestamp for this transaction. Used for cycle time measurement and SLA tracking.',
    `total_line_count` STRING COMMENT 'Number of distinct line items (material/item requests) included in this requisition. Sourced directly from the requisition header record in Infor Lawson or SAP MM — not a derived aggregate. Used for complexity classification and processing time estimation.',
    `requisition_type` STRING COMMENT 'Classification of the requisition by its origination method. Par replenishment is auto-triggered when stock falls below par level; ad hoc is a manual one-time request; surgical case is linked to an OR procedure BOM; direct purchase bypasses storeroom stock. [ENUM-REF-CANDIDATE: par_replenishment|ad_hoc|surgical_case|direct_purchase|emergency — promote to reference product]. Valid values are `par_replenishment|ad_hoc|surgical_case|direct_purchase|emergency`',
    `udi_required` BOOLEAN COMMENT 'Indicates whether one or more items on this requisition are implantable devices or Class II/III medical devices requiring FDA Unique Device Identifier (UDI) tracking. Triggers UDI capture workflow at fulfillment and patient implant documentation.',
    `urgency_level` STRING COMMENT 'Priority classification of the requisition indicating how quickly the requested materials are needed. STAT (immediate clinical need), Urgent (same-day), or Routine (standard replenishment cycle). Drives fulfillment prioritization and storeroom workflow.. Valid values are `routine|urgent|stat`',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Internal supply requisition submitted by clinical departments, nursing units, or OR teams requesting materials from the central storeroom or supply chain. Captures requisition number, requesting department, requested items with quantities and material master references, urgency level (routine, urgent, STAT), clinical justification, approval workflow status, fulfillment method (stock pull, direct purchase), linked purchase order (if non-stock), and fulfillment status. Supports par-level auto-replenishment triggers and manual ad-hoc requests. Sourced from Infor Lawson Requisitions module and SAP MM Purchase Requisitions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`udi_record` (
    `udi_record_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each UDI tracking record in the lakehouse silver layer. System-generated BIGINT for internal referencing.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: UDI tracking deficiencies are common FDA and Joint Commission audit findings. Quality teams link UDI records to findings for evidence of remediation (missing scans, incomplete documentation) and corre',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, surgical center) where the device was received, stored, or implanted. Supports facility-level inventory and compliance reporting.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: UDI tracking for implanted devices MUST link to the clinical order that authorized implantation. FDA regulatory requirement for device traceability, recall management, and adverse event reporting. Cri',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed clinician (surgeon or interventionalist) who performed the device implantation procedure. Required for implant registry reporting, credentialing verification, and provider-level quality analytics.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient in whom the device was implanted or used. Populated when the device has been associated with a specific patient encounter or implant event. Null for devices not yet implanted.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Implantable devices tracked via UDI require HCPCS codes for billing and reimbursement. Mandatory for device registry reporting, charge capture validation, and payer claims submission—regulatory and re',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: UDI records track implanted devices that must link to supply master for: FDA recall management requiring device master data, warranty claim processing, cost capture for implant billing, inventory repl',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: UDI records are transmitted via HL7/FHIR messages to implant registries, FDA MedWatch, and HIEs for care coordination. Tracks which interface message transmitted the device data for audit and reconcil',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Implantable device tracking requires linking to the payer who covered the implant for warranty claims, recall remediation, and reimbursement disputes. Real business process: FDA MDR reporting, payer-s',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or manufacturer from whom the device was procured. Used for vendor performance tracking, recall management, and procurement analytics.',
    `procedure_event_id` BIGINT COMMENT 'Reference to the surgical or procedural event record during which the device was implanted or used. Enables direct linkage between the UDI record and the clinical procedure documentation in the EHR.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (e.g., surgical procedure, inpatient admission) during which the device was implanted or used. Links UDI record to the clinical event for traceability.',
    `visit_procedure_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this UDI record was first created in the lakehouse silver layer. Used for audit trail, data lineage, and compliance reporting.',
    `device_identifier` STRING COMMENT 'The mandatory, fixed portion of the Unique Device Identifier (UDI) that identifies the labeler and the specific version or model of a device. Corresponds to the Device Identifier (DI) component of the FDA UDI system. Sourced from the FDA Global Unique Device Identification Database (GUDID).',
    `expiration_date` DATE COMMENT 'The date after which the device should not be used, as labeled by the manufacturer. Critical for sterile device management, expiration tracking, and preventing use of expired devices. Part of the Production Identifier (PI) component of the UDI.',
    `explant_date` DATE COMMENT 'The date on which a previously implanted device was surgically removed (explanted) from the patient. Populated when implant_status transitions to explanted. Used for device lifecycle tracking and adverse event reporting.',
    `explant_reason` STRING COMMENT 'The clinical or administrative reason for device explantation. Used for adverse event reporting, quality improvement, and FDA MedWatch reporting. [ENUM-REF-CANDIDATE: device_failure|infection|patient_request|end_of_life|recall|revision|death|other — promote to reference product]',
    `gmdn_code` STRING COMMENT 'The Global Medical Device Nomenclature (GMDN) code assigned to the device type, providing an internationally recognized classification for medical devices. Supports interoperability with international device registries.',
    `implant_date` DATE COMMENT 'The date on which the device was surgically implanted into the patient. Populated when implant_status transitions to implanted. Required for implant registry reporting and patient safety tracking.',
    `implant_site` STRING COMMENT 'The anatomical location in the patients body where the device was implanted (e.g., left hip, thoracic cavity, lumbar spine). Supports clinical documentation, implant registry reporting, and post-market surveillance.',
    `implant_status` STRING COMMENT 'Current lifecycle status of the implantable device. Tracks whether the device is available in inventory, has been implanted in a patient, has been explanted (removed), wasted, recalled, or quarantined pending investigation.. Valid values are `available|implanted|explanted|wasted|recalled|quarantined`',
    `implantable_flag` BOOLEAN COMMENT 'Indicates whether the device is classified as implantable per FDA UDI regulations. Implantable devices require mandatory UDI documentation at the point of care and patient-level tracking in the medical record.',
    `issuing_agency` STRING COMMENT 'The FDA-accredited issuing agency that assigned the UDI system used for this device. Valid values include GS1 (Global Standards One), HIBCC (Health Industry Business Communications Council), ICCBBA (International Council for Commonality in Blood Banking Automation), and IFA (Informationsstelle für Arzneispezialitäten).. Valid values are `GS1|HIBCC|ICCBBA|IFA`',
    `laterality` STRING COMMENT 'The side of the body where the device was implanted (left, right, bilateral, or not applicable). Used for surgical documentation, implant registry reporting, and clinical analytics.. Valid values are `left|right|bilateral|not_applicable`',
    `location_code` STRING COMMENT 'The current physical storage location code within the facility where the device is stored (e.g., OR supply room, cath lab, central sterile). Used for inventory management, par-level replenishment, and device retrieval.',
    `lot_number` STRING COMMENT 'The manufacturer-assigned lot or batch number for the device. Used for recall management, quality investigations, and traceability to the manufacturing batch. Part of the Production Identifier (PI) component of the UDI.',
    `manufacture_date` DATE COMMENT 'The date on which the device was manufactured, as labeled by the manufacturer. Used for shelf-life calculations, quality investigations, and traceability. Part of the Production Identifier (PI) component of the UDI.',
    `mdr_reportable_flag` BOOLEAN COMMENT 'Indicates whether an adverse event or malfunction associated with this device has been determined to be reportable to the FDA under Medical Device Reporting (MDR) regulations. Triggers mandatory FDA MedWatch reporting workflow.',
    `production_identifier` STRING COMMENT 'The conditional, variable portion of the UDI that identifies one or more of the following: lot/batch number, serial number, expiration date, manufacturing date, and distinct identification code. Corresponds to the Production Identifier (PI) component per FDA UDI regulations.',
    `recall_class` STRING COMMENT 'The FDA classification of the recall by severity: Class I (serious adverse health consequences or death), Class II (temporary or medically reversible adverse health consequences), Class III (unlikely to cause adverse health consequences). Drives urgency of recall response.. Valid values are `Class I|Class II|Class III`',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this specific device unit has been identified as subject to an active FDA recall, market withdrawal, or safety alert. True when the devices lot number or serial number matches an active recall notice.',
    `recall_number` STRING COMMENT 'The FDA-assigned recall identification number associated with this device if it is subject to a recall. Used to cross-reference the FDA recall database and track recall remediation actions.',
    `recall_remediation_status` STRING COMMENT 'Current status of recall remediation actions taken for this device unit. Tracks whether the facility has been notified, the device has been returned to the manufacturer, replaced, destroyed, or if no action is required.. Valid values are `pending|notified|returned|replaced|destroyed|no_action_required`',
    `receiving_date` DATE COMMENT 'The date on which the device was received at the healthcare facility from the vendor or manufacturer. Marks the start of the facilitys custody and responsibility for the device. Used for inventory aging and shelf-life calculations.',
    `serial_number` STRING COMMENT 'The manufacturer-assigned serial number uniquely identifying an individual device unit within a lot. Required for implantable devices and high-risk devices. Part of the Production Identifier (PI) component of the UDI.',
    `single_use_flag` BOOLEAN COMMENT 'Indicates whether the device is labeled as single-use only by the manufacturer. Single-use devices (SUDs) must not be reprocessed or reused unless compliant with FDA reprocessing regulations. Critical for patient safety and regulatory compliance.',
    `source_system_record_code` STRING COMMENT 'The native identifier of this UDI record in the originating operational system (e.g., Infor Lawson item transaction ID, Epic OpTime implant record ID). Supports data lineage tracing and reconciliation with source systems.',
    `sterile_flag` BOOLEAN COMMENT 'Indicates whether the device is labeled as sterile by the manufacturer. Sterile devices require specific storage conditions and handling protocols. Used by sterile processing and supply chain teams.',
    `storage_condition` STRING COMMENT 'The manufacturer-specified storage condition required to maintain device integrity and sterility. Used by supply chain and sterile processing teams to ensure proper storage and prevent device degradation.. Valid values are `room_temperature|refrigerated|frozen|controlled_room_temperature|protect_from_light`',
    `udi_carrier_aidc` STRING COMMENT 'The UDI as encoded in the Automatic Identification and Data Capture (AIDC) technology on the device label (e.g., barcode, RFID). Used for automated scanning during receiving, dispensing, and implant documentation.',
    `udi_carrier_hrf` STRING COMMENT 'The full UDI string as it appears in human-readable form (HRF) on the device label, combining both the Device Identifier (DI) and Production Identifier (PI). Used for manual verification and label reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this UDI record was last modified in the lakehouse silver layer. Used for change tracking, audit trail, and incremental data processing.',
    CONSTRAINT pk_udi_record PRIMARY KEY(`udi_record_id`)
) COMMENT 'Unique Device Identifier (UDI) tracking record for implantable devices and high-risk medical devices as required by FDA UDI regulations. Captures device identifier (DI), production identifier (PI), lot number, serial number, expiration date, manufacturer, device description, implant status, patient association, and recall status. Supports FDA 21 CFR Part 830 compliance and implant registry reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` (
    `surgical_bom_id` BIGINT COMMENT 'Unique system-generated identifier for the surgical Bill of Materials (BOM) record. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility (hospital or surgical center) where this BOM is applicable. Links to the facility master.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Surgical preference cards must align with clinical policies (formulary compliance, product standardization, evidence-based practice). Value analysis committees enforce policy compliance in BOM design ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Surgical preference cards and BOMs are inherently tied to specific CPT procedures. Enables procedure-specific supply cost benchmarking, case costing, and surgeon preference card management—core periop',
    `preference_card_id` BIGINT COMMENT 'Reference to the surgeon or procedure preference card from which this BOM was derived or linked. Preference cards in Epic OpTime or Cerner SurgiNet define surgeon-specific supply preferences.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee (typically a clinical director, OR manager, or supply chain director) who approved this BOM for active use. Supports audit trail and accountability.',
    `facility_service_id` BIGINT COMMENT 'Identifier of the clinical service line (e.g., Orthopedics, Cardiovascular, General Surgery) to which this BOM belongs. Drives OR supply planning by specialty.',
    `order_set_id` BIGINT COMMENT 'Foreign key linking to order.order_set. Business justification: Surgical preference cards (BOMs) often standardized as clinical order sets for procedure protocols. Links supply planning to clinical ordering workflow for efficiency and compliance. Real in periopera',
    `tertiary_surgical_supply_chain_owner_employee_id` BIGINT COMMENT 'Identifier of the supply chain or materials management staff member responsible for maintaining item availability, pricing, and substitution rules for this BOM.',
    `anesthesia_type` STRING COMMENT 'Standard anesthesia type associated with this procedure BOM. Drives anesthesia supply requirements and may influence BOM item composition for anesthesia-specific consumables.. Valid values are `general|regional|local|monitored_anesthesia_care|neuraxial`',
    `approval_date` DATE COMMENT 'Date on which this BOM was formally approved for clinical and operational use. Required for audit trail and version lifecycle management.',
    `approval_status` STRING COMMENT 'Clinical and supply chain approval status of this BOM. pending awaits review; approved is cleared for OR use; rejected was not approved; expired approval has lapsed and requires renewal.. Valid values are `pending|approved|rejected|expired`',
    `bom_name` STRING COMMENT 'Descriptive name of the surgical BOM, typically reflecting the procedure type and service line (e.g., Total Knee Arthroplasty — Orthopedics). Used for display and search in OR management systems.',
    `bom_number` STRING COMMENT 'Externally-known, human-readable unique identifier for this surgical BOM. Used in OR scheduling, case cart building, and supply requisitions. Sourced from Infor Lawson or SAP MM.. Valid values are `^BOM-[A-Z0-9]{4,20}$`',
    `bom_status` STRING COMMENT 'Current lifecycle status of the surgical BOM. draft indicates in development; active is approved for use; under_review is pending clinical or supply chain review; superseded has been replaced by a newer version; retired is no longer in use.. Valid values are `draft|active|under_review|superseded|retired`',
    `bom_version` STRING COMMENT 'Version identifier of the BOM (e.g., v1.0, v2.3). Supports versioning when supply lists are updated due to clinical preference changes, product substitutions, or cost reviews.. Valid values are `^v[0-9]+.[0-9]+$`',
    `case_cart_template_flag` BOOLEAN COMMENT 'Indicates whether this BOM is designated as the standard case cart template for the associated procedure type. Case cart templates drive automated pick lists in materials management systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was first created in the data platform. Supports audit trail, data lineage, and compliance with HIPAA and HITRUST record-keeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary cost estimates in this BOM (e.g., USD). Supports multi-facility and international health system cost reporting.. Valid values are `^[A-Z]{3}$`',
    `drg_code` STRING COMMENT 'CMS Diagnosis-Related Group code associated with the procedure. Used for reimbursement benchmarking and procedure-level cost analysis against expected DRG payment.. Valid values are `^[0-9]{3}$`',
    `effective_date` DATE COMMENT 'Date from which this BOM version is approved and active for use in OR case cart preparation and supply requisitions.',
    `estimated_case_duration_min` STRING COMMENT 'Standard estimated duration of the surgical procedure in minutes. Used for OR scheduling, staffing planning, and supply consumption rate estimation.',
    `estimated_implant_cost` DECIMAL(18,2) COMMENT 'Estimated cost attributable specifically to implantable devices within this BOM. Separated from general supply cost to support implant cost tracking, vendor negotiations, and UDI compliance reporting.',
    `estimated_supply_cost` DECIMAL(18,2) COMMENT 'Total estimated cost of all supplies, implants, and consumables listed in this BOM at standard unit costs. Used for procedure-level cost analysis, budgeting, and value-based purchasing (VBP) initiatives.',
    `expiration_date` DATE COMMENT 'Date after which this BOM version is no longer valid for use. Null indicates the BOM is open-ended with no planned expiration. Supports version lifecycle management.',
    `implant_required_flag` BOOLEAN COMMENT 'Indicates whether this BOM includes one or more implantable devices requiring UDI tracking and implant log documentation per FDA regulations. Triggers implant-specific workflows in the OR.',
    `item_count` STRING COMMENT 'Total number of distinct line items (supplies, implants, instruments, consumables) included in this BOM. Provides a quick summary metric for BOM complexity and case cart preparation effort.',
    `last_reviewed_date` DATE COMMENT 'Date this BOM was most recently reviewed by clinical or supply chain staff for accuracy, item availability, and cost relevance. Supports periodic review compliance requirements.',
    `notes` STRING COMMENT 'Free-text field for clinical or supply chain notes related to this BOM, such as special handling instructions, vendor-specific requirements, or known substitution constraints.',
    `or_room_type` STRING COMMENT 'Type of operating room or procedural suite required for this procedure. Determines room-specific supply requirements and equipment availability for BOM fulfillment.. Valid values are `standard_or|hybrid_or|cath_lab|endoscopy_suite|interventional_radiology|ambulatory_surgery`',
    `patient_position` STRING COMMENT 'Standard patient positioning required for this procedure (e.g., supine, prone, lateral decubitus, lithotomy). Determines positioning equipment and padding supplies included in the BOM. [ENUM-REF-CANDIDATE: supine|prone|lateral_decubitus|lithotomy|trendelenburg|reverse_trendelenburg|sitting|jackknife — promote to reference product]',
    `procedure_category` STRING COMMENT 'Clinical category grouping for the procedure (e.g., Orthopedic, Cardiovascular, Neurosurgery, General Surgery, Gynecology). Used for OR supply planning and service line reporting. [ENUM-REF-CANDIDATE: orthopedic|cardiovascular|neurosurgery|general_surgery|gynecology|urology|ophthalmology|plastics|thoracic|vascular — promote to reference product]',
    `procedure_name` STRING COMMENT 'Internal clinical name of the surgical procedure as used within the facilitys OR scheduling and EHR systems (e.g., Laparoscopic Cholecystectomy). May differ slightly from the CPT description.',
    `recall_review_required_flag` BOOLEAN COMMENT 'Indicates whether any item in this BOM is currently subject to an active FDA recall or safety alert, requiring review before case cart preparation proceeds.',
    `review_frequency_days` STRING COMMENT 'Scheduled frequency in days at which this BOM must be reviewed and validated (e.g., 180 for semi-annual, 365 for annual). Drives compliance review scheduling.',
    `source_system_bom_code` STRING COMMENT 'The native identifier of this BOM record in the originating operational system (e.g., Epic OpTime BOM ID, Infor Lawson BOM number). Enables cross-system reconciliation and ETL traceability.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this BOM was sourced or is maintained (e.g., Epic OpTime, Cerner SurgiNet, Infor Lawson, SAP MM). Supports data lineage and ETL traceability.. Valid values are `EPIC_OPTIME|CERNER_SURGINET|INFOR_LAWSON|SAP_MM|MEDITECH|MANUAL`',
    `sterile_processing_required_flag` BOOLEAN COMMENT 'Indicates whether instruments or reusable items in this BOM require sterile processing (decontamination, sterilization) prior to case use. Triggers sterile processing department (SPD) workflows.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether item-level substitutions are permitted when a listed supply is unavailable. When true, substitution rules defined at the BOM line level may be applied during case cart building.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was most recently modified. Supports change tracking, audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    CONSTRAINT pk_surgical_bom PRIMARY KEY(`surgical_bom_id`)
) COMMENT 'Bill of Materials (BOM) for surgical and procedural cases, defining the standard set of supplies, implants, instruments, and consumables required for each procedure type. Captures procedure code (CPT), service line, preference card reference, item list with standard quantities, substitution rules, and cost estimates. Enables OR supply preparation, case cart building, and procedure-level cost analysis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`case_cart` (
    `case_cart_id` BIGINT COMMENT 'Unique surrogate identifier for each surgical case cart record in the supply chain system. Primary key for the case_cart data product.',
    `care_site_id` BIGINT COMMENT 'Identifier of the hospital or surgical facility where the case cart is assembled and used.',
    `clinician_id` BIGINT COMMENT 'Identifier of the primary surgeon for the associated surgical case, used to link case cart supply usage to surgeon-level preference card accuracy and cost analytics.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Surgical case carts are charged to OR cost centers for departmental supply cost tracking, case costing, and surgeon/procedure profitability analysis. Essential for OR financial management.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Case carts are assembled for specific surgical procedures identified by CPT codes. Links actual supply usage to procedure codes for cost-per-case analysis, variance reporting, and reimbursement reconc',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Case carts assembled to fulfill specific surgical orders (preference card execution). Direct operational link between supply preparation and clinical order for charge capture, waste tracking, and supp',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Surgical case carts are assembled based on patient coverage - certain implants/supplies are only used if covered by patients plan. Real business process: pre-surgical authorization verification and s',
    `or_suite_id` BIGINT COMMENT 'Identifier of the Operating Room (OR) to which this case cart is assigned for the scheduled surgical procedure.',
    `employee_id` BIGINT COMMENT 'Identifier of the sterile processing technician or supply chain staff member who assembled and picked the case cart items.',
    `recall_notice_id` BIGINT COMMENT 'Foreign key linking to supply.recall_notice. Business justification: case_cart has recall_flag. If a case cart is flagged for recall (item in cart is subject to active recall), it should link to the specific recall_notice for traceability and to enable notification wor',
    `surgical_bom_id` BIGINT COMMENT 'Foreign key linking to supply.surgical_bom. Business justification: case_cart has preference_card_id and bom_version attributes indicating it references a surgical BOM template. surgical_bom defines standard supply sets for procedures. This is N:1 (many case carts ref',
    `surgical_case_id` BIGINT COMMENT 'Reference to the scheduled surgical case for which this case cart was assembled. Links supply chain to surgical scheduling (OpTime/SurgiNet).',
    `tertiary_case_delivered_by_employee_id` BIGINT COMMENT 'Identifier of the staff member who physically transported and delivered the case cart to the Operating Room (OR).',
    `assembly_complete_timestamp` TIMESTAMP COMMENT 'Date and time when the case cart assembly was completed and verified by sterile processing staff.',
    `assembly_location` STRING COMMENT 'Name or code of the sterile processing department (SPD) or supply room where the case cart was assembled (e.g., Central Sterile Processing, Satellite SPD-North).',
    `assembly_start_timestamp` TIMESTAMP COMMENT 'Date and time when sterile processing staff began physically assembling and picking items for this case cart.',
    `assembly_status` STRING COMMENT 'Granular status of the physical picking and assembly process within sterile processing, distinct from the overall cart lifecycle status.. Valid values are `pending|in_progress|complete|incomplete|verified`',
    `cart_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the physical case cart by sterile processing or supply chain. Used for barcode scanning and physical tracking.. Valid values are `^CC-[A-Z0-9]{4,20}$`',
    `cart_status` STRING COMMENT 'Current lifecycle state of the case cart from initial request through assembly, delivery, use, and return. [ENUM-REF-CANDIDATE: requested|in_assembly|assembled|delivered|in_use|returned|cancelled — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this case cart record was first created in the supply chain system, representing the initial cart request.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this case cart record (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `delivery_confirmation_flag` BOOLEAN COMMENT 'Indicates whether delivery of the case cart to the Operating Room (OR) has been formally confirmed by OR staff, completing the chain of custody.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time the assembled case cart was physically delivered to the assigned Operating Room (OR) or holding area, confirmed by delivery staff.',
    `expiration_check_flag` BOOLEAN COMMENT 'Indicates whether all items on the case cart have been verified for expiration date compliance prior to delivery. False indicates expiration verification is incomplete.',
    `implant_flag` BOOLEAN COMMENT 'Indicates whether this case cart contains one or more implantable devices subject to Unique Device Identifier (UDI) tracking requirements under FDA regulations.',
    `items_picked_count` STRING COMMENT 'Total number of distinct line items actually picked and placed on the case cart during assembly. Compared against items_requested_count to identify shortages.',
    `items_requested_count` STRING COMMENT 'Total number of distinct line items requested on the case cart pick list per the surgeon preference card or BOM (Bill of Materials).',
    `items_returned_count` STRING COMMENT 'Number of distinct item lines returned to supply chain or sterile processing after the surgical procedure, used for post-case reconciliation and restocking.',
    `items_wasted_count` STRING COMMENT 'Number of distinct item lines disposed of as waste post-procedure (opened but unused, contaminated, or expired during the case), used for waste tracking and cost analysis.',
    `missing_item_count` STRING COMMENT 'Number of distinct line items that were requested but could not be fulfilled during case cart assembly, providing granularity beyond the binary missing_item_flag.',
    `missing_item_flag` BOOLEAN COMMENT 'Indicates whether one or more requested items could not be picked and are missing from the assembled case cart. True signals a potential patient safety or surgical delay risk.',
    `notes` STRING COMMENT 'Free-text field for sterile processing or supply chain staff to document special instructions, exceptions, substitution rationale, or other relevant information about this case cart.',
    `or_room_name` STRING COMMENT 'Human-readable name or designation of the Operating Room (OR) assigned to this case cart (e.g., OR-7, Main OR Suite 3).',
    `priority_level` STRING COMMENT 'Operational priority assigned to this case cart assembly request, reflecting the urgency of the associated surgical procedure (e.g., elective routine vs. emergent trauma).. Valid values are `routine|urgent|emergent|stat`',
    `procedure_type` STRING COMMENT 'Classification of the surgical procedure for which this case cart is assembled (e.g., orthopedic, cardiac, general surgery, neurosurgery). Drives item selection and BOM (Bill of Materials) requirements.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether any item on this case cart is subject to an active product recall. Triggers immediate hold and substitution workflows per recall management protocols.',
    `return_timestamp` TIMESTAMP COMMENT 'Date and time the case cart was returned to sterile processing or supply chain after the surgical procedure concluded, initiating post-case reconciliation.',
    `scheduled_procedure_date` DATE COMMENT 'Calendar date on which the surgical procedure linked to this case cart is scheduled to occur. Used for assembly lead-time planning and par-level replenishment.',
    `scheduled_procedure_time` TIMESTAMP COMMENT 'Precise date and time the surgical procedure is scheduled to begin, used for delivery timing and sterile processing workflow sequencing.',
    `sterility_verified_flag` BOOLEAN COMMENT 'Indicates whether the sterility of all applicable items on the case cart has been confirmed by sterile processing staff prior to delivery to the OR.',
    `substitution_count` STRING COMMENT 'Number of distinct item substitutions made during case cart assembly, used for supply chain performance analysis and preference card accuracy tracking.',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether one or more items on the case cart were substituted with an equivalent alternative due to stockout, recall, or expiration of the originally requested item.',
    `total_supply_cost` DECIMAL(18,2) COMMENT 'Total cost of all supplies included in the case cart based on item unit costs at time of assembly. Used for surgical case costing, DRG (Diagnosis-Related Group) profitability analysis, and RCM (Revenue Cycle Management).',
    `case_cart_type` STRING COMMENT 'Classification of the case cart indicating whether it was assembled from a standard preference card, customized for a specific patient, added on during a procedure, or assembled for an emergency case.. Valid values are `standard|custom|add_on|emergency`',
    `udi_required_flag` BOOLEAN COMMENT 'Indicates whether Unique Device Identifier (UDI) documentation is required for one or more items on this case cart, triggering mandatory UDI capture workflows per FDA regulations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this case cart record was last modified, supporting audit trail and change tracking requirements.',
    `waste_cost` DECIMAL(18,2) COMMENT 'Total supply cost of items wasted or disposed of post-procedure, calculated from item unit costs. Used for supply chain cost management and surgical service line analytics.',
    CONSTRAINT pk_case_cart PRIMARY KEY(`case_cart_id`)
) COMMENT 'Operational record for each surgical case cart assembled by sterile processing and supply chain for a scheduled surgical procedure. Captures case cart number, linked surgical case, OR room, scheduled procedure date, assembly status, items picked vs. items requested, missing item flags, substitution actions, delivery confirmation, and return/waste reconciliation post-case. Bridges supply chain with surgical scheduling and sterile processing workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` (
    `sterile_processing_record_id` BIGINT COMMENT 'Unique system-generated identifier for each sterile processing and reprocessing record within the Sterile Processing Department (SPD). Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility (hospital, surgical center) where the sterile processing activity was performed.',
    `case_cart_id` BIGINT COMMENT 'Foreign key linking to supply.case_cart. Business justification: Sterile processing records prepare instrument sets for specific surgical cases. case_cart is the operational record for case supply assembly. Linking sterile_processing_record to case_cart provides tr',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Sterilized instrument sets prepared for specific scheduled surgical orders. Links sterile processing workflow to clinical order for OR readiness, quality assurance, and turnaround time tracking.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier of the specific sterilizer unit (autoclave, ETO chamber, hydrogen peroxide sterilizer) used for this cycle. Enables equipment-level traceability and maintenance correlation.',
    `employee_id` BIGINT COMMENT 'Identifier of the SPD technician who performed or supervised the sterilization cycle for this record. Used for accountability and traceability per Joint Commission standards.',
    `recall_notice_id` BIGINT COMMENT 'Foreign key linking to supply.recall_notice. Business justification: sterile_processing_record has recall_flag and recall_reason. If an instrument set or sterilization consumable is recalled, the record should link to recall_notice for full context. recall_reason detai',
    `material_master_id` BIGINT COMMENT 'add column supply_material_master_id (BIGINT) with FK to supply.material_master.material_master_id - sterile processing tracks specific instruments/materials but lacks a material_master FK',
    `surgical_case_id` BIGINT COMMENT 'Reference to the surgical case or OR procedure for which this instrument set was processed and dispatched. Enables traceability from sterilization record back to the clinical procedure.',
    `assembly_timestamp` TIMESTAMP COMMENT 'Date and time when the instrument set was assembled and inspected prior to packaging and sterilization. Supports full lifecycle tracking from decontamination through sterilization.',
    `biological_indicator_lot` STRING COMMENT 'Lot number of the biological indicator product used in this sterilization cycle. Required for traceability and documentation per AAMI and Joint Commission standards.',
    `biological_indicator_result` STRING COMMENT 'Result of the biological indicator (BI) spore test used to verify sterilization efficacy. A pass (negative growth) confirms sterilization; fail (positive growth) triggers load recall. not_required applies to cycles exempt from BI testing per protocol.. Valid values are `pass|fail|pending|not_required`',
    `bowie_dick_result` STRING COMMENT 'Result of the Bowie-Dick (air removal) test performed on pre-vacuum steam sterilizers to verify adequate air removal and steam penetration. Required daily before first processed load on pre-vacuum sterilizers.. Valid values are `pass|fail|not_applicable`',
    `chemical_indicator_result` STRING COMMENT 'Result of the chemical indicator (CI) used to monitor sterilization process parameters. Chemical indicators provide immediate visual confirmation that sterilization conditions were met, complementing biological indicator testing.. Valid values are `pass|fail|not_used`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sterile processing record was first created in the system. Audit trail field for data governance and compliance.',
    `cycle_number` STRING COMMENT 'Sequential cycle number assigned by the sterilizer unit for the specific run. Combined with sterilizer_id and sterilization_date, provides a unique reference for the physical sterilization event.',
    `cycle_type` STRING COMMENT 'The specific cycle program used within the sterilization method (e.g., gravity displacement, pre-vacuum/dynamic air removal, flash/immediate-use steam sterilization (IUSS), low-temperature). Determines exposure time and temperature parameters.. Valid values are `gravity|pre_vacuum|flash|immediate_use|low_temperature`',
    `decontamination_method` STRING COMMENT 'The decontamination protocol applied to the instrument set prior to sterilization (e.g., manual wash, automated washer-disinfector, ultrasonic cleaner). Documents the cleaning phase of the reprocessing cycle.. Valid values are `manual_wash|automated_washer|ultrasonic|washer_disinfector|combination`',
    `decontamination_timestamp` TIMESTAMP COMMENT 'Date and time when the decontamination (cleaning) phase was completed for the instrument set. Establishes the start of the clean/sterile processing workflow.',
    `expiration_date` DATE COMMENT 'Date after which the sterility of the instrument set can no longer be guaranteed and the set must be reprocessed before use. Determined by packaging type, storage conditions, and facility policy per AAMI event-related sterility guidelines.',
    `exposure_temperature_c` DECIMAL(18,2) COMMENT 'The sterilization chamber temperature in degrees Celsius recorded during the exposure phase of the cycle. Validated against cycle type parameters to confirm sterilization efficacy.',
    `exposure_time_minutes` DECIMAL(18,2) COMMENT 'Duration in minutes of the sterilization exposure phase for this cycle. Must meet minimum exposure time requirements per sterilization method and cycle type.',
    `immediate_use_flag` BOOLEAN COMMENT 'Indicates whether this sterilization cycle was performed as Immediate Use Steam Sterilization (IUSS / flash sterilization) for an urgent clinical need. IUSS is subject to additional documentation and justification requirements per Joint Commission and AAMI standards.',
    `inspection_notes` STRING COMMENT 'Free-text notes documenting findings from the instrument set inspection, including specific instruments flagged for damage, missing items, or functional defects identified during assembly.',
    `inspection_result` STRING COMMENT 'Result of the visual and functional inspection performed during assembly to verify instrument cleanliness, integrity, and functionality. fail or conditional results require instrument removal or repair before sterilization.. Valid values are `pass|fail|conditional`',
    `instrument_count` STRING COMMENT 'Total number of individual instruments included in the set or tray at the time of assembly and sterilization. Used to verify completeness against the Bill of Materials (BOM) for the set.',
    `iuss_justification` STRING COMMENT 'Clinical justification documented for performing Immediate Use Steam Sterilization (IUSS). Required by The Joint Commission when IUSS is used; must document the reason the set could not be processed through standard sterilization workflow.',
    `lifecycle_status` STRING COMMENT 'Current stage of the instrument set in its full reprocessing lifecycle: OR use → decontamination → assembly → sterilization → storage → dispatched. Enables real-time tracking of set location and readiness. [ENUM-REF-CANDIDATE: in_use|decontamination|assembly|sterilization|storage|dispatched|expired|recalled — promote to reference product]',
    `load_number` STRING COMMENT 'Unique alphanumeric identifier assigned to a specific sterilizer load or batch. Used to trace all items processed together in a single sterilization cycle. Critical for recall management and lot traceability.',
    `packaging_type` STRING COMMENT 'Type of packaging used to wrap or contain the instrument set for sterilization and sterile storage. Packaging type affects sterility maintenance duration and event-related sterility shelf life.. Valid values are `peel_pouch|wrapped_muslin|wrapped_nonwoven|rigid_container|tyvek_pouch`',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Chamber pressure in pounds per square inch (PSI) recorded during the sterilization cycle. Applicable primarily to steam sterilization; used to validate cycle parameters.',
    `quality_assurance_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this sterilization record has been reviewed and approved by a quality assurance supervisor or SPD lead as part of the facilitys quality management program.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this sterilization load has been subject to a recall event due to failed biological indicator, sterilizer malfunction, or packaging compromise. True triggers notification and retrieval of all items in the load.',
    `release_status` STRING COMMENT 'Current release status of the instrument set following sterilization. released indicates the set is cleared for clinical use; quarantined holds the set pending biological indicator results; recalled indicates a load recall event; rejected indicates failed cycle parameters.. Valid values are `released|quarantined|recalled|pending_bi|rejected`',
    `reprocessing_cycle_count` STRING COMMENT 'Cumulative number of times this instrument set has been reprocessed (sterilized) over its lifetime. Used to monitor instrument set wear, compliance with manufacturer reprocessing limits, and maintenance scheduling.',
    `set_code` STRING COMMENT 'Facility-assigned alphanumeric code uniquely identifying the instrument set type within the CDM (Charge Description Master) or supply catalog. Used for inventory and billing alignment.',
    `set_name` STRING COMMENT 'Human-readable name of the surgical instrument set or tray (e.g., Basic Laparoscopy Set, Orthopedic Hip Tray). Used for identification and workflow routing in the SPD.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this sterilization record was sourced (e.g., Infor Lawson Supply Chain, SAP MM, Cerner SurgiNet, Epic OpTime, or manual entry). Supports data lineage and ETL traceability.. Valid values are `infor_lawson|sap_mm|cerner|epic|meditech|manual`',
    `sterilization_method` STRING COMMENT 'The sterilization modality applied to the instrument set. Common methods include steam (autoclave), ethylene oxide (ETO), hydrogen peroxide (plasma), dry heat, peracetic acid (Steris), and radiation. Governs cycle parameters and biological indicator requirements. [ENUM-REF-CANDIDATE: steam|ethylene_oxide|hydrogen_peroxide|dry_heat|peracetic_acid|radiation|formaldehyde — promote to reference product]. Valid values are `steam|ethylene_oxide|hydrogen_peroxide|dry_heat|peracetic_acid|radiation`',
    `sterilization_timestamp` TIMESTAMP COMMENT 'Date and time when the sterilization cycle was initiated or completed for this load. The principal business event timestamp for this record. Used for expiration date calculation and traceability.',
    `storage_location` STRING COMMENT 'Physical location where the sterilized instrument set is stored after release (e.g., sterile core room, OR storage cabinet, SPD shelf designation). Used for inventory management and retrieval.',
    `tray_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the assembled instrument tray in kilograms at the time of sterilization. Used to verify compliance with maximum tray weight limits per AAMI guidelines (typically ≤ 25 lbs / 11.3 kg) to ensure steam penetration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this sterile processing record was last modified. Supports audit trail, change tracking, and incremental data loading in the lakehouse Silver layer.',
    `washer_lot_number` STRING COMMENT 'Lot or cycle number assigned by the automated washer-disinfector used during the decontamination phase. Enables traceability of the cleaning cycle for quality and compliance audits.',
    CONSTRAINT pk_sterile_processing_record PRIMARY KEY(`sterile_processing_record_id`)
) COMMENT 'Record of sterilization and reprocessing activities for reusable surgical instrument sets, trays, and medical devices managed by the Sterile Processing Department (SPD). Captures instrument set identity (set name, code, instrument count), sterilization method (steam, ETO, hydrogen peroxide), cycle parameters, biological indicator results, load number, technician, sterilization date, expiration date, release status, tray weight, decontamination protocol, and current lifecycle status. Supports instrument set tracking through the full cycle: OR use → decontamination → assembly → sterilization → storage. Compliant with Joint Commission and AAMI sterilization standards.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` (
    `recall_notice_id` BIGINT COMMENT 'Unique surrogate identifier for each recall notice record in the healthcare supply chain system. Primary key for the recall_notice data product.',
    `employee_id` BIGINT COMMENT 'Reference to the supply chain or materials management employee responsible for managing the recall response, including inventory assessment, quarantine, patient impact review, and remediation coordination.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the recalled product is held in inventory or was used on patients. Supports facility-level patient impact assessment and remediation.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Product recalls require formal corrective action plans for FDA and accreditation compliance (quarantine, patient notification, vendor remediation). Supply chain and quality teams link recalls to CAPs ',
    `consent_event_id` BIGINT COMMENT 'FDA-assigned recall event identifier from the FDA Enforcement Report or CDRH recall database. Enables direct cross-referencing with the FDA public recall database for regulatory compliance and audit purposes.',
    `material_master_id` BIGINT COMMENT 'Reference to the supply chain item master record for the recalled product, medical device, or implant. Links to the item catalog for inventory impact assessment.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Recall notifications are transmitted to trading partners, HIEs, and public health agencies via HL7 messages. Tracks outbound recall notification transmissions for regulatory compliance and patient saf',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Payers require notification of recalls affecting their members for risk management and potential claims review. Real business process: regulatory reporting to payers for implantable device recalls, co',
    `public_health_report_id` BIGINT COMMENT 'Foreign key linking to interoperability.public_health_report. Business justification: FDA MedWatch reporting and public health surveillance require recall data submission. Links recalls to their regulatory report submissions for compliance tracking and audit trail.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or manufacturer who issued or is subject to the recall. Used to link recall notices to vendor master records for notification and remediation tracking.',
    `affected_lot_number_range` STRING COMMENT 'Lot number or range of lot numbers affected by the recall as specified in the recall notice. Used to identify specific inventory batches and patient implant records that require assessment. May be a single lot, a range (e.g., LOT001-LOT050), or a pattern.',
    `affected_serial_number_range` STRING COMMENT 'Serial number or range of serial numbers affected by the recall as specified in the recall notice. Applicable for serialized devices and implants. Complements lot number range for precise device identification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall notice record was first created in the system. Supports audit trail requirements and recall response timeline tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of financial credit or reimbursement expected or received from the vendor for recalled products returned or destroyed. Expressed in USD. Used for accounts payable reconciliation and financial impact reporting.',
    `expiration_date_range_end` DATE COMMENT 'End of the expiration date range for products affected by the recall. Used with expiration_date_range_start to bound the affected expiration window for inventory identification.',
    `expiration_date_range_start` DATE COMMENT 'Start of the expiration date range for products affected by the recall. Supports identification of recalled items in inventory by expiration date when lot numbers are not available.',
    `fda_notice_date` DATE COMMENT 'Date the FDA publicly issued or posted the recall notice in the FDA Enforcement Report or MedWatch system. Used to track regulatory publication timelines and ensure timely organizational response.',
    `financial_credit_expected` BOOLEAN COMMENT 'Indicates whether the healthcare organization expects a financial credit or replacement from the vendor for returned or destroyed recalled products. Triggers accounts payable and procurement follow-up workflows.',
    `health_hazard_assessment` STRING COMMENT 'FDA or manufacturer health hazard evaluation narrative describing the potential clinical consequences of using the recalled product. Informs clinical decision-making and patient notification priority. Sourced from the official recall notice.',
    `implantable_device_flag` BOOLEAN COMMENT 'Indicates whether the recalled product is an implantable medical device subject to UDI tracking and mandatory patient implant registry requirements. Triggers enhanced patient impact assessment and long-term follow-up workflows.',
    `internal_notes` STRING COMMENT 'Free-text field for supply chain staff to document internal observations, escalation notes, communication logs, or special handling instructions related to the recall response. Not transmitted externally.',
    `internal_receipt_date` DATE COMMENT 'Date the healthcare organizations supply chain or materials management team internally received and logged the recall notice. Marks the start of the internal response workflow and is distinct from the vendor notification date.',
    `manufacture_date_range_end` DATE COMMENT 'End of the manufacture date range for products affected by the recall. Used with manufacture_date_range_start to bound the affected production window for inventory and implant identification.',
    `manufacture_date_range_start` DATE COMMENT 'Start of the manufacture date range for products affected by the recall. Used in conjunction with manufacture_date_range_end to identify inventory and implanted devices by production date when lot/serial numbers are unavailable.',
    `patient_impact_assessment_status` STRING COMMENT 'Current status of the clinical review to determine whether any patients received or were implanted with the recalled product. Drives patient notification workflows and adverse event reporting. Required for Class I and Class II recalls.. Valid values are `Not Started|In Progress|Completed|Not Applicable`',
    `patient_notification_date` DATE COMMENT 'Date on which affected patients were notified of the recall and any required clinical follow-up actions. Null if patient notification is not required or not yet completed. Required for regulatory audit documentation.',
    `patient_notification_required` BOOLEAN COMMENT 'Indicates whether affected patients must be notified of the recall per FDA guidance, clinical risk assessment, or organizational policy. True for Class I recalls and high-risk Class II recalls involving implanted devices.',
    `patients_affected_count` STRING COMMENT 'Number of patients identified as having received, been implanted with, or otherwise exposed to the recalled product. Populated upon completion of the patient impact assessment. Drives patient notification and clinical follow-up workflows.',
    `product_code` STRING COMMENT 'Manufacturer or FDA product code identifying the specific product line or model subject to recall. Used for cross-referencing with the item master and FDA product classification database.',
    `product_name` STRING COMMENT 'Commercial or trade name of the recalled medical supply, device, implant, or pharmaceutical product as stated in the recall notice. Provides human-readable identification for clinical and supply chain staff.',
    `quantity_destroyed` STRING COMMENT 'Number of units of the recalled product that have been destroyed or disposed of on-site per recall instructions. Required for regulatory documentation when return to vendor is not feasible.',
    `quantity_on_hand_affected` STRING COMMENT 'Total quantity of the recalled product currently held in the facilitys inventory that falls within the affected lot, serial, or date range. Used to assess inventory exposure and plan quarantine and return logistics.',
    `quantity_quarantined` STRING COMMENT 'Number of units of the recalled product that have been physically quarantined or placed on hold in inventory pending disposition. Tracks remediation progress against the total affected quantity on hand.',
    `quantity_returned_to_vendor` STRING COMMENT 'Number of units of the recalled product that have been returned to the vendor or manufacturer as part of the recall remediation process. Supports return merchandise authorization (RMA) tracking and financial credit reconciliation.',
    `recall_class` STRING COMMENT 'FDA-defined classification indicating the severity of health risk posed by the recalled product. Class I: serious adverse health consequences or death; Class II: temporary or medically reversible adverse health consequences; Class III: unlikely to cause adverse health consequences.. Valid values are `Class I|Class II|Class III`',
    `recall_initiation_source` STRING COMMENT 'Identifies who initiated the recall action. Distinguishes between FDA-mandated recalls, voluntary manufacturer recalls, distributor-initiated recalls, Group Purchasing Organization (GPO) alerts, and state health department notifications.. Valid values are `FDA Mandatory|Manufacturer Voluntary|Distributor|GPO|State Health Department`',
    `recall_number` STRING COMMENT 'Official FDA-assigned or manufacturer-assigned recall identification number. Used as the primary external reference for cross-referencing with FDA MedWatch, regulatory databases, and vendor communications. Example: Z-1234-2024.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `recall_reason_code` STRING COMMENT 'Standardized code categorizing the root cause or reason for the recall (e.g., sterility failure, labeling error, device malfunction, contamination, software defect). Aligns with FDA recall reason classification codes for regulatory reporting. [ENUM-REF-CANDIDATE: Sterility Failure|Labeling Error|Device Malfunction|Contamination|Software Defect|Packaging Defect|Material Defect|Design Defect|Manufacturing Defect|Other — promote to reference product]',
    `recall_reason_description` STRING COMMENT 'Detailed narrative description of the reason for the recall as stated in the official recall notice. Provides clinical and supply chain staff with the full context of the safety concern, defect, or hazard identified.',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall notice within the healthcare organization. Tracks progression from initial receipt through assessment, remediation, and closure. Supports regulatory reporting and patient safety workflows.. Valid values are `Open|Under Review|Remediation In Progress|Closed|Terminated`',
    `recall_type` STRING COMMENT 'Category of the recall action. Distinguishes between mandatory FDA recalls, voluntary market withdrawals, safety alerts, field corrections (in-place remediation), and hazard alerts issued by the manufacturer or FDA.. Valid values are `Recall|Market Withdrawal|Safety Alert|Field Correction|Hazard Alert`',
    `regulatory_report_date` DATE COMMENT 'Date on which the regulatory report was submitted to the FDA, CMS, or other applicable governing body. Null if not yet submitted. Required for compliance audit trails.',
    `regulatory_report_submitted` BOOLEAN COMMENT 'Indicates whether the required regulatory report (e.g., FDA MedWatch 3500A, CMS adverse event report) has been submitted to the applicable governing body. Required for Class I and Class II recalls and adverse event reporting compliance.',
    `remediation_action` STRING COMMENT 'Prescribed or completed remediation action for the recalled product as directed by the FDA or manufacturer recall notice. Determines the disposition workflow for affected inventory and guides supply chain response. [ENUM-REF-CANDIDATE: Return to Vendor|Destroy On-Site|Relabel|Repair|Replace|Quarantine Pending|No Action Required — 7 candidates stripped; promote to reference product]',
    `remediation_completion_date` DATE COMMENT 'Date on which all required remediation actions (quarantine, return, destruction, replacement) were completed for this recall notice. Marks the operational closure of the recall response and is required for regulatory reporting.',
    `response_due_date` DATE COMMENT 'Deadline by which the healthcare organization must complete its recall response, including inventory quarantine, patient impact assessment, and remediation actions. Typically defined by FDA guidance or internal policy based on recall class.',
    `source_document` STRING COMMENT 'Reference to the original recall notice document, such as an FDA Enforcement Report URL, manufacturer letter reference number, or document management system identifier. Provides traceability to the authoritative source of the recall.',
    `udi_device_identifier` STRING COMMENT 'The fixed portion of the Unique Device Identifier (UDI) that identifies the specific version or model of the recalled medical device. Conforms to FDA UDI system requirements for implantable and high-risk device tracking.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the recalled product quantities (e.g., EA=Each, BX=Box, CS=Case, PK=Pack, VL=Vial, KT=Kit). Ensures consistent quantity reporting across inventory, quarantine, return, and destruction counts.. Valid values are `EA|BX|CS|PK|VL|KT`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall notice record was last modified. Tracks the most recent update to recall status, quantities, assessment results, or remediation actions. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vendor_notification_date` DATE COMMENT 'Date on which the vendor or manufacturer formally notified the healthcare organization of the recall. Establishes the start of the organizations response timeline and is required for regulatory compliance documentation.',
    CONSTRAINT pk_recall_notice PRIMARY KEY(`recall_notice_id`)
) COMMENT 'Record of FDA and manufacturer-initiated product recalls, safety alerts, and field corrections affecting medical supplies, devices, and implants held in inventory or already used on patients. Captures recall number, FDA recall class (I, II, III), affected UDI or lot range, recall reason, affected quantity on hand, patient impact assessment status, vendor notification date, and remediation action. Supports FDA MedWatch and patient safety notification workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the vendor contract record in the supply chain data lakehouse. Primary key for the vendor_contract data product.',
    `business_associate_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.business_associate_agreement. Business justification: Vendors accessing PHI (medical device servicing, inventory management systems, patient-specific products) require Business Associate Agreements under HIPAA. Contract management links vendor contracts ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Contracts specify default GL accounts for automated invoice coding and accrual processing. Streamlines AP workflow and ensures consistent expense classification for contracted purchases.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee (typically a Supply Chain Contracting Manager or Value Analysis Committee member) responsible for managing this contract, monitoring compliance, and executing renewals.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor, distributor, or Group Purchasing Organization (GPO) party that is the counterparty to this contract. Links to the vendor master record.',
    `administrative_fee_pct` DECIMAL(18,2) COMMENT 'Percentage of purchases under this GPO contract that the vendor remits to the GPO as an administrative fee (typically 2-3%). Relevant for GPO umbrella contracts; null for direct vendor contracts. Used for GPO fee reconciliation and OIG disclosure compliance.',
    `annual_commitment_amount` DECIMAL(18,2) COMMENT 'The minimum annual spend or purchase volume (in contract currency) committed by the healthcare organization to maintain contracted pricing and GPO compliance tier. Failure to meet this threshold may result in pricing tier downgrade or contract non-compliance.',
    `approval_date` DATE COMMENT 'Date on which the contract received final internal authorization and was approved for use in purchase order creation. Distinct from the effective_date, which is the contractual start date.',
    `base_unit_price` DECIMAL(18,2) COMMENT 'The contracted base price per unit of measure for the primary item or item category covered by this contract. For tiered contracts, this represents the first-tier or floor price. Expressed in the contract currency.',
    `compliance_threshold_pct` DECIMAL(18,2) COMMENT 'The minimum percentage of eligible purchases that must be made through this contract to maintain compliance status and contracted pricing (e.g., 80% of med-surg spend must route through the GPO contract). Monitored quarterly for GPO administrative fee reporting.',
    `contract_document_url` STRING COMMENT 'Secure URL or document management system path to the executed contract document, amendments, and supporting exhibits. Enables direct access to the legal instrument from the supply chain data product for audit and compliance review.',
    `contract_name` STRING COMMENT 'Descriptive title of the contract agreement, typically including the vendor name, product category, and contract scope (e.g., Vizient Med-Surg Consumables FY2025).',
    `contract_number` STRING COMMENT 'Externally-known, human-readable contract identifier assigned by the healthcare organization, GPO, or vendor. Used for cross-referencing in purchase orders, invoices, and GPO reporting (e.g., Vizient, Premier, HealthTrust contract numbers).',
    `contract_status` STRING COMMENT 'Current lifecycle state of the vendor contract. Drives purchasing eligibility, compliance checks, and renewal workflows. Active contracts are eligible for purchase order creation; expired or terminated contracts block new PO issuance. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the contract scope and award mechanism. Distinguishes GPO umbrella agreements (Vizient, Premier, HealthTrust), sole-source awards, competitive bid awards, local vendor contracts, distributor agreements, and emergency procurements. [ENUM-REF-CANDIDATE: gpo_umbrella|sole_source|competitive_bid|local_vendor|distributor|emergency|consignment|capital_equipment — promote to reference product]. Valid values are `gpo_umbrella|sole_source|competitive_bid|local_vendor|distributor|emergency`',
    `contract_value` DECIMAL(18,2) COMMENT 'Total estimated or committed monetary value of the contract over its full term. Used for capital planning, budget allocation, and financial reporting. May be null for open-ended or indefinite-quantity contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor contract record was first created in the supply chain system. Supports audit trail, data lineage, and compliance reporting per HIPAA and OIG requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this contract (e.g., USD, CAD). Supports multi-currency contracting for international vendors and cross-border GPO agreements.. Valid values are `^[A-Z]{3}$`',
    `diversity_classification` STRING COMMENT 'Specific diversity certification category of the vendor under this contract. MBE=Minority Business Enterprise, WBE=Women Business Enterprise, VOSB=Veteran-Owned Small Business, SDVOSB=Service-Disabled Veteran-Owned Small Business, SBE=Small Business Enterprise, HUBZone=Historically Underutilized Business Zone. Null or none if not diversity-certified. [ENUM-REF-CANDIDATE: MBE|WBE|VOSB|SDVOSB|SBE|HUBZone|none — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which the contract becomes legally binding and pricing terms are enforceable. Used to validate purchase order pricing alignment and GPO compliance windows.',
    `expiration_date` DATE COMMENT 'Date on which the contract terms cease to be enforceable. Null for evergreen or open-ended agreements. Triggers renewal workflow alerts when within the renewal_notice_days threshold.',
    `freight_terms_code` STRING COMMENT 'Freight and shipping terms governing delivery cost responsibility under this contract. Determines whether freight is included in unit price, prepaid by vendor, or charged to the healthcare organization.. Valid values are `FOB_destination|FOB_origin|prepaid|collect|prepaid_add|included`',
    `gpo_affiliation` STRING COMMENT 'Identifies the Group Purchasing Organization (GPO) umbrella under which this contract was awarded, if applicable. GPO-affiliated contracts carry member pricing and compliance commitment thresholds. Set to none for direct vendor or local contracts.. Valid values are `Vizient|Premier|HealthTrust|Provista|Intalere|none`',
    `gpo_contract_number` STRING COMMENT 'The GPO-assigned contract number for umbrella agreements (e.g., Vizient contract ID, Premier contract reference). Used for GPO compliance reporting, member pricing validation, and administrative fee reconciliation. Null for non-GPO contracts.',
    `is_diversity_spend` BOOLEAN COMMENT 'Indicates whether purchases under this contract qualify for diversity spend credit reporting (Minority-Owned, Women-Owned, Veteran-Owned, or Small Business Enterprise). Supports organizational diversity procurement reporting and regulatory compliance.',
    `is_member_pricing` BOOLEAN COMMENT 'Indicates whether this contract provides GPO member pricing, which is typically lower than list price and contingent on the organizations active GPO membership status. True for GPO umbrella contracts with member-specific pricing tiers.',
    `is_sole_source_justified` BOOLEAN COMMENT 'Indicates whether this contract was awarded as a sole-source agreement with documented justification on file (e.g., proprietary technology, clinical preference, emergency procurement). Required for OIG compliance and audit trail for non-competitive awards.',
    `notes` STRING COMMENT 'Free-text field for supply chain contracting staff to capture supplemental information, negotiation history, special conditions, or operational guidance not captured in structured fields (e.g., Vendor requires 90-day lead time for custom implants).',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code governing invoice settlement for purchases under this contract (e.g., NET30, NET60, 2/10NET30 for 2% early payment discount). Aligns with SAP S/4HANA FI payment terms configuration.',
    `price_escalation_cap_pct` DECIMAL(18,2) COMMENT 'Maximum allowable annual price increase percentage negotiated in the contract (e.g., 0.0300 = 3.00% cap). Protects the healthcare organization from uncapped vendor price increases during the contract term. Null if no escalation clause exists.',
    `pricing_tier_structure` STRING COMMENT 'Describes the pricing model applied under this contract. Fixed pricing applies a single unit price; tiered volume pricing adjusts price based on purchase volume thresholds; market basket pricing ties to a defined product mix; cost-plus adds a margin to vendor cost; fee schedule uses a published rate table; index-linked ties to a commodity or inflation index.. Valid values are `fixed|tiered_volume|market_basket|cost_plus|fee_schedule|index_linked`',
    `product_category` STRING COMMENT 'Primary supply category covered by this contract (e.g., Medical-Surgical Consumables, Implantable Devices, Pharmaceuticals, Capital Equipment, Laboratory Reagents, Sterile Processing Supplies). Aligns with the organizations supply chain taxonomy and GPO category codes.',
    `rebate_pct` DECIMAL(18,2) COMMENT 'Percentage of eligible purchases returned to the healthcare organization as a rebate from the vendor or GPO upon meeting volume or compliance thresholds. Expressed as a decimal (e.g., 0.0250 = 2.50%). Used for rebate accrual and cash flow forecasting.',
    `rebate_terms` STRING COMMENT 'Narrative description of rebate eligibility conditions, payment schedule, and calculation methodology (e.g., Quarterly rebate paid within 45 days of quarter-end upon achieving $500K spend threshold). Supplements the numeric rebate_pct field.',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to contract expiration by which the healthcare organization must provide notice of intent to renew or terminate. Drives automated renewal alert workflows in the supply chain system.',
    `renewal_term_months` STRING COMMENT 'Duration in months of each renewal period for auto-renew or manual-renew contracts. Used to project the next expiration date upon renewal execution.',
    `renewal_type` STRING COMMENT 'Specifies how the contract renews at expiration. Auto-renew contracts extend automatically unless cancelled; manual renewal requires affirmative action; evergreen contracts have no fixed end date; one-time contracts do not renew.. Valid values are `auto_renew|manual_renew|evergreen|one_time|no_renewal`',
    `sap_contract_number` STRING COMMENT 'Source system contract number from SAP S/4HANA MM (Materials Management) outline agreement or scheduling agreement. Used for cross-system reconciliation between Infor Lawson and SAP environments.',
    `sole_source_justification` STRING COMMENT 'Narrative justification for sole-source contract award, documenting the clinical, operational, or regulatory basis for non-competitive procurement (e.g., Only FDA-approved device for this indication, Physician preference item with clinical outcome data). Required when is_sole_source_justified is True.',
    `termination_date` DATE COMMENT 'Date on which the contract was early-terminated prior to its scheduled expiration_date, if applicable. Null for contracts that expire naturally. Triggers cessation of purchasing eligibility and initiates transition to alternative sourcing.',
    `termination_reason` STRING COMMENT 'Reason code for early contract termination. Supports post-termination analysis, vendor performance management, and regulatory audit trails. Null for contracts that expire naturally at expiration_date. [ENUM-REF-CANDIDATE: vendor_default|mutual_agreement|recall|regulatory_action|pricing_dispute|strategic_sourcing|other — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the vendor contract record. Used for incremental ETL processing, change detection, and audit trail maintenance.',
    `vendor_account_number` STRING COMMENT 'The healthcare organizations account number assigned by the vendor or distributor. Used for order placement, EDI transactions, and vendor portal access. Distinct from the internal vendor_id.',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'SSOT for all supply chain pricing agreements between the healthcare organization and vendors, distributors, or Group Purchasing Organizations (GPOs). Covers GPO umbrella contracts (Vizient, Premier, HealthTrust), sole-source agreements, competitive bid awards, and local vendor contracts. Captures contract number, vendor, contract type, GPO affiliation, effective and expiration dates, tier pricing structure, rebate terms, compliance commitment thresholds, member pricing, renewal status, and diversity spend credits. Consolidates both GPO-level and vendor-level pricing into a single authoritative record with contract_type distinguishing agreement scope.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`location_audit` (
    `location_audit_id` BIGINT COMMENT 'Unique identifier for this location-audit event record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to the compliance audit event',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to the inventory location being audited',
    `audit_date` DATE COMMENT 'The specific date when this inventory location was audited as part of the broader audit. Explicitly identified in detection reasoning.',
    `auditor_notes` STRING COMMENT 'Free-text notes recorded by the auditor specific to this location during this audit, capturing observations, context, or specific deficiencies.',
    `compliance_score` DECIMAL(18,2) COMMENT 'The compliance score or rating assigned to this location for this audit, typically a percentage or numeric rating. Explicitly identified in detection reasoning.',
    `corrective_action_completed_date` DATE COMMENT 'The date when corrective actions for findings at this location were verified as completed.',
    `findings_count` STRING COMMENT 'The number of audit findings or deficiencies identified at this specific location during this audit. Explicitly identified in detection reasoning.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether corrective action or follow-up is required for this location based on this audits findings. Explicitly identified in detection reasoning.',
    `location_status_at_audit` STRING COMMENT 'The operational status of the inventory location at the time of the audit, captured for historical accuracy and trend analysis.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next audit of this location, which may be accelerated based on findings from this audit. Explicitly identified in detection reasoning.',
    CONSTRAINT pk_location_audit PRIMARY KEY(`location_audit_id`)
) COMMENT 'This association product represents the Event of a compliance audit being conducted at a specific inventory location. It captures the audit findings, compliance scores, and follow-up requirements for each location-audit combination. Each record links one inventory location to one audit with attributes that exist only in the context of this specific audit event at this specific location.. Existence Justification: In healthcare compliance operations, a single audit (e.g., Joint Commission survey, OSHA inspection) routinely covers multiple inventory locations across a facility, examining controlled substance storage, temperature monitoring, sterile processing areas, and hazardous material storage. Conversely, each inventory location is subject to multiple audits over time (annual HIPAA audits, quarterly controlled substance audits, infection control surveys). The business actively manages audit findings, compliance scores, and corrective action plans at the location-audit level.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` (
    `material_policy_governance_id` BIGINT COMMENT 'Primary key for the material_policy_governance association',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to the organizational policy governing the material',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master record being governed by the policy',
    `compliance_status` STRING COMMENT 'Current compliance status of this material with respect to this policy. Tracks whether the material meets policy requirements, has been granted an exception, or is under review.',
    `effective_date` DATE COMMENT 'Date on which this policy became applicable to this specific material. May differ from the policys overall effective date if materials are phased into policy compliance.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this material has been granted a formal exception from this policys requirements. Exceptions require approval and justification.',
    `exception_justification` STRING COMMENT 'Business justification for granting a policy exception to this material. Required when exception_flag is true. Documents clinical necessity, cost considerations, or other rationale.',
    `governance_notes` STRING COMMENT 'Free-text notes documenting special considerations, historical context, or ongoing issues related to this materials governance under this policy.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this material against this policy. Calculated based on policy review cycle and material risk classification.',
    `review_date` DATE COMMENT 'Date on which this materials compliance with this policy was last reviewed. Used to track periodic compliance audits and policy adherence verification.',
    `reviewer_role` STRING COMMENT 'Role or department responsible for reviewing this materials compliance with this policy (e.g., Pharmacy Director, Value Analysis Committee, Clinical Engineering).',
    CONSTRAINT pk_material_policy_governance PRIMARY KEY(`material_policy_governance_id`)
) COMMENT 'This association product represents the governance relationship between supply items and organizational policies. It captures which policies govern which materials, tracking compliance status, exceptions, and review cycles. Each record links one material master to one policy with attributes that exist only in the context of this governance relationship.. Existence Justification: Healthcare organizations actively manage which organizational policies govern which supply items through formal governance processes. A single high-cost implantable device may be governed by multiple policies simultaneously (formulary approval policy, preference card standardization policy, value analysis policy, vendor contract policy), and a single formulary policy governs hundreds or thousands of supply items. The compliance department tracks compliance status, exceptions, and review cycles for each material-policy pairing as part of regulatory and operational governance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` (
    `vendor_site_id` BIGINT COMMENT 'Primary key for vendor_site',
    `parent_vendor_site_id` BIGINT COMMENT 'Self-referencing FK on vendor_site (parent_vendor_site_id)',
    `vendor_id` BIGINT COMMENT 'Reference to the parent vendor organization that owns this site.',
    `address_line_1` STRING COMMENT 'Primary street address line for the vendor site location.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information.',
    `city` STRING COMMENT 'City where the vendor site is located.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the vendor site location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor site record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for transactions with this vendor site.',
    `duns_number` STRING COMMENT 'Nine-digit DUNS number assigned by Dun & Bradstreet for business identification.',
    `effective_end_date` DATE COMMENT 'Date when the vendor site relationship ended or is scheduled to end. Null for active sites.',
    `effective_start_date` DATE COMMENT 'Date when the vendor site relationship became active and available for procurement.',
    `email_address` STRING COMMENT 'Primary email address for communication with the vendor site.',
    `erp_site_code` STRING COMMENT 'Vendor site identifier in the integrated ERP system (Infor Lawson or SAP MM).',
    `fax_number` STRING COMMENT 'Fax number for the vendor site, if applicable.',
    `gln_number` STRING COMMENT 'Thirteen-digit GS1 Global Location Number uniquely identifying the vendor site location.',
    `incoterms` STRING COMMENT 'Standard Incoterms code defining delivery and risk transfer terms for this vendor site.',
    `is_approved_for_medical_devices` BOOLEAN COMMENT 'Indicates whether this vendor site is approved to supply medical devices and implantable products.',
    `is_approved_for_pharmaceuticals` BOOLEAN COMMENT 'Indicates whether this vendor site is approved to supply pharmaceutical products.',
    `is_preferred_site` BOOLEAN COMMENT 'Indicates whether this vendor site is designated as a preferred sourcing location.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or compliance audit conducted at the vendor site.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor site record was last updated.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days for order fulfillment from this vendor site.',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'Minimum order value required for purchases from this vendor site.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the vendor site record.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit at the vendor site.',
    `notes` STRING COMMENT 'Free-text notes and comments about the vendor site for internal reference.',
    `on_time_delivery_percentage` DECIMAL(18,2) COMMENT 'Percentage of orders delivered on time by this vendor site, calculated over a rolling period.',
    `payment_terms` STRING COMMENT 'Standard payment terms applicable to this vendor site (e.g., Net 30, Net 60, 2/10 Net 30).',
    `performance_rating` STRING COMMENT 'Overall performance rating of the vendor site based on quality, delivery, and service metrics.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the vendor site.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendor site address.',
    `primary_contact_email` STRING COMMENT 'Direct email address for the primary contact person at the vendor site.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor site.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the primary contact person at the vendor site.',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the vendor site.',
    `quality_certification` STRING COMMENT 'Quality management system certifications held by the vendor site (e.g., ISO 9001, ISO 13485).',
    `quality_defect_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of received items from this vendor site that failed quality inspection.',
    `shipping_method` STRING COMMENT 'Primary shipping method used by this vendor site for order delivery.',
    `site_code` STRING COMMENT 'Unique business identifier code for the vendor site, used in procurement and inventory systems.',
    `site_name` STRING COMMENT 'The business name or designation of the vendor site location.',
    `site_status` STRING COMMENT 'Current operational status of the vendor site in the procurement system.',
    `site_type` STRING COMMENT 'Classification of the vendor site based on its primary business function.',
    `state_province` STRING COMMENT 'State or province where the vendor site is located.',
    `tax_identification_number` STRING COMMENT 'Tax identification number for the vendor site, used for tax reporting and compliance.',
    CONSTRAINT pk_vendor_site PRIMARY KEY(`vendor_site_id`)
) COMMENT 'Master reference table for vendor_site. Referenced by vendor_site_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_parent_location_inventory_location_id` FOREIGN KEY (`parent_location_inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_case_cart_id` FOREIGN KEY (`case_cart_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`case_cart`(`case_cart_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_source_inventory_transaction_id` FOREIGN KEY (`source_inventory_transaction_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_transaction`(`inventory_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_case_cart_id` FOREIGN KEY (`case_cart_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`case_cart`(`case_cart_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ADD CONSTRAINT `fk_supply_vendor_site_parent_vendor_site_id` FOREIGN KEY (`parent_vendor_site_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ADD CONSTRAINT `fk_supply_vendor_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Expense Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `terminology_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Terminology Mapping Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `catalog_price` SET TAGS ('dbx_business_glossary_term' = 'Catalog Price');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `catalog_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `cdm_charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Description Master (CDM) Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contract Price');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `contract_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'CI|CII|CIII|CIV|CV');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `fda_device_class` SET TAGS ('dbx_business_glossary_term' = 'FDA Device Class');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `fda_device_class` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `fda_product_code` SET TAGS ('dbx_business_glossary_term' = 'FDA Product Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `fda_product_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'formulary|non_formulary|restricted|pending_review|therapeutic_substitute');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_implantable` SET TAGS ('dbx_business_glossary_term' = 'Implantable Device Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_latex_free` SET TAGS ('dbx_business_glossary_term' = 'Latex-Free Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_sterile` SET TAGS ('dbx_business_glossary_term' = 'Sterility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_code` SET TAGS ('dbx_business_glossary_term' = 'Item Category Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('dbx_business_glossary_term' = 'Item Category Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Item Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|on_hold|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Item Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `lot_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_item_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Item Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `order_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `preferred_vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Item Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'no_recall|class_i_recall|class_ii_recall|class_iii_recall|market_withdrawal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `serial_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Tracking Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_room_temp|flammable_cabinet|biohazard');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `uom_conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Conversion Factor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Vendor Primary Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Vendor Primary Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Routing Number (ABA)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Vendor City');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract End Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Start Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contract_tier` SET TAGS ('dbx_business_glossary_term' = 'Contract Tier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contract_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|sole_source|non_contract');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `diversity_certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Certification Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `diversity_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Classification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_value_regex' = 'minority_owned|woman_owned|veteran_owned|small_business|lgbtq_owned|none');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Order Fill Rate');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `gpo_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Affiliation');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `gpo_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `gpo_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insurance Certificate Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insurance Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `minimum_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `oig_excluded_flag` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Excluded Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `oig_exclusion_checked_date` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Exclusion Check Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|check|wire|virtual_card|eft');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Rating');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-() ]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `punchout_catalog_url` SET TAGS ('dbx_business_glossary_term' = 'Punchout Catalog URL');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `punchout_catalog_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `recall_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Notification Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Remittance Email Address');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor State Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|blocked|debarred');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Identification Number (EIN/TIN)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'manufacturer|distributor|gpo_prime_vendor|pharmacy_wholesaler|service_provider|consultant');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `udi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) Capable Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_terms_code` SET TAGS ('dbx_value_regex' = 'FOB_ORIGIN|FOB_DESTINATION|PREPAID|COLLECT|PREPAID_ADD');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'open|partially_fulfilled|fully_fulfilled|over_received|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `gpo_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Order Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'not_invoiced|partially_invoiced|fully_invoiced|disputed');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `is_contract_compliant` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `is_emergency_order` SET TAGS ('dbx_business_glossary_term' = 'Emergency Order Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Order Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Order Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|emergency|standing|consignment');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_MM|INFOR_LAWSON|MEDITECH|MANUAL');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `source_system_po_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Purchase Order (PO) Key');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'pending|matched|exception|waived');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_quote_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `backorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Backorder Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `expense_type` SET TAGS ('dbx_business_glossary_term' = 'Expense Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `expense_type` SET TAGS ('dbx_value_regex' = 'direct_patient_care|indirect|capital|research|administrative');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `gpo_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `gpo_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `is_contract_item` SET TAGS ('dbx_business_glossary_term' = 'Contract Item Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `is_formulary_item` SET TAGS ('dbx_business_glossary_term' = 'Formulary Item Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `is_recall_active` SET TAGS ('dbx_business_glossary_term' = 'Active Recall Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|cancelled|closed|on_hold');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'standard|blanket_release|consignment|drop_ship|service|return');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `ship_to_location_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'LAWSON|SAP_MM|MEDITECH|MANUAL');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Awaiting Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `hipaa_privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_business_glossary_term' = 'Condition on Receipt');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_value_regex' = 'acceptable|damaged|partial|contaminated|expired');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'quantity|item_mismatch|price|condition|documentation');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `implantable_device_flag` SET TAGS ('dbx_business_glossary_term' = 'Implantable Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `inventory_update_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Update Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `recall_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^GR-[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|blocked|closed');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `sterile_processing_required` SET TAGS ('dbx_business_glossary_term' = 'Sterile Processing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_room_temp|flammable');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `temperature_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'pending|matched|exception|cleared');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_receipt_value` SET TAGS ('dbx_business_glossary_term' = 'Total Receipt Value');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_receipt_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) Device Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) Production Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|BX|CS|PK|BT|VI');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `building_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Dispensing Cabinet (ADC) Device ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `osha_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Osha Safety Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `parent_location_inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_value_regex' = 'unrestricted|badge_access|dual_key|pharmacist_only|supervisor_override');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `adc_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Automated Dispensing Cabinet (ADC) Manufacturer');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `adc_manufacturer` SET TAGS ('dbx_value_regex' = 'BD_Pyxis|Omnicell|Capsa|Aesynt|other');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `bin_aisle` SET TAGS ('dbx_business_glossary_term' = 'Bin Aisle');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `bin_shelf` SET TAGS ('dbx_business_glossary_term' = 'Bin Shelf');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|continuous');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `expiration_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Expiration Tracking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9-]{5,20}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `hazardous_material_storage` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Storage Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `hazardous_material_storage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `humidity_controlled` SET TAGS ('dbx_business_glossary_term' = 'Humidity Controlled Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `lawson_location_code` SET TAGS ('dbx_business_glossary_term' = 'Infor Lawson Location ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|under_maintenance|pending_activation');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'central_storeroom|or_supply_room|nursing_unit_closet|adc|off_site_warehouse|satellite_pharmacy');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `next_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Cycle Count Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `par_level_managed` SET TAGS ('dbx_business_glossary_term' = 'Par Level Managed Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `par_level_managed` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `par_replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Par Replenishment Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `par_replenishment_method` SET TAGS ('dbx_value_regex' = 'manual|automated_adc|cart_exchange|periodic_automatic_replenishment|demand_based');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-s()]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `recall_management_enabled` SET TAGS ('dbx_business_glossary_term' = 'Recall Management Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `recall_management_enabled` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_value_regex' = 'daily|twice_daily|weekly|biweekly|on_demand|shift_based');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Storage Location Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `secure_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Secure Storage Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `sterile_processing_staging` SET TAGS ('dbx_business_glossary_term' = 'Sterile Processing Staging Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Cubic Feet)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Units)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_room_temperature|ultra_low_frozen');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `udi_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identification (UDI) Tracking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `inventory_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Balance ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `balance_snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Balance Snapshot Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `below_reorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Below Reorder Point Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `consignment_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Consignment Vendor Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `days_to_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiration');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `formulary_flag` SET TAGS ('dbx_business_glossary_term' = 'Formulary Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|blocked|restricted|recalled|expired|quarantine');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Movement Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_physical_count_qty` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `lot_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `max_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|consignment|loaner|demo|leased');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_on_order` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Order');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_quarantine` SET TAGS ('dbx_business_glossary_term' = 'Quantity in Quarantine');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `qty_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'par|kanban|min_max|manual|vendor_managed');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `serial_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Tracking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `source_record_key` SET TAGS ('dbx_business_glossary_term' = 'Source Record Key');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `stockout_flag` SET TAGS ('dbx_business_glossary_term' = 'Stockout Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `storage_bin` SET TAGS ('dbx_business_glossary_term' = 'Storage Bin');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `storage_bin` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `udi_code` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|BX|CS|PK|BG|DZ');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transaction Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `case_cart_id` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `recall_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Notice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `source_inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `count_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Variance Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `count_variance_value` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Variance Value');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `count_variance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `destination_storage_location` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Document Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Item Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Transaction Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `issuing_department_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Department Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `material_document_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `movement_category` SET TAGS ('dbx_business_glossary_term' = 'Inventory Movement Category');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Type Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `movement_type_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Type Description');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `par_location_code` SET TAGS ('dbx_business_glossary_term' = 'PAR Location Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Material Document Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_MM|INFOR_LAWSON|MEDITECH|MANUAL');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `sterile_processing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sterile Processing Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transaction Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending|error');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `udi_code` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `recall_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Recall ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `surgical_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[0-9]{2})$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `clinical_justification` SET TAGS ('dbx_business_glossary_term' = 'Clinical Justification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `expiration_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Expiration Tracking Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `fulfilled_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'stock_pull|direct_purchase|consignment|loaner|transfer');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `is_capital_expense` SET TAGS ('dbx_business_glossary_term' = 'Capital Expense Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `is_par_triggered` SET TAGS ('dbx_business_glossary_term' = 'Par-Level Auto-Replenishment Trigger Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `is_recall_related` SET TAGS ('dbx_business_glossary_term' = 'Recall-Related Requisition Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `needed_by_date` SET TAGS ('dbx_business_glossary_term' = 'Needed By Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{8,12}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requester_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Natural Key');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `sterile_processing_required` SET TAGS ('dbx_business_glossary_term' = 'Sterile Processing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requisition Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Item Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'par_replenishment|ad_hoc|surgical_case|direct_purchase|emergency');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `udi_required` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('dbx_subdomain' = 'clinical_supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) Record ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Implant Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Implanting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DI)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Device Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `explant_date` SET TAGS ('dbx_business_glossary_term' = 'Explant Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `explant_reason` SET TAGS ('dbx_business_glossary_term' = 'Explant Reason');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `gmdn_code` SET TAGS ('dbx_business_glossary_term' = 'Global Medical Device Nomenclature (GMDN) Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `implant_date` SET TAGS ('dbx_business_glossary_term' = 'Implant Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `implant_site` SET TAGS ('dbx_business_glossary_term' = 'Implant Anatomical Site');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `implant_status` SET TAGS ('dbx_business_glossary_term' = 'Implant Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `implant_status` SET TAGS ('dbx_value_regex' = 'available|implanted|explanted|wasted|recalled|quarantined');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `implantable_flag` SET TAGS ('dbx_business_glossary_term' = 'Implantable Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'UDI Issuing Agency');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_value_regex' = 'GS1|HIBCC|ICCBBA|IFA');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Implant Laterality');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Current Storage Location Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacture Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `mdr_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Device Report (MDR) Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `production_identifier` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (PI)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'FDA Recall Classification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Recall Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `recall_remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Remediation Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `recall_remediation_status` SET TAGS ('dbx_value_regex' = 'pending|notified|returned|replaced|destroyed|no_action_required');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `receiving_date` SET TAGS ('dbx_business_glossary_term' = 'Device Receiving Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `single_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Use Device (SUD) Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `sterile_flag` SET TAGS ('dbx_business_glossary_term' = 'Sterile Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Required Storage Condition');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'room_temperature|refrigerated|frozen|controlled_room_temperature|protect_from_light');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `storage_condition` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_carrier_aidc` SET TAGS ('dbx_business_glossary_term' = 'UDI Carrier Automatic Identification and Data Capture (AIDC)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `udi_carrier_hrf` SET TAGS ('dbx_business_glossary_term' = 'UDI Carrier Human Readable Form (HRF)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('dbx_subdomain' = 'clinical_supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `surgical_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Bill of Materials (BOM) ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `preference_card_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Card ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `facility_service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `order_set_id` SET TAGS ('dbx_business_glossary_term' = 'Standardized Order Set Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `tertiary_surgical_supply_chain_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Owner Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `tertiary_surgical_supply_chain_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `tertiary_surgical_supply_chain_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_value_regex' = 'general|regional|local|monitored_anesthesia_care|neuraxial');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_name` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_value_regex' = '^BOM-[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|superseded|retired');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `case_cart_template_flag` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Template Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `estimated_case_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Estimated Case Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `estimated_implant_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implant Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `estimated_implant_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `estimated_supply_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Supply Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `estimated_supply_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `implant_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Implant Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'BOM Item Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `or_room_type` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Room Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `or_room_type` SET TAGS ('dbx_value_regex' = 'standard_or|hybrid_or|cath_lab|endoscopy_suite|interventional_radiology|ambulatory_surgery');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `patient_position` SET TAGS ('dbx_business_glossary_term' = 'Patient Position');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_category` SET TAGS ('dbx_business_glossary_term' = 'Procedure Category');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `procedure_name` SET TAGS ('dbx_business_glossary_term' = 'Procedure Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `recall_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `source_system_bom_code` SET TAGS ('dbx_business_glossary_term' = 'Source System BOM ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'EPIC_OPTIME|CERNER_SURGINET|INFOR_LAWSON|SAP_MM|MEDITECH|MANUAL');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `sterile_processing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sterile Processing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('dbx_subdomain' = 'clinical_supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `case_cart_id` SET TAGS ('dbx_business_glossary_term' = 'Case Cart ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Surgeon ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilling Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Room ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assembled By Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `recall_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Notice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `surgical_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Bom Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `tertiary_case_delivered_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delivered By Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `tertiary_case_delivered_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `tertiary_case_delivered_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `assembly_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assembly Complete Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `assembly_location` SET TAGS ('dbx_business_glossary_term' = 'Assembly Location');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `assembly_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assembly Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `assembly_status` SET TAGS ('dbx_business_glossary_term' = 'Assembly Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `assembly_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|complete|incomplete|verified');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `cart_number` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `cart_number` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `delivery_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `expiration_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Expiration Check Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `implant_flag` SET TAGS ('dbx_business_glossary_term' = 'Implantable Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `items_picked_count` SET TAGS ('dbx_business_glossary_term' = 'Items Picked Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `items_requested_count` SET TAGS ('dbx_business_glossary_term' = 'Items Requested Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `items_returned_count` SET TAGS ('dbx_business_glossary_term' = 'Items Returned Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `items_wasted_count` SET TAGS ('dbx_business_glossary_term' = 'Items Wasted Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `missing_item_count` SET TAGS ('dbx_business_glossary_term' = 'Missing Item Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `missing_item_flag` SET TAGS ('dbx_business_glossary_term' = 'Missing Item Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `or_room_name` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Room Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|stat');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `procedure_type` SET TAGS ('dbx_business_glossary_term' = 'Surgical Procedure Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Return Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `scheduled_procedure_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Procedure Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `sterility_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sterility Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `substitution_count` SET TAGS ('dbx_business_glossary_term' = 'Item Substitution Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Item Substitution Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `total_supply_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Supply Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `total_supply_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `case_cart_type` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `case_cart_type` SET TAGS ('dbx_value_regex' = 'standard|custom|add_on|emergency');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `udi_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `waste_cost` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Waste Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ALTER COLUMN `waste_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` SET TAGS ('dbx_subdomain' = 'clinical_supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `sterile_processing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Sterile Processing Record ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `case_cart_id` SET TAGS ('dbx_business_glossary_term' = 'Case Cart Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared For Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Sterilizer Unit ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sterile Processing Technician Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `recall_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Notice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Case ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `assembly_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instrument Set Assembly Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `biological_indicator_lot` SET TAGS ('dbx_business_glossary_term' = 'Biological Indicator Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `biological_indicator_result` SET TAGS ('dbx_business_glossary_term' = 'Biological Indicator (BI) Result');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `biological_indicator_result` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not_required');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `bowie_dick_result` SET TAGS ('dbx_business_glossary_term' = 'Bowie-Dick Test Result');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `bowie_dick_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `chemical_indicator_result` SET TAGS ('dbx_business_glossary_term' = 'Chemical Indicator (CI) Result');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `chemical_indicator_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_used');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Sterilizer Cycle Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Cycle Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'gravity|pre_vacuum|flash|immediate_use|low_temperature');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `decontamination_method` SET TAGS ('dbx_business_glossary_term' = 'Decontamination Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `decontamination_method` SET TAGS ('dbx_value_regex' = 'manual_wash|automated_washer|ultrasonic|washer_disinfector|combination');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `decontamination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decontamination Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Sterility Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `exposure_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Exposure Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `exposure_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Exposure Time (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `immediate_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Immediate Use Steam Sterilization (IUSS) Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Instrument Inspection Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Instrument Set Inspection Result');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `instrument_count` SET TAGS ('dbx_business_glossary_term' = 'Instrument Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `iuss_justification` SET TAGS ('dbx_business_glossary_term' = 'Immediate Use Steam Sterilization (IUSS) Justification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Instrument Set Lifecycle Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `load_number` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Load Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Packaging Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'peel_pouch|wrapped_muslin|wrapped_nonwoven|rigid_container|tyvek_pouch');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Chamber Pressure (PSI)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `quality_assurance_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewed Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Load Recall Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Sterile Release Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'released|quarantined|recalled|pending_bi|rejected');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `reprocessing_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Instrument Set Reprocessing Cycle Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument Set Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `set_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Set Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'infor_lawson|sap_mm|cerner|epic|meditech|manual');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_value_regex' = 'steam|ethylene_oxide|hydrogen_peroxide|dry_heat|peracetic_acid|radiation');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `sterilization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Sterile Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `tray_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Instrument Tray Weight (Kilograms)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ALTER COLUMN `washer_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Washer-Disinfector Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Notice ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `consent_event_id` SET TAGS ('dbx_business_glossary_term' = 'FDA Recall Event ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Notified Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_business_glossary_term' = 'Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `affected_lot_number_range` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Number Range');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `affected_serial_number_range` SET TAGS ('dbx_business_glossary_term' = 'Affected Serial Number Range');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Recall Credit Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `expiration_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Affected Expiration Date Range End');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `expiration_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Affected Expiration Date Range Start');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `fda_notice_date` SET TAGS ('dbx_business_glossary_term' = 'FDA Notice Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `financial_credit_expected` SET TAGS ('dbx_business_glossary_term' = 'Financial Credit Expected Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Assessment');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `health_hazard_assessment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `implantable_device_flag` SET TAGS ('dbx_business_glossary_term' = 'Implantable Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Recall Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `internal_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Recall Receipt Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `manufacture_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Affected Manufacture Date Range End');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `manufacture_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Affected Manufacture Date Range Start');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `patient_impact_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Impact Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `patient_impact_assessment_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Not Applicable');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `patient_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `patients_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Patients Affected Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Recalled Product Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Recalled Product Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_destroyed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Destroyed');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_on_hand_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand Affected');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_quarantined` SET TAGS ('dbx_business_glossary_term' = 'Quantity Quarantined');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `quantity_returned_to_vendor` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned to Vendor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'FDA Recall Class');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_initiation_source` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Source');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_initiation_source` SET TAGS ('dbx_value_regex' = 'FDA Mandatory|Manufacturer Voluntary|Distributor|GPO|State Health Department');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'Open|Under Review|Remediation In Progress|Closed|Terminated');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'Recall|Market Withdrawal|Safety Alert|Field Correction|Hazard Alert');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `regulatory_report_submitted` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Response Due Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `source_document` SET TAGS ('dbx_business_glossary_term' = 'Recall Notice Source Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `udi_device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI) — Device Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|BX|CS|PK|VL|KT');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ALTER COLUMN `vendor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Default Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `administrative_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Administrative Fee Percentage');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `administrative_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `annual_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Commitment Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `annual_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `base_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `base_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `compliance_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Compliance Commitment Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `compliance_threshold_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'gpo_umbrella|sole_source|competitive_bid|local_vendor|distributor|emergency');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Classification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `freight_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `freight_terms_code` SET TAGS ('dbx_value_regex' = 'FOB_destination|FOB_origin|prepaid|collect|prepaid_add|included');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Affiliation');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_affiliation` SET TAGS ('dbx_value_regex' = 'Vizient|Premier|HealthTrust|Provista|Intalere|none');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `gpo_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `is_diversity_spend` SET TAGS ('dbx_business_glossary_term' = 'Diversity Spend Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `is_member_pricing` SET TAGS ('dbx_business_glossary_term' = 'Member Pricing Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `is_sole_source_justified` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Justification Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `price_escalation_cap_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Cap Percentage');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `price_escalation_cap_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Structure');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_value_regex' = 'fixed|tiered_volume|market_basket|cost_plus|fee_schedule|index_linked');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `rebate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `rebate_terms` SET TAGS ('dbx_business_glossary_term' = 'Rebate Terms');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `rebate_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto_renew|manual_renew|evergreen|one_time|no_renewal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `sap_contract_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `sole_source_justification` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Justification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `sole_source_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Account Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('dbx_association_edges' = 'supply.inventory_location,compliance.audit');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `location_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Location Audit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Location Audit - Audit Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Audit - Inventory Location Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `location_status_at_audit` SET TAGS ('dbx_business_glossary_term' = 'Location Status at Audit');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('dbx_association_edges' = 'supply.material_master,compliance.policy');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_policy_governance_id` SET TAGS ('dbx_business_glossary_term' = 'Material Policy Governance - Material Policy Governance Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Material Policy Governance - Policy Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Policy Governance - Material Master Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Material Policy Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date for Material');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Exception Indicator');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Policy Exception Justification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `governance_notes` SET TAGS ('dbx_business_glossary_term' = 'Material Policy Governance Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Material Policy Review Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Material Policy Review Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Policy Compliance Reviewer');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `parent_vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Vendor Site Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `parent_vendor_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Duns Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `erp_site_code` SET TAGS ('dbx_business_glossary_term' = 'Erp Site Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `gln_number` SET TAGS ('dbx_business_glossary_term' = 'Gln Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `is_approved_for_medical_devices` SET TAGS ('dbx_business_glossary_term' = 'Is Approved For Medical Devices');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `is_approved_for_medical_devices` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `is_approved_for_medical_devices` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `is_approved_for_pharmaceuticals` SET TAGS ('dbx_business_glossary_term' = 'Is Approved For Pharmaceuticals');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `is_preferred_site` SET TAGS ('dbx_business_glossary_term' = 'Is Preferred Site');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `minimum_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `on_time_delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Percentage');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `on_time_delivery_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `quality_defect_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `quality_defect_rate_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
