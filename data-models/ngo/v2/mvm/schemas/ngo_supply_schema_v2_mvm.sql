-- Schema for Domain: supply | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-10 20:23:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`supply` COMMENT 'Manages the humanitarian supply chain including procurement, warehousing, inventory of NFIs (Non-Food Items) and medical supplies, last-mile logistics, vendor management, commodity pipelines, in-kind donations, distribution planning, and emergency relief commodities to support field delivery operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`commodity` (
    `commodity_id` BIGINT COMMENT 'Unique identifier for the humanitarian commodity or relief item in the supply chain master catalog.',
    `commodity_category` STRING COMMENT 'Primary classification of the commodity by humanitarian sector or program area (e.g., shelter, health, nutrition, WASH, food, education, protection, NFI general, emergency relief). [ENUM-REF-CANDIDATE: shelter|health|nutrition|wash|food|education|protection|nfi_general|emergency_relief|other — 10 candidates stripped; promote to reference product]',
    `commodity_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the commodity item across procurement, warehousing, and distribution systems. Often aligned with UNSPSC or internal cataloging standards.. Valid values are `^[A-Z0-9]{6,20}$`',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether the commodity requires continuous temperature-controlled storage and transport (cold chain) from procurement through distribution, typical for vaccines and certain medical supplies.',
    `commodity_status` STRING COMMENT 'Current lifecycle status of the commodity in the master catalog (e.g., active for procurement and distribution, inactive, discontinued, pending approval, restricted use).. Valid values are `active|inactive|discontinued|pending_approval|restricted`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where the commodity is manufactured or produced, relevant for customs, import regulations, and donor reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the commodity record was first created in the master catalog system, following organizational timestamp format.',
    `commodity_description` STRING COMMENT 'Detailed textual description of the commodity including specifications, intended use, and any special characteristics relevant to field operations and beneficiary distribution.',
    `donor_restricted_flag` BOOLEAN COMMENT 'Indicates whether the commodity is subject to donor-imposed restrictions on use, distribution geography, or beneficiary eligibility, requiring compliance tracking in distribution planning.',
    `donor_restriction_notes` STRING COMMENT 'Free-text description of specific donor restrictions or conditions attached to the commodity, including geographic limitations, beneficiary eligibility criteria, or usage constraints.',
    `effective_end_date` DATE COMMENT 'Date after which the commodity record is no longer active for procurement and distribution, supporting lifecycle management and historical tracking. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'Date from which the commodity record becomes active and available for procurement and distribution operations, supporting temporal validity tracking.',
    `harmonized_tariff_code` STRING COMMENT 'International Harmonized System (HS) tariff classification code for the commodity, used for customs clearance, import/export documentation, and duty calculation.',
    `hazard_classification` STRING COMMENT 'Specific hazard classification code or category (e.g., flammable, corrosive, toxic, biohazard) if the commodity is flagged as hazardous material, following UN or GHS standards.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the commodity is classified as hazardous material requiring special handling, storage, and transport procedures per international safety standards.',
    `in_kind_donation_eligible_flag` BOOLEAN COMMENT 'Indicates whether the commodity is eligible to be received as an in-kind donation from corporate or individual donors, subject to organizational acceptance policies and quality standards.',
    `kit_assembly_flag` BOOLEAN COMMENT 'Indicates whether the commodity is a pre-assembled kit or bundle composed of multiple component items (e.g., hygiene kit, shelter kit, medical kit) rather than a single item.',
    `kit_component_count` STRING COMMENT 'Number of distinct component items included in the kit or assembly if the commodity is flagged as a kit, used for bill of materials tracking and inventory management.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who most recently modified the commodity record, supporting audit trail and data governance requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the commodity record was most recently updated or modified, following organizational timestamp format.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or producer of the commodity, important for quality assurance, traceability, and compliance with donor or regulatory requirements.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturer-assigned part number or model identifier for the commodity, used for precise specification matching and procurement accuracy.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from suppliers per procurement transaction, driven by vendor requirements or economic order quantity considerations.',
    `commodity_name` STRING COMMENT 'Full descriptive name of the humanitarian commodity or relief item as it appears in procurement documents and distribution manifests.',
    `procurement_lead_time_days` STRING COMMENT 'Average number of days required from purchase order issuance to commodity receipt at warehouse, used for supply chain planning and emergency response preparedness.',
    `quality_certification` STRING COMMENT 'Quality certifications or standards compliance held by the commodity (e.g., ISO, WHO prequalification, FDA approval, CE marking), ensuring safety and efficacy for humanitarian use.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level threshold that triggers automatic reorder or procurement action to maintain adequate stock for field operations and emergency response.',
    `shelf_life_days` STRING COMMENT 'Number of days the commodity remains usable and safe from the date of manufacture or receipt, critical for inventory rotation and distribution planning.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling, storage, or transport requirements not captured in structured fields, including fragility, orientation, stacking limits, or security considerations.',
    `sphere_compliant_flag` BOOLEAN COMMENT 'Indicates whether the commodity meets Sphere Humanitarian Charter and Minimum Standards for quality, safety, and appropriateness in humanitarian response.',
    `standard_unit_cost` DECIMAL(18,2) COMMENT 'Standard or average cost per unit of measure for the commodity, used for budgeting, procurement planning, and financial reporting. Currency is organizational default unless otherwise specified.',
    `storage_humidity_max_percent` DECIMAL(18,2) COMMENT 'Maximum relative humidity percentage allowed in storage environment to prevent commodity degradation, mold, or spoilage.',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius required to maintain commodity integrity and safety, particularly critical for medical supplies and cold-chain items.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius required to maintain commodity integrity and safety, particularly critical for medical supplies and cold-chain items.',
    `subcategory` STRING COMMENT 'Secondary classification providing finer granularity within the primary commodity category (e.g., within WASH: hygiene kits, water purification tablets, sanitation supplies).',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure used for inventory tracking, procurement, and distribution of the commodity (e.g., each, box, carton, pallet, kg, liter, meter, set, kit, dose). [ENUM-REF-CANDIDATE: each|box|carton|pallet|kg|liter|meter|set|kit|dose|vial|bottle|bag|roll — 14 candidates stripped; promote to reference product]',
    `volume_per_unit_cubic_meters` DECIMAL(18,2) COMMENT 'Volume in cubic meters occupied by a single unit of the commodity, used for warehouse space planning, transport capacity optimization, and last-mile logistics.',
    `weight_per_unit_kg` DECIMAL(18,2) COMMENT 'Weight in kilograms of a single unit of the commodity, used for logistics planning, freight cost calculation, and warehouse capacity management.',
    CONSTRAINT pk_commodity PRIMARY KEY(`commodity_id`)
) COMMENT 'Master catalog of all humanitarian commodities and relief items managed in the supply chain, including NFIs (Non-Food Items), medical supplies, WASH materials, food commodities, shelter materials, and emergency relief goods. Defines item specifications, unit of measure, commodity category (e.g., shelter, health, nutrition, WASH), SPHERE standards compliance, shelf life, storage requirements (temperature, humidity), hazardous classification, kit/assembly composition (bill of materials for NFI kits), cold-chain requirements, donor restrictions, and procurement lead time. This is the SSOT for all commodity definitions used across procurement, warehousing, and distribution.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Unique identifier for the warehouse facility in the humanitarian supply network.',
    `country_office_id` BIGINT COMMENT 'Reference to the country office that manages this warehouse facility.',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization operating this warehouse, if applicable.',
    `access_restrictions` STRING COMMENT 'Description of any access restrictions or special requirements for entering the warehouse facility.',
    `address_line1` STRING COMMENT 'Primary street address line of the warehouse facility.',
    `address_line2` STRING COMMENT 'Secondary address line for additional location details such as building or unit number.',
    `admin_level_1` STRING COMMENT 'First-level administrative division (state, province, region) where the warehouse is located.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (district, county) where the warehouse is located.',
    `city` STRING COMMENT 'City or municipality where the warehouse is located.',
    `cluster_affiliation` STRING COMMENT 'Primary OCHA humanitarian cluster that this warehouse supports in emergency response operations. [ENUM-REF-CANDIDATE: logistics|health|wash|shelter|nutrition|protection|education|food_security|multi_cluster — 9 candidates stripped; promote to reference product]',
    `warehouse_code` STRING COMMENT 'Externally-known unique alphanumeric code for the warehouse facility used in logistics documentation and tracking systems.. Valid values are `^[A-Z0-9]{3,12}$`',
    `commissioning_date` DATE COMMENT 'Date when the warehouse facility was officially commissioned and became operational.',
    `contact_email` STRING COMMENT 'Primary email address for warehouse operations communication and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for reaching the warehouse contact person or operations team.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse record was first created in the system.',
    `customs_bonded` BOOLEAN COMMENT 'Indicates whether the warehouse operates as a customs bonded facility allowing duty-free storage of international goods.',
    `decommissioning_date` DATE COMMENT 'Date when the warehouse facility was decommissioned and ceased operations, if applicable.',
    `emergency_access_24_7` BOOLEAN COMMENT 'Indicates whether the warehouse can be accessed 24 hours a day, 7 days a week for emergency response operations.',
    `facility_type` STRING COMMENT 'Classification of the warehouse based on its role in the humanitarian supply network.. Valid values are `central_warehouse|field_warehouse|transit_hub|pre_positioning_depot|cold_chain_facility|mobile_storage_unit`',
    `forklift_capacity_kg` STRING COMMENT 'Maximum lifting capacity of forklifts available at the warehouse, measured in kilograms.',
    `gis_accuracy_meters` DECIMAL(18,2) COMMENT 'Accuracy of the GIS coordinates measured in meters, indicating the precision of the location data.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the warehouse is certified to store hazardous materials according to international standards.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety, security, or compliance inspection of the warehouse facility.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the warehouse facility in decimal degrees for GIS mapping and logistics planning.',
    `loading_docks_count` STRING COMMENT 'Number of loading docks available at the warehouse for receiving and dispatching cargo.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the warehouse facility in decimal degrees for GIS mapping and logistics planning.',
    `managing_entity` STRING COMMENT 'Type of entity responsible for the day-to-day management and operation of the warehouse facility.. Valid values are `direct_operation|partner_managed|government_shared|consortium|third_party_logistics`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse record was last modified in the system.',
    `warehouse_name` STRING COMMENT 'Official name of the warehouse facility as recognized by the organization and partners.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations regarding the warehouse facility and its operations.',
    `operational_hours` STRING COMMENT 'Standard operating hours of the warehouse facility including days and times of operation.',
    `operational_status` STRING COMMENT 'Current operational state of the warehouse facility in its lifecycle.. Valid values are `operational|under_construction|temporarily_closed|decommissioned|standby|emergency_activated`',
    `ownership_type` STRING COMMENT 'Legal ownership or usage arrangement for the warehouse facility.. Valid values are `owned|leased|donated|government_provided|temporary_use`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the warehouse location.',
    `security_level` STRING COMMENT 'Security classification level of the warehouse based on threat assessment and protection measures in place.. Valid values are `minimal|low|medium|high|maximum`',
    `storage_capacity_m3` DECIMAL(18,2) COMMENT 'Total storage capacity of the warehouse measured in cubic meters (m³).',
    `storage_capacity_pallets` STRING COMMENT 'Total storage capacity of the warehouse measured in standard pallet positions.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the warehouse has temperature control capability for cold-chain commodities.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature that can be maintained in the warehouse for cold-chain storage, measured in degrees Celsius.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature that can be maintained in the warehouse for cold-chain storage, measured in degrees Celsius.',
    `wms_system_name` STRING COMMENT 'Name of the warehouse management system software used to track inventory and operations at this facility.',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master record for all physical storage facilities in the humanitarian supply network including central warehouses, field warehouses, transit hubs, pre-positioning depots, and cold-chain facilities. Captures location (GIS coordinates, country, admin level), storage capacity (m³, pallets), facility type, operational status, managing entity, temperature control capability, and OCHA cluster affiliation. Supports last-mile logistics planning and inventory positioning.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key for the vendor entity.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Many vendors are partner organizations (local NGOs, CBOs). Critical for due diligence integration—vendor screening must reference partnership capacity assessments, risk registers, and accreditation re',
    `address_line_1` STRING COMMENT 'First line of the vendors primary business address, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'Second line of the vendors primary business address, typically containing building, suite, or unit information.',
    `bank_account_number` STRING COMMENT 'The vendors primary bank account number for payment processing and fund transfers.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the vendors primary bank account is held.',
    `bank_swift_code` STRING COMMENT 'SWIFT/BIC code of the vendors bank, used for international wire transfers and cross-border payments.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `blacklist_effective_date` DATE COMMENT 'The date when the vendor blacklist or debarment status became effective.',
    `blacklist_expiry_date` DATE COMMENT 'The date when the vendor blacklist or debarment status expires, after which the vendor may be eligible for reinstatement (nullable for permanent debarments).',
    `blacklist_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether the vendor is currently blacklisted or debarred from humanitarian procurement due to fraud, corruption, poor performance, or ethical violations.',
    `blacklist_reason` STRING COMMENT 'Detailed explanation of why the vendor was blacklisted or debarred, including the nature of the violation and the decision authority.',
    `city` STRING COMMENT 'City or municipality where the vendors primary business address is located.',
    `vendor_code` STRING COMMENT 'Internal unique alphanumeric code assigned to the vendor for procurement and supply chain operations.',
    `commodity_categories` STRING COMMENT 'Comma-separated list of commodity categories that the vendor supplies, such as NFI (Non-Food Items), medical supplies, WASH (Water Sanitation and Hygiene) equipment, shelter materials, food commodities, or logistics services.',
    `country_of_operation` STRING COMMENT 'Primary country where the vendor operates or is registered, using ISO 3166-1 alpha-3 country code (e.g., USA, GBR, KEN).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Preferred currency for transactions with the vendor, using ISO 4217 three-letter currency code (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fleet_size` STRING COMMENT 'Number of vehicles or transport units in the vendors fleet (applicable for transport and logistics providers). Indicates capacity for humanitarian logistics operations.',
    `gmp_certification_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether the vendor holds Good Manufacturing Practice (GMP) certification, required for pharmaceutical and medical supply vendors.',
    `humanitarian_network_membership` STRING COMMENT 'Comma-separated list of humanitarian logistics networks or consortia the vendor is a member of, such as WFP Logistics Hub Framework (LHF), UNHRD (UN Humanitarian Response Depot), or Logistics Cluster.',
    `iso_certification` STRING COMMENT 'Comma-separated list of ISO certifications held by the vendor, such as ISO 9001 (Quality Management), ISO 14001 (Environmental Management), or ISO 45001 (Occupational Health and Safety).',
    `last_performance_review_date` DATE COMMENT 'The date when the vendors performance was last formally reviewed and assessed by the procurement or supply chain team.',
    `last_performance_score` DECIMAL(18,2) COMMENT 'The most recent performance score assigned to the vendor during the last performance review, typically on a scale of 0-100 or 0-5, measuring quality, delivery, compliance, and responsiveness.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was last modified or updated in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `vendor_name` STRING COMMENT 'The full legal name of the vendor, supplier, or service provider as registered with governing authorities.',
    `payment_terms_days` STRING COMMENT 'Standard payment terms offered by the vendor, expressed as the number of days from invoice date to payment due date (e.g., 30, 60, 90 days).',
    `performance_tier` STRING COMMENT 'Classification tier based on the vendors historical performance, quality, delivery reliability, and compliance with humanitarian standards. Tier 1 represents preferred vendors with excellent track records.. Valid values are `tier_1_preferred|tier_2_approved|tier_3_conditional|tier_4_probation`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendors primary business address.',
    `prequalification_date` DATE COMMENT 'The date when the vendor successfully completed the prequalification process and was approved for humanitarian procurement.',
    `prequalification_expiry_date` DATE COMMENT 'The date when the vendors prequalification status expires and requires renewal or reassessment.',
    `prequalification_status` STRING COMMENT 'Indicates whether the vendor has completed and passed the organizations prequalification process for humanitarian procurement, ensuring compliance with quality, ethical, and operational standards.. Valid values are `prequalified|not_prequalified|pending_review|expired`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the vendor contact person used for procurement communications, purchase orders, and supply chain coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor organization for procurement and supply chain coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the vendor contact person, including country code, used for urgent procurement and logistics coordination.',
    `registration_date` DATE COMMENT 'The date when the vendor was first registered in the organizations vendor management system.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the vendors primary business address is located.',
    `tax_identification_number` STRING COMMENT 'The vendors tax identification number (TIN), VAT number, or equivalent tax registration identifier issued by the country of operation.',
    `transport_modes_offered` STRING COMMENT 'Comma-separated list of transportation modes offered by the vendor (applicable for logistics and transport providers), such as air freight, sea freight, road transport, rail transport, or last-mile delivery.',
    `un_vendor_number` STRING COMMENT 'The unique vendor registration number assigned by the United Nations Global Marketplace (UNGM) for vendors participating in UN procurement.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor in the procurement system, indicating whether the vendor is eligible for new contracts and purchase orders.. Valid values are `active|inactive|suspended|blacklisted|pending_approval|debarred`',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on the primary service or product category they provide in the humanitarian supply chain. [ENUM-REF-CANDIDATE: commodity_supplier|manufacturer|freight_forwarder|clearing_agent|trucking_company|air_cargo_operator|last_mile_delivery_partner|warehouse_operator|service_provider|customs_broker|cold_chain_provider — promote to reference product]',
    `warehouse_capacity_sqm` DECIMAL(18,2) COMMENT 'Total warehouse storage capacity in square meters available from the vendor (applicable for warehouse operators and logistics providers).',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers, vendors, service providers, and logistics operators engaged in humanitarian procurement and supply chain operations. Covers commodity suppliers, international manufacturers, freight forwarders, clearing agents, trucking companies, air cargo operators, and last-mile delivery partners. Captures vendor registration details, country of operation, commodity categories supplied, transport modes offered (where applicable), pre-qualification status, performance tier, fleet size (for transport providers), blacklist/debarment flags, UN vendor registration number, compliance certifications (e.g., ISO, GMP), and humanitarian logistics network membership (e.g., WFP LHF, UNHRD). SSOT for all supplier and service provider identity within the supply domain.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique system identifier for the purchase order record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: NGO procurement policy requires POs issued to implementing partners to reference the governing partnership agreement for financial accountability, donor reporting, and audit trail. purchase_order has ',
    `award_budget_line_id` BIGINT COMMENT 'Foreign key linking to grant.award_budget_line. Business justification: NGO financial compliance requires POs to be charged against specific award budget lines for donor expenditure reporting, NICRA compliance, and budget variance analysis. Without this FK, budget consump',
    `award_id` BIGINT COMMENT 'Reference to the donor grant or funding source that finances this purchase order. Critical for donor-restricted fund compliance and Budget versus Actual (BvA) tracking per 2 CFR 200.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: Purchase orders are charged against a specific budget plan for financial control and commitment accounting. NGO procurement policy requires POs to reference the budget plan for donor compliance report',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: NGO procurement is authorized at the component level. Purchase orders must be traceable to the approving component for budget control, donor visibility, and audit trails. Finance and supply chain team',
    `country_office_id` BIGINT COMMENT 'Reference to the country office, field office, or headquarters unit that issued this purchase order. Used for budget tracking and procurement authority validation.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency Procurement Tracking: NGO procurement teams raise purchase orders under emergency response declarations. Linking PO to emergency enables emergency procurement spend reporting, donor accounta',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Restricted funds require tracking which purchase orders are charged against them for donor compliance reporting, audit trails, and fund balance management. Fund managers must reconcile procurement spe',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program or project that requested this procurement. Links PO to program budget and donor restrictions.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGOs routinely procure from local partner organizations to support localization commitments and capacity building. Links PO to partnership agreements, due diligence records, and performance reviews. E',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Purchase orders are issued after RFQ evaluation and vendor award. This FK links the PO to the competitive bidding process that preceded it. Standard procurement workflow: procurement_request → rfq → p',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: In NGO operations, sub-recipients issue POs under their subaward. Linking purchase_order to subaward enables subaward-level expenditure tracking required for FFATA/FSRS reporting, subaward financial m',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor organization receiving this purchase order. Links to vendor master data for payment and performance tracking.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, or project site where commodities should be delivered. Used for logistics planning and goods receipt verification.',
    `actual_delivery_date` DATE COMMENT 'Date when goods were actually received and verified. Populated upon goods receipt and used for vendor on-time delivery KPI tracking.',
    `approval_workflow_status` STRING COMMENT 'Current status of the purchase order in the multi-level approval workflow. Tracks progression through procurement authority levels per delegation of authority matrix.. Valid values are `not_submitted|pending_review|approved|rejected|revision_requested`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order received final approval. Used for procurement cycle time measurement and compliance audit trail.',
    `commodity_category` STRING COMMENT 'High-level classification of commodities on this purchase order: NFI (Non-Food Items), medical supplies, food, WASH (Water Sanitation and Hygiene), shelter materials, education supplies, protection items, or logistics equipment. Used for sector-specific reporting. [ENUM-REF-CANDIDATE: nfi|medical|food|wash|shelter|education|protection|logistics — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was first created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order (e.g., USD, EUR, GBP). Used for multi-currency procurement and exchange rate tracking.. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full physical delivery address for commodity shipment. Captured for logistics coordination and proof of delivery. Organizational contact data classified as confidential.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this purchase order should be visible in donor reporting and transparency portals (e.g., IATI - International Aid Transparency Initiative). Used for public accountability and donor stewardship.',
    `emergency_flag` BOOLEAN COMMENT 'Indicates whether this purchase order was issued under emergency procurement procedures due to humanitarian crisis or disaster response. Allows expedited approval and relaxed competitive bidding requirements per CERF (Central Emergency Response Fund) guidelines.',
    `erp_document_reference` STRING COMMENT 'Reference number or document ID from the source ERP system (SAP S/4HANA, Unit4, etc.). Used for system integration, reconciliation, and audit trail back to operational system of record.',
    `expected_delivery_date` DATE COMMENT 'Vendor-committed delivery date as agreed in the purchase order. Used for goods receipt scheduling and vendor performance measurement.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Total freight, shipping, and logistics charges for delivery of commodities. Critical for last-mile logistics cost tracking.',
    `goods_receipt_status` STRING COMMENT 'Aggregate status of goods receipt across all purchase order line items. Used for three-way matching (PO-GRN-Invoice) and inventory management.. Valid values are `not_received|partially_received|fully_received|over_received|discrepancy`',
    `incoterm` STRING COMMENT 'Delivery terms defining the division of costs and risks between buyer and seller per Incoterms 2020 (e.g., DDP = Delivered Duty Paid, FOB = Free On Board). Critical for humanitarian supply chain cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_matching_status` STRING COMMENT 'Status of three-way matching between purchase order, goods receipt note, and vendor invoice. Critical for accounts payable processing and financial control per 2 CFR 200.. Valid values are `not_matched|matched|variance|blocked`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was last updated. Used for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text notes and special instructions for the vendor, logistics team, or procurement staff. May include delivery instructions, quality requirements, or donor-specific compliance notes.',
    `payment_method` STRING COMMENT 'Method by which vendor will be paid (bank transfer, wire, check, letter of credit, mobile money, cash). Used for treasury planning and compliance with donor payment restrictions.. Valid values are `bank_transfer|wire|check|letter_of_credit|mobile_money|cash`',
    `payment_terms` STRING COMMENT 'Agreed payment terms with vendor (e.g., Net 30, Net 60, 50% advance / 50% on delivery). Governs accounts payable scheduling and cash flow management.',
    `po_date` DATE COMMENT 'Date when the purchase order was officially issued to the vendor. Principal business event timestamp for procurement tracking and lead time calculation.',
    `po_number` STRING COMMENT 'Externally-known unique purchase order document number issued to vendor. Business identifier used in procurement communications and three-way matching (PO-GRN-Invoice).. Valid values are `^PO-[A-Z0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow. Tracks progression from draft through approval, issuance, goods receipt, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type: standard (one-time procurement), blanket (recurring deliveries), contract (long-term agreement), emergency (urgent humanitarian response), framework (pre-negotiated terms).. Valid values are `standard|blanket|contract|emergency|framework`',
    `procurement_method` STRING COMMENT 'Method used to select the vendor: competitive bidding, request for quotation (RFQ), sole source justification, framework agreement, or emergency procurement waiver. Required for donor compliance and audit trail per 2 CFR 200.. Valid values are `competitive_bidding|request_for_quotation|sole_source|framework_agreement|emergency_procurement`',
    `requested_delivery_date` DATE COMMENT 'Date by which the requesting program needs the commodities delivered. Used for procurement lead time planning and emergency response timeline tracking.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, duties, and freight charges. Base procurement value for budget tracking.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount (VAT, GST, sales tax) applied to this purchase order. May be zero for tax-exempt humanitarian procurement.',
    `total_amount` DECIMAL(18,2) COMMENT 'Grand total value of the purchase order including subtotal, taxes, freight, and all other charges. Used for budget commitment and three-way matching.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Transactional record of all procurement purchase orders issued to vendors for humanitarian commodities and services, including embedded line-item detail (commodity, quantity, unit price, delivery schedule per line). Captures PO number, issuing office, vendor, line items with per-line commodity reference, ordered quantity, unit of measure, agreed unit cost, delivery location, and requested delivery date. Also records total PO value, currency, funding source (grant/donor), delivery terms (Incoterms), expected delivery date, approval workflow status, goods receipt status per line, invoice matching status, and ERP document reference. Supports BvA tracking, three-way matching (PO–GRN–Invoice), and donor-restricted fund compliance per 2 CFR 200 Uniform Guidance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding source that is financing this procurement. Used for fund accounting and donor reporting.',
    `commodity_id` BIGINT COMMENT 'Identifier of the commodity or Non-Food Item (NFI) being received. Links to the master commodity catalog.',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Goods receipts must be charged to funds for donor reporting and fund accounting. Critical for nonprofit grant compliance and restricted fund tracking.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program or project for which these goods are intended. Links supply chain to program delivery.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Goods often received by partner organizations at field locations. Establishes custody accountability, validates against partnership agreement authorized locations, supports audit trails for partner-ma',
    `project_site_id` BIGINT COMMENT 'Reference to the field project site if goods were received directly at a program location rather than a central warehouse.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods are being received. Links this receipt to the originating procurement document.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor who delivered the goods. Used for three-way matching and vendor performance tracking.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or field storage location where goods were physically received.',
    `waybill_id` BIGINT COMMENT 'Foreign key linking to supply.waybill. Business justification: Goods receipts are recorded when commodities arrive at a warehouse. The waybill is the shipping document that accompanies the delivery. The goods_receipt table has delivery_note_number (STRING) which ',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the received commodity, critical for traceability and recall management, especially for medical supplies and food items.',
    `condition_on_arrival` STRING COMMENT 'Assessment of the physical condition of the goods upon receipt. Good indicates acceptable condition, damaged indicates physical damage, expired indicates past expiry date, partial_damage indicates some units damaged, quality_issue indicates substandard quality.. Valid values are `good|damaged|expired|partial_damage|quality_issue`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this goods receipt record was first created in the database. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_date` DATE COMMENT 'Date on which the goods cleared customs and were released for delivery to the warehouse or field location.',
    `customs_cleared` BOOLEAN COMMENT 'Indicates whether the goods have cleared customs and import formalities. True if cleared, False if pending customs clearance.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether there was a discrepancy between ordered and received quantities or condition. True if discrepancy exists, False if receipt matches order exactly.',
    `discrepancy_notes` STRING COMMENT 'Detailed notes explaining any discrepancies in quantity, quality, or condition between what was ordered and what was received. Includes reasons for rejection or partial acceptance.',
    `document_number` STRING COMMENT 'The externally-known unique document number for this goods receipt, typically generated by the ERP system (e.g., SAP goods receipt document number).. Valid values are `^GR[0-9]{10}$`',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt should be included in donor reporting and visibility dashboards. True for donor-funded procurements.',
    `expiry_date` DATE COMMENT 'Manufacturer expiry or best-before date for perishable commodities, medical supplies, and food items. Critical for FEFO (First Expired First Out) inventory management.',
    `freight_charges` DECIMAL(18,2) COMMENT 'Transportation and freight costs associated with this goods receipt, if separately tracked.',
    `goods_receipt_date` DATE COMMENT 'The date on which the goods were physically received at the warehouse or field location. This is the principal business event date for this transaction.',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt transaction. Draft indicates pending finalization, posted indicates completed and inventory updated, reversed indicates a correction was applied, cancelled indicates the receipt was voided.. Valid values are `draft|posted|reversed|cancelled`',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether the received goods require formal quality inspection before being released to inventory. True for medical supplies, food items, and high-value commodities.',
    `inspection_status` STRING COMMENT 'Status of the quality inspection process. Pending indicates inspection not yet completed, passed indicates goods approved for use, failed indicates goods rejected, waived indicates inspection was not required.. Valid values are `pending|passed|failed|waived`',
    `lot_number` STRING COMMENT 'Supplier or donor lot number for the received commodity, used for tracking and quality control purposes.',
    `manufacturing_date` DATE COMMENT 'Date on which the commodity was manufactured, used to calculate shelf life and ensure quality standards.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this goods receipt record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'General notes and comments about the goods receipt, including special handling instructions, observations, or contextual information.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of the commodity that was originally ordered on the purchase order or expected from the donation.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The actual quantity of the commodity physically received and accepted at the warehouse or field location.',
    `quantity_rejected` DECIMAL(18,2) COMMENT 'The quantity of the commodity that was rejected upon receipt due to damage, expiry, or quality issues.',
    `serial_number` STRING COMMENT 'Unique serial number for individually tracked items such as medical equipment, vehicles, or high-value assets.',
    `storage_location_code` STRING COMMENT 'Specific storage location or bin within the warehouse where the received goods were placed. Used for precise inventory tracking.',
    `timestamp` TIMESTAMP COMMENT 'Precise date and time when the goods receipt was recorded in the system, including time zone information.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the goods received, calculated as quantity received multiplied by unit cost. Used for accounts payable and budget tracking.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the received commodity as stated on the purchase order or donation valuation. Used for inventory valuation and financial accounting.',
    `unit_of_measure` STRING COMMENT 'The unit in which the commodity quantity is measured. EA=Each, KG=Kilogram, LT=Liter, MT=Metric Ton, BX=Box, CS=Case, PK=Pack. [ENUM-REF-CANDIDATE: EA|KG|LT|MT|BX|CS|PK — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of commodities at a warehouse or field location against a purchase order or in-kind donation. Records receipt date, receiving warehouse, commodity, quantity received, condition on arrival (good/damaged/expired), batch/lot number, expiry date, receiving officer, discrepancy notes, and SAP goods receipt document number. Triggers inventory update and initiates three-way matching for AP payment processing.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` (
    `inventory_balance_id` BIGINT COMMENT 'Unique identifier for the inventory balance record. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Reference to the donor grant funding this inventory. Used for fund accounting and donor reporting. Links to grant master data.',
    `commodity_id` BIGINT COMMENT 'Reference to the commodity or Non-Food Item (NFI) being tracked in inventory. Links to the commodity master data.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program or project for which this inventory is allocated or reserved. Links to program master data.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or storage location where the commodity is held. Links to warehouse master data.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the commodity. Used for quality control, recall management, and traceability.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the warehouse location. Used for geographic reporting and OCHA SitRep aggregation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory balance record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the inventory valuation. Used for multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `donor_restriction_flag` BOOLEAN COMMENT 'Indicates whether this inventory is subject to donor-imposed restrictions on use, distribution, or geographic allocation. True if restricted, False if unrestricted.',
    `expiration_date` DATE COMMENT 'Expiration or best-before date for perishable commodities such as medical supplies, food, or nutrition items. Used for FEFO (First Expired First Out) distribution planning.',
    `in_kind_donation_flag` BOOLEAN COMMENT 'Indicates whether this inventory was received as an in-kind donation rather than purchased. True if in-kind donation, False if purchased. Used for donor reporting and GAAP compliance.',
    `last_movement_date` DATE COMMENT 'Date of the most recent inventory transaction (receipt, issue, transfer, or adjustment) for this balance record. Used for aging analysis and pipeline monitoring.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count for this commodity at this warehouse. Used for inventory accuracy tracking and audit compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory balance record was last modified. Used for audit trail and change tracking.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum stock capacity or target level for this commodity at this warehouse. Used for inventory optimization and storage planning.',
    `notes` STRING COMMENT 'Free-text notes or comments about this inventory balance record. Used for documenting special conditions, quality issues, or operational context.',
    `pipeline_status` STRING COMMENT 'Current status of the inventory balance in the commodity pipeline. Used for OCHA cluster reporting and pipeline gap analysis.. Valid values are `Available|Reserved|In Transit|Quarantined|Expired|Depleted`',
    `quantity_available` DECIMAL(18,2) COMMENT 'Net quantity available for new distribution allocations. Calculated as quantity_on_hand minus quantity_reserved minus quantity_quarantined.',
    `quantity_in_transit` DECIMAL(18,2) COMMENT 'Quantity currently in transit to this warehouse from suppliers or other warehouses. Not yet available for distribution.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current physical stock quantity available in the warehouse. Represents the total inventory balance at the snapshot date.',
    `quantity_quarantined` DECIMAL(18,2) COMMENT 'Quantity held in quarantine due to quality issues, expiration concerns, or pending inspection. Not available for distribution.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'Quantity allocated or reserved for planned distribution events but not yet dispatched. Reduces available stock for new allocations.',
    `reorder_level` DECIMAL(18,2) COMMENT 'Minimum stock level threshold that triggers a replenishment order. Used for pipeline management and pre-positioning decisions.',
    `snapshot_date` DATE COMMENT 'Date for which this inventory balance snapshot is recorded. Supports historical trend analysis and time-series reporting.',
    `storage_condition` STRING COMMENT 'Required storage condition for the commodity. Used for warehouse capacity planning and quality assurance.. Valid values are `Ambient|Refrigerated|Frozen|Controlled|Hazardous`',
    `total_valuation` DECIMAL(18,2) COMMENT 'Total monetary value of the inventory balance. Calculated as quantity_on_hand multiplied by unit_cost. Used for financial statements and donor reporting.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard or average cost per unit of the commodity. Used for inventory valuation and financial reporting.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the commodity quantity. Used for consistent reporting and distribution planning. [ENUM-REF-CANDIDATE: EA|KG|LTR|MTR|BOX|CARTON|PALLET|DOSE|VIAL|TABLET|KIT — 11 candidates stripped; promote to reference product]',
    `warehouse_location` STRING COMMENT 'Geographic location of the warehouse including city, region, or country. Used for logistics planning and SitRep reporting.',
    CONSTRAINT pk_inventory_balance PRIMARY KEY(`inventory_balance_id`)
) COMMENT 'Current and historical stock balance records for each commodity at each warehouse location. Captures commodity, warehouse, stock quantity on hand, quantity reserved for distribution, quantity in transit, quantity quarantined, reorder level, maximum stock level, last physical count date, and stock valuation. Supports commodity pipeline management, pre-positioning decisions, and OCHA cluster reporting on pipeline gaps.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction record. Primary key for the stock movement log.',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding source that financed the procurement or distribution of this commodity. Critical for donor reporting and fund accounting.',
    `case_record_id` BIGINT COMMENT 'Foreign key linking to beneficiary.case_record. Business justification: Stock movements document items issued for specific case management interventions (GBV dignity kits, child protection supplies, emergency assistance). Audit trail for case-based assistance. Critical fo',
    `commodity_id` BIGINT COMMENT 'Identifier of the commodity or Non-Food Item (NFI) being moved. Links to the commodity master catalog.',
    `distribution_event_id` BIGINT COMMENT 'Identifier of the beneficiary distribution event associated with this stock issue (applicable for movement_type = issue to beneficiaries). Links commodity pipeline to field delivery operations.',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Stock movements must charge funds when inventory is issued for distributions. Critical for nonprofit fund accounting and donor reporting on commodity usage.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Stock transfers to/from partner warehouses are routine in partnership arrangements. Essential for inventory accountability, validates movements against partnership agreement scope, supports partner re',
    `project_site_id` BIGINT COMMENT 'Identifier of the program or project for which this stock movement is being executed. Links commodity pipeline to program delivery for MEL reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: stock_movement currently stores purchase_order_number as a denormalized STRING field. Adding a proper FK purchase_order_id -> purchase_order.purchase_order_id normalizes this relationship, enabling re',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Stock movements track inventory transfers between warehouses or within a warehouse. The source_location_id (BIGINT) currently holds the origin warehouse reference. Renaming to source_warehouse_id and ',
    `vendor_id` BIGINT COMMENT 'Identifier of the external supplier or vendor from whom goods were received (applicable for movement_type = receipt). Null for internal movements.',
    `authorizing_officer_name` STRING COMMENT 'Full name of the staff member who authorized this stock movement. Denormalized for reporting and audit trail readability.',
    `batch_number` STRING COMMENT 'Manufacturer or supplier batch/lot number for the commodity. Critical for traceability, recall management, and quality control, especially for medical supplies and food items.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `carrier_name` STRING COMMENT 'Name of the transport carrier or logistics service provider responsible for moving the commodity (applicable for transfers and receipts). Null for internal hand-carry movements.',
    `count_team_reference` STRING COMMENT 'Reference identifier for the physical inventory count team or cycle that generated this movement record (applicable only for movement_type = physical_count). Links to physical inventory count documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was first created in the system. Part of audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost fields. Typically the organizations functional currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `donor_restriction_code` STRING COMMENT 'Classification of donor-imposed restrictions on the use of this commodity. Unrestricted = no limitations; Geographic_restricted = specific country/region only; Program_restricted = specific program use only; Beneficiary_restricted = specific beneficiary population only; Time_restricted = must be distributed within donor-specified timeframe. Critical for compliance with donor agreements.. Valid values are `unrestricted|geographic_restricted|program_restricted|beneficiary_restricted|time_restricted`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the commodity batch being moved. Critical for FEFO (First Expired First Out) inventory management, especially for medical supplies, food items, and time-sensitive NFIs.',
    `in_kind_donation_flag` BOOLEAN COMMENT 'Indicates whether this commodity was received as an in-kind donation (True) or procured through cash purchase (False). Critical for donor reporting and IATI transparency.',
    `inspection_date` DATE COMMENT 'Date on which quality inspection was performed on the commodity. Null if inspection was not required or waived.',
    `inspector_name` STRING COMMENT 'Name of the staff member or third-party inspector who performed the quality inspection. Null if inspection was not required or waived.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was last updated. Part of audit trail for data lineage and compliance.',
    `notes` STRING COMMENT 'Free-text notes or comments about this stock movement transaction. Used to capture additional context, special handling instructions, or operational observations.',
    `number` STRING COMMENT 'Externally-known unique reference number for this stock movement transaction, used for audit trail and cross-system reconciliation. Format typically includes movement type prefix and sequential number.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `quality_inspection_status` STRING COMMENT 'Result of quality inspection performed on the commodity at the time of receipt or movement. Pending = inspection not yet completed; Passed = meets quality standards; Failed = rejected; Waived = inspection requirement waived for emergency; Not_required = commodity type does not require inspection.. Valid values are `pending|passed|failed|waived|not_required`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the commodity being moved in the transaction. Always positive; movement direction is determined by movement_type. Precision supports fractional units for medical supplies and bulk commodities.',
    `reason_code` STRING COMMENT 'Standardized code explaining the business reason for the stock movement. Critical for loss analysis, donor reporting, and pipeline management. Normal_receipt = routine procurement; Emergency_receipt = rapid response; Beneficiary_distribution = direct aid delivery; Program_issue = program consumption; Inter_warehouse_transfer = logistics optimization; Count_adjustment = inventory reconciliation; Expiry/Damage/Theft/Loss_in_transit/Obsolescence = loss categories. [ENUM-REF-CANDIDATE: normal_receipt|emergency_receipt|beneficiary_distribution|program_issue|inter_warehouse_transfer|count_adjustment|expiry|damage|theft|loss_in_transit|obsolescence — 11 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text detailed explanation of the reason for the stock movement, especially for adjustments, losses, and write-offs. Provides context beyond the standardized reason code.',
    `reference_document_number` STRING COMMENT 'Unique number of the source document (GRN, waybill, distribution order, count sheet, etc.) that authorizes or records this movement. Provides full audit trail linkage.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `reference_document_type` STRING COMMENT 'Type of source document that authorizes or records this stock movement. GRN = Goods Received Note; Waybill = transport document; Distribution_order = beneficiary distribution plan; Count_sheet = physical inventory count; Adjustment_memo = correction authorization; Loss_report = documented loss/damage; Write_off_authorization = disposal approval. [ENUM-REF-CANDIDATE: GRN|waybill|distribution_order|count_sheet|adjustment_memo|loss_report|write_off_authorization — 7 candidates stripped; promote to reference product]',
    `serial_number` STRING COMMENT 'Unique serial number for individually tracked items such as medical equipment, vehicles, or high-value assets. Null for bulk commodities.',
    `stock_movement_date` DATE COMMENT 'Business date on which the stock movement occurred or is scheduled to occur. This is the operational event date, distinct from system audit timestamps.',
    `stock_movement_status` STRING COMMENT 'Current lifecycle status of the stock movement transaction. Tracks workflow state from initiation through completion or cancellation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_transit|completed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `stock_movement_type` STRING COMMENT 'Classification of the stock movement transaction. Receipt = goods received into warehouse; Issue = goods distributed/issued out; Transfer = movement between warehouses; Adjustment = correction entry; Physical_count = reconciliation from physical inventory count; Loss = documented loss/damage; Write_off = removal from inventory due to expiry/obsolescence. [ENUM-REF-CANDIDATE: receipt|issue|transfer|adjustment|physical_count|loss|write_off — 7 candidates stripped; promote to reference product]',
    `timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical stock movement was executed or recorded. Used for detailed audit trail and sequence reconstruction.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of this stock movement transaction (quantity × unit_cost), in the organizations functional currency. Used for inventory valuation, grant expenditure tracking, and donor reporting. Confidential business data.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for the shipment associated with this stock movement. Enables real-time visibility of in-transit commodities.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for this stock movement (applicable for transfers and receipts). Road = truck/vehicle; Air = aircraft; Sea = ship/barge; Rail = train; Pipeline = bulk liquid/gas; Hand_carry = manual transport for small quantities.. Valid values are `road|air|sea|rail|pipeline|hand_carry`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the commodity at the time of this movement, in the organizations functional currency. Used for inventory valuation and donor financial reporting. Confidential business data.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field. Standardized to organizational commodity catalog units. [ENUM-REF-CANDIDATE: piece|box|carton|pallet|kg|liter|meter|dose|kit|set — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional log of all inventory movements including receipts, issues, transfers between warehouses, adjustments, physical count reconciliations, losses, and write-offs. Each record captures movement type (receipt/issue/transfer/adjustment/physical_count/loss/write-off), commodity, source location, destination location, quantity, movement date, reference document (GRN/waybill/distribution order/count sheet), reason code, authorizing officer, and count team reference (for physical count adjustments). Provides full commodity pipeline audit trail for donor reporting, IATI transparency, inventory accuracy management, and loss detection.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` (
    `distribution_plan_id` BIGINT COMMENT 'Unique identifier for the distribution plan. Primary key for the distribution plan entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Distribution plans are authorized and scoped under a specific partnership agreement governing geographic scope, funding ceiling, and reporting obligations. Donor compliance audits and partner accounta',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: Grant amendments frequently trigger distribution plan revisions (scope changes, geographic changes, budget modifications). Linking distribution_plan to the triggering grant_amendment provides the audi',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding agreement that finances this distribution plan.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: Distribution plans consume budget from a specific budget plan. NGO finance teams track planned vs. actual distribution expenditure against the budget plan for donor compliance, burn-rate reporting, an',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Distribution plans are funded and scoped at the component level. NGO program officers and donors require component-level traceability of distribution plans for budget utilization reporting, sector acc',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: In multi-partner humanitarian responses, distribution plans are executed by a consortium. Linking distribution_plan to consortium enables consortium-level delivery performance reporting, pooled-fund a',
    `country_office_id` BIGINT COMMENT 'Identifier of the field office responsible for executing this distribution plan.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency Response Distribution Planning: NGO distribution plans are explicitly scoped to declared emergencies for cluster coordination reporting, flash appeal accountability, and donor earmark compli',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Distribution plans must reference budgets for cost planning, authorization, and budget availability verification. Essential for nonprofit program planning and financial control.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: NGOs formally align distribution plans to specific MEL indicators for donor reporting and results tracking. The existing plain-text mel_indicator_alignment column is a denormalization signal; a prop',
    `intervention_id` BIGINT COMMENT 'Identifier of the humanitarian program this distribution plan supports.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: A MEAL plan governs the monitoring and evaluation scope of a program, including its distribution activities. NGO MEL officers formally associate distribution plans with the governing MEAL plan to defi',
    `partner_org_id` BIGINT COMMENT 'Identifier of the partner organization (CSO, CBO, INGO) collaborating on this distribution plan.',
    `project_site_id` BIGINT COMMENT 'Identifier of the primary project site where distribution will occur.',
    `actual_end_date` DATE COMMENT 'Actual date when distribution activities were completed in the field.',
    `actual_start_date` DATE COMMENT 'Actual date when distribution activities commenced in the field.',
    `approval_date` DATE COMMENT 'Date when the distribution plan was formally approved for execution.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval is required before this distribution plan can be executed.',
    `beneficiary_category` STRING COMMENT 'Primary category of beneficiaries targeted by this distribution plan. IDP (Internally Displaced Person), PoC (Person of Concern), refugee, host community, returnee, or other vulnerable population classification.. Valid values are `idp|refugee|host_community|returnee|poc|vulnerable_population`',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO currency code for the budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `coordination_cluster` STRING COMMENT 'Humanitarian cluster or sector coordinating this distribution (e.g., Food Security, WASH, Shelter, Health, Protection).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution plan record was first created in the system.',
    `distribution_duration_days` STRING COMMENT 'Planned duration in days for the distribution activities to be completed.',
    `distribution_frequency` STRING COMMENT 'Planned frequency of distribution events under this plan (one-time, recurring weekly, monthly, etc.).. Valid values are `one_time|weekly|biweekly|monthly|quarterly|as_needed`',
    `distribution_modality` STRING COMMENT 'Method by which humanitarian commodities or assistance will be delivered to beneficiaries (direct distribution, voucher-based, cash transfer, etc.).. Valid values are `direct|voucher|cash_in_kind|mobile_money|e_voucher|hybrid`',
    `distribution_plan_status` STRING COMMENT 'Current lifecycle status of the distribution plan indicating its approval and execution state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_progress|completed|cancelled|suspended — 7 candidates stripped; promote to reference product]',
    `distribution_type` STRING COMMENT 'Classification of the distribution plan based on urgency and frequency (emergency relief, routine program distribution, seasonal support, etc.).. Valid values are `emergency|routine|seasonal|one_time|recurring`',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Estimated total budget allocated for this distribution plan including commodity costs, logistics, and operational expenses.',
    `estimated_total_volume_m3` DECIMAL(18,2) COMMENT 'Estimated total volume in cubic meters of all commodities to be distributed under this plan.',
    `estimated_total_weight_kg` DECIMAL(18,2) COMMENT 'Estimated total weight in kilograms of all commodities to be distributed under this plan.',
    `funding_source` STRING COMMENT 'Primary funding source or donor supporting this distribution plan (e.g., USAID, DFID, CERF, private donations).',
    `geographic_coverage_admin1` STRING COMMENT 'First-level administrative division (province, state, region) where distribution will occur.',
    `geographic_coverage_admin2` STRING COMMENT 'Second-level administrative division (district, county) where distribution will occur.',
    `geographic_coverage_admin3` STRING COMMENT 'Third-level administrative division (sub-district, municipality) where distribution will occur.',
    `geographic_coverage_country` STRING COMMENT 'Three-letter ISO country code where the distribution will take place.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution plan record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this distribution plan.',
    `planned_end_date` DATE COMMENT 'Scheduled date when distribution activities are planned to be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date when distribution activities are planned to begin.',
    `risk_level` STRING COMMENT 'Overall risk assessment level for this distribution plan considering security, logistics, and operational challenges.. Valid values are `low|medium|high|critical`',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goals that this distribution plan supports (e.g., SDG 1: No Poverty, SDG 2: Zero Hunger).',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether security clearance or authorization is required before distribution can proceed in the target area.',
    `target_beneficiary_count` STRING COMMENT 'Planned number of individual beneficiaries or households to be reached by this distribution plan.',
    `target_household_count` STRING COMMENT 'Planned number of households to receive assistance under this distribution plan.',
    CONSTRAINT pk_distribution_plan PRIMARY KEY(`distribution_plan_id`)
) COMMENT 'Master plan for the distribution of humanitarian commodities to beneficiaries at field locations. Captures distribution plan name, target program, geographic coverage (country/admin levels), planned distribution date range, target beneficiary count, commodity list with planned quantities per beneficiary, distribution modality (direct/voucher/cash-in-kind), responsible field office, and approval status. Links supply chain planning to field operations and MEL targets.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`distribution_order` (
    `distribution_order_id` BIGINT COMMENT 'Unique identifier for the distribution order. Primary key for the distribution order entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Distribution orders executed by implementing partners must reference the governing partnership agreement for partner accountability reporting, transport cost reconciliation against agreement funding c',
    `award_id` BIGINT COMMENT 'Reference to the specific grant or funding agreement under which this distribution order is charged. Ensures proper fund accounting and compliance.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Distribution orders are executed under a specific program component. Component-level tracking of distribution orders is required for donor reporting, budget utilization, and sector-specific accountabi',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Distribution orders are sampled during internal compliance reviews to verify beneficiary targeting, documentation completeness, and adherence to distribution protocols. Real business process: programm',
    `distribution_plan_id` BIGINT COMMENT 'Reference to the originating distribution plan that authorized this order. Links the order to the strategic distribution planning process.',
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to beneficiary.entitlement. Business justification: Entitlement-based distribution authorization: each distribution order must reference the entitlement record that authorizes the commodity release. NGO supply and compliance teams use this link to veri',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Distribution orders must be checked against budgets for authorization and budget control. Essential for nonprofit financial control and program spending oversight.',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: Distribution orders fulfill assistance to specific households. Direct operational link between supply chain execution and beneficiary delivery. Critical for household-level distribution tracking, rati',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program under which this distribution order is executed. Links order to program budget and objectives.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Distribution orders often executed by partner organizations at field level. Links execution to partnership agreements, validates against partner capacity and geographic scope, supports performance rev',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse from which commodities will be released and dispatched. Source location for stock movement.',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project site or field location where the distribution will take place. Geographic context for delivery operations.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Distribution orders deliver to individual beneficiaries (cash/voucher programs, individual assistance, protection items). Common in protection, health, and individual case management programs. Enables',
    `source_warehouse_id` BIGINT COMMENT 'Reference to the field distribution point where commodities will be delivered for beneficiary distribution. Target location for last-mile logistics.',
    `actual_delivery_date` DATE COMMENT 'Actual date when commodities were delivered to the destination distribution point. Used for performance tracking and variance analysis.',
    `approved_date` DATE COMMENT 'Date when the distribution order was officially approved by authorized personnel. Marks transition from draft to approved status.',
    `beneficiary_count` STRING COMMENT 'Estimated number of beneficiaries who will receive assistance from this distribution order. Used for impact measurement and Monitoring Evaluation and Learning (MEL) reporting.',
    `carrier_name` STRING COMMENT 'Name of the transport carrier or logistics provider responsible for delivering the commodities. May be internal fleet or third-party contractor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution order record was first created in the system. Audit trail for data lineage and compliance.',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether this distribution order requires customs clearance for cross-border shipment. Triggers customs documentation and compliance processes.',
    `customs_reference` STRING COMMENT 'Reference number for customs clearance documentation if cross-border shipment is required. Used for tracking and compliance verification.',
    `delivery_instructions` STRING COMMENT 'Special instructions or notes for the delivery of commodities to the destination distribution point. May include access constraints, security protocols, or handling requirements.',
    `dispatch_date` DATE COMMENT 'Date when commodities were physically dispatched from the issuing warehouse. Marks the start of last-mile logistics execution.',
    `distribution_order_date` DATE COMMENT 'Date when the distribution order was created and entered into the system. Business event timestamp for order initiation.',
    `distribution_order_status` STRING COMMENT 'Current lifecycle status of the distribution order. Tracks progression from draft through approval, dispatch, transit, delivery, and closure. [ENUM-REF-CANDIDATE: draft|approved|dispatched|in_transit|delivered|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `distribution_type` STRING COMMENT 'Classification of the distribution approach. General distributions serve entire populations, targeted distributions serve specific vulnerable groups, emergency distributions respond to crises.. Valid values are `general|targeted|emergency|seasonal|supplementary|blanket`',
    `driver_contact` STRING COMMENT 'Contact phone number for the driver during transit. Enables real-time communication for tracking and issue resolution during delivery.',
    `driver_name` STRING COMMENT 'Name of the driver responsible for transporting the commodities. Used for accountability and security purposes in field operations.',
    `emergency_response_flag` BOOLEAN COMMENT 'Indicates whether this distribution order is part of an emergency response operation. True for rapid-onset disaster or crisis response orders.',
    `estimated_value_usd` DECIMAL(18,2) COMMENT 'Estimated total monetary value of all commodities in this distribution order, expressed in US dollars. Used for financial tracking and donor reporting.',
    `household_count` STRING COMMENT 'Estimated number of households that will be served by this distribution order. Key metric for humanitarian assistance planning and reporting.',
    `in_kind_donation_flag` BOOLEAN COMMENT 'Indicates whether commodities in this order were received as in-kind donations rather than purchased. Affects valuation and donor acknowledgment processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution order record was last updated in the system. Audit trail for change tracking and data quality monitoring.',
    `medical_supplies_flag` BOOLEAN COMMENT 'Indicates whether this distribution order contains medical supplies or pharmaceuticals. Triggers special handling and regulatory compliance requirements.',
    `nfi_flag` BOOLEAN COMMENT 'Indicates whether this distribution order contains Non-Food Items such as shelter materials, hygiene kits, or household supplies. Used for commodity classification.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to this distribution order. Captures context, issues, or special circumstances not covered by structured fields.',
    `number` STRING COMMENT 'Human-readable unique order number assigned to this distribution order for tracking and reference purposes. Format: DO-YYYYMMDD-sequence.. Valid values are `^DO-[0-9]{8}$`',
    `priority_level` STRING COMMENT 'Priority classification of the distribution order. Determines urgency of dispatch and delivery, with emergency orders receiving expedited processing.. Valid values are `emergency|high|medium|low`',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for delivery of commodities to the destination distribution point. Used for logistics planning and beneficiary communication.',
    `special_handling_requirements` STRING COMMENT 'Specific handling requirements for commodities in this order, such as fragile items, hazardous materials, or temperature-sensitive goods. Ensures proper care during transport.',
    `total_commodity_lines` STRING COMMENT 'Total number of distinct commodity line items included in this distribution order. Summary count for order complexity assessment.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all commodities in this distribution order, expressed in standard units. Summary measure for order volume.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of all commodities in this distribution order, measured in cubic meters. Used for warehouse space and transport capacity planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of all commodities in this distribution order, measured in kilograms. Used for transport planning and capacity management.',
    `transport_cost_usd` DECIMAL(18,2) COMMENT 'Actual or estimated cost of transporting commodities from warehouse to distribution point, expressed in US dollars. Used for budget tracking and cost analysis.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for dispatching commodities from warehouse to distribution point. Critical for logistics planning and cost allocation.. Valid values are `road|air|sea|rail|multimodal|hand_carry`',
    `vehicle_registration` STRING COMMENT 'Registration number or identifier of the vehicle used for transporting commodities. Used for fleet management and security tracking.',
    `waybill_reference` STRING COMMENT 'Reference number of the transport waybill or shipping document accompanying the commodity shipment. Used for tracking and proof of dispatch.',
    CONSTRAINT pk_distribution_order PRIMARY KEY(`distribution_order_id`)
) COMMENT 'Operational order authorizing the release and dispatch of commodities from a warehouse to a field distribution point for beneficiary delivery. Captures order number, originating distribution plan, issuing warehouse, destination distribution point, commodity lines with quantities, dispatch date, transport mode, waybill reference, loading officer, and order status (draft/approved/dispatched/delivered/closed). Triggers stock movement and last-mile logistics execution.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`supply`.`waybill` (
    `waybill_id` BIGINT COMMENT 'Unique identifier for the waybill shipping document. Primary key for the waybill entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding source that finances this shipment. Required for donor reporting and fund accounting.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Transport incidents (accidents, seal tampering, driver misconduct, cargo diversion) trigger compliance incident reports requiring investigation. Real business process: logistics incident management an',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Waybill is the shipping document for a shipment. In humanitarian logistics, waybills accompany both international shipments (sea/air freight) and domestic distribution movements. This FK links the way',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Waybill is the shipping document that accompanies commodity movements from warehouse to distribution point. Each waybill is issued for a specific distribution order. The distribution_order table has w',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian program or project that this shipment supports. Links commodities to program activities and beneficiaries.',
    `warehouse_id` BIGINT COMMENT 'Reference to the destination location (warehouse, distribution point, or project site) where commodities are being delivered.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Waybills often involve partner organizations as shippers or receivers in last-mile logistics. Tracks logistics responsibility, validates against partnership agreement transport obligations, supports a',
    `vendor_id` BIGINT COMMENT 'Reference to the transport company or carrier responsible for moving the commodities. Links to partner or vendor master data.',
    `actual_delivery_date` DATE COMMENT 'Actual date when commodities were delivered and received at destination. Used for performance measurement against estimated delivery date.',
    `arrival_timestamp` TIMESTAMP COMMENT 'Precise date and time when the vehicle arrived at the destination location. Used to calculate actual transit time and delivery performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this waybill record was first created in the system. Part of audit trail for data lineage and compliance.',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether customs clearance is required for this shipment (cross-border movements). True for international shipments.',
    `customs_declaration_number` STRING COMMENT 'Official customs declaration or clearance document number for cross-border shipments. Required for international humanitarian aid movements.',
    `departure_timestamp` TIMESTAMP COMMENT 'Precise date and time when the vehicle departed from the origin warehouse. Used for transit time analysis and security tracking.',
    `discrepancy_notes` STRING COMMENT 'Detailed explanation of any quantity discrepancies, damage, or quality issues identified upon receipt. Critical for loss investigation and donor reporting.',
    `discrepancy_quantity` DECIMAL(18,2) COMMENT 'Difference between total dispatched and total received quantities. Positive values indicate shortages, negative values indicate overages.',
    `dispatch_date` DATE COMMENT 'Date when the shipment was dispatched from the origin warehouse. Critical for lead time calculation and delivery performance tracking.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance in kilometers between origin and destination. Used for cost calculation and transit time estimation.',
    `driver_contact_number` STRING COMMENT 'Mobile phone number of the driver for real-time communication during transit. Essential for emergency contact and route coordination.',
    `driver_license_number` STRING COMMENT 'Official driver license number for verification and compliance purposes. Required for audit trails and security checks.',
    `driver_name` STRING COMMENT 'Full name of the driver responsible for transporting the commodities. Used for accountability and security verification.',
    `estimated_delivery_date` DATE COMMENT 'Planned or expected date of arrival at destination. Used for distribution planning and beneficiary communication.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling. True if hazardous materials present.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the cargo insurance policy covering this shipment. Required for claims processing in case of loss or damage.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether cargo insurance is required for this shipment. True for high-value or high-risk shipments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this waybill record was last updated. Tracks the most recent change for audit and synchronization purposes.',
    `number` STRING COMMENT 'Externally-known unique waybill document number used for tracking and reference by transporters, warehouses, and auditors. Typically follows organizational numbering convention.. Valid values are `^WB[0-9]{8,12}$`',
    `priority_level` STRING COMMENT 'Urgency classification for the shipment. Critical priority typically reserved for life-saving commodities in emergency response.. Valid values are `critical|high|medium|low`',
    `receipt_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a physical or digital signature was captured upon receipt. True if signature obtained, False otherwise.',
    `received_by_name` STRING COMMENT 'Full name of the person who received and signed for the shipment at destination. Critical for accountability and audit trail.',
    `received_by_title` STRING COMMENT 'Job title or role of the person who received the shipment. Provides context for authorization level and responsibility.',
    `remarks` STRING COMMENT 'General notes, special instructions, or additional context about the shipment. May include handling instructions, security concerns, or coordination notes.',
    `route_description` STRING COMMENT 'Description of the planned transport route including major waypoints, checkpoints, or transit hubs. Important for security planning in conflict zones.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the security seal was intact upon arrival at destination. True if intact, False if broken or tampered.',
    `seal_number` STRING COMMENT 'Unique security seal number applied to the shipment container or vehicle to prevent tampering. Critical for loss prevention and donor audit compliance.. Valid values are `^SEAL[0-9]{6,10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the waybill shipment. Tracks progression from dispatch through final receipt and reconciliation.. Valid values are `draft|dispatched|in_transit|arrived|received|cancelled`',
    `shipment_type` STRING COMMENT 'Classification of the shipment purpose. Distinguishes between emergency relief, routine program supplies, warehouse transfers, and returns.. Valid values are `emergency_relief|program_supply|inter_warehouse_transfer|return_shipment`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this shipment requires temperature-controlled transport (cold chain). True for medical supplies, vaccines, or perishable items.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments. Exceedance may compromise commodity efficacy.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments. Critical for cold chain compliance and commodity quality.',
    `total_dispatched_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all commodity items dispatched on this waybill. Sum of all line-item dispatched quantities.',
    `total_received_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all commodity items received at destination. Used to calculate overall shipment discrepancy.',
    `transport_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for transporting this shipment. Includes carrier fees, fuel surcharges, and handling charges.',
    `transport_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the transport cost amount. Essential for multi-currency operations and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `vehicle_registration` STRING COMMENT 'Official registration or license plate number of the vehicle used for transport. Critical for security tracking and incident investigation.. Valid values are `^[A-Z0-9-]{5,15}$`',
    CONSTRAINT pk_waybill PRIMARY KEY(`waybill_id`)
) COMMENT 'Transactional shipping document accompanying commodity movements between warehouses or to distribution points. Records waybill number, dispatch date, origin warehouse, destination location, transporter/carrier, vehicle registration, driver details, commodity lines with dispatched quantities, seal numbers, departure time, arrival time, received quantities, and discrepancy notes. Critical for last-mile accountability, loss tracking, and donor audit compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_waybill_id` FOREIGN KEY (`waybill_id`) REFERENCES `vibe_ngo_v1`.`supply`.`waybill`(`waybill_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_source_warehouse_id` FOREIGN KEY (`source_warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_ngo_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_status` SET TAGS ('dbx_business_glossary_term' = 'Commodity Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval|restricted');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `donor_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Restricted Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `donor_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Donor Restriction Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `donor_restriction_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Code (HS Code)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `in_kind_donation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Donation Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `kit_assembly_flag` SET TAGS ('dbx_business_glossary_term' = 'Kit or Assembly Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `kit_component_count` SET TAGS ('dbx_business_glossary_term' = 'Kit Component Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `commodity_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `sphere_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sphere (Humanitarian Charter and Minimum Standards) Compliant Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `standard_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `standard_unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_humidity_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity Maximum (Percent)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_humidity_max_percent` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum (Celsius)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum (Celsius)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Commodity Subcategory');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `volume_per_unit_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume per Unit (Cubic Meters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`commodity` ALTER COLUMN `weight_per_unit_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight per Unit (Kilograms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` SET TAGS ('dbx_subdomain' = 'inventory_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `admin_level_1` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `admin_level_2` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `cluster_affiliation` SET TAGS ('dbx_business_glossary_term' = 'OCHA (Office for the Coordination of Humanitarian Affairs) Cluster Affiliation');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `customs_bonded` SET TAGS ('dbx_business_glossary_term' = 'Customs Bonded Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `emergency_access_24_7` SET TAGS ('dbx_business_glossary_term' = '24/7 Emergency Access');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'central_warehouse|field_warehouse|transit_hub|pre_positioning_depot|cold_chain_facility|mobile_storage_unit');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `forklift_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Forklift Capacity (Kilograms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `gis_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GIS (Geographic Information System) Accuracy (Meters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `loading_docks_count` SET TAGS ('dbx_business_glossary_term' = 'Loading Docks Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `managing_entity` SET TAGS ('dbx_business_glossary_term' = 'Managing Entity Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `managing_entity` SET TAGS ('dbx_value_regex' = 'direct_operation|partner_managed|government_shared|consortium|third_party_logistics');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|under_construction|temporarily_closed|decommissioned|standby|emergency_activated');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|donated|government_provided|temporary_use');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'minimal|low|medium|high|maximum');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `storage_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Cubic Meters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `storage_capacity_m3` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `storage_capacity_pallets` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Pallets)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `storage_capacity_pallets` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Capability');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range (Celsius)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range (Celsius)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `wms_system_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ALTER COLUMN `wms_system_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `blacklist_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Effective Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `blacklist_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `blacklist_flag` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `blacklist_reason` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `commodity_categories` SET TAGS ('dbx_business_glossary_term' = 'Commodity Categories Supplied');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `country_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Country of Operation');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `fleet_size` SET TAGS ('dbx_business_glossary_term' = 'Fleet Size');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `gmp_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `humanitarian_network_membership` SET TAGS ('dbx_business_glossary_term' = 'Humanitarian Logistics Network Membership');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `iso_certification` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Certification');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `last_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Score');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Tier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'tier_1_preferred|tier_2_approved|tier_3_conditional|tier_4_probation');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `prequalification_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'prequalified|not_prequalified|pending_review|expired');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Registration Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `transport_modes_offered` SET TAGS ('dbx_business_glossary_term' = 'Transport Modes Offered');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `un_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Vendor Registration Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|blacklisted|pending_approval|debarred');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ALTER COLUMN `warehouse_capacity_sqm` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Capacity in Square Meters');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `award_budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Office Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Identifier');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_requested');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `emergency_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procurement Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `erp_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Reference');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight and Shipping Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partially_received|fully_received|over_received|discrepancy');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm (International Commercial Terms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `invoice_matching_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Matching Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `invoice_matching_status` SET TAGS ('dbx_value_regex' = 'not_matched|matched|variance|blocked');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|wire|check|letter_of_credit|mobile_money|cash');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Issue Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|emergency|framework');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'competitive_bidding|request_for_quotation|sole_source|framework_agreement|emergency_procurement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Warehouse ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Waybill Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_arrival` SET TAGS ('dbx_business_glossary_term' = 'Condition on Arrival');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_arrival` SET TAGS ('dbx_value_regex' = 'good|damaged|expired|partial_damage|quality_issue');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `customs_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `customs_cleared` SET TAGS ('dbx_business_glossary_term' = 'Customs Cleared Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Document Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `freight_charges` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_rejected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Rejected');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` SET TAGS ('dbx_subdomain' = 'inventory_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `inventory_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Balance ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `donor_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Restriction Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `in_kind_donation_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Donation Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inventory Balance Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `pipeline_status` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `pipeline_status` SET TAGS ('dbx_value_regex' = 'Available|Reserved|In Transit|Quarantined|Expired|Depleted');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available for Distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_quarantined` SET TAGS ('dbx_business_glossary_term' = 'Quantity Quarantined');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved for Distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `reorder_level` SET TAGS ('dbx_business_glossary_term' = 'Reorder Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Requirement');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'Ambient|Refrigerated|Frozen|Controlled|Hazardous');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `storage_condition` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `total_valuation` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Valuation');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `total_valuation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` SET TAGS ('dbx_subdomain' = 'inventory_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `authorizing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Officer Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `authorizing_officer_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `count_team_reference` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Team Reference');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `donor_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Restriction Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `donor_restriction_code` SET TAGS ('dbx_value_regex' = 'unrestricted|geographic_restricted|program_restricted|beneficiary_restricted|time_restricted');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Commodity Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `in_kind_donation_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Donation Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspector Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Movement Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Movement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived|not_required');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Description');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Movement Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Movement Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|air|sea|rail|pipeline|hand_carry');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` SET TAGS ('dbx_subdomain' = 'inventory_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Field Office ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Distribution End Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Distribution Start Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `beneficiary_category` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Category');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `beneficiary_category` SET TAGS ('dbx_value_regex' = 'idp|refugee|host_community|returnee|poc|vulnerable_population');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `coordination_cluster` SET TAGS ('dbx_business_glossary_term' = 'Coordination Cluster');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Distribution Duration (Days)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'one_time|weekly|biweekly|monthly|quarterly|as_needed');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_modality` SET TAGS ('dbx_business_glossary_term' = 'Distribution Modality');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_modality` SET TAGS ('dbx_value_regex' = 'direct|voucher|cash_in_kind|mobile_money|e_voucher|hybrid');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `distribution_type` SET TAGS ('dbx_value_regex' = 'emergency|routine|seasonal|one_time|recurring');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `estimated_total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Volume (Cubic Meters)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `estimated_total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Weight (Kilograms)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin1` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin1` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin2` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin2` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin3` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Administrative Level 3');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_admin3` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_country` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Country');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `geographic_coverage_country` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Distribution End Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Distribution Start Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'SDG (Sustainable Development Goal) Alignment');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ALTER COLUMN `target_household_count` SET TAGS ('dbx_business_glossary_term' = 'Target Household Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` SET TAGS ('dbx_subdomain' = 'inventory_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Warehouse Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `source_warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Distribution Point Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Order Approval Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `customs_reference` SET TAGS ('dbx_business_glossary_term' = 'Customs Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_order_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_order_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `distribution_type` SET TAGS ('dbx_value_regex' = 'general|targeted|emergency|seasonal|supplementary|blanket');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_contact` SET TAGS ('dbx_business_glossary_term' = 'Driver Contact Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `emergency_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `estimated_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `in_kind_donation_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Donation Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `medical_supplies_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Supplies Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `medical_supplies_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `medical_supplies_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `medical_supplies_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `nfi_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Food Item (NFI) Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^DO-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'emergency|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `total_commodity_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Commodity Lines');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (M3)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `transport_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Transport Cost in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|air|sea|rail|multimodal|hand_carry');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ALTER COLUMN `waybill_reference` SET TAGS ('dbx_business_glossary_term' = 'Waybill Reference Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` SET TAGS ('dbx_subdomain' = 'inventory_distribution');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Waybill Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Arrival Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Departure Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `discrepancy_quantity` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance in Kilometers (KM)');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Driver Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_contact_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_business_glossary_term' = 'Driver License Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Full Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Waybill Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^WB[0-9]{8,12}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `receipt_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Receipt Signature Captured Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `receipt_signature_captured_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_name` SET TAGS ('dbx_business_glossary_term' = 'Received By Name');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `received_by_title` SET TAGS ('dbx_business_glossary_term' = 'Received By Job Title');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Waybill Remarks');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `route_description` SET TAGS ('dbx_business_glossary_term' = 'Route Description');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Security Seal Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^SEAL[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'draft|dispatched|in_transit|arrived|received|cancelled');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'emergency_relief|program_supply|inter_warehouse_transfer|return_shipment');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `total_dispatched_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Dispatched Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `total_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Received Quantity');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `transport_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transport Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `transport_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Transport Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `transport_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `vibe_ngo_v1`.`supply`.`waybill` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,15}$');
